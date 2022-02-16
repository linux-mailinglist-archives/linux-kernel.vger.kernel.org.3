Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155354B87B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiBPMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:31:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiBPMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:31:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA522A4158
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:30:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8A06B81ED1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45B0C004E1;
        Wed, 16 Feb 2022 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645014653;
        bh=J15CuNm3A0QK/OXN1iTasUMydcAQaIOZ7OaemvLX5Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ne94s/gsaPiCMbv5DQwUscJhiVuAcM/KmFdZZf6WtG3VUgRdF0JWrZMS2+jufdoba
         Gn0uJDnN9cf1UQB2jtt1io5jbLaUpo3lNT+1DGI8uNyfhYxm4hMUV2OPsdeqgdht2q
         QG78Q8qNsEZsmJYnlUsMGG0CJt4olmcHhrNuq5wn2Aa/BLY8GalzcQT0Yrc0I7A0F2
         3NtN5OMOvO2u0AjsculrIq/1vcOkTEu4F4k+pjNl9MJ7irQv4EaBaW8j7itmxv6/xV
         /Djp1cnzGQluElrD+90N7+aYS2naxP0untcneobp53drfoPXyrdx93OjPBojMPm94C
         vjdXdGrbpUqvg==
Date:   Wed, 16 Feb 2022 12:30:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/hugetlb: Define __hugetlb_valid_size()
Message-ID: <20220216123048.GA9949@willie-the-truck>
References: <1644491770-16108-1-git-send-email-anshuman.khandual@arm.com>
 <20220215164851.GD8458@willie-the-truck>
 <e60802f2-dfb4-3824-9b85-7770c8fede96@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60802f2-dfb4-3824-9b85-7770c8fede96@arm.com>
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

On Wed, Feb 16, 2022 at 05:09:12AM +0530, Anshuman Khandual wrote:
> 
> 
> On 2/15/22 10:18 PM, Will Deacon wrote:
> > On Thu, Feb 10, 2022 at 04:46:10PM +0530, Anshuman Khandual wrote:
> >> arch_hugetlb_valid_size() can be just factored out to create another helper
> >> to be used in arch_hugetlb_migration_supported() as well. This just defines
> >> __hugetlb_valid_size() for that purpose.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> This applies on v5.17-rc3
> >>
> >> Changes in V2:
> >>
> >> - s/arm64_hugetlb_valid_size/__hugetlb_valid_size per Catalin
> >> - Restored back warning in arch_hugetlb_migration_supported() per Catalin
> >> - Updated the commit message subject line as required
> >>
> >> Changes in V1:
> >>
> >> https://lore.kernel.org/all/1644197468-26755-1-git-send-email-anshuman.khandual@arm.com/
> >>
> >>  arch/arm64/mm/hugetlbpage.c | 26 +++++++++++++-------------
> >>  1 file changed, 13 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> >> index ffb9c229610a..72ed07fe2c84 100644
> >> --- a/arch/arm64/mm/hugetlbpage.c
> >> +++ b/arch/arm64/mm/hugetlbpage.c
> >> @@ -56,24 +56,19 @@ void __init arm64_hugetlb_cma_reserve(void)
> >>  }
> >>  #endif /* CONFIG_CMA */
> >>  
> >> +static bool __hugetlb_valid_size(unsigned long size);
> > 
> > Why not reorder the code to avoid this forward declaration?
> 
> That will create more code churn, which I tried to avoid.

Isn't it just moving a handful of lines further up in the file? What's
the problem with that?

Will
