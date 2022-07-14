Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D5574EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiGNNL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiGNNLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:11:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A363C8C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:11:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e28so2738872lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3k2QX4bguOE0L7QO8kTytO481rt2YTc1m8KARAq/JE=;
        b=OseFNQWCpneawnk6hDRAcmEjZIvGnmdYZBZowJgnKaUcQMpIn5ZycNGgemvrKty1Ky
         nWVLsrYroWqs1jKbXnmksiWdubrPiOfzYQ/Jadkq28J49HyA2oqZxcSrNwuHFylw1tMP
         0D0tSl58B1KULox2v9JIjxnUoihgdl/zodAm1y54fjNq3nJTJh5aQ5fTFX3O849183pI
         2iN0/YoWII2OUuSKWES3GXfom9+SHS6HWCnsUwx2pkn5N6WnIlLheIE2p79uajKY3WFW
         Qaw+ojqZRkbPpspf8jjzdGecNGvsKzn8V+idkD+PIY60XuTEQOD+mtlp7TerlTUmqxkr
         M5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3k2QX4bguOE0L7QO8kTytO481rt2YTc1m8KARAq/JE=;
        b=1GrAGKHDvoVyEr643F8zZcdKbrNmlsCAS+xWRKFpkQqFVIlytSlsdI/ZpAEav7belp
         f0tGlCZkOQU27qunqaRpoAi/9sRbv2RVL9dxlzPJRyAsezioxQWzH8WIb9P57qFuY4Jn
         0vJjEj0dC+p5/ss6cpL5zzMsPanRXOrQztsFLSI+lefdXRPd+K2MBQBq9/oSWY/FGvz4
         q+EKALRI7ywdoIj8t+oE9eLISpYyLVuoZ6U/Gk2oxZw4Xc7lbFPHPdcMN38Qmr//5KTy
         14b2F9fwoD0kauJf3FWVuOnO7yobwUW6BglHHb6rYhQzkUTAYW8My999u41rFJLvyccx
         eLow==
X-Gm-Message-State: AJIora+YEN5QwjMwGFVZ4qQ8nuCJK0+ubT3CqOMemzcEbGJ2UV+2aIlc
        AZW72qK0G/SxLxYq9SFWVUqRJMFy0gwL/h3hdjmWbg==
X-Google-Smtp-Source: AGRyM1uG/EcQ4xkQr2lwBmOJy5j05NRxm363QEGm3+XpW5ztY9XxmPCK2hQgTdMeJgU3mUt6QlIChrPlb/72n9Yjrg8=
X-Received: by 2002:a05:6512:398d:b0:489:c7a2:be6f with SMTP id
 j13-20020a056512398d00b00489c7a2be6fmr4987221lfu.11.1657804279347; Thu, 14
 Jul 2022 06:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-5-semen.protsenko@linaro.org> <9eb795cd-999b-73e5-2eeb-c123b1d05a34@arm.com>
In-Reply-To: <9eb795cd-999b-73e5-2eeb-c123b1d05a34@arm.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Jul 2022 16:11:07 +0300
Message-ID: <CAPLW+4=QOv_gAov2KHC4zR881CV3igESMH5JU7XgLbDLS8UNAg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] iommu/exynos: Use lookup based approach to access registers
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 at 19:24, Robin Murphy <robin.murphy@arm.com> wrote:

[snip]

> > No functional change here, just a refactoring patch.
>
> FWIW I'd say that this absolutely *is* a functional change. Achieving
> the same end result, but fundamentally changing the mechanism used to
> get there, is a bit different to simply moving code around.
>

As I understand, usually the "functional change" means some change
that can be observed from the user's point of view (i.e. user of this
driver). But ok, I'll clarify this bit in the commit message.

[snip]

> > +/*
> > + * Some SysMMU versions might not implement some registers from this set, thus
> > + * those registers shouldn't be accessed. Set the offsets for those registers to
> > + * 0x1 to trigger an unaligned access exception, which can help one to debug
> > + * related issues.
> > + */
> > +static const unsigned int sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
>
> Do we really need MAX_REG_SET? Maybe there's a consistency argument, I
> guess :/
>

Here and below: I reworked the register table using approach suggested
by Krzysztof, so those enums won't be present in v2 at all.

> > +     /* SysMMU v1..v3 */
> > +     {
> > +             0x00, 0x04, 0x08, 0x14, 0x0c, 0x10, 0x1, 0x1, 0x1,
> > +             0x18, 0x1c,
>
> This looks fragile and unnecessarily difficult to follow and maintain -
> designated initialisers would be a lot better in all respects, i.e.:
>
>         [REG_SET_V1] = {
>                 ...
>                 [IDX_PT_BASE] = REG_PT_BASE_ADDR,
>                 ...
>
> etc.
>

[snip]

> >   static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
> > @@ -317,31 +348,33 @@ static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
> >
> >       if (MMU_MAJ_VER(data->version) < 5) {
> >               for (i = 0; i < num_inv; i++) {
> > -                     writel((iova & SPAGE_MASK) | 1,
> > -                                  data->sfrbase + REG_MMU_FLUSH_ENTRY);
> > +                     sysmmu_write(data, IDX_FLUSH_ENTRY,
> > +                                  (iova & SPAGE_MASK) | 0x1);
> >                       iova += SPAGE_SIZE;
> >               }
> >       } else {
> >               if (num_inv == 1) {
>
> You could merge this condition into the one above now. That much I'd
> call non-functional refactoring ;)
>

Done, thanks.

[snip]

> > +
> > +static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
> > +{
>
> Seems a bit unnecessary to split the call up like this - I'd say the
> register set is fundamentally connected to the version, and
> "get_hw_info" is even less meaningfully descriptive than just having
> "get_version" take care of one more assignment, but hey ho, it's not my
> driver.
>

Guess I was looking into downstream vendor's kernel too much :) They
do a bit more things in this function -- like getting TLBs number and
"no block mode" capability; that's why I renamed it. Anyway, don't
have a strong opinion on this one, will use the old name in v2.

Thanks for the review!

> Thanks,
> Robin.
