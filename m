Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B194E5885
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbiCWSh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344096AbiCWShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:37:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75B8933B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:35:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o10so4660690ejd.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tK9niD9zkQNKvxp511CYkJeHeDOwwCyGPfpIMRzpbn8=;
        b=ILnVSpcvcMvyYeY4ROSboPGgS/ta0E1CBAGTw7IUPxpVOCKagtB2L6w4QyfvColzts
         lKoTTSAc3A59SaIQTrXgzUbBbPhDY+NCo+0THzukfmHGxObAO+MTE33aiSbzLaylxIR5
         vu3hdy/bc4BJMa2tF3nPWOM9mpVJRd5WMaZWC3ZxPK7t7PJ+kUHzdIPzkXeIYmbpy4iE
         WPKmOMjscxczUZmAkqdVQZvSP+uk9oWRXLbENpPVazMvVKH4AnAipdRqWqKxBI1AJP0c
         Hmsm2+SzQmRxOwEJr544YYtaT9z5K1U6741acmsivUDCh/MrQtFM6M+3sq7CDOm8e1vj
         gsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tK9niD9zkQNKvxp511CYkJeHeDOwwCyGPfpIMRzpbn8=;
        b=T2phTJO8RatG3IKtsSgPCdychcnvjAix6DHLt7/VDDUekF4w8ChJZEoG/m4UArg6R4
         jNvh/4sUfDWchvoLHftDfRvozXNqXOVb9krlGFPCzwdWnJPkKvBasjxlMDk3wBmBD1qX
         LpKp+AiEXGZPBwhlCuHwP+SldkADb03Q3mU4bYqsmBOK81NaL1BoiuqOoPIORULeh7OY
         iLtoHGL1L/bQ+C/KwdzG5GJsEG2/RBsP9u676qsVewxgemWHO3oquirUFTax+GE94c5I
         hYVKDnwYBYxozx54tjGzedlqQpQhB2CqHIdoi0klI8S/P5x0R4l3qGA5TADBp7LLP7MG
         lAHg==
X-Gm-Message-State: AOAM532XRtF7NOgOSCM/6nOCAN2N0TYoLESP7p4V8+suRVAJ1YqsMesG
        R4vCfn7MVrtJ8VYMt+Uqa8x3OiaucFEtUR6PKxDFtw==
X-Google-Smtp-Source: ABdhPJynp0FgSmnyck4PsURixg/OTxCJavw7joUGhNiXNB6NbDfppEQUPlJBg17McZnwMAATMWS5QwvimHiFUe6i1us=
X-Received: by 2002:a17:907:1c96:b0:6db:57e5:3e2f with SMTP id
 nb22-20020a1709071c9600b006db57e53e2fmr1506594ejc.705.1648060539244; Wed, 23
 Mar 2022 11:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220322144447.3563146-1-tongtiangen@huawei.com> <20220322144447.3563146-4-tongtiangen@huawei.com>
In-Reply-To: <20220322144447.3563146-4-tongtiangen@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 23 Mar 2022 14:35:02 -0400
Message-ID: <CA+CK2bC4oXrxUqG4K16+Qu9D=SBZcJSso+Fe3-8AFtuYOAeg0w@mail.gmail.com>
Subject: Re: [PATCH -next v2 3/4] arm64: mm: add support for page table check
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
> As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
> check"), add some necessary page table check hooks into routines that
> modify user page tables.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
