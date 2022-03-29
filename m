Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA54EB452
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiC2T4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiC2T4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41F685BE61
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648583657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rUrDz9fk04/J5E1vrYK/zqo5ycWnE8JkJuefXi7bp4s=;
        b=VEg/mjGy2+s+o5px/Y0WSnTStNgCiMi3lsf9moxxDYSwT0L77I0MYIMvv/QrM3YGCLOYHh
        e1ZguIBIFWnPuwWvJRySS/TVS229FIM+N/7MK5VStBwaBdhNftfYPbRT8My5JUBxQ0yS1U
        QiooEBOURq9LjoUemqUBzHrudC/FH6I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-HdGs0Fq_Mhyvvv4fl09m9g-1; Tue, 29 Mar 2022 15:54:16 -0400
X-MC-Unique: HdGs0Fq_Mhyvvv4fl09m9g-1
Received: by mail-qv1-f70.google.com with SMTP id k20-20020ad44714000000b00440fd2c4a0aso14543908qvz.20
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rUrDz9fk04/J5E1vrYK/zqo5ycWnE8JkJuefXi7bp4s=;
        b=CR1W0Tot8/TsHJNwAwV0WetsAyqjE6Rk6Wjm9RrwykhmItmtZcbjGIGL3hxNgrqFt5
         TAJzmcxRNOfeJ4wCPWmSeywR/UQwYgYBvVa72qYmd7MBrXYf4HBr22SX45XwLRiVSjxW
         H3fBdd2G8SXtv0SHU698rgrIl9C8/CJtDjc3bF9WfIXMBGjb4HMp4trMF/+FQzoEnB5L
         lLEj0NKNUoe/7L0B2rBk5NdtQ1WT245cEkbScg5olpSexlkzRLvoTXe/StAVbRE14/02
         k5PoPdZ39s1BBBnFjx0+9vxhIAPM4krJlwtwzjaMHnGGqRhnSHT62eUVbOS2ZCVPzYG6
         P32g==
X-Gm-Message-State: AOAM532EBZDFFWAIei2awCm4xn58G336BqyA1Ao8JbampVi2TWMXXS36
        f5PtYA9OStECdT4MMILtpmgRilOtp+MiGiFlRBUvS/gxHwTP5uoOrx0k2YikEATMdD9ieNKtOg8
        RZEsftle84CpEle/Ng2vx4/ey
X-Received: by 2002:a05:620a:25d0:b0:680:f1f5:2324 with SMTP id y16-20020a05620a25d000b00680f1f52324mr2596159qko.240.1648583655239;
        Tue, 29 Mar 2022 12:54:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWdFvGZTxQw4rDojAlGlLRq4rS2jlbvxKHp1xU4YNkibiqJ5p4ZmdpVSLJstkfd4sjknsxtQ==
X-Received: by 2002:a05:620a:25d0:b0:680:f1f5:2324 with SMTP id y16-20020a05620a25d000b00680f1f52324mr2596143qko.240.1648583654906;
        Tue, 29 Mar 2022 12:54:14 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h206-20020a379ed7000000b0067b5192da4csm9771377qke.12.2022.03.29.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 12:54:14 -0700 (PDT)
From:   trix@redhat.com
To:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org, colin.i.king@googlemail.com,
        gregkh@linuxfoundation.org, salah.triki@gmail.com
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] accessiblity: speakup: cleanup comments
Date:   Tue, 29 Mar 2022 12:54:01 -0700
Message-Id: <20220329195401.3220408-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Replace for spelling
keypresses to key presses
bytesize to byte size
specificly to specifically

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/accessibility/speakup/fakekey.c        | 4 ++--
 drivers/accessibility/speakup/serialio.c       | 2 +-
 drivers/accessibility/speakup/speakup_acntpc.c | 2 +-
 drivers/accessibility/speakup/speakup_acntsa.c | 2 +-
 drivers/accessibility/speakup/speakup_apollo.c | 2 +-
 drivers/accessibility/speakup/speakup_audptr.c | 2 +-
 drivers/accessibility/speakup/speakup_bns.c    | 2 +-
 drivers/accessibility/speakup/speakup_decext.c | 2 +-
 drivers/accessibility/speakup/speakup_dectlk.c | 2 +-
 drivers/accessibility/speakup/speakup_dtlk.c   | 2 +-
 drivers/accessibility/speakup/speakup_dummy.c  | 2 +-
 drivers/accessibility/speakup/speakup_keypc.c  | 2 +-
 drivers/accessibility/speakup/speakup_ltlk.c   | 2 +-
 drivers/accessibility/speakup/speakup_soft.c   | 2 +-
 drivers/accessibility/speakup/speakup_spkout.c | 2 +-
 drivers/accessibility/speakup/speakup_txprt.c  | 2 +-
 16 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/accessibility/speakup/fakekey.c b/drivers/accessibility/speakup/fakekey.c
