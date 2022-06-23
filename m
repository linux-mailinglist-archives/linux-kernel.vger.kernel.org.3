Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F82558777
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiFWS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiFWS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:26:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295C95BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69920B824BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE5AC3411B;
        Thu, 23 Jun 2022 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656005256;
        bh=cjA2+/VfwtnJLx2FsxboduQ0YIyLP7BYCHUqenv0DAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdzYhdL6gkVCqD2yTCLB5gNKvSf7GtCZ/uQjF5mj1ZrsfjX7fOMgLidoj2c9Nymer
         bbQZWVclh7RawXhdisVV2rAs+Jk45BRtIfDi7hacQnk8c9mvXHhJRKv4x/ZCgR6VV+
         oXA1oyCBchGS5UBYeexD6pD00cY0XxPFhwbBusj0VggOhiH66WD2or0sYbKrgvQwSp
         CPKHdODSIGrY6vfLyOpQhyhKYjEQ8iw/K7Dmc7GnuEtmSGIenxAPy0PJCQ+CkAB2pI
         ayVd7Ew+8D/PN1FDeHGN2zrPoUk/5XVBwGnO3OPqd1uXGftuqZlfwSUpOQZ50EEJWz
         6rMkUX0po+zig==
Date:   Thu, 23 Jun 2022 18:27:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cpufeature: make sure cpu_mitigations_off then
 kpti off
Message-ID: <20220623172730.GA16966@willie-the-truck>
References: <1655382938-126283-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655382938-126283-1-git-send-email-liusong@linux.alibaba.com>
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

On Thu, Jun 16, 2022 at 08:35:38PM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> If kaslr is enabled, kpti cannot be turned off even if "mitigations=off",
> adjust the code order to ensure that kpti is off when "mitigations=off".
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 42ea2bd..27d4850 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1616,6 +1616,11 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  		__kpti_forced = -1;
>  	}
>  
> +	if (cpu_mitigations_off() && !__kpti_forced) {
> +		str = "mitigations=off";
> +		__kpti_forced = -1;
> +	}
> +
>  	/* Useful for KASLR robustness */
>  	if (kaslr_requires_kpti()) {
>  		if (!__kpti_forced) {
> @@ -1624,11 +1629,6 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  		}
>  	}
>  
> -	if (cpu_mitigations_off() && !__kpti_forced) {
> -		str = "mitigations=off";
> -		__kpti_forced = -1;
> -	}

The current behaviour is intentional: KASLR is trivial to bypass when kpti
is disabled.

Will
