Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD11856D106
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiGJTNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGJTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:13:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF314D0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 12:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61352CE0EB9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 19:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B2FC341D2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 19:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657480405;
        bh=3hkmLeoPA94cguxwWVvXXxv3VcnHAir/c52ak4ViFbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ShhJs+CwJ0mATbKIljdmTB0BEj4Xh/8n7CNhzbStAtyoTJMmi8fD1azjRYNy8VmnY
         5//BNxPQA2fYCY3AWQyLWV4os77A8LuA7JhDC5bWRJmAm8PuQk3ygJ9i/u9nmRLCjB
         XnTbIFtVLLCl/snNNALgf3PTmLgwV7rVdNWXvZJIUrJb7ZVNH/ttX0U8fxv9a2dS0A
         sJ4JslvKrnfcScwn995fBK0o+ZgfOTXShwmEcT60mCwhs++Bgy4PM8J8P3qlv8ePTn
         9d3V8jAUMzx0PQTOLRuF8oNQ21AxD0JXL52iwnGEHZ7AOXlRIFvIIuvgwq+2uSQsIU
         f6TDGpXuzyyuA==
Received: by mail-yb1-f180.google.com with SMTP id h62so3032201ybb.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 12:13:25 -0700 (PDT)
X-Gm-Message-State: AJIora/aduvDz/TfExBbnz7nCLPI6E0FDug5J4TOApgedCsVPS9DnNuW
        kAV1y4MAGb5DM6VIDIxMQZV/OCQUN44LWfoJ5Jk=
X-Google-Smtp-Source: AGRyM1v1+pbuX33zfo/UTqTwqWe49lEPj5DVrFrYna2ZGAzjmIVOdIfpTz0xQRfFfS93XK23Rrs6t1nulIoluusPsxU=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr14394151ybq.472.1657480404689; Sun, 10
 Jul 2022 12:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220708231520.3958391-1-ndesaulniers@google.com>
In-Reply-To: <20220708231520.3958391-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 10 Jul 2022 21:13:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0x2KJuCjupKuj6XAYUAeF47ZV4bWuEGUQFOcOK_Do2jA@mail.gmail.com>
Message-ID: <CAK8P3a0x2KJuCjupKuj6XAYUAeF47ZV4bWuEGUQFOcOK_Do2jA@mail.gmail.com>
Subject: Re: [PATCH v6] coresight: etm4x: avoid build failure with unrolled loops
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 9, 2022 at 1:15 AM Nick Desaulniers <ndesaulniers@google.com> wrote:

>         ({                                                                      \
>                 u64 __val;                                                      \
>                                                                                 \
> -               if (__builtin_constant_p((offset)))                             \
> +               if (__is_constexpr((offset)))                                   \
>                         __val = read_etm4x_sysreg_const_offset((offset));       \
>                 else                                                            \
>                         __val = etm4x_sysreg_read((offset), true, (_64bit));    \
>

This is clearly better than the current version using
__builtin_constant_p(), but
I don't think it's safe in all cases, since there are expressions that
are constant
expressions to the compiler but are not valid input to the assembler.

I would prefer to see this fixed differently, but doing this one first is also
fine with me:

Acked-by: Arnd Bergmann <arnd@arndb.de>

        Arnd
