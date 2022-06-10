Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47B3545C60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbiFJGha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiFJGh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:37:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F711A815
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:37:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r187-20020a1c44c4000000b0039c76434147so644447wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qxlw/2GeYPhBz4i8FzCqobc8aHph2WQJ2uzH+wlAQPM=;
        b=YvKD/lnZFHPf9Bklm5hR2t0kTgFB1/rXSkgOKvxFTago0OfV/XXVBnr65QfdQ0sIbE
         X56d5w92lO93EaOJsDJ8oCNGyjZkcJXPRSg9xTkOKhWDw62K7tpcO84Az2vOBRZU/r3+
         YIHnLV0yk1ox4ibJDxo/xtHUE91KPK5nhGt24yQglgyRLlAN46Y1Z1t0+GvzN7M+MEou
         tOdQLaDCWTLurM3ng8g7elKpPBlMcfWMNnTz6GEuMIGKZgA7WgUpL2gOP6VsKo5/EHPb
         626ZTuTKw9tktPSgibPC7QlWbKT0XcsOV4TdzYgmUmuC1ODYErjWurNuno/msyBC5MwG
         9u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qxlw/2GeYPhBz4i8FzCqobc8aHph2WQJ2uzH+wlAQPM=;
        b=0+KDH6+zbTQop/UGw7Rz3ykGI0bgguMIQGKaDRTUbpokQ6qV+bkRK6e9LSqo6q8KTI
         Sg/LHGXKePqBEEQH/iD9wa7chCLrrQre7X6qbscQvFya7UFl6bpmy4NcfnN9bEoX5SJ4
         suSASXM4qamTXFNc+T88w1XL7ev40K1IM0xoeZqMBn6iHfv/G9f+W0SSMo3hBu2vgd8M
         NIeAQBM6nMyRPqB/x2n9xy9MGFCw7Ij+LWGJbvk3yhMrOGo1MrJkj3jNCMXZfqlMplmO
         SEIm49/4zBxSu31NngtNUDR8PeZoeq1/TiQ/OHavOoWGcQWgGiupZhN2+R72HR7BzLWp
         mJbA==
X-Gm-Message-State: AOAM531aSXJ67a7FOXqZty0a23TufZimi140c7hwKpRsD3Hz3AxTAv0X
        v9lnsdnfSBvGIPb5X5d61Nh1+A==
X-Google-Smtp-Source: ABdhPJw4Hge4NDaRn0TL71ijVSQhRo1MhCaO3HbTb1tYRGHCORKkku8fnKoEAx9FGxDoG3CaWVnJNw==
X-Received: by 2002:a1c:4e03:0:b0:39c:5bbc:e0d2 with SMTP id g3-20020a1c4e03000000b0039c5bbce0d2mr7034980wmh.184.1654843041123;
        Thu, 09 Jun 2022 23:37:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:27b0:82d9:d0c6:702a])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c228200b0039482d95ab7sm1729030wmf.24.2022.06.09.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 23:37:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, arm@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-tegra@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>, linux-input@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gross <agross@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-sunxi@lists.linux.dev,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Li Yang <leoyang.li@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v2 00/48] dt-bindings: input: gpio-keys: rework matching children
Date:   Fri, 10 Jun 2022 08:37:18 +0200
Message-Id: <165484301356.1384204.15957178175784526690.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Jun 2022 13:37:21 +0200, Krzysztof Kozlowski wrote:
> Merging
> =======
> 1. dt-bindings: rebased on top of Rob's:
>    https://lore.kernel.org/all/20220608211207.2058487-1-robh@kernel.org/
> 
> 2. DTS patches are independent. They can be picked up directly by sub-arch
>    maintainers, by Arnd or Olof, or eventually by me (if you wish).
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.20/arm64-dt)

[07/48] arm64: dts: amlogic: correct gpio-keys properties
        https://git.kernel.org/amlogic/c/4956be9944d1fb23107f27bad8a2cca0fa167443
[08/48] arm64: dts: amlogic: align gpio-key node names with dtschema
        https://git.kernel.org/amlogic/c/4fd9afd894ebe5831dbd737e6ca7b6de14da7fda

These changes has been applied on the intermediate git tree [1].

The v5.20/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
