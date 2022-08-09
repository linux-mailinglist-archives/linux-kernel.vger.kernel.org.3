Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB15858D591
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiHIImH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240409AbiHIImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B421E3B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47025612DA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F6DC433C1;
        Tue,  9 Aug 2022 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660034522;
        bh=tZ+wNzzLw6xNoTueASilmuzMxk2HqBkJZKa2hJ1gQdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJwnjmVh9Bj0q9dAB2ExLtX768RfNDZnX8CppEJZ1grULw+kCr+3z1QCo9wmpF+WS
         zbuOx5fOUXxbroBVnBMh8gjJt+KoIZVgJiNDW0hWwCuTFPj5TSFz+ah3M+VpK2YS1Y
         wN7I7zQjjyHYOwFVNj7LWc/rC7ylsBGzlCMcX38Wx93bF5Gy5ciyypo493TvztMB73
         kKIFHwRNw83U2tjIEs7C+UZtlHSBaMZxpkFbYpCUlejNDaoRK4LwYAtIvz17dOtrSw
         cZFuCJz6EeVgzrol1znc64uWb4LhHLyC5amF7I9+26Msgh9+8N97cbgPK97bTKQXuD
         is+r2p64XnXow==
Date:   Tue, 9 Aug 2022 09:41:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, wanghaibin.wang@huawei.com,
        Shreyas K K <quic_shrekk@quicinc.com>
Subject: Re: [PATCH] arm64: Fix match_list for erratum 1286807 on Arm
 Cortex-A76
Message-ID: <20220809084157.GB776@willie-the-truck>
References: <20220809043848.969-1-yuzenghui@huawei.com>
 <bbd76268ca1aa3badd32502cebb5c986@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd76268ca1aa3badd32502cebb5c986@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 07:08:07AM +0100, Marc Zyngier wrote:
> On 2022-08-09 05:38, Zenghui Yu wrote:
> > Since commit 51f559d66527 ("arm64: Enable repeat tlbi workaround on
> > KRYO4XX
> > gold CPUs"), we failed to detect erratum 1286807 on Cortex-A76 because
> > its
> > entry in arm64_repeat_tlbi_list[] was accidently corrupted by this
> > commit.
> > 
> > Fix this issue by creating a separate entry for Kryo4xx Gold.
> > 
> > Fixes: 51f559d66527 ("arm64: Enable repeat tlbi workaround on KRYO4XX
> > gold CPUs")
> > Cc: Shreyas K K <quic_shrekk@quicinc.com>
> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > ---
> >  arch/arm64/kernel/cpu_errata.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/cpu_errata.c
> > b/arch/arm64/kernel/cpu_errata.c
> > index 7e6289e709fc..0f7e9087d900 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -208,6 +208,8 @@ static const struct arm64_cpu_capabilities
> > arm64_repeat_tlbi_list[] = {
> >  #ifdef CONFIG_ARM64_ERRATUM_1286807
> >  	{
> >  		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 0),
> > +	},
> > +	{
> >  		/* Kryo4xx Gold (rcpe to rfpe) => (r0p0 to r3p0) */
> >  		ERRATA_MIDR_RANGE(MIDR_QCOM_KRYO_4XX_GOLD, 0xc, 0xe, 0xf, 0xe),
> >  	},
> 
> Ouch. It isn't the first time we end-up with this sort
> of thing, and I wonder whether we should restructure
> the ERRATA_MIDR_* macros to prevent this sort of
> accidental override...

Agreed. I think we may have gone a bit too far with the macros in
cpu_errata.c and cpufeature.c. Although the files would be larger, I think
it would be clearer if we removed some of the abstractions and forced this
stuff to be spelled out each time.

> Anyway, thanks for spotting it!
> 
> Cc: stable@vger.kernel.org
> Acked-by: Marc Zyngier <maz@kernel.org>

I'll queue this as a fix at -rc1 along with any other fixes which come in.

Will
