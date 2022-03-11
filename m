Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B094D6150
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348548AbiCKMNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348322AbiCKMNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:13:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A618617927F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:12:18 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 208C91F38D;
        Fri, 11 Mar 2022 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647000737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAIY4yuVMOLPaV3LWpBMeDIEu3zQzohlPZVsreJow7E=;
        b=W7Y3UDk2g3Tesn+BOr/Tm78BANNrnR/uDoYHV6fW2Mb41YdRLn3Iv5GD/Nf49ANfoPm3w7
        RCIRwIy0knPmCnnt72jhNdmfaeY3Jj+QhjOjhpgspqpNynH8G7CwOcDba00QUtLHpNryYJ
        Z8hdaG1b7/iNHlpQkRbzAx5Sce0DI24=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E2847A3B97;
        Fri, 11 Mar 2022 12:12:16 +0000 (UTC)
Date:   Fri, 11 Mar 2022 13:12:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: Make it clear that create_kthread() might be
 terminated by any fatal signal
Message-ID: <Yis8oPagDlPNQM0y@alley>
References: <20220310093455.15176-1-pmladek@suse.com>
 <871qz9brp7.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qz9brp7.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-03-10 12:14:28, Eric W. Biederman wrote:
> Petr Mladek <pmladek@suse.com> writes:
> 
> > The comments in kernel/kthread.c create a feeling that only SIGKILL
> > is able to break create_kthread().
>                    ^^^^^^^^^^^^^^^^ __kthread_create_on_node
> 
> Signals can't affect create_kthread in any was as it is only called by
> kthreadd.  It is __kthread_create_on_node which gets interrupted by
> fatal signals.

Great catch! I wanted to use the public API. I missed that
create_kthread() is used by the "kthreadd" side.

Heh, there actually is "kthread_create()" macro that substitutes
kthread_create_on_node().


> > In reality, wait_for_completion_killable() might be killed by any
> > fatal signal that does not have a custom handler:
> >
> > Update the comments in kernel/kthread.c to make this more obvious.
> 
> Except for the minor nit in the change description.
> Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks.

I am going to send v2 next week to give time more potential
reviewers.

Best Regards,
Petr
