Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6726158C7E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbiHHLvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243134AbiHHLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:51:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93995B77
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:50:47 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ADwlD008506;
        Mon, 8 Aug 2022 11:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SPisgbWwVC36xWFC1Y+Lad3WGhuSCgF3pMHsh6edFtk=;
 b=ghXvSWfNpVcqmJ3Fm6p63M8t1GnL47meyZQ72FgmjTEx5jAN372J6dRH4EjeFOaWRGz+
 PVozb30fmh+lwiggxn/6ZZ6gDexMiof+XtcZIoiDtA4IJWzHEFzMkLwDccoHoNyEYnCM
 XoXaOGvgLjHI5iEVBR3aBa4DKngV5fjvykP9SVc4F8pz7NBKHn+KHqWPTXLSEl8h5yHd
 6h6v+X/QGG/+35UoKTpjnq5zwVusZat1Cy0xe0KTZUjF3v1YgTLrEVUf5jkSnwStVvZG
 UEgVIWoGTmUlK3ZS3CoxxA0n74K+kP+IvK/PjMzDCzyO5BRD8L/yWz9SnLF5u7i8kTUa sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu0j3afwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:27 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 278BaEuo016099;
        Mon, 8 Aug 2022 11:50:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hu0j3afvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 278BoOOT016270;
        Mon, 8 Aug 2022 11:50:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3hsfx8t4bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 11:50:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 278BoMEH26411446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 11:50:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CF8411C04C;
        Mon,  8 Aug 2022 11:50:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C38F11C04A;
        Mon,  8 Aug 2022 11:50:18 +0000 (GMT)
Received: from li-c3569c4c-1ef8-11b2-a85c-ee139cda3133.ibm.com.com (unknown [9.43.59.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 11:50:18 +0000 (GMT)
From:   Sathvika Vasireddy <sv@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: [PATCH 12/16] objtool: Read special sections with alts only when specific options are selected
Date:   Mon,  8 Aug 2022 17:19:04 +0530
Message-Id: <20220808114908.240813-13-sv@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220808114908.240813-1-sv@linux.ibm.com>
References: <20220808114908.240813-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yM5TLd6QT8IEdvSZu6jgyz39Reg4J_Ts
X-Proofpoint-ORIG-GUID: oC3pqsA54xT4-EnBkfcKVfvKUtqAdqUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_08,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2208080057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reads special sections which have alternate
instructions, only when stackval or orc or uaccess or
noinstr options are passed to objtool.

Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
---
 tools/objtool/check.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1216a0fceaba..36f367da4752 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2370,9 +2370,11 @@ static int decode_sections(struct objtool_file *file)
 	 * Must be before add_jump_destinations(), which depends on 'func'
 	 * being set for alternatives, to enable proper sibling call detection.
 	 */
-	ret = add_special_section_alts(file);
-	if (ret)
-		return ret;
+	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr) {
+		ret = add_special_section_alts(file);
+		if (ret)
+			return ret;
+	}
 
 	ret = add_jump_destinations(file);
 	if (ret)
-- 
2.31.1

