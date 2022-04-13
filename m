Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6170E4FF49A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiDMKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiDMKWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:22:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD14205CC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09EEDB8210D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A508C385A4;
        Wed, 13 Apr 2022 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649845187;
        bh=qxJL5yOaos+tKLkjwwPTgb/0Ql6zLkoAu0fHe+qg3Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GijhfY4ViYIIYk2YS6l90Zh1Ax3ZZcToHUtpTNjLv145P+ZHbVACMs+kBy+e10UKk
         SB1SGfmUZJ4dvYPDM7K/Pt61aby6EXKWrJ0NSVM+CrrpLI4g4WgwzU5pXV+1a0fin5
         CLAbb4hCWvBwlrAO2y2bzIpy1It5QCreQSnUg/UsR9JANNPXrxjRf1H+DCckk/q1+a
         Ickj0NJuSL64oXciTbZrYl7waw5yckboXTDDr4Ed/AoRtGNCEqUl1ry3Ry8z54rLho
         gPFDQVI7TJKYZwH5SNO8IqFgMzK4fikttptE5Fd1QwTzWKf4OdUMgGC9Vq3DEHEQdj
         Ck8kjW2KRGL6g==
Date:   Wed, 13 Apr 2022 11:19:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, steven.price@arm.com,
        lengxujun2007@126.com, arnd@arndb.de, smuchun@gmail.com,
        duanxiongchun@bytedance.com, quic_qiancai@quicinc.com,
        aneesh.kumar@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: mm: fix pmd_leaf()
Message-ID: <20220413101929.GA1229@willie-the-truck>
References: <20220411122653.40284-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411122653.40284-1-songmuchun@bytedance.com>
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

On Mon, Apr 11, 2022 at 08:26:53PM +0800, Muchun Song wrote:
> The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
> the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
> caused by this was reported by Qian Cai.
> 
> Link: https://patchwork.kernel.org/comment/24798260/ [1]
> Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
> - Replace pmd_present() with pmd_val() since we expect pmd_leaf() works
>   well on non-present pmd case.
> 
>  arch/arm64/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index ad9b221963d4..00cdd2d895d3 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -551,7 +551,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				 PMD_TYPE_TABLE)
>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
>  				 PMD_TYPE_SECT)
> -#define pmd_leaf(pmd)		pmd_sect(pmd)
> +#define pmd_leaf(pmd)		(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
>  #define pmd_bad(pmd)		(!pmd_table(pmd))

I'm still trying to get my head around the desired semantics here.

If we want to fix the original report, then we need to take PROT_NONE
entries into account. The easiest way to do that is, as you originally
suggested, by using pmd_present():

#define pmd_leaf(pmd)	(pmd_present(pmd) && !pmd_table(pmd))

But now you seem to be saying that !pmd_present() entries should also be
considered as pmd_leaf() -- is there a real need for that?

If so, then I think this simply becomes:

#define pmd_leaf(pmd)	(!pmd_table(pmd))

which is, amusingly, identical to pmd_bad().

The documentation/comment that Steven referred to also desperately needs
clarifying as it currently states:

  "Only meaningful when called on a valid entry."

whatever that means.

Finally, if this has implications beyond PROT_NONE (as I think you're
suggesting in your v2) then pud_leaf() probably needs similar treatment.
And we can remove pmd_sect() altogether if we no longer need it.

Will
