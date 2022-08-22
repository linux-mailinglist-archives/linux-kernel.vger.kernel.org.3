Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15A159B9C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiHVGrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiHVGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:47:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DDA28711;
        Sun, 21 Aug 2022 23:47:16 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M3UEF2031551;
        Mon, 22 Aug 2022 06:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=8tGeshPQ4ptxoqqXNvZejPDqONgXcfY6pSC7QT8zil4=;
 b=isOAYDyb0OdvND/k0pSirvAfxpe6puEbJT3947/LJp6luYnI6U6G3QfRXxdjxReIpDxb
 bjaXXlSIUPkfRpoOqg0LkskBlz12HAfICVbqTHzLsLD6J9r41hj2wTiYuy2lCraOFpQK
 l6CKCBAhSmXyMaAgjof6c/iV6UibTddeldbMKTFLDWO6GUD6plf1+qbDFvaFjgbcTzoj
 TXBkUoDj8ZqjJcMZVvHLRPCzmaRUxCxPj2aZZ9VM0PzZREtayQdwY7riZx2D8MFITftg
 O8uMvjEusX7FKDLJ2vJZqy4KcHRyNua0Ko6JMofdtGglDEpwuZwky3CetF9fddyVj++u bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j2vwkbbef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 06:47:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27M6l1a9019416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 06:47:02 GMT
