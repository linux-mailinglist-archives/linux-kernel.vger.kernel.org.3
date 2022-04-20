Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E229508D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380836AbiDTQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380742AbiDTQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:47:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D776646668
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:44:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so4725620ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AfxWSlxIEICGSyTo5UTwMPZe6Q55PvAA0DKxMflvlU4=;
        b=nC9D+qQY6zO1b5+6ctalBsBld2Gklo1raloLX7LprQ0sz5ZMyJeK4iWk33WJIMlBys
         sWrGm3frGJHX0al+4QCmYIKE7/xB/nf2dHq34Kz/P8+KRaTi2tfXM3zPx31zCAO/b1Rx
         KsZ2TB/vy3W4s+buZh6s672JbmkLoKKCcRCzSZc7IaxWMIbQ8/G6krCr2AeARLmX0PBe
         SYuPncrqbw/hmoPenwsyTTApQEjuiClFf78tTK4ef20HmQPibh2pVeKqEKo9Ii8LvUcM
         aj/x9FkzcoYXASEDuyIQkrrZOcqOIfXVN9KydRiHmMBD6cNygUpxKXPQR8YkW0vJZwzS
         B+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AfxWSlxIEICGSyTo5UTwMPZe6Q55PvAA0DKxMflvlU4=;
        b=tS5JtQn6EZCO8j7/6KyNEqp+TurO5INJvLMFPqXukYsgFe0rNu4lLb47Sd93CNmD9A
         6Uiqst4SGczOeSFiLr3pSNF8kwxCUhbt5Zc3/Qy4uUkF1QYGJzHaJU1tcuSToj5mjTY2
         6WmquPtz87sn2v8HE8XYVivEEw875YNGImYRmLxSy++5kH5di9G1QveDwOCzzU0gDji7
         K4ewjgGK0jf0P5z7TSxCDyhMNTCHz1DAQp8IkxwSUy5ikno3ZcpiMv53+tcX9egGtDWg
         W5WdUDZpCp/THhAwQxpiExwAXEwehwY+q6q5O0mWLdat3SeCECortqsRmhFQ6roKPF8f
         lBkg==
X-Gm-Message-State: AOAM533H4Bxkm9ly5gn3eRFfW+XCWGhqfLwt70C/mgNZRgKWZ0Svn/pV
        Gc13boJuA32YQUl/T3292GGsrdeuh3KkFh8yXpzlyQ==
X-Google-Smtp-Source: ABdhPJyZtJ2OiQqRMqkArjaqQ1FeKnI5zVUYHqY6VjiqjAqVr53rH54QfeTBwC+gpwXOjHnNJhHpdYKW5AxpfxLyFmo=
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id
 nb10-20020a1709071c8a00b006e92a0dd7b7mr19095476ejc.572.1650473083179; Wed, 20
 Apr 2022 09:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-2-tongtiangen@huawei.com> <1671baf7-046e-7c52-183f-fd654125fd67@arm.com>
 <c376877e-53a7-d471-61bc-e7f9dd400d60@huawei.com>
In-Reply-To: <c376877e-53a7-d471-61bc-e7f9dd400d60@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Apr 2022 12:44:07 -0400
Message-ID: <CA+CK2bCF=7mADB=rxyHtVEd3oCZ4mxtKf=28L49uQr5oxUwYZQ@mail.gmail.com>
Subject: Re: [PATCH -next v4 1/4] mm: page_table_check: move
 pxx_user_accessible_page into x86
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 2:45 AM Tong Tiangen <tongtiangen@huawei.com> wrote=
:
>
>
>
> =E5=9C=A8 2022/4/19 17:29, Anshuman Khandual =E5=86=99=E9=81=93:
> >
> >
> > On 4/18/22 09:14, Tong Tiangen wrote:
> >> --- a/mm/page_table_check.c
> >> +++ b/mm/page_table_check.c
> >> @@ -10,6 +10,14 @@
> >>   #undef pr_fmt
> >>   #define pr_fmt(fmt)        "page_table_check: " fmt
> >>
> >> +#ifndef PMD_PAGE_SIZE
> >> +#define PMD_PAGE_SIZE       PMD_SIZE
> >> +#endif
> >> +
> >> +#ifndef PUD_PAGE_SIZE
> >> +#define PUD_PAGE_SIZE       PUD_SIZE
> >> +#endif
> >
> > Why cannot PMD_SIZE/PUD_SIZE be used on every platform instead ? What i=
s the
> > need for using PUD_PAGE_SIZE/PMD_PAGE_SIZE ? Are they different on x86 =
?
> > .
>
> Hi, Pasha=EF=BC=9A
> I checked the definitions of PMD_SIZE/PUD_SIZE and
> PUD_PAGE_SIZE/PMD_PAGE_SIZE in x86 architecture and their use outside
> the architecture(eg: in mm/, all used PMD_SIZE/PUD_SIZE), Would it be
> better to use a unified PMD_SIZE/PUD_SIZE here?

Hi Tong,

Yes, it makes sense to use PMD_SIZE/PUD_SIZE instead of
PUD_PAGE_SIZE/PMD_PAGE_SIZE in page_table_check to be inline with the
rest of the mm/

Pasha

>
> Thanks,
> Tong.
