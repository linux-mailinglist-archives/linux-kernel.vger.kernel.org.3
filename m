Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79808539FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350528AbiFAI7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349918AbiFAI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:59:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62225FF2F;
        Wed,  1 Jun 2022 01:59:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so3402012pjb.1;
        Wed, 01 Jun 2022 01:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMm6LDO9HaycE7ySguur0oDwpAPexCksx4/hPBqXKiI=;
        b=KvhnVMB+JjobSo/vPePqYcHsyMJL3CR3AzBCkqN2Hdv/6SdXiKFhiuLTdSnbDR8mn3
         ejP4t9Hm6WsFAejyO6BuVi1krRYRD44Hv2JcNb3FAEj7KcEHFxsyVm5Tsz01hEFwjzS6
         r3q82IZdeOTvhZLuXnukNGfRlf8pLOxfCgU96M9UIuPidO8EF3BtSE6b6ku0Qsp3vgVj
         S9Nyb1CPGd9o+olwb3dT4mml6iQVZZg+u0qp6fRwtUfnJyPByOOsvZskGap7E32CAREB
         2UXBspK9tu+cGnhh4XefkDkMRrh05e2fdm4ObqU++tsbdQ1a5mc/tKsRctiUGiiyyNJi
         xUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMm6LDO9HaycE7ySguur0oDwpAPexCksx4/hPBqXKiI=;
        b=7hNABX0dufjHHSVxUg1615bd1oGpAGT5Pt1tUszLy+2eNnZQ++yukyv7MggdqYGbZH
         9M+s3g7+rBVoR1pL6kMd/9TzRhWh0lIde7WpHG0T4ZwzGvOhLkbgoyRFvNUGsCXaZuJ8
         w5gl3+820p7dwzjOEHIbuQzQ14oVtgA5/uRlq8ZoMeX4pVK3+tSYSzgEIK9nrzhptP5r
         fhcYSVuAL31bicEL70B+ROrtB/rmbUVVAXB8FWum5I60g7I4Mmo5RyFrKiJGV6Cwfdaf
         pI66gfkQNE9J+7rmfEr1UTEE8GDyP3xGuwY22oEguAg7x+urw2XVQMcbtCEZi0KGOt4w
         A6eQ==
X-Gm-Message-State: AOAM530/mIAx5krrxhgL2N6zrqVUoyivi9dKyaDvLvECuVuG4Mzgmq9i
        K0/HPCDQFnmAxloGjt25GJuLGaB/zoj8vI9T
X-Google-Smtp-Source: ABdhPJxxhngx+SsVlEr5i0qbYYrSzMyuUez+2/ZluBDSAoLLQW0y5ujc+CQwHxKuGmqwYSdv+WcYlw==
X-Received: by 2002:a17:90b:3b92:b0:1e3:16b5:33df with SMTP id pc18-20020a17090b3b9200b001e316b533dfmr12841785pjb.198.1654073980247;
        Wed, 01 Jun 2022 01:59:40 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id o6-20020a170902bcc600b00163f2f9f07csm981290pls.48.2022.06.01.01.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:59:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Garzik <jgarzik@redhat.com>,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe
Date:   Wed,  1 Jun 2022 12:59:26 +0400
Message-Id: <20220601085926.45183-1-linmq006@gmail.com>
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
Add missing put_device() to avoid refcount leak.

Fixes: 43f01da0f279 ("MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- Add put_device() at the end of if (dma_dev).
  we need the null check and do handling only if dma_dev!=NULL.
- call put_device before of_node_put() in error path. keep the
  reverse order of resource allocation.

v1 link:
https://lore.kernel.org/all/20220511062723.56652-1-linmq006@gmail.com/
---
 drivers/ata/pata_octeon_cf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 6b5ed3046b44..35608a0cf552 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -856,12 +856,14 @@ static int octeon_cf_probe(struct platform_device *pdev)
 				int i;
 				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
 				if (!res_dma) {
+					put_device(&dma_dev->dev);
 					of_node_put(dma_node);
 					return -EINVAL;
 				}
 				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
 									 resource_size(res_dma));
 				if (!cf_port->dma_base) {
+					put_device(&dma_dev->dev);
 					of_node_put(dma_node);
 					return -EINVAL;
 				}
@@ -871,6 +873,7 @@ static int octeon_cf_probe(struct platform_device *pdev)
 					irq = i;
 					irq_handler = octeon_cf_interrupt;
 				}
+				put_device(&dma_dev->dev);
 			}
 			of_node_put(dma_node);
 		}
-- 
2.25.1

