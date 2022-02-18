Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F684BBAC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiBROgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:36:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiBROgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:36:39 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711822819B3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:36:22 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2AB03C0007;
        Fri, 18 Feb 2022 14:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645194980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fn3nkzJzBFVgF8fM2FSj8yDW3bHjsPdv9AqR1HVmuV8=;
        b=Irw1b76E+oIhx1Kpfcdcml+M1OiiD2cgBNcJAMCO6kinh7CMUOUIxfcksMHIXZedB7oB07
        d8qgOLFVd2GvoSYed/reJERhgP48VsaPIMMcBUKj3HvDqT15hcU92+SfvgYsj+6Dzmg0ru
        o5j+7c0dFkwNuluIcaD4+ZnYVTtN4gMdpuhN61RER/O1aCxHEAQYSAMEQwiG5rQGb7aaRp
        w2gvDkunDOrGs7AwGPw9XFmky7VY7vxqxvv1zEkMoVdamMvTYS13y6OGGnBxM6mtGMS7R0
        +aFCM6SXZ8lDc/JZLjfQVE5tcGWQAxD43a1B+XVMo8esum5/qkU48aoVZO4drA==
Date:   Fri, 18 Feb 2022 15:36:17 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v5.17-rc5
Message-ID: <20220218153617.016a905a@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is a fixes MTD PR for the next -rc.

Thanks,
Miqu=C3=A8l

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-5.17-rc5

for you to fetch changes up to 36415a7964711822e63695ea67fede63979054d9:

  mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status (2022-01-31 1=
7:08:56 +0100)

----------------------------------------------------------------
MTD changes:
* Qcom:
  - Don't print error message on -EPROBE_DEFER
  - Fix kernel panic on skipped partition
  - Fix missing free for pparts in cleanup
* phram: Prevent divide by zero bug in phram_setup()

Raw NAND controller changes:
* ingenic: Fix missing put_device in ingenic_ecc_get
* qcom: Fix clock sequencing in qcom_nandc_probe()
* omap2: Prevent invalid configuration and build error
* gpmi: Don't leak PM reference in error path
* brcmnand: Fix incorrect sub-page ECC status

----------------------------------------------------------------
Ansuel Smith (2):
      mtd: parsers: qcom: Fix kernel panic on skipped partition
      mtd: parsers: qcom: Fix missing free for pparts in cleanup

Bryan O'Donoghue (2):
      mtd: rawnand: qcom: Fix clock sequencing in qcom_nandc_probe()
      mtd: parsers: qcom: Don't print error message on -EPROBE_DEFER

Christian Eggers (1):
      mtd: rawnand: gpmi: don't leak PM reference in error path

Dan Carpenter (1):
      mtd: phram: Prevent divide by zero bug in phram_setup()

Miaoqian Lin (1):
      mtd: rawnand: ingenic: Fix missing put_device in ingenic_ecc_get

Roger Quadros (1):
      mtd: rawnand: omap2: Prevent invalid configuration and build error

david regan (1):
      mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status

 drivers/mtd/devices/phram.c                | 12 ++++++++----
 drivers/mtd/nand/raw/Kconfig               |  3 ++-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c   |  2 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c |  3 ++-
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c |  7 ++++++-
 drivers/mtd/nand/raw/qcom_nandc.c          | 14 ++++++--------
 drivers/mtd/parsers/qcomsmempart.c         | 36 +++++++++++++++++++++++---=
----------
 7 files changed, 48 insertions(+), 29 deletions(-)
