Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B955559B543
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiHUPy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiHUPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:54:53 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B382615
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:54:52 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 0C51C41370;
        Sun, 21 Aug 2022 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1661097289; x=1662911690; bh=38/mpMH/WKYIqy39p1O3ZnjWk
        UwjWz1Pf/Gj+eAFiF0=; b=nLoVU14h9w6sZNG5zs/W6EcREd+D0PSM2B7J07aqu
        c0lmHrqJkH0dg1B5JuZVieCheZlaRzIJGq5USAyja1BlE4R9XRdsI3fpQej2pKbV
        O0srJcF/OA1251OSC54G4DNeRTN4Lx87N+4JLjBk5fCuDt4ol7WYdIb6GVbnga8S
        fE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KZ4spSCFBqGf; Sun, 21 Aug 2022 18:54:49 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A1E08412D6;
        Sun, 21 Aug 2022 18:54:48 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Sun, 21 Aug 2022 18:54:48 +0300
Received: from ik-yadro.yadro.com (10.199.18.154) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Sun, 21 Aug
 2022 18:54:43 +0300
From:   Igor Kononenko <i.kononenko@yadro.com>
To:     Corey Minyard <minyard@acm.org>, Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>
CC:     <openbmc@lists.ozlabs.org>, Igor Kononenko <i.kononenko@yadro.com>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ipmi:kcs_bmc: Add cleanup regmap(interrupt-regs) on a shutdown.
Date:   Sun, 21 Aug 2022 18:54:09 +0300
Message-ID: <fb81dda34f9db0b9f743b247a2464576dcccd7c9.1661094034.git.i.kononenko@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661094034.git.i.kononenko@yadro.com>
References: <cover.1661094034.git.i.kononenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.18.154]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bmc might be rebooted while the host is still reachable and the host
might send requests through configured lpc-kcs channels. That leads to
raise lpc-snoop interrupts that haven't adjusted IRQ handlers on next
early kernel boot, because on the aspeed-chip reboot it might keep
unclear registers on a state that is configured on the last boot.

The described case get a `nobody cared` warning about more than 100.000
requests when another one driver configures the same shared IRQ(e.g. 35)
and the interrupt will be passed through for lpc-kcs IRQ handler by
`IRQ_NONE` state flag.

