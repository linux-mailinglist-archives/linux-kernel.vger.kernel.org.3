Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86A947C8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhLUV64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbhLUV6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:58:48 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219E4C061574;
        Tue, 21 Dec 2021 13:58:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m21so1881490edc.0;
        Tue, 21 Dec 2021 13:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86w3eyiKacs5uaGphCz79xA1hlTYBtSnubTIMb1PBmo=;
        b=XB2Tr6o9qTFoFmGFrFf4pXRwC7i8kMvVUaT+EB+JEvNRTEMIlc/1p5lGZ39m8XMk7S
         GRkcB52AK2sy29ELZhUGSYfhC5uiRToawfsjedoZTxIysPAdrE3PLHVXCy0RVK6NcMWQ
         uM8FrHXrQOb/16bzkGggCTr22d1Xu28VXRBzPjdSXvdcO8OQnVj4UgLQ2iag1hszGK2n
         eA61+pnfVavEMtzg0vHKKaKHWpWhbBnQu6EGpSYm/BRKEtg2s6cyG2mQ5jynOYT2ots7
         7m3XEymFa7yw9bWex/hqItU80e5xUzVBTAnVThUFWAgIcTY+FlTKrw3gF/Hqo5AMYOqT
         wOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86w3eyiKacs5uaGphCz79xA1hlTYBtSnubTIMb1PBmo=;
        b=fzKD2A8jGw+ZS6ZkbhPBxgANl0gYy3Ar1spbCI++5Ih4PY6d2nkK/xHKbapEVKomcN
         J4YRWo6U7oBJZgsVZaQA/S1aB91P+ZVZw4ZQywJHQOviXfR4XrDXCCYSCu7PguQtxQoR
         fZtLh07KkYF5YLnuo7mU2Ct6cAqbIPKz4tAkIYvPulme7gtFcqYSufGoJDOGDBWd24/3
         Y4cq+sRuRHR8dJO54BGjWxLgCDovj7UjdZ52Y4ycEB9+urFGazhU5BtVwV7hr3N4WqjD
         v5AI+Vc1BvSt92aD48ndONtFGqfB3Y2IOXp24+0GlPDbOwl745wnjNm7PPMUdJ5d47wn
         Yx8A==
X-Gm-Message-State: AOAM532z5/zuS1ncdPAL9RSnN6s4fCAgGYtFdEdtRG91EkE1rYAaNR/2
        ZwqZ/OqscMcFMWmzPhrNvOY=
X-Google-Smtp-Source: ABdhPJw9HbpnoQ5r4jEJa9z3MfkenIhrxCUjYfO33xFG0Xtb+uqiWGhCGyyAr0OJuW0wGW83BINjtA==
X-Received: by 2002:a17:906:2192:: with SMTP id 18mr189324eju.635.1640123926767;
        Tue, 21 Dec 2021 13:58:46 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id nc29sm41640ejc.3.2021.12.21.13.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:58:46 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] hwmon: (adt7x10) Use devm_request_threaded_irq
Date:   Tue, 21 Dec 2021 23:58:38 +0200
Message-Id: <20211221215841.2641417-5-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221215841.2641417-1-demonsingur@gmail.com>
References: <20211221215841.2641417-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

To simplify the core driver remove function.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 2e6e54bf1d15..84e8879d4ca7 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -450,9 +450,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	}
 
 	if (irq > 0) {
-		ret = request_threaded_irq(irq, NULL, adt7x10_irq_handler,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				dev_name(dev), dev);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						adt7x10_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						dev_name(dev), dev);
 		if (ret)
 			return ret;
 	}
@@ -463,8 +465,6 @@ EXPORT_SYMBOL_GPL(adt7x10_probe);
 
 void adt7x10_remove(struct device *dev, int irq)
 {
-	if (irq > 0)
-		free_irq(irq, dev);
 }
 EXPORT_SYMBOL_GPL(adt7x10_remove);
 
-- 
2.34.1

