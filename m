Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A69E56CB07
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 20:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiGISNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 14:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGISNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 14:13:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27296254;
        Sat,  9 Jul 2022 11:13:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t3so1706830edd.0;
        Sat, 09 Jul 2022 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+PAXAr4GvuuMdL9CB8YUJ0tSa3wVMMc5VOskQpoahMU=;
        b=UzAJOJFRYH2pfZk1ApRIxOWHReUpQxHsioSWHGXhzuPcSW6uJ7iHrVvhMf6THlEqip
         zcWcqTTLL/bCUxaNJ2zmwTwjwT5TA1nF38nVatdO3WOOXbofZ41fHWpWZ2MYwkJSf+Sz
         ibRQ6JzuiH3pCb5NS/5np0G0FFW5qv9h8gf+nus9WvwCIp6i50XhramB9UeqA/wWNNdN
         MnU6pKgQ2IPRhbQeXDIxAKDzsHWC/Bp+lErsHNDmXlOSCs28Elx4VmYoXSCBxpG/FUVf
         cnq9D4lNNndEQVBCQkSOkAEPYqrYP2nddbDkh9fphqK+K+XPRw3acSt6+nzGvmPYF/pk
         Lf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PAXAr4GvuuMdL9CB8YUJ0tSa3wVMMc5VOskQpoahMU=;
        b=BnsqkEHVHX4lv1/acYVhvBJXMbi0FyzRXLMnfyQTMF17i4QkWNiqndT6pI6j3mmT/T
         0X7UjLxooueFArnZ7j0bD4HGI21LS+WZBvdSQLZZ2cmGKt3Ki8Ti93BbzlBaS+8n0gOE
         F4q24NDDfJTXveaI6ZI0P5UpFDvsEfOgZmJFLm5hYgd5W2TRRGVWfzSCY6MR8NfumfBB
         j3/1QyfqSjVVU+zVQPRZYCqxmE8oJQCQxJmqkZPHL4JDHPaIPzJPKHQEt1jN9ATUgYWU
         Rtbeyi3GU4vzFsAJW0b0EOk2KAEW9VhRS3ZxTLc1AD3wla29BCSn4RFRFLoopo7Goh1f
         ildA==
X-Gm-Message-State: AJIora8ORfPA0aGh4Pp3XzFkg/edDwV/RYgKJonzZvbNFhah0eA3uIuA
        JGCf4PEUv3pGYjzk1NeQqnQ=
X-Google-Smtp-Source: AGRyM1t0Sw7KTfcOfu1/oqyz8NDrZZivhAkDjWb/sciKYE9kWvKwLd0gCCCZLcHGy7IoNXb7Nr9N4A==
X-Received: by 2002:a05:6402:3591:b0:43a:9076:e2be with SMTP id y17-20020a056402359100b0043a9076e2bemr13162715edc.171.1657390412839;
        Sat, 09 Jul 2022 11:13:32 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906300400b006fe9e717143sm825682ejz.94.2022.07.09.11.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 11:13:32 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 0/7] arm64: sunxi: Allwinner H616 SoC DT support
Date:   Sat, 09 Jul 2022 20:13:25 +0200
Message-ID: <8633607.VV5PYv0bhD@kista>
In-Reply-To: <20220708105235.3983266-1-andre.przywara@arm.com>
References: <20220708105235.3983266-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 08. julij 2022 ob 12:52:28 CEST je Andre Przywara napisal(a):
> Hi,
> 
> only some minor changes this time in the .dtsi, addressing the comments,
> many thanks to Jernej and Samuel for that! Also adding the R-b tags.
> 
> This keeps the TF-A reserved memory node, as a compromise for a smoother
> user experience.
> 
> This is on top of kernel.org's sunxi/dt-for-5.20, to get the new I2C
> fallback compatible. The series can be found here:
> https://github.com/apritzel/linux/commits/h616-v13
> 
> For a complete changelog, see below.
> 
> Thanks!
> Andre
> 
> ==================
> This series gathers patches to support the Allwinner H616 SoC. This is
> a rather uninspired SoC (Quad-A53 with the usual peripherals), but
> allows for some cheap development boards and TV boxes, and supports
> up to 4GB of DRAM.
> 
> Some DT binding patches are sprinkled throughout the series, to add
> the new compatible names right before they are used.
> Eventually we get the .dtsi for the SoC in patch 3, and the .dts for
> the OrangePi Zero2 board[1] later, followed by the .dts for the X96 Mate
> TV box[2] afterwards.
> 
> U-Boot and Trusted Firmware support is now merged in released versions,
> it allows booting via FEL or SD card, also you can TFTP kernels in on
> the OrangePi Zero 2 board.
> 
> Many thanks to Jernej for his tremendous help on this, also for the
> awesome input and help from the #linux-sunxi IRC channel.
> 
> The whole series (including the prerequisites) can also be found here:
> https://github.com/apritzel/linux/commits/h616-v13
> 
> Happy reviewing!
> 
> Cheers,
> Andre
> 
> [1] https://linux-sunxi.org/Orange_Pi_Zero_2
> [2] https://linux-sunxi.org/X96_Mate

Fixed emac compatible and applied, thanks!

Best regards,
Jernej


