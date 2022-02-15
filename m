Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A973D4B7702
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiBOS2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:28:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbiBOS2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:28:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D97E03B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 945DAB8164A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F1AC340EB;
        Tue, 15 Feb 2022 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644949704;
        bh=L60HeiekO++0XPvkBfLyZbFV+rY4TRb6oJsd1nSRUmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYPoCcaoxwUtyhfN2ANlISCVRuDw+rQO7r0Yjc2tf/ZmCn1NzR6BGCwelr6Qdc+Hd
         Lcvo5H2wuEJ6MinMtn9XhNrG+WoRJ+PBHfHfjuZdBKc6MJ9rNfRa91TBS1bK0ZA5tK
         lmxttZ/C0w3pe5xilsBf73arufx895Dazg4KqWel7jmsAT26uoiiQJ7PYJnNJZYT+k
         RcaMoT/cSwrYqrEwymIgNBcb3CHcAlkWLSyZshJKRAfuUK3/PxENNd91A9/yxL9bGD
         2m5RYbEHU17e2D5vS5fmgBltDDJQzB1IHuG4UqKaFW8M9OCSc9YexyP63LKIVTUjUj
         rGZ6dhv4jtjbw==
Date:   Tue, 15 Feb 2022 18:28:19 +0000
From:   Will Deacon <will@kernel.org>
To:     cgel.zte@gmail.com
Cc:     catalin.marinas@arm.com, pasha.tatashin@soleen.com,
        si.hao@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com
Subject: Re: [PATCH linux-next] arm64: kexec: Support the case of VA_BITS=39
 in trans_pgd_idmap_page()
Message-ID: <20220215182818.GA9026@willie-the-truck>
References: <20220121065216.1001021-1-si.hao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121065216.1001021-1-si.hao@zte.com.cn>
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

On Fri, Jan 21, 2022 at 06:52:16AM +0000, cgel.zte@gmail.com wrote:
> From: sihao <si.hao@zte.com.cn>
> 
> When the values of CONFIG_ARM64_VA_BITS and CONFIG_ARM64_PA_BITS are not
> equal, the following panic occurs when kexec is executed.
> 
> This happens because trans_pgd_idmap_page() does not support VA_BITS=39.
> So the patch supports the case of VA_BITS=39.

--->8

> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> index d7da8ca40d2e..3d88185adcf5 100644
> --- a/arch/arm64/mm/trans_pgd.c
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -232,7 +232,7 @@ int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
>  {
>  	phys_addr_t dst_addr = virt_to_phys(page);
>  	unsigned long pfn = __phys_to_pfn(dst_addr);
> -	int max_msb = (dst_addr & GENMASK(52, 48)) ? 51 : 47;
> +	int max_msb = (dst_addr & GENMASK(52, VA_BITS)) ? 51 : (VA_BITS - 1);
>  	int bits_mapped = PAGE_SHIFT - 4;
>  	unsigned long level_mask, prev_level_entry, *levels[4];
>  	int this_level, index, level_lsb, level_msb;

Do you plan to respin this based on Catalin's comments?

Will
