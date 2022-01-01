Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31EA48266A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 04:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiAADdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 22:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiAADdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 22:33:39 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FAFC061574;
        Fri, 31 Dec 2021 19:33:39 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v22so25466706qtx.8;
        Fri, 31 Dec 2021 19:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCZIWc943tGIO95j8AxKAR/J5LIDyYCAcQH1rfQcnGw=;
        b=pbIaJWvKDbw/fi0syNJ13QBPVkPTl7s7jVW4JmGtb7LRHPUsjZbm3aQigMz5Rm4VUA
         07BAKYpWh1CoXvO/IAZeQOgn8lqrUGiCWjmgKXIhimKYR4NXRcp6YLMNqDoeZEANuLBp
         2oJtlc9+MnDDqFR67hKU42LN9Pko8gHbErGdpjrZi4NoGUWOENpeiCeefFpY1QtZp163
         RqwqdLBROPjASS8mOaIK92H4OWY2q9cIMpD+psW3wDrIoYhikUPkfTXd8TjjS2+LowrW
         FVwyZQqvkaeyJDehM7sspCxiSCCUf1tjXvVWLMMWMyozqI7q92umIXjAiNiKb6gtslzk
         69pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCZIWc943tGIO95j8AxKAR/J5LIDyYCAcQH1rfQcnGw=;
        b=7lpdYUogpsXAxTIyuiBA7bYWEqlTsWJMxlG18sR4XKquXzo3amto5WDPYha4pX7htA
         nrrurcT/iQujUFqYPDO1ioK+4Ep/sBRHSU08cLXIZ+lHqSVT9gdIqt2dPnDPvWqJv1RV
         3Th2jsIZpnoCugWQ0PbE+ldmK8xx+fcgcW+sT6ZGBtb2/Tge85iQWBcAHFTcJAkM6K+I
         sR2rRweBjVOAXifK1j3dQ162NoOxmEl93O1ZbeShrxIOtpZSYf1sYxyLl1igqjEMFIBL
         UwvsNFCzwTc0cslmaPuvzUEcVxXgNd6aa14TmRtSkgsi1cvy+dqTQ0shybGjdxkpHJfI
         /XRQ==
X-Gm-Message-State: AOAM5328o4/oZ6Ivs/h1GekZWX7jy15FwmVBaHW75JZB3ZmM0aLNFcGI
        yV4HWpwTkWGelFJABM5/5WY=
X-Google-Smtp-Source: ABdhPJyeooLqVAWTjaL3pwzXtleC/1eeGZIxL/lTQ/jbLuWnczCcOYj6wpJ8hL0BmuFfaZ7fTcuZOA==
X-Received: by 2002:a05:622a:1354:: with SMTP id w20mr32273847qtk.566.1641008018591;
        Fri, 31 Dec 2021 19:33:38 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id x4sm24132867qtw.44.2021.12.31.19.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 19:33:38 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, erhard_f@mailbox.org,
        yinxiujiang@kylinos.cn
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] of: unittest: re-implement overlay tracking
Date:   Fri, 31 Dec 2021 21:33:29 -0600
Message-Id: <20220101033329.1277779-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220101033329.1277779-1-frowand.list@gmail.com>
References: <20220101033329.1277779-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Some overlays are tracked when they are applied.  The tracked overlays
are later removed after the overlay tests are completed.  The old
implementation makes assumptions about the expected values for
overlay changeset id created by the overlay apply which result
in fragile code.  The new code removes the assumptions.

A symptom that exposes a problem with the tracking code is a
warning "UBSAN: shift-out-of-bounds in drivers/of/unittest.c:1933:36",
Kernel Version: 5.15-rc7, PPC-64, Talos II.  This results from variable
"id" value of -1 in the final line of of_unittest_untrack_overlay().

Reported-by: erhard_f@mailbox.org
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 110 +++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 61 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 33c458044600..e2807014cbe7 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1657,7 +1657,7 @@ static void __init of_unittest_overlay_gpio(void)
 	 * The overlays are applied by overlay_data_apply()
 	 * instead of of_unittest_apply_overlay() so that they
 	 * will not be tracked.  Thus they will not be removed
-	 * by of_unittest_destroy_tracked_overlays().
+	 * by of_unittest_remove_tracked_overlays().
 	 *
 	 * - apply overlay_gpio_01
 	 * - apply overlay_gpio_02a
@@ -1905,86 +1905,70 @@ static const char *overlay_name_from_nr(int nr)
 
 static const char *bus_path = "/testcase-data/overlay-node/test-bus";
 
-/* FIXME: it is NOT guaranteed that overlay ids are assigned in sequence */
+#define MAX_TRACK_OVCS_IDS 256
 
-#define MAX_UNITTEST_OVERLAYS	256
-static unsigned long overlay_id_bits[BITS_TO_LONGS(MAX_UNITTEST_OVERLAYS)];
-static int overlay_first_id = -1;
+static int track_ovcs_id[MAX_TRACK_OVCS_IDS];
+static int track_ovcs_id_overlay_nr[MAX_TRACK_OVCS_IDS];
+static int track_ovcs_id_cnt;
 
-static long of_unittest_overlay_tracked(int id)
+static void of_unittest_track_overlay(int ovcs_id, int overlay_nr)
 {
-	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
-		return 0;
-	return overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id);
-}
-
-static void of_unittest_track_overlay(int id)
-{
-	if (overlay_first_id < 0)
-		overlay_first_id = id;
-	id -= overlay_first_id;
-
-	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
+	if (WARN_ON(track_ovcs_id_cnt >= MAX_TRACK_OVCS_IDS))
 		return;
-	overlay_id_bits[BIT_WORD(id)] |= BIT_MASK(id);
+
+	track_ovcs_id[track_ovcs_id_cnt] = ovcs_id;
+	track_ovcs_id_overlay_nr[track_ovcs_id_cnt] = overlay_nr;
+	track_ovcs_id_cnt++;
 }
 
