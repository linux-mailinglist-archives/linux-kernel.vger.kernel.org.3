Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E2B4BE76A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359192AbiBUNio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:38:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359139AbiBUNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:38:40 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C949517A88;
        Mon, 21 Feb 2022 05:38:16 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21LCjG3k002334;
        Mon, 21 Feb 2022 14:37:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=98j3uGLmj33OK+/665DQtkEMyBwIaDlMKW+jkpdU1TM=;
 b=Vb/jqUnVGN3ob4XyHIF0tzlPrgVqEXNa4naZDcql/WKygA9XMVdlQnPNgU0OTjrK1OyE
 nUNgb5jBoDHIlx1PQH2d/B2AWVndyd2iw1NjyGAegLHClqNsg8TZBq9+J4ckisi+42Y9
 lbpjHChikaXXiL5FvdfXKTLwR5KdNhrDXx1ux4Cw5pnGGxA6uTZxuZxNwKMukz04Hv/D
 tSAp1U7VnnTBJCdyBremNgY/eSqSYzyzAg2L37qHDx9VtZ5II+/MZaE9Qqe49xFfYcnR
 NnkKvIlegA4QZPY/NwyMofmgCLEn4SvRaGOkxGtf8OdoHCC2a8E/M6agbxiSJIYEVW74 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ebsqxcdbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 14:37:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9BBB010002A;
        Mon, 21 Feb 2022 14:37:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 902DB229A81;
        Mon, 21 Feb 2022 14:37:53 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 21 Feb 2022 14:37:52
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 0/2] ARM: dts: stm32: Correct masks for GIC PPI interrupts on stm32mp
Date:   Mon, 21 Feb 2022 14:37:48 +0100
Message-ID: <20220221133750.20297-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_07,2022-02-21_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using GIC_CPU_MASK_SIMPLE(x), x should reflect the number of CPUs.

regards
alex

Alexandre Torgue (2):
  ARM: dts: stm32: Correct masks for GIC PPI interrupts on stm32mp13
  ARM: dts: stm32: Correct masks for GIC PPI interrupts on stm32mp15

 arch/arm/boot/dts/stm32mp131.dtsi | 8 ++++----
 arch/arm/boot/dts/stm32mp151.dtsi | 8 ++++----
 arch/arm/boot/dts/stm32mp153.dtsi | 7 +++++++
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.17.1

