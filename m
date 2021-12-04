Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36346884F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhLDXnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbhLDXnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:43:03 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F5C061751;
        Sat,  4 Dec 2021 15:39:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p18so5246775wmq.5;
        Sat, 04 Dec 2021 15:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OqnBagOxhhtF/t4GSojOaAJSnCcEzo0LpiQasnt5IRM=;
        b=ToVzTZAJUUmSNvPQB7W3Emz73dFlKNGrKoLBFEqQIxWeMlqHSb5fe2LbsrfQw+Jp8g
         6hO0qeRHogAF6XOozYoESgCr0S2Tw8ToggyWvtS37ysDUmNtWTxrXusTC4sHW/ziUZ0x
         YLS4ttEadChVAv3kLWDS/+Zpeo+EAxKcE7Sh6N4nSqIy+UJjR/fP3l7SLol3jh54+vqo
         zsIFf5witpxuzzUSFjp2UWCRZZS9VPYAdBmZQen21unM2DnwmYJrpGhLKpjlGhDAUtXl
         JvrQr4wj2K/DZgVSC47/QvcqgyDyPxk/Mi62evwfng2/OE63rq/8Ybg0fOfCND6nrQpW
         ls/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OqnBagOxhhtF/t4GSojOaAJSnCcEzo0LpiQasnt5IRM=;
        b=bvbk7BT46uI/r8XKomThdc0/rkeF2w6F08leYyn8VTw5rZj9l4Evuwzhihaa5G1Un9
         GNOHAb/xJH2gGLRIobHCNfIBMd8H71Ins9TuAMlmL4p7EtJG4a+fGqtBKL7qQLx/3VGl
         EiinnRxwFsUUWQssN7Npl+h71zpbInM+kFwwT4ttOAowzbaLzgststXwjtbhrCTqCILf
         6R5rO7ZVOSUwj5mxdHU8s57lDXsMMgSvlZsIcjAiJ3tMY0dOJKHfHFdvb9Rram7KMPnn
         MNe5i1Ocowgj6b4ykS/yXuira8QPKjMmpd9kw3O/xYdw99UoAUxYXF+1qKQKxroZiKOe
         JD8g==
X-Gm-Message-State: AOAM533a3RCD6g+md7tRw+B7+pVBnc0ETAYX+9231TGBHcZPHMJ5vWc8
        Big6W/NsdmAMFvs0lQYybBJOEbUnvHjW6Q==
X-Google-Smtp-Source: ABdhPJzeEfY4eEtFp5Du9ySdu1XeMGwkUZVdxcdwI4WiW1nT/4aIdqCV30HN/rHZmEagiNevtHA4Xg==
X-Received: by 2002:a05:600c:3b8f:: with SMTP id n15mr26942362wms.180.1638661175930;
        Sat, 04 Dec 2021 15:39:35 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p13sm8980737wmi.0.2021.12.04.15.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 15:39:35 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] intel_th: remove redundant re-assignment of pointer hubdrv
Date:   Sat,  4 Dec 2021 23:39:34 +0000
Message-Id: <20211204233934.80070-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer hubdrv is being re-assigned the same value as it was 
initialized with only a few lines earlier. The re-assignment is
redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwtracing/intel_th/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 7e753a75d23b..5de47b89a9e1 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -1048,7 +1048,6 @@ int intel_th_set_output(struct intel_th_device *thdev,
 	 * hub is instantiated together with the source device that
 	 * calls here, so guaranteed to be present.
 	 */
-	hubdrv = to_intel_th_driver(hub->dev.driver);
 	if (!hubdrv || !try_module_get(hubdrv->driver.owner))
 		return -EINVAL;
 
-- 
2.33.1

