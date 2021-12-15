Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB42474FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhLOA6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:58:54 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:56971 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhLOA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:58:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDH1m0mLVz4xRB;
        Wed, 15 Dec 2021 11:58:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1639529932;
        bh=rgm18ZlcGbuDcVzIyyKfPtAJUMVGTI5VokdMjxI1FSc=;
        h=From:To:Cc:Subject:Date:From;
        b=BPZgdpsAzt9uNtUMUqMCEX8IM/uxBClXdOyq2QNPWlaxxFA0ORVIHxFK2MnnDBOKz
         IwHj1B0KVKh36iw5pLKIu4vE0mAaUmhf0KdJjkpzqB0sm4OD8guZXrAygrdL1dM56X
         yNhMTJiBLT/gm4o7xrx1B5BRHb1aQP0WGs6MUal1BNGmqTnW5t1s2jrevQUHQ9O+Gz
         zHdAs0yF4keelw2pAnr6RlkFXVxxqDnJeKKcaTyc43kJRMxTrIE67+TkezkQMCV09b
         zw93EiW4clYYpojkf+NHQ+SX+WLqs+OOQghQ2YceoAzo6OBYSNlXwG2PnU5AxMWrpj
         7sjtOlElUOM3A==
From:   Amitay Isaacs <amitay@ozlabs.org>
To:     linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     Amitay Isaacs <amitay@ozlabs.org>
Subject: [PATCH 1/2] fsi: sbefifo: Use specified value of start of response timeout
Date:   Wed, 15 Dec 2021 11:58:32 +1100
Message-Id: <20211215005833.222841-1-amitay@ozlabs.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some of the chip-ops where sbe needs to collect trace information,
sbe can take a long time (>30s) to respond.  Currently these chip-ops
will timeout as the start of response timeout defaults to 10s.

Instead of default value, use specified value.  The require timeout
value will be set using ioctl.

Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
---
 drivers/fsi/fsi-sbefifo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 52328adef643..9188161f440c 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -125,6 +125,7 @@ struct sbefifo {
 	bool			dead;
 	bool			async_ffdc;
 	bool			timed_out;
+	uint32_t		timeout_start_rsp_ms;
 };
 
 struct sbefifo_user {
@@ -549,7 +550,7 @@ static int sbefifo_read_response(struct sbefifo *sbefifo, struct iov_iter *respo
 
 	dev_vdbg(dev, "reading response, buflen = %zd\n", iov_iter_count(response));
 
-	timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_START_RSP);
+	timeout = msecs_to_jiffies(sbefifo->timeout_start_rsp_ms);
 	for (;;) {
 		/* Grab FIFO status (this will handle parity errors) */
 		rc = sbefifo_wait(sbefifo, false, &status, timeout);
@@ -972,6 +973,7 @@ static int sbefifo_probe(struct device *dev)
 	sbefifo->fsi_dev = fsi_dev;
 	dev_set_drvdata(dev, sbefifo);
 	mutex_init(&sbefifo->lock);
+	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
 
 	/*
 	 * Try cleaning up the FIFO. If this fails, we still register the
-- 
2.33.1