index cd029968462f..868c47b2a59b 100644
--- a/drivers/accessibility/speakup/fakekey.c
+++ b/drivers/accessibility/speakup/fakekey.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /* fakekey.c
- * Functions for simulating keypresses.
+ * Functions for simulating key presses.
  *
  * Copyright (C) 2010 the Speakup Team
  */
@@ -78,7 +78,7 @@ void speakup_fake_down_arrow(void)
 }
 
 /*
- * Are we handling a simulated keypress on the current CPU?
+ * Are we handling a simulated key press on the current CPU?
  * Returns a boolean.
  */
 bool speakup_fake_key_pressed(void)
diff --git a/drivers/accessibility/speakup/serialio.c b/drivers/accessibility/speakup/serialio.c
index 53580bdc5baa..3418ea31d28f 100644
--- a/drivers/accessibility/speakup/serialio.c
+++ b/drivers/accessibility/speakup/serialio.c
@@ -59,7 +59,7 @@ const struct old_serial_port *spk_serial_init(int index)
 	}
 	ser = rs_table + index;
 
-	/*	Divisor, bytesize and parity */
+	/*	Divisor, byte size and parity */
 	quot = ser->baud_base / baud;
 	cval = cflag & (CSIZE | CSTOPB);
 #if defined(__powerpc__) || defined(__alpha__)
diff --git a/drivers/accessibility/speakup/speakup_acntpc.c b/drivers/accessibility/speakup/speakup_acntpc.c
index 023172ca22ef..a55b60754eb1 100644
--- a/drivers/accessibility/speakup/speakup_acntpc.c
+++ b/drivers/accessibility/speakup/speakup_acntpc.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * this code is specificly written as a driver for the speakup screenreview
+ * this code is specifically written as a driver for the speakup screenreview
  * package and is not a general device driver.
  * This driver is for the Aicom Acent PC internal synthesizer.
  */
diff --git a/drivers/accessibility/speakup/speakup_acntsa.c b/drivers/accessibility/speakup/speakup_acntsa.c
index 3a863dc61286..2697c51ed6b5 100644
--- a/drivers/accessibility/speakup/speakup_acntsa.c
+++ b/drivers/accessibility/speakup/speakup_acntsa.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * this code is specificly written as a driver for the speakup screenreview
+ * this code is specifically written as a driver for the speakup screenreview
  * package and is not a general device driver.
  */
 
diff --git a/drivers/accessibility/speakup/speakup_apollo.c b/drivers/accessibility/speakup/speakup_apollo.c
index cd63581b2e99..c84a7e0864b7 100644
--- a/drivers/accessibility/speakup/speakup_apollo.c
+++ b/drivers/accessibility/speakup/speakup_apollo.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * this code is specificly written as a driver for the speakup screenreview
+ * this code is specifically written as a driver for the speakup screenreview
  * package and is not a general device driver.
  */
 #include <linux/jiffies.h>
diff --git a/drivers/accessibility/speakup/speakup_audptr.c b/drivers/accessibility/speakup/speakup_audptr.c
index a0c3b8ae17a1..4d16d60db9b2 100644
--- a/drivers/accessibility/speakup/speakup_audptr.c
+++ b/drivers/accessibility/speakup/speakup_audptr.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * specificly written as a driver for the speakup screenreview
+ * specifically written as a driver for the speakup screenreview
  * s not a general device driver.
  */
 #include "spk_priv.h"
diff --git a/drivers/accessibility/speakup/speakup_bns.c b/drivers/accessibility/speakup/speakup_bns.c
index 76dfa3f7c058..b8103eb117b8 100644
--- a/drivers/accessibility/speakup/speakup_bns.c
+++ b/drivers/accessibility/speakup/speakup_bns.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * this code is specificly written as a driver for the speakup screenreview
+ * this code is specifically written as a driver for the speakup screenreview
  * package and is not a general device driver.
  */
 #include "spk_priv.h"
