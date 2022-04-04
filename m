Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA66F4F1841
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356184AbiDDP0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239630AbiDDP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:26:34 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816C3193EA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:24:38 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y38so18211732ybi.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYOFxbnaPkCaL8rvz60xVT97yR/ZBBL4rwrJFtUiBYk=;
        b=HCQKc+ecg4fdHb/+0UBrcWb9LzzGVNtRzOT37fNF/z9V/H5DyHu/DxS+IXrmYbSPrv
         leDKgRZBCQqQ2C1bKkyAYSPjo2SfdzzrSBUGbJPnZDYdVNsZsytDrjEOGyiHBTty9YwE
         G03EQ3IgVey/d8ZfUSa6MoL34bHO/IUM3izC2gZ6714JJjrKAit78+2omvGdyn3fadYC
         rUGBdtGs6YwOLEebecxbgoBWihHPsimiz/m8v4MNxhvAwjcO57lf6YWtgSS8O18HudDp
         7795/xu8xMzDyaYUgpEwuhpwJVgFiXiI3HWNnc7crUPTHKkDsVBWp8i+abqteU/zhjwi
         s1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYOFxbnaPkCaL8rvz60xVT97yR/ZBBL4rwrJFtUiBYk=;
        b=rIADeSL/j6F/+YO9xbkvflmyQI90657vIXlcpTKV4p9c2HxZ37ZtqLFHM3sXgWCMHe
         r7ArzkLjBB7J4UMYqjzOBB0hWTdvOp6xfubfut4znW8QMoF/CDVC2DRrKQlODmnYjJFY
         y36hm5dB/atROV/ezQpEJIYAEstbF0EfVkn/o6GtiwyXjvprSSu8OGBSHZtjK4Rmo2Y+
         ZeAdcFIaiLoS5i09Wgu47LP1Pig8/9o6hEjHR8/H1I33sJ/hR36m5by/iogwVmUJkeIA
         cr/a4Lhh04CYnnlROWQCQSZnLRecdf9bYOcsO9phBNeJ3PNFLK1s+I8F0UP5yXyuqw48
         NTZA==
X-Gm-Message-State: AOAM530gL7flxMfT2/bcl2dKFRTZl0mKIb6A/tpM/6AAf7e378HaeBAT
        y2gQOabGLVg3buUB9SiEGrLqRJjSCixBmtADEEFOaA==
X-Google-Smtp-Source: ABdhPJxWaXmiS32u6GZgE5itWQUf6xO4YxJteY5qn5GcXvbhiBC7ACm+T1qc3Dw/YD54l3aWcO9r6pbJ5soRPB9o7Gs=
X-Received: by 2002:a25:e70e:0:b0:634:1a47:4ff2 with SMTP id
 e14-20020a25e70e000000b006341a474ff2mr275019ybh.89.1649085877745; Mon, 04 Apr
 2022 08:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220403024928.4125-1-songmuchun@bytedance.com>
 <20220404091957.GA22790@willie-the-truck> <CAMZfGtU=4aFmbwyyh+5=M3iaqox7X7yaoPP+r=WJO9dReaNb-g@mail.gmail.com>
 <de6529b0-9360-cf4a-4233-ee1498b44176@linux.ibm.com>
In-Reply-To: <de6529b0-9360-cf4a-4233-ee1498b44176@linux.ibm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 4 Apr 2022 23:24:01 +0800
Message-ID: <CAMZfGtXieqZroJfvgV6eVM+ux0P28sjz6NMtZsNwkvdebBoztQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: fix pmd_leaf()
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        steven.price@arm.com, lengxujun2007@126.com,
        Arnd Bergmann <arnd@arndb.de>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <smuchun@gmail.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 10:10 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 4/4/22 5:10 PM, Muchun Song wrote:
> > On Mon, Apr 4, 2022 at 5:20 PM Will Deacon <will@kernel.org> wrote:
> >>
> >> On Sun, Apr 03, 2022 at 10:49:28AM +0800, Muchun Song wrote:
> >>> The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
> >>> the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
> >>> caused by this was reported by Qian Cai.
> >>>
> >>> Link: https://patchwork.kernel.org/comment/24798260/ [1]
> >>> Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
> >>> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>>   arch/arm64/include/asm/pgtable.h | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >>> index 94e147e5456c..09eaae46a19b 100644
> >>> --- a/arch/arm64/include/asm/pgtable.h
> >>> +++ b/arch/arm64/include/asm/pgtable.h
> >>> @@ -535,7 +535,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> >>>                                 PMD_TYPE_TABLE)
> >>>   #define pmd_sect(pmd)                ((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >>>                                 PMD_TYPE_SECT)
> >>> -#define pmd_leaf(pmd)                pmd_sect(pmd)
> >>> +#define pmd_leaf(pmd)                (pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> >>>   #define pmd_bad(pmd)         (!pmd_table(pmd))
> >>>
> >>>   #define pmd_leaf_size(pmd)   (pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
> >>
> >> A bunch of the users of pmd_leaf() already check pmd_present() -- is it
> >> documented that we need to handle this check inside the macro? afaict x86
> >> doesn't do this either.
>
>
> ppc64 also doesn't do a pmd_present check.
>
> >>
> >
> > arm64 is different from x86 here. pmd_leaf() could return true for
> > the none pmd without pmd_present() check, the check of
> > pmd_present() aims to exclude the pmd_none() case.  However,
> > it could work properly on x86 without pmd_present() or pmd_none().
> > So we don't see pmd_present() or pmd_none() check in pmd_leaf().
> > For this reason, I think this check is necessary.
> >
> > BTW, there are some users of pmd_leaf() (e.g. apply_to_pmd_range,
> > walk_pmd_range, ptdump_pmd_entry) which do not check pmd_present()
> > or pmd_none() before the call of pmd_leaf().  So it is also necessary
> > to add the check.
> >
>
>
> I would expect pmd_leaf check to return true, if the said pmd page table
> entry can point to a leaf page table entry which can also be a not
> present page table entry?
>

All right. In order to exclude the pmd_none() case.  How about
the following code?

#define pmd_leaf(pmd)                (pmd_val(pmd) && !(pmd_val(pmd) &
PMD_TABLE_BIT))

Thanks.
