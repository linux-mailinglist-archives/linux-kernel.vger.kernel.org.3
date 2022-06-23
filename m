Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99F8558A80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiFWVNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiFWVNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BB8506E0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n1so477390wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oky3YgKKfNXCQVslFZi4xoyuek1RvMVadIY0VBZTguA=;
        b=Gi4aZN2sLBYp2ljUDPgzuGmqSQQkoBx224Y9NdkkPudfprFuvJKpVNzxTerjz+W79c
         uJemVZrRHa337z29pIJwA4xKfXYxK/FLUqZgHJDI8UJbCs8rTNxdrYm8kG5EPlDUjqSa
         43uaEfEpNdjOi0mZBsh8k2Rh6jNuIburDRnqUiLSV/PzvSeIzYQHbMFFQV5n80bGfP1I
         ErLxO1Z4qXB5v6Pb91rXN5PavcL6BZT14uO0WgOTcxfgoE05tfD3TaeDcGNsNw16gm5g
         /Svj0Js2kguzTPIXpp/nuLnvSqZ7CJmSwBdKQyjEj46vSmwSZIpA96aJvuWvabOIML5W
         XnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oky3YgKKfNXCQVslFZi4xoyuek1RvMVadIY0VBZTguA=;
        b=VEr61VA5g41B+/muu6oQRsC8PcihU4if6NpQr4r8B4g1neHdWN2VAFNFUWut0LKiqT
         aFlHY8W8unxqQQ43A5wFmnI2JmFbGSXaYiqbJny2PTJNs+kyOokFIqfx7IOgp10O+Fxw
         aGR6YWOSk0CsGC2pZICxjrl9BTFUFqDBKe2d4AkUTlHz82fybHrkx4aaWLUBX7LCAQ19
         Qdt4HjemMaARNs8xMnQqHn7/acJUubUGZ2ilWxg1qpt0q6O8eu6hnnMH/SB8ZB/4jDWb
         KBF01gsyJmTR0fLJcxVI0n0lrPWEWyhKID68BEwSFtePDvrtWz3fErIe5UpbVmIwp413
         irGw==
X-Gm-Message-State: AJIora/o6Bub77cj55IY9wwbBTXVMYPNPI+nztz7BkVAPzn0hv9KRJ8z
        JrDTWQhKWits0Elalbs7JRMh8xBkj2I=
X-Google-Smtp-Source: AGRyM1u74I3yclz1slGC+ZAtAzuCAsg8Kp437l9Kw7u2Pwp5GeLMxdxqWb94DNFdZ+yBfuNRbG5x9Q==
X-Received: by 2002:a05:6000:192:b0:21a:3c91:df05 with SMTP id p18-20020a056000019200b0021a3c91df05mr10206433wrx.655.1656018807701;
        Thu, 23 Jun 2022 14:13:27 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b0021badf3cb26sm498689wrr.63.2022.06.23.14.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:27 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned int
Date:   Thu, 23 Jun 2022 22:14:09 +0100
Message-Id: <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
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

Use 'unsigned int' for bitfields for consistency with most other
kernel code.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c |  2 +-
 include/linux/regmap.h           | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a6db605707b0..a58b29e9c7c7 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -43,7 +43,7 @@ struct regmap_irq_chip_data {
 	unsigned int irq_reg_stride;
 	unsigned int type_reg_stride;
 
-	bool clear_status:1;
+	unsigned int clear_status:1;
 };
 
 static int sub_irq_reg(struct regmap_irq_chip_data *data,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8952fa3d0d59..7c5e4a20e9cf 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1518,19 +1518,19 @@ struct regmap_irq_chip {
 	unsigned int type_base;
 	unsigned int *virt_reg_base;
 	unsigned int irq_reg_stride;
-	bool mask_writeonly:1;
-	bool init_ack_masked:1;
-	bool mask_invert:1;
-	bool use_ack:1;
-	bool ack_invert:1;
-	bool clear_ack:1;
-	bool wake_invert:1;
-	bool runtime_pm:1;
-	bool type_invert:1;
-	bool type_in_mask:1;
-	bool clear_on_unmask:1;
-	bool not_fixed_stride:1;
-	bool status_invert:1;
+	unsigned int mask_writeonly:1;
+	unsigned int init_ack_masked:1;
+	unsigned int mask_invert:1;
+	unsigned int use_ack:1;
+	unsigned int ack_invert:1;
+	unsigned int clear_ack:1;
+	unsigned int wake_invert:1;
+	unsigned int runtime_pm:1;
+	unsigned int type_invert:1;
+	unsigned int type_in_mask:1;
+	unsigned int clear_on_unmask:1;
+	unsigned int not_fixed_stride:1;
+	unsigned int status_invert:1;
 
 	int num_regs;
 
-- 
2.35.1

