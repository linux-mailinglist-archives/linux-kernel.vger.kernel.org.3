Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22016496052
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350704AbiAUOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380952AbiAUODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:03:53 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE74C06175D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:03:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay14-20020a05600c1e0e00b0034d7bef1b5dso22579332wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9Qbow8A0YPWPn3/lM+2GnA7PMQAnbZ2M1lFPHFZxvI=;
        b=iLBvT1rCA9fzZwk3qDs+fOqABHEY57jiB8s6aoCN2xtmXNgFBPi8cTSJ6M+sjOxfKD
         ML5LjOJJmQaxWaMgHGMOkqXx9FAKKH0RSJ1gxob9voRk1h+hqcb65A5NZPYuLrnO8+oQ
         +fUCJzkLi8vOoZ+YUkDI9ZNFiaoLd8UJ8E1xmD2qhNdmzv6lIUii/8wLPBslyy5gyxy5
         ieiVr8m+9jjE5ZKvDwjg0mCUp/wjjSs4n0VXMOsRmZ14yBIGPZqIcBMt8uqGi9S+jzvd
         3qZTi3PzWk/oNQMoTRkjYQ/Rk35xR1gJyFyjXMa4cWfPOUwATdabAQivzxwD6yRZ0NBF
         b4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9Qbow8A0YPWPn3/lM+2GnA7PMQAnbZ2M1lFPHFZxvI=;
        b=SxtLBtC7nW+aPytzbeohTmdHaE7MqNQtmXA3ffbnNgEjK1/u7fNZwqaCLAZm8i2iq/
         XLSzREjUXm3Z+Qnha7vy7Ls4C1U6owclhxmJ0ynLnVSTELZ9k2qGTbt49IGjBKMc1BeK
         3QBhU1cWpBGkXO5JaFRtpIofp0yG5ykqY3BuWM2WPYwjsDHm6dAXWOJdPLeE7wUOIHAo
         vZu3Q4gGjKoxAQbOqGtNkrtMIwL2i0vuqoVfIyWOfLy8pDBjiZZSEOLgmNF30GvpK75d
         xIq6WGVTtR9aRvfkueCdG9QjT/N5MW0ZC9JcsFg9jpnYdMsGnfO477RxkIPM/Pw1kI0s
         kf+Q==
X-Gm-Message-State: AOAM530RsRdWUKAIhH7pUAdb2V16JS/vesPR/jX8e6zL7Snde72SjRpq
        IrGjs2cghQIRVX/HjyM5mssNjw==
X-Google-Smtp-Source: ABdhPJze8JkZPt8YeJNz4+qQXr+QI1NypQGJpv1iLMTMx8IGenCg7ujdHDkOBgABZTcC58knzAWJHg==
X-Received: by 2002:a1c:1d45:: with SMTP id d66mr899724wmd.24.1642773809302;
        Fri, 21 Jan 2022 06:03:29 -0800 (PST)
Received: from groot.home (lfbn-tou-1-205-205.w86-201.abo.wanadoo.fr. [86.201.52.205])
        by smtp.gmail.com with ESMTPSA id p29sm9225129wms.5.2022.01.21.06.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 06:03:29 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: input: mtk-pmic-keys: add MT6358 binding definition
Date:   Fri, 21 Jan 2022 15:03:21 +0100
Message-Id: <20220121140323.4080640-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220121140323.4080640-1-mkorpershoek@baylibre.com>
References: <20220121140323.4080640-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation of the mtk-pmic-keys for the MT6358 PMICs.

MT6358 is a little different since it used separate IRQs for the
release key (_r) event

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
index 535d92885372..9d00f2a8e13a 100644
--- a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -9,7 +9,10 @@ For MT6397/MT6323 MFD bindings see:
 Documentation/devicetree/bindings/mfd/mt6397.txt
 
 Required properties:
-- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+- compatible: Should be one of:
+	- "mediatek,mt6397-keys"
+	- "mediatek,mt6323-keys"
+	- "mediatek,mt6358-keys"
 - linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
 
 Optional Properties:
-- 
2.32.0

