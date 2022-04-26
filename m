Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72C750FF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351161AbiDZNpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351090AbiDZNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:45:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ADB3CA77
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so901233wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lqk8ZG0qxpIIDvSpDmpiW10RXEh5f90c5tYGoIQTeBk=;
        b=Ld2I5By2ve8Ct4dPJ90lZhxgNO5il6+Sl6Mx4qVGQHec2ojQKQO7x9srGnXiJ8cR8F
         MQMj5i5gnGyXWfpe2m4fJSzW3QxxYFrSc1ghc0Em1Vw6bPvCRPSOFAqVK5PYs/wsWZCL
         +ITEiXeZKbHEvx6ra2hivQCnxe/gC58Lb9RigpjKQDCDXR/mqG5xJJ5nfwDoiAI+XS/M
         E1xYhNq7r98BwE+wj6EZnEws6OUIPejXyM+VbyeYnp1bjkAr0zu1mBBC2KS8alhLfEdl
         MNh1VPTVWNymyZ1W7GssJYgh/urf6MF0P8DtU1AObKt2pk9W72l32QvgsLk066mqXX8P
         igDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lqk8ZG0qxpIIDvSpDmpiW10RXEh5f90c5tYGoIQTeBk=;
        b=JwSIUaGEPF8YJ7gNd2z2/8+235Psnt5l010LIkCeclrpx+gIEEllGxYRzHngQYLJ8G
         +6cL5yGdXi/lpoh8s+/Hmlv0oOsiirguixP1mA4TP1ECljWOKWrEUVjqra8XoTw4ZJ3O
         8lJymAaO7QLt/jTBzlUMpddp9jJ1YZFycrLh7P6kuqZeYttQDIRg8AwfYXz1htP+DqcP
         kHgi91pzmi+xRyOJh/e4znU5fZY6TEsZazNdWMvwt6FzaqQ/4nsV6Yliaa2CH0ATKosQ
         tgKYjki9aBlwIMkL0tj6BrdXsv4gAAUXmWFP6uoRFFL6hcivtaVt1y+9lxcFWsDAcm2u
         AaIQ==
X-Gm-Message-State: AOAM531o0DlCYSRKHr6tMY/MDuW3wXt7mW1jHVmpS2yMb/yYI1d6MYWj
        Oyqt3Zo1dKCR50zCKYZdMaQDlQ==
X-Google-Smtp-Source: ABdhPJzIUFpskUEdsGQHDHpN9fuLdWE/J6FsWPSN4vkc1wjnQyDdu6kOKJ2iOFA8Zbk+ODv7dlvlyw==
X-Received: by 2002:a05:600c:4e12:b0:391:18da:1883 with SMTP id b18-20020a05600c4e1200b0039118da1883mr21617051wmq.101.1650980515586;
        Tue, 26 Apr 2022 06:41:55 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id b6-20020adfd1c6000000b0020aac8a9946sm13628475wrd.47.2022.04.26.06.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:41:55 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: mediatek: mt8195-demo: enable uart1
Date:   Tue, 26 Apr 2022 15:41:05 +0200
Message-Id: <20220426134106.242353-8-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426134106.242353-1-fparent@baylibre.com>
References: <20220426134106.242353-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UART1 is exposed on a header. Enable the uart1 node to be able to
use it.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index d1f650d99d7e..aa41df865c9c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -520,6 +520,12 @@ &uart0 {
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
 &u3phy0 {
 	status = "okay";
 };
-- 
2.36.0

