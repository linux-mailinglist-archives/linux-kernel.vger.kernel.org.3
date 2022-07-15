Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBE0575C65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiGOHcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiGOHcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:32:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E97B791;
        Fri, 15 Jul 2022 00:32:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q16so603271pgq.6;
        Fri, 15 Jul 2022 00:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xhkyx9F8tVf/d1N3ebELfQNQ/kZk1tVV6FgOJJw40IY=;
        b=C1hnfgNGaErmtt8GJW4mRcledeMDc+BKsT3jL2oNeLMSsXPO9Pc/31a/WFaNbmzdxt
         lh2PyHvYO3Wnu77HG+VBTx5EvsI4jT3kKgzswpLCjfogL7GGYgvop/AFV0NKrth0fW1P
         xFAmy2b2Tu455xd0ThMFark18woIImv+t7IRqdF2A2oquqj6XAXNwGheB8lExuPSbKn4
         Er0BhTIk2CTvqJjq4tL5KG6yBejfxigoarArap/QcE/AeRAbfLRupqdEuA/Vm3sO2nd+
         qe3LK6Dazmn3ZHuv2vOZZnUw0ScN58s+SaDqJu7p1REYYuemCUmRjlNyEN2sYPCF1Ykk
         u+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xhkyx9F8tVf/d1N3ebELfQNQ/kZk1tVV6FgOJJw40IY=;
        b=nWdRuND1Hy+cuNOTzxqzH+3QADC3fb0N44J0yj/f1QUQMovgLNCWyPG/wWFMqe47Bh
         aXHikPAQBCub7V+wCGFTk/KQdhCB8g4V7hycVoJh4gDz48FW3sZB/cosJ/0YMtdFD6QT
         OjT/w82o7KRTq0jS237Fh+qk8s9KFSqXy2P+C3CdvtmL+IK2egx9kNkWKyL327454kVM
         03HzjWfM6LqXRaenEDhv090myS917inw2MMPBGIR0EOKCpXGjoCS+BO7z1TP2SfBwQ8d
         HdK0kbjf6V2gC8SV0nmqH6QH86Uge9vhn9vnCgQbJMeoFOpylnbi9rzznwt0z5J+EInh
         3Z4A==
X-Gm-Message-State: AJIora+UYo9faBWFWUGVi5ndNsmqiYx7sPm0R4fery9MUQx5GCczoZla
        ddXm3/lRxVYt0UFSlGSroaArY8QqkDkn
X-Google-Smtp-Source: AGRyM1trd/AxNasvP2q/f2x8cI3MIE1OGA5Psan5P6i+mPcJOPVGahunHQYMVrrkmpDNNOpDgC4cYQ==
X-Received: by 2002:aa7:88cc:0:b0:51c:319e:772c with SMTP id k12-20020aa788cc000000b0051c319e772cmr12431831pff.41.1657870355444;
        Fri, 15 Jul 2022 00:32:35 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id x14-20020aa79ace000000b0052ad49292f0sm2962590pfp.48.2022.07.15.00.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:32:35 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] scsi: pm8001: Fix the warning when failing at the probe time
Date:   Fri, 15 Jul 2022 15:32:21 +0800
Message-Id: <20220715073221.3364198-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
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

When the driver fails at chip_init(), we will get the following warning:

[    7.778705] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'pm80xx0'
[    7.779414] WARNING: CPU: 0 PID: 290 at fs/proc/generic.c:720 remove_proc_entry+0x389/0x3f0
[    7.782793] RIP: 0010:remove_proc_entry+0x389/0x3f0
[    7.790813] Call Trace:
[    7.791284]  unregister_irq_proc+0x14c/0x170
[    7.793043]  pci_disable_device+0x1ad/0x380
[    7.793396]  pm8001_pci_probe+0x6d9/0xd40 [pm80xx]

Fix this by free the irq before disabling the pci device.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 9b04f1a6a67d..71ade184ee6f 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1159,6 +1159,7 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
 err_out_shost:
 	scsi_remove_host(pm8001_ha->shost);
 err_out_ha_free:
+	free_irq(pm8001_ha->irq, sha);
 	pm8001_free(pm8001_ha);
 err_out_free:
 	kfree(sha);
-- 
2.25.1

