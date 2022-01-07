Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2153B487D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiAGUJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiAGUJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:09:40 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB318C061574;
        Fri,  7 Jan 2022 12:09:40 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 196so5995129pfw.10;
        Fri, 07 Jan 2022 12:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GlqDBj+o7dtbgmxyDQt1Xa3p3CMvoVc4XzadBcBPSMs=;
        b=Ko7KadctNlBORJ1zGN2ork73KBy8HZ1hh5VCBFLcZStax0lvs+5+ppww77Xofej6qv
         OWh1YI2iWKi192wCCY7JWQxLeQPltKA1Zkqws4qb/tIkFI5fxTyIGZOMpi0GBS91Eryx
         MUS1hkwyIxy4sW1jQ+i7BV5RMJPuEZ6y+CVIgWDZ0Uwyw/SJ/z5cY4geg1C02aVVLYAz
         mbCZBaHtkRTW3kgqgzB/IhadhY10Q1AZXHcUrHGsJw3z7cpX7iJx42vfzWJK5NOT2ZkR
         b/P+/aPIfKJc0XZYjpMErUNS/xWfCl1ZAMjsRme5iDbmqe62csr8hZuOGvLkTkvYSP6G
         zUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GlqDBj+o7dtbgmxyDQt1Xa3p3CMvoVc4XzadBcBPSMs=;
        b=L3MeBJN05qpFAdq6CB5UNsPQsgegsg1GUZvjA8G6WgNRfPOrlaoUg5bOvE9Sb69WxB
         yNGZ6GfCDOAZG5nyty5oi9dHkXyXCM0nM6hmtFKntfIR6SZqwjmOSv87YIPD+PUXLtab
         bxjq5AfWhvqYmg6E6a6/huTeIGd1jfGsJJKfso8aY2fXvFlGf63f7BQLGAPXx9J+yeX3
         epXGWPRyfUyuVTcY4uR09Nlp6va30xBgJ/oqIUkTq8AREPYS+dCvulyFcXK9ftJp/f51
         1gVNrVpzlkxn89MamPt9Z+VzOpURZxIbzv01EEyqad2JY4xz9fDFrp7ZA79AMNzDtkhA
         ST5w==
X-Gm-Message-State: AOAM530MalKQk5e39ofyx6ZjVLfgIn0bkMV6SipM+FsxmzlC/hQGKW+L
        zk2y3KDP25AIIRwxeV5lEa4=
X-Google-Smtp-Source: ABdhPJytZqaW5DORPA4lj3/5A7nmp8m43uQl6FaEno3S09mBW/vJA6j1SghEeVvS8bV3fV0qydJcDw==
X-Received: by 2002:a63:a74d:: with SMTP id w13mr3521394pgo.7.1641586180167;
        Fri, 07 Jan 2022 12:09:40 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4a85:a3d:72a9:2009])
        by smtp.gmail.com with ESMTPSA id z15sm6689735pfh.201.2022.01.07.12.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 12:09:38 -0800 (PST)
Date:   Fri, 7 Jan 2022 12:09:36 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Sean O'Brien <seobrien@chromium.org>,
        Ting Shen <phoenixshen@google.com>,
        Stephen Boyd <swboyd@google.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: vivaldi: fix handling devices not using numbered reports
Message-ID: <YdieAFj0ppmAtQxS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately details of USB HID transport bled into HID core and
handling of numbered/unnumbered reports is quite a mess, with
hid_report_len() calculating the length according to USB rules,
and hid_hw_raw_request() adding report ID to the buffer for both
numbered and unnumbered reports.

Untangling it all requres a lot of changes in HID, so for now let's
handle this in the driver.

Fixes: 14c9c014babe ("HID: add vivaldi HID driver")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

CrOS folks, please help testing this as I do not have the affected
hardware.

Thanks!

 drivers/hid/hid-vivaldi.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
index cd7ada48b1d9..1804de1ef9b8 100644
--- a/drivers/hid/hid-vivaldi.c
+++ b/drivers/hid/hid-vivaldi.c
@@ -71,10 +71,11 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
 				    struct hid_usage *usage)
 {
 	struct vivaldi_data *drvdata = hid_get_drvdata(hdev);
+	struct hid_report *report = field->report;
 	int fn_key;
 	int ret;
 	u32 report_len;
-	u8 *buf;
+	u8 *report_data, *buf;
 
 	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
 	    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
@@ -86,12 +87,24 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
 	if (fn_key > drvdata->max_function_row_key)
 		drvdata->max_function_row_key = fn_key;
 
-	buf = hid_alloc_report_buf(field->report, GFP_KERNEL);
-	if (!buf)
+	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	if (!report_data)
 		return;
 
-	report_len = hid_report_len(field->report);
-	ret = hid_hw_raw_request(hdev, field->report->id, buf,
+	report_len = hid_report_len(report);
+	if (!report->id) {
+		/*
+		 * hid_hw_raw_request() will stuff report ID (which will be 0)
+		 * into the first byte of the buffer even for unnumbered
+		 * reports, so we need to account for this to avoid getting
+		 * -EOVERFLOW in return.
+		 * Note that hid_alloc_report_buf() adds 7 bytes to the size
+		 * so we can safely say that we have space for an extra byte.
+		 */
+		report_len++;
+	}
+
+	ret = hid_hw_raw_request(hdev, field->report->id, report_data,
 				 report_len, HID_FEATURE_REPORT,
 				 HID_REQ_GET_REPORT);
 	if (ret < 0) {
@@ -100,7 +113,16 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
 		goto out;
 	}
 
-	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf,
+	if (!report->id) {
+		/*
+		 * Undo the damage from hid_hw_raw_request() for unnumbered
+		 * reports.
+		 */
+		report_data++;
+		report_len--;
+	}
+
+	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
 				   report_len, 0);
 	if (ret) {
 		dev_warn(&hdev->dev, "failed to report feature %d\n",
-- 
2.34.1.575.g55b058a8bb-goog


-- 
Dmitry
