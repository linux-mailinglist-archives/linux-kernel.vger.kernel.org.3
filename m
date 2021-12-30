Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29DA482022
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbhL3UBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhL3UBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:01:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6368BC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so13818615wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6ueGjhitt5AKVe2y1vecDo+aJ407Ip2YoygN2lvWow=;
        b=lUjJWRIwzuq9avYjFleZFvHqEKsyrzAZZA/KJA1+TgxIduC1PQ9L0mwv6Er8sOu+l4
         PVjWCLUs5p+QAlfZSvE+guw9VGRhIEeBvSpdPY8v6HpZ5+u/IqIfTINqnOOCCllnrqJ5
         4HtbpnG9VgVyLUdumUB/ttNJxoOejHYaYugPgozDclGRYeTJ3z6wNl52WwKy6QGKubmq
         xoi4k1liWeftVZ4Ns9b4IHbZnBsy5OJchinJx5KW+yg3zBWI0vQxXtAVBKztr62tlOmL
         p+PhxYCu9TnMNHz+xot0nVi4DDpbr9AzvbeD1Xi0FXvlkFESCtZhHiDumwusbk7+sJPQ
         2dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6ueGjhitt5AKVe2y1vecDo+aJ407Ip2YoygN2lvWow=;
        b=7vhUfquCEZhDjAcYG7srCx++9b2dvaL0kbtlmboygX2wEJGgUwbJycdGTJPc8PSr+q
         2NA7nsfmaDE6TK06/iF/77DHhhucl+4pdrVKeZSARhHT2K9k8b/4WrDmUAP/oXEzsJR2
         0gqmHfVKa+nRivAQuAz3uGS2UYVENu1gDF9Hj0mC1/dyAeNZNk0WIT0sdOWDQhgzz2Ud
         xeM5YwVToCCUs2BhBTbl80WoSx+DXZuFLGmnCJqHZBqx0D6BAaVeDjarps1VbLgdO91q
         iaDJmTtKW5sAPVsQ3gZz/Zm+sX1HWFU4vTe4RPga6iW/OKaYo0ox9+kMUE1lUv0THM06
         ekcw==
X-Gm-Message-State: AOAM533pnrIQltHuWPF+WRW6i2jbH2spp6KW9P2H/MyRRihZxDWvvWR0
        CB81inZamdlGnZ//qCs80vG6B/vAtV8=
X-Google-Smtp-Source: ABdhPJwYJCuNuWbv6IQMeQOBMXgAwgmi9/D3Vj51tik9Y3lsDE8f3KOAKoI5g1C7/KzHcd2ZQYtkiA==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr27058656wmh.68.1640894466941;
        Thu, 30 Dec 2021 12:01:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id o8sm29042286wry.20.2021.12.30.12.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 12:01:06 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/7] staging: r8188eu: UsbRxHighSpeedMode is set but never used
Date:   Thu, 30 Dec 2021 21:00:54 +0100
Message-Id: <20211230200059.13406-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230200059.13406-1-straube.linux@gmail.com>
References: <20211230200059.13406-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field UsbRxHighSpeedMode of struct hal_data_8188e is set but
never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 5 -----
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 104705ef170e..96db9a8e7667 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -502,16 +502,11 @@ usb_AggSettingRxUpdate(
 
 static void InitUsbAggregationSetting(struct adapter *Adapter)
 {
-	struct hal_data_8188e *haldata = &Adapter->haldata;
-
 	/*  Tx aggregation setting */
 	usb_AggSettingTxUpdate(Adapter);
 
 	/*  Rx aggregation setting */
 	usb_AggSettingRxUpdate(Adapter);
-
-	/*  201/12/10 MH Add for USB agg mode dynamic switch. */
-	haldata->UsbRxHighSpeedMode = false;
 }
 
 static void _InitOperationMode(struct adapter *Adapter)
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index e8cb093abb62..8b54f52f49e2 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -262,9 +262,6 @@ struct hal_data_8188e {
 	u8	OutEpQueueSel;
 	u8	OutEpNumber;
 
-	/*  Add for USB aggreation mode dynamic shceme. */
-	bool		UsbRxHighSpeedMode;
-
 	/*  2010/11/22 MH Add for slim combo debug mode selective. */
 	/*  This is used for fix the drawback of CU TSMC-A/UMC-A cut.
 	 * HW auto suspend ability. Close BT clock. */
-- 
2.34.1

