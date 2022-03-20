Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD59D4E1C2A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbiCTPJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbiCTPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:09:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C8D181B05;
        Sun, 20 Mar 2022 08:07:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kx5-20020a17090b228500b001c6ed9db871so2108944pjb.1;
        Sun, 20 Mar 2022 08:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+l4q4eQBGuYBAncAJ/7FNjzYbCXQcTb8z0Fti3AjfZE=;
        b=pKRs/2JE10K4Vf6BDYt3+ZiXJI53GJEKLNRdDPyEMO+eAi3qZAiszRRYdUeCvObWnY
         UX/fxE7cRUoPrh1EBtowQvg36anRqPbzVDrb776T7xCGWNw8Yg6sayI4ugxx3LZ7j1Vd
         66Lzfxj3wP9tJh8isZBG7b8z/5uQIwK32EbvrcUmP90tlkIhdR0CkdZ4Q4iAMbCwBGf8
         1XPKSY9/JEkwnH0vqs/IeJ6DHNABuTZ5j+QX9kmeKKjXfk9uQqhPJgu4D8yLc4qPvJ8R
         ARxD4ks/TRyl11SHs0V1KPvK5FGvcaKXFhXdkE4BrnornyFJyN7tL6BoixI0sWBfIt1h
         oy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+l4q4eQBGuYBAncAJ/7FNjzYbCXQcTb8z0Fti3AjfZE=;
        b=SCloi02Kr43xXFfPSODHTRJlEfWwYA7oE+5inVDL5WHlZ/Ooz3uJqCxlnf6vFv9Zbr
         aef+bchQGEU6IhlnY7525PmyCz12YmaRIzpDYzv/0qJgFF/ibpZGpa4bqfFbICGb4Irc
         HdtF0YPe2xGLulNSQ8vR8VS3vpd+xjwNgiSBjiynMqhQhIIwIzE9bxNbdxHZxsheKmER
         2336LMGcRNB1Ew2UGeeW+0jsQcakLN7VRg84Wh1btdaRp82AAx4XpIXLzA1WVdGZXETj
         0uJvZUVg4D6qrBNdtGUryJoqEOeuodK+qgrdl+Aop2wKix2uyTf36X1/lL7HctmvNmm+
         JXqQ==
X-Gm-Message-State: AOAM532oTVo9S8DE7WIsbfv1oVpDyZ9uz9H77BZP+7NRIp++szVwwkOu
        Fj0Sur+Y5+CdUKwnJLPWpDs=
X-Google-Smtp-Source: ABdhPJzjVhIHqIT+FL3/lrMPWUW4Qb9pOyn3dCQxm/yIh00qtRxd6bgB3b4r8/Es3nEwAA9vFu155w==
X-Received: by 2002:a17:903:244c:b0:154:5ec5:c4a2 with SMTP id l12-20020a170903244c00b001545ec5c4a2mr333552pls.28.1647788865955;
        Sun, 20 Mar 2022 08:07:45 -0700 (PDT)
Received: from localhost.localdomain ([36.24.165.243])
        by smtp.googlemail.com with ESMTPSA id u37-20020a056a0009a500b004f820de3dcdsm15901275pfg.9.2022.03.20.08.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:07:45 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     alim.akhtar@samsung.com
Cc:     avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, daejun7.park@samsung.com,
        beanhuo@micron.com, bvanassche@acm.org, keosung.park@samsung.com,
        gregkh@linuxfoundation.org, stanley.chu@mediatek.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jakobkoschel@gmail.com, Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] ufs: fix an NULL check on list iterator
Date:   Sun, 20 Mar 2022 23:07:33 +0800
Message-Id: <20220320150733.21824-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list iterator is always non-NULL so the check 'if (!rgn)'
is always false and the dev_err() is never called. Move the
check outside the loop and determine if 'victim_rgn' is NULL,
to fix this bug.

Fixes: 4b5f49079c52a ("scsi: ufs: ufshpb: L2P map management for HPB read")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
changes since v1:
 - move the check outside the loop (Jakob Koschel)
v1: https://lore.kernel.org/all/20220319042657.21835-1-xiam0nd.tong@gmail.com/
---
 drivers/scsi/ufs/ufshpb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 2d36a0715fca..b34feba1f53d 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -869,12 +869,6 @@ static struct ufshpb_region *ufshpb_victim_lru_info(struct ufshpb_lu *hpb)
 	struct ufshpb_region *rgn, *victim_rgn = NULL;
 
 	list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn) {
-		if (!rgn) {
-			dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-				"%s: no region allocated\n",
-				__func__);
-			return NULL;
-		}
 		if (ufshpb_check_srgns_issue_state(hpb, rgn))
 			continue;
 
@@ -890,6 +884,11 @@ static struct ufshpb_region *ufshpb_victim_lru_info(struct ufshpb_lu *hpb)
 		break;
 	}
 
+	if (!victim_rgn)
+		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
+			"%s: no region allocated\n",
+			__func__);
+
 	return victim_rgn;
 }
 

base-commit: 14702b3b2438e2f2d07ae93b5d695c166e5c83d1
-- 
2.17.1

