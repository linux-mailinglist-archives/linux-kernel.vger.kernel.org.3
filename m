Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A20658D38B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiHIGIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiHIGIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EBF175B8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 23:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9254D611CC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4000C433C1;
        Tue,  9 Aug 2022 06:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660025289;
        bh=LqLpwe8o9hPrLZHTBSjxV3vkB+wAIFFMG+7BQFOMnhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nUh3Wz47ADJSoHUpZwjPU7LC3QCNrtXX4cmMCxCCgUtpd/ffijF7St9fEvmXn/TR4
         Xgf4bXrIvYSZYxam+PP6WdP2VOol14291/Id7IGfZyE4naGHH2/FWeFAapM5mLHAR0
         eeKwR/qQ4Lmxfb/rm4fV9K8k10TUPDvWqdL7UWSU6oQjs4lzuz78N3yDid9z48h/Ec
         rPCRsgKGAitXZUbycae8A/PJd7x4PfvXOAx1bc5T3cQDQqrH1pQFigl0SP3cKMfxCP
         kwm0+qau8l8srjqJm7OHgh8p2MWP5e40G2f46rbCkUzv6xhdeTlaxsmfroNWgtCyL5
         HLibvlzK1lJ0w==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oLIPP-001q80-Lj;
        Tue, 09 Aug 2022 07:08:07 +0100
MIME-Version: 1.0
Date:   Tue, 09 Aug 2022 07:08:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        wanghaibin.wang@huawei.com, Shreyas K K <quic_shrekk@quicinc.com>
Subject: Re: [PATCH] arm64: Fix match_list for erratum 1286807 on Arm
 Cortex-A76
In-Reply-To: <20220809043848.969-1-yuzenghui@huawei.com>
References: <20220809043848.969-1-yuzenghui@huawei.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bbd76268ca1aa3badd32502cebb5c986@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, wanghaibin.wang@huawei.com, quic_shrekk@quicinc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-09 05:38, Zenghui Yu wrote:
> Since commit 51f559d66527 ("arm64: Enable repeat tlbi workaround on 
> KRYO4XX
> gold CPUs"), we failed to detect erratum 1286807 on Cortex-A76 because 
> its
> entry in arm64_repeat_tlbi_list[] was accidently corrupted by this 
> commit.
> 
> Fix this issue by creating a separate entry for Kryo4xx Gold.
> 
> Fixes: 51f559d66527 ("arm64: Enable repeat tlbi workaround on KRYO4XX
> gold CPUs")
> Cc: Shreyas K K <quic_shrekk@quicinc.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c 
> b/arch/arm64/kernel/cpu_errata.c
> index 7e6289e709fc..0f7e9087d900 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -208,6 +208,8 @@ static const struct arm64_cpu_capabilities
> arm64_repeat_tlbi_list[] = {
>  #ifdef CONFIG_ARM64_ERRATUM_1286807
>  	{
>  		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 0),
> +	},
> +	{
>  		/* Kryo4xx Gold (rcpe to rfpe) => (r0p0 to r3p0) */
>  		ERRATA_MIDR_RANGE(MIDR_QCOM_KRYO_4XX_GOLD, 0xc, 0xe, 0xf, 0xe),
>  	},

Ouch. It isn't the first time we end-up with this sort
of thing, and I wonder whether we should restructure
the ERRATA_MIDR_* macros to prevent this sort of
accidental override...

Anyway, thanks for spotting it!

Cc: stable@vger.kernel.org
Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