diff --git a/drivers/accessibility/speakup/speakup_decext.c b/drivers/accessibility/speakup/speakup_decext.c
index 092cfd08a9e1..eaebf62300a4 100644
--- a/drivers/accessibility/speakup/speakup_decext.c
+++ b/drivers/accessibility/speakup/speakup_decext.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * specificly written as a driver for the speakup screenreview
+ * specifically written as a driver for the speakup screenreview
  * s not a general device driver.
  */
 #include <linux/jiffies.h>
diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
index 78ca4987e619..2a7e8d727904 100644
--- a/drivers/accessibility/speakup/speakup_dectlk.c
+++ b/drivers/accessibility/speakup/speakup_dectlk.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * specificly written as a driver for the speakup screenreview
+ * specifically written as a driver for the speakup screenreview
  * s not a general device driver.
  */
 #include <linux/unistd.h>
diff --git a/drivers/accessibility/speakup/speakup_dtlk.c b/drivers/accessibility/speakup/speakup_dtlk.c
index a9dd5c45d237..6f01e010aaf4 100644
--- a/drivers/accessibility/speakup/speakup_dtlk.c
+++ b/drivers/accessibility/speakup/speakup_dtlk.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * specificly written as a driver for the speakup screenreview
+ * specifically written as a driver for the speakup screenreview
  * package it's not a general device driver.
  * This driver is for the RC Systems DoubleTalk PC internal synthesizer.
  */
diff --git a/drivers/accessibility/speakup/speakup_dummy.c b/drivers/accessibility/speakup/speakup_dummy.c
index 63c2f2943282..34f11cd47073 100644
--- a/drivers/accessibility/speakup/speakup_dummy.c
+++ b/drivers/accessibility/speakup/speakup_dummy.c
@@ -8,7 +8,7 @@
  * Copyright (C) 2003 David Borowski.
  * Copyright (C) 2007 Samuel Thibault.
  *
- * specificly written as a driver for the speakup screenreview
+ * specifically written as a driver for the speakup screenreview
  * s not a general device driver.
  */
 #include "spk_priv.h"
diff --git a/drivers/accessibility/speakup/speakup_keypc.c b/drivers/accessibility/speakup/speakup_keypc.c
index 1618be87bff1..f61b62f1ea4d 100644
--- a/drivers/accessibility/speakup/speakup_keypc.c
+++ b/drivers/accessibility/speakup/speakup_keypc.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2003 David Borowski.
  *
- * specificly written as a driver for the speakup screenreview
+ * specifically written as a driver for the speakup screenreview
  * package it's not a general device driver.
  * This driver is for the Keynote Gold internal synthesizer.
  */
diff --git a/drivers/accessibility/speakup/speakup_ltlk.c b/drivers/accessibility/speakup/speakup_ltlk.c
index 3e59b387d0c4..f885cfaa27c8 100644
--- a/drivers/accessibility/speakup/speakup_ltlk.c
+++ b/drivers/accessibility/speakup/speakup_ltlk.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * specificly written as a driver for the speakup screenreview
+ * specifically written as a driver for the speakup screenreview
  * s not a general device driver.
  */
 #include "speakup.h"
diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 19824e7006fe..1ced2721513e 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2003  Kirk Reiser.
  *
- * this code is specificly written as a driver for the speakup screenreview
+ * this code is specifically written as a driver for the speakup screenreview
  * package and is not a general device driver.
  */
 
diff --git a/drivers/accessibility/speakup/speakup_spkout.c b/drivers/accessibility/speakup/speakup_spkout.c
index bd3d8dc300ff..5e3bb3aa98b6 100644
--- a/drivers/accessibility/speakup/speakup_spkout.c
+++ b/drivers/accessibility/speakup/speakup_spkout.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * specificly written as a driver for the speakup screenreview
+ * specifically written as a driver for the speakup screenreview
  * s not a general device driver.
  */
 #include "spk_priv.h"
diff --git a/drivers/accessibility/speakup/speakup_txprt.c b/drivers/accessibility/speakup/speakup_txprt.c
index a7326f226a5e..9e781347f7eb 100644
--- a/drivers/accessibility/speakup/speakup_txprt.c
+++ b/drivers/accessibility/speakup/speakup_txprt.c
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-99  Kirk Reiser.
  * Copyright (C) 2003 David Borowski.
  *
- * specificly written as a driver for the speakup screenreview
+ * specifically written as a driver for the speakup screenreview
  * s not a general device driver.
  */
 #include "spk_priv.h"
-- 
2.26.3

