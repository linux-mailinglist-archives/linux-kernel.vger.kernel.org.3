Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8FA57DF45
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiGVJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiGVJuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:50:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECF121A8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:49:01 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M7wsvu010994;
        Fri, 22 Jul 2022 04:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=mhudEj+jeeORFqXXeD7h2ikvbMsXpSNbYJ7DiT+NSCM=;
 b=Ul1zY9WF5TtQyarOJlleAbobaWXH+4nzOF3knGAB9umilUrHQmUZrjJ68cano3LeHDlg
 8O6nylOolhCSU4q4AaxyRRI42WmzBOcF1eeINR992sLkJKgUOq/VfKRVvX854E7Co140
 npY/AbwN7krlAd7Ogg92wq2BWttC9PokY6Ku1MqA44AyZSpw8EoKhSfgUYGiir01Hq6N
 VNbjMQMUbbm0SqWjQumvDdR1NHYb4s9rVZ9UzyfF52Q5Uy5f444Aa+CmG8+OLSAh5DgC
 7xnBjxojbpUV0rY3Bzro4K7L5B8P7tyX6kIL6zXE7xTyp2wgMYTznZwbapUSrsNttPF6 hg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hdrqfm7ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 04:48:53 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 22 Jul
 2022 04:48:51 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Fri, 22 Jul 2022 04:48:51 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A05DD477;
        Fri, 22 Jul 2022 09:48:51 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] firmware: cs_dsp: Add memory chunk helpers
Date:   Fri, 22 Jul 2022 10:48:51 +0100
Message-ID: <20220722094851.92521-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722094851.92521-1-ckeepax@opensource.cirrus.com>
References: <20220722094851.92521-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: C36uW4LBVuq7E_CKa2O5qQsN4DCgQiYe
X-Proofpoint-GUID: C36uW4LBVuq7E_CKa2O5qQsN4DCgQiYe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers that can be layered on top of a buffer read from or to be
written to the DSP to faciliate accessing datastructures within the DSP
memory. These functions handle adding the padding bytes for the DSP,
converting to big endian, and packing arbitrary length data.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c       | 104 +++++++++++++++++++++++++
 include/linux/firmware/cirrus/cs_dsp.h |  73 +++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index b402f841d72cf..81cc3d0f6eec1 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -3180,6 +3180,110 @@ static const struct cs_dsp_ops cs_dsp_halo_ops = {
 	.stop_core = cs_dsp_halo_stop_core,
 };
 
