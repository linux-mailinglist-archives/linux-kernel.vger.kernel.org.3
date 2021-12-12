Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DEB47180E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhLLDrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhLLDrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:47:43 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2CFC061714;
        Sat, 11 Dec 2021 19:47:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C152B419BC;
        Sun, 12 Dec 2021 03:47:36 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Apple SPI controller driver
Date:   Sun, 12 Dec 2021 12:47:23 +0900
Message-Id: <20211212034726.26306-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This short series adds a new SPI controller driver for Apple SoCs.
It is based on spi-sifive. It has been tested with the generic
jedec,spi-nor support and with a patched up input/keyboard/applespi.c
(though we're going to write a new driver for the keyboard; that's a
story for another time).

As usual, I'm splitting off the MAINTAINERS and DT binding changes.
We would rather merge the MAINTAINERS change through the Asahi-SoC
tree to avoid merge conflicts as things trickle upstream, since
we have other submissions touching that section of the file.

The DT binding change can go via the SPI tree or via ours, but it's
easier if we merge it, as then we can make the DT changes to
instantiate it without worrying about DT validation failures depending
on merge order.

Hector Martin (3):
  MAINTAINERS: Add apple-spi driver & binding files
  dt-bindings: spi: apple,spi: Add binding for Apple SPI controllers
  spi: apple: Add driver for Apple SPI controller

 .../devicetree/bindings/spi/apple,spi.yaml    |  63 ++
 MAINTAINERS                                   |   2 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-apple.c                       | 566 ++++++++++++++++++
 5 files changed, 640 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/apple,spi.yaml
 create mode 100644 drivers/spi/spi-apple.c

-- 
2.33.0

