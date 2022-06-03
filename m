Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895D553CA1A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbiFCMjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiFCMjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:39:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB952381BE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:39:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so7097735pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZeh6dPlumSxGZHW+VabBQeUNOylTh9kH627gkvPD+A=;
        b=Y007TVDTsVw2lMEBXkR/FDRNRV6iyelZ51Ogy3OHkyUxu5lyWsKT5NvAJWTmGx+5ku
         7SPyy8Q9FvgqXHsRr3cqUCSu8P0sEmUphieQGMnAL4rwzKq1/T4o8SShk7nGIIuVIJ7s
         sAJk9SBu059Jsf3aZBF3WgzYewGjI/izch7jta9PIaaDYRVT6UjFIg59Z+5UdKL1n4Z3
         o1RAhsDEs+moKuck8+3NPVgX1ag1oBcCxuxJU62Q+r8JbVAjV/qtCkNu2gSTr33n+QDj
         5y8ZvVS/3Msue9oUKSevHa0iFV31Zdkhk/sAaYrGGFtJL/RWndHjEkXEn0sSba712JPq
         t08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZeh6dPlumSxGZHW+VabBQeUNOylTh9kH627gkvPD+A=;
        b=uBpPkHLDfpdnymDckfSMTWi8wU1aorRSV4/+PH9TJitottjOwywe3XXSgIMBVbWu10
         +t6YHMJD2VKfbxESZGJbDVaSesudNg2s/KfeA2AH/CI7mqr4cJRztJb8NBgbyNGK8ZyU
         a5Oi/RR75JURLpnvSoEGuzg9WKeGhX4nH4OYUlUUsJNG7JFs3ctgab5fvqLFlMcjaOkS
         PbdD2+wJxN0ExjJYaJi7ChO/01s8gjnlSTz+ePA9zwbtdEf6KWR8TCmSOSxLmdJfyFGS
         jKdBmtNtKkIRnCsMA3iFljCbFVlfDFubSR7ubpRck4OGjWtdsAg+gKeXAcRSQT2StTJb
         kFSA==
X-Gm-Message-State: AOAM532sIWzDp249mJg3CUPv59x2cdDSbGx8AaztoimRNhFiuNP4muR+
        qzDDi1S9S8HcVad4uHfB6xc=
X-Google-Smtp-Source: ABdhPJxTwFTdmtpYkEYSdKalAhQdMMJ2P6PK6DiB3tuvARtFEmIIk6ddSDvYnFSLZ94zcHu1HAEyVQ==
X-Received: by 2002:a17:902:d592:b0:161:3bf4:9047 with SMTP id k18-20020a170902d59200b001613bf49047mr3355736plh.137.1654259954469;
        Fri, 03 Jun 2022 05:39:14 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id ju10-20020a17090b20ca00b001df264610c4sm5483212pjb.0.2022.06.03.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:39:13 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Patrick Venture <venture@google.com>,
        Robert Lippert <roblip@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: aspeed: Fix IRQ check in aspeed_lpc_snoop_config_irq
Date:   Fri,  3 Jun 2022 16:39:02 +0400
Message-Id: <20220603123904.30714-1-linmq006@gmail.com>
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

platform_get_irq() returns negative error number instead 0 on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
v1 Link: https://lore.kernel.org/r/20220114064357.18562-1-linmq006@gmail.com
In previous v1 thread:
Reviewed-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Signed-off-by: Patrick Venture <venture@google.com>

v2 Link: https://lore.kernel.org/r/20220603082336.3867-1-linmq006@gmail.com
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8dfbeb..c4a03b3a5cf8 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -167,8 +167,8 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	int rc;
 
 	lpc_snoop->irq = platform_get_irq(pdev, 0);
-	if (!lpc_snoop->irq)
-		return -ENODEV;
+	if (lpc_snoop->irq < 0)
+		return lpc_snoop->irq;
 
 	rc = devm_request_irq(dev, lpc_snoop->irq,
 			      aspeed_lpc_snoop_irq, IRQF_SHARED,
-- 
2.25.1

