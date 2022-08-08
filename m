Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A1458CFBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbiHHVeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiHHVec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:34:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF741B792
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:34:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n4so10515243wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=9kRHsgOgJ6PrAYABPQZo5fFEimmGDPOkqaNSMbcJVyc=;
        b=TYEiGXwYdSs4KSceoUw0CONgMh/BCvSsIAkhexa4o4d8X0/H14uel438GJ7mB39Q0O
         IE1q8hV2gxxGTpP8sXz39FaGlVNq0vre28mLKsTHR71YmHlycqTUxLWbMDvW8G9zA1kV
         aIcKAijN6Zne3pHprutjgeaZzPmEvNOOU/9mPkehxyznxeoFODtYxiK/b2/16Cayl1VM
         rTq2CSDmDw/x9K20038uoWnRahYX9u1Vnd/MNldNaqz17kK9epaesrnTJrVd7N5gemCz
         Xg8i4j+c8J0AhUsr6FCPhlytlOXTxD48x+cdFRPhrYN6g7snYKStSUeycdlW4nfYRVVg
         vyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9kRHsgOgJ6PrAYABPQZo5fFEimmGDPOkqaNSMbcJVyc=;
        b=Kzzkn1KaLYf0L0ta6CyDG0SplxFaQm4COKtc15ViX4CAzfthhtg3k/n7t3xgijYGq7
         eACjG6alOiMFrEqoEB3WRz0FO7DuFD/7IxqSlFmew2xf0oQeRg4NbzoKOBosAa4uVNBF
         qK9E+k9Fl9eh+jAk8F1WlLll4n6tM3DVTY+G7YaaB1ZOKBIMy6JXpau05lYO684y8nxt
         H3KqUL1Dxenszm9QWs2gaB3k6gFCUakSUu9pQ2wO2W85ddrFQd1qx0Nyv0vpcZkZCe7G
         QFXDfoQtgTIvBBUevgE00aJEtC8b5fCIclrqvQUn/re+hz1OgQKIviUKBUM1o/jFPd3M
         b7Vw==
X-Gm-Message-State: ACgBeo1UWb24XRt3zR7VroWa7HlsjYCQa8Oda1fDDmk4c5Av8o3IB7c8
        1e4SobVTTir6hVvGmTuebXMrZQ==
X-Google-Smtp-Source: AA6agR5mFLBH7jdSMh6Rb2K0gPj3kWj9UbS6iuvGWq1LcSMGI6UaYFSJLp5u4ZP4z0ZR67q8PSvObQ==
X-Received: by 2002:a05:6000:235:b0:220:3a22:fe38 with SMTP id l21-20020a056000023500b002203a22fe38mr12675264wrz.419.1659994465738;
        Mon, 08 Aug 2022 14:34:25 -0700 (PDT)
Received: from Jessicas-MacBook-Pro.localdomain (global-5-141.n-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003a4eea0aa48sm15541146wmq.0.2022.08.08.14.34.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Aug 2022 14:34:25 -0700 (PDT)
Received: by Jessicas-MacBook-Pro.localdomain (Postfix, from userid 501)
        id B48C929DB6B6; Mon,  8 Aug 2022 22:34:24 +0100 (BST)
Date:   Mon, 8 Aug 2022 22:34:24 +0100
From:   Jessica Clarke <jrtc27@jrtc27.com>
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Message-ID: <YvGBYKZyW0B2/wSr@Jessicas-MacBook-Pro>
References: <20220805162844.1554247-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805162844.1554247-1-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:28:42PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The device trees produced automatically for the virt and spike machines
> fail dt-validate on several grounds. Some of these need to be fixed in
> the linux kernel's dt-bindings, but others are caused by bugs in QEMU.
> 
> Patches been sent that fix the QEMU issues [0], but a couple of them
> need to be fixed in the kernel's dt-bindings. The first patches add
> compatibles for "riscv,{clint,plic}0" which are present in drivers and
> the auto generated QEMU dtbs.

IMO the correct thing is to have QEMU use a qemu,plicX rather than to
weaken the requirement that a non-generic compatible be used. Otherwise
you end up with QEMU using something that's marked as deprecated and
either the warning remains and annoys people still or it becomes too
weak and people ignore it when creating real hardware.

> The final patch adds some new ISA strings
> which needs scruitiny from someone with more knowledge about what ISA
> extension strings should be reported in a dt than I have.

Listing every possible ISA string supported by the Linux kernel really
is not going to scale...

Jess

> Thanks to Rob Herring for reporting these issues [1],
> Conor.
> 
> To reproduce the errors:
> ./build/qemu-system-riscv64 -nographic -machine virt,dumpdtb=qemu.dtb
> dt-validate -p /path/to/linux/kernel/Documentation/devicetree/bindings/processed-schema.json qemu.dtb
> (The processed schema needs to be generated first)
> 
> 0 - https://lore.kernel.org/linux-riscv/20220805155405.1504081-1-mail@conchuod.ie
> 1 - https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
> 
> Conor Dooley (3):
>   dt-bindings: timer: sifive,clint: add legacy riscv compatible
>   dt-bindings: interrupt-controller: sifive,plic: add legacy riscv
>     compatible
>   dt-bindings: riscv: add new riscv,isa strings for emulators
> 
>  .../sifive,plic-1.0.0.yaml                     |  5 +++++
>  .../devicetree/bindings/riscv/cpus.yaml        |  2 ++
>  .../bindings/timer/sifive,clint.yaml           | 18 ++++++++++++------
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 42d670bda02fdba0f3944c92f545984501e5788d
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
