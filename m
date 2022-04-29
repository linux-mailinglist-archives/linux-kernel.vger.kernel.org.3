Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1285150CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379107AbiD2QbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379075AbiD2QbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B3D8920
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p189so4911059wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e6ar+XxU37QB2aFpX4f2hjgRwMYzw0bu5owiNbvSfoc=;
        b=KlZ2rvfkJgWC93f3WJwVGdP8EGPjxUTY3rfCaXPI2f5fgeAfcAwEIpyqZrDrWZMlch
         N8xBUihznzsPwrQMKQuxJpxzWRuhJgsfAZcpPk6m17lX1fMtrcyn1sV+YpEPY3Wt6k48
         SPPsD5t7bibF974GFTzffC2YBWwJvXpXBkx8jWoTLURwu1exc84aQ6k2UwKULTv/Xmhz
         fb9EfybB408F2mL59umYxMG1DaDjSqNGaG892YUgtZbsW6A5Wfl/aRzhDkfYk8UsX0ro
         cNHM59yMuehH+vopkCdR5MCxGHzjtEzOHB927Q2/Dk0Mb6AA7i+LDYKWKiP9Sqxdhln+
         PdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6ar+XxU37QB2aFpX4f2hjgRwMYzw0bu5owiNbvSfoc=;
        b=JNv9SKIObov4KptnX4OCWI7rDzpA9dvJeopXIzxv79yMNHIAdsA3IuSgDVa6MtNgiw
         EWSVbdNCgmOq37vH9j+2CpYUw+u7XFqiRdRFK+xf43U2Hxfq+mhJiTlRJijt1mGnp2wK
         9JUR9oWaTBX8u0VryJKUDZzO1oQInb4UaSYjPNCkfGbhrTLjtPDnguTmDLZHTEknZU9y
         ZimGidf9c6tj/QBvuXBp6WBfXZ3k/1sc/+lvWyKfOYGuRVWSDX+NfgR3Pln2fUF+q4ug
         WW+lqUbgnf9b8qj2GGZOb4wQFwLuypw6/IG6UF05Z6Kp0LX4sLTWtaTReERoaAsg+PdS
         eJjA==
X-Gm-Message-State: AOAM5320p9TB5BSIrDmGk3/8ukGlwlQsZ3VGI8yI9xh9ipNhBAqElg14
        PWREqOuzyKQdK8n1ZAKAx/F5HiKedMczDw==
X-Google-Smtp-Source: ABdhPJy7eQToIh7d1Hc/x5CBhIG49kN0j6I6FeIPDCf6qa2Te2M3IjWb58SXgLbKYYDaNW4IzIW+wA==
X-Received: by 2002:a1c:7416:0:b0:38e:b8b7:e271 with SMTP id p22-20020a1c7416000000b0038eb8b7e271mr3869552wmc.7.1651249672960;
        Fri, 29 Apr 2022 09:27:52 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:27:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/16] nvmem: core: support passing DT node in cell info
Date:   Fri, 29 Apr 2022 17:26:46 +0100
Message-Id: <20220429162701.2222-2-srinivas.kandagatla@linaro.org>
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

Some hardware may have NVMEM cells described in Device Tree using
individual nodes. Let drivers pass such nodes to the NVMEM subsystem so
they can be later used by NVMEM consumers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 1 +
 include/linux/nvmem-consumer.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f58d9bc7aa08..1e3c754efd0d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -467,6 +467,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
+	cell->np = info->np;
 
 	if (cell->nbits)
 		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index c0c0cefc3b92..980f9c9ac0bc 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -25,6 +25,7 @@ struct nvmem_cell_info {
 	unsigned int		bytes;
 	unsigned int		bit_offset;
 	unsigned int		nbits;
+	struct device_node	*np;
 };
 
 /**
-- 
2.21.0

