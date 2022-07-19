Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBD57A61F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiGSSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiGSSKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:10:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2401625C3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEC86B81CB8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5154DC341C6;
        Tue, 19 Jul 2022 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658254204;
        bh=cmRMdfnK3eg1c4qOOLtsspjkB4OOh1S9fEMyzJi09h8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGsA3B1U4DU9meEMfdydgC8ynm8DIyAR6dhWs8qU1zsAHbNemoC8syT3lvitpqM5d
         KeGqSCKCsdz1eABV3oYbNhiqkQ4c8vo+2e338mATDSp4tyWdhlh+xypXos51KgOk9u
         XVWZpXpmwJlVkUSC5J8HaP5i/HzCQTRB6RHxuNig/4Tc0zz24YuHiSeECDrnos7b98
         i16olnm1pwVkm43eXsYFvv4hFHUq/klDs0gyTFa5DwsJX7ujZyCfsyoSVCVe77KCI2
         dtf8mt5TDVJbAnx3DjXBSVVymzLFboG9zwy6IrIYnrOmjYloTJ720dTaXWJolmkR2i
         gWsG076rFWY0w==
Date:   Tue, 19 Jul 2022 19:09:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, shan.gavin@gmail.com
Subject: Re: [PATCH] arm64: numa: Don't check node against MAX_NUMNODES
Message-ID: <20220719180959.GB14526@willie-the-truck>
References: <20220718064232.3464373-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718064232.3464373-1-gshan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 02:42:32PM +0800, Gavin Shan wrote:
> When the NUMA nodes are sorted by checking ACPI SRAT (GICC AFFINITY)
> sub-table, it's impossible for acpi_map_pxm_to_node() to return
> any value, which is greater than or equal to MAX_NUMNODES. Lets drop
> the unnecessary check in acpi_numa_gicc_affinity_init().
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kernel/acpi_numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index fdfecf0991ce..e51535a5f939 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -109,7 +109,7 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
>  	pxm = pa->proximity_domain;
>  	node = acpi_map_pxm_to_node(pxm);
>  
> -	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
> +	if (node == NUMA_NO_NODE) {
>  		pr_err("SRAT: Too many proximity domains %d\n", pxm);
>  		bad_srat();
>  		return;

This isn't "obviously" correct, but it does look like the way in which
acpi_map_pxm_to_node() allocates nodes in 'nodes_found_map' means that this
check is redundant, so I'll pick it up.

Will
