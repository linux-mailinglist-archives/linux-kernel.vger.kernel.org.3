Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BEB4C2045
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbiBWXwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiBWXwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:52:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31601D0FD;
        Wed, 23 Feb 2022 15:51:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id n14so26868wrq.7;
        Wed, 23 Feb 2022 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWcU2wxdMqhCzxhAoNFRTMb2fbcbT+16RrjB3ao6kCg=;
        b=ouCqYEFEJDJQSKvkEfkD1y8O+lo4KvkqEYA/USF0C0X4zYU0Hfwbv75xRCDOD/wYwS
         bxc+OiNXUrvkzZlHehUbh5PJ+G7XAbOcheMWs4GqhIzuH9wP4L7CanMAsjkYWphZeRGm
         GQ6oVXvr2y8+ruoyHT1nH8pNVj1gymYVpKqq1PwAwZQIp1ts/9ibkz+YtCK3ib7FYKa2
         yt/TD/frVslyKKE/7JNw/nacl7ukTFCX8wcc6c6yTSmf6ptQvHhoQKZJxpElhXdzWC7O
         s8EnApyLSZjheONUS323PMy4dMZXSoZO+jLbDt2fi24ywnYCbUuILQyY3maGmEEZp7gS
         uCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RWcU2wxdMqhCzxhAoNFRTMb2fbcbT+16RrjB3ao6kCg=;
        b=i9blaG3JKYIUBvKBK/wR34HSyEikjJFwBOtYBR0HmUzZkrvGnAZY8TEebS4IhryYzg
         LCRfp/OO5vbzjzOUeOZqNpiLIEVOuhlZrfTJGIQ8//oR42jYTvV4/zxJiJA5VSIXq0un
         +/17+aAgBo01wj3Qex5HOX/P8+BUeA2mTMCNqdUIy888LbdFY/pj0dKAW6fUUNd+1rM6
         9V4SHxJQac7+foL7Bb45HpKDjoFKuq1/vZNt18iA3rx2cVwZYnc5i7gQGKYjdklYeuSL
         RPbWlRGEykwy7TWHiD+49Bh7BF+kD6SilfL1EE1ipZIIo6ydDjaEfULyZmPNpNIBt2gm
         82dA==
X-Gm-Message-State: AOAM530+9IVXbe14UJQq/HaBIWqvxY46+dRsG2Gj0dDf620tAwtdOs7p
        tiItrlpTCsupiOGKrEe1qKRgYo26FEI=
X-Google-Smtp-Source: ABdhPJxBnDjx7IqXw37IjhU7Y9Jyo4WmcJT+bDK7UZba4++07TTHZy3KUjLHzZOs4w7XW29nRwys5Q==
X-Received: by 2002:a5d:6da7:0:b0:1ea:78a4:8e00 with SMTP id u7-20020a5d6da7000000b001ea78a48e00mr65078wrs.129.1645660295412;
        Wed, 23 Feb 2022 15:51:35 -0800 (PST)
Received: from localhost.localdomain ([2603:c020:c001:7eff:ffff:ffff:ffff:ff00])
        by smtp.googlemail.com with ESMTPSA id s7sm943591wri.5.2022.02.23.15.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:51:34 -0800 (PST)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESUBMIT 1/2] ARM: dts: NSP: MX6X: get mac-address from eeprom
Date:   Wed, 23 Feb 2022 23:50:39 +0000
Message-Id: <20220223235041.2542331-1-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAC address on the MX64/MX65 series is located on the AT24 EEPROM.
This is the same as other Meraki devices such as the MR32 [1].

[1] https://lore.kernel.org/linux-arm-kernel/fa8271d02ef74a687f365cebe5c55ec846963ab7.1631986106.git.chunkeey@gmail.com/

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
index 6519b7c61af1..5de727de6a4b 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
@@ -39,6 +39,8 @@ led-3 {
 
 &amac2 {
 	status = "okay";
+	nvmem-cells = <&mac_address>;
+	nvmem-cell-names = "mac-address";
 };
 
 &ehci0 {
@@ -53,6 +55,12 @@ eeprom@50 {
 		reg = <0x50>;
 		pagesize = <32>;
 		read-only;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		mac_address: mac-address@66 {
+			reg = <0x66 0x6>;
+		};
 	};
 };
 
-- 
2.27.0

