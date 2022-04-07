Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831104F79CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbiDGIdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbiDGIdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:33:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEE71D08E8;
        Thu,  7 Apr 2022 01:31:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k23so9295922ejd.3;
        Thu, 07 Apr 2022 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YjO65yCUJueZcsX5BrYnH/m97GWK+kzYfUVQzJPSKgo=;
        b=eqbZmKla+dMEy9RQxxGz8eoOGg0sMQZAoFKINltZOLnFd5l+1ni1BvW/dUgJ3CWqvN
         g9gvVG1BIeC/+LFoAwLiclai1XWUzHGbNKSJUvd8djMDg4A2kLOJpE0Fkf3hnvphS3Lp
         QNK9x+p96F6XsUUfrm86+/Kkr4FfozVqvjCttcQmbNE20toEd7oQBkUKNyYT6fAqx/bX
         WCLRmzPXkbkfGZ/zsNbyDbpikdziRWl4VPEkKUIWWHOtBeXAHVXf9ZC3oWGKXMA1wKLv
         FbZgLFevDR3gwsFs79qIs0IZL0kEJbP0P3USR+81LaWuaNdXKbvcEabyEqR8IG2cORyD
         UbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YjO65yCUJueZcsX5BrYnH/m97GWK+kzYfUVQzJPSKgo=;
        b=dgzTvJ7Ny6/BjA4WsBPYEml/fZU1cQKpUm4aa0Oh27tzcmlTdXFOCO4Y+qu4VS2jVX
         OppDNgWMk7HOWw+aVlLdA1QnSfJq4EMcwH5UtstcekoH41xxJi6E26AfMRput0Vkpx0O
         dAoLi1mcrhEUXPZA+ksgG+FUX0rPfC6tNiYWhgPmQJNfZEjLa73YMe1P2dSTOFVnLn0Q
         ACHZ6L1iDclhXGmvfZMQQT9VaPdrF7iQ9vQdJ0gmNlqZNCXyDidzk58EM+OpVeAvmSSN
         JGnjbvRlz/Lu2PsQYniQXua61tsICOAXYfqU5er9iQdscJ8SJx2PKQi7XVpyvN8GiSAs
         x8wg==
X-Gm-Message-State: AOAM533Xdqo1ei7ymEFps0443Bz89KPbeslr4GB0XzrJjd8qSIaD9Rtl
        XMphdtSeFUEu7KFiVRYgU5M=
X-Google-Smtp-Source: ABdhPJzrkNK1rxguF+DMNfRgciLJTOVyUNzWLOqu4MmnIEWr10fJ0cLSk6ulGsblDUYqRxBkrnK0Rg==
X-Received: by 2002:a17:907:3e99:b0:6db:6c1c:d9d9 with SMTP id hs25-20020a1709073e9900b006db6c1cd9d9mr12171094ejc.688.1649320295929;
        Thu, 07 Apr 2022 01:31:35 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.23.54])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906139700b006e758e94972sm5390523ejc.171.2022.04.07.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:31:34 -0700 (PDT)
Message-ID: <5fc3c2b7f299d1b5f784ae5fe4b9cbe9ddf0328d.camel@gmail.com>
Subject: Re: [PATCH 04/12] ARM: ep93xx: make mach/ep93xx-regs.h local
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
Date:   Thu, 07 Apr 2022 10:31:33 +0200
In-Reply-To: <20220405091750.3076973-5-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
         <20220405091750.3076973-5-arnd@kernel.org>
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
> Nothing relies on it outside of arch/arm/mach-ep93xx/, so just move
> it there.
> 
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h | 4 ----
>  arch/arm/mach-ep93xx/gpio-ep93xx.h                    | 2 +-
>  arch/arm/mach-ep93xx/include/mach/uncompress.h        | 1 -
>  arch/arm/mach-ep93xx/soc.h                            | 2 +-
>  4 files changed, 2 insertions(+), 7 deletions(-)
>  rename arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h (94%)

-- 
Alexander Sverdlin.

