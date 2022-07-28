Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D0E584561
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiG1RvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiG1RvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:51:17 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC22A428;
        Thu, 28 Jul 2022 10:51:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y197so1907259iof.12;
        Thu, 28 Jul 2022 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXMRCPg/c9Nbak8x8/xFoJWKumOKkUty3hELsz55Pu4=;
        b=FYGlUeNsJv/aOwTaXwRqilYn7rkz6D+rKHHRH0+kTu65hoygCWrHbrV13KL82jB2VN
         5A+VFSdmQmPzv/5f/zS4lTrqI+xaqgXDXTFl8wPicp7/jpcHEsUYqu+wMqE9YuuNZdKU
         x0i7Sp9NnXksHyYfg3/s3uET3iCfTQWNhWjUK9ttTQR7qOl7bvprRHGHeMzJW/YuoPPQ
         H+ArPcg4A6LjUgxQ8xZP8I9NxKCQPQkYLXL0yDG7/0AeSoqiGz2qtrN6KRxDE9sh7Ck4
         2NCT5T7MIS8whMj8NfQvnaOhgqCOVlV+bd/8MFVzIGYBRIWCt5xTWp5j4vAuStZJS8t+
         5GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXMRCPg/c9Nbak8x8/xFoJWKumOKkUty3hELsz55Pu4=;
        b=nLXJF8l1nFIp/fuZPFOJYL1bgHAL9LJMa+hUubtuE/KYEl8/0ttYmtrBOA1CRmHtAO
         Dcou9uiAlSrl73jH2bcyeF8Mw/XSeN6FYdtx4Xez74Ech7nFY3jEeFuq5wGLaCHVxS3/
         DK/2qNthkifaQZMjLm9QHtaI8XqYNCvoPCccj7ItgnhbJACcfdM0IAV17dAuXV/r2NOs
         byuAfPzR+bcu79sAhlnrq2fy1GSCYZ+pUdDBjytiObUfRySovaVl2XbtNbriUwJ8JASw
         IchUnVSJYTF4W9QJ24SCAij+q68yQ3a+Xu7CCTYeobKOfJKbN6RmbdIqOaf6CwykSyAl
         6eDQ==
X-Gm-Message-State: AJIora+0XS+Q6OHgPW6c4A3Wzi366YiV/8+GhYL4KU0mhseViiZHNtof
        SICRsdniVHj2vrPWezBLrg3+6KBF7KkuRw==
X-Google-Smtp-Source: AGRyM1vFETi9nJb7BXr+m3gG0v2Nk7JjG5f7nXxam3ehi4VvlChzhQxwDFSQHin/MyhxElBORWV+kg==
X-Received: by 2002:a05:6602:2dc4:b0:648:adac:bae8 with SMTP id l4-20020a0566022dc400b00648adacbae8mr9885180iow.9.1659030675553;
        Thu, 28 Jul 2022 10:51:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:249:600:388b::2253:8b11])
        by smtp.gmail.com with ESMTPSA id a12-20020a02ac0c000000b0033e72ec9d93sm621487jao.145.2022.07.28.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:51:14 -0700 (PDT)
From:   Josh Kilmer <srjek2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Josh Kilmer <srjek2@gmail.com>
Subject: [PATCH v2 RESEND] hid: asus: ROG NKey: Ignore portion of 0x5a report
Date:   Thu, 28 Jul 2022 12:51:11 -0500
Message-Id: <20220728175111.18769-1-srjek2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <CAMXW6=97T1tzT=FSyzZN6jBAKgzUDOjqRoH-FMAPLHk1gsD=mA@mail.gmail.com>
References: <CAMXW6=97T1tzT=FSyzZN6jBAKgzUDOjqRoH-FMAPLHk1gsD=mA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

