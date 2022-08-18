Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F25597B64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbiHRCOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiHRCOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:14:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBEC59245
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C1C2B82003
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76BFC433D7;
        Thu, 18 Aug 2022 02:14:12 +0000 (UTC)
Date:   Wed, 17 Aug 2022 22:14:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Fix NULL pointer dereference in
 is_ftrace_trampoline when ftrace is dead
Message-ID: <20220817221422.295db316@gandalf.local.home>
In-Reply-To: <dcbc9c43-486d-e045-1e35-4226233981ea@huawei.com>
References: <20220804021610.209791-1-yangjihong1@huawei.com>
        <20220817104115.0ec6b90b@gandalf.local.home>
        <dcbc9c43-486d-e045-1e35-4226233981ea@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 09:50:40 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> Thanks for the detailed explanation.
> If panic_on_warn is not set, FTRACE_WARN_ON{_ONCE} only sets 
> ftrace_disabled, but will not reboot.

Correct. But whenever there's a WARN_ON() the administrator of the machine
should think about rebooting it ASAP. That's because all WARN_ON()s are
suppose to only happen when the system does something that was not
expected, putting it into an inconsistent state. And could be a dangerous
one. This is why all WARN_ON()s that are triggered are considered bugs and
must be fixed.


> I think this is to limit the problem to ftrace itself and not spread to 
> other subsystems(I don't know if that's right. If it's not right, please 
> correct it).

Yes, the ftrace_disable means that ftrace just found itself in a situation
that it does not understand, and nothing can be trusted. As ftrace modifies
kernel code, it basically stops everything and WARNs about it. Because
anything else it does can make things worse.

> Because is_ftrace_trampoline is a common and public interface  (This 
> interface is called in many places in the kernel).
> If is_ftrace_trampoline interface is not restricted (for example, just 
> return true if ftrace_disabled is set), the preceding Syzkaller scenario 
> may be triggered when this interface is called.

If ftrace_disabled is set, then any operations should fail, and any tests
should fail with it.

> 
> Therefore, my idea is to restrict the is_ftrace_trampoline or roll back 
>   _unregister_ftrace_function when ftrace_disabled is set, so that the 
> interface can be invoked normally. Or keep the current code and do not 
> modify.

Once ftrace_disabled is set, none of its interfaces should perform
normally.

But you reported that you could hit a NULL pointer from the
is_ftrace_trampoline() which was caused by the failure adding the dynamic
trampoline, and then the ops is on the list but later freed.

My suggestion above is to just call _unregister_ftrace_function(ops) to
take it off the list and prevent the NULL pointer.

Doesn't that fix the bug?

I don't want to totally roll it back and free the trampoline, because those
actions could cause further damage, depending on the failed state ftrace is
in.

-- Steve
