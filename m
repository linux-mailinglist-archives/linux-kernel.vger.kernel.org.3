Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C245031CB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349598AbiDOWcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiDOWcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:32:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739B319C07;
        Fri, 15 Apr 2022 15:29:38 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b16so9485698ioz.3;
        Fri, 15 Apr 2022 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXMRCPg/c9Nbak8x8/xFoJWKumOKkUty3hELsz55Pu4=;
        b=BVk6Q02XXWGXTFhTGS3/ioT/vHTmKEm4UMQx3wVby/AH13igNBSsMblXpYfug+4AAU
         Zgdp/vETR6z9zaY6GP9lD5T/HFcCPujlJsHSD+morp3OSsZMw2rYuCyj48Wa7BPah+C6
         QJ/SISJB/9Y96b0HbRaauuAwWl9hjMPsVlnSLGuji7sTPbWEXXwriLH9DXCtfVlZf490
         VKBNGydOvnXQ2gZo53F4jou5BIUvT8ijKcSHxVZFewhrGGzvV06+eKjCnvYItIxy76bU
         MowdSBwK1UfaA8YVM3GgldPYLoM2EdkuxlVn5VOiZZO3qD3VG+bMHZYWThAnIW093ObS
         kFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXMRCPg/c9Nbak8x8/xFoJWKumOKkUty3hELsz55Pu4=;
        b=Mp+7BTHvdXu+a7axf2QpWccTGGuxu8WANug2S/Hc9h8aPhUjfyP7pbmO7+2IGqsNTu
         MPFZrNnP72S0Ay0XeK6UPfuTEMBTEGq9ftAFE/rnAPYI0XINLZdqns0CfxVlx4AzoN8Q
         4H6OuBr8rZauyt/kGhN7KFOORh09OsqDk30csKYrhhqpc8B8tgNCQrLCI5eAOv3ZR0Mb
         7FWwTeBgz8RDlkAMpvX3MouWTQW9nO2ltRTYVs2NEbEMxyj9ZBhUQnDrb5bp7FEoyP+o
         wCXLnRgLYSriWWXVE6YWqNNCB1O6bydhc9uA1RJUSUaBMzzc1DiZhRbPdMxeU0HJUWLS
         7Guw==
X-Gm-Message-State: AOAM532LeWQpnVr5TeLgrtmlev+mHcMMXJMatW6Q5oT+9NMwITaK7/Ig
        1JTJxvSUJGmk/Q7wYKRQ1p4=
X-Google-Smtp-Source: ABdhPJxUutqb+TYlnKj3WxyxDJo2wKImILloGMAI0NlYBWTPUjPGXWJSlU6gq7SQe1nCzdBADNM4MQ==
X-Received: by 2002:a05:6638:204a:b0:323:e148:74f2 with SMTP id t10-20020a056638204a00b00323e14874f2mr490354jaj.90.1650061777829;
        Fri, 15 Apr 2022 15:29:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:249:600:483::2253:8b11])
        by smtp.gmail.com with ESMTPSA id ay18-20020a5d9d92000000b0064c77f6aaecsm3966404iob.3.2022.04.15.15.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 15:29:37 -0700 (PDT)
From:   Josh Kilmer <srjek2@gmail.com>
To:     Josh Kilmer <srjek2@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2] hid: asus: ROG NKey: Ignore portion of 0x5a report
Date:   Fri, 15 Apr 2022 17:29:20 -0500
Message-Id: <20220415222920.6351-1-srjek2@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAMXW6=97T1tzT=FSyzZN6jBAKgzUDOjqRoH-FMAPLHk1gsD=mA@mail.gmail.com>
References: <CAMXW6=97T1tzT=FSyzZN6jBAKgzUDOjqRoH-FMAPLHk1gsD=mA@mail.gmail.com>
MIME-Version: 1.0
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

On an Asus G513QY, of the 5 bytes in a 0x5a report, only the first byte
is a meaningful keycode. The other bytes are zeroed out or hold garbage
from the last packet sent to the keyboard.

This patch fixes up the report descriptor for this event so that the
general hid code will only process 1 byte for keycodes, avoiding
spurious key events and unmapped Asus vendor usagepage code warnings.

Signed-off-by: Josh Kilmer <srjek2@gmail.com>
---
 drivers/hid/hid-asus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 08c9a9a60ae4..b59c3dafa6a4 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1212,6 +1212,13 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		rdesc = new_rdesc;
 	}
 
+	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD &&
+			*rsize == 331 && rdesc[190] == 0x85 && rdesc[191] == 0x5a &&
+			rdesc[204] == 0x95 && rdesc[205] == 0x05) {
+		hid_info(hdev, "Fixing up Asus N-KEY keyb report descriptor\n");
+		rdesc[205] = 0x01;
+	}
+
 	return rdesc;
 }
 
-- 
2.35.1

