Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF13487F56
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiAGXXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiAGXXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:23:08 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE05C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:23:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso12170941pjm.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oxC+muJBkXyTXQKgCJPwxGyWw5oodW+7FxxEHsth64I=;
        b=I6a7SZ191VKBPHyZmGgVbGyFdLC+t75d/evttp8v9noPdYLAiXmlZGFjTNYPF6kgBS
         jGMdx6fzlmGVTavNkR3tNyhaT9CVd5TPtOD/UBOLiyp7fHrJO4b/ihHzRVD9XfDsY3Mh
         KniCDD/3TXvkwyvm1+3xPBw8pwTRc5EQY5w54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oxC+muJBkXyTXQKgCJPwxGyWw5oodW+7FxxEHsth64I=;
        b=t2Ty1RQ4grYC6ww2aXbTYI/XHEvtJon/hBGcyNeXMN3LGIPyVYvENzBocOw13tYRRj
         KIyBsow2xA4AGxnCDB6d8YWlPfesOZ3i6t9ugBcFpxlwUfq4szmrvnHy12OzPVZuhLkY
         OkJKbDFzBxp0My96JY5sqePO+UecowUfOFgg9bO9VMCFm2MNlPdqIiV/DJUh3EGURT9J
         YStjw3oo503HzaP8DCEutHohbzjAKOKSvPpAs3Kri+A11CSQgi1lYZZO0sxyZIfGxl+5
         XEhfknK0CT+8SyumHukIT4KtgBcQ4xxCFl+meOY96wCyN5NUBdYw8aDsC9SD0US0/VFi
         xwuw==
X-Gm-Message-State: AOAM533oo/utwPMjZdWkFYTwpqrR217y36oL5TVfP7HOHs52dbWxUMFo
        fT+rlhJPnCC9ifgRS8hF4EMRGVIC+yhbXA==
X-Google-Smtp-Source: ABdhPJwtrVhfglFzXEu1lt2wh8t6OM217nC2ZYrJ1WTSR3xsUgRd677L8RQLFW4dxUWhBrtOqMMFRw==
X-Received: by 2002:a17:902:e749:b0:148:a4e1:4fb4 with SMTP id p9-20020a170902e74900b00148a4e14fb4mr64192916plf.111.1641597787528;
        Fri, 07 Jan 2022 15:23:07 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5681:18f1:24f0:d55c])
        by smtp.gmail.com with ESMTPSA id v12sm24291pgc.13.2022.01.07.15.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:23:07 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Sean O'Brien <seobrien@chromium.org>,
        Ting Shen <phoenixshen@chromium.org>
Subject: [PATCH] HID: vivaldi: Minor cleanups
Date:   Fri,  7 Jan 2022 15:23:05 -0800
Message-Id: <20220107232305.3190198-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perform some minor cleanups on this driver. Include header files for
struct definitions that are used, drop a forward declaration that isn't
useful, and mark a sysfs attribute static as it isn't used outside this
file.

Cc: Sean O'Brien <seobrien@chromium.org>
Cc: Ting Shen <phoenixshen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/hid-vivaldi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
index cd7ada48b1d9..90ebb33380b7 100644
--- a/drivers/hid/hid-vivaldi.c
+++ b/drivers/hid/hid-vivaldi.c
@@ -6,16 +6,17 @@
  * Author: Sean O'Brien <seobrien@chromium.org>
  */
 
+#include <linux/device.h>
 #include <linux/hid.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sysfs.h>
 
 #define MIN_FN_ROW_KEY	1
 #define MAX_FN_ROW_KEY	24
 #define HID_VD_FN_ROW_PHYSMAP 0x00000001
 #define HID_USAGE_FN_ROW_PHYSMAP (HID_UP_GOOGLEVENDOR | HID_VD_FN_ROW_PHYSMAP)
 
-static struct hid_driver hid_vivaldi;
-
 struct vivaldi_data {
 	u32 function_row_physmap[MAX_FN_ROW_KEY - MIN_FN_ROW_KEY + 1];
 	int max_function_row_key;
@@ -40,7 +41,7 @@ static ssize_t function_row_physmap_show(struct device *dev,
 	return size;
 }
 
-DEVICE_ATTR_RO(function_row_physmap);
+static DEVICE_ATTR_RO(function_row_physmap);
 static struct attribute *sysfs_attrs[] = {
 	&dev_attr_function_row_physmap.attr,
 	NULL

base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
-- 
https://chromeos.dev

