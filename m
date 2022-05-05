Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB4351B5C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiEECZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiEECZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:25:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126CC4B1EF;
        Wed,  4 May 2022 19:21:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so3125729plg.5;
        Wed, 04 May 2022 19:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8tYXGu935tCO4A1yLQDnVEfASFN2GrANQDA+wv6yeI=;
        b=hs0QdSt9aR5HZJsrBx0cyFQacevUUGNfXXJmjnhK+snDefAYRtPfS/OJseaupvONmy
         qzF/ATnv02xNB9rPB/FN0JVdDBvbxbuqWxuD4DochLemJ/K/Qw+CGpQi+ZIhwt462/NC
         6grsP2lT0BklqXBS18MMCba8HF+/tdpx0xWEFlqRuicK1ftj2iZgwFEI0jox5VV1ujse
         Zv7185NHU7njna7csplr/VBQ3vN1pLp6ciYpCF4hvBs2zg7Q+OpRSQGYe5QFJ9BeTB09
         5rzpbXdaP1CUx2Xj9xrqu2nQ0CNDYou7JpYLB8VLQRihQOTGOGgrP5mg206nexOcMQBW
         4Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8tYXGu935tCO4A1yLQDnVEfASFN2GrANQDA+wv6yeI=;
        b=iyYOA1Mdn88HKLa3Xzzqym2ZeHOU7HBQGkAUMzoEbCS1b+Dxdwswot0577Uj9KGOQQ
         X2fEKLT09r3nd5kZfNo55GzXNynoiqtzoQq9VbbSwmbFi0J86RwJm0uMPaW6AvAcfjo4
         DFzTZZIkR4Z+DkO8gxSGZUmbHaDF7GofqteNkBdEk7RdfBK1j/wICy062CHWSUxnZald
         R2MTwOHoPUDGjYJRQQ+Mhv8ScCe8aNeIj2g9XXIqk35kL5KL12R/x69vj1lXiVMWhZ87
         6bryILh+ehqwA4HtneisJxpyjolO4BZY1cvG8STEDyufmE466u16qEI4z6OHPL1Bdhtl
         jx8Q==
X-Gm-Message-State: AOAM530JPA3FlKIicYtKVxll8kgBR1TQpIAGe+IHd2Pk5YAnRVqxMzRD
        6/Z+JjSmEBBpoO/Oatxm36bLGmNTT3k=
X-Google-Smtp-Source: ABdhPJw1JgQ70uS+Tb2Lt26hrrMVuOCjMo2+j9p7TVrg90ySnEN8YqRvbL5Zwhdu3VIXO+AjpdVvjA==
X-Received: by 2002:a17:902:b48f:b0:15e:da68:8f12 with SMTP id y15-20020a170902b48f00b0015eda688f12mr271928plr.27.1651717297536;
        Wed, 04 May 2022 19:21:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id cq17-20020a17090af99100b001cd4989fec9sm4017898pjb.21.2022.05.04.19.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:21:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ata: simplify the return expression of brcm_ahci_remove
Date:   Thu,  5 May 2022 02:21:33 +0000
Message-Id: <20220505022133.55852-1-chi.minghao@zte.com.cn>
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

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/ata/ahci_brcm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index ab8552b1ff2a..f61795c546cf 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -549,15 +549,10 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
-	int ret;
 
 	brcm_sata_phys_disable(priv);
 
-	ret = ata_platform_remove_one(pdev);
-	if (ret)
-		return ret;
-
-	return 0;
+	return ata_platform_remove_one(pdev);
 }
 
 static void brcm_ahci_shutdown(struct platform_device *pdev)
-- 
2.25.1


