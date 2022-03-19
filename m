Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42A94DE5F0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbiCSE2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbiCSE23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:28:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C5D1D253D;
        Fri, 18 Mar 2022 21:27:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bc27so6407028pgb.4;
        Fri, 18 Mar 2022 21:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=YZMUZMRb13gxRVQlDqvdqmbrfa6neN3fcSPMrOn7PzI=;
        b=Bew74swDcYqef96ehtkWNmKyQ5lC/TfXk7XTkZOOpfEj/GHCpfvpuCeYMedZ4DI9B9
         045sYlK3LZMvy+5vNRi00+1KocmzQfDq33Pp2f+VEejt6HKXYeM6OzhQ97vfbP7TGLy4
         tCmTRzqHfjl3mIehaHhNmmoKmVpn1sQudbV5j/xFY1j5/CA07PpAd/VOdcE94UgiQpSG
         gmh/ZcYi2SL5SCMKhvosXB+/MQAaLXH3VQ7M5iY0Rqsc3fMPXZ18zmZRGlr55mvaS6OV
         UhJiAzN7RbrDdMMm7T22o6o+LwFkYTnpJp2vVtUrVwmRO/DJ1NxFJo0zQDEC0bticwst
         R1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YZMUZMRb13gxRVQlDqvdqmbrfa6neN3fcSPMrOn7PzI=;
        b=uE5s36eX77JxXKZLseZ85CInyHx3WrQH6hrVEEqEtIL6GMZ2m5Xmgf70k6AJQOZKEC
         MBSJRjjcIkqn280r73Qzc4c0M+bpk/XRnv0tkSvi0wh73qU4+iCu7Qw7Zxosy8lcICMI
         38NjhI7XUwCWlS3UGj8Q3un0N2HjIcHTbis/Uyx+Arm8KN9kAjjb4xZI0emyc2cp2EW6
         hVIhlGbkw/voqbXWR5SReCgL6kHajqDNRQYqvuKKOv2URdIIKEMpnSGX1xpbj5eXAlhi
         cl8BB7hqQzX50XLZ3y/IJHUFqGsC2bV3kwK3D5VKzrLPl33DV70JOeticagRCrIMljhI
         7c5w==
X-Gm-Message-State: AOAM531nrQYnnGj13+L7JrbUoZtMa7fiyXv1ylA3gIH+ordVkHKrvyXB
        8/EJp8UW+UXEYPKi7O4jr18=
X-Google-Smtp-Source: ABdhPJyMJQoE3n6Xaxl4MY6y/hE9op+J2qQH/Gk9qr3ihyaEyHB1BClCeaYZcEfLxBUfDim/emz5HA==
X-Received: by 2002:aa7:8104:0:b0:4fa:2091:d200 with SMTP id b4-20020aa78104000000b004fa2091d200mr13462127pfi.17.1647664028128;
        Fri, 18 Mar 2022 21:27:08 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id u37-20020a056a0009a500b004f820de3dcdsm10884887pfg.9.2022.03.18.21.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 21:27:07 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        daejun7.park@samsung.com, bvanassche@acm.org, beanhuo@micron.com,
        keosung.park@samsung.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] ufs: remove an unneed NULL check on list iterator
Date:   Sat, 19 Mar 2022 12:26:57 +0800
Message-Id: <20220319042657.21835-1-xiam0nd.tong@gmail.com>
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

The list iterator is always non-NULL so it doesn't need to be checked.
Thus just remove the unnecessary NULL check.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/scsi/ufs/ufshpb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 2d36a0715..a3db0ad60 100644
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
 
-- 
2.17.1

