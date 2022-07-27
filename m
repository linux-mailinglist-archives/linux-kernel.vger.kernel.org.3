Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4000582106
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiG0HZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiG0HZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:25:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231DD3E75C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:25:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b11so29914402eju.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rydDqlFJvbn5JuZDSQ+fXBnsGfZJlblYwnY24ftaijo=;
        b=E+qTzrBWSrgHjQRguRQQdvlNKWssv6zsmDgh33eijxuIPtJRHibCfgdaeFR71FqghW
         38YRPWmQ4EjiiKd+dbY4W5rNW52QKyxNv227fhUNR8AaPik/PUfwVwivkKPKG8rgrYrL
         Xv20fgwOtbto9sx7cnvnFC/yHAgLvlvkbELc4gajxdtqHPCaajA/MxpiaMR5iB0cUAgb
         q9dsM/bIs13WbIEEQiO1a73RC7mBL69301FVhw03jFILZKYXMpL2J/OsBZsyYe6xSbut
         qu8LtSqWNcDaRuEDyT+Y9+H5V+b5UGOXEqk7107xwG8uymYj+8GaNFIM5XCyW+7p3vkk
         maog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rydDqlFJvbn5JuZDSQ+fXBnsGfZJlblYwnY24ftaijo=;
        b=hPD5F8iiFoBkewCQo9aHHURtHoATbaLV7sgej7+8UozzkIigW6nzkUF7kM9Zj7Q2Mu
         0paCenGOKrrbuM7igF79W7uPTeKn8Szc9eLIVEBk+SovOQ/4dYKJMfU48BHmlCoSR+KS
         LOiy2uFYNdTl4NidlW9Ssetz6MHIpuqjd6dqZjAyibawiPIWmsr+ytlrWCNXZCEsEO0B
         vQjyRWr+NcCPFhMjfr7btJrxailDZJsCDYIabvCk6t/iwC9Q1n3m65mhy0ZxaGpUWw/Z
         Ck7nsnWJtRlDimWITTZy6wlnXCJdtmrTZsxtMmeuNqZTGGPJ8RudhFbSnB5XpGNBrjHr
         ZrCg==
X-Gm-Message-State: AJIora/rTpX9Ch2Q34kFzKp08xFUL1IwwGNy690Aj9V+XyBmDI+R83H6
        OvKFhcLyCyVgMmxhlBswAParoriU3M+0m6sUicht0w==
X-Google-Smtp-Source: AGRyM1vxmco3aYUjfYxZjr+kwVOiRBIVmMeZhZUY4wsw3ERIYrSEPbtpbvKETSkTS/aUQ66bA/Tt85bh1Np0KmYc9oc=
X-Received: by 2002:a17:906:2ed7:b0:72f:d080:411 with SMTP id
 s23-20020a1709062ed700b0072fd0800411mr12069816eji.203.1658906729603; Wed, 27
 Jul 2022 00:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220727040022.139387-1-lihuafei1@huawei.com> <20220727040022.139387-5-lihuafei1@huawei.com>
In-Reply-To: <20220727040022.139387-5-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Jul 2022 09:25:18 +0200
Message-ID: <CACRpkdbu8M84s2rPsKTwMmMXeeYEmNVaXFnp1hsKM0Dc9jzNfw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 6:03 AM Li Huafei <lihuafei1@huawei.com> wrote:

> Historically architectures have had duplicated code in their stack trace
> implementations for filtering what gets traced. In order to avoid this
> duplication some generic code has been provided using a new interface
> arch_stack_walk(), enabled by selecting ARCH_STACKWALK in Kconfig, which
> factors all this out into the generic stack trace code. Convert ARM to
> use this common infrastructure.
>
> When initializing the stack frame of the current task, arm64 uses
> __builtin_frame_address(1) to initialize the frame pointer, skipping
> arch_stack_walk(), see the commit c607ab4f916d ("arm64: stacktrace:
> don't trace arch_ stack_walk()"). Since __builtin_frame_address(1) does
> not work on ARM, unwind_frame() is used to unwind the stack one layer
> forward before calling walk_stackframe().
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
