Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9246153C6E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiFCIXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiFCIXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:23:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11F5192A3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:23:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cx11so6892479pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 01:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJ5nOCm8LzcOFMf8dnh/CUtYdPr3TKZePHvPE4Ct0MA=;
        b=TQjaqSnDFwGyupFW9eoFjOll0k72uxMIxfGVm2AnhrSZWe7ATloGVFkY/cUNwu9zbB
         w+C3i3HZQj0Ef5OMvLZujyOCLFcT0WtZwF9GuDLv/4/b87zEiPUgEC4MjNGBRQcjqXBM
         qzTZf31kKRrt34/KjGtbwFh9iwp5i/fRcVMiZGqUMfTamVNZh0yslWC8OFrQYDtWeXv8
         +Zq2w5wMmnXNq4/K5qG05hBPfKzIxjlP4YMIj2P2weEsabq7s2hzW8KbQ9pySx94I+kQ
         MB7Jtlm0Os8as7/uuRCsrTgI8/13atDyU2wJJmTMx0FU/EL7RZ1vbtcLjUcIdegBY44K
         /N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJ5nOCm8LzcOFMf8dnh/CUtYdPr3TKZePHvPE4Ct0MA=;
        b=zofiWSSBw1K541VCK++aemvksmIKM29/pHSVHtCoBQkuBMSvI6XxHm0LZFK9N+DVSW
         J2Fsw76oxvzue/t4eqJLqIiLmzXnXzghr7FTjHY/xP4zhpMjcvi90O68jNV43WX0ZHTa
         aY4yjOb6m/ox+FlrxuNlIvsuHDYAcJ9rwQ3v5gBUrKEQSjG7gqab9yNdxhfuXLKN1Ha/
         0TVlN+PkBnWGANyryFtwkISWmHNcQBaFyyln2m3WxlxRCyifX7vpIrr0TtqEs87QkpXR
         +c3WakSQSzBv3Kmkeyj+2ALeJtQ2kQiclu6UXAIzHCQwjCCtr9t3Ti56lFA/r+BcUVGd
         U+fQ==
X-Gm-Message-State: AOAM53051hF9hkMjxL8MrxMiqVUWaIRH+XyNQl9xseWUESNPDPqDdGqV
        gfu9eYcBI0wMQxgXKyTqoFO6CNJVgsR9ctWmgYs=
X-Google-Smtp-Source: ABdhPJwG680KUxCoYDSbUUqPJzsbyeO7F8Mz29YiJl6SmAvepgPoKkwAgxs7y83lsE1ERiQwCAv7jQ==
X-Received: by 2002:a17:902:8d87:b0:162:da7:e3d6 with SMTP id v7-20020a1709028d8700b001620da7e3d6mr9212233plo.44.1654244626465;
        Fri, 03 Jun 2022 01:23:46 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id ju10-20020a17090b20ca00b001df264610c4sm4818881pjb.0.2022.06.03.01.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 01:23:45 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Patrick Venture <venture@google.com>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] soc: aspeed: Fix IRQ check in aspeed_lpc_snoop_config_irq
Date:   Fri,  3 Jun 2022 12:23:34 +0400
Message-Id: <20220603082336.3867-1-linmq006@gmail.com>
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

Fixes: 524feb799408 ("soc: add aspeed folder and misc drivers")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Link: https://lore.kernel.org/r/20220114064357.18562-1-linmq006@gmail.com
In previous thread:
Reviewed-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Signed-off-by: Patrick Venture <venture@google.com>
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

