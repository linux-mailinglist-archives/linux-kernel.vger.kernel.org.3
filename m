Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746AA4E5799
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiCWRg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbiCWRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:36:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B25793BC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:34:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id yy13so4334955ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSwzHlwSz23lvNtLo13bFAIrxFRCXX53K/CMQWwbRmc=;
        b=eho+7tpnDRTL+44l04LLUo+wv1fUtZvszL0rupuFXL6S5K4e00IplNblrGZ2/VchBC
         gAMGRJMGn7oXIS+0Yoye69b87Qa71Wn1Yzl+EcrdS3AUHzHmmj1cfTjhvNYalkB8vw3h
         6Pors1dQZGvTMTBn10VggfVLiF1jcfUjH9O/iDrPsa11zUyp46c9DPy735KBLmK0IEfL
         b13VH8xR90mm0/t93esJsccRYWVw9gVImdAQH+zw632De5CmgjTeLPtzVRD++RMILX3X
         dkWE4Wqg2XTF0Q4DrBzQSBuIrMJjjuugqAcpe1RhM6drRKWw/1WyP53oowoLbuAw8sQG
         viHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSwzHlwSz23lvNtLo13bFAIrxFRCXX53K/CMQWwbRmc=;
        b=H1cBGCl6TI9L/XNBYc9xtaye266Ap2KfI1yFA5RceB0XZdgmsx8JslQ6CHvdfVCRrP
         dITe58DHd8toKl2uOMoCPJtC9UyPnPUWXwXWjGskI9VzYfZVgenxx0UfcE+LJBR3HssM
         xBYUdUSWb8QYAcmNM3mwLYaU/vRD3tKYxkQlxkmIppkW7x/CsRVWK+UEWxFhixlkKrha
         ko6fysiYGEXhOuWe12vi4aO0ZBvSge+AtEJptgM+Js/4kx0OSwcdRFjQQDV0TtD1+Yem
         sirheFZ17pKvXK0WDDBp8YqcLesnH03cb8lC5q7ejEM5bXNPQSzHa/E7yEJYf0WlnF3S
         NQvw==
X-Gm-Message-State: AOAM533y67vykYaYYS0K+E7gC60OfhSgcA6uyj50TsRbbzdIm3Qogetn
        Km2SzyfnX+mAU+nbD/Y+Vw2y0Ah9o39UTJzA+rfhnA==
X-Google-Smtp-Source: ABdhPJwz8c++mc+m2Cqc/41NOOuHOiA6+RTyfPiOBMGZtngJZJD0Xv8B5WGZ85z3FwLIjo9C7ItQfgASkZAORNo6RGw=
X-Received: by 2002:a17:906:4a96:b0:6c5:5ea9:5366 with SMTP id
 x22-20020a1709064a9600b006c55ea95366mr1199621eju.473.1648056891284; Wed, 23
 Mar 2022 10:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220322144447.3563146-1-tongtiangen@huawei.com> <20220322144447.3563146-2-tongtiangen@huawei.com>
In-Reply-To: <20220322144447.3563146-2-tongtiangen@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 23 Mar 2022 13:34:14 -0400
Message-ID: <CA+CK2bAPiMbdv441+B+_4aGyPeAgyyaZ=n5ni3WgfyDP3bEADA@mail.gmail.com>
Subject: Re: [PATCH -next v2 1/4] mm: page_table_check: move
 pxx_user_accessible_page into x86
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        linux-riscv@lists.infradead.org
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

On Tue, Mar 22, 2022 at 10:25 AM Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> The pxx_user_accessible_page() check the PTE bit, it's
> architecture-specific code, move them into x86's pgtable.h,
> also add default PMD/PUD_PAGE_SIZE definition, it's prepare
> for support page table check feature on new architecture.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thank you for this work!
