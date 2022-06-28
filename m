Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D4C55E464
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbiF1NVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346326AbiF1NVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E830835AAF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656422356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtr8/zsHx2lgXvXWLguSyb54C2tIRyCmz4eBKyNcZb0=;
        b=FanQX8fbKAboMUhwWZK6X5rjtORLcIMo9+N9BuYj415/quB7NPo1s6G8qlwhkzPUTbVFQz
        mCQ8oDaX8SYWNTB3GMW2CNhEfLHRkCkHSD+feFRf9RgglzlHLsPPZWvi6CszggkY/PXk3V
        ZfGByGtIswFMDbvwUNK+MciAK5dO/qs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-zZ6o1MKUNDSMQK_WKH0PCw-1; Tue, 28 Jun 2022 09:19:15 -0400
X-MC-Unique: zZ6o1MKUNDSMQK_WKH0PCw-1
Received: by mail-qv1-f71.google.com with SMTP id mz4-20020a0562142d0400b004726d99aa49so4955229qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qtr8/zsHx2lgXvXWLguSyb54C2tIRyCmz4eBKyNcZb0=;
        b=c/H7GL3k6lt7Parr4UWg7hA5hrJZCDcgkRbeMvKfIKno8uT4mWGSL48gp+hA2RzkdQ
         BxzZjzq0wGXVuRuiRTH+ELQI5nGIqX+JJhjIqwgOjMmNKzh+UUKVy50k9iim/soSkNvN
         tby4dhb7zEva0g1zASkdQsOVDctsW4q4nggAd7GXcqY/FBrbuhm9SoBglKR7DfYKWT6s
         176vhhuNQRIDhQF7nCbsCF0d3plKQeENWJL58+Kd11R5kMu2273iU76CMMqnpUSpgFu+
         eSLEwz1m3gjGKJCU2A7TGN9eCA6hYZyVY/VWVUY84v7FsCXyZ26bT+aQsJZXJIBxih9L
         PWCA==
X-Gm-Message-State: AJIora9bOk6JADrsy8e1tSuQJKo7g74g6MKz9Q+hIopEWsJXnIOI3wcp
        W8ohiNMRybNzR3Su8guPIZRv/PPP6qL8cOsTxvMR0HiewbE1qzke7H4wyaZejiynBdgus/qNHIu
        qK3STWtKa2Ke+CoTXZ6n1fjtSNLzU+Ojs7gUVjmKPB1MZZIJVBqAJQ0LCpy+/RnxRUi1g7vc=
X-Received: by 2002:a05:620a:2629:b0:6ae:f26f:4a6f with SMTP id z41-20020a05620a262900b006aef26f4a6fmr11211907qko.525.1656422354185;
        Tue, 28 Jun 2022 06:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u6u3ElgI5SXkTszodT7+MkuzdhwyGAU7ALTb5+ws6xpB7rbXIdQWZhAuG2FGgMK9tgjL0AfQ==
X-Received: by 2002:a05:620a:2629:b0:6ae:f26f:4a6f with SMTP id z41-20020a05620a262900b006aef26f4a6fmr11211875qko.525.1656422353898;
        Tue, 28 Jun 2022 06:19:13 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id ay42-20020a05620a17aa00b006af3bc9c6bbsm3262520qkb.52.2022.06.28.06.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 06:19:13 -0700 (PDT)
Subject: Re: [PATCH 0/2] Enable clang tools for kernels build using gcc
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220628122741.93641-1-daniel.thompson@linaro.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0478d832-d902-69ed-7c1c-4f19d942cddf@redhat.com>
Date:   Tue, 28 Jun 2022 06:19:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220628122741.93641-1-daniel.thompson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The limitations of the compilation db are not limited to the kernel.

Why shouldn't the change be made in the llvm project ?

Tom

On 6/28/22 5:27 AM, Daniel Thompson wrote:
> This patch set makes it possible to use clang based tools, such as
> the clangd completion engine, regardless of our choice of compiler
> for the actual kernel build.
>
> Most of the fine details are included in the patch header for the
> first patch (since we'd like them to appear in the kernel history so
> they can help future archaeologists).
>
> Daniel Thompson (2):
>    clang-tools: Generate clang compatible output even with gcc builds
>    Makefile: Enable clang-tidy and clang-analyzer for gcc builds
>
>   Makefile                                    | 11 ++--
>   scripts/clang-tools/gen_compile_commands.py | 71 ++++++++++++++++++++-
>   2 files changed, 74 insertions(+), 8 deletions(-)
>
>
> base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
> --
> 2.35.1
>

