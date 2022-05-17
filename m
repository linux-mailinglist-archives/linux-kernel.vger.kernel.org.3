Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C7E5296D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbiEQBiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiEQBh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:37:57 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72AC72E6A2;
        Mon, 16 May 2022 18:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7G8Kb
        AmludJDMdA3ZiXqK+V/H8kA2kjapKKgVRW8jhc=; b=lJE2W15X5D1aKIQlx7UNx
        ZMWlyYARWJYJf05qA7uRMDHbZAb1E10n6frNPPXux7L/4eR6aDVjmYNUbvSghR7z
        6m2q3ghPxQCyAstAw9lAIcLGjuUPv/FTlgABl6WnKDZHdLvNlUi8NZ0KInuv+hHp
        WqUV+Ux6n0SHQNSjDcqqGo=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.20])
        by smtp9 (Coremail) with SMTP id DcCowAB3USwR_IJiF3ohDQ--.61255S2;
        Tue, 17 May 2022 09:36:18 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 0/3] ARM: sun8i-r40: CPU improve
Date:   Tue, 17 May 2022 09:36:04 +0800
Message-Id: <20220517013607.2252-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAB3USwR_IJiF3ohDQ--.61255S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFykZw13Xr4rAryUuw1kuFg_yoWrJFWfpr
        1UJr1UGr4UJr1UJr17tr1rJr1UJr1UJr1UJr15Jr1UJr1UJF1UJr1UJr15Jr4UGrn8Ar1U
        tr1UJryUG34DJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zNfOxUUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXBME7VXl26j8kwAAsK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

Change history:
===============
v5(2022-05-17):
- Move opp tables to sun8i-r40-cpu-opp.dtsi
- cpufreq supports 720M, 912M, 1G, 1.1G, 1.2G
- Add cooling supports

v4(2022-05-16):
- Invert two patches.
- Drop the cpufreqs that exceeds 1G in opp tables.

v3:
- remove "allwinner-r40" compatible from allowlist.
- split dts in two part.

Test:
=====

cpufreq was tested by tools: https://github.com/ssvb/cpuburn-arm

1. cpufreq-ljt-stress-test

- root@ubuntu:~/cpuburn-arm-master# ./cpufreq-ljt-stress-test 
- CPU stress test, which is doing JPEG decoding by libjpeg-turbo
- at different cpufreq operating points.
- 
- Testing CPU 0
-  1200 MHz ............................................................ OK
-  1104 MHz ............................................................ OK
-  1008 MHz ............................................................ OK
-   912 MHz ............................................................ OK
-   720 MHz ............................................................ OK
- 
- Testing CPU 1
-  1200 MHz ............................................................ OK
-  1104 MHz ............................................................ OK
-  1008 MHz ............................................................ OK
-   912 MHz ............................................................ OK
-   720 MHz ............................................................ OK
- 
- Testing CPU 2
-  1200 MHz ............................................................ OK
-  1104 MHz ............................................................ OK
-  1008 MHz ............................................................ OK
-   912 MHz ............................................................ OK
-   720 MHz ............................................................ OK
- 
- Testing CPU 3
-  1200 MHz ............................................................ OK
-  1104 MHz ............................................................ OK
-  1008 MHz ............................................................ OK
-   912 MHz ............................................................ OK
-   720 MHz ............................................................ OK

Overall result : PASSED

2. cpu freq slow down when cpuburn-a7.out running

- temperature: 79213, online: 0-3, freq: 1200000
- temperature: 79213, online: 0-3, freq: 1200000
- temperature: 80230, online: 0-3, freq: 1104000
- temperature: 78874, online: 0-3, freq: 1200000
- temperature: 80004, online: 0-3, freq: 1104000
- temperature: 79213, online: 0-3, freq: 1200000
- temperature: 78196, online: 0-3, freq: 1200000
- temperature: 79891, online: 0-3, freq: 1200000
- temperature: 78422, online: 0-3, freq: 1200000
- temperature: 80343, online: 0-3, freq: 1104000
- temperature: 80343, online: 0-3, freq: 1104000


qianfan Zhao (3):
  ARM: dts: sun8i-r40: Add "cpu-supply" node for sun8i-r40 based board
  ARM: dts: sun8i-r40: add opp table for cpu
  ARM: dts: sun8i-r40: Add thermal trip points/cooling maps

 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  5 ++
 arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi      | 52 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-r40-feta40i.dtsi      |  5 ++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 36 +++++++++++++
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts      |  5 ++
 .../boot/dts/sun8i-v40-bananapi-m2-berry.dts  |  5 ++
 6 files changed, 108 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi

-- 
2.25.1

