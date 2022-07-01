Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15075635E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGAOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGAOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A519289
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31444622B4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 14:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF03C3411E;
        Fri,  1 Jul 2022 14:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656686047;
        bh=Fh2Yx93xB3C+S/wXYC4C1fagIRcAr8t3LoCK9meJw6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlTpod6kmJ8Vu+1s2M+gHRiphuzguWZM2ld9fH1qN7NS79nWrdmbv+BUjm6//ODgJ
         LCPmIY9CnRUFe85yAL7RzvXogOD4sxyvoXTFJZkN3az/aTX0nelgkmmEXrG1O00bzD
         UcXu4alq2933ycz+RuPskq5jjKS8FS2wbCKi94NOPjDNRY6lmHObra2LjYFtFDs8md
         lXhQo8hrv7e2ipOQzBwQibtaUIA+pZoKKX7EN7sc6BEdn2t3goh+FmJeAltt/D1J94
         ccC4by786WslgGhWcZLrjLxzTiteIWQCdPuseEhfupAgxheRXluKb6m2aBlvka5IhG
         p+d/D/j76b/sA==
Date:   Fri, 1 Jul 2022 15:34:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Xenia Ragiadakou <burzalodowa@gmail.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix undefined behavior in GBPA_UPDATE
Message-ID: <20220701143401.GA28408@willie-the-truck>
References: <20220630063959.27226-1-burzalodowa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630063959.27226-1-burzalodowa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:39:59AM +0300, Xenia Ragiadakou wrote:
> The expression 1 << 31 results in undefined behaviour because the type of
> integer constant 1 is (signed) int and the result of shifting 1 by 31 bits
> is not representable in the (signed) int type.
> 
> Change the type of 1 to unsigned int by adding the U suffix.
> 
> Signed-off-by: Xenia Ragiadakou <burzalodowa@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index cd48590ada30..44fbd499edea 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -96,7 +96,7 @@
>  #define CR2_E2H				(1 << 0)
>  
>  #define ARM_SMMU_GBPA			0x44
> -#define GBPA_UPDATE			(1 << 31)
> +#define GBPA_UPDATE			(1U << 31)

There are loads of these kicking around in the kernel sources and we compile
with -fno-strict-overflow.

If you really want to change these, then let's use the BIT() macro instead,
but I think it's really just churn.

Will
