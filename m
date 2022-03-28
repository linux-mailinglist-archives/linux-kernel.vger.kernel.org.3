Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16404E8C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiC1D3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiC1D3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:29:46 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCD8321;
        Sun, 27 Mar 2022 20:28:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b18so11293459qtk.13;
        Sun, 27 Mar 2022 20:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhfnGBc1zMeNDHlXmiDZZwnSVLaEg/Q9PFtmWw5kI1U=;
        b=UK7jIQsi9lqpK4VRqUGZm4XwsRzwYPebczxkscgk7THS0IL1uq/Wc/xa/Bv1yPkUKI
         a28dLon+1WGmiyYO5Q46hjMryEu/9mqyUBl8L6AZXbiz0rWryS7DmJXny0ajSq+NRJXJ
         AQaz7xpl0pACcA0fapVn/SUpQp51jYgfpn8fWSIfShnml3LigfamSAQzv6DhA7IvP9M2
         OpJ2ArjAqQSyQp5+o5Z8kwLOgwaj4w6t2+QUPaG9b/Ru9hHaWmCLQaNw/d/w4+RVB9/f
         9yUWtqE/2jRINZhDP8q5Qih1GMPGiQl/0p8i/IaN844rnSJz8VwDiNy+wnEMK1NuCE2o
         TKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhfnGBc1zMeNDHlXmiDZZwnSVLaEg/Q9PFtmWw5kI1U=;
        b=jqfRqZ83yEU5mmF+82+Ka1chahvIE3bNh6QsfzQQ9MhazOAeOX5ix42+88Q/QXkFtj
         lILIfUf0fqiOtZnlKB87QyQ1I+SwPHgFTNfKH0k3RTwvbrgOVHWbd9mBs00S2s4Ezr0i
         1ddveSmeSdcqqBeaSMWAeFjsK3dp5qiaJ3tHj8oLPFcipUfGYT3+4F1M7c3+lmTQuuUt
         NCptrkb59ObN1useaVNicUHMRYShPy6nqopVudJZLoZGkPRuF7kcMbTyU/Fsgb+Q8xYQ
         QSFHwx5IhF2/waTxVpVakrezAgeajuQdzkYQxhleszp95d27jVpQmvUgazYnoEW6UVWK
         CW3w==
X-Gm-Message-State: AOAM531YRWRHJVuvrcoP7vS9L3shBhbs615E+squI48e9S1W0+m0OfB4
        28v34yM2c/xX6gqITkqsakY=
X-Google-Smtp-Source: ABdhPJzkxCMRpipAJw7RMOhsG1MT3j4e5x+gJF3vDZqCQzpHaq5Zq7JxE5DtZvkIU31q0N7VFBcfIQ==
X-Received: by 2002:a05:622a:15cf:b0:2e1:e5cb:aed3 with SMTP id d15-20020a05622a15cf00b002e1e5cbaed3mr20127111qty.524.1648438086294;
        Sun, 27 Mar 2022 20:28:06 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o13-20020ac87c4d000000b002e1e732dea5sm11745455qtv.70.2022.03.27.20.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 20:28:05 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     james.smart@broadcom.com
Cc:     dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: lpfc: add NULL pointer check
Date:   Mon, 28 Mar 2022 03:27:44 +0000
Message-Id: <20220328032744.2371667-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

kzalloc() is a memory allocation function which can return NULL when some
internal memory errors happen. It is safer to check NULL pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index eed6464bd880..6cc8765b0a92 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7159,6 +7159,8 @@ lpfc_sli4_cgn_params_read(struct lpfc_hba *phba)
 	/* Find out if the FW has a new set of congestion parameters. */
 	len = sizeof(struct lpfc_cgn_param);
 	pdata = kzalloc(len, GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 	ret = lpfc_read_object(phba, (char *)LPFC_PORT_CFG_NAME,
 			       pdata, len);
 
-- 
2.25.1

