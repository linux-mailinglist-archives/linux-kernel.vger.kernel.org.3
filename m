Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B9E4AAE32
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 07:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiBFFzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 00:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBFFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 00:55:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C68BC06173B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 21:55:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a8so8828483pfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 21:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QllGcs8jzslhBf9s27Nd7fCzfzy4T3imE/YP1j3Ms3c=;
        b=l6+4DZO0eT+NO+dc2mLF5dsgbs9+drsyJuMcPj3hNHjIyyhgmfWhsgIhnPVEqTl5ww
         7FzxZ/fU5knE1fPFx4tIU/J4vN6P/zg+2FlLqnzbfaQtgYbVCa80fa5eoJDg1FXjZgWl
         E6vEYJjrEHyVeZT0He2n+JdsXJWNn5ZiOgWJ5EI87v6Ws7+8itqaInyWZChB1UyZNrGw
         VVASpSMs23kvPx0gnd+LJJiGXPYuLxow4ztB4FHAtb2F0HIzaKCUOCKmUtrWgwfvmLN8
         pgoAyL1hbOEqz8yniKBpweAIYxoYEMfQdI6I12tyEzpKhSJCN49BMspFGUKUyrONhYko
         MRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QllGcs8jzslhBf9s27Nd7fCzfzy4T3imE/YP1j3Ms3c=;
        b=VEQIxTCSxmyJEb99W7iOhNrXak0YeNnvBEy7G4tD0H7Jkjlrc06MU2T92eoRoBteP+
         WseHv5rujgpkfqL1lepsujJnKFyxCjQwj3OfgmMiZ8nvntmck3OO4nTGPQ131pdNZb3Z
         FEqIrmIuoWooGK1ZXDLPVoGFCNCPu4ZzwnGPpKQ5F+fI/Lf56ynPrZRmCJgeaCre9rX2
         yg0dv+P1W+bVKqTCZxfss2EPeBsGQkIpBq//Ou9RW+6UT21SwpM5/bjqavnvoU8pvr5s
         XT2p52WPnebFjoIPoE9WKtLRjAQYCA+tP2mEafw8Xn1/TpmdbW8OZZxA8SEv26xRXeGJ
         clFw==
X-Gm-Message-State: AOAM533DehNpufoRL/MUGjLDd0NMfRAkpJwXHD6/rnUwzOXcvMlc/U2G
        EESP6Et8BnaZGryWqVMNqKE=
X-Google-Smtp-Source: ABdhPJxmThNqiX6NqrU4WsRYYdLRfnbKATWJt3yOAjweie1fwvFZ++Dq7mGovWp/DrwF6mynq4CL/Q==
X-Received: by 2002:a05:6a00:194d:: with SMTP id s13mr10230054pfk.22.1644126915744;
        Sat, 05 Feb 2022 21:55:15 -0800 (PST)
Received: from mail.google.com ([124.157.67.163])
        by smtp.gmail.com with ESMTPSA id o1sm8311886pfu.88.2022.02.05.21.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 21:55:15 -0800 (PST)
Date:   Sun, 6 Feb 2022 18:55:09 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: remove register debug dev_dbg stmts using
 DEBUG_VALUES
Message-ID: <Yf9ivRB5qpmA5rY2@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which the recent addition of the debugfs dentry (regs), users can now
obtain rf69 register values without having to tweak constants
(DEBUG_VALUES) and recompile the pi433 module source code in order to
see those values.

This patch removes code blocks made obsolete by debugfs regs file.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69.c | 37 ++----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 2ab3bf46e37d..bf26aef69daa 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -8,8 +8,6 @@
 
 /* enable prosa debug info */
 #undef DEBUG
-/* enable print of values on reg access */
-#undef DEBUG_VALUES
 /* enable print of values on fifo access */
 #undef DEBUG_FIFO_ACCESS
 
@@ -26,48 +24,17 @@
 
 u8 rf69_read_reg(struct spi_device *spi, u8 addr)
 {
-	int retval;
-
-	retval = spi_w8r8(spi, addr);
-
-#ifdef DEBUG_VALUES
-	if (retval < 0)
-		/*
-		 * should never happen, since we already checked,
-		 * that module is connected. Therefore no error
-		 * handling, just an optional error message...
-		 */
-		dev_dbg(&spi->dev, "read 0x%x FAILED\n", addr);
-	else
-		dev_dbg(&spi->dev, "read 0x%x from reg 0x%x\n", retval, addr);
-#endif
-
-	return retval;
+	return spi_w8r8(spi, addr);
 }
 
 static int rf69_write_reg(struct spi_device *spi, u8 addr, u8 value)
 {
-	int retval;
 	char buffer[2];
 
 	buffer[0] = addr | WRITE_BIT;
 	buffer[1] = value;
 
-	retval = spi_write(spi, &buffer, 2);
-
-#ifdef DEBUG_VALUES
-	if (retval < 0)
-		/*
-		 * should never happen, since we already checked,
-		 * that module is connected. Therefore no error
-		 * handling, just an optional error message...
-		 */
-		dev_dbg(&spi->dev, "write 0x%x to 0x%x FAILED\n", value, addr);
-	else
-		dev_dbg(&spi->dev, "wrote 0x%x to reg 0x%x\n", value, addr);
-#endif
-
-	return retval;
+	return spi_write(spi, &buffer, ARRAY_SIZE(buffer));
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.34.1

