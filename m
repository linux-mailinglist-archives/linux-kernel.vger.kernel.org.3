Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB344B76F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbiBOQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:49:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbiBOQtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:49:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1CE101F0E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:48:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D3D60F51
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5929C340EB;
        Tue, 15 Feb 2022 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644943735;
        bh=2ryad9yaGExISvwWmN9OK6ZZTJh9aiOukYGy/j7e0Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYKvINz3Yde08Cd0NdBqPg1qsmwkpAcULEGGvs1tihvkIS/7C0cWoGM2+6cOdnTk2
         Rz1o9sQ+sm1kpz5+rhSyxq/LQ2ULRTtJHxp7XhqCzlIORFANviRIqBfqTJ+piOL6Cl
         X9JGMt0lUxYXE0hdCjVU6dwgRcLM5XaBwo7CKA71lfeatTbx3mcuh5GN+dbptkpwDi
         3JVjQsqb/XYu4t6XShKR2c3tUyPhF/B4a+/gCzv5UzrL91AQQUQzESyeTevjeZg7eE
         7VRZ4sCadRTPCSnSFnc1ElcNh2J/qQlk0XY5Sal3mzzMbRClHCiAg77PqCSyldv1fS
         2gppO/AgDaThg==
Date:   Tue, 15 Feb 2022 16:48:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/hugetlb: Define __hugetlb_valid_size()
Message-ID: <20220215164851.GD8458@willie-the-truck>
References: <1644491770-16108-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644491770-16108-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 04:46:10PM +0530, Anshuman Khandual wrote:
> arch_hugetlb_valid_size() can be just factored out to create another helper
> to be used in arch_hugetlb_migration_supported() as well. This just defines
> __hugetlb_valid_size() for that purpose.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.17-rc3
> 
> Changes in V2:
> 
> - s/arm64_hugetlb_valid_size/__hugetlb_valid_size per Catalin
> - Restored back warning in arch_hugetlb_migration_supported() per Catalin
> - Updated the commit message subject line as required
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/1644197468-26755-1-git-send-email-anshuman.khandual@arm.com/
> 
>  arch/arm64/mm/hugetlbpage.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index ffb9c229610a..72ed07fe2c84 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -56,24 +56,19 @@ void __init arm64_hugetlb_cma_reserve(void)
>  }
>  #endif /* CONFIG_CMA */
>  
> +static bool __hugetlb_valid_size(unsigned long size);

Why not reorder the code to avoid this forward declaration?

Will
