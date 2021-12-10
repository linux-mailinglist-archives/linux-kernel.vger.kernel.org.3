Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D5E46FF8A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhLJLPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:15:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:54466 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237425AbhLJLPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:15:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301711563"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="301711563"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:11:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="516720804"
Received: from ccrisan-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.210.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:11:53 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, mika.westerberg@linux.intel.com,
        tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [PATCHv4 2/5] HID: hid-input: Add suffix also for HID_DG_PEN
Date:   Fri, 10 Dec 2021 13:11:35 +0200
Message-Id: <20211210111138.1248187-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
References: <20211210111138.1248187-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

This and HID_DG_STYLUS are pretty much the same thing so add suffix for
HID_DG_PEN too. This makes the input device name look better.

While doing this, remove the suffix override from hid-multitouch, as it
is now handled by hid-input. Also, the suffix override done by
hid-multitouch was wrong, as it mapped HID_DG_PEN => "Stylus" and
HID_DG_STYLUS => "Pen".

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/hid/hid-input.c      | 1 +
 drivers/hid/hid-multitouch.c | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ad718ceb8af3..78205e445652 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1741,6 +1741,7 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 		case HID_GD_MOUSE:
 			suffix = "Mouse";
 			break;
+		case HID_DG_PEN:
 		case HID_DG_STYLUS:
 			suffix = "Pen";
 			break;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 082376a6cb3d..99eabfb4145b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1606,9 +1606,6 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	case HID_DG_STYLUS:
 		/* force BTN_STYLUS to allow tablet matching in udev */
 		__set_bit(BTN_STYLUS, hi->input->keybit);
-		fallthrough;
-	case HID_DG_PEN:
-		suffix = "Stylus";
 		break;
 	default:
 		suffix = "UNKNOWN";
-- 
2.25.1

