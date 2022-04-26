Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B392510231
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352567AbiDZPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352550AbiDZPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:53:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C9B140CB;
        Tue, 26 Apr 2022 08:50:23 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QF764I028624;
        Tue, 26 Apr 2022 15:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QRtic6C4MllCJbNujlUQhPMgQ31u/k422BjvVmM/Z/k=;
 b=KSAsz3N4cQsP4eE5axc7gZfV0EtmQMZ46ILkQB3jOmFzDPeCCF9kDVtaQdEjA+A4SrS/
 C1OCR7gDLwdgqumTWtB7St/+1OzvUFnCjgEZ/mzZl9+SYZ4SsQmeeA1PNtr1HWgHD6Gx
 ENSejAnllIrjmEiyFS76fAtZmBp8Nhtr56rTPhv/HWBHiGYDxZWgPO5+l78MQvwDxa1K
 lXPImO3fCpNxO7WAW2BvXvPjgtKeYxGTXkuYGw2FzU73mQO1RGkQGtVvd/lzm2nS+6Bb
 0etZkbwab/WyWXOAgaye29+6iaPe+FJCmd7TPue+PiPFAJBPSpLF6kKRTwZDsrG9rXfG wQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fphea3m76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 15:49:59 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QFgVsP031580;
        Tue, 26 Apr 2022 15:49:58 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 3fm939ufu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 15:49:58 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QFnv7Q38863208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:49:57 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53A2FBE059;
        Tue, 26 Apr 2022 15:49:57 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEC49BE053;
        Tue, 26 Apr 2022 15:49:56 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.82.59])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 15:49:56 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, joel@jms.id.au,
        jk@ozlabs.org, David.Laight@ACULAB.COM
Subject: [PATCH v2 0/2] fsi and hwmon (occ): Prevent occasional checksum failures
Date:   Tue, 26 Apr 2022 10:49:54 -0500
Message-Id: <20220426154956.27205-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CRLahnghCqWE2g304Iae6uFt_RxvTshw
X-Proofpoint-ORIG-GUID: CRLahnghCqWE2g304Iae6uFt_RxvTshw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_04,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=794 mlxscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the OCC communication design with a shared SRAM area,
checkum errors are expected due to corrupted buffer from OCC
communications with other system components. Therefore, use a
unique errno for checksum failures and retry the command twice
in that case.

Changes since v1:
 - Refactor the retry loop

Eddie James (2):
  fsi: occ: Fix checksum failure mode
  hwmon (occ): Retry for checksum failure

 drivers/fsi/fsi-occ.c      |  7 +++++--
 drivers/hwmon/occ/p9_sbe.c | 15 +++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.27.0

