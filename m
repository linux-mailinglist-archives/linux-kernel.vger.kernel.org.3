Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F757926D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiGSF0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiGSF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:26:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D52408F;
        Mon, 18 Jul 2022 22:26:39 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J4MrwI030932;
        Tue, 19 Jul 2022 05:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0JvF+b2n50QUqkXrDKutgItVCcu3h52DXxUvQYdaCrQ=;
 b=g5ulYKEGE8SQjcERPKwn8D5HeDOzx+yhE1gujixV94UTeEnqQ7h/nEzczhepLuctUSpt
 jBlez//hS8ApuBChBb14PxA3vRi9Pl4giGEZSO8n4fkdW5I6OFFygEt+rt0E4B0LS6z5
 QpFcaffCUpSLf5TT59KW7QO1bzQCAuufizooF5x6wkvzp3Xzkfm06krSvjgQFwSXtIxo
 l2GwPJOBE65LVGJxTFl4Vhilr/2fDlfduDraLZK8gAC/eTlKbTi0wg1axM5u5LTuAjll
 CtSWSuhq3OvbJdVwCQJBxP1cdTOdLGT3xlw8mU8Xz5qmtHAl1Ve50K09+2/Fo0PL1l7I wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdnhnh6pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:32 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26J5IOo0001919;
        Tue, 19 Jul 2022 05:26:31 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hdnhnh6p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:31 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26J5L98C018328;
        Tue, 19 Jul 2022 05:26:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3hbmy8um9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 05:26:29 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26J5QQvQ21102942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 05:26:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 019AA11C052;
        Tue, 19 Jul 2022 05:26:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E243911C04A;
        Tue, 19 Jul 2022 05:26:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jul 2022 05:26:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 7A8D6E030C; Tue, 19 Jul 2022 07:16:36 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 0/4] s390/crash: support multi-segment iterators
Date:   Tue, 19 Jul 2022 07:16:32 +0200
Message-Id: <cover.1658206891.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yLy2WMCrGRAomVNcJlSIXCYmokO49dS4
X-Proofpoint-ORIG-GUID: B_Y5-4UxfKz3InkKrg77OC5wi8oS8ZAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=932 mlxscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew et al,

This series completes 5d8de293c224 ("vmcore: convert copy_oldmem_page()
to take an iov_iter") for s390.

Changes since v3:
  - concurrent access to HSA and oldmem swap buffers protected;

Changes since v2:
  - Matthew Wilcox suggestion is adopted, with that...
  - copy_to_iter() is used instead of custom implementation;

Changes since v1:
  - number of bytes left to copy on fail fixed;

Thanks!


Alexander Gordeev (4):
  s390/zcore: fix race when reading from hardware system area
  s390/crash: move copy_to_user_real() to crash_dump.c
  s390/crash: use static swap buffer for copy_to_user_real()
  s390/crash: support multi-segment iterators

 arch/s390/include/asm/os_info.h |  17 ++++-
 arch/s390/include/asm/sclp.h    |   4 +-
 arch/s390/include/asm/uaccess.h |   1 -
 arch/s390/kernel/crash_dump.c   | 114 ++++++++------------------------
 arch/s390/mm/maccess.c          |  26 --------
 drivers/s390/char/zcore.c       |  55 ++++++++-------
 6 files changed, 71 insertions(+), 146 deletions(-)

-- 
2.34.1

