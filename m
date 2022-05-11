Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16932522C49
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbiEKG1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiEKG1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:27:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6990A22EA74;
        Tue, 10 May 2022 23:27:32 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q76so929871pgq.10;
        Tue, 10 May 2022 23:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6QMLfxwOjrgEo2T024s8tceNALt/NjOUTGCdVzN17Y0=;
        b=lrbiXuOxFTroo21bJnsXw8lr9QSBUnK/XFsQaWyDte2CMf+ycoWwOfCC4v4QsXIaFA
         v3EOJP0bb7sWXSLScJL+uWVTk4ckOrs8s8wtuFOSm+xpeGk/VbobBqsTJx3yjXeNCqAl
         TSVRYB1r7UaShsu4uZ/fjlXb2J8LKDOBQL/IZxFNKHNu1TrC+1/sC0NTm7aQYMwtSIvU
         8Mi4akg3JxsMVgziu+MRSwxvmjap/XFPlaTeUH0l8yHVShfFbkWyaxIpaYiK4OaJPTyJ
         WQnehxWCd12lf/l+aB7NBo9bVJ96nczhnI5cEMToNNK/+7snh0Gvi6SaIRUXxWk5YShU
         CRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6QMLfxwOjrgEo2T024s8tceNALt/NjOUTGCdVzN17Y0=;
        b=V7fMUxA2exlXqCEY7jRPDdstjCy31lDJrqRkawpbgB6B5YDvwxYbJaYAisFXYqS9ov
         VBP2pG2P0TaWv6tvlOWxZwoBF3bufMJ796fmpQtXZq/CTaTQM2yevimzaE+bbSUAhDao
         ZdFKffi5Lsf9sO4ut5fMBwelkRCqyS3RuTilqnmL06oHc0nJqr1F2hsfkXTCW+Qxi3gI
         tyLCWy0rfqia2PLcMjko5zrcTFTfqfL8xpQpUSU5s8H/jJZQsyLzxRlB5P0hB1r9d/j+
         2pUf1iYQ1eQ5aa9YIc2KxqVqSp2DGjz97rR+NGHnK9Icm8wvn0Vel8jhoXsd7i8aNXES
         bdbg==
X-Gm-Message-State: AOAM530YRlLWZ1IR0PUj6/fpAGfhDDp2Oyr50IYp3JZ+uFL8uTPmjtV7
        0Ca04T1s5Ou81eU8TWHgzV8=
X-Google-Smtp-Source: ABdhPJzV7M8WNxLMmly7NZZKEXlt2lXzDUTZ89qzMV6tl2sP0GFbTZJ9KfjTX4f3cCcU/Dstwic0Pg==
X-Received: by 2002:a63:da13:0:b0:3c6:4c0:e2f9 with SMTP id c19-20020a63da13000000b003c604c0e2f9mr19585290pgh.493.1652250451978;
        Tue, 10 May 2022 23:27:31 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s64-20020a17090a2f4600b001d7f3bb11d7sm3173716pjd.53.2022.05.10.23.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:27:31 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Garzik <jgarzik@redhat.com>,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe
Date:   Wed, 11 May 2022 10:27:23 +0400
Message-Id: <20220511062723.56652-1-linmq006@gmail.com>
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

of_find_device_by_node() takes reference, we should use put_device()
to release it when not need anymore.
Add missing put_device() in error path to avoid refcount
leak.

Fixes: 43f01da0f279 ("MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/ata/pata_octeon_cf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 6b5ed3046b44..65688459acf1 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -857,12 +857,14 @@ static int octeon_cf_probe(struct platform_device *pdev)
 				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
 				if (!res_dma) {
 					of_node_put(dma_node);
+					put_device(&dma_dev->dev);
 					return -EINVAL;
 				}
 				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
 									 resource_size(res_dma));
 				if (!cf_port->dma_base) {
 					of_node_put(dma_node);
+					put_device(&dma_dev->dev);
 					return -EINVAL;
 				}
 
-- 
2.25.1

