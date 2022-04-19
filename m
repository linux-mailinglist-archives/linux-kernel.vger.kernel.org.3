Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F401506D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348402AbiDSNWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351985AbiDSNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:22:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D1A2C8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:19:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y20so12721116eju.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWoWgEcXIMYRuEsZLERLpvc6D4fQ6dZb3dEHGDCcqIs=;
        b=fY6TQpn2KPv+1NlQy1Jow9T1OohAsjrB3oV9ppqNtHvd0r+4OW08v/avNwv1G8Odjm
         D/2GsdfYMSvjtxG1P4B7SzmR2XTR5xS2bZ0XXxMVMHNciSyV6R5MO6AkQwLdeFk1lHfh
         Cgt7v30oEPEsJbmsWTr9+ULhOcR1ribWin+0SWBgoc1mhBYRwOlMDx37E219LP/c8iur
         e8Jl67Cq3yYNgZHQHPlunLvMK0ujRMh0wPaA5jNKhTst45qBNw6ujFZl8BZe81KmcSAw
         S+BsJt8ItH1FzOurK6u7x4BM44CcrZpOkFaSvq0vaqehD0L+SUhwh2c75xAXXhRm0fg5
         rMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWoWgEcXIMYRuEsZLERLpvc6D4fQ6dZb3dEHGDCcqIs=;
        b=aNNiE/FORLQlhMkIDGZY4y/LTHsSblYVfC/3nShBSinZXKX81lYPH9XsMGp4HhZl74
         UZ6VjNHK2kPRlnOaHHIyJw+Hf73SgLGMSoyOXJoZY4uE7ktKFf+VSfsMgNBFHIpWNs38
         qSga/ReT6YvVvcLNou9U2ML3iVZVPNbGFcqlM+9ZEWAXF50eMWt7w84D13pYJG0TaXsy
         +wKFeL28IobQhMYX+QKM3GycH11U8pBdsTBHtc9z6NbmJntvj4wXwGq/iouqpVEp2bVJ
         qydm1Wbun3+hfpPlVYLASvuK1j3teMErk/f/+vJvhp2FrhiCKxE36ZR2viZydId2fLN4
         wBbA==
X-Gm-Message-State: AOAM533RilKWwmtPPSrlQDm32rFxP1nPLBvnZSeZnaS78Ad8HbDCKTxV
        Do7T8gQmIL/k0PV4cKzUK0cclXYQBD51Pf4ZVrEr5Q==
X-Google-Smtp-Source: ABdhPJwnqnEl1PogZpbrEzxXO0aXN+psYbjJRFm+NSGmxo/x2WJ/ZC6/8hzNHXDDrwtWHaCSyZ4gF5RFiYFl5n9G5cc=
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id
 nb10-20020a1709071c8a00b006e92a0dd7b7mr13404246ejc.572.1650374394669; Tue, 19
 Apr 2022 06:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-4-tongtiangen@huawei.com> <073cb6a6-3dbc-75d4-dbfe-a5299a6b0510@arm.com>
In-Reply-To: <073cb6a6-3dbc-75d4-dbfe-a5299a6b0510@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 19 Apr 2022 09:19:16 -0400
Message-ID: <CA+CK2bCPrQ=F0jNRxcVZ9f18Rm-kAATO3xFE79TZDoWQ99GC4Q@mail.gmail.com>
Subject: Re: [PATCH -next v4 3/4] arm64: mm: add support for page table check
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Tong Tiangen <tongtiangen@huawei.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 6:22 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
> On 4/18/22 09:14, Tong Tiangen wrote:
> > +#ifdef CONFIG_PAGE_TABLE_CHECK
> > +static inline bool pte_user_accessible_page(pte_t pte)
> > +{
> > +     return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
> > +}
> > +
> > +static inline bool pmd_user_accessible_page(pmd_t pmd)
> > +{
> > +     return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> > +}
> > +
> > +static inline bool pud_user_accessible_page(pud_t pud)
> > +{
> > +     return pud_present(pud) && pud_user(pud);
> > +}
> > +#endif
> Wondering why check for these page table entry states when init_mm
> has already being excluded ? Should not user page tables be checked
> for in entirety for all updates ? what is the rationale for filtering
> out only pxx_user_access_page entries ?

The point is to prevent false sharing and memory corruption issues.
The idea of PTC to be simple and relatively independent  from the MM
state machine that catches invalid page sharing. I.e. if an R/W anon
page is accessible by user land, that page can never be mapped into
another process (internally shared anons are treated as named
mappings).

Therefore, we try not to rely on MM states, and ensure that when a
page-table entry is accessible by user it meets the required
assumptions: no false sharing, etc.

For example, one bug that was caught with PTC was where a driver on an
unload would put memory on a freelist but memory is still mapped in
user page table.

Pasha
