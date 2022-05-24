Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437E75332F8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbiEXVbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiEXVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:31:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B39C26
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:31:06 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OLLr1t010538;
        Tue, 24 May 2022 21:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qKIrqNLPjaLRBqiv4WGWBu1SfM8aEazEXMVCpIalUaA=;
 b=QJCk2vz8emPFw9K1NUEdxUUuEeKx8N2W8LHmtcmcimoor3ng/E2LJmy0dBDoLN+g9Ene
 14k5Jt4sLBkKoQ6EG5x5//Jk3dfYI1TWPnd+tWsGQ/P7hiZ3trBmWTlRTPnEoZ2Qi7VK
 arWYp1CdPtDw1Z2b6k2l5pKghx+MxXz5nOEBvwZluE2UuNAbn2LfFdiktci7yiOrmQk5
 u6NDqgztveHK99QFLK3I1MjMCIFljcPHgkQPXjoEavQp1WbkfKKz10LpLYd5I5OQKylg
 L1PbjojZ+nCwX2NCRglH0p90wm6A61Puq0CRSu8NrOOZ992kXejGWodQ21wfmoYM+zP/ hg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g977ar3jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 21:30:57 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OLS1hE026369;
        Tue, 24 May 2022 21:30:56 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3g93ut9qve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 21:30:56 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OLUtLq21037386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 21:30:55 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB41AAE062;
        Tue, 24 May 2022 21:30:55 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12F58AE05C;
        Tue, 24 May 2022 21:30:55 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.82.60])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 21:30:54 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH] eeprom: at25: Split reads into chunks and cap write size
Date:   Tue, 24 May 2022 16:30:43 -0500
Message-Id: <20220524213043.57559-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0eDLgV76QWcYSiEpyNuDq0HGIxrqz_1T
X-Proofpoint-GUID: 0eDLgV76QWcYSiEpyNuDq0HGIxrqz_1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_10,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205240105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Bishop <bradleyb@fuzziesquirrel.com>

Make use of spi_max_transfer_size to avoid requesting transfers that are
too large for some spi controllers.

Signed-off-by: Brad Bishop <bradleyb@fuzziesquirrel.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/misc/eeprom/at25.c | 93 ++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 8d169a35cf13..0434ffa6ec4c 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -79,6 +79,11 @@ static int at25_ee_read(void *priv, unsigned int offset,
 {
 	struct at25_data *at25 = priv;
 	char *buf = val;
+	size_t max_chunk = spi_max_transfer_size(at25->spi);
+	size_t num_msgs = DIV_ROUND_UP(count, max_chunk);
+	size_t nr_bytes = 0;
+	unsigned int msg_offset;
+	size_t msg_count;
 	u8			*cp;
 	ssize_t			status;
 	struct spi_transfer	t[2];
@@ -92,54 +97,59 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	if (unlikely(!count))
 		return -EINVAL;
 
-	cp = at25->command;
+	msg_offset = (unsigned int)offset;
+	msg_count = min(count, max_chunk);
+	while (num_msgs) {
+		cp = at25->command;
 
-	instr = AT25_READ;
-	if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
-		if (offset >= BIT(at25->addrlen * 8))
-			instr |= AT25_INSTR_BIT3;
+		instr = AT25_READ;
+		if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
+			if (msg_offset >= (1U << (at25->addrlen * 8)))
+				instr |= AT25_INSTR_BIT3;
 
-	mutex_lock(&at25->lock);
+		mutex_lock(&at25->lock);
 
-	*cp++ = instr;
-
-	/* 8/16/24-bit address is written MSB first */
-	switch (at25->addrlen) {
-	default:	/* case 3 */
-		*cp++ = offset >> 16;
-		fallthrough;
-	case 2:
-		*cp++ = offset >> 8;
-		fallthrough;
-	case 1:
-	case 0:	/* can't happen: for better code generation */
-		*cp++ = offset >> 0;
-	}
+		*cp++ = instr;
 
-	spi_message_init(&m);
-	memset(t, 0, sizeof(t));
+		/* 8/16/24-bit address is written MSB first */
+		switch (at25->addrlen) {
+		default:	/* case 3 */
+			*cp++ = msg_offset >> 16;
+			fallthrough;
+		case 2:
+			*cp++ = msg_offset >> 8;
+			fallthrough;
+		case 1:
+		case 0:	/* can't happen: for better codegen */
+			*cp++ = msg_offset >> 0;
+		}
 
-	t[0].tx_buf = at25->command;
-	t[0].len = at25->addrlen + 1;
-	spi_message_add_tail(&t[0], &m);
+		spi_message_init(&m);
+		memset(t, 0, sizeof(t));
 
-	t[1].rx_buf = buf;
-	t[1].len = count;
-	spi_message_add_tail(&t[1], &m);
+		t[0].tx_buf = at25->command;
+		t[0].len = at25->addrlen + 1;
+		spi_message_add_tail(&t[0], &m);
 
-	/*
-	 * Read it all at once.
-	 *
-	 * REVISIT that's potentially a problem with large chips, if
-	 * other devices on the bus need to be accessed regularly or
-	 * this chip is clocked very slowly.
-	 */
-	status = spi_sync(at25->spi, &m);
-	dev_dbg(&at25->spi->dev, "read %zu bytes at %d --> %zd\n",
-		count, offset, status);
+		t[1].rx_buf = buf + nr_bytes;
+		t[1].len = msg_count;
+		spi_message_add_tail(&t[1], &m);
 
-	mutex_unlock(&at25->lock);
-	return status;
+		status = spi_sync(at25->spi, &m);
+
+		mutex_unlock(&at25->lock);
+
+		if (status)
+			return status;
+
+		--num_msgs;
+		msg_offset += msg_count;
+		nr_bytes += msg_count;
+	}
+
+	dev_dbg(&at25->spi->dev, "read %zu bytes at %d\n",
+		count, offset);
+	return 0;
 }
 
 /* Read extra registers as ID or serial number */
@@ -190,6 +200,7 @@ ATTRIBUTE_GROUPS(sernum);
 static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at25_data *at25 = priv;
+	size_t maxsz = spi_max_transfer_size(at25->spi);
 	const char *buf = val;
 	int			status = 0;
 	unsigned		buf_size;
@@ -253,6 +264,8 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		segment = buf_size - (offset % buf_size);
 		if (segment > count)
 			segment = count;
+		if (segment > maxsz)
+			segment = maxsz;
 		memcpy(cp, buf, segment);
 		status = spi_write(at25->spi, bounce,
 				segment + at25->addrlen + 1);
-- 
2.27.0

