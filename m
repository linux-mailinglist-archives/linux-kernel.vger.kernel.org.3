Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8721A4CAD47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiCBSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiCBSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:14:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64E2BD880;
        Wed,  2 Mar 2022 10:13:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p9so4054191wra.12;
        Wed, 02 Mar 2022 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5L8Hwj3FIl0Xgnzes+JlfSkI7X/LRJVH+HAy2sV4IVM=;
        b=d5/4UL6UMw316oSWqEZCJq6fg77tBeU8ISJBAxeIFcSC3BBv2nxqdU3g/z4BTYns9l
         GA3zbNzD/ILhdQimnFxGx7pwdKeZ0ONMAyv5RsoFU6FKgAycB0VA8N6wVJHZhCBFvzR4
         fck4wJ6i3ALJGQfS4n858fp8cq2sKf26c4iki1R85ABS6N3VsPMYJUm0oGphl5Qk2HNA
         emxtYBzW2ZG378Svaajz0q5MT4u/pywP8S8XZF3gnCkFQHTPYQmq4OuLPM0nXqtGugvD
         qqPmQ0ERFoPbjtuURk2T4q9TeoPKFyJ9b9Lis8vR13B3Lz/eSYHThwm89hunzUzBp26M
         PWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5L8Hwj3FIl0Xgnzes+JlfSkI7X/LRJVH+HAy2sV4IVM=;
        b=cw+8A0A3O2nY9cUsCYfkItVMxi4FA4h4sBEhlYLnDRXHtgfGSon+lRX4emGr+F1k8m
         NbMZRYRWBG+7uU46f8OEiScFkS7T8rc1PUGcuCTedk/nOPSvXYOJ3vhRUCWRyDVStwdM
         OZv5L6PdS/FGvcmtGg5M7l8AZnxFk8MWCpnCqGhgshKswi+4vpcxEsRQZct++ID2PL+4
         RmiOb0CAYmKsZ1tq/7+rU/d1jYtiGasOeh5Rc9RvjYX04XPUUPpKIyuDfSof9mZnLJiL
         uWvFO6BUyk8dtr/1PANFl4meukjMM2qIxjQ0j1d0MTyTqbILVXFVeh8STatgdbV34kzl
         oW0w==
X-Gm-Message-State: AOAM532g+573Ln5AefVr5YcsYhnSTUuac1d05CfZOywCyuWo/4TuW/Z6
        fhxsyGwG4ALEHM3AfEMPYFxt4dOVMEi6aw==
X-Google-Smtp-Source: ABdhPJylJfs5FBTbZvwKyYefm3ujs/kNK9gAIiH6yzqV5F+X+vOMfFby1thaHMNqsJuWpe9CoEzDJw==
X-Received: by 2002:adf:80a4:0:b0:1e6:db9f:a8c4 with SMTP id 33-20020adf80a4000000b001e6db9fa8c4mr23857226wrl.345.1646244805070;
        Wed, 02 Mar 2022 10:13:25 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c020700b003862bfb550fsm1225138wmi.46.2022.03.02.10.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:13:24 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH][next] HID: core: Remove redundant assignment to pointer field
Date:   Wed,  2 Mar 2022 18:13:23 +0000
Message-Id: <20220302181323.1100490-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The pointer fields is being assigned a value that is never read, the
pointer is re-assigned a new value in for-loops that occur later on.
The assignment is redundant and can be removed.

Clean up clang scan build warning:
drivers/hid/hid-core.c:1665:30: warning: Although the value stored
to 'field' is used in the enclosing expression, the value is never
actually read from 'field' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index db925794fbe6..6579f4724bbb 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1662,7 +1662,7 @@ static void hid_process_report(struct hid_device *hid,
 
 	/* first retrieve all incoming values in data */
 	for (a = 0; a < report->maxfield; a++)
-		hid_input_fetch_field(hid, field = report->field[a], data);
+		hid_input_fetch_field(hid, report->field[a], data);
 
 	if (!list_empty(&report->field_entry_list)) {
 		/* INPUT_REPORT, we have a priority list of fields */
-- 
2.34.1

