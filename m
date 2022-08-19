Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81CA59A933
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbiHSXPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbiHSXO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:14:58 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE647DB066;
        Fri, 19 Aug 2022 16:14:56 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JLZXTr004018;
        Fri, 19 Aug 2022 23:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=9RAVBG5NW8ghejOsgLcih85r5AuQQzJg6LlIUc/W2NU=;
 b=LQgjPxpdzUk/cqBCrtvGroPne6p8GBVCo6jMCvIbWN/wGnTJw78Elrg089TAZYSqDdcG
 mRc/9mvgH6fVkdErHMHY9zFNVxE6y7+vGs9R/p8f1FcimmZpyST2EgwV/y7Dp/dpCJZb
 zuJmNx+SgIro7klZb9VkOJapvNcS6Jnt9wswqR/0/H9R9aZsjQKgHCGgNF1a6WoK0Jey
 ybJ+Ds7Zau5j3KbnC+QR/bkLB9tRILuoWi/kxLuNwg8f4l222vD7o3LlpF33HggoWcCr
 q2pVjEBYyCnRGBWwJqa2wKnckpoi331j3uhLT341w9xrVJFrvnDK/se13DIZzW8HB3V6 dw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2jf98ka5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 23:14:42 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E4BDE8000BB;
        Fri, 19 Aug 2022 23:14:41 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id C4BBF80882C;
        Fri, 19 Aug 2022 23:14:40 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 0/2] watchdog/hpwdt: Enable hpwdt for ARM64 platforms
Date:   Fri, 19 Aug 2022 17:14:21 -0600
Message-Id: <20220819231423.1236664-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xPEBfcs_DDO5Uqr74ZqgohZTwqzW9xFK
X-Proofpoint-ORIG-GUID: xPEBfcs_DDO5Uqr74ZqgohZTwqzW9xFK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 mlxlogscore=655 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable hpwdt for the rl300, an ARM64 based platform.


Jerry Hoemann (2):
  watchdog/hpwdt: Build issue for ARM64 platforms
  watchdog: Enable HP_WATCHDOG for ARM64 systems.

 drivers/watchdog/Kconfig | 4 ++--
 drivers/watchdog/hpwdt.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.1

