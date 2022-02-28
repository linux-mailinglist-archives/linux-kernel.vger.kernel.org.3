Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAAA4C69E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiB1LKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiB1LJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:09:48 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A226D96F;
        Mon, 28 Feb 2022 03:09:09 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d187so10821093pfa.10;
        Mon, 28 Feb 2022 03:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkpVN31t/Eo1GFbtPY7KJm4bzowxIotybpf1qkjJYWA=;
        b=e7q7GaOlrjqhw4wZSZZkOjSswhSoiRcCyyhJLTMrTTRiYOlGlsvsYIER7wjHPtYcsO
         +sXXxbPH3kbyt09diTODIc7SpGDqNWkn+lRheuiWw1j9F9xltL+s/6gJm7z6mNQktI22
         PUy9soMoFKmplSmnwgUpNf3MiTsgZwVb0ogKoB+mWnNZ+Gy/jZHybtMnNh//Xfgrky3V
         GCxgyWVokhcP62cPE2/QzSjG2QkWkqpyyER4VK5Sia60ATPXETIdz6edI4c3b+jSa1X+
         ZzLWNGO9oNayYqYLKYMW2fV7IXTVfBLe19NvGjiHkVrthVNEElcChNTpp5Xm4GuKr3hz
         Mu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkpVN31t/Eo1GFbtPY7KJm4bzowxIotybpf1qkjJYWA=;
        b=29ixLfn3Ti9YBQsLuEgVnqcLsPFhZAK9dT2LuWPJjHyumQFCsZT1WNWxVRcRdPNIXb
         anJIeEw+t18ipA+92YXbpWNvC9U3Ptuszm/yLZTf+LD9jaqWHhg8qm0eYyDuPa0NJCPq
         ybL8haAxyqYJMss17ljaZfgVFx6FFqtqPBkwWykHYmSLmz9s+s1obe988xJk70fBwJ/E
         TECMtbpsnL+sGuy1wUAR9M3siKDpnfcqdkeWWEXpGm/x47eNNW2cDqo9CBkUtwa99mRX
         oyaNF3+q3f48POISy0A00IKlWJP+SMugpl+TLK2WCMVsZB0V4WvQiOSOWlYQd6yvNEvT
         +vqA==
X-Gm-Message-State: AOAM531Dyi0zsM1MDB3ukr3I7ed/RDLMsT27GjPuv+SsznUDMtP7KyUY
        rl9Y4hZ/Mdy+ZDdXVzbjShg=
X-Google-Smtp-Source: ABdhPJy8LwgcYXgh2fp2qYyRnv9aOc3hbJeqRAeSeufjtJFBpQK6wmjAp4ZSo1sfUYuT++jGsnRUjQ==
X-Received: by 2002:a65:6d0a:0:b0:373:9242:3a13 with SMTP id bf10-20020a656d0a000000b0037392423a13mr16964961pgb.452.1646046548643;
        Mon, 28 Feb 2022 03:09:08 -0800 (PST)
Received: from localhost.localdomain ([122.161.51.77])
        by smtp.gmail.com with ESMTPSA id d17-20020a056a00245100b004c283dcbbccsm12700239pfj.176.2022.02.28.03.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:09:08 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Anup Patel <anup.patel@broadcom.com>
Subject: [PATCH] arm64: dts: ns2: Fix spi-cpol and spi-cpha property
Date:   Mon, 28 Feb 2022 16:39:03 +0530
Message-Id: <20220228110903.97478-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Broadcom ns2 platform has spi-cpol and spi-cpho properties set
incorrectly. As per spi-slave-peripheral-prop.yaml, these properties are
of flag or boolean type and not integer type. Fix the values.

CC: Ray Jui <rjui@broadcom.com>
CC: Scott Branden <sbranden@broadcom.com>
CC: Florian Fainelli <f.fainelli@gmail.com>
Fixes: d69dbd9f41a7c (arm64: dts: Add ARM PL022 SPI DT nodes for NS2)
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
Hi,

This patch is on top of git://github.com/broadcom/cygnus-linux.git,
master branch which is not updated since 4.14 kernel.
Hope the reference is correct. Thanks!


 arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
index ec19fbf928a1..12a4b1c03390 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
@@ -111,8 +111,8 @@
 		compatible = "silabs,si3226x";
 		reg = <0>;
 		spi-max-frequency = <5000000>;
-		spi-cpha = <1>;
-		spi-cpol = <1>;
+		spi-cpha;
+		spi-cpol;
 		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,slave-tx-disable = <0>;
@@ -135,8 +135,8 @@
 		at25,byte-len = <0x8000>;
 		at25,addr-mode = <2>;
 		at25,page-size = <64>;
-		spi-cpha = <1>;
-		spi-cpol = <1>;
+		spi-cpha;
+		spi-cpol;
 		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,slave-tx-disable = <0>;
-- 
2.25.1

