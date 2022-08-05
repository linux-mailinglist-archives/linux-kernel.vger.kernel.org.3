Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD55D58AA44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiHELlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiHELlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:41:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E3D1403A;
        Fri,  5 Aug 2022 04:41:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z16so2902801wrh.12;
        Fri, 05 Aug 2022 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3qq+Nq9Ztf/arjtnNjMRQsswkmXt747/vussuWqMywo=;
        b=RJ5QzDPPYRf3i2BZOFWJ2gH8Xu6N/rQsVFXsjBSuLRxW3rM62w9n5HuiJDWe6GGEpx
         1uV3UvxsZ0SIDhSUjqP6prjl+a4TNWZRNnMONE+ZAPzgTKcO7zj5eAsdCE+C2iDeq56R
         QZjVJJ7oqxD9U+zosvv2/VRQ0BO17Fc88/7/lkO2DliaG6GaLbuuMnhupo8lbhJJCjOk
         5bzI2S6IOjdPKtlPYSrt2jy1Z2ceFH1yLfY5mVn693REu3x/XiCbbo50wig04bDZPZQ2
         BM4q2sasNAmcChmSdXWED4udnhszGeiv8zy7nAb+N7DDHdCm/x3JG7ypbDyG8zNyeN8P
         6ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3qq+Nq9Ztf/arjtnNjMRQsswkmXt747/vussuWqMywo=;
        b=z4eqXhObi2yy5tzthdGTLuImM4bspzVxvlQVf5SKR7m1ZaR7Oc627OvXF44v3HA1Qk
         tb5yuZACYhMr1QYdfczIM0fdcY/HFm/60SQMhqPt1Ry2GvacFx0bkcLqwACemTsTr1pW
         5OcG97/4X4pOQaSVoUkRA/wP7nCJox5YYeCOL6UGqGybg5JEn5Sc7bWyR5D0tcSKnP6L
         2U5n3Go00rqKJ5n+rwNAqhcB/55a7ksgXP5cblKO9+KArAptD84wUg+dtoQw22GYjiCQ
         /jorsRv4CTrZprvn2KIsDvA9kijgZXvirrA5+rbHC73HWC6udk+9f4bCjI3UzLO+PP34
         tc+A==
X-Gm-Message-State: ACgBeo21rOoxPzyGs/Hjs7RP/eV0nND9+yU6o6/lwa/xul8j/NK/Ot+T
        6z25P9m7v2qDiCgF4dKWl1E=
X-Google-Smtp-Source: AA6agR6O9vPkSO4x8F3K8gcNHNZWfbE3M1f/azPYPqigY8BULDkioa6Oa0UJxBjO9HAW8mR0+qFikg==
X-Received: by 2002:a5d:6483:0:b0:21e:999c:e1ca with SMTP id o3-20020a5d6483000000b0021e999ce1camr4027575wri.640.1659699661259;
        Fri, 05 Aug 2022 04:41:01 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c414a00b003a32167b8d4sm9975117wmm.13.2022.08.05.04.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:41:00 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: initio: remove redundant assignment to pointer scb
Date:   Fri,  5 Aug 2022 12:41:00 +0100
Message-Id: <20220805114100.2339637-1-colin.i.king@gmail.com>
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

The variable scb is assigned a value but it is never read. The assignment
is redundant and can be removed. Also replace the != NULL check with the
more usual non-null check idiom.

Cleans up clang scan build warning:
drivers/scsi/initio.c:1169:9: warning: Although the value stored to 'scb'
is used in the enclosing expression, the value is never actually read
from 'scb' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/initio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index f585d6e5fab9..375261d67619 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -1166,7 +1166,7 @@ static void tulip_scsi(struct initio_host * host)
 			return;
 		}
 		if (host->jsint & (TSS_FUNC_COMP | TSS_BUS_SERV)) {	/* func complete or Bus service */
-			if ((scb = host->active) != NULL)
+			if (host->active)
 				initio_next_state(host);
 			return;
 		}
-- 
2.35.3

