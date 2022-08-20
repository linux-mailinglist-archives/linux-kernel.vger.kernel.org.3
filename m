Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBEF59B077
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiHTU3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiHTU3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:29:03 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF87A23BF4;
        Sat, 20 Aug 2022 13:29:02 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KAIkGJ004204;
        Sat, 20 Aug 2022 20:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=Rkq13/MrlFn0D14OGLlUtjXMn0jr/8jx4TEFY40dQaE=;
 b=JOrfOi+zHA3bus4gn4eUR+OYi3N8JCPFyq+TthpB2RSTO0wTOiEbPberqnSNndx6WRMY
 RUckFjSuJzzqNW/y4FuYa/TO6aaIxYbLSYLXvLgVP6Gay6+uauVNrmZ4Srv/kSjrcz/t
 32sfSDAw67aqGBvANghdwK7exY6CGMCrYnDe/tOFTsmkZDg7KZIqFv6AomVa9aqixHU4
 3OKV88OabnvkEoY+yDWTAXby7OpAgD+IJVZdlQLXjHj25fhYrnwa9uL3Dek/vn5EXXDB
 GbqYmjpkEXtSADSuEX4ueg3lxkZtM0Am/ytBjivg3rRYEx3lVm8TJ9YsD4bV40xUy0hm LQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wqpjfu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 20:28:48 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 0A0928000BB;
        Sat, 20 Aug 2022 20:28:48 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 8F3E4808C3D;
        Sat, 20 Aug 2022 20:28:47 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 2/2] watchdog: Enable HP_WATCHDOG for ARM64 systems.
Date:   Sat, 20 Aug 2022 14:28:21 -0600
Message-Id: <20220820202821.1263837-3-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820202821.1263837-1-jerry.hoemann@hpe.com>
References: <20220820202821.1263837-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jsZiaylxqD5DH3UA7lrEkSgxBoChVMEa
X-Proofpoint-ORIG-GUID: jsZiaylxqD5DH3UA7lrEkSgxBoChVMEa
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=716 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Enable HP_WATCHDOG for ARM64 systems.
HPWDT_NMI_DECODING requires X86 as NMI handlers are X86 specific.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9295492d24f7..cd643e50681e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1315,7 +1315,7 @@ config IT87_WDT
 config HP_WATCHDOG
 	tristate "HP ProLiant iLO2+ Hardware Watchdog Timer"
 	select WATCHDOG_CORE
-	depends on X86 && PCI
+	depends on (ARM64 || X86) && PCI
 	help
 	  A software monitoring watchdog and NMI handling driver. This driver
 	  will detect lockups and provide a stack trace. This is a driver that
@@ -1325,7 +1325,7 @@ config HP_WATCHDOG
 
 config HPWDT_NMI_DECODING
 	bool "NMI support for the HP ProLiant iLO2+ Hardware Watchdog Timer"
-	depends on HP_WATCHDOG
+	depends on X86 && HP_WATCHDOG
 	default y
 	help
 	  Enables the NMI handler for the watchdog pretimeout NMI and the iLO
-- 
2.37.1

