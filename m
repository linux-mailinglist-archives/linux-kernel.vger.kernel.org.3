Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46EE482706
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiAAISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiAAISH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:18:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8ADC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:18:07 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s1so59598035wra.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VHZWSW7IZYW+tuJsgx1W6d7mxzf81jEGBsUolGkzPM=;
        b=bjmxPyvwNFTPhYcJcUJ98dC8ps/bBGutyg7IHwbG8rgvwxO100qA2EiNa4UFb9mShc
         bae19aCnDi7jaub2Zoyp4I7YMQu8AZwV1QK9tz42eRF9IkyS4W/xFTXaEJBGwWgcEoRe
         s1dnOsjp1iGyP1eoqBBy1O2AxuRNI8hD/KfGeV5eEjEku1xh+iDBnNRW+LkWcUvR+P6/
         Yg4cZlcZQxk5XYyvYlUXXN/FGjRByzIhSbcKFFQHeym1cQxJVxdUqHoSeiGdPAXEaZ8Z
         sv7Q9uQ0CwBpg6c3YdUQDzVtQU3eza/RLHNyhv9BBVj4PRz41eWCQsizbrZg2vEUowhs
         IQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VHZWSW7IZYW+tuJsgx1W6d7mxzf81jEGBsUolGkzPM=;
        b=m1cVBGTlQtgYQnysMQtZTo8GxP5Nfasou8kM4o2EX1ubyMLyuSOVAfoclsQ+H6R/x4
         rL6bn710OfSMMUhtsnxsNRxvS+f8H0Yzuznw2LfLgc9kR12301o1iDhL1NC+MCk8NjHs
         UpDuls6F02/BPn/kRlWWTcAtb3lK8juXPzB3JAO9N+r4h3vcOv/qxTEd5BP7Zh0ayfUa
         F6dLyjMnKpeXJLMsT6TS5BlxdC/A4gBCIro8wzbytp4OxocZu+1DCD2GmQff7o9VUD1W
         FOC+cX3e6Ly9eLhYUcGEooScZTxUUrp9egKWmGTD50WU8NHa3jvQWsLhLi+QJLcPdBAM
         HR5A==
X-Gm-Message-State: AOAM530uL4qbacsWbWjO5mYdqtTX0PDobFcuHfdO6x4ah2I32bJKs0g8
        ZHfpUBnopgOHn5XXP8qvM+w=
X-Google-Smtp-Source: ABdhPJxJ33tHYsaHYW+ck0zvMCQIMLYjLwMF6L5bYlo5BOanRAOHbvX6mKtjbZcgesDeUu3mz82hZA==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr32116271wrn.378.1641025085625;
        Sat, 01 Jan 2022 00:18:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id u9sm30693651wmm.7.2022.01.01.00.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:18:05 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/7] staging: r8188eu: UsbRxHighSpeedMode is set but never used
Date:   Sat,  1 Jan 2022 09:17:53 +0100
Message-Id: <20220101081758.9716-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101081758.9716-1-straube.linux@gmail.com>
References: <20220101081758.9716-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field UsbRxHighSpeedMode of struct hal_data_8188e is set but
never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

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

