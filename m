Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2B576205
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiGOMoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGOMox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:44:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3EC71BE1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:44:52 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id by8so1978241ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwAK4H2fVQwUr3+IIFLavhYbNJQlw8pntln2eHgKkYw=;
        b=xkd2N7NGlJjsxyfWaBYiu4504FmMAzx9WdGCA1mHXUCdraS+3nek0OoHMV5wXltoQK
         7jBHjR81MK3dEw2/+TT2EoTokOQyoTJ9qd3qMSB6z8xU1AZ02ZJYRDreU0pbsF0lC7XX
         k/q7vgPIFaur3/c49NhsLqf+q1/UemhMbSvK/HxkNZBfvkILQT8l0lYf48ol0AVzHYQq
         JYyXqXHpKvn5crcBjkf8fFfm0kHT93fpo4jUstolI3AoNixEisdDaGDUQFKfkJRekkdq
         8+Y+0h4KgKWhAUcxLQI2yTVbQwbNezkiyp4o+ox2kuVZxaslPGZj/39qUOGar91N0Cix
         RsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwAK4H2fVQwUr3+IIFLavhYbNJQlw8pntln2eHgKkYw=;
        b=zu4+t7njkWlhvpCZocwjSzbGpoVavY4ZKkJ3S//QJSMws/Z8qPXK/E9LJFJ1O+gM+B
         VY5N3+ASy4qzyhxGUgHLkBJWDHBSnZtQIiYfDPDDihBSADS++ZW5W6UkeHefwOVVau5q
         6F/X2h4z5X6V27qcb0MkwLAQcthK+bHQttKP59t7ROX8EZHeqhHetEM+9i61dpytkPmt
         IazdE6J8UFpAI7ZPoTitQ0h91k+FMnfaGSZhp5iR9o7/MbDH9QnzsYWkBi3drRR820Ai
         bJC/XdefcLSFX5tq2a9eIGEjfer0ADSW9P/rw6yztGY+0E85jZ7yegvhAR+3jBSd664B
         Mx7w==
X-Gm-Message-State: AJIora+O+r3ytX91KDdolQUai1Xtqlv5TU/fPpRv6aXlsnXYgu/oJiZ/
        tpkPkVe/nwPDpqabZN6BXtvWG62jK/c/BcOj5Ud+RA==
X-Google-Smtp-Source: AGRyM1sLowP5UFCjY6i+lwr3s+svnMnfBmDjh4s0YfgEmYk4rETNfT++ZPrlf4BUQEqFL0k+8Y+hq9DGBtLWzDqBsxo=
X-Received: by 2002:a2e:a413:0:b0:25d:4844:9d65 with SMTP id
 p19-20020a2ea413000000b0025d48449d65mr6839813ljn.169.1657889090278; Fri, 15
 Jul 2022 05:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
 <20220714165550.8884-5-semen.protsenko@linaro.org> <29cb0b4f-531c-b17a-09b6-2da2faaf9e11@arm.com>
In-Reply-To: <29cb0b4f-531c-b17a-09b6-2da2faaf9e11@arm.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 15 Jul 2022 15:44:39 +0300
Message-ID: <CAPLW+4nzxAP4jFxxWRTuXWHzEbpsZEVO7OAZH5A_V1Bda-tNBg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] iommu/exynos: Abstract non-common registers on
 different variants
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 at 15:14, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-07-14 17:55, Sam Protsenko wrote:
> > At the moment the driver supports SysMMU v1..v5 versions. SysMMU v5 has
> > different register layout than SysMMU v1..v3. Instead of checking the
> > version each time before reading/writing the registers, let's create
> > corresponding register structure for each SysMMU version and set the
> > needed structure on init, checking the SysMMU version one single time.
> > This way is faster and more elegant.
> >
> > No behavior changes from the user's point of view, it's only a
> > refactoring patch.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> > Changes in v3:
> >    - Added Marek's Acked-by tag
> >    - Removed abstracting common regs, used plain readl/writel to access
> >      those instead
> >    - Used variant struct instead of array to keep non-common register
> >      offsets
>
> I'm a bit late, but just for the record I think the new approach in this
> version looks really good :)
>

Thank you for the review, Robin!

