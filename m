Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2244BB2E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 08:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiBRHIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 02:08:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBRHIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:08:10 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292BB1BA334;
        Thu, 17 Feb 2022 23:07:52 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p22so3655753lfu.5;
        Thu, 17 Feb 2022 23:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tX9YbbK4wZDYd/1rJF+Fsl9cu8MwUvaAy3wkrzRgdck=;
        b=pxTGNtwoQqXXXR2NQW0yIPEwzA0QmPkCsh3TL6HrB99Tf4HSx4B99Dqicg+E+RHzC4
         MHVO+WtCge/ccF+M4pDhmB+OD4gvoQIUaWPxzX5LNEvLfpsBaQVMP8fhanBREMlxHQ5E
         ZdNRPw0yRGsymvyZkIp1f+lCFpsngd3NFTe7zgypaZr8kw1W8gcuioLuvcbUG/YW02Vg
         Gisz5pm04fQLQuetkLKo5JcrTCmFE08MjcSuSeRa3UDe8sOu+okvGvlfJJc9FkH8OQRW
         qUBLmGNGZGFsQc3a7ViJMZUUZyVUeahBQTItXu0/PqWVLKKFJp/uB5ta0zEpLyVc60qg
         wjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tX9YbbK4wZDYd/1rJF+Fsl9cu8MwUvaAy3wkrzRgdck=;
        b=aMxHVL5xaH6e2E1nYq5lgnZE0V1AszvAY2otdHup8Dp69N6IN5tgRpV6gtU6qbv0hW
         8Czuy94NEtQwz7AAB7XxJMlogXXSrvJm1wKnqymrI20p2uW1rnUrqyLrzV1GzyFQRDwC
         P1g13gslrlxEbZdSfF0MIQGrV3dyS+Kq8qJ/MN3rI5c+NGeYvIVD6oU4S9G3S8xdiTIF
         NMcPMRXqqCpzbwHvxMthGqrg3as9yBhAUm0V5j5WMoWHIc1JfWHvtNna34E9uxYNz6RZ
         I2KG89Rrgzp7+Eoh1qMWBsbH54n4hjwp9RsYhEsaFQNMwtUmGpfzqLWSNCzTIdcpd16x
         2hnA==
X-Gm-Message-State: AOAM530SpVWoXuPdhgDRrgCUYYu+O4QiCuJ7+bvaLBJp+KB8wa7xK4em
        90QAdpta8IvD2sinS+5bZzE=
X-Google-Smtp-Source: ABdhPJxGeC6tp3SeoxUP99YYLkCjtoNxEe4/ANtehLPoJQ2I5YnOQLjx0VpstabDvYhzosZJadeOmw==
X-Received: by 2002:ac2:554d:0:b0:443:6539:a299 with SMTP id l13-20020ac2554d000000b004436539a299mr4590089lfk.552.1645168070508;
        Thu, 17 Feb 2022 23:07:50 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id f2sm216321ljn.11.2022.02.17.23.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 23:07:50 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 3/3] nvmem: core: add cell name based matching of DT cell nodes
Date:   Fri, 18 Feb 2022 08:07:29 +0100
Message-Id: <20220218070729.3256-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218070729.3256-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220218070729.3256-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

When adding NVMEM cells defined by driver it's important to match them
with DT nodes that specify matching names. That way other bindings &
drivers can reference such "dynamic" NVMEM cells.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 53a43d843743..a891449c52f1 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -499,6 +499,31 @@ static int nvmem_cell_info_to_nvmem_cell_entry(struct nvmem_device *nvmem,
 	return 0;
 }
 
+/**
+ * nvmem_find_cell_of_node() - Find DT node matching nvmem cell
+ *
+ * @nvmem: nvmem provider
+ * @name: nvmem cell name
+ *
+ * Runtime created nvmem cells (those not coming from DT) may still need to be
+ * referenced in DT. This function allows finding DT node referencing nvmem cell
+ * by its name. Such a DT node can be then used by nvmem consumers.
+ *
+ * Return: NULL or pointer to DT node
+ */
+static struct device_node *nvmem_find_cell_of_node(struct nvmem_device *nvmem,
+						   const char *name)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(nvmem->dev.of_node, child) {
+		if (!strcmp(child->name, name))
+			return child;
+	}
+
+	return NULL;
+}
+
 /**
  * nvmem_add_cells() - Add cell information to an nvmem device
  *
@@ -532,6 +557,8 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 			goto err;
 		}
 
+		cells[i]->np = nvmem_find_cell_of_node(nvmem, cells[i]->name);
+
 		nvmem_cell_entry_add(cells[i]);
 	}
 
-- 
2.34.1

