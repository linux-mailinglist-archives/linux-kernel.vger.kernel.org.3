Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A848575C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiAERgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbiAERgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:36:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97522C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:36:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso3573980pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlDyQSfZH97+YSOXX0OoVP/OqcWQnYb38Gvp9Yo2/W0=;
        b=CYToiqUrNG3t3x39vLyMisao1WjgLJw0g2VmSXl2v82QK8IjZKQltcCkddvWZrhsJ0
         uGlpnBLdlTrJp7gEpD1vVsfLfU/sNu+CLemkhe6qrqOxkPhYGtO7IFWXkqk5eXFSw34v
         P3UucZWCN39FnL4LzccNJ5nbXrXuRxXcQLMRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlDyQSfZH97+YSOXX0OoVP/OqcWQnYb38Gvp9Yo2/W0=;
        b=RmZmWXF6dkJPix+14INLV+BHFqyr6ZPnqZAktqji6y1hfHAmLp7OOg9ozgazFe1t8b
         CMa/b02DjzLTuwj9u4pbKsjsXTq+ZS6SdvASOVtkpR6MWPZgY0a0btQDfRWqOvZMmL6Q
         hHqMvpAslQoZMYIN/XtH5lj48/zKqfKhW/YCeeONo7SVuq0QVtcmKxSrBuOpvYfZDyah
         dBpqiT2HiTmutRAAuGXswdZ5RkrZ+g43JRNffbozeKN4DD6XcpREF+Z+k1dkfAPeTeaf
         CQiBdRpim4s3dgFvBLn9nrMmSfG36MAteZvnd0eslEDSK9LsDJ+djiQm61R+qH5qTGQk
         iJ6Q==
X-Gm-Message-State: AOAM533PzpCLnZME2tPb1mBO+jSPSj58udHgnPbGIQhdKEvmMobWEods
        shjqSDV+Sj8u19xjkdaordnuXw==
X-Google-Smtp-Source: ABdhPJxRAvesKc77wiFyz23fyuXHgHsmrfIZycg9eOtRUOAcEQtVNM/mW0s1X/aWw9HMHp0TJM/6RQ==
X-Received: by 2002:a17:902:ea02:b0:149:473f:ca35 with SMTP id s2-20020a170902ea0200b00149473fca35mr55049525plg.99.1641404195156;
        Wed, 05 Jan 2022 09:36:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o34sm22926834pgl.33.2022.01.05.09.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:36:34 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH][RESEND] scsi: megaraid: Avoid mismatched storage type sizes
Date:   Wed,  5 Jan 2022 09:36:33 -0800
Message-Id: <20220105173633.2421129-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7461; h=from:subject; bh=yCVF/dR75zh7pN1scPMv4U3tXSsTcbBV/KYX9KngEWY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh1dcgvp5F9LNf7Zt07G6F92kvoKo8Do3EicDHawzQ Z02EgniJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYdXXIAAKCRCJcvTf3G3AJsYxD/ 9TmyIV365IN5cHqKQsIt3+8vCbIV+iJQlKSIz8zTcIYFM9Az9UKzROZa4HgsUVsrfYbS7HxxE4YNvk SNbwBWUD/yk6M5nX7mzgeiqYy7x80aBH4+nFwr9IjQXuBeqTiHBdHa6uB2RK6ar0jfwMspijvPIMRW 6xDVNRgfAxsudy0yyufNPhfuJDdo2y/gII3FKafq62MklNbGXrZlzSQdN9SXIIc9h9gx/a5Uxvxdhg 9uxPrKyY2NcPVnANztsgW5MGDR64jr/VAWopirT9QagpgojMPD0wtmaWvZAR4wUHQ7qIyUTm7RGbQv YY34QvAVpdUZ5QcrCt5azihTurS2ilZTjII8wsggEWp2PsFD8x1iWsQ441Jd95FHZ805Y1SM7bxB0n i2nWNwneedallbaK9xICcfPC6hyPKBQceGOV+ZVw4PnNqTzbwkP3yBemxH8kkLjj1RaduMucQwZvEv 5dpscpuaBBqyOlGHcReCIwBcOH/gMlgi+mcWLXyLccH70RNOHk7aawrw39TJqQ79RGpP1BbR89GVlA Yg2k/8XvjBWIxiBLruCupRqauQEAazc0rp/EAt6GzXKGxawhMYSvjwxNC5lv3gIxeFBWS54b+APPQ7 xfpb1hPg820N8pcroNGZZ1C0d1RdDhBE+jl8NE3LP4DBDC5Mu64KafG+7Njg==
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

Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: megaraidlinux.pdl@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Original patch sent here:
https://lore.kernel.org/lkml/20211203091424.3355371-1-keescook@chromium.org/
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

