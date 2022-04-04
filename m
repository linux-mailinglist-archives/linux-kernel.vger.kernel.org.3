Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE444F11DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353691AbiDDJWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbiDDJWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:22:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB377765F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4E134CE0F24
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35249C2BBE4;
        Mon,  4 Apr 2022 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649064004;
        bh=HmQZ2Vn2Y/xndkTASq4gy6DwwGvg1neZwy0UTPq1zR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xb0eErFS+ZwWKjgJMvXwUIsFSRgYAnKfU6QvOjUn+lR9Sqi3Vq39Mozf1PW6Tkv1N
         kggOxEhkEzRzxkAgEV6Kr9Ar6Sa+uWD5oz6n2F3B4Hx6vkbAyHpaUM59k/EjELNCOy
         ERsIT64hG40CgDfDTKBd99WfOuv+FA91+6M26MNr9jlB2quYtm8HNtwsl+QksABg4L
         65CTmHN/Tf/4Om9ZEk33rG2oYkqnh878QxwMEV7+kbIg0Wte7CZRVE8qZv4URraDCj
         s+Rpz1bYfuDDevIc142CUFq1FD1Qo8HqxFq153uoZh7Us63oFBKTWUMr5T30T/84Ov
         eNo5UzQ5KdOKQ==
Date:   Mon, 4 Apr 2022 10:19:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, aneesh.kumar@linux.ibm.com,
        steven.price@arm.com, lengxujun2007@126.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        smuchun@gmail.com, duanxiongchun@bytedance.com,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH] arm64: mm: fix pmd_leaf()
Message-ID: <20220404091957.GA22790@willie-the-truck>
References: <20220403024928.4125-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403024928.4125-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 10:49:28AM +0800, Muchun Song wrote:
> The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
> the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
> caused by this was reported by Qian Cai.
> 
> Link: https://patchwork.kernel.org/comment/24798260/ [1]
> Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 94e147e5456c..09eaae46a19b 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -535,7 +535,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				 PMD_TYPE_TABLE)
>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
>  				 PMD_TYPE_SECT)
> -#define pmd_leaf(pmd)		pmd_sect(pmd)
> +#define pmd_leaf(pmd)		(pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
>  #define pmd_bad(pmd)		(!pmd_table(pmd))
>  
>  #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)

A bunch of the users of pmd_leaf() already check pmd_present() -- is it
documented that we need to handle this check inside the macro? afaict x86
doesn't do this either.

Will
