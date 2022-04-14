Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98521500BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiDNLUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiDNLUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:20:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851875C3D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:18:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i24-20020a17090adc1800b001cd5529465aso4297913pjv.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cApjy1z/WTuYgC0OK2plrpPC0MAtVd0VXO0NPNL/K7k=;
        b=JRiEcfNcIxdtXaRVoJ49EaIWVLBuPwVwzbNP5U2aJD+SwsDxylVURuBvt0Qv9wNrSd
         pvXnJY6xxmNXRgWlzyaDe34yc3PwAlKhlHPJUEaXAE3fh2IH63usa7ptt5edKIVeD82P
         H2Y77Wd5pHy/jEAoSGSRAnZgvg1AOKVY96bkduwWnLjiujAS9wx806bOuQr6sFsDtO0j
         NxMyJ5bKj1IEBxf49Zby/yQ/lMDtghiPvMGmpjZPkPMkqRMiXqTJcUy+ID320/MmZEfI
         1x3wqupplKRF5XNO/Gi0kRuCQzIOvb3LZcr+kpEKetyEWeGfXpV/05F7Fp91E3IEI4AB
         nPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cApjy1z/WTuYgC0OK2plrpPC0MAtVd0VXO0NPNL/K7k=;
        b=7gZ3qBQusbTAF6mSFMKy4g2mdITrKGx64vwRZ4K7kaKzBTuoth4XGvlmK3wJUcQzZn
         tK2BJqnlLCGBs8ZCk9Hu9LwHA4vNnyrXY2sZRRfbXRdPhsqdg1TaXd2VJPqgQB7hdwSw
         ui+ANtM4eyVoIgfaoX4IFvqaZVQywddTD7cp6rWUGdb+M8Fxd2/OZvJF83KBh9qeqUg6
         ToqTfkgVxQlYx9zMI1tU6TzfQ4cn2bKJntBwZkViELn9qolF6A8+a/JBo24ZKvgu+XMk
         JkSfNDd1fqOVauYmq2FUW5YZ30Oomdn7k8a5FhKWYFnj8gU64jHdb03qG0m5QnVL8nKr
         6DMQ==
X-Gm-Message-State: AOAM53252DP7gYKtG3jey28lnL+2728Wa3SaiqiJ5V513IeWXd/2qjgp
        aWbLh2eZqiOajtljFrPYy/BVVQ==
X-Google-Smtp-Source: ABdhPJy7RRXNPbA+lQVGxBoi5SOBxAGPWUefgr9V+P+8VYZr88w41MNltNvDvmzCwsofV1+Hh9rnFw==
X-Received: by 2002:a17:90b:4a89:b0:1c7:3933:d802 with SMTP id lp9-20020a17090b4a8900b001c73933d802mr3117701pjb.75.1649935100207;
        Thu, 14 Apr 2022 04:18:20 -0700 (PDT)
Received: from localhost ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a4d8200b001cb41f25148sm1848735pjh.17.2022.04.14.04.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 04:18:19 -0700 (PDT)
Date:   Thu, 14 Apr 2022 19:18:11 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>, catalin.marinas@arm.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        lengxujun2007@126.com, arnd@arndb.de, smuchun@gmail.com,
        duanxiongchun@bytedance.com, quic_qiancai@quicinc.com,
        aneesh.kumar@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: mm: fix pmd_leaf()
Message-ID: <YlgC877mS2LjsqS8@FVFYT0MHHV2J.usts.net>
References: <20220411122653.40284-1-songmuchun@bytedance.com>
 <20220413101929.GA1229@willie-the-truck>
 <64d4288e-7776-a3fd-5ee4-70486dfd0394@arm.com>
 <20220414100535.GB2298@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414100535.GB2298@willie-the-truck>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:05:35AM +0100, Will Deacon wrote:
> On Wed, Apr 13, 2022 at 11:39:49AM +0100, Steven Price wrote:
> > On 13/04/2022 11:19, Will Deacon wrote:
> > > On Mon, Apr 11, 2022 at 08:26:53PM +0800, Muchun Song wrote:
> > >> The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
> > >> the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
> > >> caused by this was reported by Qian Cai.
> > >>
> > >> Link: https://patchwork.kernel.org/comment/24798260/ [1]
> > >> Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
> > >> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> > >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > >> ---
> > >> v2:
> > >> - Replace pmd_present() with pmd_val() since we expect pmd_leaf() works
> > >>   well on non-present pmd case.
> > >>
> > >>  arch/arm64/include/asm/pgtable.h | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > >> index ad9b221963d4..00cdd2d895d3 100644
> > >> --- a/arch/arm64/include/asm/pgtable.h
> > >> +++ b/arch/arm64/include/asm/pgtable.h
> > >> @@ -551,7 +551,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> > >>  				 PMD_TYPE_TABLE)
> > >>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> > >>  				 PMD_TYPE_SECT)
> > >> -#define pmd_leaf(pmd)		pmd_sect(pmd)
> > >> +#define pmd_leaf(pmd)		(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> > >>  #define pmd_bad(pmd)		(!pmd_table(pmd))
> > > 
> > > I'm still trying to get my head around the desired semantics here.
> > > 
> > > If we want to fix the original report, then we need to take PROT_NONE
> > > entries into account. The easiest way to do that is, as you originally
> > > suggested, by using pmd_present():
> > > 
> > > #define pmd_leaf(pmd)	(pmd_present(pmd) && !pmd_table(pmd))
> > > 
> > > But now you seem to be saying that !pmd_present() entries should also be
> > > considered as pmd_leaf() -- is there a real need for that?
> > > 
> > > If so, then I think this simply becomes:
> > > 
> > > #define pmd_leaf(pmd)	(!pmd_table(pmd))
> > > 
> > > which is, amusingly, identical to pmd_bad().
> > > 
> > > The documentation/comment that Steven referred to also desperately needs
> > > clarifying as it currently states:
> > > 
> > >   "Only meaningful when called on a valid entry."
> > > 
> > > whatever that means.
> > 
> > The intention at the time is that this had the same meaning as
> > pmd_huge() (when CONFIG_HUGETLB_PAGE is defined), which would then match
> > this patch. This is referred in the comment, albeit in a rather weak way:
> > 
> > >  * This differs from p?d_huge() by the fact that they are always available (if
> > >  * the architecture supports large pages at the appropriate level) even
> > >  * if CONFIG_HUGETLB_PAGE is not defined.
> > 
> > However, the real issue here is that the definition of pmd_leaf() isn't
> > clear. I know what the original uses of it needed but since then it's
> > been used in other areas, and I'm afraid my 'documentation' isn't
> > precise enough to actually be useful.
> > 
> > At the time I wrote that comment I think I meant "valid" in the AArch64
> > sense (i.e. the LSB of the entry). PROT_NONE isn't 'valid' by that
> > definition (and I hadn't considered it). But of course that definition
> > of 'valid' is pretty meaningless in the cross-architecture case.
> 
> arm64 'valid' + PROT_NONE is roughly what 'present' means. So we could say
> that this only works for present entries, but then Muchun's latest patch
> wants to work with !present which is why I tried to work this through.
>

My bad. In the previous version, Aneesh seems want to make
pmd_leaf() works for a not present page table entry, I am
trying doing this in this version.  Seems like I do the right
thing in the previous version from your explanation.

I'll use the previos version and fix pud_leaf() as well and
update the documentation.  Do you think this is okay?

Thanks.



 
