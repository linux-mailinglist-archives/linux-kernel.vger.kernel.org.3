Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1849842B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbiAXQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbiAXQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:03:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A55C06173B;
        Mon, 24 Jan 2022 08:03:21 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x11so50884812lfa.2;
        Mon, 24 Jan 2022 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfS/F/Wf9bu+NmDqBxpkt9bmTl6S69QHI1qpficbqZk=;
        b=BPJQ7SJ1V0lmwC4C01DIbifBg7ehy+WB5aIuFTp6EjdCDMMOsA6mfQfRV+4UTcrNdP
         Tdhc3iHt54ivoyVnXU1mWG1lf0abJKqqCwnPElabBBzQHWByy7GqLaXpvkooORBA0tJt
         xYnkY6QuTkwqjY1Bq0J75UrtLrn4urM2LojwoL00czhU7e+nAvLQmzUmfyTajF7xW+Jo
         LHFCXOsg5Ey6JaFG3qSVGmym+Uw2qL3l2Zfy+x7yQN3k4k6G0RocYgNZpUiGv71dfVh5
         E4ok0tjNlDPOlkhARkh29k7oFo+teAVcWsyeFpgRqTItoVxCUcVbdab0wfAsWctUpEts
         LXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfS/F/Wf9bu+NmDqBxpkt9bmTl6S69QHI1qpficbqZk=;
        b=f8gYXlwAuzLYA8wMmhHan2LIT1f2q9ziy2DUCvWfQdOMmnZ8NsFr0rxW6HQcXjD9PC
         y9tIMP67i1btKsXwFSTedGF6fbGm+Bn5PSKTlwlfxMlyxmKTTnH/MuyNCkGkX5z3salK
         gfQTh/T4AU2eh2rJ2omafZtY5jaApvKePRhT+wKQibKTwI39zueA2LDRZkGEo5Gl5KV8
         ptcRj6I5FnAbrb5vds9whxbXuHjMt7i5KoNeOC9a1x/ewhl36MdJ07BH/locVBHo1cyJ
         JSl1hWIXPgmbcIecu8YnTqTmvtyDT2E4uHrkBDUUfxnfuYa/+maO647pNtPL8zvjzQ09
         xsCQ==
X-Gm-Message-State: AOAM532M24WxxUoTqpu8DNIQ7zxUT3pRC8G8fvK6vUVndRcrISmGxXfJ
        uIq/1T/39pif7ExKk4K9Aks=
X-Google-Smtp-Source: ABdhPJxAfwvpekuz53Sh6fCrPpxNEfqZtyyPgqs42/pS7SEszF6KXyJ0UzyTB8S3DJyXgws5ehsBog==
X-Received: by 2002:a05:6512:b84:: with SMTP id b4mr4711978lfv.652.1643040199237;
        Mon, 24 Jan 2022 08:03:19 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n21sm674187lji.18.2022.01.24.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:03:18 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/3] nvmem: core: add cell name based matching of DT cell nodes
Date:   Mon, 24 Jan 2022 17:03:00 +0100
Message-Id: <20220124160300.25131-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124160300.25131-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
index 23a38dcf0fc4..9a1299a7f46a 100644
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
2.31.1

