Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB95847489D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhLNQ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:56:44 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:14536 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235926AbhLNQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:56:40 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BEAJk6p021532;
        Tue, 14 Dec 2021 08:56:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=tp6mY6+PLk/58Il8Y6N+ozXLsAZN46Z8xK+scU60b7U=;
 b=NTmwUUm+wujiHvZ8KhLyMi2j/fZUDqgOdS6f1cNuQr7FUOEXprEUAh+t7yeJalyIDdbX
 m2ITUaEY6YNEmHKZGCuukSP1YwBh/fmqLQ5drJ6w6hfEEgX/YJMtVAy9H+O0E0GCt2jw
 9p3n+FPy9592EEIPZqfTY600p3uL0g4xjx9xKyMycjVf1LBAizbiXKR51pru+Wo4F3+O
 PE1UhDwCNNJxDUWDmGEc/sLFDnkC86Ih850mWoNx+6D1NFnURqHwrEemXEWhs4c0XfQw
 f1ALr/wkIDNRSEV7T6vc96YcLn2qf8XoClgfYSTBHiJUvlLLXh8iBEWBGm7a2/LbSExn lw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cxsds1mej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 08:56:23 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Dec
 2021 08:56:21 -0800
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Dec 2021 08:56:18 -0800
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v7 0/4] cn10k DDR Performance monitor support
Date:   Tue, 14 Dec 2021 22:26:09 +0530
Message-ID: <20211214165613.26479-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: jkJJ9OeHDuJfM1hZ_XwdJRW9PwsxZ9uD
X-Proofpoint-ORIG-GUID: jkJJ9OeHDuJfM1hZ_XwdJRW9PwsxZ9uD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds DDR performance monitor support
on Marvell cn10k series of processor.

First patch adds device tree binding changes.
Second patch add basic support (without overflow and event
ownership). Third and fourth patch adds overflow and event
ownership respectively.

Seems like 4th patch can be merged in second patch,
For easy review it is currently separate

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
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 756 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 5 files changed, 802 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
 create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c

-- 
2.17.1

