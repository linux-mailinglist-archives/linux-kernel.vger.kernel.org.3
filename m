Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1C46FF89
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbhLJLPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:15:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:54466 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237456AbhLJLP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:15:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301711558"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="301711558"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:11:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="516720800"
Received: from ccrisan-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.210.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:11:51 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [PATCHv4 1/5] HID: Add map_msc() to avoid boilerplate code
Date:   Fri, 10 Dec 2021 13:11:34 +0200
Message-Id: <20211210111138.1248187-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
References: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Since we are going to have more MSC events too, add map_msc() that can
be used to fill in necessary fields and avoid boilerplate code.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/hid/hid-input.c | 6 ++----
 include/linux/hid.h     | 4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 03f994541981..ad718ceb8af3 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -52,6 +52,7 @@ static const struct {
 #define map_rel(c)	hid_map_usage(hidinput, usage, &bit, &max, EV_REL, (c))
 #define map_key(c)	hid_map_usage(hidinput, usage, &bit, &max, EV_KEY, (c))
 #define map_led(c)	hid_map_usage(hidinput, usage, &bit, &max, EV_LED, (c))
+#define map_msc(c)	hid_map_usage(hidinput, usage, &bit, &max, EV_MSC, (c))
 
 #define map_abs_clear(c)	hid_map_usage_clear(hidinput, usage, &bit, \
 		&max, EV_ABS, (c))
@@ -876,10 +877,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 		case 0x5b: /* TransducerSerialNumber */
 		case 0x6e: /* TransducerSerialNumber2 */
-			usage->type = EV_MSC;
-			usage->code = MSC_SERIAL;
-			bit = input->mscbit;
-			max = MSC_MAX;
+			map_msc(MSC_SERIAL);
 			break;
 
 		default:  goto unknown;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 313fa4a2554f..cc797d608951 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1015,6 +1015,10 @@ static inline void hid_map_usage(struct hid_input *hidinput,
 		bmap = input->ledbit;
 		limit = LED_MAX;
 		break;
+	case EV_MSC:
+		bmap = input->mscbit;
+		limit = MSC_MAX;
+		break;
 	}
 
 	if (unlikely(c > limit || !bmap)) {
-- 
2.25.1

