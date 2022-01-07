Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C783B4875AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbiAGKgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346800AbiAGKgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23931C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w16so20353626edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CfP3gmv1Q7HUVGnEeNqV+K84WsivcSZYZ8kexJOYm58=;
        b=hotIENNn/JBp3WvMcltnuAjEai6Vr/7EjnKXvgP0MKulZEmBaBMoQ6FVSt1BGP+Uxc
         36tMGwUPtiSpF2nM6qVTk0L1Mi+AxI8C2J1aygQRY7jeLFxP6mtNwfvJx1t7sSectWM1
         dF0esgp4gHabIckVnw9iM0JAYdhD9HZdXytGm7ZwEzeXBBI6jmBIg+Iy1Rg4Vqw9w7u1
         HgS/dCsjiApx3OtTbiYsdvetQ+K4TTEwvvNNRe2ly/vgdX3jTKx5dSKWhwJdZApvn0xO
         w+M0NaC6YfKaNnHwRnfdEGcb8Ya7NN2f+VF1I+OU6g7C0M1Vt6W0o/8ulhIvUU960qgT
         qGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfP3gmv1Q7HUVGnEeNqV+K84WsivcSZYZ8kexJOYm58=;
        b=MsGuTvHy4fHV8VlvO7k8GBn4aDMZNl9XqvvqIqCzGPpLmV99OmGYwsZxO3jV+fhjEY
         DSPLxvUx/DhYWMmZbG9Bh2Ocy0XPNURPuD39k9rJC+ekXO6pRexCtIgb/WdWyadUiZEJ
         Xzv1tzuD1iv5UDeWDobYbzZSm1HcFcmL/ui2I/Tby8QFWdbDRTisTanJHT1G19PUiVn4
         LWq5GSHYbpZs7BBKa+PF43Nq7JsbOzy7ra68vxYNoq0iceUsWNj6nbBdfVsAH6v+I6mw
         Mtg/HmOYyPT8ZS19VWUx8NYgQ/crcZeADrs6Tpbn0gQ4BPkEkaSvY51tINT5S3R9oPMO
         0gBQ==
X-Gm-Message-State: AOAM530y1BAkhOvMXZeZ8SdrTI80iQzf5pegfUCWC0YBJKZJxs49/gaT
        L+X+dMGDmOKIVvs8XW78488=
X-Google-Smtp-Source: ABdhPJwL5PfDscG+CG6dwqKJUsHmP6pN1FsbvPCQ8T92tXW/X6XcetH1zn46rdv0Dugxbzz4Qk5tiQ==
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr50734068ejc.476.1641551794822;
        Fri, 07 Jan 2022 02:36:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:34 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/19] staging: r8188eu: use kmemdup instead of kzalloc and memcpy
Date:   Fri,  7 Jan 2022 11:36:10 +0100
Message-Id: <20220107103620.15648-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup instead of kzalloc and memcpy in load_firmware().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 7 +------
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index ee684b37ff91..f7ae2fc0d2b9 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -525,18 +525,13 @@ static int load_firmware(struct rt_firmware *rtfw, struct device *device)
 		ret = _FAIL;
 		goto exit;
 	}
-	if (fw->size > FW_8188E_SIZE) {
-		ret = _FAIL;
-		goto exit;
-	}
 
-	rtfw->data = kzalloc(FW_8188E_SIZE, GFP_KERNEL);
+	rtfw->data = kmemdup(fw->data, fw->size, GFP_KERNEL);
 	if (!rtfw->data) {
 		pr_err("Failed to allocate rtfw->data\n");
 		ret = _FAIL;
 		goto exit;
 	}
-	memcpy(rtfw->data, fw->data, fw->size);
 	rtfw->size = fw->size;
 	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", rtfw->size);
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 3da04751f25d..051f3b9fe726 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -35,7 +35,6 @@
 #define PageNum_128(_Len)	(u32)(((_Len)>>7) + ((_Len) & 0x7F ? 1 : 0))
 
 /*  download firmware related data structure */
-#define FW_8188E_SIZE			0x4000 /* 16384,16k */
 #define FW_8188E_START_ADDRESS		0x1000
 
 #define MAX_PAGE_SIZE			4096	/*  @ page : 4k bytes */
-- 
2.34.1

