Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96D4B7733
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243674AbiBOTbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:31:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbiBOTbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C80C4AEF38
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644953461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qHGc3lWJg2pqSw0iyqKF1wYg1gMLVmr0OdHv1eJKGAo=;
        b=RhQkU5MSUAA1pQkOudl5hnq6OHkYS1Bklf3TnvSF+fkPdrSr2jeTZTTlMRmuXua7qrEFdz
        2trC3ZQ7vI8RC3sY4d+mO//jR3K1viyd/CFqIeSvks+e9MaAwdypIOHeDgjSoCLjR7fJy3
        yeungXGrIZfojIWw/SRUittgExNhZA8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-tSLjiC-GPfiQd76mJ5alag-1; Tue, 15 Feb 2022 14:30:59 -0500
X-MC-Unique: tSLjiC-GPfiQd76mJ5alag-1
Received: by mail-oi1-f199.google.com with SMTP id f3-20020aca3803000000b002cf47784c5bso65553oia.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qHGc3lWJg2pqSw0iyqKF1wYg1gMLVmr0OdHv1eJKGAo=;
        b=aj/th8xm9Kc0VhFfs4fB9Rm91xEs6ViLJxX4b88R8URWudZaCdJaA1M6m6aZbzPZsX
         W40HzteOSt+1lMpAbDCsHy5glDjpjcYtQPIpY+EtW991VmAIfDe++arP3ZQThmUIBSgi
         2jbdBgbnLEYuWQcbrhVSN9TkOCQPQnyXxE5ZMmwjn+HyO4Nh8Tk6wVtF+a+TWpNn4rwH
         CQCy+kgrnRwy2cOFOi8jA1SPc8HfTzJ90f9E8cOgKUGedq/ZmDVMxYg+MsF88XD3nl3f
         ToR37NCmi4NqqDUQ6OZbCmrCqFvW0wlFWEn+I8bGS2G2JlsrWEsaqanCa1G3mLFA2jDh
         iYoQ==
X-Gm-Message-State: AOAM531/vm70+a3jGwNNYgEQ9f6PpfblcdL+igbiNDcqk4gMLAn3A1R1
        EtYz1t011iax/jScMUXRycTTJnlljvvQjWGojZCnXSRKHwvPHQmMQ0u3/FrXIcROfmx9GS6nWX1
        mELG9objRyIDWfLJGkdJKJLJK
X-Received: by 2002:a9d:758e:: with SMTP id s14mr147335otk.32.1644953458928;
        Tue, 15 Feb 2022 11:30:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6/ssg3bB2LJ6vYV00tJ2Gl8yteMQjJzsxm6tUe7YxWgH9/pNjs8axhwokSjOUYEXKz4yv+w==
X-Received: by 2002:a9d:758e:: with SMTP id s14mr147327otk.32.1644953458667;
        Tue, 15 Feb 2022 11:30:58 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id f8sm6095715oou.19.2022.02.15.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 11:30:58 -0800 (PST)
From:   trix@redhat.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org, michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] xilinx_hwicap: cleanup comments
Date:   Tue, 15 Feb 2022 11:30:54 -0800
Message-Id: <20220215193054.3032955-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'the'.
Replacements:
was to what
intiate to initiate

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/char/xilinx_hwicap/fifo_icap.c     | 2 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/fifo_icap.c b/drivers/char/xilinx_hwicap/fifo_icap.c
index 02225eb19cf6..619f3a30ec55 100644
--- a/drivers/char/xilinx_hwicap/fifo_icap.c
+++ b/drivers/char/xilinx_hwicap/fifo_icap.c
@@ -111,7 +111,7 @@ static inline u32 fifo_icap_fifo_read(struct hwicap_drvdata *drvdata)
 }
 
 /**
- * fifo_icap_set_read_size - Set the the size register.
+ * fifo_icap_set_read_size - Set the size register.
  * @drvdata: a pointer to the drvdata.
  * @data: the size of the following read transaction, in words.
  **/
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 067396bedf22..74a4928aea1d 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -241,7 +241,7 @@ static int hwicap_command_desync(struct hwicap_drvdata *drvdata)
 	buffer[index++] = XHI_NOOP_PACKET;
 
 	/*
-	 * Write the data to the FIFO and intiate the transfer of data present
+	 * Write the data to the FIFO and initiate the transfer of data present
 	 * in the FIFO to the ICAP device.
 	 */
 	return drvdata->config->set_configuration(drvdata,
@@ -297,7 +297,7 @@ static int hwicap_get_configuration_register(struct hwicap_drvdata *drvdata,
 	buffer[index++] = XHI_NOOP_PACKET;
 
 	/*
-	 * Write the data to the FIFO and intiate the transfer of data present
+	 * Write the data to the FIFO and initiate the transfer of data present
 	 * in the FIFO to the ICAP device.
 	 */
 	status = drvdata->config->set_configuration(drvdata,
@@ -384,7 +384,7 @@ hwicap_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		       drvdata->read_buffer + bytes_to_read,
 		       4 - bytes_to_read);
 	} else {
-		/* Get new data from the ICAP, and return was was requested. */
+		/* Get new data from the ICAP, and return what was requested. */
 		kbuf = (u32 *) get_zeroed_page(GFP_KERNEL);
 		if (!kbuf) {
 			status = -ENOMEM;
-- 
2.26.3

