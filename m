Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA2E4B329D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 03:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiBLCUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 21:20:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBLCUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 21:20:12 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC211303;
        Fri, 11 Feb 2022 18:20:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y9so9612933pjf.1;
        Fri, 11 Feb 2022 18:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17pyCMYUdJRs5/I+oAtbnvmljOFXa0XqjKCSqRSFssE=;
        b=hIJSwGBwjoV1eeu9VKbrhLXYQVHUKfUJMEUxxRM7j/NivoJdv1LcivbeCfvsutaamV
         rkOwlNdGExHun9L1H76LddAZKpjTyBwnQolusGJzdpjN9erMbHEhfOqlVNUB/nQUjTq9
         +ANO1PrL77t+7ybRtncF5aqrPZlCQ5nsRXoT9OHEqD1VJj+wmndJ37nv3z8uXpczcNX9
         KtTgS4vNSdei4DX49SbQdEXTibSFk/6egZ0YWeLWxCrSYay5IHpvoSxcX1XpTX4CnVA7
         QoptaQAFV9zWyZ+iC6QMrgPj76CNMpXochr3Q/WgVYcEu4QHiD7hX4irno+mTtWyBhEa
         ZGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17pyCMYUdJRs5/I+oAtbnvmljOFXa0XqjKCSqRSFssE=;
        b=1f8uVKWSfFKhuu47XwccN+3iGRMnCBF86bpdII5ebUiveRNKqhhqbONhVyeJ7WyAED
         iOXZi9+y/2S4wNIfXohM6GJc2r0iBZRvPoQwJR2cHuPmd0kzeB0RRToN8ul6pUbYiQyy
         K8c+MzDBb0fqGWNvFgvzo5HJgD3jsqfaeVdIlBiVA7k4vmBX7GpKx/rAC/aNcH+5Z6JY
         vfdFV/UQWhu6/j4AQPlPt1IK1u873gO8EsDxiqzVhkgtBqawtwoGD15MChT00k6aSbj+
         MFym4unbJRtvFgU/2iF10aBpVB1NqrFGApAuK4LiACd7mudccHf2+Ab4AbycKdygLrMb
         A+4g==
X-Gm-Message-State: AOAM5312SqazKK1aheInfBcibzrFe8cOSqaih9f66LDg7XfQ7yrl1j7d
        2/8u+TMwcpEDybUbY3r9xeA=
X-Google-Smtp-Source: ABdhPJw1CgpJG8g9VxdycjemQbXKY+xXFw3BFj2mihwtdK2c44cuKTYH/q9r0w+1w9kHJvQFEuTQEQ==
X-Received: by 2002:a17:90a:e549:: with SMTP id ei9mr3280517pjb.190.1644632408124;
        Fri, 11 Feb 2022 18:20:08 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id a17sm6429806pju.15.2022.02.11.18.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 18:20:07 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     davidcomponentone@gmail.com, jirislaby@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, zev@bewilderbeest.net, johan@kernel.org,
        yang.guang5@zte.com.cn, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v3] serial: 8250_aspeed_vuart: replace snprintf with sysfs_emit
Date:   Sat, 12 Feb 2022 10:19:48 +0800
Message-Id: <fed40753603dac4d14b17970c88e6f5f936348c1.1644541843.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/tty/serial/8250/8250_aspeed_vuart.c:85:8-16:
WARNING: use scnprintf or sprintf
./drivers/tty/serial/8250/8250_aspeed_vuart.c:174:8-16:
WARNING: use scnprintf or sprintf
./drivers/tty/serial/8250/8250_aspeed_vuart.c:127:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>

---
Change from v1-v2:
- Modify the patch title
- Use the CC for patch sender

Change from v2-v3:
- Fix the patch subject prefix typo ("8250")
- Change back the SoB for patch submitter

---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 2350fb3bb5e4..36c39b8ea7af 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -82,7 +82,7 @@ static ssize_t lpc_address_show(struct device *dev,
 	addr = (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRH) << 8) |
 		(aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRL));
 
-	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
+	return sysfs_emit(buf, "0x%x\n", addr);
 }
 
 static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32 addr)
@@ -124,7 +124,7 @@ static ssize_t sirq_show(struct device *dev,
 	reg &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 	reg >>= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg);
+	return sysfs_emit(buf, "%u\n", reg);
 }
 
 static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
@@ -171,7 +171,7 @@ static ssize_t sirq_polarity_show(struct device *dev,
 	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 	reg &= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", reg ? 1 : 0);
 }
 
 static void aspeed_vuart_set_sirq_polarity(struct aspeed_vuart *vuart,
-- 
2.30.2

