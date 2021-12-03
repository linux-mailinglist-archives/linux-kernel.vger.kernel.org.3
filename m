Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D31467A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358211AbhLCPq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:46:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233978AbhLCPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:46:55 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3ErsJx005632;
        Fri, 3 Dec 2021 15:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=aJHlGAcEBIiXbh1Zf7wGFefvJiI8vBQPSsYcWah5D6E=;
 b=dEtApW0cTgueslHo1bbYLLdH+sqo0WcNrDBkfBs4joga7Gw3PgapAXmwzjCpgKKexfsQ
 OM5MDxsHwPIzfGPn9pyXgHFCslHrZM4eZObOdWKzh+4RtOH25sVn83KsSxYQj2xI8vQN
 o6TS0IKMNgfoVSBQhHDIsE28GsDPODoqurQuw8GxbUvqlVpxDnH+K5GaUqtwVsJD1oOi
 8JxvyoL+9C8qn05uaAUFj+MV3ThxypUDJyYjdshgscSIX7QeSGqHyXSydyPQfIIYVShf
 NuIqwwKzuIoBcIMUxihtG1VokQcfif/EXio3KCv3mUGDN/v+hesjyRiFmdxdjzuKMysW GA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqnd5s0us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 15:43:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B3FcQpf002691;
        Fri, 3 Dec 2021 15:43:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3ckbxky8nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 15:43:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B3FhMYe26542480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 15:43:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B6B411C052;
        Fri,  3 Dec 2021 15:43:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36CAE11C04C;
        Fri,  3 Dec 2021 15:43:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.11.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 15:43:22 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>
Subject: [PATCH v3] powerpc/pseries: read the lpar name from the firmware
Date:   Fri,  3 Dec 2021 16:43:21 +0100
Message-Id: <20211203154321.13168-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _1osv22C3g7arS0Xlp1QvBPfSArGPSMT
X-Proofpoint-ORIG-GUID: _1osv22C3g7arS0Xlp1QvBPfSArGPSMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPAR name may be changed after the LPAR has been started in the HMC.
In that case lparstat command is not reporting the updated value because it
reads it from the device tree which is read at boot time.

However this value could be read from RTAS.

Adding this value in the /proc/powerpc/lparcfg output allows to read the
updated value.

Cc: Nathan Lynch <nathanl@linux.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
v3:
 address Michael's comments.
v2:
 address Nathan's comments.
 change title to partition_name aligning with existing partition_id
---
 arch/powerpc/platforms/pseries/lparcfg.c | 54 ++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index f71eac74ea92..5f6dbc23d7d2 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -311,6 +311,59 @@ static void parse_mpp_x_data(struct seq_file *m)
 		seq_printf(m, "coalesce_pool_spurr=%ld\n", mpp_x_data.pool_spurr_cycles);
 }
 
+/*
+ * PAPR defines, in section "7.3.16 System Parameters Option", the token 55 to
+ * read the LPAR name.
+ */
+#define SPLPAR_LPAR_NAME_TOKEN	55
+static void read_lpar_name(struct seq_file *m)
+{
+	int rc, len, token;
+	union {
+		char raw_buffer[RTAS_DATA_BUF_SIZE];
+		struct {
+			__be16 len;
+			char name[RTAS_DATA_BUF_SIZE-2];
+		};
+	} *local_buffer;
+
+	token = rtas_token("ibm,get-system-parameter");
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return;
+
+	local_buffer = kmalloc(sizeof(*local_buffer), GFP_KERNEL);
+	if (!local_buffer)
+		return;
+
+	do {
+		spin_lock(&rtas_data_buf_lock);
+		memset(rtas_data_buf, 0, RTAS_DATA_BUF_SIZE);
+		rc = rtas_call(token, 3, 1, NULL, SPLPAR_LPAR_NAME_TOKEN,
+			       __pa(rtas_data_buf), RTAS_DATA_BUF_SIZE);
+		if (!rc)
+			memcpy(local_buffer->raw_buffer, rtas_data_buf,
+			       RTAS_DATA_BUF_SIZE);
+		spin_unlock(&rtas_data_buf_lock);
+	} while (rtas_busy_delay(rc));
+
+	if (rc != 0) {
+		pr_err_once(
+			"%s %s Error calling get-system-parameter (0x%x)\n",
+			__FILE__, __func__, rc);
+	} else {
+		/* Force end of string */
+		len = be16_to_cpu(local_buffer->len);
+		if (len >= (RTAS_DATA_BUF_SIZE-2))
+			len = RTAS_DATA_BUF_SIZE-2;
+		local_buffer->name[len] = '\0';
+
+		seq_printf(m, "partition_name=%s\n", local_buffer->name);
+	}
+
+	kfree(local_buffer);
+}
+
+
 #define SPLPAR_CHARACTERISTICS_TOKEN 20
 #define SPLPAR_MAXLENGTH 1026*(sizeof(char))
 
@@ -496,6 +549,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		/* this call handles the ibm,get-system-parameter contents */
+		read_lpar_name(m);
 		parse_system_parameter_string(m);
 		parse_ppp_data(m);
 		parse_mpp_data(m);
-- 
2.34.1

