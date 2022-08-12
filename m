Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7968F591750
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiHLW0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiHLWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:44 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BAB12D0E;
        Fri, 12 Aug 2022 15:25:42 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j11so1596360qvt.10;
        Fri, 12 Aug 2022 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QGLoUgJ2TVf85FNO9ppA71x6uLHjiN5oNLDyUkLBWZY=;
        b=BrPUuTuvsEMuz7vINzRyesoXiEsXiAG4JppuAC4kMz7UCBYJ8ahAQXKB+aJiI77n29
         LPzIciOpQoUV+5dKx9IOLSBjI8Tz+1nrNhNmaRKuLT/gLxE/Hwg9rNr1k/XBcdVGGjBo
         zAsgrM8kK20KDW3vNQmoqonEYshf1SscUHWErdnzifzMtadOxnueA8jwczjDVVAKlkLh
         gsmm5onid+sFhlw6PhL2admYH6ddlgT149osiQw+HStaJ+eGMjQIUQ2WemYqzgHAd1qK
         9ovsA/lyAvujtnTSzNoK3ayMYyfLWSkqEZExzuesS8Z7wo/g2b6fqMcz2gBeyzAwS+qf
         9YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QGLoUgJ2TVf85FNO9ppA71x6uLHjiN5oNLDyUkLBWZY=;
        b=V4aVNKyIU9Laa6f9jcBFGcszPvz65qTAzFN15aKiVgqO1EJk1jtsHa4XQOt2nA51fd
         HMMS4Xa8o742oiVEA/BA/pqBTga/Ne5ygY7yAQDFG54MAmfkYMHCW2n0Yg+ploYBKZu2
         k3gZ9QDOQRARAV7iDPqFtkK21eCnviZBwcCRX3JCwIg7nsbZrSUfwy3EDN7d2jiAzE2+
         UtC6+X8HcDR2aVCVJSjcjBQigb3i+Xx7F1/8wcP7OV8wbQQn37rCfIXO7vLYlXVSpnaA
         5iZyQvMj/Lko7uB1benpozyefWnHBclblNM5ozvjHQZ0LMX1Q4xbVhx9DF0kSpdfD0KY
         TL7Q==
X-Gm-Message-State: ACgBeo0mrrAmgS2X9qX1oJLl3H1hpJf3azEWzmLpa1wty+ToS/UkwC/S
        7oxKRCq2qqarizbvIQOJdECBn6REsA4=
X-Google-Smtp-Source: AA6agR7cuDyIxJDxuMPYAKka6etc7s1OxIxNb1oPVVEcqVr1Xi/DUaqCZ7zmyWTd4J1E+MBtvBtwZw==
X-Received: by 2002:a0c:f0d1:0:b0:47b:36df:b1ed with SMTP id d17-20020a0cf0d1000000b0047b36dfb1edmr5287327qvl.7.1660343141047;
        Fri, 12 Aug 2022 15:25:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f17-20020a05620a409100b006b942ae928bsm2788878qko.71.2022.08.12.15.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 15:25:40 -0700 (PDT)
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
Subject: [PATCH v5 2/3] Documentation: sysfs: Document Broadcom STB memc sysfs knobs
Date:   Fri, 12 Aug 2022 15:25:32 -0700
Message-Id: <20220812222533.2428033-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812222533.2428033-1-f.fainelli@gmail.com>
References: <20220812222533.2428033-1-f.fainelli@gmail.com>
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

