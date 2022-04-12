Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CBB4FE326
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356369AbiDLNze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356357AbiDLNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:55:26 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799D857B35;
        Tue, 12 Apr 2022 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649771588;
  x=1681307588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AUdNxymSjy37DI3EYemBqzmoIe81Gg2MVcQxXKOtE1k=;
  b=oKZ1t0rm2PKW+LWMQhwuaV7WfddMGBkhF/CfjcENjYoHgKgTDaS8fs4v
   sReQU4Pz1HVgGrzF0jVTw+1vUKKv4lbwt0i/TkRZrSKDMadSTG6PodcDk
   auPomf7iG1iAOHAM1KByj9f0JhTqvyem/kQ2nRWTW7/SYvF0wugeAyooE
   jFVgCXEx56jgIWIBh3LfwgFsRwLoFMko5IG70RSG/4VlWETumDuNtG/r2
   I2ddnmu2CjD2GAprnDkKUn6h3vYB2kb/0YyqNjzI6qWCIpghxfUhNRgj5
   0LvQ3298Ex5eKx2al230sFeiuLDx0TFafFCKMCs2FL8HUbQfPPaAmgQTb
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] mtd: phram improvements
Date:   Tue, 12 Apr 2022 15:52:58 +0200
Message-ID: <20220412135302.1682890-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- Fix build error on some configs.
- Reword binding.
- Added note about alternatives in cover letter (see below)

v2:
- Add note on what "phram" means in binding.
- Use /schemas/mtd/mtd.yaml instead of relative pathUse /schemas/mtd/mtd.yaml
  instead of relative path in binding.

The phram driver in the MTD subsystem can be used to allow the kernel to use an
MTD or (via mtdblock) a block device in RAM (with the contents loaded by a
bootloader for example).  This series has some improvements to make it more
usable by adding device tree support and to significantly improve its
performance by using cached mappings when possible.

I use this feature to pass the squashfs rootfs to the kernel when booting from
RAM.  The boot is much faster and requires less memory than initrd (which is on
top of that being deprecated), and it allows the same disk images to be used
when booting from RAM, unlike initramfs.

If there is no interest in extending the phram driver to support this, an
option is to use a new custom block driver.  I have patches for that too.  That
will not support MTDs of course, but it works for block devices and it is
faster and smaller than mtdblock + MTD + phram.

Cc: linux-mtd@lists.infradead.org

Cc: devicetree@vger.kernel.org
Cc: robh+dt@kernel.org
Cc: krzk+dt@kernel.org
Cc: frowand.list@gmail.com

Cc: linux-kernel@vger.kernel.org

Vincent Whitchurch (4):
  mtd: core: Check devicetree alias for index
  dt-bindings: reserved-memory: Support MTD/block device
  mtd: phram: Allow probing via reserved-memory
  mtd: phram: Allow cached mappings

 .../bindings/reserved-memory/phram.yaml       | 47 +++++++++++
 drivers/mtd/devices/phram.c                   | 78 +++++++++++++++++--
 drivers/mtd/mtdcore.c                         | 11 ++-
 drivers/of/platform.c                         |  1 +
 4 files changed, 129 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/phram.yaml

-- 
2.34.1

