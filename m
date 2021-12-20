Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DE247AC72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhLTOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:43:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22974 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhLTOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640011347; x=1671547347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YNa8YHikRJ/OKzAGyD12kWBKv4tGn1WRMnt2QZArwnc=;
  b=tlGF/QfuZowrxpAQO7cbJiRI6hRr3Z4dZdx1YzbxMVrCu5616FAQ8CJE
   GD8/l25pWsYmu74OOAzGfX+f0dnRNVF7hac8+AM2iTWJaln+gIxcSYBJq
   J24Jr6QZUVjKJYTCaGtvH92HVV7mc3QysZ6QhqSqgCL0wGeQibGEm7Ghn
   9xoO5KmyYfYbbFpelqPfWuBiPMFFv3sDg+rcS++3SN+J40MUlf2lg5N02
   P95Su0S80PnbsvYtgIPX2SAplEa1KLMCHN5xUKHtfcCyTjArf2lz3w954
   N7gU5iWjx3LxGuiCpa3NFQVU9TBTesqt80TSEcLJtDbf6WJbNz1NdDpS/
   w==;
IronPort-SDR: 5gTeZxK3/JoYsKr5AUjMzhAxFNSCKxbe0kR5vEy+WK5GUC/DQ3loE4mYxdvIayukdfz8sqMuLB
 dWSS2dEt26O/ROOdFHEHPu6YSfzYJIbs0VsjyXY0u/U0K1QjAcUqhyVM0sroXepfUUooeyRHDS
 2Ujl6+GfiIZU8XUtWrAMNeVlHbj+u9ODCOp5oHF0iWlUsURu9Z8gdk7+pr2uqk+apLLEVEubMF
 isLeP4E3Vc7G0UUouZFb1BZLRBT+VOnYabxtTt6kAmO8jGFandBq/NYSxqsHLeUInBk+aMMP86
 ViHr4q4X/EVzSIzLlKta3fhg
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="147245455"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2021 07:42:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 07:42:23 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Dec 2021 07:42:20 -0700
From:   <conor.dooley@microchip.com>
To:     <aou@eecs.berkeley.edu>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <linux-riscv@lists.infradead.org>
CC:     <cyril.jean@microchip.com>, <daire.mcnamara@microchip.com>,
        <lewis.hanly@microchip.com>, <jassisinghbrar@gmail.com>,
        <j.neuschaefer@gmx.net>, <sfr@canb.auug.org.au>,
        <damien.lemoal@wdc.com>, <atishp@atishpatra.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 0/1] soc: add polarfire soc system controller
Date:   Mon, 20 Dec 2021 14:44:12 +0000
Message-ID: <20211220144413.6798-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Changes since v1:
- system controller is now an mfd
- parentage is now used to get the device node on the system controller
- mpfs_sys_controller_get() now updates the reference count
- "polarfire-soc" in compat string changed to "mpfs"

Depends on [0] to change the compat string in the dt-binding.

@Arnd Bergmann:
I sent the first version of this patch in November & you (along with
requesting referencing counting) wanted me to check if the driver was
bound to the specific device [1]. I have taken another look at this
driver now and I am still none the wiser as to how I should do this.

As I said in the previous thread, I checked other driver but was not
able to find any examples of of_find_device_by_node() where the binding
of the driver was checked. If you could point me towards an example
that would be great.

Thanks,
Conor.

For some extra context, the device tree entry for this driver will look
like:

syscontroller: syscontroller {
	compatible = "microchip,mpfs-sys-controller", "simple-mfd";
	mboxes = <&mbox 0>;

	hwrandom: hwrandom {
		compatible = "microchip,mpfs-rng";
	};

	sysserv: sysserv {
		compatible = "microchip,mpfs-generic-service";
	};
};

and the mpfs_sys_controller_get() function is called in, for example,
the mpfs-rng driver:

node_pointer = of_get_parent(dev->of_node);
if (!node_pointer) {
	dev_err(&pdev->dev,
		"Failed to find mpfs system controller node\n");
	return -ENODEV;
}

rng_priv->sys_controller =  mpfs_sys_controller_get(&pdev->dev, node_pointer);

[0] https://lore.kernel.org/linux-riscv/CAMuHMdWTjrAiHosU0cGyJYkK=9JzNgHb=tjHXPdYxTWmkVzeYQ@mail.gmail.com/T/
[1] https://lore.kernel.org/linux-riscv/CAK8P3a1m_LhOg5JGMqPz6sohJa2hPZ3GN-jQDPxigZ5DaqAGxQ@mail.gmail.com/

Conor Dooley (1):
  soc: add polarfire soc system controller

 drivers/soc/Kconfig                         |   1 +
 drivers/soc/Makefile                        |   1 +
 drivers/soc/microchip/Kconfig               |  10 ++
 drivers/soc/microchip/Makefile              |   1 +
 drivers/soc/microchip/mpfs-sys-controller.c | 169 ++++++++++++++++++++
 include/soc/microchip/mpfs.h                |   3 +-
 6 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/microchip/Kconfig
 create mode 100644 drivers/soc/microchip/Makefile
 create mode 100644 drivers/soc/microchip/mpfs-sys-controller.c

-- 
2.33.1

