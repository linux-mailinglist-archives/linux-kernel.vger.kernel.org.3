Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900FD567E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiGFGAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGFGAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:00:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6707612AA2;
        Tue,  5 Jul 2022 23:00:08 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2665M1FO008640;
        Wed, 6 Jul 2022 05:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Z0gnX5GACyaXo2gCTjfG5TGcxwQShY+PJz4Yjnuvfxc=;
 b=B2gF9rMEqfzn6JQ5CT01N4t5o9UxkaPRH/ydAPbL6RHVQAXibScE6uwRigeiP+pPGsOk
 LiHM4H2KH7IQmbCT8oqblY0KN69JneXdPnH4rsJSNgV05gy7vv+zyFbc98/f5Ry/zpKO
 BtvVMgBGQEQ/0QlEGmtOPpCeT+4+4HV0/rfbuIcM2POVdBrluG7PJjFB68eidjd/xa2C
 oYtlniuQJ3fWvmtDL89xM5+YerEzxtk1lJGKgYIbPTSNJi54Wy7FtzvliPr8sRdP+7X9
 QjIAeuiLYlH/L0136sMRXMtCY15+mhoJAv1AdGS2oicUqpZH1PpOEhLdcPSzyQjSCpdY xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5464rqbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 05:59:40 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2665tcwn012614;
        Wed, 6 Jul 2022 05:59:40 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5464rqas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 05:59:39 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2665ogH1016701;
        Wed, 6 Jul 2022 05:59:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3h4uk98cj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 05:59:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2665wILE23920968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 05:58:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A14952051;
        Wed,  6 Jul 2022 05:59:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 28D9752050;
        Wed,  6 Jul 2022 05:59:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id D3A7CE02F0; Wed,  6 Jul 2022 07:59:33 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 0/1] s390/crash: allow multi-segment iterators
Date:   Wed,  6 Jul 2022 07:59:32 +0200
Message-Id: <cover.1657049033.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F4AA8XjICDUsjH6tYILSIp6gucGQwLLh
X-Proofpoint-ORIG-GUID: 9QXDJuSRpsiSNuci3y_ANua_jUp2Bg8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_02,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 mlxlogscore=868 spamscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060020
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

Alexander Gordeev (1):
  s390/crash: allow multi-segment iterators

 arch/s390/kernel/crash_dump.c | 65 +++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 15 deletions(-)

-- 
2.34.1