+/**
+ * cs_dsp_chunk_write() - Format data to a DSP memory chunk
+ * @ch: Pointer to the chunk structure
+ * @nbits: Number of bits to write
+ * @val: Value to write
+ *
+ * This function sequentially writes values into the format required for DSP
+ * memory, it handles both inserting of the padding bytes and converting to
+ * big endian. Note that data is only committed to the chunk when a whole DSP
+ * words worth of data is available.
+ *
+ * Return: Zero for success, a negative number on error.
+ */
+int cs_dsp_chunk_write(struct cs_dsp_chunk *ch, int nbits, u32 val)
+{
+	int nwrite, i;
+
+	nwrite = min(CS_DSP_DATA_WORD_BITS - ch->cachebits, nbits);
+
+	ch->cache <<= nwrite;
+	ch->cache |= val >> (nbits - nwrite);
+	ch->cachebits += nwrite;
+	nbits -= nwrite;
+
+	if (ch->cachebits == CS_DSP_DATA_WORD_BITS) {
+		if (cs_dsp_chunk_end(ch))
+			return -ENOSPC;
+
+		ch->cache &= 0xFFFFFF;
+		for (i = 0; i < sizeof(ch->cache); i++, ch->cache <<= BITS_PER_BYTE)
+			*ch->data++ = (ch->cache & 0xFF000000) >> CS_DSP_DATA_WORD_BITS;
+
+		ch->bytes += sizeof(ch->cache);
+		ch->cachebits = 0;
+	}
+
+	if (nbits)
+		return cs_dsp_chunk_write(ch, nbits, val);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs_dsp_chunk_write);
+
+/**
+ * cs_dsp_chunk_flush() - Pad remaining data with zero and commit to chunk
+ * @ch: Pointer to the chunk structure
+ *
+ * As cs_dsp_chunk_write only writes data when a whole DSP word is ready to
+ * be written out it is possible that some data will remain in the cache, this
+ * function will pad that data with zeros upto a whole DSP word and write out.
+ *
+ * Return: Zero for success, a negative number on error.
+ */
+int cs_dsp_chunk_flush(struct cs_dsp_chunk *ch)
+{
+	if (!ch->cachebits)
+		return 0;
+
+	return cs_dsp_chunk_write(ch, CS_DSP_DATA_WORD_BITS - ch->cachebits, 0);
+}
+EXPORT_SYMBOL_GPL(cs_dsp_chunk_flush);
+
+/**
+ * cs_dsp_chunk_read() - Parse data from a DSP memory chunk
+ * @ch: Pointer to the chunk structure
+ * @nbits: Number of bits to read
+ *
+ * This function sequentially reads values from a DSP memory formatted buffer,
+ * it handles both removing of the padding bytes and converting from big endian.
+ *
+ * Return: A negative number is returned on error, otherwise the read value.
+ */
+int cs_dsp_chunk_read(struct cs_dsp_chunk *ch, int nbits)
+{
+	int nread, i;
+	u32 result;
+
+	if (!ch->cachebits) {
+		if (cs_dsp_chunk_end(ch))
+			return -ENOSPC;
+
+		ch->cache = 0;
+		ch->cachebits = CS_DSP_DATA_WORD_BITS;
+
+		for (i = 0; i < sizeof(ch->cache); i++, ch->cache <<= BITS_PER_BYTE)
+			ch->cache |= *ch->data++;
+
+		ch->bytes += sizeof(ch->cache);
+	}
+
+	nread = min(ch->cachebits, nbits);
+	nbits -= nread;
+
+	result = ch->cache >> ((sizeof(ch->cache) * BITS_PER_BYTE) - nread);
+	ch->cache <<= nread;
+	ch->cachebits -= nread;
+
+	if (nbits)
+		result = (result << nbits) | cs_dsp_chunk_read(ch, nbits);
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(cs_dsp_chunk_read);
+
 MODULE_DESCRIPTION("Cirrus Logic DSP Support");
 MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 6ab230218df0e..cad828e21c72b 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -11,6 +11,7 @@
 #ifndef __CS_DSP_H
 #define __CS_DSP_H
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/list.h>
@@ -34,6 +35,7 @@
 #define CS_ADSP2_REGION_ALL (CS_ADSP2_REGION_0 | CS_ADSP2_REGION_1_9)
 
 #define CS_DSP_DATA_WORD_SIZE                3
+#define CS_DSP_DATA_WORD_BITS                (3 * BITS_PER_BYTE)
 
 #define CS_DSP_ACKED_CTL_TIMEOUT_MS          100
 #define CS_DSP_ACKED_CTL_N_QUICKPOLLS        10
@@ -252,4 +254,75 @@ struct cs_dsp_alg_region *cs_dsp_find_alg_region(struct cs_dsp *dsp,
 
 const char *cs_dsp_mem_region_name(unsigned int type);
 
+/**
+ * struct cs_dsp_chunk - Describes a buffer holding data formatted for the DSP
+ * @data:	Pointer to underlying buffer memory
+ * @max:	Pointer to end of the buffer memory
+ * @bytes:	Number of bytes read/written into the memory chunk
+ * @cache:	Temporary holding data as it is formatted
+ * @cachebits:	Number of bits of data currently in cache
+ */
+struct cs_dsp_chunk {
+	u8 *data;
+	u8 *max;
+	int bytes;
+
+	u32 cache;
+	int cachebits;
+};
+
+/**
+ * cs_dsp_chunk() - Create a DSP memory chunk
+ * @data: Pointer to the buffer that will be used to store data
+ * @size: Size of the buffer in bytes
+ *
+ * Return: A cs_dsp_chunk structure
+ */
+static inline struct cs_dsp_chunk cs_dsp_chunk(void *data, int size)
+{
+	struct cs_dsp_chunk ch = {
+		.data = data,
+		.max = data + size,
+	};
+
+	return ch;
+}
+
+/**
+ * cs_dsp_chunk_end() - Check if a DSP memory chunk is full
+ * @ch: Pointer to the chunk structure
+ *
+ * Return: True if the whole buffer has been read/written
+ */
+static inline bool cs_dsp_chunk_end(struct cs_dsp_chunk *ch)
+{
+	return ch->data == ch->max;
+}
+
+/**
+ * cs_dsp_chunk_bytes() - Number of bytes written/read from a DSP memory chunk
+ * @ch: Pointer to the chunk structure
+ *
+ * Return: Number of bytes read/written to the buffer
+ */
+static inline int cs_dsp_chunk_bytes(struct cs_dsp_chunk *ch)
+{
+	return ch->bytes;
+}
+
+/**
+ * cs_dsp_chunk_valid_addr() - Check if an address is in a DSP memory chunk
+ * @ch: Pointer to the chunk structure
+ *
+ * Return: True if the given address is within the buffer
+ */
+static inline bool cs_dsp_chunk_valid_addr(struct cs_dsp_chunk *ch, void *addr)
+{
+	return (u8 *)addr >= ch->data && (u8 *)addr < ch->max;
+}
+
+int cs_dsp_chunk_write(struct cs_dsp_chunk *ch, int nbits, u32 val);
+int cs_dsp_chunk_flush(struct cs_dsp_chunk *ch);
+int cs_dsp_chunk_read(struct cs_dsp_chunk *ch, int nbits);
+
 #endif
-- 
2.30.2

