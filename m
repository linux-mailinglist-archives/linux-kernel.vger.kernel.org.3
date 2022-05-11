Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB0522C33
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiEKGW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiEKGWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:22:50 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 May 2022 23:22:49 PDT
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B911CA040;
        Tue, 10 May 2022 23:22:49 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="51935716"
X-IronPort-AV: E=Sophos;i="5.91,216,1647270000"; 
   d="scan'208";a="51935716"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 11 May 2022 15:21:41 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4038DE5BA6;
        Wed, 11 May 2022 15:21:40 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 76BD2140E1;
        Wed, 11 May 2022 15:21:39 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 4078940487F9C;
        Wed, 11 May 2022 15:21:39 +0900 (JST)
From:   Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
To:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-serial@vger.kernel.org, sumit.garg@linaro.org
Cc:     arnd@arndb.de, olof@lixom.net, catalin.marinas@arm.com,
        will@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, peterz@infradead.org,
        hasegawa-hitomi@fujitsu.com
Subject: [PATCH v4 0/1] soc: fujitsu: Add A64FX diagnostic interrupt driver
Date:   Wed, 11 May 2022 15:21:12 +0900
Message-Id: <20220511062113.2645747-1-hasegawa-hitomi@fujitsu.com>
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

I tested on FX700:
$ echo 1 > /proc/sys/kernel/sysrq
$ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
:
:

Send the "chassis power diag" command from the management server
using ipmitool, the following message is shown:
[  123.272342] Kernel panic - not syncing: a64fx_diag: interrupt received
:
:

Changes in V4:
 - Call the panic function instead of sysrq. Prepare a handler
   for each NMI/IRQ and call nmi_panic()/panic() respectively (as in v1).
 - Fixing other issues raised by Greg.

Changes in V3:
 - Exclude Sumit's patch.
 - Retest in v5.17.

Changes in V2:
 - Include Sumit's patch.
 - The handler calls handle_sysrq() to use the sysrq feature to cause
   a panic.
 - request_nmi() and request_irq() now use the same handler, and
   the function name of the handler has also changed.
 - Use readl()/writel() instead of readl_relaxed()/writel_relaxed().

V3: https://lore.kernel.org/linux-arm-kernel/20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com/
V2: https://lore.kernel.org/linux-arm-kernel/20220304064324.331217-3-hasegawa-hitomi@fujitsu.com/
V1: https://lore.kernel.org/linux-arm-kernel/20220218092010.1327309-1-hasegawa-hitomi@fujitsu.com/


Hitomi Hasegawa (1):
  soc: fujitsu: Add A64FX diagnostic interrupt driver

 MAINTAINERS                      |   5 +
 drivers/soc/Kconfig              |   1 +
 drivers/soc/Makefile             |   1 +
 drivers/soc/fujitsu/Kconfig      |  13 +++
 drivers/soc/fujitsu/Makefile     |   3 +
 drivers/soc/fujitsu/a64fx-diag.c | 155 +++++++++++++++++++++++++++++++
 6 files changed, 178 insertions(+)
 create mode 100644 drivers/soc/fujitsu/Kconfig
 create mode 100644 drivers/soc/fujitsu/Makefile
 create mode 100644 drivers/soc/fujitsu/a64fx-diag.c

-- 
2.27.0

