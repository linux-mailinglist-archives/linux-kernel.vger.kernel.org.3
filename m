Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5685A48F7C9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiAOQ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:27:30 -0500
Received: from h04mx17.reliablemail.org ([185.76.67.210]:36546 "EHLO
        h04mx17.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiAOQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:27:29 -0500
X-Halon-Out: 06a35eb1-7620-11ec-a232-556aad082471
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ReV3cTCcQbwKTVST9aqNB4NI1KACvVlqj1N8uT56YnQ=; b=o6TkzjnLdEX9Xls8zB32N/0Cgr
        4NHScSmIVW1HQZLcPwR4lL9pk9OVj/YhYe3aBUBrQE6NJpj0mK4B5BcbX94fRUkq1t90fXvKHgbSb
        TAxm3RL6j8RthAnBilbBtNXCpcN/djiJEfDyHF9b0dVUitrobTdthhMSvR9odVdlR6xamrS5GtC1w
        JIaDXOVgnUp49+/f5eHsdUhNyjcLdR3fKYVII2a+AX41v8tngWP1WAHmcEl0IBbCVrrO+5RsNQ38t
        bmS6JPbvoKPd54uwnLrbT8zpos1wKwatG7yq3AVDAqpbnX/1UHkTVINb6zMWF8uWgiflv+3b/vZAS
        DRrJBynA==;
From:   Henrik Grimler <henrik@grimler.se>
To:     semen.protsenko@linaro.org, virag.david003@gmail.com,
        martin.juecker@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v2 0/3] Add initial support for exynos5420-chagallwifi
Date:   Sat, 15 Jan 2022 17:27:00 +0100
Message-Id: <20220115162703.699347-1-henrik@grimler.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung's tablet Galaxy Tab S 10.5" (wifi) has codename chagallwifi
and is one of several tablets released in 2013 - 2014 based on Exynos
5420.  This initial devicetree adds support for accessing device over
USB or UART, and allows using a rootfs in either the internal eMMC or
an external sdcard.  4 out of 8 CPUs are brought up when device boots,
which is the same as on the somewhat similar device
exynos5420-arndale-octa.

Patch 2 is necessary after a secure-firmware node is added, otherwise
device hangs during the CPU1BOOT secure monitor call. Without the
secure-firmware node we are not able to bring up any secondary CPUs.

Changes since v1
================

Fix mmc_0 and usbdrd in patch 3: 
* Remove extra, non supported, options from mmc_0 node 
* Do not set usbdrd supplies. Usb networking does not work with them 
  specified, but it works fine with dummy regulators

Henrik Grimler (3):
  dt-bindings: arm: samsung: document chagallwifi board binding
  ARM: exynos: only do SMC_CMD_CPU1BOOT call on Exynos4
  ARM: dts: Add support for Samsung Chagallwifi

 .../bindings/arm/samsung/samsung-boards.yaml  |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/exynos5420-chagallwifi.dts  |  57 ++
 .../dts/exynos5420-galaxy-tab-common.dtsi     | 633 ++++++++++++++++++
 arch/arm/mach-exynos/firmware.c               |   4 +-
 5 files changed, 695 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/exynos5420-chagallwifi.dts
 create mode 100644 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi

-- 
2.34.1

