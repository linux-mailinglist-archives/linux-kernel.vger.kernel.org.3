Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6046FF8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhLJLPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:15:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:54474 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237471AbhLJLPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:15:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301711575"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="301711575"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:12:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="516720824"
Received: from ccrisan-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.210.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:11:58 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [PATCHv4 4/5] HID: input: Make hidinput_find_field() static
Date:   Fri, 10 Dec 2021 13:11:37 +0200
Message-Id: <20211210111138.1248187-5-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
References: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

This function is not called outside of hid-input.c so we can make it
static.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/hid/hid-input.c | 4 ++--
 include/linux/hid.h     | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 78205e445652..1179ef1d257a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1463,7 +1463,8 @@ void hidinput_report_event(struct hid_device *hid, struct hid_report *report)
 }
 EXPORT_SYMBOL_GPL(hidinput_report_event);
 
-int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field)
+static int hidinput_find_field(struct hid_device *hid, unsigned int type,
+			       unsigned int code, struct hid_field **field)
 {
 	struct hid_report *report;
 	int i, j;
@@ -1478,7 +1479,6 @@ int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int
 	}
 	return -1;
 }
-EXPORT_SYMBOL_GPL(hidinput_find_field);
 
 struct hid_field *hidinput_get_led_field(struct hid_device *hid)
 {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index b8634d17d11e..6b482c855605 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -904,7 +904,6 @@ extern void hidinput_disconnect(struct hid_device *);
 
 int hid_set_field(struct hid_field *, unsigned, __s32);
 int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
-int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field);
 struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
 __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);
-- 
2.25.1

