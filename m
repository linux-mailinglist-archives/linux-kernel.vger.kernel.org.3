Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58EA4673C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379467AbhLCJRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351313AbhLCJRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:17:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81FBC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 01:14:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so4646880pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 01:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=saVuQhzixBwsqDYRywfLCa1HkOX8bignwBCsRWI1qEU=;
        b=SlTpIt8ZNCqW/9A4VUbaR83S1wMyfqdCewD6rXm+VJsVUfcmFju+i0rgDaRiL3X2FO
         FvKdIsYob7oyCjWrkpN2Etf1mA576MDr/cDygoeRNe3vedQHKPRj//TxFYNAA/qvT+1P
         2I2hQ0gXFqqEWsBI5TrldoZYGyyce4VvGqP6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=saVuQhzixBwsqDYRywfLCa1HkOX8bignwBCsRWI1qEU=;
        b=Ikww4mNdILgoPPGQMLvJ1C3b0CpWkxL2DiDuS2dNFCnozNeHybCNLNaSAwtm+nso9u
         Werqb37ZaZ5oE8UwINBEK1HZl+0u1yvd6IZTiKdctalh5naJOdaNB+vaGwrTC496cPMF
         ZRtcIcibD1Z2f3+5iqxKBBk3E2UNd7OQp7hG/+RXVRsoIepJRUfS1K3DFGkFIf1Dv0HY
         ByQJ+sM5UOe2Kk+9btQRqulW+RU2jiOPnVIew0fwblOCiBDLeUY+hjp+a5JdojdMNx+M
         xpfETBpQ9csE55P9eUz5iq0q/Kmq3zYESRiPC2+WTXvy9kIwlF70kB4TI+b9VRODVTKQ
         tHGQ==
X-Gm-Message-State: AOAM530qQNWMyq7/Y6aDPuomcHeYy+3cHqwqpaJK/ir7G3agRYR3lMWu
        wpd/AR5JZqTmJ5oiEzUSt1fpXQ==
X-Google-Smtp-Source: ABdhPJz8RnRahBC15FlwjjPsKlZ+CpQcH75sjsinaHiphr+fFlXgxA/jx9yn9VYUsmsMio1yEUacIw==
X-Received: by 2002:a17:903:248c:b0:142:9bf:8b0 with SMTP id p12-20020a170903248c00b0014209bf08b0mr21371502plw.70.1638522866265;
        Fri, 03 Dec 2021 01:14:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15sm1814024pjs.51.2021.12.03.01.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 01:14:26 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: megaraid: Avoid mismatched storage type sizes
Date:   Fri,  3 Dec 2021 01:14:24 -0800
Message-Id: <20211203091424.3355371-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7024; h=from:subject; bh=LkdLDRS96rJJ+hsAnyw+nSek/NN70rsR6NXpE1WqNL0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhqd/vtwMNKerswTCQUH/RzzThOHW470nn5B9vB56H GLxt2qSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYanf7wAKCRCJcvTf3G3AJjzbEA CJgny2oO/KaCl8l/C0HuShj6t+Kya+5RGbj776BKxjzVP8r12CulsTYnPWCFTLiXIM2CgzhHgZ/hhF uUIbLHncQ2M0UG/bOvuzqqBDLa8lc9XllLmTSxgXgRL3C2rnWHZ9mOjXpDvm+AzeZMBrOzkWhnMp53 k8IBu/HZcFuHDvLjTChZNmJxU0Owbrcrkns4KUqp7heH0gHLC5ZUCI7L4rmihEz0lQzr/RHKpjwy3i +phfAd+Eh853oaRCtg/TYI5bIzCnZQtUjwEmcF7kCv8uSqKuLLGAS+rUB5o60pxQIk7HrfuUGKNZV1 hahWnk48CPCLhDlLOb9cqeg2ObYrOitbaD2HNmxacySFe4t6EpfGTLd9vGYxxL37QDObmCYJI4ykzN OFYwNT/jpa4Z3zlGlu+hkmJ13Y+827pGXaoZ2ze9Z2knbOIn5jlSK4WO3ljhhduNIo1e/bttTwf3zE PTI4gNz7lylHPOb4lnJuEZKWyek4EPmEF3Yh0ToAyI8bkpbltSfqotzITyuWBXaerWh/UxpmdgQIVM 14vo61cj+l+Xw6JZIteOkCHIIeRKu7csJkNYaSDpMyErO5vFnbTWsUUwO7GVT4s8EueZyI0HR5andj V6cZu/c97mcCHEg0I4vTNF9087WaCDsgEnq4D9TJU4qii8BwRbsrvwKHGtiw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove needless use of mbox_t, replacing with just struct
mbox_out. Silences compiler warnings under a -Warray-bounds build:

