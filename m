Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC42500ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbiDNKIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbiDNKIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A46AA74
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D78761DA5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86612C385A5;
        Thu, 14 Apr 2022 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649930741;
        bh=Dmla2dPaUtWMTVxmNVoyiq1mZIf/bZdj49HOCheIL5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgQc04JQWUYRZZuWRorf2UFDSTE8CLHFAtlO4puAc+Q3y4L+aCZSmbUMDs0XKmFNn
         qh/tGovkPUIPvH1T+AzLn9SYhMb92IpB+ZfMo1pVqGkFiMdy0KPXxL6zEpz7HEaRK/
         S3rQ+H6cm3PWi6Z0gckzFTY4pbpCj2rTbtvzPg4qKjWspYJDZ5dtfcCA/yT7wjL6nc
         cm5u1O+pck4AzObjG3Zd0xmTkvZTb5UUmjiHJBHQm4+m+5J8h92mMsT2Eq49zRXqwt
         o5Uj9haFXd1fIsRoxsT12YQUS8t98KrKzB0c8x7tfbUfdxIbvX/5t1uJZXwOg2/Iso
         KryjHogmPHsnQ==
Date:   Thu, 14 Apr 2022 11:05:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, catalin.marinas@arm.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        lengxujun2007@126.com, arnd@arndb.de, smuchun@gmail.com,
        duanxiongchun@bytedance.com, quic_qiancai@quicinc.com,
        aneesh.kumar@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: mm: fix pmd_leaf()
Message-ID: <20220414100535.GB2298@willie-the-truck>
References: <20220411122653.40284-1-songmuchun@bytedance.com>
 <20220413101929.GA1229@willie-the-truck>
 <64d4288e-7776-a3fd-5ee4-70486dfd0394@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64d4288e-7776-a3fd-5ee4-70486dfd0394@arm.com>
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

On Wed, Apr 13, 2022 at 11:39:49AM +0100, Steven Price wrote:
> On 13/04/2022 11:19, Will Deacon wrote:
> > On Mon, Apr 11, 2022 at 08:26:53PM +0800, Muchun Song wrote:
> >> The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
> >> the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
> >> caused by this was reported by Qian Cai.
> >>
> >> Link: https://patchwork.kernel.org/comment/24798260/ [1]
> >> Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
> >> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> ---
> >> v2:
> >> - Replace pmd_present() with pmd_val() since we expect pmd_leaf() works
> >>   well on non-present pmd case.
> >>
> >>  arch/arm64/include/asm/pgtable.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index ad9b221963d4..00cdd2d895d3 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -551,7 +551,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >>  				 PMD_TYPE_TABLE)
> >>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >>  				 PMD_TYPE_SECT)
> >> -#define pmd_leaf(pmd)		pmd_sect(pmd)
> >> +#define pmd_leaf(pmd)		(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> >>  #define pmd_bad(pmd)		(!pmd_table(pmd))
> > 
> > I'm still trying to get my head around the desired semantics here.
> > 
> > If we want to fix the original report, then we need to take PROT_NONE
> > entries into account. The easiest way to do that is, as you originally
> > suggested, by using pmd_present():
> > 
> > #define pmd_leaf(pmd)	(pmd_present(pmd) && !pmd_table(pmd))
> > 
> > But now you seem to be saying that !pmd_present() entries should also be
> > considered as pmd_leaf() -- is there a real need for that?
> > 
> > If so, then I think this simply becomes:
> > 
> > #define pmd_leaf(pmd)	(!pmd_table(pmd))
> > 
> > which is, amusingly, identical to pmd_bad().
> > 
> > The documentation/comment that Steven referred to also desperately needs
> > clarifying as it currently states:
> > 
> >   "Only meaningful when called on a valid entry."
> > 
> > whatever that means.
> 
> The intention at the time is that this had the same meaning as
> pmd_huge() (when CONFIG_HUGETLB_PAGE is defined), which would then match
> this patch. This is referred in the comment, albeit in a rather weak way:
> 
> >  * This differs from p?d_huge() by the fact that they are always available (if
> >  * the architecture supports large pages at the appropriate level) even
> >  * if CONFIG_HUGETLB_PAGE is not defined.
> 
> However, the real issue here is that the definition of pmd_leaf() isn't
> clear. I know what the original uses of it needed but since then it's
> been used in other areas, and I'm afraid my 'documentation' isn't
> precise enough to actually be useful.
> 
> At the time I wrote that comment I think I meant "valid" in the AArch64
> sense (i.e. the LSB of the entry). PROT_NONE isn't 'valid' by that
> definition (and I hadn't considered it). But of course that definition
> of 'valid' is pretty meaningless in the cross-architecture case.

arm64 'valid' + PROT_NONE is roughly what 'present' means. So we could say
that this only works for present entries, but then Muchun's latest patch
wants to work with !present which is why I tried to work this through.

Will
