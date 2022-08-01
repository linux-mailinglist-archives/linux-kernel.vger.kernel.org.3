Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84745873C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiHAWJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiHAWJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:09:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B023DBEF;
        Mon,  1 Aug 2022 15:09:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c139so11864725pfc.2;
        Mon, 01 Aug 2022 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QGLoUgJ2TVf85FNO9ppA71x6uLHjiN5oNLDyUkLBWZY=;
        b=d17UTAAusi4TBrUbIR23vHVok0T2hvu6Y3UqOXgIdu9XjfmaFkav7NLPJlA4rrQ51l
         A6WbBQrWXUeaY9kjPHHjRAWv1OyUf6VE19+9gkfihXBtphKEcFD/biOE1KROZWcnyGqk
         WSEtWUC4EjSTvLNEOibR1+/Y9IKTxd1skcrNkofc7j2ItYRUS0z6JOkHRWQu0ptSwplO
         pQxtgUX1ZzpTtXOF+OA4yh/qYmr+nw810M4RLAViQkHTYrKlkfjlcvEe4wr033c0R3pd
         vzvGD9PIXpjLRR1TQQ++Pq3M0yH4FePMwc0kTmsDKX/HQRy4BF5UubcgEhEucXSU51MX
         mWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QGLoUgJ2TVf85FNO9ppA71x6uLHjiN5oNLDyUkLBWZY=;
        b=sEDJ9pKAQuYOWF8CdZgK4EZhZVppe00+r9v+WOdVFyNac4WsVJYlVv69lRKZ7uQ/VW
         Y8k5fQ1jUaMwLB+KR0fNAi2zwXhy3oSPbK3ucfpSyE1d41KsyW5/nvvJjDEUffGurFTN
         oTm6Qs85kynQxKSQTDbKd9m8B8c+prGj6T8y7zeZRUtknzXtbZxwkKQ2nPF3m7zVjXuv
         DsocBQAgn9E/aijAvDRNDTDKzmx7U5AMZUHZSAjOGCR6+ObKDj/1VGcvSOB4L6prm6Q9
         9x0Y/gR9DMiExU0YSNYKbpiYqiYdtDQ9JJ3yVEKmktxPwhD5UdtrAw1RssA1mrW4eEN0
         kNAQ==
X-Gm-Message-State: ACgBeo2lsWBmqN7uPL0YftIVGdyWGXayXRcGOJeE3EGiLRiIh5F4ysl6
        NdymbWH/hEt7A7aw+Ib3QFdUqGFHYao=
X-Google-Smtp-Source: AA6agR5p/8/L7QGjOX3paswtlMvKpAhdmTYJkzqy7UoM1PMVtFVUInrh/cP4uqSIy/1hUQWRetqzNA==
X-Received: by 2002:a05:6a00:e1a:b0:52d:9c84:24c1 with SMTP id bq26-20020a056a000e1a00b0052d9c8424c1mr4366312pfb.13.1659391776705;
        Mon, 01 Aug 2022 15:09:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001637529493esm10136969plq.66.2022.08.01.15.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:09:36 -0700 (PDT)
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
Subject: [PATCH v3 2/3] Documentation: sysfs: Document Broadcom STB memc sysfs knobs
Date:   Mon,  1 Aug 2022 15:09:30 -0700
Message-Id: <20220801220931.181531-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801220931.181531-1-f.fainelli@gmail.com>
References: <20220801220931.181531-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

