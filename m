Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D07533323
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbiEXVv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiEXVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:51:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D205C665
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:51:56 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OLfEfq007134;
        Tue, 24 May 2022 21:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=f5ZqreB55gygODdJk6y2+ucCZG8SHfLf71tnxTXjTQM=;
 b=nrDrBDP5nnu38uw9DF1hof5bvqq1eXggUSKH1Boh4eWErpl/08OKZb9//TyMuBxlDGZv
 EDDsFdkHrGxlzB1w6JkWry82MRBVLGIeHnc/O1oEnXYm6Gh7KX3NzG0HhuO/B64+aFn4
 2QzFnoEp29I6ynOabk/a+eqWiNWwzEuiG2mg38NLpoFAVHvrqr8GqJHn12AlxvSqrkjZ
 3YvAYgr7FY/ytHJYjY/ZLVmHfMdpx1wj7RJBktEGq9io/b4uV0sgzXBVwBdzISjCy3K9
 dL1B99wBVXqOuYzBGqQ4044InjHbpuPycTs20hxFa7KoaiS7ChKMhNYFxUj1y0B3vlQD /A== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g973b8dt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 21:51:48 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OLouT5018208;
        Tue, 24 May 2022 21:51:47 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 3g93v81unf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 21:51:47 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OLpkF564356738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 21:51:46 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAF44AE06A;
        Tue, 24 May 2022 21:51:46 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AA43AE068;
        Tue, 24 May 2022 21:51:46 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.82.60])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 21:51:45 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2] eeprom: at25: Split reads into chunks and cap write size
Date:   Tue, 24 May 2022 16:51:42 -0500
Message-Id: <20220524215142.60047-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: scF7snyU8GkGvHC5ZG5xf66-vVAIbh64
X-Proofpoint-ORIG-GUID: scF7snyU8GkGvHC5ZG5xf66-vVAIbh64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_10,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205240105
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
Changes since v1:
 - My apologies, I missed a couple of newer improvments in my rebase from
   an older kernel: the use of BIT() and better comment about code
   generation.
 
 drivers/misc/eeprom/at25.c | 93 ++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 8d169a35cf13..c9c56fd194c1 100644
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
+			if (msg_offset >= BIT(at25->addrlen * 8))
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
+		case 0:	/* can't happen: for better code generation */
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

