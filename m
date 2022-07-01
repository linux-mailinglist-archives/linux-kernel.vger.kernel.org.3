Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553F15630E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiGAKCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiGAKCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:02:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA7D7390F;
        Fri,  1 Jul 2022 03:02:19 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2618mOmi004570;
        Fri, 1 Jul 2022 10:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=tlFH5SZ0JRLCgKOvdvAOo/NW7dAYuqoCdpK0JG6IhQQ=;
 b=omQqgtyO3YiZmdeoShfNizj03VQJMMirnPM+aJYtpWZex3TYTUt8zCkBMKehSyyEFrgN
 L3WFyNDwud15aTR0M2C1xP8C6dsVz+tUGGbImcOEOLfY5liWuOuMxBB5DZHEtkF1o79F
 Mf8qgksyk0IReFmP/f1Pd/Fb40kwbykAzivHxLgQLR1RoZVKYS8kr0kz+4AS67P/6DlO
 Ou5UA8/T56yEkE8nWLbQXOfZeggLpWnski1SmCgXDflb1+TQ+YZw2lSZMdwWEl06kAX6
 qlu4gXs8vpVmvg/TL7CSDWGCzUf4cWjJ2x4oC1TaOpO0WwVsWqVhasDDeIvfMtGNkcDn uQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1wr3t209-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 10:02:17 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2619pIGT011328;
        Fri, 1 Jul 2022 10:02:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3gwsmhy4es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 10:02:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 261A2C6r21627360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 10:02:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5771AAE045;
        Fri,  1 Jul 2022 10:02:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49AC8AE04D;
        Fri,  1 Jul 2022 10:02:11 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 10:02:11 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH 0/2] s390: Autoload uvdevice module based on CPU feature
Date:   Fri,  1 Jul 2022 12:02:08 +0200
Message-Id: <20220701100210.5482-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D9j0uXnVXkJXdnPHltQzj_xFbQg1EXDh
X-Proofpoint-ORIG-GUID: D9j0uXnVXkJXdnPHltQzj_xFbQg1EXDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=948 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the uvdevice (drivers/s390/char/uvdevice) must be loaded
manually. We can, however, determine if the Ultravisor is available
by observing facility 158. 

This series, first, introduces the HWCAP_UV connected to facility 158.
And, second, it automatically loads the uvdevice if HWCAP_UV is present.

Steffen Eiden (2):
  s390/hwcaps: Add HWCAP_UV
  drivers/s390/char/uvdevice: Autoload module based on CPU feature

 arch/s390/include/asm/elf.h  | 2 ++
 arch/s390/kernel/processor.c | 5 +++++
 drivers/s390/char/uvdevice.c | 5 ++---
 3 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.35.3

