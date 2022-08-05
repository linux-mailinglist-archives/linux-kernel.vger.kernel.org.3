Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B458AA59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiHELus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbiHELuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:50:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51E2658;
        Fri,  5 Aug 2022 04:50:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so2954820wrs.9;
        Fri, 05 Aug 2022 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qFfnrobG81eCLwiKKwpCL8mlY9yVSsuf2600g2kw3zo=;
        b=PvgDIF/bZYvsCscjDAry2PISTyOdMg6MkwAFQ1AYQNqG7+u5YPlywMDaNs3IwhBrS+
         e+PC9nre6uSlxt2y3OmfL1Jn01kvdutsWo85N0FRLQiD2VCOxmyO7hihTUcEJX/RH2Lw
         PZEmHgo9GDr145LQ2kgK0tuB5iIW+yeEeVp1qFC+s2+zqXJAeNVtKCz6cQxv6j8VqrES
         TCwBxWQFErbpHUpKz74aL7DJtjUZZjD+5+wnhlIEmzZtUMW95eBc3A1crqhyIH8Ad0Bv
         t72RI2Rj2qL46/IpQbyubJxvXzQ9boov51CCxqdkLz6Moext/ocr9moMQVHZTuw0hA2g
         d2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qFfnrobG81eCLwiKKwpCL8mlY9yVSsuf2600g2kw3zo=;
        b=vH/6W/SZYm+kueryjCDDtSl9SuZd8W/Gsy2YgGcPRTYAMYRs+KWwHjHFElwkKKX/Nn
         NkmEC6Ho13fL5vOIWUB+GwEY5sVUSmNFj80gap0byTsEIJP/2j4rADHQ7jxqu9fGyB1+
         rGkwJxxg8dvtWZEeKh/ob3zfDAf2pu0t78ol4tOj+VJLD1k0RWLDyTDt2IiuUUPOPI82
         m1uXQhAhi25GMBOEIiadyUFj5vYE6V1QixbGZswz7Q8rnhyrZxVrazAGSJcCtMHHu3S4
         T+YT3lklSfwFRdRACd+fQuyV1ZnFm8FSTfu1w8Tsw4rrZJP8pt1WTfDagiOyuqQ7Urp7
         eeQQ==
X-Gm-Message-State: ACgBeo3a4HZsn7dNGEsBhaQnt80vrN02orYo+ZGYmUpYP02gAI8qyaHr
        PTXmn/rT22nW5cZ7Gp33Fk5Ud34XUyTOEL96
X-Google-Smtp-Source: AA6agR4tpCBR6Cl/QU50mH+GkoU9F8Hf/prBxUHU7EFzP8cTuQjOH3d1pk6pIWEIzkenBPhq/KWx5w==
X-Received: by 2002:a5d:5847:0:b0:221:748d:243c with SMTP id i7-20020a5d5847000000b00221748d243cmr1291630wrf.222.1659700243602;
        Fri, 05 Aug 2022 04:50:43 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b0039db31f6372sm9990763wmq.2.2022.08.05.04.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:50:43 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid: remove redundant assignment to variable mfiStatus
Date:   Fri,  5 Aug 2022 12:50:42 +0100
Message-Id: <20220805115042.2340400-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

The variable mfiStatus is assigned a value but it is never read. The
assignment is redundant and can be removed. Also remove { } as the
return statement does not need to be in it's own code block.

Cleans up clang scan build warning:
drivers/scsi/megaraid/megaraid_sas_base.c:4026:7: warning: Although the
value stored to 'mfiStatus' is used in the enclosing expression, the
value is never actually read from 'mfiStatus' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index a3e117a4b8e7..c9b01b155f65 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4023,10 +4023,8 @@ megasas_deplete_reply_queue(struct megasas_instance *instance,
 	u32 mfiStatus;
 	u32 fw_state;
 
-	if ((mfiStatus = instance->instancet->check_reset(instance,
-					instance->reg_set)) == 1) {
+	if (instance->instancet->check_reset(instance, instance->reg_set) == 1)
 		return IRQ_HANDLED;
-	}
 
 	mfiStatus = instance->instancet->clear_intr(instance);
 	if (mfiStatus == 0) {
-- 
2.35.3

