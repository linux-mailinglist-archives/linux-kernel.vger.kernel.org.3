Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1439151EECF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiEHQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiEHQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:06:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB49E0AB;
        Sun,  8 May 2022 09:02:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so16334178wrg.12;
        Sun, 08 May 2022 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5c/oJcY+mU8bZWq31obYM76SgdTTfJMILUS4a25EC9M=;
        b=Ou8tKTUjnVee5QYHsgs8fAh8DwycdNVZtbWyKG0/FponkQZLRTLyLG6N/Op+6/0ryt
         8A/m3OvxJQzvqq+GD64IZXO03pMi6dThMO0/SP7alsclTFyTWCLeokZf63wjtaU4OxbT
         NjcpXnfOc7d6ZOyJlTbKlo5NIfPScx16AOqiq4o1MkEeYuzHm64VSh2DYnAcTsOXCQao
         95p4YhyJL8KitsjCai18QDCAGug+V9P9A0PXIXs39vhQaVVb9ztoz30xnio2omicEJSI
         m0rN9uzKj1n4BHBBbv6RKMKtR6jrxYgZ29F+cjXEfJhht6OuwPWBIuFXTuhd+XdgZT72
         YSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5c/oJcY+mU8bZWq31obYM76SgdTTfJMILUS4a25EC9M=;
        b=6EqLjMt/AZixwnR617LDcCrwFj0QfYi1OWc875PD4ugG9chcCK/HKJgAXAgGZWgnjs
         feYjnq2LDSKt0t+9TpYV/nfAxCEee9N4YNurskF6hv3dt7vwof4MeO2u0QeTkch42OGL
         fNvhNyA1XjTbGyaUg4N4OiVp/OK05qcP1/7VghgFSVk/MiLiRSs5MDr2qWsjGRCXDQUm
         iVB6o4cNS+Pm0iT2MKTvt2jf7CX6Yg/Qa4qN3LDtR6Q/pulXUSY4ZMIRnUQcrjU2NITE
         PQqstUWG2vX/eIG0G5lnC23glx4AT1rH9u927pFAK+oxCekrSkhzjCxHKqS8aGCvK6hX
         XJgQ==
X-Gm-Message-State: AOAM531tsiRtzFa3KQQfj9TPJFUQOhJ5MYDO1p5jUObmkRxJQd85ERas
        e+M7XivpHjzMz3Vr4vhaBBQ=
X-Google-Smtp-Source: ABdhPJy9Pz120cLoC1JhaQndg+mUhhZwK2lhXv31H74w67CjktAf2sLjgGwcyXehdLyXqycRpl1wWg==
X-Received: by 2002:a5d:4f08:0:b0:20a:ddfe:bd99 with SMTP id c8-20020a5d4f08000000b0020addfebd99mr10888248wru.339.1652025739637;
        Sun, 08 May 2022 09:02:19 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b003942a244ecfsm10101925wmj.20.2022.05.08.09.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 09:02:19 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 7/7] HID: uclogic: Switch to Digitizer usage for styluses
Date:   Sun,  8 May 2022 18:01:46 +0200
Message-Id: <20220508160146.13004-8-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508160146.13004-1-jose.exposito89@gmail.com>
References: <20220508160146.13004-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kondrashov <spbnick@gmail.com>

The (incorrect) "Pen" (0x02) application usage used in replacement
report descriptors throughout the drivers leads to all tablets
recognized as a "direct" input device (i.e. a tablet monitor) by
recent kernels, which messes up desktop environments [1].

Replace the application usage with "Digitizer" (0x01) for each
non-display graphics tablet.

