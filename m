Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009C050BFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiDVSXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiDVSXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:23:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDBF75E5D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:20:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q1so11403028plx.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=StDrkjCbJY1YTZwQ+hjKVKx8zZzPWM3Hr4pkTObtJoA=;
        b=QaTQnVxLpbjUu7Q4HVIWf89mR3iZ+/dCruQzOIvEPN3rMBvYHzobChUmbS8zKJUj+V
         G6JlwQ+r9HJY4R/pp+OioxKANEfhvhDdtC/O/ZcdP+/cMrzW0LtAvkqawQfpd1HAjnY7
         EerhnOKARycbOHzX8ntKBKgZcOQCqu8rNCcwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=StDrkjCbJY1YTZwQ+hjKVKx8zZzPWM3Hr4pkTObtJoA=;
        b=JpyGJlv2zV4hNtkhp3muFkL3YRYyPQBTlAP140Ymstrl02qjxVah+6H+/Z9MYoCEMY
         sIHErCeqWHy07SyoOXnjTAAGPF1CkkefySzJI6+RGSYCOC0CkWPRIaVAMDMDAehoHJqc
         QNlfupqrspl8mbpQq9I5HcLbX1BgWqW8tSiNEdUkLO5rE6Rt0x5QFD402XoiZxx06YDC
         6aCjBSjesO6MdCmQEqZ0r2YSb3td3AaziJId327GDczY/UfFzRbsRI8tBfaHeJwFujTf
         4ov12uptZyTunZifF8LLIUdt99UJNBV/OEp4kN1nch/w8eInnOSnNBzL9T1zDAbFxZ75
         vTIA==
X-Gm-Message-State: AOAM531iMQ++ze4qsgR0aQ+4dTlRt1R/HFWxK2hOGAc20wAEl3q3DPL6
        7WWUBrRD9M4Rc/uqOGOf+xXZow==
X-Google-Smtp-Source: ABdhPJxEkTRKxnGvrx+fdTPpn7AfmC0GBEfArx58zWt1H5Xi35nlxQORQWOYw4gLVSkZTksJksRarQ==
X-Received: by 2002:a17:90a:b014:b0:1cb:ba36:8fe1 with SMTP id x20-20020a17090ab01400b001cbba368fe1mr18101221pjq.67.1650651586827;
        Fri, 22 Apr 2022 11:19:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e283:652b:fb2e:829f])
        by smtp.gmail.com with UTF8SMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm3445028pfl.135.2022.04.22.11.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 11:19:46 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] soc: rockchip: Fix compile-testing SoC drivers
Date:   Fri, 22 Apr 2022 11:19:19 -0700
Message-Id: <20220422111914.1.Id5f16dec920f620120c0a143a97a12e16d401760@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 7f94b69ece51 ("ARM: ixp4xx: fix compile-testing soc
drivers").

drivers/soc/rockchip/Kconfig makes plenty of provision for configuring
drivers either for ARCH_ROCKCHIP or for COMPILE_TEST. But
drivers/soc/Makefile pulls the rug out from under us, by refusing to
build anything if we specified COMPILE_TEST but not ARCH_ROCKCHIP.

Currently, I'm not aware of anything that breaks without this patch, but
it certainly makes for confusing builds (CONFIG_ROCKCHIP_PM_DOMAINS=y,
but we didn't actually compile the driver?) and leaves room for future
error (I have pending patches that break confusingly with COMPILE_TEST=y
even though their Kconfig dependencies seem correct [1]).

Defer to drivers/soc/rockchip/{Makefile,Kconfig} to do the right thing.

[1] e.g.,
https://lore.kernel.org/linux-rockchip/20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid/
[RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index fd7717d597fc..4c91705a8bb3 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -23,7 +23,7 @@ obj-y				+= pxa/
 obj-y				+= amlogic/
 obj-y				+= qcom/
 obj-y				+= renesas/
-obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
+obj-y				+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
 obj-y				+= sunxi/
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

