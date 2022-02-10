Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED094B0AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiBJKf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:35:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbiBJKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:35:12 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7BFF1;
        Thu, 10 Feb 2022 02:35:12 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id n23so9501155pfo.1;
        Thu, 10 Feb 2022 02:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OyHKEWDVKlKy9kwRRGPyuapqQZ9EQT0MCaFn+0fLSY4=;
        b=KamH/nE7RyCGAJiELKI8ttpxAJ9wkggTJ5s0F/Y9wop+T3gwUgiqgAhfmpOoLrzghl
         HHMFronttCK7irfax/sVkRSs4TvRVaDclnH/+hJtc9lRpJ7WR4KpJRRkTnR7bGqm8IpH
         1rJeZr4InqU66DRe5dK8jEg8oysCN5u0uEPLLRuHg5gqHLfQVgeap/XnOOEimXVQm8qj
         JrmcdPeh97sq3w/tXGzK4VLZ8VfQWF1UtGTEVSwxX+vCCDOzINd6nBfbKy2DulL+C1xB
         z2fO8zUunZ+wqe404S7xjpHFgrI3UUlzG9iHpKis5Gs/fOXWg7aDFVJeP9fC/DtW+vL8
         wV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OyHKEWDVKlKy9kwRRGPyuapqQZ9EQT0MCaFn+0fLSY4=;
        b=67/h6wlJBlu8ktifa8MMrUgfFUtkp4uhJb0VZGRKaAsYMZaSN2CGAaRAWm0NgfMxKb
         KI1c60Z7mjO1nnor7Mwg5+ACLZEn8QDvR7CKgK5LXx0Ejrd/DRmrk9yYs8FDQ5tdEgrU
         YNxSSjoo0GLWiWQXnRXIaYR2B5FwoiM6JmLqDRD3lyoUwJGUlDWknrWTw3Mz8hRnXxIV
         PEku2tnkQ21zY6RJB+SUfE/e+GL366/qzKd2CbramTcVj2iNV6q+XfseYIxaWe7vR18D
         t7wP6kQxaPMMoIrq0P5P1YCyLda1O8yfPCXEKzzJWsX6iimgOlH3R3SaAm0FFcWC/UwS
         wHng==
X-Gm-Message-State: AOAM532mi7imh7Qvt18Z56EVtLWJKye5l4ABngl+aKX7sJkmb+K/3Y+Q
        deYehv7FY6ptVD6eVLLexfY=
X-Google-Smtp-Source: ABdhPJyHB7MuV96LGULlUp4tGXnFXjvLg7pzcsrt/mwATW5OK7J1WrWnm4frTCS4r2tuWK+a4RMWEA==
X-Received: by 2002:a63:4e:: with SMTP id 75mr5682216pga.461.1644489312338;
        Thu, 10 Feb 2022 02:35:12 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id y20sm23063496pfi.78.2022.02.10.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:35:12 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     davidcomponentone@gmail.com, jirislaby@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, zev@bewilderbeest.net, johan@kernel.org,
        yang.guang5@zte.com.cn, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] serial: 8259_aspeed_vuart: replace snprintf with sysfs_emit
Date:   Thu, 10 Feb 2022 18:34:45 +0800
Message-Id: <a0f3e5d6d438710413d1909365f99ae4d2a4bacc.1644399683.git.yang.guang5@zte.com.cn>
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
CC: David Yang <davidcomponentone@gmail.com>

---
Change from v1-v2:
- Modify the patch title
- Use the CC for patch sender

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

