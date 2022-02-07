Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769954ACB92
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiBGVs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241763AbiBGVs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:48:27 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912EC0612A4;
        Mon,  7 Feb 2022 13:48:26 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p24so8428284ejo.1;
        Mon, 07 Feb 2022 13:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TA2tCHxBtL+GNLM2iu5etsizYFK9h2SqH5H/ePAisPI=;
        b=iOZaeLr0JVActyoQUwFar0O4NBbIHuc/3U9jGwpQTpNT3RFDTLUU2OUWoN/BK9lIAD
         6MyAAOjjknbVj8XjY9Qd/3w6NLIQmW6MH2ZIdToBcIgwixB2fC6FvXDyj/MzzD76sv6c
         2CZ2iz6i8fhKZITSiyW0ReKr1w+Uoya7xm2SjCXcsGOPSczgev/c2B25gZi0EYCwThp3
         MfS+8DW6eZfEPMI809tsefpKQOU/bCKbN4khHqVnjRps+QHFaDTgyVTwomRCztirOiti
         iFaNvX4sIWFJ64L7JfZCK3XN+SRHaYjpuM5eWBxWCPzCVSopMWfqfkJOzATpYqa9WQx7
         UnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TA2tCHxBtL+GNLM2iu5etsizYFK9h2SqH5H/ePAisPI=;
        b=LlUCELalvYU5Le4DcREWvfYaE5QcM38pL2Sr2yIC6fUjseeGWqNnL5D7d7Yv/1uhat
         lSmSKWbZPR5SO3mg0pjyaQJhfX8Igx/FP8wGBE4b9EF76fB9SrdaVsIF1XefhLiur0A1
         RgvbUDkczDooYWkzTpzi+6cHn9h3+ZBdxMoA34Nmndh6rL4EggEYIet2LYvQEInobbGO
         6S5NvFAAFq1Td4A6iy7kEM4btSHP60TQjfc2gznWHMhhoTzgCMfoFiF41ZFs7Re1XEdp
         EGLn2QUFjNFc3fXgtUTb1DJBLaOSdYFsBwSBByusoqKiZyP6i9ul0jDwPGrlIZIh5YfT
         loVg==
X-Gm-Message-State: AOAM533Tp71yO8nY8R/KopYC2Kg9uZFxMmRHoN1LV6JNSomIm7UYoPqB
        0FhsX6gR6wOduEHRp0/Tx+c=
X-Google-Smtp-Source: ABdhPJzj6OQmhljMT82gf4rsUtp0LbiixERpC+ZA4NpekGHODdFJJhOCyimW6ogQhAcE0wQC/FS9fg==
X-Received: by 2002:a17:906:6b0c:: with SMTP id q12mr1249316ejr.640.1644270504735;
        Mon, 07 Feb 2022 13:48:24 -0800 (PST)
Received: from localhost.localdomain ([178.94.5.59])
        by smtp.gmail.com with ESMTPSA id f19sm5714378edu.22.2022.02.07.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:48:24 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Per Melin <kernel@melin.net>,
        Jaap de Haan <jaap.dehaan@freenet.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (nct6775) add ASUS ROG STRIX Z390/Z490/X570-* / PRIME X570-P
Date:   Mon,  7 Feb 2022 23:48:15 +0200
Message-Id: <20220207214815.10995-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards such as
* PRIME X570-P,
* ROG STRIX B550-F GAMING WIFI II,
* ROG STRIX B550-XE GAMING (WI-FI),
* ROG STRIX X570-E GAMING,
* ROG STRIX Z390-F GAMING,
* ROG STRIX Z390-H GAMING,
* ROG STRIX Z390-I GAMING,
* ROG STRIX Z490-A GAMING,
* ROG STRIX Z490-E GAMING,
* ROG STRIX Z490-F GAMING,
* ROG STRIX Z490-G GAMING,
* ROG STRIX Z490-G GAMING (WI-FI),
* ROG STRIX Z490-H GAMING
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such boards to the WMI monitoring list.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Per Melin <kernel@melin.net>
Tested-by: Jaap de Haan <jaap.dehaan@freenet.de>

---
Changes in v2:
- Added ROG STRIX B550-F GAMING WIFI II, ROG STRIX B550-XE GAMING (WI-FI).

Comments for v1:
- I have rechecked all the boards by extracting[1] all DSDT files from UEFI
  CAP files that can be downloaded from asus.com site. And all boards have
  fully same WMI methods implementation. I have saved dumps to [2].
  [1]: https://github.com/theopolis/uefi-firmware-parser
  [2]: https://github.com/asus-wmi-boards-sensors/asus-board-dsdt
- PRIME X570-P and ROG STRIX Z390-F GAMING are checked with real boards.
---
 drivers/hwmon/nct6775.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index fbf6266c7ba7..2b91f7e05126 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -5109,6 +5109,7 @@ static const char * const asus_wmi_boards[] = {
 	"PRIME B550-PLUS",
 	"PRIME B550M-A",
 	"PRIME B550M-A (WI-FI)",
+	"PRIME X570-P",
 	"PRIME X570-PRO",
 	"ROG CROSSHAIR VIII DARK HERO",
 	"ROG CROSSHAIR VIII FORMULA",
@@ -5118,10 +5119,22 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX B550-E GAMING",
 	"ROG STRIX B550-F GAMING",
 	"ROG STRIX B550-F GAMING (WI-FI)",
+	"ROG STRIX B550-F GAMING WIFI II",
 	"ROG STRIX B550-I GAMING",
+	"ROG STRIX B550-XE GAMING (WI-FI)",
+	"ROG STRIX X570-E GAMING",
 	"ROG STRIX X570-F GAMING",
 	"ROG STRIX X570-I GAMING",
 	"ROG STRIX Z390-E GAMING",
+	"ROG STRIX Z390-F GAMING",
+	"ROG STRIX Z390-H GAMING",
+	"ROG STRIX Z390-I GAMING",
+	"ROG STRIX Z490-A GAMING",
+	"ROG STRIX Z490-E GAMING",
+	"ROG STRIX Z490-F GAMING",
+	"ROG STRIX Z490-G GAMING",
+	"ROG STRIX Z490-G GAMING (WI-FI)",
+	"ROG STRIX Z490-H GAMING",
 	"ROG STRIX Z490-I GAMING",
 	"TUF GAMING B550M-PLUS",
 	"TUF GAMING B550M-PLUS (WI-FI)",

base-commit: 74fa97c35a74d62a34e120343520e74c50329372
-- 
2.34.1

