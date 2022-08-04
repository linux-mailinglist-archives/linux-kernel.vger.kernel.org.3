Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917405898B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiHDHwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbiHDHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:52:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E4E2AC5A;
        Thu,  4 Aug 2022 00:52:37 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2747jRwA011139;
        Thu, 4 Aug 2022 07:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TN+XdCLSqyDz6yFrNX1BnKhuGLKjYA8yxloDczOEbCI=;
 b=mUeE5nMWlibtvBgjvD4mshksjnC6aKGZJerHQgKAVgeTc9lbnBq2heriXOB01nmSuKYX
 Ylr/3Mh9RhE9YEILnhqmvaBYNxuzxm8c6swVcOtQyc9yX4yAnmpHBgW7J0Olz6uoZbJS
 JcyzUC6Lamh00w5lBnamf8h12sBrTzsJiRws6gM8ifBFMQxBZ1cTxDwSdN4lyDnBYZZX
 pG+8DXFdEL5NSVQAWa/7IX6Xywy2XtU/Xno9F+PmHcw5StnKlIHCp+05KKC0fqMjepXr
 kLIjsKU8GOpEHHU6Z9kqciZaw+cndl5l9PzVvlkR8bgr4YJA7yXkuVjXi8U3t+qjG7L0 nQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hra0n86e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 07:52:32 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2747pcvD008624;
        Thu, 4 Aug 2022 07:52:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3hmuwhww0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 07:52:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2747qR3619661224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Aug 2022 07:52:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32DCEA4051;
        Thu,  4 Aug 2022 07:52:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D06FEA4040;
        Thu,  4 Aug 2022 07:52:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Aug 2022 07:52:26 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf list: Add PMU pai_crypto event description for IBM z16
Date:   Thu,  4 Aug 2022 09:52:21 +0200
Message-Id: <20220804075221.1132849-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XR5Ocmlokcm7j3ivrEWiQW2CefjipEHM
X-Proofpoint-ORIG-GUID: XR5Ocmlokcm7j3ivrEWiQW2CefjipEHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_01,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the event description for the IBM z16 pai_crypto PMU released with
commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")

The document SA22-7832-13 "z/Architecture Principles of Operation",
published May, 2022, contains the description of the
Processor Activity Instrumentation Facility and the cryptography
counter set., See Pages 5-110 to 5-113.

Patch reworked to fit for the converted jevents processing.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../perf/pmu-events/arch/s390/cf_z16/pai.json | 1101 +++++++++++++++++
 tools/perf/pmu-events/jevents.py              |    1 +
 2 files changed, 1102 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/pai.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai.json b/tools/perf/pmu-events/arch/s390/cf_z16/pai.json
