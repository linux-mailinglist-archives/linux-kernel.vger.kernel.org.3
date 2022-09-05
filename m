Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52F5AD841
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiIERQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiIERQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:16:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A351A01;
        Mon,  5 Sep 2022 10:16:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so8124406wme.1;
        Mon, 05 Sep 2022 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TzfY9hsKE+/NMaAr86KQtgckRDntIH8+oY7tsTfeowI=;
        b=KLV4Nstc48KFC9+jc2u0EphqKQQEB8LLwdQ0MEoORpOpwyjOGK1pAH3k7ehAfPlIAt
         oB8G74ze0PuXWXf3t6pZD6VPc3YhmM4BCVpRGZp6SiBoMw+qMNs9T71AVmTpAv8ytiqG
         kRJXVXfx6rtjygzsxEpw6KjmpxxJPYfrb+rEFuFQ1MRemKWk49UayCPAt4edf69erBoI
         fpjN6oI2MNhp0i6YJ5Dp3u3CcGKSLXPVjshGHixbDR+OgnvjQw5DyPiXUVuvdrsfIl2l
         VUw+dQqRImBdMl5cNBZgKqq9/7waLoiFDRM4G2eCmYqRV6QIY4C6/h3uF5vPIUEHvxHF
         2sqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TzfY9hsKE+/NMaAr86KQtgckRDntIH8+oY7tsTfeowI=;
        b=LWXduibe9nE0pRw3rNp5MTIzDI8P5DRYbypfwhl7P5UIxRbp9VyBjf8LYuG+ozy3Il
         ExaeZXgapqYc2xJVt0BM5zA1K+JMGPGBf4VXaIT+EZ5NwY8uQ6ZKGPB7BYzBK1YlY7O8
         2r4ebWjqDn5vbjIemYRzhQAdub3ULNezBtLHYME/wH3zZfC1m2lYumvFsjUAwDCGWPot
         nvU+6Phbh0ZiOY4bQSv1M4bvwpLnmMeml3JrUqz2NRjE0HQoh3yYORZ7ON5yTj2+TUHJ
         kbfVejTy/F3zxUoO6GU8rvBZahQY/7MMebhm9Xc4vspzXyJjUXSSAnu77OHAT4wtXMru
         V/WQ==
X-Gm-Message-State: ACgBeo0k+llUwXsYyP3XxGDbcTx5IeavkNu5LZ+oL4B0e/4JhGM3zceC
        reLJsXGXewiIiacbSx2ZJ18=
X-Google-Smtp-Source: AA6agR4RwpjPOOTqBKl/6DsHS3haY3qQDvxQ4RNUYlwerXpgCNpvdgAPmkUKgUdWtUeRFLIuXnBAew==
X-Received: by 2002:a05:600c:3b10:b0:3a5:3357:ecf4 with SMTP id m16-20020a05600c3b1000b003a53357ecf4mr11296930wms.193.1662398167450;
        Mon, 05 Sep 2022 10:16:07 -0700 (PDT)
Received: from Clement-Blade14.home (2a01cb000c0d3d00995730c36491d21b.ipv6.abo.wanadoo.fr. [2a01:cb00:c0d:3d00:9957:30c3:6491:d21b])
        by smtp.gmail.com with ESMTPSA id v22-20020a7bcb56000000b003a5ad7f6de2sm11437072wmj.15.2022.09.05.10.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:16:06 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 1/5] arm64: defconfig: Enable devfreq cooling device
Date:   Mon,  5 Sep 2022 19:15:57 +0200
Message-Id: <20220905171601.79284-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905171601.79284-1-peron.clem@gmail.com>
References: <20220905171601.79284-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Devfreq cooling device framework is used in Panfrost
to throttle GPU in order to regulate its temperature.

Enable this driver for ARM64 SoC.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 91e58cf59c99..e557ccac8d9c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -582,6 +582,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_IMX_SC_THERMAL=m
 CONFIG_IMX8MM_THERMAL=m
-- 
2.34.1

