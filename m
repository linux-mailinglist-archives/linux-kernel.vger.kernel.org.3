Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353EB5150D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379116AbiD2QbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379091AbiD2QbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99448D8933
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e24so11442200wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mI7n1NLRE2SJ0nGq1GuXHkLC+FfGx13T6nrAvtwR/WM=;
        b=PriGK0hSLnTS2cEJ+8PWs2vh9pUtjydmRrC3DSfgUHwogh0l2BHrOQYPMmQ9NnT00m
         JWsLo/RVbQV8IqxodaIw3hgYW5ZWti1Iyqa/i2k+38+s1hIpfv4dHTWCgwwY++uHARYr
         wbnoZIA3qYMz3YKu+3AAn7edSudw0xSwPsI3oBtMOQ/hiOzXZKORETz6HS7jqeX5AL8h
         IrDJULRDRD3TvPypBfwUkFvk6flChvXpixC3Q+uPKp11/ELD2pHEMKDgdzuhwugb8Eht
         qBPkK8ygajUnpMQa5Ia5mWMLsswnjWSEbGQtvOirttoKjsOcKZTTCQt35E12Ymfos9ds
         w89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mI7n1NLRE2SJ0nGq1GuXHkLC+FfGx13T6nrAvtwR/WM=;
        b=sMbq9iF7L9Uokj3/XleizFwHNAtA0rk93aYaW9/ebDLEdwYVrJxDVcok6ACvNEUAdU
         rAJQxAcrI1N1Qb7+7W/cShREBKrIqRel2th5fq3OpUOi5RYLutqVhAtd66HKXhNwpsIH
         iw9vc9GV9Z0eGkFRDfVJLSfX8WNJytw8C8lI5F75/LQekqIwmNQE13OGl1z9KBabVrJH
         jMNCCs3x7YJ9YJOPzTzZ/F8XFDrF3WeIDsqO0BhurnhzyfHTvzsokHGtJr3+w/vG9ugy
         EToJLcuPTZ1ZLPLHaLNWGsdwig/PQfa8nn8FK/HMSN54EC57hysQ5mjTPHRg3JS5OL0V
         Tkxw==
X-Gm-Message-State: AOAM5325JkqolWgPMjM4dgBlA1qqKodg2rUl7vcvn0OOl/SscW3DSkoY
        YxI5pVrLMReJqx+Uviex5lhk/w==
X-Google-Smtp-Source: ABdhPJwAW+PCsz1kk0HbPOVAVPEoNj30Gybb1JbMaNpx4iKlaVMW5ioc7YSOio+KjFoTaUnEKSJajQ==
X-Received: by 2002:adf:ef01:0:b0:20a:8068:ca5e with SMTP id e1-20020adfef01000000b0020a8068ca5emr30867930wro.661.1651249674218;
        Fri, 29 Apr 2022 09:27:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:27:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/16] nvmem: brcm_nvram: find Device Tree nodes for NVMEM cells
Date:   Fri, 29 Apr 2022 17:26:47 +0100
Message-Id: <20220429162701.2222-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

DT binding for Broadcom's NVRAM supports specifying NVMEM cells as NVMEM
device (provider) subnodes. Look for such subnodes when collecing NVMEM
cells. This allows NVMEM consumers to use NVRAM variables.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/brcm_nvram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 439f00b9eef6..450b927691c3 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -72,6 +73,7 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 			return -ENOMEM;
 		priv->cells[idx].offset = value - (char *)data;
 		priv->cells[idx].bytes = strlen(value);
+		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
 	}
 
 	return 0;
-- 
2.21.0

