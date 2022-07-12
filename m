Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC69571786
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiGLKp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGLKp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:45:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9F5AD879;
        Tue, 12 Jul 2022 03:45:56 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CAhB6p026384;
        Tue, 12 Jul 2022 10:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=moa9v0DPAqYqbaHqt5FoLScyi4YMCELdoQ0BpuluAzk=;
 b=CTJkPoEnjD82mh1Om25UM3nJseag/1ojrLQCmLo0ooIYU5w8Fz9CMxOHH8mUeU85/Rfh
 8nmV6WuAbLqkT6dVxiCqRtq9Q+BLmYPJuCV44aL3hFXGDgaSoech3ici31MDbXGLUc7v
 53SOwIZ5Z+dYN4RNMHehs7xJOqcUxX5y8smHxb0b8mn6HQgnjIjRNRWgPXG0FvFIm6p9
 V7b1KA4gHUQgebZx7ErgGlypNQvLecZ++oO+t2LrM90UqnqZTQwmYVkCimk0F8ozym4g
 7auO0S8lAhSBimGDhk9UgH1PHhVwYwosJ4IRmP0xVh0moUz0RytHSea76DUuMM0oclmS /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h94wf4fu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:45:54 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26CATGVb008295;
        Tue, 12 Jul 2022 10:45:54 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h94wf4ftv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:45:54 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CAapcG012120;
        Tue, 12 Jul 2022 10:45:53 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 3h71a9tcc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:45:53 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CAjqnF6226548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 10:45:52 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A45ABAC05F;
        Tue, 12 Jul 2022 10:45:52 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C2EBAC05B;
        Tue, 12 Jul 2022 10:45:52 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 10:45:52 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-doc@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: siphash: Fix typo in the name of offsetofend macro
Date:   Tue, 12 Jul 2022 10:44:55 +0000
Message-Id: <20220712104455.1408150-1-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jhl3QEua3AWARSZK74ikH1GMBdqqvKgq
X-Proofpoint-ORIG-GUID: vNJNBBy_-KzZM-OsuoR89l9B3HH7KbpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_05,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 mlxlogscore=800 priorityscore=1501
 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The siphash documentation misspelled "offsetendof" instead of
"offsetofend".

Fixes: 2c956a60778cbb ("siphash: add cryptographically secure PRF")
Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 Documentation/security/siphash.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/siphash.rst b/Documentation/security/siphash.rst
index a10380cb78e5..023bd95c74a5 100644
--- a/Documentation/security/siphash.rst
+++ b/Documentation/security/siphash.rst
@@ -85,7 +85,7 @@ Often times the XuY functions will not be large enough, and instead you'll
 want to pass a pre-filled struct to siphash. When doing this, it's important
 to always ensure the struct has no padding holes. The easiest way to do this
 is to simply arrange the members of the struct in descending order of size,
-and to use offsetendof() instead of sizeof() for getting the size. For
+and to use offsetofend() instead of sizeof() for getting the size. For
 performance reasons, if possible, it's probably a good thing to align the
 struct to the right boundary. Here's an example::
 
-- 
2.25.1