drivers/scsi/megaraid.c: In function 'megaraid_probe_one':
drivers/scsi/megaraid.c:3615:30: error: array subscript 'mbox_t[0]' is partly outside array bounds of 'unsigned char[15]' [-Werror=array-bounds]
 3615 |         mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
      |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/megaraid.c:3599:23: note: while referencing 'raw_mbox'
 3599 |         unsigned char raw_mbox[sizeof(struct mbox_out)];
      |                       ^~~~~~~~

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/megaraid.c | 84 +++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 50 deletions(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 0d31d7a5e335..bf987f3a7f3f 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -192,23 +192,21 @@ mega_query_adapter(adapter_t *adapter)
 {
 	dma_addr_t	prod_info_dma_handle;
 	mega_inquiry3	*inquiry3;
-	u8	raw_mbox[sizeof(struct mbox_out)];
-	mbox_t	*mbox;
+	struct mbox_out	mbox;
+	u8	*raw_mbox = (u8 *)&mbox;
 	int	retval;
 
 	/* Initialize adapter inquiry mailbox */
 
-	mbox = (mbox_t *)raw_mbox;
-
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
-	memset(&mbox->m_out, 0, sizeof(raw_mbox));
+	memset(&mbox, 0, sizeof(mbox));
 
 	/*
 	 * Try to issue Inquiry3 command
 	 * if not succeeded, then issue MEGA_MBOXCMD_ADAPTERINQ command and
 	 * update enquiry3 structure
 	 */
-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox.xferaddr = (u32)adapter->buf_dma_handle;
 
 	inquiry3 = (mega_inquiry3 *)adapter->mega_buffer;
 
@@ -232,10 +230,10 @@ mega_query_adapter(adapter_t *adapter)
 
 		inq = &ext_inq->raid_inq;
 
-		mbox->m_out.xferaddr = (u32)dma_handle;
+		mbox.xferaddr = (u32)dma_handle;
 
 		/*issue old 0x04 command to adapter */
-		mbox->m_out.cmd = MEGA_MBOXCMD_ADPEXTINQ;
+		mbox.cmd = MEGA_MBOXCMD_ADPEXTINQ;
 
 		issue_scb_block(adapter, raw_mbox);
 
@@ -262,7 +260,7 @@ mega_query_adapter(adapter_t *adapter)
 						      sizeof(mega_product_info),
 						      DMA_FROM_DEVICE);
 
-		mbox->m_out.xferaddr = prod_info_dma_handle;
+		mbox.xferaddr = prod_info_dma_handle;
 
 		raw_mbox[0] = FC_NEW_CONFIG;	/* i.e. mbox->cmd=0xA1 */
 		raw_mbox[2] = NC_SUBOP_PRODUCT_INFO;	/* i.e. 0x0E */
@@ -3569,16 +3567,14 @@ mega_n_to_m(void __user *arg, megacmd_t *mc)
 static int
 mega_is_bios_enabled(adapter_t *adapter)
 {
-	unsigned char	raw_mbox[sizeof(struct mbox_out)];
-	mbox_t	*mbox;
-
-	mbox = (mbox_t *)raw_mbox;
+	struct mbox_out mbox;
+	unsigned char	*raw_mbox = (u8 *)&mbox;
 
-	memset(&mbox->m_out, 0, sizeof(raw_mbox));
+	memset(&mbox, 0, sizeof(mbox));
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox.xferaddr = (u32)adapter->buf_dma_handle;
 
 	raw_mbox[0] = IS_BIOS_ENABLED;
 	raw_mbox[2] = GET_BIOS;
@@ -3600,13 +3596,11 @@ mega_is_bios_enabled(adapter_t *adapter)
 static void
 mega_enum_raid_scsi(adapter_t *adapter)
 {
-	unsigned char raw_mbox[sizeof(struct mbox_out)];
-	mbox_t *mbox;
+	struct mbox_out mbox;
+	unsigned char	*raw_mbox = (u8 *)&mbox;
 	int i;
 
-	mbox = (mbox_t *)raw_mbox;
-
-	memset(&mbox->m_out, 0, sizeof(raw_mbox));
+	memset(&mbox, 0, sizeof(mbox));
 
 	/*
 	 * issue command to find out what channels are raid/scsi
@@ -3616,7 +3610,7 @@ mega_enum_raid_scsi(adapter_t *adapter)
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox.xferaddr = (u32)adapter->buf_dma_handle;
 
 	/*
 	 * Non-ROMB firmware fail this command, so all channels
@@ -3655,23 +3649,21 @@ static void
 mega_get_boot_drv(adapter_t *adapter)
 {
 	struct private_bios_data	*prv_bios_data;
-	unsigned char	raw_mbox[sizeof(struct mbox_out)];
-	mbox_t	*mbox;
+	struct mbox_out mbox;
+	unsigned char	*raw_mbox = (u8 *)&mbox;
 	u16	cksum = 0;
 	u8	*cksum_p;
 	u8	boot_pdrv;
 	int	i;
 
-	mbox = (mbox_t *)raw_mbox;
-
-	memset(&mbox->m_out, 0, sizeof(raw_mbox));
+	memset(&mbox, 0, sizeof(mbox));
 
 	raw_mbox[0] = BIOS_PVT_DATA;
 	raw_mbox[2] = GET_BIOS_PVT_DATA;
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox.xferaddr = (u32)adapter->buf_dma_handle;
 
 	adapter->boot_ldrv_enabled = 0;
 	adapter->boot_ldrv = 0;
@@ -3721,13 +3713,11 @@ mega_get_boot_drv(adapter_t *adapter)
 static int
 mega_support_random_del(adapter_t *adapter)
 {
-	unsigned char raw_mbox[sizeof(struct mbox_out)];
-	mbox_t *mbox;
+	struct mbox_out mbox;
+	unsigned char	*raw_mbox = (u8 *)&mbox;
 	int rval;
 
-	mbox = (mbox_t *)raw_mbox;
-
-	memset(&mbox->m_out, 0, sizeof(raw_mbox));
+	memset(&mbox, 0, sizeof(mbox));
 
 	/*
 	 * issue command
@@ -3750,13 +3740,11 @@ mega_support_random_del(adapter_t *adapter)
 static int
 mega_support_ext_cdb(adapter_t *adapter)
 {
-	unsigned char raw_mbox[sizeof(struct mbox_out)];
-	mbox_t *mbox;
+	struct mbox_out mbox;
+	unsigned char	*raw_mbox = (u8 *)&mbox;
 	int rval;
 
-	mbox = (mbox_t *)raw_mbox;
-
-	memset(&mbox->m_out, 0, sizeof(raw_mbox));
+	memset(&mbox, 0, sizeof(mbox));
 	/*
 	 * issue command to find out if controller supports extended CDBs.
 	 */
@@ -3865,16 +3853,14 @@ mega_do_del_logdrv(adapter_t *adapter, int logdrv)
 static void
 mega_get_max_sgl(adapter_t *adapter)
 {
-	unsigned char	raw_mbox[sizeof(struct mbox_out)];
-	mbox_t	*mbox;
+	struct mbox_out	mbox;
+	unsigned char	*raw_mbox = (u8 *)&mbox;
 
-	mbox = (mbox_t *)raw_mbox;
-
-	memset(mbox, 0, sizeof(raw_mbox));
+	memset(&mbox, 0, sizeof(mbox));
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox.xferaddr = (u32)adapter->buf_dma_handle;
 
 	raw_mbox[0] = MAIN_MISC_OPCODE;
 	raw_mbox[2] = GET_MAX_SG_SUPPORT;
@@ -3888,7 +3874,7 @@ mega_get_max_sgl(adapter_t *adapter)
 	}
 	else {
 		adapter->sglen = *((char *)adapter->mega_buffer);
-		
+
 		/*
 		 * Make sure this is not more than the resources we are
 		 * planning to allocate
@@ -3910,16 +3896,14 @@ mega_get_max_sgl(adapter_t *adapter)
 static int
 mega_support_cluster(adapter_t *adapter)
 {
-	unsigned char	raw_mbox[sizeof(struct mbox_out)];
-	mbox_t	*mbox;
-
-	mbox = (mbox_t *)raw_mbox;
+	struct mbox_out	mbox;
+	unsigned char	*raw_mbox = (u8 *)&mbox;
 
-	memset(mbox, 0, sizeof(raw_mbox));
+	memset(&mbox, 0, sizeof(mbox));
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
-	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
+	mbox.xferaddr = (u32)adapter->buf_dma_handle;
 
 	/*
 	 * Try to get the initiator id. This command will succeed iff the
-- 
2.30.2