[1] https://lore.kernel.org/linux-input/f39ce5d5-bd5b-bd3f-3ea2-9b2a89ba1eb1@gmail.com/

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-kye.c           | 12 ++++++------
 drivers/hid/hid-uclogic-rdesc.c | 18 +++++++++---------
 drivers/hid/hid-viewsonic.c     |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index f46616390a98..da903138eee4 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -33,7 +33,7 @@ static __u8 easypen_i405x_rdesc_fixed[] = {
 	0xB1, 0x02,       /*    Feature (Variable),           */
 	0xC0,             /*  End Collection,                 */
 	0x05, 0x0D,       /*  Usage Page (Digitizer),         */
-	0x09, 0x02,       /*  Usage (Pen),                    */
+	0x09, 0x01,       /*  Usage (Digitizer),              */
 	0xA1, 0x01,       /*  Collection (Application),       */
 	0x85, 0x10,       /*    Report ID (16),               */
 	0x09, 0x20,       /*    Usage (Stylus),               */
@@ -91,7 +91,7 @@ static __u8 mousepen_i608x_rdesc_fixed[] = {
 	0xB1, 0x02,       /*    Feature (Variable),           */
 	0xC0,             /*  End Collection,                 */
 	0x05, 0x0D,       /*  Usage Page (Digitizer),         */
-	0x09, 0x02,       /*  Usage (Pen),                    */
+	0x09, 0x01,       /*  Usage (Digitizer),              */
 	0xA1, 0x01,       /*  Collection (Application),       */
 	0x85, 0x10,       /*    Report ID (16),               */
 	0x09, 0x20,       /*    Usage (Stylus),               */
@@ -190,7 +190,7 @@ static __u8 mousepen_i608x_v2_rdesc_fixed[] = {
 	0xB1, 0x02,                   /*    Feature (Variable),           */
 	0xC0,                         /*  End Collection,                 */
 	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
-	0x09, 0x02,                   /*  Usage (Pen),                    */
+	0x09, 0x01,                   /*  Usage (Digitizer),              */
 	0xA1, 0x01,                   /*  Collection (Application),       */
 	0x85, 0x10,                   /*    Report ID (16),               */
 	0x09, 0x20,                   /*    Usage (Stylus),               */
@@ -289,7 +289,7 @@ static __u8 easypen_m610x_rdesc_fixed[] = {
 	0xB1, 0x02,                   /*    Feature (Variable),           */
 	0xC0,                         /*  End Collection,                 */
 	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
-	0x09, 0x02,                   /*  Usage (Pen),                    */
+	0x09, 0x01,                   /*  Usage (Digitizer),              */
 	0xA1, 0x01,                   /*  Collection (Application),       */
 	0x85, 0x10,                   /*    Report ID (16),               */
 	0x09, 0x20,                   /*    Usage (Stylus),               */
@@ -368,7 +368,7 @@ static __u8 pensketch_m912_rdesc_fixed[] = {
 	0xB1, 0x02,                   /*    Feature (Variable),           */
 	0xC0,                         /*  End Collection,                 */
 	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
-	0x09, 0x02,                   /*  Usage (Pen),                    */
+	0x09, 0x01,                   /*  Usage (Digitizer),              */
 	0xA1, 0x01,                   /*  Collection (Application),       */
 	0x85, 0x10,                   /*    Report ID (16),               */
 	0x09, 0x20,                   /*    Usage (Stylus),               */
@@ -497,7 +497,7 @@ static __u8 easypen_m406xe_rdesc_fixed[] = {
 	0xB1, 0x02,         /*      Feature (Variable),             */
 	0xC0,               /*  End Collection,                     */
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x02,         /*  Usage (Pen),                        */
+	0x09, 0x01,         /*  Usage (Digitizer),                  */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0x85, 0x10,         /*      Report ID (16),                 */
 	0x09, 0x20,         /*      Usage (Stylus),                 */
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 3c3d4e8780dc..13f9ce73f1b1 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -21,7 +21,7 @@
 /* Fixed WP4030U report descriptor */
 __u8 uclogic_rdesc_wp4030u_fixed_arr[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x02,         /*  Usage (Pen),                        */
+	0x09, 0x01,         /*  Usage (Digitizer),                  */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0x85, 0x09,         /*      Report ID (9),                  */
 	0x09, 0x20,         /*      Usage (Stylus),                 */
@@ -66,7 +66,7 @@ const size_t uclogic_rdesc_wp4030u_fixed_size =
 /* Fixed WP5540U report descriptor */
 __u8 uclogic_rdesc_wp5540u_fixed_arr[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x02,         /*  Usage (Pen),                        */
+	0x09, 0x01,         /*  Usage (Digitizer),                  */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0x85, 0x09,         /*      Report ID (9),                  */
 	0x09, 0x20,         /*      Usage (Stylus),                 */
@@ -143,7 +143,7 @@ const size_t uclogic_rdesc_wp5540u_fixed_size =
 /* Fixed WP8060U report descriptor */
 __u8 uclogic_rdesc_wp8060u_fixed_arr[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x02,         /*  Usage (Pen),                        */
+	0x09, 0x01,         /*  Usage (Digitizer),                  */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0x85, 0x09,         /*      Report ID (9),                  */
 	0x09, 0x20,         /*      Usage (Stylus),                 */
@@ -220,7 +220,7 @@ const size_t uclogic_rdesc_wp8060u_fixed_size =
 /* Fixed WP1062 report descriptor */
 __u8 uclogic_rdesc_wp1062_fixed_arr[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x02,         /*  Usage (Pen),                        */
+	0x09, 0x01,         /*  Usage (Digitizer),                  */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0x85, 0x09,         /*      Report ID (9),                  */
 	0x09, 0x20,         /*      Usage (Stylus),                 */
@@ -268,7 +268,7 @@ const size_t uclogic_rdesc_wp1062_fixed_size =
 /* Fixed PF1209 report descriptor */
 __u8 uclogic_rdesc_pf1209_fixed_arr[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x02,         /*  Usage (Pen),                        */
+	0x09, 0x01,         /*  Usage (Digitizer),                  */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0x85, 0x09,         /*      Report ID (9),                  */
 	0x09, 0x20,         /*      Usage (Stylus),                 */
@@ -345,7 +345,7 @@ const size_t uclogic_rdesc_pf1209_fixed_size =
 /* Fixed PID 0522 tablet report descriptor, interface 0 (stylus) */
 __u8 uclogic_rdesc_twhl850_fixed0_arr[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x02,         /*  Usage (Pen),                        */
+	0x09, 0x01,         /*  Usage (Digitizer),                  */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0x85, 0x09,         /*      Report ID (9),                  */
 	0x09, 0x20,         /*      Usage (Stylus),                 */
@@ -457,7 +457,7 @@ const size_t uclogic_rdesc_twhl850_fixed2_size =
 /* Fixed TWHA60 report descriptor, interface 0 (stylus) */
 __u8 uclogic_rdesc_twha60_fixed0_arr[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x02,         /*  Usage (Pen),                        */
+	0x09, 0x01,         /*  Usage (Digitizer),                  */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0x85, 0x09,         /*      Report ID (9),                  */
 	0x09, 0x20,         /*      Usage (Stylus),                 */
@@ -534,7 +534,7 @@ const size_t uclogic_rdesc_twha60_fixed1_size =
 /* Fixed report descriptor template for (tweaked) v1 pen reports */
 const __u8 uclogic_rdesc_v1_pen_template_arr[] = {
 	0x05, 0x0D,             /*  Usage Page (Digitizer),                 */
-	0x09, 0x02,             /*  Usage (Pen),                            */
+	0x09, 0x01,             /*  Usage (Digitizer),                      */
 	0xA1, 0x01,             /*  Collection (Application),               */
 	0x85, 0x07,             /*      Report ID (7),                      */
 	0x09, 0x20,             /*      Usage (Stylus),                     */
@@ -588,7 +588,7 @@ const size_t uclogic_rdesc_v1_pen_template_size =
 /* Fixed report descriptor template for (tweaked) v2 pen reports */
 const __u8 uclogic_rdesc_v2_pen_template_arr[] = {
 	0x05, 0x0D,             /*  Usage Page (Digitizer),                 */
-	0x09, 0x02,             /*  Usage (Pen),                            */
+	0x09, 0x01,             /*  Usage (Digitizer),                      */
 	0xA1, 0x01,             /*  Collection (Application),               */
 	0x85, 0x08,             /*      Report ID (8),                      */
 	0x09, 0x20,             /*      Usage (Stylus),                     */
diff --git a/drivers/hid/hid-viewsonic.c b/drivers/hid/hid-viewsonic.c
index df60c8fc2efd..8024b1d370e2 100644
--- a/drivers/hid/hid-viewsonic.c
+++ b/drivers/hid/hid-viewsonic.c
@@ -24,7 +24,7 @@
 /* Fixed report descriptor of PD1011 signature pad */
 static __u8 pd1011_rdesc_fixed[] = {
 	0x05, 0x0D,             /*  Usage Page (Digitizer),             */
-	0x09, 0x02,             /*  Usage (Pen),                        */
+	0x09, 0x01,             /*  Usage (Digitizer),                  */
 	0xA1, 0x01,             /*  Collection (Application),           */
 	0x85, 0x02,             /*      Report ID (2),                  */
 	0x09, 0x20,             /*      Usage (Stylus),                 */
-- 
2.25.1

