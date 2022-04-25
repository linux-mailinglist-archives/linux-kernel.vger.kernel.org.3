Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7299950DE28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiDYKvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiDYKvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:51:49 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 03:48:43 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE3063CC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:48:40 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20220425104733c4677b3423d2a9cbb7
        for <linux-kernel@vger.kernel.org>;
        Mon, 25 Apr 2022 12:47:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ibveypy2TT2i4YuSJ92muBFUBKsW8Al9oyDzThK4kpU=;
 b=GGDFW8jUESh9CAa2Qw8xzLTbXEizho7aK/UrtUKNjeFNF7EAUDMsWThmC5UvVBz5wrD287
 hg0Hxt4dF6mTBffFhnoZc1NFP/bUDtzKYNMciuhn7pRHLcJ/ymWDWckgUmdHOp8n9CJV1GMl
 dWoqMP0OFeJrZByN2WdphYPd6CnoI=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] tty: n_gsm: fix sometimes uninitialized warning in gsm_dlci_modem_output()
Date:   Mon, 25 Apr 2022 03:47:26 -0700
Message-Id: <20220425104726.7986-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

'size' may be used uninitialized in gsm_dlci_modem_output() if called with
an adaption that is neither 1 nor 2. The function is currently only called
by gsm_modem_upd_via_data() and only for adaption 2.
Properly handle every invalid case by returning -EINVAL to silence the
compiler warning and avoid future regressions.

Fixes: c19ffe00fed6 ("tty: n_gsm: fix invalid use of MSC in advanced option")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8652308c187f..a38b922bcbc1 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -932,18 +932,21 @@ static int gsm_dlci_modem_output(struct gsm_mux *gsm, struct gsm_dlci *dlci,
 {
 	u8 *dp = NULL;
 	struct gsm_msg *msg;
-	int size;
+	int size = 0;
 
 	/* for modem bits without break data */
-	if (dlci->adaption == 1) {
-		size = 0;
-	} else if (dlci->adaption == 2) {
-		size = 1;
+	switch (dlci->adaption) {
+	case 1: /* Unstructured */
+		break;
+	case 2: /* Unstructured with modem bits. */
+		size++;
 		if (brk > 0)
 			size++;
-	} else {
+		break;
+	default:
 		pr_err("%s: unsupported adaption %d\n", __func__,
 		       dlci->adaption);
+		return -EINVAL;
 	}
 
 	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
-- 
2.25.1

