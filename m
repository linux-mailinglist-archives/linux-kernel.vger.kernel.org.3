Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8137A50A419
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389818AbiDUPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiDUPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:31:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BC633A32
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:29:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g13so10826301ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrA9XZmQJ3pzwkzftPloH2yboFwnXRie+CWHLphliSk=;
        b=Goof91mBcka2VgETshL668shaAzHbdRfpyNvrN5YOcp4rhboXwZMtZDVAaWyLyahuQ
         CdaDmp2jWbyV5OJCLb9mFBtn8VUpNhEqnHvKmW2rmbiU81mufV28MWCU1u7VvAeUZEd9
         2u4xZXMNL1TOKfntRmdjyFc8vFUQU+K2rPooY6bMN8zqt91QKzhS2BhSAUFJld7m2EPZ
         SNq/Kb9bmfpSLvL0klMqmIih/kL/HnekghPnIjYHA8OSyGeGTmeuiE0Bbf9JhAQLARJc
         zOgCs57NF6H9sId258Pbwyy2EVsOsG9tO9VANSYUVqeN94X01agrIHg1uGNe6d7B1uaw
         /r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrA9XZmQJ3pzwkzftPloH2yboFwnXRie+CWHLphliSk=;
        b=3Hso6HsuJivqde92DQkHjfhPnJ/O2iscZ+2GCaCKs8o/7bMGrYPIQqJILBHh8DOBv0
         trSr4iswK2nYbQHk8thqlN2Y4aku0rKBdjlONK9E81eBfrXdPZwwATKKogqYkGjmt+tF
         VpKyx/OCeRpDxLEOIp3vUvB4EYMgki3LJfCWj1978sYccOtjls9JagVRBw8PERHNERs4
         Mc9fflFjHrt9tME7NtJri1pwKB0npiTuHZrJoK234qJ+dFrXUlYjaSjO5qLczywmqRXc
         GNX4tdEXYHjJ1cLKstKy+kTQDR6sQFB/Si8VlkJwTxGJ4GryF2gp1DP64PkJnz0n0yQz
         KxJw==
X-Gm-Message-State: AOAM532d2ZnpXZREZztFMpVjQhVBziLlWcTIiBAmor1fDfMSQnCRE6Jh
        nIg3dkFy6ZIClb7rQTRN++o4SmRlls34mZm0qLK4Pw==
X-Google-Smtp-Source: ABdhPJwdgR44vtT8cq3DFzLTy4Q7GdhPWMlulCx49QBzEtRNAYLnPLMlOP09qRIzOTf6f3uQrAGXR9/c5PPBDTovPvs=
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id
 nb10-20020a1709071c8a00b006e92a0dd7b7mr85739ejc.572.1650554944449; Thu, 21
 Apr 2022 08:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220421082042.1167967-1-tongtiangen@huawei.com> <20220421082042.1167967-2-tongtiangen@huawei.com>
In-Reply-To: <20220421082042.1167967-2-tongtiangen@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 21 Apr 2022 11:28:27 -0400
Message-ID: <CA+CK2bCWRL_vXW1BUhxb-zLiywXTCQdaa+9feEwQytYW=K46-g@mail.gmail.com>
Subject: Re: [PATCH -next v5 1/5] mm: page_table_check: using PxD_SIZE instead
 of PxD_PAGE_SIZE
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 4:02 AM Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> Macro PUD_SIZE/PMD_SIZE is more general in various architectures. Using
> PUD_SIZE/PMD_SIZE instead of PUD_PAGE_SIZE/PMD_PAGE_SIZE can better
> support page table check in architectures other than x86 and it is no
> functional impact on x86.
>
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
