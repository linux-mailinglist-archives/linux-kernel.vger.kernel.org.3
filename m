Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811355822F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiG0JV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiG0JVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:21:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF541AF;
        Wed, 27 Jul 2022 02:21:25 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R9G0QW011970;
        Wed, 27 Jul 2022 09:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9WVbCnO6TDYhf5XWN6+VnSHbQoj/Tr12da+Y8xsuexo=;
 b=TLYPhW955AVqXuONnWidbXmDd4pkhIuz5Kexdz8QCKrOnCTWIG/qlnrpzCt+fQmJuST6
 31qL5/Dw1HweB0nUbwtJd+4zBfJ4JB9vPoa0uwZMkpjvRvkSKwsrbi1TIkXtbPeNPz8Z
 b/+T2jdiKlwavHvskH6qCkGolDbnWyGwh8JBCuf88X3mdvQ04ph6A5k0RIieiowq30GS
 fHXjthzaHoQDyiKMjj9Ziguub2bqYtehdoKgk5x4XZYkpHncsqvz3CrJzun5IxYfMocu
 b91MieFMgH0XzHdYqiiV4eFMRNETdT3IYlrF8Wi/MdR0HYxKOtzaCl+UPIbE6AdkWzsu FQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hk2k3g4qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 09:21:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26R9K6Na007976;
        Wed, 27 Jul 2022 09:21:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3hg95ybns2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 09:21:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26R9LPPO32112952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 09:21:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 088CC4C044;
        Wed, 27 Jul 2022 09:21:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8A9D4C04A;
        Wed, 27 Jul 2022 09:21:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.87.150])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jul 2022 09:21:10 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-next@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>
Subject: [PATCH] watchdog: Fix build error when CONFIG_SOFTLOCKUP_DETECTOR is not set
Date:   Wed, 27 Jul 2022 11:21:09 +0200
Message-Id: <20220727092109.31362-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Icyg8G4lulj4I2VcU8rr3Ikb1xmzrZeF
X-Proofpoint-GUID: Icyg8G4lulj4I2VcU8rr3Ikb1xmzrZeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sachin reported the following build error when CONFIG_SOFTLOCKUP_DETECTOR
is not set:

kernel/watchdog.c:597:20: error: static declaration of 'lockup_detector_reconfigure' follows non-static declaration
 static inline void lockup_detector_reconfigure(void)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from kernel/watchdog.c:17:
./include/linux/nmi.h:125:6: note: previous declaration of 'lockup_detector_reconfigure' was here
 void lockup_detector_reconfigure(void);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~

The definition of lockup_detector_reconfigure should be exported even in
that case, and __lockup_detector_reconfigure should remain static.

Fixes: 24a1260705b7 ("watchdog: export lockup_detector_reconfigure")
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 kernel/watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 90e6c41d5e33..41596c415111 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -590,7 +590,7 @@ static __init void lockup_detector_setup(void)
 }
 
 #else /* CONFIG_SOFTLOCKUP_DETECTOR */
-void __lockup_detector_reconfigure(void)
+static void __lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
 	watchdog_nmi_stop();
@@ -598,7 +598,7 @@ void __lockup_detector_reconfigure(void)
 	watchdog_nmi_start();
 	cpus_read_unlock();
 }
-static inline void lockup_detector_reconfigure(void)
+void lockup_detector_reconfigure(void)
 {
 	__lockup_detector_reconfigure();
 }
-- 
2.37.1

