Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D64B1D80
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbiBKEyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:54:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiBKEyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:54:05 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218152637;
        Thu, 10 Feb 2022 20:54:05 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AJH6Ak008345;
        Thu, 10 Feb 2022 20:53:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=hrRvsY8CjSQCrLcTDy+DF5FvCdRQObVLc9z3KzXzuQw=;
 b=FOv1Ne7qXkxff3GUI82wttbn5HRbNs/ryHqfSOVM6uZleBEtpOGG7lTBvRbQ4+sLPesG
 IblKmD7zmyyd4k7ij85VHQ0ehQR65+C6zHzu73iyBZ6wSnzvybP8jpdOKbfmp1RS5jV7
 hLedjvrVmKkq8f1ZfTazugH8d22s8zWZSE4f2m/vv/FnepkDCUxqNNrteahg+6UWn2XB
 WW/0TpqaV3AAgsz2kRkPUYFZ1LAoMmiInDenWK9I3sNf+4fxN4LettCmjWtTzwXOWFan
 ll7C9eejauGITgmOf0q9CqCPob3BjjCeeKslYZvu7FWGQ3alGld9v6+vI4OCcQrC7TjI VQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3e50uccad5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 20:53:53 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Feb
 2022 20:53:51 -0800
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 10 Feb 2022 20:53:48 -0800
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v8 0/4] cn10k DDR Performance monitor support
Date:   Fri, 11 Feb 2022 10:23:42 +0530
Message-ID: <20220211045346.17894-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ZhMGI3AZGFDdev2A15C32_9DDyDURqQL
X-Proofpoint-ORIG-GUID: ZhMGI3AZGFDdev2A15C32_9DDyDURqQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_01,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds DDR performance monitor support on Marvell cn10k series of processor.

First patch adds device tree binding changes.
Second patch add basic support (without overflow and event ownership). Third and fourth patch adds overflow and event ownership respectively.

Seems like 4th patch can be merged in second patch, For easy review it is currently separate

v7->v8:
 - Fixed warning when W=1 and CONFIG_OF=n
 - Rebased to fix merge error

v6->v7:
 - Moved Kconfig to last patch
 - added Reviewed-by

v5->v6:
 - Changed COMPILE_TEST to (COMPILE_TEST && 64BIT)

v4->v5:
 - Added missing COMPILE_TEST dependency

v3->v4:
 - Added Rob Herring reviewed-by for dt-binding patch

v2->v3:
 - dt-binding, ddrcpmu@1 -> pmu@87e1c0000000
 - Add COMPILE_TEST as a dependency
 - Switch to sysfs_emit()
 - Error propagation when invalif event requested
 - Switch to devm_platform_get_and_ioremap_resource()
 - Other review comments on v2.

v1->v2:
 - DT binding changed to new DT Schema
 - writeq/readq changed to respective relaxed
 - Using PMU_EVENT_ATTR_ID

Bharat Bhushan (4):
  dt-bindings: perf: marvell: cn10k ddr performance monitor
  perf/marvell: CN10k DDR performance monitor support
  perf/marvell: cn10k DDR perfmon event overflow handling
  perf/marvell: cn10k DDR perf event core ownership

 .../bindings/perf/marvell-cn10k-ddr.yaml      |  37 +
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 758 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 5 files changed, 804 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
 create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c

-- 
2.17.1

