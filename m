Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8DA4F13F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376291AbiDDLmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347843AbiDDLmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:42:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E39271C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:40:42 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f23so17009366ybj.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3e33i6OE0vKtQNUj2X/HMPY2qJBMa9Au4u5Sza4lwk=;
        b=h72gvlx6PxdeNzjj/gMt24tBmab31R4r06K4rde6PfLCni70SxyMCBN8jE4advswlt
         TXWIYi7jf+zkelEhbRYicwu4oiqy2Wyn7wF1MVlZdjVr3LKALQpQXyJjmW4lAVunb3mg
         Ywl3nuGQaxHrAiTxL2vonb2s+0ER0zoysDAMP3iv62hyLa8hCvSrstD9yZUswxW9Gpr7
         a9LA+GiPXUGvyk8BwL5YHv9JJ8rCX/O94mqBwcUHVUk79reEYkoGloie3I9XK/EoOS7g
         A+8u2Wt2UMeqP61Zeb8U16yOeP1gzhMvW3sQ0TefyVwxq5zd8+Nt8ILVv1TybvHiMDM3
         spKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3e33i6OE0vKtQNUj2X/HMPY2qJBMa9Au4u5Sza4lwk=;
        b=7HWUI6n2W1hrgIt/UQQsueVckGPp5O5kvFjCTf6yRfdOOE6IxMS/EcEXg/aPHtRHEL
         SzpB0AB6EN1Y8e0VfPEY/MGpExbmpLaePFbUIHZKvsMQVpntEnxtT4UwozG/Xel+1m1p
         ae0Rx3x3mnHWnv3NpR+XY/tA95eLO7Z+HUKEA5rwegjlm1M8MRUjEhAsaGCL5kdwZGog
         Yfiw+/hLg5udgWKp5MVDHAVeHf/ncy2cHUsKJ4tdsfJgb565xti1AuO54W42l8dbmbu1
         xmHcKWBuIrt2y4iDrdhQQeqSFuR2Sr4RK5AwbLUUzQ2cTkfCihDC001/UZCt5ZWsfH4d
         w2Og==
X-Gm-Message-State: AOAM532pNfV9A6WLNZrGl+RrV/YHi5VDOB/ov4g8NVa1QDUcxUcHwA7j
        F5tU9BYfpNvpBh9vWZlzrtQBpXC9M00Qr1aIqH7Tiw==
X-Google-Smtp-Source: ABdhPJxoxR86mK9l+xNHYzZggMVQi2Hc4ai3sN8J1A6guxozXQpoyV2SN+UjxYFVurlHwbPVBUGuHO1nrYIm89rKhR0=
X-Received: by 2002:a25:e70e:0:b0:634:1a47:4ff2 with SMTP id
 e14-20020a25e70e000000b006341a474ff2mr18831825ybh.89.1649072441764; Mon, 04
 Apr 2022 04:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220403024928.4125-1-songmuchun@bytedance.com> <20220404091957.GA22790@willie-the-truck>
In-Reply-To: <20220404091957.GA22790@willie-the-truck>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 4 Apr 2022 19:40:05 +0800
Message-ID: <CAMZfGtU=4aFmbwyyh+5=M3iaqox7X7yaoPP+r=WJO9dReaNb-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: fix pmd_leaf()
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        steven.price@arm.com, lengxujun2007@126.com,
        Arnd Bergmann <arnd@arndb.de>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <smuchun@gmail.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 5:20 PM Will Deacon <will@kernel.org> wrote:
>
> On Sun, Apr 03, 2022 at 10:49:28AM +0800, Muchun Song wrote:
> > The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
> > the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
> > caused by this was reported by Qian Cai.
> >
> > Link: https://patchwork.kernel.org/comment/24798260/ [1]
> > Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
> > Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 94e147e5456c..09eaae46a19b 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -535,7 +535,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >                                PMD_TYPE_TABLE)
> >  #define pmd_sect(pmd)                ((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >                                PMD_TYPE_SECT)
> > -#define pmd_leaf(pmd)                pmd_sect(pmd)
> > +#define pmd_leaf(pmd)                (pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> >  #define pmd_bad(pmd)         (!pmd_table(pmd))
> >
> >  #define pmd_leaf_size(pmd)   (pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
>
> A bunch of the users of pmd_leaf() already check pmd_present() -- is it
> documented that we need to handle this check inside the macro? afaict x86
> doesn't do this either.
>

arm64 is different from x86 here. pmd_leaf() could return true for
the none pmd without pmd_present() check, the check of
pmd_present() aims to exclude the pmd_none() case.  However,
it could work properly on x86 without pmd_present() or pmd_none().
So we don't see pmd_present() or pmd_none() check in pmd_leaf().
For this reason, I think this check is necessary.

BTW, there are some users of pmd_leaf() (e.g. apply_to_pmd_range,
walk_pmd_range, ptdump_pmd_entry) which do not check pmd_present()
or pmd_none() before the call of pmd_leaf().  So it is also necessary
to add the check.

Thanks.
