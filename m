Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EAF4F79AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbiDGIbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbiDGIbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:31:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87D2DBD3C;
        Thu,  7 Apr 2022 01:29:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a6so9381580ejk.0;
        Thu, 07 Apr 2022 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0F6DhDok16S/mQnw6vQwIVuASfGD3h0OWMoxK33LWCA=;
        b=cYDvbwtjz/ppOtT0tIl41bS8Cauu7EyNoWz+ZNBV0wslHKs8RORt9tSzMwQCNs6/xO
         IRaVZKRvv5KEOWw/wpCsyZWTq1bNuql/umI0neXnPCu4kZxhgLIQNggYbaikkqkfBSTR
         8oBvL+xDwB2ToLPRtJdq5M11V2+e9NS6Apsl3ixQwKnX1cANv1yLliF3vjcm/wjFF7oP
         9Cy+8tXENsn9Mbq1ZF6vductnyEkwAUOjC4InAliZG75oM0AwKbMe7Gyu/rCwfmWvPsR
         JZmrZRecVIOHxOh9Pmq5TeULOwPB7BopR0haek/Aa7KPS7LJg/RXg7Ovtuu6+TxNvpxl
         DeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0F6DhDok16S/mQnw6vQwIVuASfGD3h0OWMoxK33LWCA=;
        b=BuY2U9amPN8M6gO48xZTN1m9Da0QlRxwdYqGudnmfseLO/BiQgLgHPWbLRRLVqdvrx
         c0h6FbIx0x8dnBfCl3yvYHEjvevdYq+z/drvMPtr4qm1A9csTFJmqPHkMp78Z9r10/Xd
         SF/l/bY6NSAneYZctPDgox8ZQQf/ZTqegwOnLJEmNuUn05TYZv6qSB9R1Ppx7tswKpDf
         aM9BdQ98b6Of+kCVjVx99e8DNmS9GVP0rfJziEAfYTvl/rU110uieVZ+InrZATUM19C1
         X1E1S38q60JtOcrGhl6Ezw0vF0du1Wa6U1tjfBjYXLOyb5v+Zl/lsllRcsqLx0sTq6Kq
         nR7A==
X-Gm-Message-State: AOAM530kREVK7D3BqKEpFdoaVfWkuaNdGzrTLQxGqJChdZD2qohqHKfm
        6IoPiLBnXgEzNpyLil12oo4=
X-Google-Smtp-Source: ABdhPJxgqem8xJnZtgt0VCnwgO9PwyfQTZWkcJsDdqRgUdc44rTZFKng5pPG/Ih0HWtEx+Jj7Oy1+w==
X-Received: by 2002:a17:906:4fc4:b0:6da:b4c6:fadb with SMTP id i4-20020a1709064fc400b006dab4c6fadbmr12411431ejw.282.1649320170304;
        Thu, 07 Apr 2022 01:29:30 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.23.54])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b0041cbaba8743sm7022814edk.56.2022.04.07.01.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:29:29 -0700 (PDT)
Message-ID: <68685953d3ffd8912afdaf8202ed87d113f281ad.camel@gmail.com>
Subject: Re: [PATCH 02/12] ARM: ep93xx: renumber interrupts
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
Date:   Thu, 07 Apr 2022 10:29:27 +0200
In-Reply-To: <20220405091750.3076973-3-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
         <20220405091750.3076973-3-arnd@kernel.org>
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
> With the move to irq domains, no irqchip must start at number 0,
> so shift all the hardwired IRQ numbers by one.
> 
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've successfully tested the whole series on EDB9302, therefore:
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/mach-ep93xx/core.c              |   4 +-
>  arch/arm/mach-ep93xx/include/mach/irqs.h | 122 ++++++++++++-----------
>  2 files changed, 65 insertions(+), 61 deletions(-)

-- 
Alexander Sverdlin.

