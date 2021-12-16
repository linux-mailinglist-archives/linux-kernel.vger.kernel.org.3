Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B903476A55
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhLPGY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:24:28 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:43997 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhLPGYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:24:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JF2Bt5FRPz4xhm;
        Thu, 16 Dec 2021 17:24:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1639635862;
        bh=IXzQV5i1MD7zSKM4RjVBhbxOGrjVssghN4sw6JSIz3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AE4Sp2BJ02akQWrM+mBAQBMOn/DZ+jH6hiQobBM+9B4Pz0je37RR5gsHGn4n/pfp+
         bXSNRViA+W0sWtqBOkU1ZooWVUwyjTi9uAdxzTtgpXDuATCVi9pSlAOPFh4E46c974
         vZoSj4W6GBfTzDYOZvb8OsD1PolactVIa8xMnmWAeySra033F5Mtr82Wqh02DYLQuD
         hO0nX3PqEcRUMpTmSYft6nzFQdCDwOpQnGhqHV27c0AWxhAOpPpUu7L2x0acrqhO0g
         7o2H7Q40sBAy+y5x8W4RvP+c6okvv4R39g12VMau8zJkJqS7waBa8kj1cu3o894hmA
         V8OqcH4QL6pAQ==
From:   Amitay Isaacs <amitay@ozlabs.org>
To:     linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     Amitay Isaacs <amitay@ozlabs.org>
Subject: [PATCH v2 1/2] fsi: sbefifo: Use specified value of start of response timeout
Date:   Thu, 16 Dec 2021 17:24:04 +1100
Message-Id: <20211216062405.415888-2-amitay@ozlabs.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211216062405.415888-1-amitay@ozlabs.org>
References: <20211216062405.415888-1-amitay@ozlabs.org>
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
index 52328adef643..1e9b326e8f67 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -125,6 +125,7 @@ struct sbefifo {
 	bool			dead;
 	bool			async_ffdc;
 	bool			timed_out;
+	u32			timeout_start_rsp_ms;
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

