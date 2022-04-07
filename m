Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6774F79D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbiDGIeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbiDGIeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:34:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF1D229CA7;
        Thu,  7 Apr 2022 01:32:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bh17so9256416ejb.8;
        Thu, 07 Apr 2022 01:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0tw+m4R57U/18KDq8GHiXafNKaWFuGwCGvDB2p+CXdM=;
        b=ZgpJZpew8vmFcf2B/L57Jw7+3WvktQLD4FmKiZa48+lPK06yQ8Hd8sRWMuVXykUx5k
         6lgaBwmtRFPXpz+uvmJArBAA4ZpHAsL/WritHY3Bg3tyk/qU8S6ZRP0EQD8+UjS8Z/Pf
         jm2ae4p56hhRiWao6kFhfYAWtpYtTqMXyMmpvOUXZb6G9uTxiuiA2n8ht+ddD2nADtxf
         uLgTzujRjV0Tea9guSmWIigU8S+UZbPgK4HH9IzrpBIGH0CMhTftm9DrnBLWjokZ0CvU
         8antZvuk+Hn7ju9QILcIZZ+JlsoEBZEO1TKyUhygLpSKjH2Lri6GupaWXid1kIQi4lfe
         HiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0tw+m4R57U/18KDq8GHiXafNKaWFuGwCGvDB2p+CXdM=;
        b=PQyTBo4xBW1wGM6lkIeZA2SR/6nYfNdqdp7pW70JubRZEco8Qgnohcc1YElqtDbtMm
         qvWhWrjVmvnWbJp8i/N3VRanpvGHBe5GsWYfrmcYuJjbAybU78CDhZsGnp/ccwZB4Qf+
         8O6e/Hq5x1s5PGlWQC9CnQ9tUqOYsla3DXr41dxyzSivU6a3Wb4d+qKlTD2n8jTQOgFp
         FtgPMHrizwH2K47U6B4sI4lAyHQtHChMR4+BXLrTYUrnsYVAgt2ft1Uk/Db/7Fb3X/ek
         ZIWqia2+thATYIMhY1/sdCENsKamJMEGu6eefrSUWcM0ysat8txIeDoSp3TpW5ex+A1a
         VhoQ==
X-Gm-Message-State: AOAM531bwIO4BDhQyPO/KZHSLEKiPrQnps+VDSMZCyI6PRTzO6WHB+2A
        uLvxlthcyb75WCiwiOtuKDU=
X-Google-Smtp-Source: ABdhPJzngHlEDPVVoNFWkMVU3CN0HM0bYPGxeLREedvJN8v4si+9GL4sWpNGTTGbXkMUwe3i26sUKA==
X-Received: by 2002:a17:906:18b2:b0:6d0:ee54:1add with SMTP id c18-20020a17090618b200b006d0ee541addmr12042792ejf.499.1649320342454;
        Thu, 07 Apr 2022 01:32:22 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.23.54])
        by smtp.gmail.com with ESMTPSA id k22-20020a170906971600b006e840b36f5asm31039ejx.91.2022.04.07.01.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:32:21 -0700 (PDT)
Message-ID: <e3596f79c41af25df6a8c08ecefaba40c751f45e.camel@gmail.com>
Subject: Re: [PATCH 05/12] ARM: ep93xx: multiplatform support
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
Date:   Thu, 07 Apr 2022 10:32:20 +0200
In-Reply-To: <20220405091750.3076973-6-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
         <20220405091750.3076973-6-arnd@kernel.org>
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
> With the clock support and the interrupts out of the way, ep93xx can be
> compiled into the same kernel image as the other ARMv4/v5 platforms. The
> last obstacle are the two workarounds for broken boot loaders that
> require us to re-initialize the ethernet controller and/or the watchdog
> on certain machines.
> 
> Move this code into the decompressor sources directly, checking for
> each possibly affected machine individually.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've successfully tested the whole series on EDB9302, therefore:
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/Kconfig                              | 16 -----
>  .../compressed/misc-ep93xx.h}                 | 69 +++++++++----------
>  arch/arm/boot/compressed/misc.c               |  4 ++
>  arch/arm/configs/ep93xx_defconfig             |  2 +
>  arch/arm/mach-ep93xx/Kconfig                  | 12 ++++
>  5 files changed, 51 insertions(+), 52 deletions(-)
>  rename arch/arm/{mach-ep93xx/include/mach/uncompress.h => boot/compressed/misc-ep93xx.h} (51%)

-- 
Alexander Sverdlin.