new file mode 100644
index 000000000000..cf8563d059b9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai.json
@@ -0,0 +1,1101 @@
+[
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4096",
+		"EventName": "CRYPTO_ALL",
+		"BriefDescription": "CRYPTO ALL",
+		"PublicDescription": "Sums of all non zero cryptography counters"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4097",
+		"EventName": "KM_DEA",
+		"BriefDescription": "KM DEA",
+		"PublicDescription": "KM-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4098",
+		"EventName": "KM_TDEA_128",
+		"BriefDescription": "KM TDEA 128",
+		"PublicDescription": "KM-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4099",
+		"EventName": "KM_TDEA_192",
+		"BriefDescription": "KM TDEA 192",
+		"PublicDescription": "KM-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4100",
+		"EventName": "KM_ENCRYPTED_DEA",
+		"BriefDescription": "KM ENCRYPTED DEA",
+		"PublicDescription": "KM-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4101",
+		"EventName": "KM_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KM ENCRYPTED TDEA 128",
+		"PublicDescription": "KM-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4102",
+		"EventName": "KM_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KM ENCRYPTED TDEA 192",
+		"PublicDescription": "KM-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4103",
+		"EventName": "KM_AES_128",
+		"BriefDescription": "KM AES 128",
+		"PublicDescription": "KM-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4104",
+		"EventName": "KM_AES_192",
+		"BriefDescription": "KM AES 192",
+		"PublicDescription": "KM-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4105",
+		"EventName": "KM_AES_256",
+		"BriefDescription": "KM AES 256",
+		"PublicDescription": "KM-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4106",
+		"EventName": "KM_ENCRYPTED_AES_128",
+		"BriefDescription": "KM ENCRYPTED AES 128",
+		"PublicDescription": "KM-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4107",
+		"EventName": "KM_ENCRYPTED_AES_192",
+		"BriefDescription": "KM ENCRYPTED AES 192",
+		"PublicDescription": "KM-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4108",
+		"EventName": "KM_ENCRYPTED_AES_256",
+		"BriefDescription": "KM ENCRYPTED AES 256",
+		"PublicDescription": "KM-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4109",
+		"EventName": "KM_XTS_AES_128",
+		"BriefDescription": "KM XTS AES 128",
+		"PublicDescription": "KM-XTS-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4110",
+		"EventName": "KM_XTS_AES_256",
+		"BriefDescription": "KM XTS AES 256",
+		"PublicDescription": "KM-XTS-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4111",
+		"EventName": "KM_XTS_ENCRYPTED_AES_128",
+		"BriefDescription": "KM XTS ENCRYPTED AES 128",
+		"PublicDescription": "KM-XTS-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4112",
+		"EventName": "KM_XTS_ENCRYPTED_AES_256",
+		"BriefDescription": "KM XTS ENCRYPTED AES 256",
+		"PublicDescription": "KM-XTS-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4113",
+		"EventName": "KMC_DEA",
+		"BriefDescription": "KMC DEA",
+		"PublicDescription": "KMC-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4114",
+		"EventName": "KMC_TDEA_128",
+		"BriefDescription": "KMC TDEA 128",
+		"PublicDescription": "KMC-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4115",
+		"EventName": "KMC_TDEA_192",
+		"BriefDescription": "KMC TDEA 192",
+		"PublicDescription": "KMC-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4116",
+		"EventName": "KMC_ENCRYPTED_DEA",
+		"BriefDescription": "KMC ENCRYPTED DEA",
+		"PublicDescription": "KMC-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4117",
+		"EventName": "KMC_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMC ENCRYPTED TDEA 128",
+		"PublicDescription": "KMC-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4118",
+		"EventName": "KMC_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMC ENCRYPTED TDEA 192",
+		"PublicDescription": "KMC-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4119",
+		"EventName": "KMC_AES_128",
+		"BriefDescription": "KMC AES 128",
+		"PublicDescription": "KMC-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4120",
+		"EventName": "KMC_AES_192",
+		"BriefDescription": "KMC AES 192",
+		"PublicDescription": "KMC-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4121",
+		"EventName": "KMC_AES_256",
+		"BriefDescription": "KMC AES 256",
+		"PublicDescription": "KMC-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4122",
+		"EventName": "KMC_ENCRYPTED_AES_128",
+		"BriefDescription": "KMC ENCRYPTED AES 128",
+		"PublicDescription": "KMC-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4123",
+		"EventName": "KMC_ENCRYPTED_AES_192",
+		"BriefDescription": "KMC ENCRYPTED AES 192",
+		"PublicDescription": "KMC-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4124",
+		"EventName": "KMC_ENCRYPTED_AES_256",
+		"BriefDescription": "KMC ENCRYPTED AES 256",
+		"PublicDescription": "KMC-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4125",
+		"EventName": "KMC_PRNG",
+		"BriefDescription": "KMC PRNG",
+		"PublicDescription": "KMC-PRNG function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4126",
+		"EventName": "KMA_GCM_AES_128",
+		"BriefDescription": "KMA GCM AES 128",
+		"PublicDescription": "KMA-GCM-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4127",
+		"EventName": "KMA_GCM_AES_192",
+		"BriefDescription": "KMA GCM AES 192",
+		"PublicDescription": "KMA-GCM-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4128",
+		"EventName": "KMA_GCM_AES_256",
+		"BriefDescription": "KMA GCM AES 256",
+		"PublicDescription": "KMA-GCM-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4129",
+		"EventName": "KMA_GCM_ENCRYPTED_AES_128",
+		"BriefDescription": "KMA GCM ENCRYPTED AES 128",
+		"PublicDescription": "KMA-GCM-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4130",
+		"EventName": "KMA_GCM_ENCRYPTED_AES_192",
+		"BriefDescription": "KMA GCM ENCRYPTED AES 192",
+		"PublicDescription": "KMA-GCM-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4131",
+		"EventName": "KMA_GCM_ENCRYPTED_AES_256",
+		"BriefDescription": "KMA GCM ENCRYPTED AES 256",
+		"PublicDescription": "KMA-GCM-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4132",
+		"EventName": "KMF_DEA",
+		"BriefDescription": "KMF DEA",
+		"PublicDescription": "KMF-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4133",
+		"EventName": "KMF_TDEA_128",
+		"BriefDescription": "KMF TDEA 128",
+		"PublicDescription": "KMF-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4134",
+		"EventName": "KMF_TDEA_192",
+		"BriefDescription": "KMF TDEA 192",
+		"PublicDescription": "KMF-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4135",
+		"EventName": "KMF_ENCRYPTED_DEA",
+		"BriefDescription": "KMF ENCRYPTED DEA",
+		"PublicDescription": "KMF-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4136",
+		"EventName": "KMF_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMF ENCRYPTED TDEA 128",
+		"PublicDescription": "KMF-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4137",
+		"EventName": "KMF_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMF ENCRYPTED TDEA 192",
+		"PublicDescription": "KMF-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4138",
+		"EventName": "KMF_AES_128",
+		"BriefDescription": "KMF AES 128",
+		"PublicDescription": "KMF-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4139",
+		"EventName": "KMF_AES_192",
+		"BriefDescription": "KMF AES 192",
+		"PublicDescription": "KMF-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4140",
+		"EventName": "KMF_AES_256",
+		"BriefDescription": "KMF AES 256",
+		"PublicDescription": "KMF-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4141",
+		"EventName": "KMF_ENCRYPTED_AES_128",
+		"BriefDescription": "KMF ENCRYPTED AES 128",
+		"PublicDescription": "KMF-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4142",
+		"EventName": "KMF_ENCRYPTED_AES_192",
+		"BriefDescription": "KMF ENCRYPTED AES 192",
+		"PublicDescription": "KMF-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4143",
+		"EventName": "KMF_ENCRYPTED_AES_256",
+		"BriefDescription": "KMF ENCRYPTED AES 256",
+		"PublicDescription": "KMF-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4144",
+		"EventName": "KMCTR_DEA",
+		"BriefDescription": "KMCTR DEA",
+		"PublicDescription": "KMCTR-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4145",
+		"EventName": "KMCTR_TDEA_128",
+		"BriefDescription": "KMCTR TDEA 128",
+		"PublicDescription": "KMCTR-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4146",
+		"EventName": "KMCTR_TDEA_192",
+		"BriefDescription": "KMCTR TDEA 192",
+		"PublicDescription": "KMCTR-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4147",
+		"EventName": "KMCTR_ENCRYPTED_DEA",
+		"BriefDescription": "KMCTR ENCRYPTED DEA",
+		"PublicDescription": "KMCTR-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4148",
+		"EventName": "KMCTR_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMCTR ENCRYPTED TDEA 128",
+		"PublicDescription": "KMCTR-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4149",
+		"EventName": "KMCTR_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMCTR ENCRYPTED TDEA 192",
+		"PublicDescription": "KMCTR-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4150",
+		"EventName": "KMCTR_AES_128",
+		"BriefDescription": "KMCTR AES 128",
+		"PublicDescription": "KMCTR-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4151",
+		"EventName": "KMCTR_AES_192",
+		"BriefDescription": "KMCTR AES 192",
+		"PublicDescription": "KMCTR-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4152",
+		"EventName": "KMCTR_AES_256",
+		"BriefDescription": "KMCTR AES 256",
+		"PublicDescription": "KMCTR-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4153",
+		"EventName": "KMCTR_ENCRYPTED_AES_128",
+		"BriefDescription": "KMCTR ENCRYPTED AES 128",
+		"PublicDescription": "KMCTR-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4154",
+		"EventName": "KMCTR_ENCRYPTED_AES_192",
+		"BriefDescription": "KMCTR ENCRYPTED AES 192",
+		"PublicDescription": "KMCTR-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4155",
+		"EventName": "KMCTR_ENCRYPTED_AES_256",
+		"BriefDescription": "KMCTR ENCRYPTED AES 256",
+		"PublicDescription": "KMCTR-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4156",
+		"EventName": "KMO_DEA",
+		"BriefDescription": "KMO DEA",
+		"PublicDescription": "KMO-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4157",
+		"EventName": "KMO_TDEA_128",
+		"BriefDescription": "KMO TDEA 128",
+		"PublicDescription": "KMO-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4158",
+		"EventName": "KMO_TDEA_192",
+		"BriefDescription": "KMO TDEA 192",
+		"PublicDescription": "KMO-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4159",
+		"EventName": "KMO_ENCRYPTED_DEA",
+		"BriefDescription": "KMO ENCRYPTED DEA",
+		"PublicDescription": "KMO-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4160",
+		"EventName": "KMO_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMO ENCRYPTED TDEA 128",
+		"PublicDescription": "KMO-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4161",
+		"EventName": "KMO_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMO ENCRYPTED TDEA 192",
+		"PublicDescription": "KMO-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4162",
+		"EventName": "KMO_AES_128",
+		"BriefDescription": "KMO AES 128",
+		"PublicDescription": "KMO-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4163",
+		"EventName": "KMO_AES_192",
+		"BriefDescription": "KMO AES 192",
+		"PublicDescription": "KMO-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4164",
+		"EventName": "KMO_AES_256",
+		"BriefDescription": "KMO AES 256",
+		"PublicDescription": "KMO-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4165",
+		"EventName": "KMO_ENCRYPTED_AES_128",
+		"BriefDescription": "KMO ENCRYPTED AES 128",
+		"PublicDescription": "KMO-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4166",
+		"EventName": "KMO_ENCRYPTED_AES_192",
+		"BriefDescription": "KMO ENCRYPTED AES 192",
+		"PublicDescription": "KMO-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4167",
+		"EventName": "KMO_ENCRYPTED_AES_256",
+		"BriefDescription": "KMO ENCRYPTED AES 256",
+		"PublicDescription": "KMO-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4168",
+		"EventName": "KIMD_SHA_1",
+		"BriefDescription": "KIMD SHA 1",
+		"PublicDescription": "KIMD-SHA-1 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4169",
+		"EventName": "KIMD_SHA_256",
+		"BriefDescription": "KIMD SHA 256",
+		"PublicDescription": "KIMD-SHA-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4170",
+		"EventName": "KIMD_SHA_512",
+		"BriefDescription": "KIMD SHA 512",
+		"PublicDescription": "KIMD-SHA-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4171",
+		"EventName": "KIMD_SHA3_224",
+		"BriefDescription": "KIMD SHA3 224",
+		"PublicDescription": "KIMD-SHA3-224 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4172",
+		"EventName": "KIMD_SHA3_256",
+		"BriefDescription": "KIMD SHA3 256",
+		"PublicDescription": "KIMD-SHA3-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4173",
+		"EventName": "KIMD_SHA3_384",
+		"BriefDescription": "KIMD SHA3 384",
+		"PublicDescription": "KIMD-SHA3-384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4174",
+		"EventName": "KIMD_SHA3_512",
+		"BriefDescription": "KIMD SHA3 512",
+		"PublicDescription": "KIMD-SHA3-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4175",
+		"EventName": "KIMD_SHAKE_128",
+		"BriefDescription": "KIMD SHAKE 128",
+		"PublicDescription": "KIMD-SHAKE-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4176",
+		"EventName": "KIMD_SHAKE_256",
+		"BriefDescription": "KIMD SHAKE 256",
+		"PublicDescription": "KIMD-SHAKE-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4177",
+		"EventName": "KIMD_GHASH",
+		"BriefDescription": "KIMD GHASH",
+		"PublicDescription": "KIMD-GHASH function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4178",
+		"EventName": "KLMD_SHA_1",
+		"BriefDescription": "KLMD SHA 1",
+		"PublicDescription": "KLMD-SHA-1 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4179",
+		"EventName": "KLMD_SHA_256",
+		"BriefDescription": "KLMD SHA 256",
+		"PublicDescription": "KLMD-SHA-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4180",
+		"EventName": "KLMD_SHA_512",
+		"BriefDescription": "KLMD SHA 512",
+		"PublicDescription": "KLMD-SHA-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4181",
+		"EventName": "KLMD_SHA3_224",
+		"BriefDescription": "KLMD SHA3 224",
+		"PublicDescription": "KLMD-SHA3-224 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4182",
+		"EventName": "KLMD_SHA3_256",
+		"BriefDescription": "KLMD SHA3 256",
+		"PublicDescription": "KLMD-SHA3-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4183",
+		"EventName": "KLMD_SHA3_384",
+		"BriefDescription": "KLMD SHA3 384",
+		"PublicDescription": "KLMD-SHA3-384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4184",
+		"EventName": "KLMD_SHA3_512",
+		"BriefDescription": "KLMD SHA3 512",
+		"PublicDescription": "KLMD-SHA3-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4185",
+		"EventName": "KLMD_SHAKE_128",
+		"BriefDescription": "KLMD SHAKE 128",
+		"PublicDescription": "KLMD-SHAKE-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4186",
+		"EventName": "KLMD_SHAKE_256",
+		"BriefDescription": "KLMD SHAKE 256",
+		"PublicDescription": "KLMD-SHAKE-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4187",
+		"EventName": "KMAC_DEA",
+		"BriefDescription": "KMAC DEA",
+		"PublicDescription": "KMAC-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4188",
+		"EventName": "KMAC_TDEA_128",
+		"BriefDescription": "KMAC TDEA 128",
+		"PublicDescription": "KMAC-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4189",
+		"EventName": "KMAC_TDEA_192",
+		"BriefDescription": "KMAC TDEA 192",
+		"PublicDescription": "KMAC-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4190",
+		"EventName": "KMAC_ENCRYPTED_DEA",
+		"BriefDescription": "KMAC ENCRYPTED DEA",
+		"PublicDescription": "KMAC-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4191",
+		"EventName": "KMAC_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMAC ENCRYPTED TDEA 128",
+		"PublicDescription": "KMAC-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4192",
+		"EventName": "KMAC_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMAC ENCRYPTED TDEA 192",
+		"PublicDescription": "KMAC-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4193",
+		"EventName": "KMAC_AES_128",
+		"BriefDescription": "KMAC AES 128",
+		"PublicDescription": "KMAC-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4194",
+		"EventName": "KMAC_AES_192",
+		"BriefDescription": "KMAC AES 192",
+		"PublicDescription": "KMAC-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4195",
+		"EventName": "KMAC_AES_256",
+		"BriefDescription": "KMAC AES 256",
+		"PublicDescription": "KMAC-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4196",
+		"EventName": "KMAC_ENCRYPTED_AES_128",
+		"BriefDescription": "KMAC ENCRYPTED AES 128",
+		"PublicDescription": "KMAC-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4197",
+		"EventName": "KMAC_ENCRYPTED_AES_192",
+		"BriefDescription": "KMAC ENCRYPTED AES 192",
+		"PublicDescription": "KMAC-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4198",
+		"EventName": "KMAC_ENCRYPTED_AES_256",
+		"BriefDescription": "KMAC ENCRYPTED AES 256",
+		"PublicDescription": "KMAC-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4199",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_DEA",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING DEA",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4200",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_TDEA_128",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING TDEA 128",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4201",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_TDEA_192",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING TDEA 192",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4202",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_DEA",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED DEA",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4203",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_TDEA_128",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED TDEA 128",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-TDEA- 128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4204",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_TDEA_192",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED TDEA 192",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-TDEA- 192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4205",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_AES_128",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING AES 128",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4206",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_AES_192",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING AES 192",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4207",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_AES_256",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING AES 256",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4208",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_128",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 128",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES- 128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4209",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_192",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 192",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES- 192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4210",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256A",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 256A",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES- 256A function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4211",
+		"EventName": "PCC_COMPUTE_XTS_PARAMETER_USING_AES_128",
+		"BriefDescription": "PCC COMPUTE XTS PARAMETER USING AES 128",
+		"PublicDescription": "PCC-Compute-XTS-Parameter-Using-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4212",
+		"EventName": "PCC_COMPUTE_XTS_PARAMETER_USING_AES_256",
+		"BriefDescription": "PCC COMPUTE XTS PARAMETER USING AES 256",
+		"PublicDescription": "PCC-Compute-XTS-Parameter-Using-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4213",
+		"EventName": "PCC_COMPUTE_XTS_PARAMETER_USING_ENCRYPTED_AES_128",
+		"BriefDescription": "PCC COMPUTE XTS PARAMETER USING ENCRYPTED AES 128",
+		"PublicDescription": "PCC-Compute-XTS-Parameter-Using-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4214",
+		"EventName": "PCC_COMPUTE_XTS_PARAMETER_USING_ENCRYPTED_AES_256",
+		"BriefDescription": "PCC COMPUTE XTS PARAMETER USING ENCRYPTED AES 256",
+		"PublicDescription": "PCC-Compute-XTS-Parameter-Using-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4215",
+		"EventName": "PCC_SCALAR_MULTIPLY_P256",
+		"BriefDescription": "PCC SCALAR MULTIPLY P256",
+		"PublicDescription": "PCC-Scalar-Multiply-P256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4216",
+		"EventName": "PCC_SCALAR_MULTIPLY_P384",
+		"BriefDescription": "PCC SCALAR MULTIPLY P384",
+		"PublicDescription": "PCC-Scalar-Multiply-P384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4217",
+		"EventName": "PCC_SCALAR_MULTIPLY_P521",
+		"BriefDescription": "PCC SCALAR MULTIPLY P521",
+		"PublicDescription": "PCC-Scalar-Multiply-P521 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4218",
+		"EventName": "PCC_SCALAR_MULTIPLY_ED25519",
+		"BriefDescription": "PCC SCALAR MULTIPLY ED25519",
+		"PublicDescription": "PCC-Scalar-Multiply-Ed25519 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4219",
+		"EventName": "PCC_SCALAR_MULTIPLY_ED448",
+		"BriefDescription": "PCC SCALAR MULTIPLY ED448",
+		"PublicDescription": "PCC-Scalar-Multiply-Ed448 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4220",
+		"EventName": "PCC_SCALAR_MULTIPLY_X25519",
+		"BriefDescription": "PCC SCALAR MULTIPLY X25519",
+		"PublicDescription": "PCC-Scalar-Multiply-X25519 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4221",
+		"EventName": "PCC_SCALAR_MULTIPLY_X448",
+		"BriefDescription": "PCC SCALAR MULTIPLY X448",
+		"PublicDescription": "PCC-Scalar-Multiply-X448 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4222",
+		"EventName": "PRNO_SHA_512_DRNG",
+		"BriefDescription": "PRNO SHA 512 DRNG",
+		"PublicDescription": "PRNO-SHA-512-DRNG function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4223",
+		"EventName": "PRNO_TRNG_QUERY_RAW_TO_CONDITIONED_RATIO",
+		"BriefDescription": "PRNO TRNG QUERY RAW TO CONDITIONED RATIO",
+		"PublicDescription": "PRNO-TRNG-Query-Raw-to-Conditioned-Ratio function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4224",
+		"EventName": "PRNO_TRNG",
+		"BriefDescription": "PRNO TRNG",
+		"PublicDescription": "PRNO-TRNG function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4225",
+		"EventName": "KDSA_ECDSA_VERIFY_P256",
+		"BriefDescription": "KDSA ECDSA VERIFY P256",
+		"PublicDescription": "KDSA-ECDSA-Verify-P256 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4226",
+		"EventName": "KDSA_ECDSA_VERIFY_P384",
+		"BriefDescription": "KDSA ECDSA VERIFY P384",
+		"PublicDescription": "KDSA-ECDSA-Verify-P384 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4227",
+		"EventName": "KDSA_ECDSA_VERIFY_P521",
+		"BriefDescription": "KDSA ECDSA VERIFY P521",
+		"PublicDescription": "KDSA-ECDSA-Verify-P521 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4228",
+		"EventName": "KDSA_ECDSA_SIGN_P256",
+		"BriefDescription": "KDSA ECDSA SIGN P256",
+		"PublicDescription": "KDSA-ECDSA-Sign-P256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4229",
+		"EventName": "KDSA_ECDSA_SIGN_P384",
+		"BriefDescription": "KDSA ECDSA SIGN P384",
+		"PublicDescription": "KDSA-ECDSA-Sign-P384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4230",
+		"EventName": "KDSA_ECDSA_SIGN_P521",
+		"BriefDescription": "KDSA ECDSA SIGN P521",
+		"PublicDescription": "KDSA-ECDSA-Sign-P521 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4231",
+		"EventName": "KDSA_ENCRYPTED_ECDSA_SIGN_P256",
+		"BriefDescription": "KDSA ENCRYPTED ECDSA SIGN P256",
+		"PublicDescription": "KDSA-Encrypted-ECDSA-Sign-P256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4232",
+		"EventName": "KDSA_ENCRYPTED_ECDSA_SIGN_P384",
+		"BriefDescription": "KDSA ENCRYPTED ECDSA SIGN P384",
+		"PublicDescription": "KDSA-Encrypted-ECDSA-Sign-P384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4233",
+		"EventName": "KDSA_ENCRYPTED_ECDSA_SIGN_P521",
+		"BriefDescription": "KDSA ENCRYPTED ECDSA SIGN P521",
+		"PublicDescription": "KDSA-Encrypted-ECDSA-Sign-P521 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4234",
+		"EventName": "KDSA_EDDSA_VERIFY_ED25519",
+		"BriefDescription": "KDSA EDDSA VERIFY ED25519",
+		"PublicDescription": "KDSA-EdDSA-Verify-Ed25519 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4235",
+		"EventName": "KDSA_EDDSA_VERIFY_ED448",
+		"BriefDescription": "KDSA EDDSA VERIFY ED448",
+		"PublicDescription": "KDSA-EdDSA-Verify-Ed448 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4236",
+		"EventName": "KDSA_EDDSA_SIGN_ED25519",
+		"BriefDescription": "KDSA EDDSA SIGN ED25519",
+		"PublicDescription": "KDSA-EdDSA-Sign-Ed25519 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4237",
+		"EventName": "KDSA_EDDSA_SIGN_ED448",
+		"BriefDescription": "KDSA EDDSA SIGN ED448",
+		"PublicDescription": "KDSA-EdDSA-Sign-Ed448 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4238",
+		"EventName": "KDSA_ENCRYPTED_EDDSA_SIGN_ED25519",
+		"BriefDescription": "KDSA ENCRYPTED EDDSA SIGN ED25519",
+		"PublicDescription": "KDSA-Encrypted-EdDSA-Sign-Ed25519 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4239",
+		"EventName": "KDSA_ENCRYPTED_EDDSA_SIGN_ED448",
+		"BriefDescription": "KDSA ENCRYPTED EDDSA SIGN ED448",
+		"PublicDescription": "KDSA-Encrypted-EdDSA-Sign-Ed448 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4240",
+		"EventName": "PCKMO_ENCRYPT_DEA_KEY",
+		"BriefDescription": "PCKMO ENCRYPT DEA KEY",
+		"PublicDescription": "PCKMO-Encrypt-DEA-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4241",
+		"EventName": "PCKMO_ENCRYPT_TDEA_128_KEY",
+		"BriefDescription": "PCKMO ENCRYPT TDEA 128 KEY",
+		"PublicDescription": "PCKMO-Encrypt-TDEA-128-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4242",
+		"EventName": "PCKMO_ENCRYPT_TDEA_192_KEY",
+		"BriefDescription": "PCKMO ENCRYPT TDEA 192 KEY",
+		"PublicDescription": "PCKMO-Encrypt-TDEA-192-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4243",
+		"EventName": "PCKMO_ENCRYPT_AES_128_KEY",
+		"BriefDescription": "PCKMO ENCRYPT AES 128 KEY",
+		"PublicDescription": "PCKMO-Encrypt-AES-128-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4244",
+		"EventName": "PCKMO_ENCRYPT_AES_192_KEY",
+		"BriefDescription": "PCKMO ENCRYPT AES 192 KEY",
+		"PublicDescription": "PCKMO-Encrypt-AES-192-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4245",
+		"EventName": "PCKMO_ENCRYPT_AES_256_KEY",
+		"BriefDescription": "PCKMO ENCRYPT AES 256 KEY",
+		"PublicDescription": "PCKMO-Encrypt-AES-256-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4246",
+		"EventName": "PCKMO_ENCRYPT_ECC_P256_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC P256 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-P256-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4247",
+		"EventName": "PCKMO_ENCRYPT_ECC_P384_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC P384 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-P384-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4248",
+		"EventName": "PCKMO_ENCRYPT_ECC_P521_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC P521 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-P521-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4249",
+		"EventName": "PCKMO_ENCRYPT_ECC_ED25519_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC ED25519 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-Ed25519-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4250",
+		"EventName": "PCKMO_ENCRYPT_ECC_ED448_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC ED448 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-Ed448-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4251",
+		"EventName": "IBM_RESERVED_155",
+		"BriefDescription": "IBM RESERVED_155",
+		"PublicDescription": "Reserved for IBM use"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4252",
+		"EventName": "IBM_RESERVED_156",
+		"BriefDescription": "IBM RESERVED_156",
+		"PublicDescription": "Reserved for IBM use"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 83e0dcbeac9a..7386c718f7cf 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -108,6 +108,7 @@ class JsonEvent:
           'iMPH-U': 'uncore_arb',
           'CPU-M-CF': 'cpum_cf',
           'CPU-M-SF': 'cpum_sf',
+          'PAI-CRYPTO' : 'pai_crypto',
           'UPI LL': 'uncore_upi',
           'hisi_sicl,cpa': 'hisi_sicl,cpa',
           'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
-- 
2.36.1

