Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EC48DAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiAMPqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:46:38 -0500
Received: from h01mx15.reliablemail.org ([173.236.5.211]:39814 "EHLO
        h01mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiAMPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:46:37 -0500
X-Halon-Out: 25006da8-7487-11ec-90dc-00163c81f1a9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E3H2b1siBtWNfs0FHzAhtIUMbRbOex7ugO9PAMm8rUY=; b=tQR5XVOPvCFZKEhYA0goMbE2ep
        a+D7tdu3nIfTWwJA6mYCVes4bYZFky6OISA5GksfNtzdHPdLu7dhrEQk3wSTDyWJD0OU7i9CqNj40
        HeYfe4fJRkBudQpewUTYapH1vuJHEDq72OCJAw/MCinjcHIUTZdW9ooJxiKqHWi02S7QykcKQliwA
        PZdxd6Z0UjWUFOytdOlggGmDM92uySnYgaXFVKsG88kG2WoBdL9mIZnCU6Jr3a7+uo9PlO71hcxQ9
        /sf3bu3CN6Z/zGGZIc6CTUGa5vjHPlU8eQ0c+43Bc0Xd2vdaG2uP+/55zCM5KLKg+Cut995btJPtN
        uyMNpXCw==;
From:   Henrik Grimler <henrik@grimler.se>
To:     semen.protsenko@linaro.org, virag.david003@gmail.com,
        martin.juecker@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 0/3] Add initial support for exynos5420-chagallwifi
Date:   Thu, 13 Jan 2022 16:40:16 +0100
Message-Id: <20220113154019.74434-1-henrik@grimler.se>
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

Henrik Grimler (3):
  dt-bindings: arm: samsung: document chagallwifi board binding
  ARM: exynos: only do SMC_CMD_CPU1BOOT call on Exynos4
  ARM: dts: Add support for Samsung Chagallwifi

 .../bindings/arm/samsung/samsung-boards.yaml  |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/exynos5420-chagallwifi.dts  |  57 ++
 .../dts/exynos5420-galaxy-tab-common.dtsi     | 647 ++++++++++++++++++
 arch/arm/mach-exynos/firmware.c               |   4 +-
 5 files changed, 709 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/exynos5420-chagallwifi.dts
 create mode 100644 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi


base-commit: b1cbda0fc3431b464aa78b5f335a5d35428f10c8
-- 
2.34.1

