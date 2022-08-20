Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5459AF76
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiHTSRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiHTSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F0331213
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 2so1124643edx.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=e4jICG6gjMLfwoDo4zWh1kJbnZqKJz6qjRyX07nCUFA=;
        b=Gr/7HgQwJ6WukK57Ee2kwhhQ+ttuqhIFAg6JWcpP4+wjYC2NcnoT3uGG0OI2gh9jZt
         pdKG0O1vVYZVVESm+Apj4eisepNZ+kx9Z147O3h5Vpg8Y+TAnhLJNLAxZdJaX8+A5R0B
         4n+2Cly6C2vD817qoXpWMCD34curbnoAU+rcYUQKSmGUWIvYvyxoW6iGq9TExmKnMEeR
         JG4gVF0rPnb7S4mym3EE3sxV88fwCB++4r+5hbGq2QzjQ6Kgae6PkYcNgWZZxp3+Lajs
         RHA2QJu1EwpzQ/7qY4vxe1ZRdNxofTkvs+blhXou3Y+GSPmMCHB+nohYvx6uFXIe+DvN
         iO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=e4jICG6gjMLfwoDo4zWh1kJbnZqKJz6qjRyX07nCUFA=;
        b=0yG/ntmOJOSpPmfEsiGfhHQZ9qTeyqtQpAbOoGNp+tIA0rNxFu8L9XTBi/TChKvyR9
         dWWi+ixjX7JC+zMnZGjGYDsDNzkjhecYaWr8X+0zBRUndWcELkMar+nep3pbHctUa8ib
         c9nDReYlmRFobuwkavyKYFzFiMyLZO8ZZRTFmON0rGyw1aoBLE1cC8+GL2vl3/rIFctj
         gdIZkcnApDRtgWp2TpAt3YGoKViI3cMf9OnhrioamCI6mIRsUol/y13Lbp7dkB2vJS4H
         QbMwlZkWwIKcrLDoc6QYB+sFLpPqiv7xbJ5KRRaCNluUsKLVMcuhTvJ48oDwlXqjDyro
         OkZw==
X-Gm-Message-State: ACgBeo3fweVq31GrU9GCCZwrgwQXNoLZmBBrqMKW2bWWG2JJ+F7aTzmh
        IvKgx74idXVN4o7NdV9V6aM=
X-Google-Smtp-Source: AA6agR6zwR2DTcTb1GMKEy/7A7Ih+d1e823/dU582oGjYfp88DElN5cMOJOCx8BJR/ofYUElG+kH4A==
X-Received: by 2002:a05:6402:ea1:b0:443:d90a:5d31 with SMTP id h33-20020a0564020ea100b00443d90a5d31mr10271644eda.121.1661019401649;
        Sat, 20 Aug 2022 11:16:41 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/19] staging: r8188eu: make _rtw_open_pktfile() static
Date:   Sat, 20 Aug 2022 20:16:12 +0200
Message-Id: <20220820181623.12497-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
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

The function _rtw_open_pktfile() is only used in rtw_xmit.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      | 19 ++++++++++++++++++
 drivers/staging/r8188eu/include/xmit_osdep.h |  1 -
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 21 --------------------
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index eef1a27e84eb..6cf583fd9890 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -402,6 +402,25 @@ u8	qos_acm(u8 acm_mask, u8 priority)
 	return change_priority;
 }
 
+static void _rtw_open_pktfile(struct sk_buff *pktptr, struct pkt_file *pfile)
+{
+	if (!pktptr) {
+		pr_err("8188eu: pktptr is NULL\n");
+		return;
+	}
+	if (!pfile) {
+		pr_err("8188eu: pfile is NULL\n");
+		return;
+	}
+	pfile->pkt = pktptr;
+	pfile->cur_addr = pktptr->data;
+	pfile->buf_start = pktptr->data;
+	pfile->pkt_len = pktptr->len;
+	pfile->buf_len = pktptr->len;
+
+	pfile->cur_buffer = pfile->buf_start;
+}
+
 static void set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 {
 	struct ethhdr etherhdr;
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index 2c663c00b985..2ecbe3f01aa8 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -30,7 +30,6 @@ struct xmit_buf;
 
 int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev);
 
-void _rtw_open_pktfile(struct sk_buff *pkt, struct pkt_file *pfile);
 uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt);
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 3d298d8187d2..c917024843a2 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -17,27 +17,6 @@ static uint rtw_remainder_len(struct pkt_file *pfile)
 	       (size_t)(pfile->buf_start));
 }
 
-void _rtw_open_pktfile(struct sk_buff *pktptr, struct pkt_file *pfile)
-{
-
-	if (!pktptr) {
-		pr_err("8188eu: pktptr is NULL\n");
-		return;
-	}
-	if (!pfile) {
-		pr_err("8188eu: pfile is NULL\n");
-		return;
-	}
-	pfile->pkt = pktptr;
-	pfile->cur_addr = pktptr->data;
-	pfile->buf_start = pktptr->data;
-	pfile->pkt_len = pktptr->len;
-	pfile->buf_len = pktptr->len;
-
-	pfile->cur_buffer = pfile->buf_start;
-
-}
-
 uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
 {
 	uint	len = 0;
-- 
2.37.2

