Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB49A5914D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiHLRcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiHLRbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:31:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06AB248D;
        Fri, 12 Aug 2022 10:31:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a4so1261835qto.10;
        Fri, 12 Aug 2022 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QGLoUgJ2TVf85FNO9ppA71x6uLHjiN5oNLDyUkLBWZY=;
        b=V3p1XYcwP5WukAYpk4aGPYV8sxzjosJzLcqm7Un2fOVSxu77GYdPsItF1d8bclhcUP
         XlSYJO9z2VDjB9zn/5N30u+BVwrWXYx8J5Q7pN6ULYAiaSqkvuJMxMNajIxFjYSVKQl+
         YX9bqTIqf6yiQ2+ss1emf5r7d3U6WP4emtfpxqYaPeYj2Xz8CmgpSkUUPxrEy7o8dCfj
         pUen91YYGVT2tPzXzQp1jLBcbt7R1EmsGVGIneycc54UJdflBGBWmW1aYaAoMmwsG6Ip
         VjrrUtE170Tv55A/Q1UJsnZg8yD6wYAenYq0mrt1CHg33SrmuoF/nvgVL11CL5cgYRkK
         1fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QGLoUgJ2TVf85FNO9ppA71x6uLHjiN5oNLDyUkLBWZY=;
        b=3KJZln+GBex6wAWXNhUQN3tv5SW4Aby3NMzuK2zWd4PN0ftHieLFioAGknBLKpgMi5
         mRsMEgtVczVolCvaIiLKVeQa1G2EdwSIVjGZoc4e7KfgXc9CpsTsp8gqVtMLhCtob5wc
         yWf+yGDiIiNSClrU0/qF9jtSFgWk4jiM3nOwAyKip4I8Kq4UjlyoFzHTcvnqtQnLq6vo
         t87VzEA1qAv/bSKvfRmWUBv9CuKX4ilQ1Kw0DE69xU4Tk209HRkanzKLkFo/ih+vmgpC
         tAX4kRnvnkowG3gcXMBQGBEq/Y2DInlGtKyMxrw0K+PLGKgBgkrC5PYg30FUWel8Q7oW
         HJeA==
X-Gm-Message-State: ACgBeo3ezbECR7d6XEy/pQTajklIIhfCSohu2OT+UNLNcvZhkMTwQLHe
        qWc8cLQbI6DajS58lPmzatWPRDYaWBA=
X-Google-Smtp-Source: AA6agR5xbLuBLYyiVY65BGRBlXMliQTeyvhM34JIB8q+FtA+/zp8fxvlW8pZw/kKSyUS3/nY6t7sag==
X-Received: by 2002:a05:622a:4c88:b0:33b:f61b:d17f with SMTP id ez8-20020a05622a4c8800b0033bf61bd17fmr4441246qtb.23.1660325495138;
        Fri, 12 Aug 2022 10:31:35 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006b9b7879964sm2369300qke.28.2022.08.12.10.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:31:34 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v4 2/3] Documentation: sysfs: Document Broadcom STB memc sysfs knobs
Date:   Fri, 12 Aug 2022 10:31:24 -0700
Message-Id: <20220812173125.2410536-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812173125.2410536-1-f.fainelli@gmail.com>
References: <20220812173125.2410536-1-f.fainelli@gmail.com>
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

Document the "srpd" and "frequency" sysfs attributes exposed by
the brcmstb_memc driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ABI/testing/sysfs-platform-brcmstb-memc       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc

diff --git a/Documentation/ABI/testing/sysfs-platform-brcmstb-memc b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
new file mode 100644
index 000000000000..2f2b750ac2fd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
@@ -0,0 +1,15 @@
+What:		/sys/bus/platform/devices/*/srpd
+Date:		July 2022
+KernelVersion:	5.21
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		Self Refresh Power Down (SRPD) inactivity timeout counted in
+		internal DDR controller clock cycles. Possible values range
+		from 0 (disable inactivity timeout) to 65535 (0xffff).
+
+What:		/sys/bus/platform/devices/*/frequency
+Date:		July 2022
+KernelVersion:	5.21
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		DDR PHY frequency in Hz.
-- 
2.25.1