-static void of_unittest_untrack_overlay(int id)
+static void of_unittest_untrack_overlay(int ovcs_id)
 {
-	if (overlay_first_id < 0)
+	if (WARN_ON(track_ovcs_id_cnt < 1))
 		return;
-	id -= overlay_first_id;
-	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
-		return;
-	overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
-}
 
-static void of_unittest_destroy_tracked_overlays(void)
-{
-	int id, ret, defers, ovcs_id;
+	track_ovcs_id_cnt--;
 
-	if (overlay_first_id < 0)
-		return;
+	/* If out of synch then test is broken.  Do not try to recover. */
+	WARN_ON(track_ovcs_id[track_ovcs_id_cnt] != ovcs_id);
+}
 
-	/* try until no defers */
-	do {
-		defers = 0;
-		/* remove in reverse order */
-		for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
-			if (!of_unittest_overlay_tracked(id))
-				continue;
+static void of_unittest_remove_tracked_overlays(void)
+{
+	int ret, ovcs_id, overlay_nr, save_ovcs_id;
+	const char *overlay_name;
 
-			ovcs_id = id + overlay_first_id;
-			ret = of_overlay_remove(&ovcs_id);
-			if (ret == -ENODEV) {
-				pr_warn("%s: no overlay to destroy for #%d\n",
-					__func__, id + overlay_first_id);
-				continue;
-			}
-			if (ret != 0) {
-				defers++;
-				pr_warn("%s: overlay destroy failed for #%d\n",
-					__func__, id + overlay_first_id);
-				continue;
-			}
+	while (track_ovcs_id_cnt > 0) {
 
-			of_unittest_untrack_overlay(id);
+		ovcs_id = track_ovcs_id[track_ovcs_id_cnt - 1];
+		overlay_nr = track_ovcs_id_overlay_nr[track_ovcs_id_cnt - 1];
+		save_ovcs_id = ovcs_id;
+		ret = of_overlay_remove(&ovcs_id);
+		if (ret == -ENODEV) {
+			overlay_name = overlay_name_from_nr(overlay_nr);
+			pr_warn("%s: of_overlay_remove() for overlay \"%s\" failed, ret = %d\n",
+				__func__, overlay_name, ret);
 		}
-	} while (defers > 0);
+		of_unittest_untrack_overlay(save_ovcs_id);
+	};
+
 }
 
 static int __init of_unittest_apply_overlay(int overlay_nr, int *ovcs_id)
 {
+	/*
+	 * The overlay will be tracked, thus it will be removed
+	 * by of_unittest_remove_tracked_overlays().
+	 */
+
 	const char *overlay_name;
 
 	overlay_name = overlay_name_from_nr(overlay_nr);
 
 	if (!overlay_data_apply(overlay_name, ovcs_id)) {
-		unittest(0, "could not apply overlay \"%s\"\n",
-				overlay_name);
+		unittest(0, "could not apply overlay \"%s\"\n", overlay_name);
 		return -EFAULT;
 	}
-	of_unittest_track_overlay(*ovcs_id);
+	of_unittest_track_overlay(*ovcs_id, overlay_nr);
 
 	return 0;
 }
@@ -2226,7 +2210,7 @@ static void __init of_unittest_overlay_6(void)
 			return;
 	}
 	save_ovcs_id[0] = ovcs_id;
-	of_unittest_track_overlay(ovcs_id);
+	of_unittest_track_overlay(ovcs_id, overlay_nr + 0);
 
 	EXPECT_END(KERN_INFO,
 		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status");
@@ -2243,7 +2227,7 @@ static void __init of_unittest_overlay_6(void)
 			return;
 	}
 	save_ovcs_id[1] = ovcs_id;
-	of_unittest_track_overlay(ovcs_id);
+	of_unittest_track_overlay(ovcs_id, overlay_nr + 1);
 
 	EXPECT_END(KERN_INFO,
 		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status");
@@ -2317,7 +2301,7 @@ static void __init of_unittest_overlay_8(void)
 		return;
 
 	save_ovcs_id[0] = ovcs_id;
-	of_unittest_track_overlay(ovcs_id);
+	of_unittest_track_overlay(ovcs_id, overlay_nr + 0);
 
 	overlay_name = overlay_name_from_nr(overlay_nr + 1);
 
@@ -2336,7 +2320,7 @@ static void __init of_unittest_overlay_8(void)
 	}
 
 	save_ovcs_id[1] = ovcs_id;
-	of_unittest_track_overlay(ovcs_id);
+	of_unittest_track_overlay(ovcs_id, overlay_nr + 1);
 
 	/* now try to remove first overlay (it should fail) */
 	ovcs_id = save_ovcs_id[0];
@@ -2356,6 +2340,10 @@ static void __init of_unittest_overlay_8(void)
 		   "OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8");
 
 	if (!ret) {
+		/*
+		 * Should never get here.  If we do, expect a lot of
+		 * subsequent tracking and overlay removal related errors.
+		 */
 		unittest(0, "%s was destroyed @\"%s\"\n",
 				overlay_name_from_nr(overlay_nr + 0),
 				unittest_path(unittest_nr,
@@ -2805,7 +2793,7 @@ static void __init of_unittest_overlay(void)
 
 	of_unittest_overlay_gpio();
 
-	of_unittest_destroy_tracked_overlays();
+	of_unittest_remove_tracked_overlays();
 
 out:
 	of_node_put(bus_np);
-- 
Frank Rowand <frank.rowand@sony.com>

