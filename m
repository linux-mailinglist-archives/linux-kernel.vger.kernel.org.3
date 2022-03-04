Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFBD4CCDFD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiCDGrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCDGri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:47:38 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Mar 2022 22:46:50 PST
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186418CC23;
        Thu,  3 Mar 2022 22:46:50 -0800 (PST)
IronPort-SDR: EI5VdwU71qwp/hTU6E1u7csQh7X91ZB0CD35wA/uIVwTF/ebimlljlEUodpEXU9vMbJIj7Ea3K
 /M0czsdvdvhu3gzIrIga/f3b7gpxr07384+d1uIlSrBDrEjJGhAQ7tsGwAvP46JZM/S/m2lk/I
 Gi7t6ceLeAohYJnk6iutItdztg0KS8hPtjBlMGgSX8eu55BiNrl53kLnH2oNv7kqVJK8jfA9Xr
 00H14hynqsqZyzTID70LRBiaL1Mhex9MFeInNm9orYqM+MKAbzN9MjQMOx5LzZHttPBNE6UI3V
 Ah8oeaTmS1da8Jj7xhb4N8Xo
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="44623340"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; 
   d="scan'208";a="44623340"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2022 15:45:44 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 630A8C68A4;
        Fri,  4 Mar 2022 15:45:44 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id A9E14CFBC0;
        Fri,  4 Mar 2022 15:45:43 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id 7D372403884F7;
        Fri,  4 Mar 2022 15:45:42 +0900 (JST)
From:   Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
To:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-serial@vger.kernel.org, sumit.garg@linaro.org
Cc:     arnd@arndb.de, olof@lixom.net, catalin.marinas@arm.com,
        will@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, peterz@infradead.org,
        hasegawa-hitomi@fujitsu.com
Subject: [PATCH v2 0/2] soc: fujitsu: Add A64FX diagnostic interrupt driver
Date:   Fri,  4 Mar 2022 15:43:22 +0900
Message-Id: <20220304064324.331217-1-hasegawa-hitomi@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt is set using pseudo-NMI if it is available. Arm has a
diagnostic interrupt feature called "Arm Generic Diagnostic Dump and
Reset device", but the A64FX does not support this feature and instead
has its own device definition.

This patch series includes ones created by Sumit.[1]

I tested on FX700:
$ echo 1 > /proc/sys/kernel/sysrq
$ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
[  124.712351] lkdtm: Performing direct entry HARDLOCKUP
[  147.232096] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
:
:

Send the "chassis power diag" command from the management server
using ipmitool, the following message is shown:
[  206.061770] sysrq: Trigger a crash
[  206.061779] Kernel panic - not syncing: sysrq triggered crash
:
:

Changes in V2:
 - Include Sumit's patch.
 - The handler calls handle_sysrq() to use the sysrq feature to cause
   a panic.
 - request_nmi() and request_irq() now use the same handler, and
   the function name of the handler has also changed.
 - Use readl()/writel() instead of readl_relaxed()/writel_relaxed().

V1:
  https://lore.kernel.org/linux-arm-kernel/20220218092010.1327309-1-hasegawa-hitomi@fujitsu.com/

[1] https://lore.kernel.org/all/20220228135408.1452882-1-sumit.garg@linaro.org/

Sumit Garg (1):
  tty/sysrq: Make sysrq handler NMI aware

Hitomi Hasegawa (1):
  soc: fujitsu: Add A64FX diagnostic interrupt driver

 MAINTAINERS                      |   5 +
 drivers/soc/Kconfig              |   1 +
 drivers/soc/Makefile             |   1 +
 drivers/soc/fujitsu/Kconfig      |  13 +++
 drivers/soc/fujitsu/Makefile     |   3 +
 drivers/soc/fujitsu/a64fx-diag.c | 151 +++++++++++++++++++++++++++++++
 drivers/tty/sysrq.c              |  45 ++++++++-
 include/linux/sysrq.h            |   1 +
 kernel/debug/debug_core.c        |   1 +
 9 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/fujitsu/Kconfig
 create mode 100644 drivers/soc/fujitsu/Makefile
 create mode 100644 drivers/soc/fujitsu/a64fx-diag.c

-- 
2.27.0

