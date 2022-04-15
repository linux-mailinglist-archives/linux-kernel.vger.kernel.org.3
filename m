Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E6D502387
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiDOFM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245379AbiDOFMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:12:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1C95D66E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:08:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso582178pjj.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YqFMa1IXN1PKDC9UT7f6BduKQK2XEUyF5RvZFJz14s=;
        b=mfo01goZwLmw+DZHNVBdBfx9wY1brTJW+71koawfmUZuNOgkmOLQUlJ9OdzId3C6qh
         VfKUrdjtwwG4bE9CSqxHolDAmowpXQmXPJ57U6ms8Jys89xnlp889JCffS8tdVPhe2/J
         nYlBqcfXMh8rATvNi3zbusmzCm5KJtwBMRnB5p1eWpkMAUJaBiXpnEFkmacJchvipZc2
         6JlLpUMN/l+QmLOa3O8MKDJmxzU/AEmXfEX+fOtfWXGuKeNjn3SYkmX7nnL0ugUpIcaw
         Bj+upHNQwdLcmCS7g8tsDGoVs8eew/e+WDyK/dHCTFhoJ/zLUsvwsTmCqjZFLMWBtoQ5
         TF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8YqFMa1IXN1PKDC9UT7f6BduKQK2XEUyF5RvZFJz14s=;
        b=1SPZSEfSuWHzx0IGCVbHmEducO0KRLcikgkeeUCqou+XxGZSCzPmv0OyrsR8zuCNCp
         3ZP2UJdFCPEsP9MecGBC/UVMEOOQTlMrr+hlbVwurDv+JT1rYFzHevjQNfNkgC9u6x1Q
         cYYaH6mso4h2JQBDYy9mkkR2IiyfOmUjYG3h25IGhkaZi4LJ5C2ZC4Uy/8Nm/bFj1CiJ
         uurKD2hcjDBqsbxetUqcsjglVU5CjGBVjk00Zr1ic4QLyzsbAoHP5k/MKP8s7X3Nxp8g
         d39/mt102561ObRbPIiA9+pbQUt/kIB1HKqlG7Qw10wkE2uDx71ee0RXrFgxwQXbuEeZ
         JZSQ==
X-Gm-Message-State: AOAM533Ykm61Q9D7RXk3hp0KDjpf16I7olHz3DpezJ27BDdo5OoCMtU2
        AGE6nCV3oYrGCSG4Kz988yq5wPXo4I4=
X-Google-Smtp-Source: ABdhPJyIjpzyxnLP11xF7oCPJRkEhkUcJOgivp6AH7DFRBpNoHX03IRhgmYPqGpkci3e1CBRxxdG+Q==
X-Received: by 2002:a17:902:ce85:b0:158:66cd:c370 with SMTP id f5-20020a170902ce8500b0015866cdc370mr22614912plg.111.1649999285520;
        Thu, 14 Apr 2022 22:08:05 -0700 (PDT)
Received: from voyager.ozlabs.ibm.com (region97.lnk.telstra.net. [110.143.27.102])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090a3d4500b001c97528521asm3531507pjf.6.2022.04.14.22.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 22:08:04 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fsi: sbefifo: Add detailed debugging information
Date:   Fri, 15 Apr 2022 14:37:57 +0930
Message-Id: <20220415050757.281158-1-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide more output on the timeout status, and make some vdbg calls into
dbg calls so they can be enabled at runtime.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 Fix timeout jiffies traces. The driver was printing jiffies as ms, so
 convert the timeout back to ms for the trace.

 drivers/fsi/fsi-sbefifo.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index f52a912cdf16..5f93a53846aa 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -477,7 +477,8 @@ static int sbefifo_wait(struct sbefifo *sbefifo, bool up,
 	if (!ready) {
 		sysfs_notify(&sbefifo->dev.kobj, NULL, dev_attr_timeout.attr.name);
 		sbefifo->timed_out = true;
-		dev_err(dev, "%s FIFO Timeout ! status=%08x\n", up ? "UP" : "DOWN", sts);
+		dev_err(dev, "%s FIFO Timeout (%u ms)! status=%08x\n",
+			up ? "UP" : "DOWN", jiffies_to_msecs(timeout), sts);
 		return -ETIMEDOUT;
 	}
 	dev_vdbg(dev, "End of wait status: %08x\n", sts);
@@ -497,8 +498,8 @@ static int sbefifo_send_command(struct sbefifo *sbefifo,
 	u32 status;
 	int rc;
 
-	dev_vdbg(dev, "sending command (%zd words, cmd=%04x)\n",
-		 cmd_len, be32_to_cpu(command[1]));
+	dev_dbg(dev, "sending command (%zd words, cmd=%04x)\n",
+		cmd_len, be32_to_cpu(command[1]));
 
 	/* As long as there's something to send */
 	timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_START_CMD);
@@ -551,21 +552,23 @@ static int sbefifo_read_response(struct sbefifo *sbefifo, struct iov_iter *respo
 	size_t len;
 	int rc;
 
-	dev_vdbg(dev, "reading response, buflen = %zd\n", iov_iter_count(response));
+	dev_dbg(dev, "reading response, buflen = %zd\n", iov_iter_count(response));
 
 	timeout = msecs_to_jiffies(sbefifo->timeout_start_rsp_ms);
 	for (;;) {
 		/* Grab FIFO status (this will handle parity errors) */
 		rc = sbefifo_wait(sbefifo, false, &status, timeout);
-		if (rc < 0)
+		if (rc < 0) {
+			dev_dbg(dev, "timeout waiting (%u ms)\n", jiffies_to_msecs(timeout));
 			return rc;
+		}
 		timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_IN_RSP);
 
 		/* Decode status */
 		len = sbefifo_populated(status);
 		eot_set = sbefifo_eot_set(status);
 
-		dev_vdbg(dev, "  chunk size %zd eot_set=0x%x\n", len, eot_set);
+		dev_dbg(dev, "  chunk size %zd eot_set=0x%x\n", len, eot_set);
 
 		/* Go through the chunk */
 		while(len--) {
-- 
2.35.1

