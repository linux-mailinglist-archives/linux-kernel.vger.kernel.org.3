Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0815977A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbiHQUQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHQUQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:16:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813751A00
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:16:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a7so26503423ejp.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Q8l7owka14u7MGvMmnutbIDuZcppj3Zne6ItQTkKbfM=;
        b=H0fEhAQn4l5fNZh5PguleIFVYcgHWRiXQ4CHZKQ7sAvGgIAyPNZkHREO0i7ao8NEjn
         UI+0aY7DylpRGLdXVDkbb99XKNt9510ituuTMbWCV8q5M4u5Vpyqrgr4tis3sPdP1KcQ
         mLdscN0u+DG4jQudxuaGyzyxIFmjoO0O85sVudWrxONwpKgv20A+QDf/pEYEHHg2K42W
         ZmiPCpXBKZs2pBxPvaCRHaaL9HuQkOn651g0dzdtYuJ1LOb1o9GquYxou1W4NMvdga4v
         IFWRO8gGoeLn7CgLqo1w6Vc/xsKHeYoLyMGwVvrhS+ZARHLcWlklUGJna4I5kolbpJRs
         Oxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Q8l7owka14u7MGvMmnutbIDuZcppj3Zne6ItQTkKbfM=;
        b=x1BlT2BqYPJ09gigKL+M8AZ8d+TqHfcyvIY03MwArePBka3F3CpnURiW7WMP2IS1Ai
         wIxdFyOTyfjYGKk29AXpkMRRfS6SLF+6n/rg9abs7kVhoSBYO5JzzlM+TXD5HSBD5IWM
         LlN8RwCF1gvvZZyuc4fkoVLljvE0t8HG8NT0u3LJyGlytPPmR2LGVMVVjY3/37BoMCid
         PB0eo+MaeUfk/9cFw6Uw2oR2vZAhuUMHey9B649dpCekhl+QXwbziIRl0sSPqGHE1sGJ
         Bh+M6Sl7YcDmAJCpPwPWw0n6mryMtqv4oiU/5MSrf553PiTAP5D2wUq2fbwPPC19m1xW
         lIAA==
X-Gm-Message-State: ACgBeo13E9JZFlE6b5xNS2I4/QUmai51Y8NtmTvrMllspDbKXI/LpOfT
        MSV3zJBmsj98XhyEBInyXRwF7w==
X-Google-Smtp-Source: AA6agR7w7ynxTh5+3YZVnkSQkUG2igBkJmtypLwGJKdI8yT/kcScIXzf9Y0o98gC2OAY5JjeOiiprQ==
X-Received: by 2002:a17:907:1c1f:b0:739:17e2:209a with SMTP id nc31-20020a1709071c1f00b0073917e2209amr5606669ejc.320.1660767393763;
        Wed, 17 Aug 2022 13:16:33 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id k18-20020aa7c052000000b0043bbbaa323dsm11338908edo.0.2022.08.17.13.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:16:33 -0700 (PDT)
Date:   Wed, 17 Aug 2022 22:16:32 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: riscv: add new riscv,isa strings for
 emulators
Message-ID: <20220817201632.orjcqwu6bihgnnqd@kamzik>
References: <20220817200531.988850-1-mail@conchuod.ie>
 <20220817200531.988850-4-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817200531.988850-4-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 09:05:22PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The QEMU virt and spike machines currently export a riscv,isa string of
> "rv64imafdcsuh",
> 
> While the RISC-V foundation has been ratifying a bunch of extenstions
> etc, the kernel has remained relatively static with what hardware is
> supported - but the same is not true of QEMU. Using the virt machine
> and running dt-validate on the dumped dtb fails, partly due to the
> unexpected isa string.
> 
> Rather than enumerate the many many possbilities, change the pattern
> to a regex, with the following assumptions:
> - the single letter order is fixed & we don't care about things that
>   can't even do "ima"
> - the standard multi letter extensions are all in a "_z<foo>" format
>   where the first letter of <foo> is a valid single letter extension
> - _s & _h are used for supervisor and hyper visor extensions.
> - after the first two chars, a standard multi letter extension name
>   could be an english   word (ifencei anyone?) so it's not worth
>   restricting the charset
> - vendor ISA extensions begind with _x and have no charset restrictions
> - we don't care about an e extension from an OS pov
> - that attempting to validate the contents of the multiletter extensions
>   with dt-validate beyond the formatting is a futile, massively verbose
>   or unwieldy exercise at best.
> - ima are required
> 
> The following limitations also apply:
> - multi letter extension ordering is not enforced. dt-schema does not
>   appear to allow for named match groups, so the resulting regex would
>   be even more of a headache.
> - ditto for the numbered extensions.
> 
> Finally, add me as a maintainer of the binding so that when it breaks
> in the future, I can be held responsible!
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Palmer, feel free to drop the maintainer addition. I just mostly want
> to clean up my own mess on this when they decide to ratify more
> extensions & this comes back up again.
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index 873dd12f6e89..c0e0bc5dce04 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -9,6 +9,7 @@ title: RISC-V bindings for 'cpus' DT nodes
>  maintainers:
>    - Paul Walmsley <paul.walmsley@sifive.com>
>    - Palmer Dabbelt <palmer@sifive.com>
> +  - Conor Dooley <conor@kernel.org>
>  
>  description: |
>    This document uses some terminology common to the RISC-V community
> @@ -79,9 +80,7 @@ properties:
>        insensitive, letters in the riscv,isa string must be all
>        lowercase to simplify parsing.
>      $ref: "/schemas/types.yaml#/definitions/string"
> -    enum:
> -      - rv64imac
> -      - rv64imafdc
> +    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:(?:_[zsh][imafdqcbvksh]|_x)(?:[a-z])+)*$
>  
>    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
>    timebase-frequency: false
> -- 
> 2.37.1
>

I'd say "looks good to me", but it's a regex, so "good" is a strong word.
Instead, here's a [somewhat tentative]

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