> Cheers,
> Robin.
>
> >    - Removed 0x1 value used as an offset for missing registers
> >    - Merged __sysmmu_hw_info() into __sysmmu_get_version()
> >    - Refactored __sysmmu_tlb_invalidate_entry() for "num_inv == 1" case
> >    - Reworked the commit message w.r.t. all changes
> >
> > Changes in v2:
> >    - Reworked existing code (SysMMU v1..v5) to use this approach
> >    - Extracted v7 registers to the separate patches
> >    - Replaced MMU_REG() with corresponding SysMMU read/write functions
> >    - Improved the comment for 0x1 offsets triggering an unaligned access
> >      exception
> >    - Removed support for VMID number, as only VMID=0 (default) is used
> >      for now
> >    - Renamed register index names to reflect the old SysMMU version
> >      register names
> >
> >   drivers/iommu/exynos-iommu.c | 100 +++++++++++++++++++++--------------
> >   1 file changed, 60 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index 494f7d7aa9c5..6a0299fe1722 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -148,26 +148,12 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
> >   #define MAKE_MMU_VER(maj, min)      ((((maj) & 0xF) << 7) | ((min) & 0x7F))
> >
> >   /* v1.x - v3.x registers */
> > -#define REG_MMU_FLUSH                0x00C
> > -#define REG_MMU_FLUSH_ENTRY  0x010
> > -#define REG_PT_BASE_ADDR     0x014
> > -#define REG_INT_STATUS               0x018
> > -#define REG_INT_CLEAR                0x01C
> > -
> >   #define REG_PAGE_FAULT_ADDR 0x024
> >   #define REG_AW_FAULT_ADDR   0x028
> >   #define REG_AR_FAULT_ADDR   0x02C
> >   #define REG_DEFAULT_SLAVE_ADDR      0x030
> >
> >   /* v5.x registers */
> > -#define REG_V5_PT_BASE_PFN   0x00C
> > -#define REG_V5_MMU_FLUSH_ALL 0x010
> > -#define REG_V5_MMU_FLUSH_ENTRY       0x014
> > -#define REG_V5_MMU_FLUSH_RANGE       0x018
> > -#define REG_V5_MMU_FLUSH_START       0x020
> > -#define REG_V5_MMU_FLUSH_END 0x024
> > -#define REG_V5_INT_STATUS    0x060
> > -#define REG_V5_INT_CLEAR     0x064
> >   #define REG_V5_FAULT_AR_VA  0x070
> >   #define REG_V5_FAULT_AW_VA  0x080
> >
> > @@ -250,6 +236,21 @@ struct exynos_iommu_domain {
> >       struct iommu_domain domain; /* generic domain data structure */
> >   };
> >
> > +/*
> > + * SysMMU version specific data. Contains offsets for the registers which can
> > + * be found in different SysMMU variants, but have different offset values.
> > + */
> > +struct sysmmu_variant {
> > +     u32 pt_base;            /* page table base address (physical) */
> > +     u32 flush_all;          /* invalidate all TLB entries */
> > +     u32 flush_entry;        /* invalidate specific TLB entry */
> > +     u32 flush_range;        /* invalidate TLB entries in specified range */
> > +     u32 flush_start;        /* start address of range invalidation */
> > +     u32 flush_end;          /* end address of range invalidation */
> > +     u32 int_status;         /* interrupt status information */
> > +     u32 int_clear;          /* clear the interrupt */
> > +};
> > +
> >   /*
> >    * This structure hold all data of a single SYSMMU controller, this includes
> >    * hw resources like registers and clocks, pointers and list nodes to connect
> > @@ -274,6 +275,30 @@ struct sysmmu_drvdata {
> >       unsigned int version;           /* our version */
> >
> >       struct iommu_device iommu;      /* IOMMU core handle */
> > +     const struct sysmmu_variant *variant; /* version specific data */
> > +};
> > +
> > +#define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
> > +
> > +/* SysMMU v1..v3 */
> > +static const struct sysmmu_variant sysmmu_v1_variant = {
> > +     .flush_all      = 0x0c,
> > +     .flush_entry    = 0x10,
> > +     .pt_base        = 0x14,
> > +     .int_status     = 0x18,
> > +     .int_clear      = 0x1c,
> > +};
> > +
> > +/* SysMMU v5 */
> > +static const struct sysmmu_variant sysmmu_v5_variant = {
> > +     .pt_base        = 0x0c,
> > +     .flush_all      = 0x10,
> > +     .flush_entry    = 0x14,
> > +     .flush_range    = 0x18,
> > +     .flush_start    = 0x20,
> > +     .flush_end      = 0x24,
> > +     .int_status     = 0x60,
> > +     .int_clear      = 0x64,
> >   };
> >
> >   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> > @@ -304,10 +329,7 @@ static bool sysmmu_block(struct sysmmu_drvdata *data)
> >
> >   static void __sysmmu_tlb_invalidate(struct sysmmu_drvdata *data)
> >   {
> > -     if (MMU_MAJ_VER(data->version) < 5)
> > -             writel(0x1, data->sfrbase + REG_MMU_FLUSH);
> > -     else
> > -             writel(0x1, data->sfrbase + REG_V5_MMU_FLUSH_ALL);
> > +     writel(0x1, SYSMMU_REG(data, flush_all));
> >   }
> >
> >   static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
> > @@ -315,33 +337,30 @@ static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
> >   {
> >       unsigned int i;
> >
> > -     if (MMU_MAJ_VER(data->version) < 5) {
> > +     if (MMU_MAJ_VER(data->version) < 5 || num_inv == 1) {
> >               for (i = 0; i < num_inv; i++) {
> >                       writel((iova & SPAGE_MASK) | 1,
> > -                                  data->sfrbase + REG_MMU_FLUSH_ENTRY);
> > +                            SYSMMU_REG(data, flush_entry));
> >                       iova += SPAGE_SIZE;
> >               }
> >       } else {
> > -             if (num_inv == 1) {
> > -                     writel((iova & SPAGE_MASK) | 1,
> > -                                  data->sfrbase + REG_V5_MMU_FLUSH_ENTRY);
> > -             } else {
> > -                     writel((iova & SPAGE_MASK),
> > -                                  data->sfrbase + REG_V5_MMU_FLUSH_START);
> > -                     writel((iova & SPAGE_MASK) + (num_inv - 1) * SPAGE_SIZE,
> > -                                  data->sfrbase + REG_V5_MMU_FLUSH_END);
> > -                     writel(1, data->sfrbase + REG_V5_MMU_FLUSH_RANGE);
> > -             }
> > +             writel(iova & SPAGE_MASK, SYSMMU_REG(data, flush_start));
> > +             writel((iova & SPAGE_MASK) + (num_inv - 1) * SPAGE_SIZE,
> > +                    SYSMMU_REG(data, flush_end));
> > +             writel(0x1, SYSMMU_REG(data, flush_range));
> >       }
> >   }
> >
> >   static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
> >   {
> > +     u32 pt_base;
> > +
> >       if (MMU_MAJ_VER(data->version) < 5)
> > -             writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
> > +             pt_base = pgd;
> >       else
> > -             writel(pgd >> SPAGE_ORDER, data->sfrbase + REG_V5_PT_BASE_PFN);
> > +             pt_base = pgd >> SPAGE_ORDER;
> >
> > +     writel(pt_base, SYSMMU_REG(data, pt_base));
> >       __sysmmu_tlb_invalidate(data);
> >   }
> >
> > @@ -378,6 +397,11 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
> >       dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
> >               MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
> >
> > +     if (MMU_MAJ_VER(data->version) < 5)
> > +             data->variant = &sysmmu_v1_variant;
> > +     else
> > +             data->variant = &sysmmu_v5_variant;
> > +
> >       __sysmmu_disable_clocks(data);
> >   }
> >
> > @@ -405,19 +429,14 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
> >       const struct sysmmu_fault_info *finfo;
> >       unsigned int i, n, itype;
> >       sysmmu_iova_t fault_addr;
> > -     unsigned short reg_status, reg_clear;
> >       int ret = -ENOSYS;
> >
> >       WARN_ON(!data->active);
> >
> >       if (MMU_MAJ_VER(data->version) < 5) {
> > -             reg_status = REG_INT_STATUS;
> > -             reg_clear = REG_INT_CLEAR;
> >               finfo = sysmmu_faults;
> >               n = ARRAY_SIZE(sysmmu_faults);
> >       } else {
> > -             reg_status = REG_V5_INT_STATUS;
> > -             reg_clear = REG_V5_INT_CLEAR;
> >               finfo = sysmmu_v5_faults;
> >               n = ARRAY_SIZE(sysmmu_v5_faults);
> >       }
> > @@ -426,7 +445,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
> >
> >       clk_enable(data->clk_master);
> >
> > -     itype = __ffs(readl(data->sfrbase + reg_status));
> > +     itype = __ffs(readl(SYSMMU_REG(data, int_status)));
> >       for (i = 0; i < n; i++, finfo++)
> >               if (finfo->bit == itype)
> >                       break;
> > @@ -443,7 +462,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
> >       /* fault is not recovered by fault handler */
> >       BUG_ON(ret != 0);
> >
> > -     writel(1 << itype, data->sfrbase + reg_clear);
> > +     writel(1 << itype, SYSMMU_REG(data, int_clear));
> >
> >       sysmmu_unblock(data);
> >
> > @@ -622,6 +641,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
> >       data->sysmmu = dev;
> >       spin_lock_init(&data->lock);
> >
> > +     __sysmmu_get_version(data);
> > +
> >       ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
> >                                    dev_name(data->sysmmu));
> >       if (ret)
> > @@ -633,7 +654,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
> >
> >       platform_set_drvdata(pdev, data);
> >
> > -     __sysmmu_get_version(data);
> >       if (PG_ENT_SHIFT < 0) {
> >               if (MMU_MAJ_VER(data->version) < 5) {
> >                       PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
