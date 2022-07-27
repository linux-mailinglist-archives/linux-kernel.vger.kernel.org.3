Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8748A582FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbiG0R2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242160AbiG0R1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:27:35 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C557F501;
        Wed, 27 Jul 2022 09:47:15 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RFwUtK023856;
        Wed, 27 Jul 2022 16:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=UFYjiEWtx65NAlZGwbjuEPkGm/TiO1KWDpSSR7Sm3co=;
 b=DqZt92L6Smq3KbqdloSY2xA9h18G0jRP7qoMBqxvVRGepovBQoZIlM3mJv76ui3W0BB+
 0CcMR71Qk3ZaB962BWQiDc0c4bXghauIrsFj+K1lES3BvFe1lQqkkixfk9g4XudzzLUJ
 QOTbYNCPigNW8NVioxBrtUC0/f2/saRBirozuENlCGwADcsI4/dEfypB/hDrM+Ky2qKW
 w8snXdoBJIaxJnXPx3e0cSTxzFBZYEkSy5Nymo/eXYBspDZP3+quDI4Dzf04RhWIa7Fh
 hKzAR/ulX+awIlkULBULER832qtKf96iX5GQLYc4uBNZxBrjJbLAU3QoTYexk4KzR9rm GQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hk475amu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 16:46:42 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 465BB804C86;
        Wed, 27 Jul 2022 16:46:41 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 07EEC8001B3;
        Wed, 27 Jul 2022 16:46:39 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v5 4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP SPI driver
Date:   Wed, 27 Jul 2022 11:47:35 -0500
Message-Id: <20220727164736.48619-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220727164736.48619-1-nick.hawkins@hpe.com>
References: <20220727164736.48619-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: xnrEATHz-dceqYfb9Ma87PdRr7SO74IK
X-Proofpoint-GUID: xnrEATHz-dceqYfb9Ma87PdRr7SO74IK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_06,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=667 impostorscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270070
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Enable the SPI driver on the HPE GXP BMC.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
v5:
 *No change, add Acked-by from Krzsztof from previous version
v4:
 *No change
v3:
 *No change
v2:
 *Change CONFIG_SPI_GXP from y to m
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ce9826bce29b..ee8a730dabc9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -443,6 +443,7 @@ CONFIG_SPI_CADENCE=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_SPI_GPIO=m
+CONFIG_SPI_GXP=m
 CONFIG_SPI_FSL_DSPI=m
 CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
-- 
2.17.1

