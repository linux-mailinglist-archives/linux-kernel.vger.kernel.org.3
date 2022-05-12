Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6981B5241E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbiELBRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349836AbiELBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:17:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0B369F6;
        Wed, 11 May 2022 18:17:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c9so3494006plh.2;
        Wed, 11 May 2022 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6x2a5UIpGMcoB6vAU/Zz8zzmYENEHUkMTRpV4QCbdJ4=;
        b=FdwEfKZ5ps3k4ah3e9ZswuuqpYtfbubiJoTnD8svogZ+OybBVHr56W75CYXQbO4EBM
         cMJrOzVlkQN9Ts525s0PoHxXtJg3weNg4VKNETIXhzWQBhMTh1vbW4xO6ZIQEMhoSZSL
         yvU1HU8v582VuIc0TaIpDXhjo+3HblP/NMfw6B27dkEsofr0qNyqt2bLnE5hH2Nh82eS
         gJimrjxE07+SDqVlF859fDeKaTGfnUc8GNxmRwlE/kr9wr4F1y9iEm0Iubsvaj/Jo5r0
         FJJ5XL/h40TAAjDcUdoWlZ97+ZQNLJihswYcLH1+yn27xjN9jW5FnG5lIoLx26wfJ28z
         Qddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6x2a5UIpGMcoB6vAU/Zz8zzmYENEHUkMTRpV4QCbdJ4=;
        b=AYWW1I1wnFKmQ9TJsgXDSMxiW8OG9JVytndasZAWkLLfTYRVb7JqSb2o98ytV14Hin
         yOQZS2R8OmB50aGGdIums35g9v8vssaljursNzDPqI7C6LRgCTdgSSCY5JI14osP9oXx
         YhZPuD3PSjEnEQiZcziK00K1aFPh/WcXhbEVUw9eMoJyBWkUozqedCkF34v57FgwU/sA
         X52eCKq0Z2Qxsrb4THm64Kci8UcLqqrJNmE4suOvz1luwD66UrUxXC4xYM1p2X4n3GRM
         4nAMdz0Anbt9LWDLjGr7CIlFk9ANf85CbDWZHNK+23hLXDkmiGJgBc3voD4EhHry9hnG
         NDyQ==
X-Gm-Message-State: AOAM532GHU/3Q+21phNrOhSv8PzGB7qCbQvoD2GligQmI/3a7vMeH7Mz
        1PH+D/6yFlKtDYV5QVLodHo=
X-Google-Smtp-Source: ABdhPJy8ZDJj+yXzLsGEWj0uL8eVH1NvrjgV3cy5u8ON9GU0ZdNr6u+NMy6ao289P08M5FmoLSSmBA==
X-Received: by 2002:a17:90b:1001:b0:1d8:4978:c7d5 with SMTP id gm1-20020a17090b100100b001d84978c7d5mr8216406pjb.167.1652318272726;
        Wed, 11 May 2022 18:17:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g23-20020a170902869700b0015ec44d25dasm2501540plo.235.2022.05.11.18.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 18:17:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     linuxdrivers@attotech.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] [SCSI] esas2r: Use kobj_to_dev()
Date:   Thu, 12 May 2022 01:17:49 +0000
Message-Id: <20220512011749.1621689-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/scsi/esas2r/esas2r_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index 7a4eadad23d7..f030ff6dc5b2 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -59,7 +59,7 @@ struct esas2r_adapter *esas2r_adapters[MAX_ADAPTERS];
 
 static struct esas2r_adapter *esas2r_adapter_from_kobj(struct kobject *kobj)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct Scsi_Host *host = class_to_shost(dev);
 
 	return (struct esas2r_adapter *)host->hostdata;
--
2.25.1


