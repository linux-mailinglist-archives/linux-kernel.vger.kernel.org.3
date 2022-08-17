Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477D959776D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiHQUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiHQUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:07:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4AA6C11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:07:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bs25so17434347wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=B62d/4sJXmri44gHYwQ72W46oaIsl+XdBEnlOkM1PHU=;
        b=JCGzxJkhrzEuo9lQLIBPfriafnUTtMKhcXyomBG1zeRPPUlTkwDKY5JRBY+EDYavmF
         BsdQGNi8C55VRRp77LZ8wlt4703ixan9kmNazqozc+kwPgnT8zB4aPQ051E6JW9XP2RI
         NHUCTUehoNye9Lg8oIapURtqtL5zok3j3zJ5bip5b5e7iW8FXqtoXRwoi7cwkJkMEDl8
         /aBf00PGTBcXpy0j6P8J1vs//QIOKYOSMSfBM1qxzYvJP9xzTg0Opow4VDXIRmeHgDNB
         7ZQ5Hrr5PmhpnYcZBqHOh3nkar8K4lT548wgQS5ScJd1/z0T8tFiNSDIUoEYgf6o9+5O
         udIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=B62d/4sJXmri44gHYwQ72W46oaIsl+XdBEnlOkM1PHU=;
        b=wz++lYsssTe6OZEfrh4qzjoHQNSkhrzqO/aX2PGNhHleVKjVApAjI27u7GTDiKEZTu
         A5nBYa/ZnxuvzMAoFZyRaigqALEY8KR0sx8ZPS/vVp2INSMbBZ64Zu9AUKMG3WKAR1kG
         CmOLLPBIPvWWL2tFFyMldEebQY7z5ec8LB7IVBi/jGuvS6ATme348w0NEaL1MnG4K8lZ
         94vn05QCN4WP0lzcQxkEqTN0LwnSkcDWgy9Cu5UlbkosRzFb41I0YKOoszJZ2viY5Twz
         6YcF29q7t7Lwk3P45FG17xuyrecX5ys+EEbSUtYYtt+TAyOpHNVOc816Zp07wFFPdoZ1
         uCOA==
X-Gm-Message-State: ACgBeo2XjpvU4pczZXF4Q0GKYvYDK8d8CoFLy6s+W1DMDAdedWexZvGk
        j6y09WYB1gchJwxr+p7N9XRHiw==
X-Google-Smtp-Source: AA6agR7qoZmJnmLkrdfATQ1ZiPYo4Z3sqFiUIuZIK+EsCYgIyc4Zluwktxa718RJyfLz+JhYNmY+1Q==
X-Received: by 2002:a5d:47c6:0:b0:225:fd3:f0c0 with SMTP id o6-20020a5d47c6000000b002250fd3f0c0mr6828257wrc.308.1660766824704;
        Wed, 17 Aug 2022 13:07:04 -0700 (PDT)
Received: from [192.168.2.222] ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id q6-20020a1ce906000000b003a342933727sm3106958wmc.3.2022.08.17.13.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 13:07:04 -0700 (PDT)
Message-ID: <9a4eabe8-6fcf-f146-7803-3f8e0fcb29e9@conchuod.ie>
Date:   Wed, 17 Aug 2022 21:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/4] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org
References: <20220817200531.988850-1-mail@conchuod.ie>
 <20220817200531.988850-6-mail@conchuod.ie>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220817200531.988850-6-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please also ignore this series, I accidentally had too much in the folder.

On 17/08/2022 21:05, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The device trees produced automatically for the virt and spike machines
> fail dt-validate on several grounds. Some of these need to be fixed in
> the linux kernel's dt-bindings, but others are caused by bugs in QEMU.
> 
> Patches been sent that fix the QEMU issues [0], but a couple of them
> need to be fixed in the kernel's dt-bindings. The first patches add
> compatibles for "riscv,{clint,plic}0" which are present in drivers and
> the auto generated QEMU dtbs. The final patch should be ignored for all
> serious purposes unless you want to wash your eyes out afterwards, but
> JIC the versioned extensions ever come up, it's there.
> 
> Thanks to Rob Herring for reporting these issues [1],
> Conor.
> 
> To reproduce the errors:
> ./build/qemu-system-riscv64 -nographic -machine virt,dumpdtb=qemu.dtb
> dt-validate -p /path/to/linux/kernel/Documentation/devicetree/bindings/processed-schema.json qemu.dtb
> (The processed schema needs to be generated first)
> 
> 0 - https://lore.kernel.org/linux-riscv/20220810184612.157317-1-mail@conchuod.ie/
> 1 - https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
> 
> Changes since v1:
> - drop the "legacy systems" bit from the binding descriptions
> - convert to a regex for the isa string
> 
> Conor Dooley (4):
>   dt-bindings: timer: sifive,clint: add legacy riscv compatible
>   dt-bindings: interrupt-controller: sifive,plic: add legacy riscv
>     compatible
>   dt-bindings: riscv: add new riscv,isa strings for emulators
>   dt-bindings: riscv: isa string bonus content
> 
>  .../sifive,plic-1.0.0.yaml                     |  5 +++++
>  .../devicetree/bindings/riscv/cpus.yaml        |  9 ++++++---
>  .../bindings/timer/sifive,clint.yaml           | 18 ++++++++++++------
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