Received: from quicinc.com (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 21 Aug
 2022 23:47:01 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>
Subject: [PATCH] soc: qcom: qmi: use const for struct qmi_elem_info
Date:   Sun, 21 Aug 2022 23:46:48 -0700
Message-ID: <20220822064648.30794-1-quic_jjohnson@quicinc.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OOgTgKZBwUiW9xLQcRStV5pJxvJRTGT4
X-Proofpoint-GUID: OOgTgKZBwUiW9xLQcRStV5pJxvJRTGT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=972 clxscore=1011 priorityscore=1501
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208220029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all usage of struct qmi_elem_info, which is used to define
the QMI message encoding/decoding rules, does not use const. This
prevents clients from registering const arrays. Since these arrays are
always pre-defined, they should be const, so add the const qualifier
to all places in the QMI interface where struct qmi_elem_info is used.

Once this patch is in place, clients can independently update their
pre-defined arrays to be const, as demonstrated in the QMI sample
code.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/soc/qcom/qmi_encdec.c    | 48 ++++++++++++++++----------------
 drivers/soc/qcom/qmi_interface.c | 12 ++++----
 include/linux/soc/qcom/qmi.h     | 20 ++++++-------
 samples/qmi/qmi_sample_client.c  | 10 +++----
 4 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index 328cc8237191..6144bf6fe1e4 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -57,11 +57,11 @@ do { \
 #define TLV_TYPE_SIZE sizeof(u8)
 #define OPTIONAL_TLV_TYPE_START 0x10
 
-static int qmi_encode(struct qmi_elem_info *ei_array, void *out_buf,
+static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 		      const void *in_c_struct, u32 out_buf_len,
 		      int enc_level);
 
-static int qmi_decode(struct qmi_elem_info *ei_array, void *out_c_struct,
+static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 		      const void *in_buf, u32 in_buf_len, int dec_level);
 
 /**
@@ -76,10 +76,10 @@ static int qmi_decode(struct qmi_elem_info *ei_array, void *out_c_struct,
  *
  * Return: struct info of the next element that can be encoded.
  */
-static struct qmi_elem_info *skip_to_next_elem(struct qmi_elem_info *ei_array,
+static struct qmi_elem_info *skip_to_next_elem(const struct qmi_elem_info *ei_array,
 					       int level)
 {
-	struct qmi_elem_info *temp_ei = ei_array;
+	const struct qmi_elem_info *temp_ei = ei_array;
 	u8 tlv_type;
 
 	if (level > 1) {
@@ -101,11 +101,11 @@ static struct qmi_elem_info *skip_to_next_elem(struct qmi_elem_info *ei_array,
  *
  * Return: Expected minimum length of the QMI message or 0 on error.
  */
-static int qmi_calc_min_msg_len(struct qmi_elem_info *ei_array,
+static int qmi_calc_min_msg_len(const struct qmi_elem_info *ei_array,
 				int level)
 {
 	int min_msg_len = 0;
-	struct qmi_elem_info *temp_ei = ei_array;
+	const struct qmi_elem_info *temp_ei = ei_array;
 
 	if (!ei_array)
 		return min_msg_len;
@@ -194,13 +194,13 @@ static int qmi_encode_basic_elem(void *buf_dst, const void *buf_src,
  * Return: The number of bytes of encoded information on success or negative
  * errno on error.
  */
-static int qmi_encode_struct_elem(struct qmi_elem_info *ei_array,
+static int qmi_encode_struct_elem(const struct qmi_elem_info *ei_array,
 				  void *buf_dst, const void *buf_src,
 				  u32 elem_len, u32 out_buf_len,
 				  int enc_level)
 {
 	int i, rc, encoded_bytes = 0;
-	struct qmi_elem_info *temp_ei = ei_array;
+	const struct qmi_elem_info *temp_ei = ei_array;
 
 	for (i = 0; i < elem_len; i++) {
 		rc = qmi_encode(temp_ei->ei_array, buf_dst, buf_src,
@@ -233,13 +233,13 @@ static int qmi_encode_struct_elem(struct qmi_elem_info *ei_array,
  * Return: The number of bytes of encoded information on success or negative
  * errno on error.
  */
-static int qmi_encode_string_elem(struct qmi_elem_info *ei_array,
+static int qmi_encode_string_elem(const struct qmi_elem_info *ei_array,
 				  void *buf_dst, const void *buf_src,
 				  u32 out_buf_len, int enc_level)
 {
 	int rc;
 	int encoded_bytes = 0;
-	struct qmi_elem_info *temp_ei = ei_array;
+	const struct qmi_elem_info *temp_ei = ei_array;
 	u32 string_len = 0;
 	u32 string_len_sz = 0;
 
@@ -289,11 +289,11 @@ static int qmi_encode_string_elem(struct qmi_elem_info *ei_array,
  * Return: The number of bytes of encoded information on success or negative
  * errno on error.
  */
-static int qmi_encode(struct qmi_elem_info *ei_array, void *out_buf,
+static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 		      const void *in_c_struct, u32 out_buf_len,
 		      int enc_level)
 {
-	struct qmi_elem_info *temp_ei = ei_array;
+	const struct qmi_elem_info *temp_ei = ei_array;
 	u8 opt_flag_value = 0;
 	u32 data_len_value = 0, data_len_sz;
 	u8 *buf_dst = (u8 *)out_buf;
@@ -468,13 +468,13 @@ static int qmi_decode_basic_elem(void *buf_dst, const void *buf_src,
  * Return: The total size of the decoded data elements on success, negative
  * errno on error.
  */
-static int qmi_decode_struct_elem(struct qmi_elem_info *ei_array,
+static int qmi_decode_struct_elem(const struct qmi_elem_info *ei_array,
 				  void *buf_dst, const void *buf_src,
 				  u32 elem_len, u32 tlv_len,
 				  int dec_level)
 {
 	int i, rc, decoded_bytes = 0;
-	struct qmi_elem_info *temp_ei = ei_array;
+	const struct qmi_elem_info *temp_ei = ei_array;
 
 	for (i = 0; i < elem_len && decoded_bytes < tlv_len; i++) {
 		rc = qmi_decode(temp_ei->ei_array, buf_dst, buf_src,
@@ -514,7 +514,7 @@ static int qmi_decode_struct_elem(struct qmi_elem_info *ei_array,
  * Return: The total size of the decoded data elements on success, negative
  * errno on error.
  */
-static int qmi_decode_string_elem(struct qmi_elem_info *ei_array,
+static int qmi_decode_string_elem(const struct qmi_elem_info *ei_array,
 				  void *buf_dst, const void *buf_src,
 				  u32 tlv_len, int dec_level)
 {
@@ -522,7 +522,7 @@ static int qmi_decode_string_elem(struct qmi_elem_info *ei_array,
 	int decoded_bytes = 0;
 	u32 string_len = 0;
 	u32 string_len_sz = 0;
-	struct qmi_elem_info *temp_ei = ei_array;
+	const struct qmi_elem_info *temp_ei = ei_array;
 
 	if (dec_level == 1) {
 		string_len = tlv_len;
@@ -564,10 +564,10 @@ static int qmi_decode_string_elem(struct qmi_elem_info *ei_array,
  *
  * Return: Pointer to struct info, if found
  */
-static struct qmi_elem_info *find_ei(struct qmi_elem_info *ei_array,
-				     u32 type)
+static const struct qmi_elem_info *find_ei(const struct qmi_elem_info *ei_array,
+					   u32 type)
 {
-	struct qmi_elem_info *temp_ei = ei_array;
+	const struct qmi_elem_info *temp_ei = ei_array;
 
 	while (temp_ei->data_type != QMI_EOTI) {
 		if (temp_ei->tlv_type == (u8)type)
@@ -590,11 +590,11 @@ static struct qmi_elem_info *find_ei(struct qmi_elem_info *ei_array,
  * Return: The number of bytes of decoded information on success, negative
  * errno on error.
  */
-static int qmi_decode(struct qmi_elem_info *ei_array, void *out_c_struct,
+static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 		      const void *in_buf, u32 in_buf_len,
 		      int dec_level)
 {
-	struct qmi_elem_info *temp_ei = ei_array;
+	const struct qmi_elem_info *temp_ei = ei_array;
 	u8 opt_flag_value = 1;
 	u32 data_len_value = 0, data_len_sz = 0;
 	u8 *buf_dst = out_c_struct;
@@ -713,7 +713,7 @@ static int qmi_decode(struct qmi_elem_info *ei_array, void *out_c_struct,
  * Return: Buffer with encoded message, or negative ERR_PTR() on error
  */
 void *qmi_encode_message(int type, unsigned int msg_id, size_t *len,
-			 unsigned int txn_id, struct qmi_elem_info *ei,
+			 unsigned int txn_id, const struct qmi_elem_info *ei,
 			 const void *c_struct)
 {
 	struct qmi_header *hdr;
@@ -767,7 +767,7 @@ EXPORT_SYMBOL(qmi_encode_message);
  * errno on error.
  */
 int qmi_decode_message(const void *buf, size_t len,
-		       struct qmi_elem_info *ei, void *c_struct)
+		       const struct qmi_elem_info *ei, void *c_struct)
 {
 	if (!ei)
 		return -EINVAL;
@@ -781,7 +781,7 @@ int qmi_decode_message(const void *buf, size_t len,
 EXPORT_SYMBOL(qmi_decode_message);
 
 /* Common header in all QMI responses */
-struct qmi_elem_info qmi_response_type_v01_ei[] = {
+const struct qmi_elem_info qmi_response_type_v01_ei[] = {
 	{
 		.data_type	= QMI_SIGNED_2_BYTE_ENUM,
 		.elem_len	= 1,
diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index c8c4c730b135..57052726299d 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -305,7 +305,7 @@ EXPORT_SYMBOL(qmi_add_server);
  * Return: Transaction id on success, negative errno on failure.
  */
 int qmi_txn_init(struct qmi_handle *qmi, struct qmi_txn *txn,
-		 struct qmi_elem_info *ei, void *c_struct)
+		 const struct qmi_elem_info *ei, void *c_struct)
 {
 	int ret;
 
@@ -736,7 +736,8 @@ EXPORT_SYMBOL(qmi_handle_release);
 static ssize_t qmi_send_message(struct qmi_handle *qmi,
 				struct sockaddr_qrtr *sq, struct qmi_txn *txn,
 				int type, int msg_id, size_t len,
-				struct qmi_elem_info *ei, const void *c_struct)
+				const struct qmi_elem_info *ei,
+				const void *c_struct)
 {
 	struct msghdr msghdr = {};
 	struct kvec iv;
@@ -787,7 +788,7 @@ static ssize_t qmi_send_message(struct qmi_handle *qmi,
  */
 ssize_t qmi_send_request(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
 			 struct qmi_txn *txn, int msg_id, size_t len,
-			 struct qmi_elem_info *ei, const void *c_struct)
+			 const struct qmi_elem_info *ei, const void *c_struct)
 {
 	return qmi_send_message(qmi, sq, txn, QMI_REQUEST, msg_id, len, ei,
 				c_struct);
@@ -808,7 +809,7 @@ EXPORT_SYMBOL(qmi_send_request);
  */
 ssize_t qmi_send_response(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
 			  struct qmi_txn *txn, int msg_id, size_t len,
-			  struct qmi_elem_info *ei, const void *c_struct)
+			  const struct qmi_elem_info *ei, const void *c_struct)
 {
 	return qmi_send_message(qmi, sq, txn, QMI_RESPONSE, msg_id, len, ei,
 				c_struct);
@@ -827,7 +828,8 @@ EXPORT_SYMBOL(qmi_send_response);
  * Return: 0 on success, negative errno on failure.
  */
 ssize_t qmi_send_indication(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
-			    int msg_id, size_t len, struct qmi_elem_info *ei,
+			    int msg_id, size_t len,
+			    const struct qmi_elem_info *ei,
 			    const void *c_struct)
 {
 	struct qmi_txn txn;
diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
index b1f80e756d2a..469e02d2aa0d 100644
--- a/include/linux/soc/qcom/qmi.h
+++ b/include/linux/soc/qcom/qmi.h
@@ -75,7 +75,7 @@ struct qmi_elem_info {
 	enum qmi_array_type array_type;
 	u8 tlv_type;
 	u32 offset;
-	struct qmi_elem_info *ei_array;
+	const struct qmi_elem_info *ei_array;
 };
 
 #define QMI_RESULT_SUCCESS_V01			0
@@ -102,7 +102,7 @@ struct qmi_response_type_v01 {
 	u16 error;
 };
 
-extern struct qmi_elem_info qmi_response_type_v01_ei[];
+extern const struct qmi_elem_info qmi_response_type_v01_ei[];
 
 /**
  * struct qmi_service - context to track lookup-results
@@ -173,7 +173,7 @@ struct qmi_txn {
 	struct completion completion;
 	int result;
 
-	struct qmi_elem_info *ei;
+	const struct qmi_elem_info *ei;
 	void *dest;
 };
 
@@ -189,7 +189,7 @@ struct qmi_msg_handler {
 	unsigned int type;
 	unsigned int msg_id;
 
-	struct qmi_elem_info *ei;
+	const struct qmi_elem_info *ei;
 
 	size_t decoded_size;
 	void (*fn)(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
@@ -249,23 +249,23 @@ void qmi_handle_release(struct qmi_handle *qmi);
 
 ssize_t qmi_send_request(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
 			 struct qmi_txn *txn, int msg_id, size_t len,
-			 struct qmi_elem_info *ei, const void *c_struct);
+			 const struct qmi_elem_info *ei, const void *c_struct);
 ssize_t qmi_send_response(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
 			  struct qmi_txn *txn, int msg_id, size_t len,
-			  struct qmi_elem_info *ei, const void *c_struct);
+			  const struct qmi_elem_info *ei, const void *c_struct);
 ssize_t qmi_send_indication(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
-			    int msg_id, size_t len, struct qmi_elem_info *ei,
+			    int msg_id, size_t len, const struct qmi_elem_info *ei,
 			    const void *c_struct);
 
 void *qmi_encode_message(int type, unsigned int msg_id, size_t *len,
-			 unsigned int txn_id, struct qmi_elem_info *ei,
+			 unsigned int txn_id, const struct qmi_elem_info *ei,
 			 const void *c_struct);
 
 int qmi_decode_message(const void *buf, size_t len,
-		       struct qmi_elem_info *ei, void *c_struct);
+		       const struct qmi_elem_info *ei, void *c_struct);
 
 int qmi_txn_init(struct qmi_handle *qmi, struct qmi_txn *txn,
-		 struct qmi_elem_info *ei, void *c_struct);
+		 const struct qmi_elem_info *ei, void *c_struct);
 int qmi_txn_wait(struct qmi_txn *txn, unsigned long timeout);
 void qmi_txn_cancel(struct qmi_txn *txn);
 
diff --git a/samples/qmi/qmi_sample_client.c b/samples/qmi/qmi_sample_client.c
index 78fcedbd25e2..c045e3d24326 100644
--- a/samples/qmi/qmi_sample_client.c
+++ b/samples/qmi/qmi_sample_client.c
@@ -42,7 +42,7 @@ struct test_name_type_v01 {
 	char name[TEST_MAX_NAME_SIZE_V01];
 };
 
-static struct qmi_elem_info test_name_type_v01_ei[] = {
+static const struct qmi_elem_info test_name_type_v01_ei[] = {
 	{
 		.data_type	= QMI_DATA_LEN,
 		.elem_len	= 1,
@@ -71,7 +71,7 @@ struct test_ping_req_msg_v01 {
 	struct test_name_type_v01 client_name;
 };
 
-static struct qmi_elem_info test_ping_req_msg_v01_ei[] = {
+static const struct qmi_elem_info test_ping_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_1_BYTE,
 		.elem_len	= 4,
@@ -113,7 +113,7 @@ struct test_ping_resp_msg_v01 {
 	struct test_name_type_v01 service_name;
 };
 
-static struct qmi_elem_info test_ping_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info test_ping_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -172,7 +172,7 @@ struct test_data_req_msg_v01 {
 	struct test_name_type_v01 client_name;
 };
 
-static struct qmi_elem_info test_data_req_msg_v01_ei[] = {
+static const struct qmi_elem_info test_data_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_DATA_LEN,
 		.elem_len	= 1,
@@ -224,7 +224,7 @@ struct test_data_resp_msg_v01 {
 	struct test_name_type_v01 service_name;
 };
 
-static struct qmi_elem_info test_data_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info test_data_resp_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
-- 
2.37.0

