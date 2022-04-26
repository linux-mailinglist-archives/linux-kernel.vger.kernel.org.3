Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D455101F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352352AbiDZPec convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Apr 2022 11:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiDZPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:34:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3E11AF32
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92F30B820D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EFEC385A0;
        Tue, 26 Apr 2022 15:31:15 +0000 (UTC)
Date:   Tue, 26 Apr 2022 11:31:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <jolsa@redhat.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Reset the function filter after completing
 trampoline/graph selftest
Message-ID: <20220426113114.2005b94f@gandalf.local.home>
In-Reply-To: <ee4bc477-0131-367b-9a1f-c2cb5af5c316@huawei.com>
References: <20220418073958.104029-1-lihuafei1@huawei.com>
        <20220425185859.29e8f9d8@gandalf.local.home>
        <ee4bc477-0131-367b-9a1f-c2cb5af5c316@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 16:00:35 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> > No need for all the 'goto reset_filter', if this function fails, then the
> > tracer is disabled, and there's no reason to clear the filter. In fact, it  
> Thank you for the review. I see that we will disable function_graph tracer:
> 
>       /* Stop it if we failed */
>       if (ret)
>             ftrace_graph_stop();
> 
> But there is no function tracer disabled. Am I missing something that 
> would disable the function tracer?

No, but if we are triggering these, then something really bad has happened,
and function tracer is possibly corrupted too, or should not be trusted.

> 
> 
> > may cause a crash (because something bad happened).  
> 
> Yes, so should we kill ftrace when the function_graph test fails?

No, but the system should be fixed. These should never trigger on any
production system, because it means something really bad is happening and
we do not know what.

Not resetting the filters may even be useful in debugging it. So that's
another reason to not do so.

-- Steve
