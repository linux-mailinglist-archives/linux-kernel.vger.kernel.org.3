Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787144F4A62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiDEWlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384347AbiDEOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:18:01 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF392E09E;
        Tue,  5 Apr 2022 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649163839;
  x=1680699839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LB9Z91H4lxNWiHmnPf+yOrh5/8wfRKj1DRyzVPm5Z0s=;
  b=WUZj+nhNaQk+plWanfhUOe+OsLv68D/+hZsmIxc3F7IhlWxRaDIg81Jf
   mrV7Rnur5M93c1gfVtOZTNZaynpnE35xTtz1zCyWQXhS3rH1Xm7JpVBoQ
   HVHmPp81CxvwmrKQS33lkypf1dXHcVlwg5EQvCsE3+g6eHejF/KHcx0Q+
   BkiiMWRNIZWp4bbF/Ruwn/wKI6YmehfD/JZiaS+WPYPYQwEm4IT0UFRW/
   PJv5G4CbGoGi99GyNdIsPXxbemScV3FTTH/u3U6FZCoBJCqKTJKuMdTgN
   eay7AyS3hki5eMrm76CcDIIR71yaYJQsSQm4za/tYVRsfbcZxnINxwDtg
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] mtd: phram improvements
Date:   Tue, 5 Apr 2022 15:03:46 +0200
Message-ID: <20220405130350.1640985-1-vincent.whitchurch@axis.com>
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

v2:
- Add note on what "phram" means in binding.
- Use /schemas/mtd/mtd.yaml instead of relative pathUse /schemas/mtd/mtd.yaml
  instead of relative path in binding.

The phram driver in the MTD subsystem can be used to allow the kernel to use an
MTD or (via mtdblock) a block device in RAM (with the contents loaded by a
bootloader for example).  This series has some improvements to make it more
usable by adding device tree support and to significantly improve its
performance by using cached mappings when possible.

I use this feature to pass the rootfs to the kernel when booting from RAM.  The
boot is much faster and requires less memory than initrd (which is on top of
that being deprecated), and it allows the same disk images to be used when
booting from RAM, unlike initramfs.

Cc: linux-mtd@lists.infradead.org

Cc: devicetree@vger.kernel.org
Cc: robh+dt@kernel.org
Cc: krzk+dt@kernel.org
Cc: frowand.list@gmail.com

Cc: linux-kernel@vger.kernel.org

Vincent Whitchurch (4):
  mtd: core: Check devicetree alias for index
  dt-bindings: reserved-memory: Add phram
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

