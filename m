Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AC4B26C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350425AbiBKNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:06:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350401AbiBKNGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:06:15 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241DF3E;
        Fri, 11 Feb 2022 05:06:14 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h18so8524888lja.13;
        Fri, 11 Feb 2022 05:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tX9YbbK4wZDYd/1rJF+Fsl9cu8MwUvaAy3wkrzRgdck=;
        b=EYhftBejqCnc8+Xc8fkkRb1kgXnwY9DZicwijRuZEMwqwLctCSRnWT3czltZ1Oe7Vi
         RRYXVlpSymNMkx85YtOHjmuCrs4Rw1nSL9N5I1CLdYMj78PYUCVl0FtUgXFjgJTHx9TZ
         HQdK1nrxeRo/nseosHSxIJdwwgSttMcTBwBK7BVq95O65zEO9lyQT5Ko+tFf1bS7VG3S
         OQuJYPPe3DOGMSto56n04z06eUyBmXcgu4jxGd9GtAbNNXNIKURGrny0I2FNPa2g2E7a
         O6NltEOPRVDIM2iBU+78Qa4FgjfDX3ggUzOcjIBgqXnASsQX3Yep9azAufzehByV5hAI
         a6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tX9YbbK4wZDYd/1rJF+Fsl9cu8MwUvaAy3wkrzRgdck=;
        b=sxdRVAgcay7x932FOLqpu8IKS8tJAH61RI0iTGIyIXQWg1hum1sIML9xRurSn5ttAh
         52tNGjhsU3XvsX7h1hCdq8cpqvJysvskI8RlWQVlstxrsSnCWZ51+PcOyq33iw551C4a
         zuvA0N9cT4ftutDU2Tk1Ss/4ev3AcaZZknsRqKvYxKKGMLKHTcNR4ctp4sAnqQ8ElATF
         th/xTFKm7btdFLhF3q3enxYT/hZZX04sWUDbDcP9hJEFtzSE+R8q2DupNquYSzHB6hA1
         XGY+fcdr6kjVw3MRHVxJ7a7VfJKIiLB0EvnLzK9Hl9/ZJLLyk7dDO8ajmoHaipWrsw71
         0iww==
X-Gm-Message-State: AOAM5336HN8ixAEcr/M25PWO1UF7TIBDyB1FaecmB3CEV+zkZiykNPFT
        FvbUCF6hrl0nOHRQ8IhNWZc=
X-Google-Smtp-Source: ABdhPJwjh3Lda7G/sGCxxqTFqmt+fCLA8UjkG+crA1HMkLbUpGWDYr9nLfTZA8qjf3oHiyFBjGOzjA==
X-Received: by 2002:a2e:9d96:: with SMTP id c22mr976389ljj.293.1644584772698;
        Fri, 11 Feb 2022 05:06:12 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b13sm3111094lfv.175.2022.02.11.05.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:06:12 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 3/3] nvmem: core: add cell name based matching of DT cell nodes
Date:   Fri, 11 Feb 2022 14:05:54 +0100
Message-Id: <20220211130554.13062-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211130554.13062-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220211130554.13062-1-zajec5@gmail.com>
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

