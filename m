Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F1A4E8BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiC1BtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiC1BtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:49:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A1B4FC58
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:47:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p15so25632354ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZZ3p7IrHQhC+IOfUXwoClwM84pWBM5gqGoXaIupHHM=;
        b=nwP8zWrnITLyb5BsAoRxPGj1QczX8ieAYG0mpE3CqWZuNHoLvJONkgBjw24eQ7uZnk
         mtn0Ej7nrBLIxFK2rTfldm2vmuXW8Q3PF7cnnJTTSziU8fGhaWqiLP/QBIRRZUoLgyL0
         nw1SemxX8ResM21+czAeWEy2jcpCQInCUNzViuqCSdTfFKTDhfGBNYrSckX3t97++RfZ
         2s4ntOWnmhCBO2O+d/22VDEZ3Fv3zHDT+oi+0J+74YYJwcn5/A7+i5ZnH7hGMki4FGiK
         LRbK5M0FM0MzIQ2R36V3XYv1NWbJCBnf3asp+jDsWHFXxVfmlc0bUa/950+95foy9QA3
         NK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZZ3p7IrHQhC+IOfUXwoClwM84pWBM5gqGoXaIupHHM=;
        b=5o1AxyRl4KvtghHjowf0KkyT0sqYeOhUHHl6oleKebYFpIpp8U25K7CGLsluWG7bDO
         TFAZ/avPowB4tUvZRLUnjjnKpLnF3xKqL0AddVQBQRerX37GZRJUUg6k++nTVm9s6M30
         4kFs+YsGrEuTUSg5PratUJfi3EUbOy20AolpFQHNtMXN8w2c1qALwBpQWCjPUf9EVhyI
         n8riQ+/qrR2Kre7zEs4ph9XWH4r+DQvN5OFQRzjzZAMrbEOhcxrC++bVS56L7lkd3PJp
         Vwb8njy5rSYW1JAdJtsn/l9UuapfLmykLmimuqrmdG+t9JVv0zLdTKer1jX2iL/wAyua
         9AuA==
X-Gm-Message-State: AOAM532+40iCoUEwm4UePdajj35L0bY55XYlCLBFwlbBUtniEW+Uzq6B
        Nzf4QXVRWuUj18FQ6w4eaSA0a7XJL43X9+gAbrDDMA==
X-Google-Smtp-Source: ABdhPJyoEPMTr2WZSucqjP6xJ3oXCNNikK1sAH6HQxOe9SZ1jL6JPJk0y3ucgungcXT2oiKXBzz2VE4T1XgwUFqSBVc=
X-Received: by 2002:a17:907:1ca6:b0:6e0:94d2:fcc9 with SMTP id
 nb38-20020a1709071ca600b006e094d2fcc9mr18799193ejc.473.1648432061846; Sun, 27
 Mar 2022 18:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220328015242.1136836-1-tongtiangen@huawei.com> <20220328015242.1136836-3-tongtiangen@huawei.com>
In-Reply-To: <20220328015242.1136836-3-tongtiangen@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Sun, 27 Mar 2022 21:47:03 -0400
Message-ID: <CA+CK2bBbPaK2N91HPp=3ON8TKc9rTg7wt928dTsjTg1qzGAz0w@mail.gmail.com>
Subject: Re: [PATCH -next v3 2/4] mm: page_table_check: add hooks to public helpers
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

On Sun, Mar 27, 2022 at 9:34 PM Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> Move ptep_clear() to the include/linux/pgtable.h and add page table check
> relate hooks to some helpers, it's prepare for support page table check
> feature on new architecture.
>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
