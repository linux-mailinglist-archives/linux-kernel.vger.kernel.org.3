Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C896A4F7AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiDGJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbiDGJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:01:17 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D462E0ACB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:59:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c4so7625534qtx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OX+no6hxlL1LIUDogEtqqTuM8con6ykQVZQuQa/oUy8=;
        b=hYah8tsQYWe1mMuS/KWbwp8nTrfF4SWp7eSFvSSqrfNvuDwAYzvs78sRiO9XQo1OwH
         UzeTDIIq1sLfgXSqOlHBamT0dQcaNN/h/eJ+1NEUDYpIRcQHDuWsCUW/Qa9tNW3rB+tE
         ZBQpCzCSK7a/lwyES3oGZ2WcyuqGjj0jSVQ6ufLV97js2QehrnwAg1TC+58FzFpaKbWV
         ouCgWQ5EP7Y2fvAJcvjg5I+SugKBuJ+CTJiS5gAXeaUhHM1aC9o6X7G5gkliNDV/kUS9
         RknXfaMXSW0wxD90YzzOzex0v05TZK53bD2Xmk+DBVyeqlp7ujj/+xHk91KpEHJEpuHC
         jJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OX+no6hxlL1LIUDogEtqqTuM8con6ykQVZQuQa/oUy8=;
        b=R1pH7FNAhuP3RFeBMQe6gbI5nXuJ7QVa/KRRWFzoURKkNilbfAlZaeolemM1Hrv0fb
         STtpvRlJ8wNNCf5LqjTKtaE2UzDJpqT9yBOMXnGOykURlLTRrptC6TKPyBW2cTXOptCp
         7J2LZQNqG9j+PdvmMgn15L6EgEfLWdj9/jj2A9Z/V/ubSm+paVXbuFkBNGb0d6cen/ki
         jQd9vU2p+QtxlbB5+5J5zxowDuZW/gSC+azkixWU8+UbeelWJ4jOFXb+bC3McgZA5o8m
         X9H2gJovbZRU3YNNb1KgHW6JwMp33imaLaVIQ9XU4AcClSlMCLQC5Ign7ayeIOcQ2Oj9
         0pIA==
X-Gm-Message-State: AOAM530aD9wZTdRYyudoubNWuYGzeSKRFFrk4gbbWMOKwauUZJFTbWpO
        IIo2MLFebNkXqhYbkh7AjuYz/mnceEg=
X-Google-Smtp-Source: ABdhPJz7xzi5mr7zKa8f0PYWMQ7BluOjgYnDYgdNZXFsK+psH9rt0Rn8kgo5vYCKFiVIEyDBZJyoiA==
X-Received: by 2002:a05:622a:1cb:b0:2e2:27da:74c4 with SMTP id t11-20020a05622a01cb00b002e227da74c4mr10821609qtw.462.1649321957587;
        Thu, 07 Apr 2022 01:59:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d22-20020a05620a167600b0067d8efed4d4sm11508829qko.26.2022.04.07.01.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:59:17 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     jk@ozlabs.org, joel@jms.id.au
Cc:     alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fsi: master-ast-cf: Fix missing of_node_put in fsi_master_acf_probe
Date:   Thu,  7 Apr 2022 08:59:11 +0000
Message-Id: <20220407085911.2491719-1-lv.ruyi@zte.com.cn>
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

of_parse_phandle returns node pointer with refcount incremented, use
of_node_put() on it when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/fsi/fsi-master-ast-cf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 24292acdbaf8..5f608ef8b53c 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1324,12 +1324,14 @@ static int fsi_master_acf_probe(struct platform_device *pdev)
 		}
 		master->cvic = devm_of_iomap(&pdev->dev, np, 0, NULL);
 		if (IS_ERR(master->cvic)) {
+			of_node_put(np);
 			rc = PTR_ERR(master->cvic);
 			dev_err(&pdev->dev, "Error %d mapping CVIC\n", rc);
 			goto err_free;
 		}
 		rc = of_property_read_u32(np, "copro-sw-interrupts",
 					  &master->cvic_sw_irq);
+		of_node_put(np);
 		if (rc) {
 			dev_err(&pdev->dev, "Can't find coprocessor SW interrupt\n");
 			goto err_free;
-- 
2.25.1

