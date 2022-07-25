Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38201580396
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiGYRib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGYRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:38:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB06F1C916;
        Mon, 25 Jul 2022 10:38:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y9so11045189pff.12;
        Mon, 25 Jul 2022 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CQxdN0UuCCTwqKPx83Nzu7fLirKahxtUNngDAmtuPY=;
        b=RRNd2A2HkQ6hbJaE13qKf/tqqRa1cdyvaSFzq5KJAbWtgKTUwcqQqUcH88F6odiq3R
         mSUzI/nwKgT/i6FE3aoj/YGbP4lwOcM+bFgdFCH0Xshfxjey9DvbZ5W5vo2LspgPtAAa
         Uk1wwa9m6rhTSjIFiUjREkJm+ZSnmTl80EBUo4N29HXVWI5puU/uxfc4Q0N9MYPpOe7i
         cmAMtBSjdJ6TyhcajUq9m9VorSpMwt7GJz2Fz8oijxRXXYFhe0A0+cc0DmiNlPN2ip2n
         7QA5zZBd45nA9fxvtKLPXhdYYB8YTGc27q1078F9cezra1NOnmZHtVaWwIP0nsFdbley
         egGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CQxdN0UuCCTwqKPx83Nzu7fLirKahxtUNngDAmtuPY=;
        b=lfd2vCL+MvpouwCAK7bTz7B8T8hi8k2nE6+DDSb1L1iL7IvqMh+CuPc3Yr6nJNhOn/
         dT1G1l3UvobQ6tIoRZksH8zC0TEGCaWDu+/jXusvnAqWAQn8MvQZ+55fwPIgcXTK2VhW
         ttSL9Ysd+/538SzkVeiJtn7SiGeFPxJ/u9h9CqpNz4/m0io+coLtmndny/y/XpzJdJHq
         kcyeiaFvW801Pjy7kOXxq0/HlJcl4A1O1PPBO4R3V9fXpWNgWE2FPrscdP33lEOM0kuf
         Ef3G54Ifuhk7WHV2lOMgjbTjSA1uhS8BjMxziJKhXE3Tgqt6uDSOKsHO5Ho0CrV0bBix
         7PDA==
X-Gm-Message-State: AJIora8aEZ6tUIrnlAqa9mu0p6OkUVFCN89BW/wd2baRhwXMNd9v3yYs
        wykQcGpJG8iQOaUQ7ReX92roDkEwqYk=
X-Google-Smtp-Source: AGRyM1vgKz/ifCaiCr8JOoIJjb7/GeKixT5F/X1KEdo30UBhdFvBcugFAnTbTxwXUuYIqmCDYr1w8Q==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr14054362pfi.84.1658770707922;
        Mon, 25 Jul 2022 10:38:27 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i188-20020a6287c5000000b005251b9102dbsm10219146pfe.144.2022.07.25.10.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 10:38:27 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mmayer@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH] tools/thermal: Fix possible path truncations
Date:   Mon, 25 Jul 2022 10:37:54 -0700
Message-Id: <20220725173755.2993805-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A build with -D_FORTIFY_SOURCE=2 enabled will produce the following warnings:

sysfs.c:63:30: warning: '%s' directive output may be truncated writing up to 255 bytes into a region of size between 0 and 255 [-Wformat-truncation=]
  snprintf(filepath, 256, "%s/%s", path, filename);
                              ^~
Bump up the buffer to PATH_MAX which is the limit and account for all of
the possible NUL and separators that could lead to exceeding the
allocated buffer sizes.

Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/thermal/tmon/sysfs.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
index b00b1bfd9d8e..cb1108bc9249 100644
--- a/tools/thermal/tmon/sysfs.c
+++ b/tools/thermal/tmon/sysfs.c
@@ -13,6 +13,7 @@
 #include <stdint.h>
 #include <dirent.h>
 #include <libintl.h>
+#include <limits.h>
 #include <ctype.h>
 #include <time.h>
 #include <syslog.h>
@@ -33,9 +34,9 @@ int sysfs_set_ulong(char *path, char *filename, unsigned long val)
 {
 	FILE *fd;
 	int ret = -1;
-	char filepath[256];
+	char filepath[PATH_MAX + 2]; /* NUL and '/' */
 
-	snprintf(filepath, 256, "%s/%s", path, filename);
+	snprintf(filepath, sizeof(filepath), "%s/%s", path, filename);
 
 	fd = fopen(filepath, "w");
 	if (!fd) {
@@ -57,9 +58,9 @@ static int sysfs_get_ulong(char *path, char *filename, unsigned long *p_ulong)
 {
 	FILE *fd;
 	int ret = -1;
-	char filepath[256];
+	char filepath[PATH_MAX + 2]; /* NUL and '/' */
 
-	snprintf(filepath, 256, "%s/%s", path, filename);
+	snprintf(filepath, sizeof(filepath), "%s/%s", path, filename);
 
 	fd = fopen(filepath, "r");
 	if (!fd) {
@@ -76,9 +77,9 @@ static int sysfs_get_string(char *path, char *filename, char *str)
 {
 	FILE *fd;
 	int ret = -1;
-	char filepath[256];
+	char filepath[PATH_MAX + 2]; /* NUL and '/' */
 
-	snprintf(filepath, 256, "%s/%s", path, filename);
+	snprintf(filepath, sizeof(filepath), "%s/%s", path, filename);
 
 	fd = fopen(filepath, "r");
 	if (!fd) {
@@ -199,8 +200,8 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
 {
 	unsigned long trip_instance = 0;
 	char cdev_name_linked[256];
-	char cdev_name[256];
-	char cdev_trip_name[256];
+	char cdev_name[PATH_MAX];
+	char cdev_trip_name[PATH_MAX];
 	int cdev_id;
 
 	if (nl->d_type == DT_LNK) {
@@ -213,7 +214,8 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
 			return -EINVAL;
 		}
 		/* find the link to real cooling device record binding */
-		snprintf(cdev_name, 256, "%s/%s", tz_name, nl->d_name);
+		snprintf(cdev_name, sizeof(cdev_name) - 2, "%s/%s",
+			 tz_name, nl->d_name);
 		memset(cdev_name_linked, 0, sizeof(cdev_name_linked));
 		if (readlink(cdev_name, cdev_name_linked,
 				sizeof(cdev_name_linked) - 1) != -1) {
@@ -226,8 +228,8 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
 			/* find the trip point in which the cdev is binded to
 			 * in this tzone
 			 */
-			snprintf(cdev_trip_name, 256, "%s%s", nl->d_name,
-				"_trip_point");
+			snprintf(cdev_trip_name, sizeof(cdev_trip_name) - 1,
+				"%s%s", nl->d_name, "_trip_point");
 			sysfs_get_ulong(tz_name, cdev_trip_name,
 					&trip_instance);
 			/* validate trip point range, e.g. trip could return -1
-- 
2.25.1

