Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0A4C5507
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 10:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiBZJzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 04:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBZJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 04:55:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5EDF542B;
        Sat, 26 Feb 2022 01:55:00 -0800 (PST)
X-UUID: 12beb10077d04d32a5264b4067461e53-20220226
X-UUID: 12beb10077d04d32a5264b4067461e53-20220226
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1253442640; Sat, 26 Feb 2022 17:54:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 26 Feb 2022 17:54:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Feb 2022 17:54:52 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <pmladek@suse.com>
CC:     <acme@kernel.org>, <akpm@linux-foundation.org>,
        <alexander.shishkin@linux.intel.com>, <catalin.marinas@arm.com>,
        <davem@davemloft.net>, <jolsa@redhat.com>, <jthierry@redhat.com>,
        <keescook@chromium.org>, <kernelfans@gmail.com>,
        <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>, <maz@kernel.org>,
        <mcgrof@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <sparclinux@vger.kernel.org>, <sumit.garg@linaro.org>,
        <wangqing@vivo.com>, <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH 2/5] kernel/watchdog: change watchdog_nmi_enable() to void
Date:   Sat, 26 Feb 2022 17:54:52 +0800
Message-ID: <20220226095452.16924-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YhjQnMZahzu1w2lj@alley>
References: <YhjQnMZahzu1w2lj@alley>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat 2022-02-12 18:43:46, Lecopzer Chen wrote:
> > 
> > Nobody cares about the return value of watchdog_nmi_enable(),
> > changing its prototype to void.
> > 
> > --- a/arch/sparc/kernel/nmi.c
> > +++ b/arch/sparc/kernel/nmi.c
> > @@ -282,11 +282,11 @@ __setup("nmi_watchdog=", setup_nmi_watchdog);
> >   * sparc specific NMI watchdog enable function.
> >   * Enables watchdog if it is not enabled already.
> >   */
> > -int watchdog_nmi_enable(unsigned int cpu)
> > +void watchdog_nmi_enable(unsigned int cpu)
> >  {
> >  	if (atomic_read(&nmi_active) == -1) {
> >  		pr_warn("NMI watchdog cannot be enabled or disabled\n");
> > -		return -1;
> > +		return;
> >  	}
> >  
> >  	/*
> > @@ -295,11 +295,11 @@ int watchdog_nmi_enable(unsigned int cpu)
> >  	 * process first.
> >  	 */
> >  	if (!nmi_init_done)
> > -		return 0;
> > +		return;
> >  
> >  	smp_call_function_single(cpu, start_nmi_watchdog, NULL, 1);
> >  
> > -	return 0;
> > +	return;
> 
> Return at the end of the function is superfluous.

Thanks, I'll fix in the next patch.

> 
> >  }
> >  /*
> >   * sparc specific NMI watchdog disable function.
> 
> Otherwise, it looks good.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
