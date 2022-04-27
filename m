Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440055111CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358482AbiD0G7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358487AbiD0G7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:59:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8116582
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:56:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651042583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mvz2KPryvvuLCMabiS6LY9UMdp1w23qAUiaDds4YLLM=;
        b=Dk7BumDojuYclU6e6KTwp6UcD5rlSTWOiqerBToF6poJ32WwhZ8AOGs2ffhL86jrLiF7Zt
        uauDVYuCq/8OmbDia96O23K3A4G0z2yKlvlWzzTX4m84qwnbi9mSU6ny3/XOKRfdsHFzm/
        Vcm2uL/xzxv7+dEOjKeIQQiQd61dVRBo239mKb9uvqG36t3qQTIJ0+Bc4RMUAsutu7IL6U
        HUQaIFzy6d1A98wVmTX/epUu4Z0/0/AO2pO2jCEyRDFYKc8/J9juodXuM2XDI4RtAGIEzV
        HBdovH0iTkFZlxNVdZJZMn5JcqS+DNyzDescIk5VZtBK/eMM7CB4O/CJUIic0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651042583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mvz2KPryvvuLCMabiS6LY9UMdp1w23qAUiaDds4YLLM=;
        b=hb3fmOXQpiBd4nb/9A4WyogxV0RYSlTKPx7j9Gx3+vaZR6WbXXQ1xJHGNNnueb/ivyDnzK
        qoMQXMT2ru2CwOBw==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch v12 05/13] task isolation: sync vmstats on return to
 userspace
In-Reply-To: <20220315153313.952151848@fedora.localdomain>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153313.952151848@fedora.localdomain>
Date:   Wed, 27 Apr 2022 08:56:23 +0200
Message-ID: <87czh3ypyg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
> --- linux-2.6.orig/kernel/entry/common.c
> +++ linux-2.6/kernel/entry/common.c
>  
> @@ -174,6 +175,9 @@ static unsigned long exit_to_user_mode_l
>  		if (ti_work & _TIF_NOTIFY_RESUME)
>  			tracehook_notify_resume(regs);
>  
> +		if (ti_work & _TIF_TASK_ISOL)
> +			task_isol_exit_to_user_mode();
> +
>  		/* Architecture specific TIF work */
>  		arch_exit_to_user_mode_work(regs, ti_work);

> --- linux-2.6.orig/include/linux/entry-common.h
> +++ linux-2.6/include/linux/entry-common.h
> @@ -60,7 +60,7 @@
>  #define EXIT_TO_USER_MODE_WORK						\
>  	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
>  	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
> -	 ARCH_EXIT_TO_USER_MODE_WORK)
> +	 _TIF_TASK_ISOL | ARCH_EXIT_TO_USER_MODE_WORK)

How is this supposed to compile when _TIF_TASK_ISOL is not defined by an
architecture?

Hint: Search for _TIF_PATCH_PENDING in the very same header file.

Thanks,

        tglx

