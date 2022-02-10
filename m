Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163F44B15C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbiBJTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:05:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbiBJTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A123C1084;
        Thu, 10 Feb 2022 11:04:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m14so11223708wrg.12;
        Thu, 10 Feb 2022 11:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHzlUdZJZAbrkir44zct42ZxWDwZutaTx2Vvtix3Wsk=;
        b=QtyNOwJlEwfIlA1ACJIS9aSGj9/JdtURJRuW3a5+/nH41Cz9p/J6jxM8MBncRmZDks
         7xFIOaPp21W8f2vAkIrivTZkSH4xGSuO8nhzWILbi0dVBUOq5QEsk7GDzVOShZzgU3oC
         ne+E0qV5zyuzEuawaZw8eXJGGuLFp7xFq4Zk9M8r85qVnwFwzw+2/I2daWCmsNytB/lf
         K46F47os3erFsHeqyEYZTg+ILLCCNgULXGgHdgTAWBc03RjzWV/1pPMKjm+9fxAsjIBr
         NHhFX6osrQgsdoaCJ6BjpUCrCH1LdcG5tXRXDYYZ56qOrdCC5io+GhMy9PXvNKxC1ukj
         gmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHzlUdZJZAbrkir44zct42ZxWDwZutaTx2Vvtix3Wsk=;
        b=GJtsyFNj0G15t3LJztKkDlLC0hjdOIMzoMyJlKwOEPLVATkv2Z6DG7IuZCGmlE7eU0
         N6uliPNUn4HMY7083ps0inancWFndSBJfXRphUADmfki8u44afh/HjRaC7++gtKoHFdv
         VA3rsSzpHPCcIjXbpvA1+eSiTYje899bF23KpvT+GuSGtFfnKsRxierZI60yowHV7Nsq
         FMLu/q++cQ4DNXc/yZLg+fwazZn5sPxYx6Z7Zh38QWRoAdqZaj9jOjxGt1VtotXlB46c
         9NwmnIj3WqMvN/4lbGGYLwPOC+8O9B8zxoCpuKchk6wXeQWu6DcmGhqBD/970tThA6qj
         bPjw==
X-Gm-Message-State: AOAM533wxxlPUg8Re9o0d2otHOvU1AK1Kvt8piEtWdH4unMwgnL2NW1y
        C+UrMwnLjpvI0wkAygob2VhWDdjC+G+Ceg==
X-Google-Smtp-Source: ABdhPJyH+Tm5WjJ41gpAy7HUaLhca8G0gg3aX+B++QVCyqE/ifCkKie+piD9OEjsP2ZY8Oym7x4aXA==
X-Received: by 2002:adf:e9c8:: with SMTP id l8mr7677639wrn.415.1644519895257;
        Thu, 10 Feb 2022 11:04:55 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o10sm21794816wri.19.2022.02.10.11.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:04:54 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 6/7] HID: uclogic: Skip non-input raw events earlier
Date:   Thu, 10 Feb 2022 20:04:36 +0100
Message-Id: <20220210190437.50152-7-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210190437.50152-1-jose.exposito89@gmail.com>
References: <20220210190437.50152-1-jose.exposito89@gmail.com>
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

Early return when a non-input raw event is received to simplify the
logic present in uclogic_raw_event.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 56b76d9b46af..8aac3f7a9cda 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -368,9 +368,12 @@ static int uclogic_raw_event(struct hid_device *hdev,
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 	struct uclogic_params *params = &drvdata->params;
 
+	/* Do not handle anything but input reports */
+	if (report->type != HID_INPUT_REPORT)
+		return 0;
+
 	/* Tweak pen reports, if necessary */
 	if (!params->pen_unused &&
-	    (report->type == HID_INPUT_REPORT) &&
 	    (report->id == params->pen.id) &&
 	    (size >= 2)) {
 		/* If it's the "virtual" frame controls report */
@@ -384,8 +387,7 @@ static int uclogic_raw_event(struct hid_device *hdev,
 	}
 
 	/* Tweak frame control reports, if necessary */
-	if ((report->type == HID_INPUT_REPORT) &&
-	    (report->id == params->frame.id))
+	if (report->id == params->frame.id)
 		return uclogic_raw_event_frame(drvdata, data, size);
 
 	return 0;
-- 
2.25.1

