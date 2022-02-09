Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D964AE6A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiBICjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiBIAsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:48:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C30CC061576;
        Tue,  8 Feb 2022 16:48:54 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso2656262pjg.0;
        Tue, 08 Feb 2022 16:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI+hs3F4c1QaxzVBV/sm+QTUejv8UzZhOXTGUR0B9uI=;
        b=YKjkFETzIsoNqqkAmCjyV0mNIUkQkRSnB2T7NJbtwbxXJrArMifhGPLxUyR08q5bHv
         6t6xNyXKagTaEW+KSMpYR3r4SbqfopBqIabBi+Bh1fJayxMOKtbhngW1ctk39HR50gH4
         MYsyS5IcJWmB30Pl/WeDdxFuIZdY7mfU3kxJWH5aq333hrqbWiWRic52tY8NagHRDlj2
         gK/rkVOkK9+A9qgg+Q1MvkC6YBVpwnQyMFdaE/bDvYcC7flw6GKEjQEqAkDcLRC8IpG5
         KVqeIch3RcnvS/X3Yba319rF8IfT/0KfRROc11/Le/eccSmeIN+5fjh4gl4m1UDO+zhs
         xABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI+hs3F4c1QaxzVBV/sm+QTUejv8UzZhOXTGUR0B9uI=;
        b=beTLwwXdqN1KM4DdFHTPVOEfun3sn+gajmcjDQbUQA8sji5Cxs8ohTdcOYQBMjoyEz
         T6xVmsMf+zShPFlXM892LxrTsQuKTDJTtPGzaHZv3kbpRWtbvGir+4phLlZ9jhlfzoAW
         xsFE2ds/8d8878NUDK9ppOOSUI5kB9+aORt+5WCWvxK6XMq3zeibZfucHgQFhkel31ff
         F16iBSMjoSupqtPjakMpy0nAMJ3a12xA0LVDCUxCZZ/hTMBiYfLYqux2cg2q9iaKZx4z
         h4jhixLW1WJSldv4wCdI1ecUy7JMgn1zzBcrPMvZBiK/VpyfJKDdclcaRJp9gWyB35ld
         vnDQ==
X-Gm-Message-State: AOAM532XepYJCbYNdRUhM7xwHDunady5lDfW1ixonLVOe6fTLSEuVzl3
        +mq/er8vaCAIA3xSQ4zHLuM=
X-Google-Smtp-Source: ABdhPJxKenclyaWuFcTHESCPUiTtBJ90EFW/FDClHKa7xQUCowiN2FiI9OlBQjPUKIjxdeTncsF5Ow==
X-Received: by 2002:a17:90a:b947:: with SMTP id f7mr659505pjw.184.1644367733798;
        Tue, 08 Feb 2022 16:48:53 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id t2sm17020154pfj.211.2022.02.08.16.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:48:53 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     davidcomponentone@gmail.com, jirislaby@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, zev@bewilderbeest.net, johan@kernel.org,
        yang.guang5@zte.com.cn, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] serial: 8259: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:48:40 +0800
Message-Id: <96f0e23f49d708ce2476a6c19867443a48d78f65.1644283006.git.yang.guang5@zte.com.cn>
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

