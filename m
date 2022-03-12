Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711EC4D6FDF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiCLPuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCLPt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 758ADD5547
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647100133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kISRCGimiFN+j8PVmDcD9+AwgFqbdKXIjp3SAo8kWyw=;
        b=hqEllWudHRMq/5Im9T/9iUlhG1ooMWpS8QBEpePbPAmKzwVsaF6Rj8rg60cdD3YvI7L/qe
        pTbqMVCw6U0c7tyiaSlof2GHNAOxjbe6Gf0ZJ7HdsJgrYwXgUcOP324epFzKG4UX++yVnT
        vhOUQp56anxvCHTW8yNYFvzYNgu5rdA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-_kYIIkYLMu6HhuGtE71XZw-1; Sat, 12 Mar 2022 10:48:52 -0500
X-MC-Unique: _kYIIkYLMu6HhuGtE71XZw-1
Received: by mail-qt1-f197.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso8811411qtm.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kISRCGimiFN+j8PVmDcD9+AwgFqbdKXIjp3SAo8kWyw=;
        b=tEFJh0W42AChwAHg7ziibwgtI4ESSGhNq+ETA86luTJr9EpfLdPX39/K3d/pQpfsYW
         ayIMLKAik5ON4xeB5qyG54PA+nY9udzq0ngsrI/vMP0QZE9R1K+y4cmKUNKrm/CvpQXu
         ZkMCkfn/fz/l2PVNIKl+4A1PSLg6XLNSdc/nsm5v1Lks7RzgxzTFJaSdmvOpkXgzITEs
         SAmmn6jGAZdfE1/MyAD9DML/kdlqRSl3ap3dEUSAFD4h26wt9vnUnziFoWeH9vbcuM8N
         YwQf+lHLbjzmvV/kssoRpABMo78krk84fONz8ozbHZ/9qFex0YyekzFA6l9jTGRQVK42
         jtzg==
X-Gm-Message-State: AOAM530Gh85zXQmPHtAojbF/hohaKHr8xF1DAhbxW/LUr8w83Vrr44dx
        yLSylYAyG6aMi8hOwwBSIdOYUqAPctC5tsjGqO97IjPmKzEPhlWvlLplG/hYaITBkHX8E4YUe4q
        O55qBDpScEJGRpSRqAK6+YjgF
X-Received: by 2002:ac8:7fcd:0:b0:2e1:cd49:4153 with SMTP id b13-20020ac87fcd000000b002e1cd494153mr655303qtk.38.1647100131913;
        Sat, 12 Mar 2022 07:48:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrlwtkGuieGph5i7dQs0daAao7w3lGwSdZ8aE9uKzklCWyujh6pAd13Ps8ESaGlleBhM36og==
X-Received: by 2002:ac8:7fcd:0:b0:2e1:cd49:4153 with SMTP id b13-20020ac87fcd000000b002e1cd494153mr655285qtk.38.1647100131675;
        Sat, 12 Mar 2022 07:48:51 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85893000000b002e1afa26591sm6015249qta.52.2022.03.12.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 07:48:51 -0800 (PST)
From:   trix@redhat.com
To:     ek5.chimenti@gmail.com, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: cec: seco: remove byte handling from smb_word_op
Date:   Sat, 12 Mar 2022 07:48:45 -0800
Message-Id: <20220312154845.1402960-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

smb_word_op() has a parameter data_format that
determines if the data is either a byte or
word.  From inspection, smb_word_op() is only
used by the macros smb_wr16() and smb_rd16()
both pass in CMD_WORD_DATA. There is no use of
smb_word_op() that passes in CMD_BYTE_DATA.
So remove the byte handling.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/cec/platform/seco/seco-cec.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/media/cec/platform/seco/seco-cec.c b/drivers/media/cec/platform/seco/seco-cec.c
index 51a6fcfd077df..580905e3d0667 100644
--- a/drivers/media/cec/platform/seco/seco-cec.c
+++ b/drivers/media/cec/platform/seco/seco-cec.c
@@ -31,29 +31,17 @@ struct secocec_data {
 	int irq;
 };
 
-#define smb_wr16(cmd, data) smb_word_op(CMD_WORD_DATA, SECOCEC_MICRO_ADDRESS, \
-					     cmd, data, SMBUS_WRITE, NULL)
-#define smb_rd16(cmd, res) smb_word_op(CMD_WORD_DATA, SECOCEC_MICRO_ADDRESS, \
+#define smb_wr16(cmd, data) smb_word_op(SECOCEC_MICRO_ADDRESS, \
+					cmd, data, SMBUS_WRITE, NULL)
+#define smb_rd16(cmd, res) smb_word_op(SECOCEC_MICRO_ADDRESS, \
 				       cmd, 0, SMBUS_READ, res)
 
-static int smb_word_op(short data_format, u16 slave_addr, u8 cmd, u16 data,
+static int smb_word_op(u16 slave_addr, u8 cmd, u16 data,
 		       u8 operation, u16 *result)
 {
 	unsigned int count;
-	short _data_format;
 	int status = 0;
 
-	switch (data_format) {
-	case CMD_BYTE_DATA:
-		_data_format = BRA_SMB_CMD_BYTE_DATA;
-		break;
-	case CMD_WORD_DATA:
-		_data_format = BRA_SMB_CMD_WORD_DATA;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	/* Active wait until ready */
 	for (count = 0; count <= SMBTIMEOUT; ++count) {
 		if (!(inb(HSTS) & BRA_INUSE_STS))
@@ -75,7 +63,7 @@ static int smb_word_op(short data_format, u16 slave_addr, u8 cmd, u16 data,
 		outb((u8)(data >> 8), HDAT1);
 	}
 
-	outb(BRA_START + _data_format, HCNT);
+	outb(BRA_START + BRA_SMB_CMD_WORD_DATA, HCNT);
 
 	for (count = 0; count <= SMBTIMEOUT; count++) {
 		if (!(inb(HSTS) & BRA_HOST_BUSY))
-- 
2.26.3

