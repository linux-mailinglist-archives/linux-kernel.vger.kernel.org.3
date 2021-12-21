Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B5847C888
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhLUVAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234156AbhLUVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640120411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=opHhr7eJomY1CIR2KI4V/ZHUiBD46mZi8UhoJAWs9bo=;
        b=Zf8GQVKC/bSg2qbywQPm1OCl2ynUrYhn3P3t4gOZR9kQvdjQtC7AWIGGS165RAaSrbn6lD
        OXg73I4eg+L1CdlVeOZEvPZTTFRS57rp7it88ZePzBQdK7nvzthbllQM1gKtxfZ3DP16as
        BIYPljJmhJNZuxJyN3tK28IXoMfo4DU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-e9HQ82jBNY6dphXjTGUeAg-1; Tue, 21 Dec 2021 16:00:09 -0500
X-MC-Unique: e9HQ82jBNY6dphXjTGUeAg-1
Received: by mail-oi1-f199.google.com with SMTP id 6-20020aca0b06000000b002bcd1c33ae3so187827oil.20
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 13:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=opHhr7eJomY1CIR2KI4V/ZHUiBD46mZi8UhoJAWs9bo=;
        b=G4HOZI7ECnGENFVNZsO4AObsszjo2flSvF6wThEMZcTwW1JjPx1lLTNvuIkfcWd31M
         rSaIsS0fWt2mBEV3mzqagzOp21YJAdvbDYRQDhgKFlE4b5ueHoAI0UmqW/846S/8Iw3u
         3MsTijDZtq2CyZ/d6iM+e4bcbcgRjQAcWxigB9t+afPDnV+ADjYTg5Vvni0n/QjpH0NW
         kB7FW5Vf7whscXFcBcgw2oSXEyDqDlnGrKYFRcL6wZnhTOgTIC71PxEj2iwvhJNWAVlE
         AAUY8QEY6Ujyb5tW+URA+KuHhHQ1ZHNkXxIpcpHjMi+jx25XvgCDOVS400Up2ubbepgp
         53oA==
X-Gm-Message-State: AOAM530mUYvKL/jmahjPQclku04j2Zjw8Ceq5RcbJuHJ0x5MzIZjvjdo
        XCxvvv2HY0Qlg8k6j5YZoCTtbt/FfkW2UTbRhxQUpAtfDCYRkOb5w67Fvb2J4Wf1Vkns3msmQw2
        6x69WNBt3u8cPRgq3nPC5z+vQ
X-Received: by 2002:aca:aa49:: with SMTP id t70mr9910oie.85.1640120408915;
        Tue, 21 Dec 2021 13:00:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziVncuYfrfE+RPUGyGvApAs6V4DsQA0c2MP2vr+q3FzM7aw2hm+pPGcEc53t9Jy+88JOV4pw==
X-Received: by 2002:aca:aa49:: with SMTP id t70mr9890oie.85.1640120408439;
        Tue, 21 Dec 2021 13:00:08 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f59sm2021otf.9.2021.12.21.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:00:08 -0800 (PST)
From:   trix@redhat.com
To:     wangzhou1@hisilicon.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] crypto: cleanup warning in qm_get_qos_value()
Date:   Tue, 21 Dec 2021 12:59:53 -0800
Message-Id: <20211221205953.3128923-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Building with clang static analysis returns this warning:

qm.c:4382:11: warning: The left operand of '==' is a garbage value
        if (*val == 0 || *val > QM_QOS_MAX_VAL || ret) {
            ~~~~ ^

The call to qm_qos_value_init() can return an error without setting
*val.  So check ret before checking *val.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/crypto/hisilicon/qm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index b1fe9c7b8cc89..c906f2e59277b 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4379,7 +4379,7 @@ static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
 		return -EINVAL;
 
 	ret = qm_qos_value_init(val_buf, val);
-	if (*val == 0 || *val > QM_QOS_MAX_VAL || ret) {
+	if (ret || *val == 0 || *val > QM_QOS_MAX_VAL) {
 		pci_err(qm->pdev, "input qos value is error, please set 1~1000!\n");
 		return -EINVAL;
 	}
-- 
2.26.3

