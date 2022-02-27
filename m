Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5CA4C5A5A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiB0KBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiB0KBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:01:36 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7EA5B893;
        Sun, 27 Feb 2022 02:00:57 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K5zY33XD1z9sSq;
        Sun, 27 Feb 2022 11:00:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LdNfrufnK6HX; Sun, 27 Feb 2022 11:00:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K5zY25X9kz9sSG;
        Sun, 27 Feb 2022 11:00:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DBCBA8B773;
        Sun, 27 Feb 2022 11:00:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kIXKBl3dZIco; Sun, 27 Feb 2022 11:00:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.62])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 97F068B763;
        Sun, 27 Feb 2022 11:00:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21RA0iA9262867
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 27 Feb 2022 11:00:44 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21RA0hCP262866;
        Sun, 27 Feb 2022 11:00:43 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] Add support for components requiring trailing clock after transfer
Date:   Sun, 27 Feb 2022 11:00:33 +0100
Message-Id: <cover.1645950971.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645956034; l=1411; s=20211009; h=from:subject:message-id; bh=IebqzfmWxu7oC8NSzb59R0Ani2Fs64Wm+uqXMhKSF/Y=; b=7uE0P90tPBEtj5ZR/Io1GAlYC/G5Nv3/lq2wwj5KrylImEwUR2ibG9pLIl49gi3mq/byoKqfdESh HIkhw6XVC5Xvb4b6NVK3kriwltihYieuhene4WlAlk+7SnFbKrUz
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some components require a few clock cycles with chipselect off before
or/and after the data transfer done with CS on.

Typically IDT 801034 QUAD PCM CODEC datasheet states "Note *: CCLK
should have one cycle before CS goes low, and two cycles after
CS goes high".

The cycles "before" are implicitely provided by all previous activity
on the SPI bus. But the cycles "after" must be provided in order to
achieve the SPI transfer.

In order to use that kind of component, implement a new option for
SPI slaves in order to implement a trailing clock of a few bits
with ChipSelect off at the end of the transfer.

This is based on a discussion we had a few years ago, see
https://lore.kernel.org/linux-spi/20160824112701.GE22076@sirena.org.uk/

IDT 801034 QUAD PCM CODEC datasheet can be found at
https://www.renesas.com/eu/en/document/dst/821034-data-sheet?language=en&r=24763

Christophe Leroy (2):
  spi: Add new mode to generate additional clock cycles
  spi: fsl-spi: Implement trailing clock mode

 .../bindings/spi/spi-peripheral-props.yaml        |  4 ++++
 drivers/spi/spi-fsl-lib.c                         |  2 +-
 drivers/spi/spi-fsl-spi.c                         | 15 +++++++++++++--
 drivers/spi/spi.c                                 |  5 ++++-
 include/uapi/linux/spi/spi.h                      |  3 ++-
 5 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.34.1

