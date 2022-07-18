Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B0578402
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiGRNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiGRNmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:42:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79180205F8;
        Mon, 18 Jul 2022 06:42:00 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IDN1je031402;
        Mon, 18 Jul 2022 13:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FPy+DYCthLkQP4vs5sUDtj7RP5kqgPiS+tdgo1D1oxE=;
 b=FVCYPaWGIhoxvHw2hTxYlsxV5sWSNhb6jCd+Jy8Ol8Z8tOYIO0tP2XrSoMubKzLvBCSU
 H0wAwLK+l/1cHqN93YNKJbNl6X2Xh0jyvW8KnL7rxMtEwsNeOtLndgB9SueULFxrFqxp
 V6KYtGwgtE7Kky/wDojhTSUFWfXUI0YE15wLglHBcpjmr78ojbnZdTlJYV3HPrdwEL/C
 /f05rBuTeMRI/lygV5/vziUH7NP4jV8l/K0315RZFcLj4ymXKblbNdvsFJTFsUTloT9b
 OU7UCctyACy2SZA17yJEku7N/bu0tJXofohQFC+ax/UKVNpKfYleSvAxLH71UvCqgu+u Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd8bw0upn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:53 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26IDPxpu011600;
        Mon, 18 Jul 2022 13:41:40 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd8bw0u3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:40 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26IDKQF8004421;
        Mon, 18 Jul 2022 13:41:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3hbmy8j1ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 13:41:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26IDfNok18874710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:41:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EA8411C069;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CD3811C064;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jul 2022 13:41:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 6DE64E01D7; Mon, 18 Jul 2022 15:32:41 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 0/3] s390/crash: support multi-segment iterators
Date:   Mon, 18 Jul 2022 15:32:38 +0200
Message-Id: <cover.1658148067.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3QtOpRPL_YcJt0TJb1QrmJDg6qiPeZVb
X-Proofpoint-ORIG-GUID: M3jVHJ3tNiOSDZM-P796BAXY_X_xJWEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207180058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew et al,

This series completes 5d8de293c224 ("vmcore: convert copy_oldmem_page() to
take an iov_iter") for s390.

@Matthew,
  Please, let me know if you are not okay with Suggested-by tag in patch 3.

Changes since v2:
  - Matthew Wilcox suggestion is adopted, with that...
  - copy_to_iter() is used instead of custom implementation;

Changes since v1:
  - number of bytes left to copy on fail fixed;

Thanks!

Alexander Gordeev (3):
  s390/crash: move copy_to_user_real() to crash_dump.c
  s390/crash: use static swap buffer for copy_to_user_real()
  s390/crash: support multi-segment iterators

 arch/s390/include/asm/os_info.h |  17 ++++-
 arch/s390/include/asm/sclp.h    |   4 +-
 arch/s390/include/asm/uaccess.h |   1 -
 arch/s390/kernel/crash_dump.c   | 111 +++++++-------------------------
 arch/s390/mm/maccess.c          |  26 --------
 drivers/s390/char/zcore.c       |  59 +++++++----------
 6 files changed, 65 insertions(+), 153 deletions(-)

-- 
2.34.1

