Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4614C65BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiB1Jer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiB1Jep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:34:45 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918593FBFE;
        Mon, 28 Feb 2022 01:34:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b11so20238710lfb.12;
        Mon, 28 Feb 2022 01:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fyLAwYBTvyuqO87oNdeuHQ7QKOeWMlrnczfuq8lDfy0=;
        b=MAlC1PXvtBS4kESMFqvatJNemhkHIuJ8yqRgVhJGf32Vign6qvkBQuS3Kt5YPi4CwD
         Y67GrQ7yIdxljqpHi8DzBVgQf0TFQP3Pt8BVKv9d2rCEhK5m7lCvz8GhZbDuNz174bqO
         lYwBwdEioZYMRF9Ob6o4oBZifqogVhCu2WwtonGxFvdGCyH01FdXhz3vU3O9Lk2x7Iqz
         XIakM6YZK3ibXdACUqOi6J2Ajlqv7n9WvtZRgmtRGAtaOKEL3Fj8vKLOqbaWAqlB1oRJ
         cQNb5cGsoYsqQVNF9lUeq7ZX8jb8EXXO462z31eC9ZcrYbGCPURE17/w4Ss2fvtW5oHk
         L4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fyLAwYBTvyuqO87oNdeuHQ7QKOeWMlrnczfuq8lDfy0=;
        b=pbP/aQZqEbY/jFr3TqRMjI8LddyKCi07s+V4y68wPxu9y+jpqnQcnuVsyDy8Iybnl/
         JyI2SZLv7AVWU7/2nrVR9RU3pv2mIPsUPTtUEjtO9Ddbr39JJl9DxFhKIEEmUlybQ78J
         vyfnnMFpUFUYs8ylZ6r4Wxsbz3lbBEjDAeWQZ+xyrNysdOWZ9/mk28+dzbmzAZ+1r3Bi
         Z4PIspwWkYPlp+VpGtrz9+MdfTH05MlylCMAqKC2BZ0fpf9nF5U1vZ63vccJRbcBgQPD
         R75sMHUwC8q50hFvi0g3ezAYxp1BoMYiCNVoLoN9QTi544XvAW7/eT2SVSTlCx+j4BZI
         nJ/g==
X-Gm-Message-State: AOAM531aP+ZmGqxV7KHte1Tp2q/2QPVSiNzTvn+3RIj8ZejjuqRMdMfz
        3mB839hWEmdpQmKbzW+zrDw=
X-Google-Smtp-Source: ABdhPJxB4BVjo7DczKxRbvgCnl/C/wzdu7aovyg1ZYnL7+qqSH8ER4BnqbnPUYMofKizf2NvG1B4Sw==
X-Received: by 2002:ac2:5dfb:0:b0:443:7baa:aee6 with SMTP id z27-20020ac25dfb000000b004437baaaee6mr12229114lfq.324.1646040844785;
        Mon, 28 Feb 2022 01:34:04 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id k7-20020a0565123d8700b00443cec880e5sm876184lfv.4.2022.02.28.01.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:34:04 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] nvmem: core: support passing DT node in cell info
Date:   Mon, 28 Feb 2022 10:33:50 +0100
Message-Id: <20220228093351.28162-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Some hardware may have NVMEM cells described in Device Tree using
individual nodes. Let drivers pass such nodes to the NVMEM subsystem so
they can be later used by NVMEM consumers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c           | 1 +
 include/linux/nvmem-consumer.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6d5702e715d6..5fcf2793b599 100644
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
2.34.1

