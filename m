Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96498515431
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbiD2TJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbiD2TJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D50A1457
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3C5624B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 19:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229CCC385A4;
        Fri, 29 Apr 2022 19:06:16 +0000 (UTC)
Date:   Fri, 29 Apr 2022 20:06:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linu Cherian <lcherian@marvell.com>
Cc:     maz@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuc.decode@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64: Declare non global symbols as static
Message-ID: <Ymw3JY5m1R0W8/l5@arm.com>
References: <20220429075535.10636-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429075535.10636-1-lcherian@marvell.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:25:35PM +0530, Linu Cherian wrote:
> Fix below sparse warnings introduced while adding errata.
> 
> arch/arm64/kernel/cpu_errata.c:218:25: sparse: warning: symbol
> 'cavium_erratum_23154_cpus' was not declared. Should it be static?
> arch/arm64/kernel/cpu_errata.c:233:25: sparse: warning: symbol
> 'cavium_erratum_27456_cpus' was not declared. Should it be static?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 4c9b5b4b7a0b..57a39cb6b489 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -215,7 +215,7 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
>  #endif
>  
>  #ifdef CONFIG_CAVIUM_ERRATUM_23154
> -const struct midr_range cavium_erratum_23154_cpus[] = {
> +static const struct midr_range cavium_erratum_23154_cpus[] = {
>  	MIDR_ALL_VERSIONS(MIDR_THUNDERX),
>  	MIDR_ALL_VERSIONS(MIDR_THUNDERX_81XX),
>  	MIDR_ALL_VERSIONS(MIDR_THUNDERX_83XX),
> @@ -230,7 +230,7 @@ const struct midr_range cavium_erratum_23154_cpus[] = {
>  #endif
>  
>  #ifdef CONFIG_CAVIUM_ERRATUM_27456
> -const struct midr_range cavium_erratum_27456_cpus[] = {
> +static const struct midr_range cavium_erratum_27456_cpus[] = {
>  	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
>  	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
>  	/* Cavium ThunderX, T81 pass 1.0 */

That's referred in arch/arm64/kernel/cpufeature.c, so the build fails.

-- 
Catalin