The kernel output of described way is bellow:
```
[    1.360110] irq 35: nobody cared (try booting with the "irqpoll" option)
[    1.360145] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.43-c109de3-24cc5b6 #1
[    1.360158] Hardware name: Generic DT based system
[    1.360168] Backtrace:
[    1.360228] [<80107f5c>] (dump_backtrace) from [<80108184>] (show_stack+0x20/0x24)
[    1.360250]  r7:00000023 r6:00000000 r5:00000000 r4:9d12d560
[    1.360283] [<80108164>] (show_stack) from [<8084ae54>] (dump_stack+0x20/0x28)
[    1.360316] [<8084ae34>] (dump_stack) from [<80156790>] (__report_bad_irq+0x40/0xc0)
[    1.360344] [<80156750>] (__report_bad_irq) from [<801566c0>] (note_interrupt+0x238/0x290)
[    1.360366]  r9:9d0ae000 r8:9d00c600 r7:00000023 r6:00000000 r5:00000000 r4:9d12d560
[    1.360408] [<80156488>] (note_interrupt) from [<80153594>] (handle_irq_event+0xb4/0xc4)
[    1.360429]  r10:00000000 r9:9d0ae000 r8:9d00c600 r7:00000001 r6:00000000 r5:00000000
[    1.360440]  r4:9d12d560 r3:00000000
[    1.360466] [<801534e0>] (handle_irq_event) from [<8015788c>] (handle_level_irq+0xac/0x180)
[    1.360480]  r5:80c7d35c r4:9d12d560
[    1.360503] [<801577e0>] (handle_level_irq) from [<80152a5c>] (__handle_domain_irq+0x6c/0xc8)
[    1.360519]  r5:80c7d35c r4:9d12d560
[    1.360545] [<801529f0>] (__handle_domain_irq) from [<801021cc>] (avic_handle_irq+0x68/0x70)
[    1.360568]  r9:9d0ae000 r8:9d12d608 r7:9d0afc84 r6:ffffffff r5:9d0afc50 r4:9d002380
[    1.360587] [<80102164>] (avic_handle_irq) from [<80101a6c>] (__irq_svc+0x6c/0x90)
[    1.360603] Exception stack(0x9d0afc50 to 0x9d0afc98)
[    1.360620] fc40:                                     00000000 00000100 00000000 00000000
[    1.360640] fc60: 9d12d560 98bbd0c0 00000000 00000023 9d12d608 60000053 00000000 9d0afcd4
[    1.360657] fc80: 9d0afc80 9d0afca0 801570ec 80154cdc 40000053 ffffffff
[    1.360670]  r5:40000053 r4:80154cdc
[    1.360693] [<801549e0>] (__setup_irq) from [<801555e4>] (request_threaded_irq+0xdc/0x15c)
[    1.360715]  r9:98bbb340 r8:00000023 r7:9d12d570 r6:9d12d560 r5:00000000 r4:98bbd0c0
[    1.360741] [<80155508>] (request_threaded_irq) from [<801589d8>] (devm_request_threaded_irq+0x70/0xc4)
[    1.360762]  r10:80a7353c r9:00000000 r8:98bbb340 r7:9d130e10 r6:00000023 r5:804f4a70
[    1.360774]  r4:98bbd020 r3:00000080
[    1.360800] [<80158968>] (devm_request_threaded_irq) from [<804f4ebc>] (aspeed_lpc_snoop_probe+0x100/0x2ac)
[    1.360821]  r10:00000000 r9:9d130e10 r8:98bbd040 r7:00000000 r6:9d130e00 r5:98bbb340
[    1.360830]  r4:00000000
[    1.360851] [<804f4dbc>] (aspeed_lpc_snoop_probe) from [<8056a5c4>] (platform_drv_probe+0x44/0x80)
[    1.360873]  r9:80c5ef90 r8:00000000 r7:80cc2938 r6:00000000 r5:80c5ef90 r4:9d130e10
[    1.360910] [<8056a580>] (platform_drv_probe) from [<80568420>] (really_probe+0x26c/0x498)
[    1.360924]  r5:80cc282c r4:9d130e10
[    1.360949] [<805681b4>] (really_probe) from [<80568c28>] (driver_probe_device+0x138/0x184)
[    1.360970]  r10:80b0050c r9:80adadb0 r8:00000007 r7:80c5ef90 r6:9d130e10 r5:00000000
[    1.360981]  r4:80c5ef90
[    1.361004] [<80568af0>] (driver_probe_device) from [<80568fe4>] (device_driver_attach+0xb8/0xc0)
[    1.361020]  r7:80c5ef90 r6:9d130e54 r5:00000000 r4:9d130e10
[    1.361046] [<80568f2c>] (device_driver_attach) from [<80569070>] (__driver_attach+0x84/0x16c)
[    1.361063]  r7:80c61128 r6:9d130e10 r5:00000001 r4:80c5ef90
[    1.361088] [<80568fec>] (__driver_attach) from [<80566068>] (bus_for_each_dev+0x84/0xcc)
[    1.361106]  r7:80c61128 r6:80568fec r5:80c5ef90 r4:00000000
[    1.361130] [<80565fe4>] (bus_for_each_dev) from [<80569180>] (driver_attach+0x28/0x30)
[    1.361147]  r6:00000000 r5:9d1a3d40 r4:80c5ef90
[    1.361169] [<80569158>] (driver_attach) from [<80566a08>] (bus_add_driver+0x114/0x200)
[    1.361195] [<805668f4>] (bus_add_driver) from [<80569814>] (driver_register+0x98/0x128)
[    1.361214]  r7:00000000 r6:80ca0ca0 r5:00000000 r4:80c5ef90
[    1.361241] [<8056977c>] (driver_register) from [<8056b528>] (__platform_driver_register+0x40/0x54)
[    1.361256]  r5:000000b8 r4:80b2575c
[    1.361294] [<8056b4e8>] (__platform_driver_register) from [<80b2577c>] (aspeed_lpc_snoop_driver_init+0x20/0x28)
[    1.361331] [<80b2575c>] (aspeed_lpc_snoop_driver_init) from [<80b01318>] (do_one_initcall+0x84/0x184)
[    1.361356] [<80b01294>] (do_one_initcall) from [<80b01540>] (kernel_init_freeable+0x128/0x1ec)
[    1.361375]  r7:80b3f858 r6:80ca0ca0 r5:000000b8 r4:80b61914
[    1.361412] [<80b01418>] (kernel_init_freeable) from [<80864060>] (kernel_init+0x18/0x11c)
[    1.361435]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80864048
[    1.361444]  r4:00000000
[    1.361470] [<80864048>] (kernel_init) from [<801010e8>] (ret_from_fork+0x14/0x2c)
[    1.361483] Exception stack(0x9d0affb0 to 0x9d0afff8)
[    1.361500] ffa0:                                     00000000 00000000 00000000 00000000
[    1.361518] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.361535] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.361547]  r5:80864048 r4:00000000
[    1.361555] handlers:
[    1.361592] [<(ptrval)>] aspeed_lpc_snoop_irq
[    1.361609] Disabling IRQ #35

```

Note:
 * The lpc-snoop driver found on the same 1e789080 address and have
same IRQ#35 as for lpc-kcs
 * The lpc-snoop initizalied earlier than lpc-kcs.

The patch brings a way to masking lpc-kcs interrupt all through
a bmc-rebooting time.

Tested on the YADRO VEGMAN N110 stand.

Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index cdc88cde1e9a..440f31d96bd3 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -636,6 +636,13 @@ static int aspeed_kcs_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void aspeed_kcs_shutdown(struct platform_device *pdev)
+{
+	struct kcs_bmc *kcs_bmc = dev_get_drvdata(&pdev->dev);
+
+	aspeed_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF), 0);
+}
+
 static const struct of_device_id ast_kcs_bmc_match[] = {
 	{ .compatible = "aspeed,ast2400-kcs-bmc-v2" },
 	{ .compatible = "aspeed,ast2500-kcs-bmc-v2" },
@@ -651,6 +658,7 @@ static struct platform_driver ast_kcs_bmc_driver = {
 	},
 	.probe  = aspeed_kcs_probe,
 	.remove = aspeed_kcs_remove,
+	.shutdown = aspeed_kcs_shutdown,
 };
 module_platform_driver(ast_kcs_bmc_driver);
 
-- 
2.25.1

