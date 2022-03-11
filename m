Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C354D6850
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350814AbiCKSL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiCKSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:11:25 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E506E1D3AFC;
        Fri, 11 Mar 2022 10:10:20 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x26-20020a4a621a000000b00320d7d4af22so11401648ooc.4;
        Fri, 11 Mar 2022 10:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IiXxyHsgfTOlGSBUBDet/+QfpWGHIGkaOs4O67rqF3M=;
        b=b91012sJtY7KuSmcUXg8KKm7RlHqbOU8tfkEkcbx+9FEZX4EIj9BrubwmW6hkWhjhf
         ZyaUPkv8QbXKFbW23ATHEJmCBP9V5zUt4BEgBJdrjeM5FucuaRusNeQ2BgkEFBknZBeI
         awuG4zzfXB975rpus0R+/RN9Ws5MCklOI7zRzqq5hvv7VIuuvdTQl1xkSqUAJlRIT9sn
         +ulJQkPjRyJQFiorMTsdnn9lmB6kKuLRKNkNYaulNY+IctlyQBxlr3NO+xukPdPwnJpe
         N5VM65FKjbUft74bX4D6H5KDwuBEyjDOZtgEZc0BPtvXUxHgCGN/eDTBjcwdNci4vzx0
         w8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IiXxyHsgfTOlGSBUBDet/+QfpWGHIGkaOs4O67rqF3M=;
        b=fwYn6qpPYqE2AAGHAep+do1DkRHFdVrMYi4ehSebBiBz8Zn0nPF2sbETzEG2+xMPD3
         xP/UxYTzVpj77syOhF4xInllmgaWxJ5GF25oI5Z9QZZI0KPBBqleNaLolYgdtF98kbkG
         1CsXZrEcQQtgLz5P+98AakCKFyj4cJv3g9D2HgfMo2X6iFgmfL8xJ3L7Gwz9AQdEFFal
         Cl+7l9eEPW1eivrnhLf7j4ZrsYaia9K7KN+A9tlZl07YSP7FeYzF0MDu7a8eCddfUjgI
         azMSw0UQkJE97vHVc11mKKseK44ywxwFBsJDlFoAzbDlhFH9oUOub5HP4xSIgNtUAYKd
         nnRA==
X-Gm-Message-State: AOAM533Hy/h+xdMhR+HfHRWhuKq/vFqOIHK0vO4zy0YlgZGWzDJAKEk0
        nBWJmejfxwqEZSonuJiWQvI=
X-Google-Smtp-Source: ABdhPJzMyariRy8rQjTfsq0Ik6o8MYOaMiQZDQen9AtoKXvvNrfz9qRad3dE3XqwMqtDbkP0u9b+yg==
X-Received: by 2002:a05:6870:3113:b0:d3:473b:3f1d with SMTP id v19-20020a056870311300b000d3473b3f1dmr6061237oaa.116.1647022220168;
        Fri, 11 Mar 2022 10:10:20 -0800 (PST)
Received: from fstone04p1.aus.stglabs.ibm.com ([129.41.86.7])
        by smtp.gmail.com with ESMTPSA id s24-20020a056808209800b002da3b9bf8e0sm3600917oiw.32.2022.03.11.10.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 10:10:19 -0800 (PST)
From:   Brandon Wyman <bjwyman@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Brandon Wyman <bjwyman@gmail.com>
Subject: [PATCH v2] hwmon: (pmbus/ibm-cffps) Add clear_faults debugfs entry
Date:   Fri, 11 Mar 2022 18:10:14 +0000
Message-Id: <20220311181014.3448936-1-bjwyman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clear_faults write-only debugfs entry for the ibm-cffps device
driver.

Certain IBM power supplies require clearing some latched faults in order
to indicate that the fault has indeed been observed/noticed.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
---
V1 -> V2: Explain why this change is needed

 drivers/hwmon/pmbus/ibm-cffps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index e3294a1a54bb..3f02dde02a4b 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -67,6 +67,7 @@ enum {
 	CFFPS_DEBUGFS_CCIN,
 	CFFPS_DEBUGFS_FW,
 	CFFPS_DEBUGFS_ON_OFF_CONFIG,
+	CFFPS_DEBUGFS_CLEAR_FAULTS,
 	CFFPS_DEBUGFS_NUM_ENTRIES
 };
 
@@ -274,6 +275,13 @@ static ssize_t ibm_cffps_debugfs_write(struct file *file,
 		if (rc)
 			return rc;
 
+		rc = 1;
+		break;
+	case CFFPS_DEBUGFS_CLEAR_FAULTS:
+		rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
+		if (rc < 0)
+			return rc;
+
 		rc = 1;
 		break;
 	default:
@@ -607,6 +615,9 @@ static int ibm_cffps_probe(struct i2c_client *client)
 	debugfs_create_file("on_off_config", 0644, ibm_cffps_dir,
 			    &psu->debugfs_entries[CFFPS_DEBUGFS_ON_OFF_CONFIG],
 			    &ibm_cffps_fops);
+	debugfs_create_file("clear_faults", 0200, ibm_cffps_dir,
+			    &psu->debugfs_entries[CFFPS_DEBUGFS_CLEAR_FAULTS],
+			    &ibm_cffps_fops);
 
 	return 0;
 }
-- 
2.25.1

