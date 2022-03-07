Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95B84D0514
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbiCGRSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiCGRSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:18:37 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C61261E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:17:42 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7848D40005;
        Mon,  7 Mar 2022 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646673460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uAiCuWoMbD3fjoAvdv+nrJeK43GJCyewkymDyP5ee7I=;
        b=ipWv51NMK/X6ZXHmPyxKkgw4EkZFEb8BgFqVaqFHvvqo9HGJDteh9OmuEbaCbq4g8VyW3l
        5wm76igc3zZJnz5THFbRm7Wrb71elSSTIAS7HwJlMsv5Vek0BT50LSFuTjgO6J6utZHa58
        k78eVnQGO/4ziObl4ch+5ema4l1yVVqghP54R+5CHaNsE75L5du/Cv06sJM3GIy6MVs9qc
        JVuW9Nu7yeFjNVDqZBmuSavFFG0xTajlABG6R70CaAtlc5lJnxPLJiopUkW9d02awqlwin
        da+Ypihm3Ji7nVY68YtW2SibPAcbYpPp41LWzVuEPRW4PdVPrDEP9H3lzObrWQ==
Date:   Mon, 7 Mar 2022 18:17:34 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for the next -rc/v5.17 final
Message-ID: <20220307181734.750b4661@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.17-rc8

for you to fetch changes up to 42da5a4ba17070e9d99abf375a5bd70e85d2a6b8:

  mtd: rawnand: omap2: Actually prevent invalid configuration and build error (2022-03-07 17:46:54 +0100)

----------------------------------------------------------------
As part of a previous changeset introducing support for the K3
architecture, the OMAP_GPMC (a non visible symbol) got selected by the
selection of MTD_NAND_OMAP2 instead of doing so from the architecture
directly (like for the other users of these two drivers). Indeed, from a
hardware perspective, the OMAP NAND controller needs the GPMC to
work.

This led to a robot error which got addressed in fix merge into
-rc4. Unfortunately, the approach at this time still used "select" and
lead to further robot reports.

This time we switch to "depends on" in order to prevent random
misconfigurations. The different dependencies will however need a future
cleanup.

----------------------------------------------------------------
Roger Quadros (1):
      mtd: rawnand: omap2: Actually prevent invalid configuration and build error

 drivers/mtd/nand/raw/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
