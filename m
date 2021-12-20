Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393A147B0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhLTQM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:12:27 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51256 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232655AbhLTQM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:12:27 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BKAnu9H014865;
        Mon, 20 Dec 2021 17:11:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=n8yRP6xOqGZhqk3DxX5FSPwv2mGGn+K5o3yLGj6OSu4=;
 b=jgMH5to82aOey9qL+052rDPLywW+LfkbP4//IhuJRhJkUt9oCTX/YnVd8El9C60VNRy5
 Ph+lODE4U5EzwJ28CBVvf/Na1F7Hzq7Svs6FIyTaK24S61hXacJfDYf2vFtFLfa+oUY3
 Pw4A9vOPnPQIMOFf5QMA9Nlzgps2i290hpv2k9kfbbeNwOW64zV6Hyxmg1rL3cpU0MGI
 YgmjVHpvTqQacdt1Kl5tEPWUW0SuH8MjJHGbZYILAm42Dx/zWSPwHF8YzFtiI/xZuUil
 1QMXHKMBvcJMMjFD2JN2/eFqIPz2qdFO5lxhZxapVeaJbFOl1JfHHloIoKf4i3ZVBGEr yQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d2keau531-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 17:11:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9928A100034;
        Mon, 20 Dec 2021 17:11:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 919A0209722;
        Mon, 20 Dec 2021 17:11:58 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 20 Dec 2021 17:11:58
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable CONFIG_RPMSG_TTY
Date:   Mon, 20 Dec 2021 17:11:55 +0100
Message-ID: <20211220161155.32564-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_06,2021-12-20_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPMsg TTY implements an inter-processor communication with a standard
TTY interface on top of the RPMsg framework.
This driver is a generic RPMsg client that can run on different platforms.

By enabling the RPMSG_TTY driver as module in multi_v7_defconfig, it makes
possible to automatically probe the rpmsg_tty driver by the RPMsg bus,
when the support of the RPMsg service is dynamically requested by the
co-processor firmware.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
delta vs V1:
add
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c951aeed2138..370ca4ae3981 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -372,6 +372,7 @@ CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
 CONFIG_SERIAL_OWL=y
+CONFIG_RPMSG_TTY=m
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_ASPEED_KCS_IPMI_BMC=m
-- 
2.17.1

