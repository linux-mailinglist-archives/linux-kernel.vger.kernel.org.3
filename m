Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F286F467EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383061AbhLCUYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352808AbhLCUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:24:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F2CC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:20:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so16383532edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYlniXxTR7J7OWes9rdka6OdCg5A0vL9FQbn1HK7hEc=;
        b=RpRzLpUaSCf7o5/0Telq5zdr1BeQOMXy6zIgusGRAYPIGUiz+3a0LhIaH6BQOyOEqF
         MpKXbWKWhFmZ9XPM2z+27fAjtVLgChwxh6Q9ez+vzLNXTW/f2H8PO+/HM8sn6fzeK7OJ
         F4OpBF8Voxv6Aph3bmu852GVmE+mEIPCptkRs1OeSxHBqN7rWyYwxCeCQJ4SKWeBvfvE
         J988HG6afKhWhKbQnLiY2KB9rX8YvHAj1L3nraFmygPWX/ZBV+iNaOieKjaLzPkWnHR8
         EUQ0aTM6jUEEhdLlMq6CKmOxBxow4XTK+33T4mlkau0nOEAEuVrBc/nfDnukZxLYyr6D
         cWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYlniXxTR7J7OWes9rdka6OdCg5A0vL9FQbn1HK7hEc=;
        b=o19IeWKhzKjQROx5TD/dQx8+c1vi2VsQuyD6ZK7oOH/K4bpRLa0G8YGz1dHHodSF+9
         38oKuNNr1SS12FpAi5lKkfEAxczGu/n2AEubFyKeIo5z63ci+aqalsg/FFnA3vUZkxtu
         KL/9+7q8DKVLz1vyB1szbZA/yDNESSzXgYDJnVbkPIgpi2EKe38yP3I+EbnqjzSKtmmx
         DFKhV5Oqi4m45sxcpiO29ges5mGPtE6tGEjU5hGJa+BNIBwH1HBPV6M8z9tx9zK0aJJy
         8Y9nCdz2EgfIXRU3cQePhvcgyIVRYGkwr8NXSjDQNym+/CbZa+BPfqLFVTJ4CELRpMwO
         34dg==
X-Gm-Message-State: AOAM530sr0H8CAyz1QY3byfZfhrwJaRgL7J+oAqLWZCHF5/cYe+UWQ63
        lqSb2XmJaRa8epx3x3BcJOU=
X-Google-Smtp-Source: ABdhPJyk/q71i8JmucdKj3hZLHe1pDU+GubdZr8P39xQUV3QL4rdKEKm+MoUYfF3WleOaZsG90nhqg==
X-Received: by 2002:a17:906:eb8a:: with SMTP id mh10mr25171779ejb.198.1638562841273;
        Fri, 03 Dec 2021 12:20:41 -0800 (PST)
Received: from bulldog.fritz.box (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id sh33sm2654655ejc.56.2021.12.03.12.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:20:40 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6655: refactor byRadioCtl to radio_ctl
Date:   Fri,  3 Dec 2021 21:18:37 +0100
Message-Id: <20211203201839.3806539-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase hungarian notated variable "byRadioCtl"
into linux kernel coding style equivalent variable "hw_radio_off".

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---

v1 -> v2
- Correct mail subject

 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index c51eba94230d..245f992e5a23 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -227,7 +227,7 @@ struct vnt_private {
 	bool bPWBitOn;
 
 	/* GPIO Radio Control */
-	unsigned char byRadioCtl;
+	unsigned char radio_ctl;
 	unsigned char byGPIO;
 	bool hw_radio_off;
 	bool bPrvActive4RadioOFF;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 897d70cf32b8..37a82550ca82 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -371,18 +371,18 @@ static void device_init_registers(struct vnt_private *priv)
 
 	priv->radio_off = false;
 
-	priv->byRadioCtl = SROMbyReadEmbedded(priv->port_offset,
+	priv->radio_ctl = SROMbyReadEmbedded(priv->port_offset,
 					      EEP_OFS_RADIOCTL);
 	priv->hw_radio_off = false;
 
-	if (priv->byRadioCtl & EEP_RADIOCTL_ENABLE) {
+	if (priv->radio_ctl & EEP_RADIOCTL_ENABLE) {
 		/* Get GPIO */
 		MACvGPIOIn(priv->port_offset, &priv->byGPIO);
 
 		if (((priv->byGPIO & GPIO0_DATA) &&
-		     !(priv->byRadioCtl & EEP_RADIOCTL_INV)) ||
+		     !(priv->radio_ctl & EEP_RADIOCTL_INV)) ||
 		     (!(priv->byGPIO & GPIO0_DATA) &&
-		     (priv->byRadioCtl & EEP_RADIOCTL_INV)))
+		     (priv->radio_ctl & EEP_RADIOCTL_INV)))
 			priv->hw_radio_off = true;
 	}
 
-- 
2.25.1

