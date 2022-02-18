Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6044BC2E5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 00:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiBRXgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 18:36:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiBRXgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 18:36:14 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3523088C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:35:56 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 195so9121367pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZsLTrBtK3TIKi6znBawoZ+YQgveHVMJBjVViZ+ZI9I=;
        b=ocTW4xYVtEUiFTHfgGa+DOZ3/hoX+WD3Wf1H9QiD5tNx13dO4c3aByIXRRfjIIw26T
         ec/0nrFthMMRbJVd+vUeV9kFC/Qb8/iaklFLAnfJOcSWpOIcyLpAs7hhwIeYqa8zJbRE
         tn8pgie1KedOUPI9ejghACw/hdQ3HJIaaXV60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZsLTrBtK3TIKi6znBawoZ+YQgveHVMJBjVViZ+ZI9I=;
        b=pQW0ObXmW2IXvav5onXu4ab8jhiVcca49vqCvhfuXwVVt09N8vknuPCi88uzsdD/bT
         qz/XUWq7sB2RvyoTuOLGZeT3vwMzUY5Qxb+sPCZRURPjz5x/G9+h6cRo0aF1XswqScUk
         Xirmx1nwFE3w+K6oEwlTZsAl2KLVYgSB7H5M52GNCqmb8WtmbF2f1l2n1o5v+WbKwLzn
         M7NcsYE8GquaLJ3aqb4fW3yJ2xR67EMYNHrm21MrIf7NBwuhI3CgJoaLnroFWDDZ4+0v
         dZus5nv7fGgbeMMKYRtlTc2B0sL4ZF489obYeJJb/Iq4HoxxBljJiMZM/EkPUvASS17+
         QC7A==
X-Gm-Message-State: AOAM5310eWgrr2USod7l7kzMk5jdjWAm3ZO5xrnfcqTfmzF10j1jYxDO
        oipgIxN/Gi/7WUyku8lhqkRLzjvvSZx+4Gvw
X-Google-Smtp-Source: ABdhPJzOVNsmTySJHEEohgFGoycKrY0tIQxTBWSDZG2SaaSNf3OYI9SLqmPS3zPPoS/8g11Q03/1sw==
X-Received: by 2002:a05:6a00:c95:b0:4e1:3259:f7ad with SMTP id a21-20020a056a000c9500b004e13259f7admr9717807pfv.43.1645227356208;
        Fri, 18 Feb 2022 15:35:56 -0800 (PST)
Received: from wmahon.c.googlers.com.com (218.180.124.34.bc.googleusercontent.com. [34.124.180.218])
        by smtp.gmail.com with ESMTPSA id i17sm11967109pgv.8.2022.02.18.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 15:35:55 -0800 (PST)
From:   William Mahon <wmahon@chromium.org>
X-Google-Original-From: William Mahon <wmahon@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     William Mahon <wmahon@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH v2] HID: Add mapping for KEY_ALL_APPLICATIONS
Date:   Fri, 18 Feb 2022 23:35:49 +0000
Message-Id: <20220218233350.1.I3a7746ad05d270161a18334ae06e3b6db1a1d339@changeid>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new key definition for KEY_ALL_APPLICATIONS
which is an alias of KEY_DASHBOARD.

It also maps the 0x0c/0x2a2 usage code to KEY_ALL_APPLICATIONS.

Signed-off-by: William Mahon <wmahon@google.com>
---

 drivers/hid/hid-input.c                | 2 ++
 include/uapi/linux/input-event-codes.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index eccd89b5ea9f..c3e303c1d8d1 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1162,6 +1162,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 		case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT);	break;
 
+		case 0x2a2: map_key_clear(KEY_ALL_APPLICATIONS);	break;
+
 		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
 		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
 		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 311a57f3e01a..e520f22c1b8d 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -279,6 +279,7 @@
 #define KEY_PROG3		202
 #define KEY_PROG4		203
 #define KEY_DASHBOARD		204	/* AL Dashboard */
+#define KEY_ALL_APPLICATIONS KEY_DASHBOARD
 #define KEY_SUSPEND		205
 #define KEY_CLOSE		206	/* AC Close */
 #define KEY_PLAY		207
-- 
2.35.1.473.g83b2b277ed-goog

