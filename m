Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A184F7B82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiDGJZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiDGJZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:25:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEA5160C27;
        Thu,  7 Apr 2022 02:23:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so6930622wrg.3;
        Thu, 07 Apr 2022 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xMgd46EJ5wVn6CMXY5aj4EBYAJUgSDExNiBRxjSsup0=;
        b=YLZM8TqAf5s/xZGGwK2qBp8Mzy6aF/171CjMHcR+izwqk7nAAArqVQSbBtJ0+NLo/V
         8qMH2CcMm2ZdTE00QJvgZuUQYjgRUo9pK3IwVnjPlHCKyjWUZHXlN+0BM2+6Hda/AVNp
         5NGhG97wRsX7jTnROFQp1ptJjyVu/IVdturcismecQ0QpH0/MXGBgHnFKoWMsgGrM9tW
         tNkb8jrlSuplbU7j4bpGbRw6ATi+lwF8Dakno4v8h0vXBpzJ22rxb5D1LZIAkA4X3jZz
         a0O0+W/e7pG1qJwyQmb7vL7/SBGYxctuA7OpSlYP2kmPMa16F5LcDQiRvZ66RDgnvHte
         Uv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xMgd46EJ5wVn6CMXY5aj4EBYAJUgSDExNiBRxjSsup0=;
        b=1uiD3bON7plK7bQPYGUEyo/zbdomSO9BBxYHDQ7hTYnBoUkq14t2SvadDHLGggEMH/
         zpMqKAUCifJ0eBZ0Sp2/cZZvzGG1LBzd1WOZTyyme+AVMGBLEZN6Os3iueY2o8Qu2TmR
         lm8WDnKF4pRhBAp/6EGjOU8dvdZBdAIZF2U/xZacSBIMj6kRxHOPTeEg3yJU3HKdq4C0
         ARfvEe1cy7oW/aoBsmTogElVtiXEg4idDNZ+MFPTJnX5xQvLuPhEcVTyW2yyF7yb0izW
         oUuPQO8lRrrAgajOWcxMzGVzE3wyCDtWtyyJ/U8ZqAa+Kykv9jzhXxCPn8U6nusyb244
         40GA==
X-Gm-Message-State: AOAM533zYTiNDkJVpeBuvuz1e6tCQBF1DRWOtH4FtrfNL9FfMGyx7o0D
        UaWpmJgl0dCbp9PTppdk4r8=
X-Google-Smtp-Source: ABdhPJxlwXiGsX4SdX2RIZetw4/+BtOmLs6hXQXzAnwv9pX0XNdCG9MenFDNjce1/UNO81Wsoa28wA==
X-Received: by 2002:adf:f7c9:0:b0:206:bac:2d54 with SMTP id a9-20020adff7c9000000b002060bac2d54mr10025636wrq.64.1649323419140;
        Thu, 07 Apr 2022 02:23:39 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.23.54])
        by smtp.gmail.com with ESMTPSA id v1-20020adf9e41000000b00205c3d212easm17199814wre.51.2022.04.07.02.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:23:38 -0700 (PDT)
Message-ID: <39e8b64cefd8e2b4e4d91a5e6cfc98db88be7449.camel@gmail.com>
Subject: Re: [PATCH 00/12] ARM: ARMv5 multiplatform conversions
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Date:   Thu, 07 Apr 2022 11:23:35 +0200
In-Reply-To: <20220405091750.3076973-1-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

On Tue, 2022-04-05 at 11:17 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I revisited some patches from a few years back, to see what
> is needed forsome of the remaining platforms to become part of
> CONFIG_ARCH_MULTIPLATFORM.
> 
> A few things happened since I last looked at this, which helps to make
> this easier:
> 
>  - The ixp4xx platform saw a large scale cleanup
> 
>  - The ep93xx platform lost support for MaverickCrunch FPUs and
>    gained support for the common clock subsystem

would you like to consider a couple of fixups from the common clock
rework of ep93xx?

https://lore.kernel.org/linux-arm-kernel/20220120133739.4170298-2-alexander.sverdlin@gmail.com/
https://lore.kernel.org/lkml/20220130152502.236531-1-alexander.sverdlin@gmail.com/t/

Thanks!
-- 
Alexander Sverdlin.

