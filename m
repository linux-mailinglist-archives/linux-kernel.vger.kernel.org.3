Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52C0465330
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351651AbhLAQs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:48:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:26294 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351554AbhLAQrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:47:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216512549"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="216512549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:23 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="512784005"
Received: from razaahme-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.36.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:43:20 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [RFCv3 4/7] HID: input: Make hidinput_find_field() static
Date:   Wed,  1 Dec 2021 18:42:58 +0200
Message-Id: <20211201164301.44653-5-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201164301.44653-1-tero.kristo@linux.intel.com>
References: <20211201164301.44653-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

This function is not called outside of hid-input.c so we can make it
static.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/hid-input.c | 4 ++--
 include/linux/hid.h     | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index b428ee9b4d9b..f6332d269d49 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1477,7 +1477,8 @@ void hidinput_report_event(struct hid_device *hid, struct hid_report *report)
 }
 EXPORT_SYMBOL_GPL(hidinput_report_event);
 
-int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field)
+static int hidinput_find_field(struct hid_device *hid, unsigned int type,
+			       unsigned int code, struct hid_field **field)
 {
 	struct hid_report *report;
 	int i, j;
@@ -1492,7 +1493,6 @@ int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int
 	}
 	return -1;
 }
-EXPORT_SYMBOL_GPL(hidinput_find_field);
 
 struct hid_field *hidinput_get_led_field(struct hid_device *hid)
 {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 96eaca0d5322..3f1fd4fcf1a9 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -636,7 +636,6 @@ extern void hidinput_disconnect(struct hid_device *);
 
 int hid_set_field(struct hid_field *, unsigned, __s32);
 int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
-int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field);
 struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
 __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);
-- 
2.25.1

