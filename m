Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C1565DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiGDTFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGDTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:05:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA7D9F;
        Mon,  4 Jul 2022 12:05:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r14so8847379wrg.1;
        Mon, 04 Jul 2022 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEBSbyyAriJ3axcxzTJOLoEF87twdXMhPEB9eDVIr3U=;
        b=JN7kMXbpqSYP8XlB6hY6/vmJLbzYxjT3ky1kqpqyPBmg+fk2a0vanwxn2qykBhVdE8
         9TZW7U1AG/yeP/orQPhRoMNbc56jcROPqAIDicIvrTgO5Ms6kwKFBcPjJv81A9VI3zYn
         VeF1JXQvWgFscEZRIlbhj/RhFZiwLNBsh2Z552vaBV0t9qwysIZBIPCsxeDmwuuUgFqR
         Wk01HoigCItp7/QccbAooLbigWRwXkUmgBA1HQTc+wuqlpF7mUtIOBbaEzeUkFbHaRH/
         /Gc3RjG8whX6vTZ8U0KqlPXt+Vz09/R1qej9ChBq1qzH+KMpupvRdlL4tXipKvvMVjPN
         ryEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEBSbyyAriJ3axcxzTJOLoEF87twdXMhPEB9eDVIr3U=;
        b=ygz8+wGHOYitNJIUaGTKkyaFbVKcy3tdQDw3C6x39nAyCAE/G98DUw1jhHp7Ztd5a3
         S+n0AAP0lKky8ZvDvKgFRrnI5bWyFGoOaCSH5263DsoLB42lLzwVqTi5cTwxc4OMf4bx
         aWk8jXPw79VSrFLipWUUm29qjsb4q4X5v6mfOYf6JPcUgahMq8XhQV4JEWj4yGhR9vCQ
         vYnwAv50lcKJyrgj8t6elw1eijPImHrDw5LosXGtAUa8PkTwrVtkN5RXiuBVUZ1u7PEb
         6gwFfXsTCFDiUlZmwcx7qp4L7LWeaMPqFHbXo9TKhCCBpuWtHJLDNF7lo2fq2+1jO98U
         xdwg==
X-Gm-Message-State: AJIora9Li6n5NgE5iSw+Jz5nW+hSQyVcqeNwJza5tscKyX78BqglQJZJ
        Oc6d6ngMey/toh/QsYd8bBA=
X-Google-Smtp-Source: AGRyM1selk9vQO874eIZGtcdX8d03YdOesjs/jdxQk+lZrli65FVjoppNiuB0CjDD2uoA31Smellsg==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id k6-20020a5d6d46000000b0021b933d7950mr28313024wri.679.1656961498051;
        Mon, 04 Jul 2022 12:04:58 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bv13-20020a0560001f0d00b002101ed6e70fsm12243662wrb.37.2022.07.04.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 12:04:57 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vDPA/ifcvf: remove duplicated assignment to pointer cfg
Date:   Mon,  4 Jul 2022 20:04:56 +0100
Message-Id: <20220704190456.593464-1-colin.i.king@gmail.com>
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

The assignment to pointer cfg is duplicated, the second assignment
is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 48c4dadb0c7c..47b94091733c 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -29,7 +29,6 @@ u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
 
-	cfg = hw->common_cfg;
 	vp_iowrite16(vector,  &cfg->msix_config);
 
 	return vp_ioread16(&cfg->msix_config);
-- 
2.35.3

