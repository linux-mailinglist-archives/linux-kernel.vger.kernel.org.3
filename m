Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16C4FBF74
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347423AbiDKOrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347424AbiDKOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:47:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C77CBC9C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:44:54 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a11so16287879qtb.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prism19-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UnSeorzrHp2ShcLAoDvVpITCICkDvr9NW1j4ZfpG8o=;
        b=7v/UEtR1eSUjf3DjrG6u5oSFQ6lybW47MzaZKUelNTbLzOG1QvyInnxaSFl5rtC0CN
         l6IhVaQowoZCAU10b9xsSe++yByur/nfWa2svgVxpuSOmtnlhWeBsxeTIN5+eHYLRADV
         W5g1ztwzDF2fpR9ZSVvc6dAEw4Eg6QnaglPJlXLy54l8tKQ/mnIJi63ntzATYsP5W1kX
         uPPEg9LdDHn+pPK0CobPaiosNuw/HsD67UlYcabR3d4d3e8Q5HtKLh8seKU/T2uYPViW
         M8arc0GGwOL8I3syiQdJIpbu1fcNO1DsGU2vvjaTogVUuX6/hFOfmhK/YCqZ68IOTZcH
         idjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UnSeorzrHp2ShcLAoDvVpITCICkDvr9NW1j4ZfpG8o=;
        b=Cs0pvImEaNvvsYYady4NhX5ne/WVTPnQVECQ16OfVEuI1dFGgAWZDhO9dp8nsc3JSk
         1XajNmtBaKDNhnh45GvGbDWxnvnAw7N7KQPt+KIWczjLUU9L+0D6mOTmempcqZV68EBU
         JM4cCEJJOIekPFo+5c0vu52eREV5chxm2YO2n5fkP2L4laxiLS0fUJ8P/MmJr/cXExAr
         oawL+NRDBgvJQLTmRW8hc3V75rCQJ6BM4ls+HEcZuCl/+Mq5UwJDhJj1CLo9eg7xFSwb
         cmOrFW+czVojHAMHrge1AuPKlfkt9GH6z0YG3eNDWyzSx0faTzc5u+BhnnXQ1TMNh5IN
         LwqA==
X-Gm-Message-State: AOAM5300Yzxp3YtaBuG1OMwTWNT/uskzzstAUAAKSpkoIhE3Tz8BZIsE
        4V6Mvla4E3iu+LozYswmHpTTkg==
X-Google-Smtp-Source: ABdhPJx5N2Qv5BYEoOuxQsD/w2C/JE0G/XNbIZuMEzcNJoIliG30Af7PXQCTDUltVgUxF5mB8376mA==
X-Received: by 2002:ac8:5906:0:b0:2e1:c1ef:2085 with SMTP id 6-20020ac85906000000b002e1c1ef2085mr25952476qty.170.1649688293019;
        Mon, 11 Apr 2022 07:44:53 -0700 (PDT)
Received: from RADIUM.localdomain (bras-base-mtrlpq2718w-grc-02-76-67-205-66.dsl.bell.ca. [76.67.205.66])
        by smtp.googlemail.com with ESMTPSA id i65-20020a379f44000000b0069a0d9eed43sm8158749qke.33.2022.04.11.07.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 07:44:52 -0700 (PDT)
From:   Guillaume Giraudon <ggiraudon@prism19.com>
To:     kernel-dev@prism19.com
Cc:     ggiraudon@prism19.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO pin labeling for CON1
Date:   Mon, 11 Apr 2022 10:44:28 -0400
Message-Id: <20220411144427.874-1-ggiraudon@prism19.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The labels for lines 61 through 84 on the periphs-banks were offset by 2.
2 lines are missing in the BOOT GPIO lines (contains 14, should be 16)
Added 2 empty entries in BOOT to realigned the rest of GPIO labels
to match the Banana Pi M5 schematics.

(Thanks to Neil Armstrong for the heads up on the position of the missing pins)

Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")

Signed-off-by: Guillaume Giraudon <ggiraudon@prism19.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index 5751c48620ed..84489525c75f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -437,6 +437,7 @@
 		"",
 		"eMMC_RST#", /* BOOT_12 */
 		"eMMC_DS", /* BOOT_13 */
+		"","",
 		/* GPIOC */
 		"SD_D0_B", /* GPIOC_0 */
 		"SD_D1_B", /* GPIOC_1 */
-- 
2.20.1

