Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA8569A29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiGGGBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiGGGBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:01:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A90931939;
        Wed,  6 Jul 2022 23:01:30 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2673E4b7030395;
        Thu, 7 Jul 2022 06:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=71+kH/CtjTUCNfcDn+NS9jAFVfSPvoTRId7bBbYcrro=;
 b=PT+2ipuHsC+h0TS+YeFUXoyMKapHbsls0zfEVjbsz5OwhKH4R15nvuEVSnFmvUu6gMLQ
 r4K6WbAt82lSsowPDBz87XvzhcjUbnnFy2JSH0Tjbyi/m1UFwzSbKtlmwyT/Ye/GIPZc
 z4mgFu6TAu+VeiISBcA44s3XKfc1iDmJN8AIEBnrcru4GXNruXM7YezixMfmVwP/pVFV
 27/a2l+uny5KaWvK9O5WJzGByq4ZUw8EZmijb2aLOiGDlhuy148lPM6/cWKTFR+EIGtE
 fm0+OR0BIfLj2JTyjnEzQ2PfHolFIvgRFIcMyW382igkXZ9eDf+A47OeeRxzNmeGb9LT sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5magfh68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 06:01:21 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2675oUZP006091;
        Thu, 7 Jul 2022 06:01:21 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5magfh5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 06:01:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2675q0NF030038;
        Thu, 7 Jul 2022 06:01:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3h4usd23dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 06:01:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26761GBH22151638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 06:01:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7485A405B;
        Thu,  7 Jul 2022 06:01:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5475A4064;
        Thu,  7 Jul 2022 06:01:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Jul 2022 06:01:15 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 9746FE0231; Thu,  7 Jul 2022 08:01:15 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 0/1] s390/crash: allow multi-segment iterators
Date:   Thu,  7 Jul 2022 08:01:14 +0200
Message-Id: <cover.1657172539.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z6aApccoeqk47JGsObnhzZlzLTlZlQpN
X-Proofpoint-GUID: KZ2R2RWF57IQwEjIhsTM-hjGdc7aW8Sc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 mlxlogscore=812 mlxscore=0 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other architectures s390 can not use copyout() and memcopy() for
accessing memory and thus using copy_to_iter() now is not possible. But
a fix is needed, since 'cp' routine as 'core_collector' for kdump service
initiates multi-segment iterator.

The reason iterate_iovec() and __iterate_and_advance() macros copied from
lib/iov_iter.c (thus introducing redundancy) is to avoid custom iterator-
treating in s390 code. I doubt these macros could be turned public (i.e
with a follow-up patch), so the intention is to do it like _copy_to_iter()
does.

Changes since v1:
  - number of bytes left to copy on fail fixed;

Alexander Gordeev (1):
  s390/crash: allow multi-segment iterators

 arch/s390/kernel/crash_dump.c | 65 +++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 15 deletions(-)

-- 
2.34.1

