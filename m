Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D84E2C58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350327AbiCUPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350390AbiCUPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:33:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77320169798;
        Mon, 21 Mar 2022 08:31:49 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LCcr3N002576;
        Mon, 21 Mar 2022 15:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=j672nln5CbyRKxNf6ezAqa0EiQ4l+vPrR3zPPLrfIT0=;
 b=KxniCuU1+R4lNGhNtOBA9uenObNWlTAgdIbk26VJwJpF1ISEJ82GvEjRedBS7Rj6vdvo
 4AY3LX427ozfWhsclzORtDncZ5FUB3UjptvNEEGEcf5Xn0WfcWNQqhyfgjtCMgBg1CiX
 RKz+NW6Tl+U/LrYsgOlt5ALe0P9m32rHvuI5jpc49XovlnGwrxnX1gjT5pJXKXSmcDqq
 k2BInMU7xVZVPQzKm8yFCw3xd+9fErx7Vwh7xyytAEmOG82XhqYHZTB5v3/cRlLhePib
 m1Dk0n21NBFCGGtjx/TcEYohfFFM1yTcpMuD6V4M5pj/yxopI4tzBl6BWZL0DiUly8bj 9g== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3expy0f67t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 15:31:19 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22LFRM6c019122;
        Mon, 21 Mar 2022 15:31:18 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 3ew6t96804-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 15:31:18 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22LFVHiA12845538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 15:31:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47034C605B;
        Mon, 21 Mar 2022 15:31:17 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC362C6055;
        Mon, 21 Mar 2022 15:31:16 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.47.134])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Mar 2022 15:31:16 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, joel@jms.id.au,
        jk@ozlabs.org, alistair@popple.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] fsi and hwmon (occ): Prevent occasional checksum failures
Date:   Mon, 21 Mar 2022 10:31:10 -0500
Message-Id: <20220321153112.12199-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SYIRL_syCVTsGlItUybE74VWBN5ObQ6h
X-Proofpoint-GUID: SYIRL_syCVTsGlItUybE74VWBN5ObQ6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_06,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 mlxlogscore=796 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Eddie James (2):
  fsi: occ: Fix checksum failure mode
  hwmon (occ): Retry for checksum failure

 drivers/fsi/fsi-occ.c      |  7 +++++--
 drivers/hwmon/occ/p9_sbe.c | 28 ++++++++++++++++++----------
 2 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.27.0

