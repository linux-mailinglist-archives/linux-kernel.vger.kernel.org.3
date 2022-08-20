Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0075559B078
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiHTU3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 16:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHTU3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:29:03 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F22408C;
        Sat, 20 Aug 2022 13:29:02 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KAHPG9020634;
        Sat, 20 Aug 2022 20:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=aZDdO0I6etmnaLZVKrrq7+bij97XxK4tSORRQyJrim0=;
 b=NcwI3jBCjmY30YInGrR2rl8PPP5p3vw924k/kuMFQMudi0myxYBAA+tcHNwAYluylPEV
 6KqFjlLqbEwvxtsoLybH56OxWha5Aspkgst3my9Klr3hLJdjGWY2jTvq6+21dY+DYHwa
 LVec//jQBrtnWvAKOPYRz9Ex4AJS1L2zBzQl2wQ4eLgPRb+6gKT8uu0qLJs0EqK0Gb5s
 A0vw3FSDiZRArFH0B/nwS46oLZVw5xJkzt1LstlrCEQ3XURVHYd/NpWAuGiIJP5sxaMa
 cMPDkP9SY/TdY7hPfID323RJb8R8Pp3UCaPKIUS/w4ZOVSnL9IKvVnzJBtb98flcindF ig== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wqq2hak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 20:28:48 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 69C35D2C9;
        Sat, 20 Aug 2022 20:28:47 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 43760808C3D;
        Sat, 20 Aug 2022 20:28:46 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 0/2] watchdog/hpwdt: Enable hpwdt for ARM64 platforms
Date:   Sat, 20 Aug 2022 14:28:19 -0600
Message-Id: <20220820202821.1263837-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DJLiJoWhXQZiNx3FXJzytBfE7f86rC9M
X-Proofpoint-ORIG-GUID: DJLiJoWhXQZiNx3FXJzytBfE7f86rC9M
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=621 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208200087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable hpwdt for the rl300, an ARM64 based platform.


Patch 1: watchdog/hpwdt.c: Include nmi.h only if CONFIG_HPWDT_NMI_DECODING

ARM64 does not support NMI and does not have <asm/nmi.h>.  Include
nmi.h only if CONFIG_HPWDT_NMI_DECODING is defined.

Patch 2: watchdog/Kconfig:  Allow hpwdt.c to be built for ARM64.

Allow hpwdt.c to be built for (ARM64 || X86) as this part of hwpdt doesn't
use NMI.

Make HPWDT_NMI_DECODING dependent upon X86 as NMI handlers are specific
to X86 platforms.


== Changes for v2 ==
Update patch documentation.




Jerry Hoemann (2):
  watchdog/hpwdt: Include nmi.h only if CONFIG_HPWDT_NMI_DECODING
  watchdog: Enable HP_WATCHDOG for ARM64 systems.

 drivers/watchdog/Kconfig | 4 ++--
 drivers/watchdog/hpwdt.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.1

