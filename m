Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD3512E45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbiD1IbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344138AbiD1Iau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:30:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CBA0BD1;
        Thu, 28 Apr 2022 01:27:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 893EE2186F;
        Thu, 28 Apr 2022 08:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651134453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIozUSFdjDnLnEJpNn98rpE1d2R0anAtFMrgIZeUiR4=;
        b=kk0y2HUNWPQ6yurCu47RXpWICv/UYYHPEiBz2vwYJUQU92TGjP6YsUB3QW/6bksx3k5t/F
        F/My4Vm3K9vGazCfRQnqYqYdnsZXWxKy4/0UkrWqH/AOJ7+7WlUXGP+sLpj9pHauw349c/
        +8XoiuZlexn/SXMwfGzlxoxmq0EliWI=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D7C5B2C141;
        Thu, 28 Apr 2022 08:27:32 +0000 (UTC)
Date:   Thu, 28 Apr 2022 10:27:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        davem@davemloft.net, jolsa@redhat.com, jthierry@redhat.com,
        keescook@chromium.org, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, matthias.bgg@gmail.com, maz@kernel.org,
        mcgrof@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        nixiaoming@huawei.com, peterz@infradead.org,
        sparclinux@vger.kernel.org, sumit.garg@linaro.org,
        wangqing@vivo.com, will@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v3 5/5] arm64: Enable perf events based hard lockup
 detector
Message-ID: <YmpP9PTa1/pSmuuQ@alley>
References: <20220421163035.26402-1-lecopzer.chen@mediatek.com>
 <20220426163840.18871-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426163840.18871-1-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-27 00:38:40, Lecopzer Chen wrote:
> > What about just introducing the API that will allow to try to
> > initialize the hardlockup detector later:
> > 
> > /*
> >  * Retry hardlockup detector init. It is useful when it requires some
> >  * functionality that has to be initialized later on a particular
> >  * platform.
> >  */
> > void __init retry_lockup_detector_init(void)
> > {
> > 	/* Must be called before late init calls. */
> > 	if (!allow_lockup_detector_init_retry)
> > 		return 0;
> > 
> > 	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> > }
> > 
> > /*
> >  * Ensure that optional delayed hardlockup init is proceed before
> >  * the init code and memory is freed.
> >  */
> > static int __init lockup_detector_check(void)
> > {
> > 	/* Prevent any later retry. */
> > 	allow_lockup_detector_init_retry = false;
> > 
> > 	/* Make sure no work is pending. */
> > 	flush_work(&detector_work);
> > }
> > late_initcall_sync(lockup_detector_check);
> > 
> > You could leave lockup_detector_init() as it is. It does not really
> > matter what was the exact error value returned by watchdog_nmi_probe().
> > 
> > Then you could call retry_lockup_detector_init() in
> > armv8_pmu_driver_init() and be done with it.
> > 
> > It will be universal API that might be used on any architecture
> > for any reason. If nobody calls retry_lockup_detector_init()
> > then nohing will happen and the code will work as before.
> > 
> > It might make sense to provide the API only on architectures that
> > really need it. We could hide it under
> > 
> >    ARCH_NEED_DELAYED_HARDLOCKUP_DETECTOR_INIT
> > 
> > , similar to ARCH_NEEDS_CPU_IDLE_COUPLE.
> > 
> 
> During implementation, if I add ARCH_NEED_DELAYED_..., there will contain
> many enclosed ifdef-endif and is a little bit ugly.
> Also, I didn't find a must-have reason to this Kconfig after I rebase from
> your suggestion.
> 
> The one calls retry_lockup_detector_init() must fail at lockup_detector_init,
> so I think anyone who has aleady failed at lockup_detector_init() has right
> to retry no matter HW, SW or Arch reason.
> Thus I might not introduce a new Kconfig in v4, and I would be glad to see
> if any further commet on this.

Sounds reasonable from my POV. There is not much code. It will be removed
after the init phase. It will be most likely removed even during
compilation when linked with gcc LTE optimization and the symbols
are not used.

Best Regards,
Petr

PS: It might take few days until I do the review of v4. I am a bit
    overloaded at the moment.
