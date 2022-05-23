Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF79530B69
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiEWIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiEWIYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:24:39 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E9D62EB
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:24:36 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2fffcc66fe2so13596157b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1l8F8G/4aBFXvrvpU3F8ABVJ/BAoPux/2EGliQHK9E=;
        b=kizfswkQ/MUhIu/fM+C6HlyJDTesukV5aFMyl6P4uRqJLlBTN3QiLsCxhlIZL7wyS0
         JkGGcpTYZbHmGcO+0cPOQIXjFLf822qePB0TwRBaU/Z0y1sRevQa9Yr6qfGbHoVrV4fI
         VbfvIRINQ4rAlewFBYrLT3I9mtk3cFZWFTP0vXREoEJSo0tbwTXK/zsCNoGpmGBML6rJ
         tIrXmSzYvB6+mF3MkzGQL0RqsAFpKlt04+FLfxkRgRrWT2LKhaooRylXi+i4DNHnEug+
         TV+gXG8+laxpjqEtamxbsi4Q/vBL0ND2hsEua51y+XpaFol99qPY3s4kEyacRNPVmahA
         YSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1l8F8G/4aBFXvrvpU3F8ABVJ/BAoPux/2EGliQHK9E=;
        b=TeqEfpO09uS8lRuUuQV+WBKtYEhF+oB3h0z11E4R8abpXMsUH66bIUcMOzG1FuB2lY
         HeYnoIEor62homX3MU7d6l+BPTP3jaBzAdiPY1ujkkL+fx+12HikNs5yjFbcsXgQJ3aO
         DpPeD7e9GG64YZPPwJlE964XjguGaM4667QLgM7kG2G12YMkJB87dGai8UArhbkMRbiY
         9mO6t5vhrF6HIM2g9hlVel6xQNUUPPuoCIhCQEY7hPMGlW3/N5zqtJEcfJhngSgl4ngx
         tUO2R9b8BTxc1p9b7XV/va2q7fXVaarv3ONGTxC+WhsFhJEGYC6ni5NiNbcEKrz/tEDm
         MAWw==
X-Gm-Message-State: AOAM533d3gJcanojqsZoPjy2qPB/JdWkYSWaGWkKlvyM/Pp3q/2Av2Ex
        YobOtTpPGHa/0zMYxrZhXc1APgWsmWytxIjPJiKdig==
X-Google-Smtp-Source: ABdhPJx3U48zklgNqZHphc3Xt63U3bsbJLc7Pr5PXin48vh9cRHiJrnVrkio4VDqZUegppE5mkZYUJK2LtLbZXg18gI=
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr22494436ywg.316.1653294275634; Mon, 23
 May 2022 01:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020051.141460-1-wangkefeng.wang@huawei.com> <20220523020051.141460-3-wangkefeng.wang@huawei.com>
In-Reply-To: <20220523020051.141460-3-wangkefeng.wang@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 23 May 2022 10:23:59 +0200
Message-ID: <CANpmjNO=KKum3OcdwoDCf2hiCRW+Nr9tYuPyBCN+VmzAO7UR4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: kcsan: Support detecting more missing
 memory barriers
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 at 03:50, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> As "kcsan: Support detecting a subset of missing memory barriers"[1]
> introduced KCSAN_STRICT/KCSAN_WEAK_MEMORY which make kcsan detects
> more missing memory barrier, but arm64 don't have KCSAN instrumentation
> for barriers, so the new selftest test_barrier() and test cases for
> memory barrier instrumentation in kcsan_test module will fail, even
> panic on selftest.
>
> Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
> defined the final instrumented version of these barriers, which will
> fix the above issues.
>
> Note, barrier instrumentation can be disabled via __no_kcsan with
> appropriate compiler-support (and not just with objtool help), see
> commit bd3d5bd1a0ad ("kcsan: Support WEAK_MEMORY with Clang where
> no objtool support exists"), it adds disable_sanitizer_instrumentation
> to __no_kcsan attribute for Clang which will remove all sanitizer
> instrumentation fully (with Clang 14.0). Meanwhile, GCC does the
> same thing with no_sanitize.
>
> [1] https://lore.kernel.org/linux-mm/20211130114433.2580590-1-elver@google.com/
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  arch/arm64/include/asm/barrier.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 9f3e2c3d2ca0..2cfc4245d2e2 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -50,13 +50,13 @@
>  #define pmr_sync()     do {} while (0)
>  #endif
>
> -#define mb()           dsb(sy)
> -#define rmb()          dsb(ld)
> -#define wmb()          dsb(st)
> +#define __mb()         dsb(sy)
> +#define __rmb()                dsb(ld)
> +#define __wmb()                dsb(st)
>
> -#define dma_mb()       dmb(osh)
> -#define dma_rmb()      dmb(oshld)
> -#define dma_wmb()      dmb(oshst)
> +#define __dma_mb()     dmb(osh)
> +#define __dma_rmb()    dmb(oshld)
> +#define __dma_wmb()    dmb(oshst)
>
>  #define io_stop_wc()   dgh()
>
> --
> 2.35.3
>
