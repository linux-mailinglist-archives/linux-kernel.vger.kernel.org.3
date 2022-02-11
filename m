Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B66D4B2D64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344881AbiBKTMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:12:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiBKTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:12:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8596938F;
        Fri, 11 Feb 2022 11:12:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40E1CB82C0E;
        Fri, 11 Feb 2022 19:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A4DC340ED;
        Fri, 11 Feb 2022 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644606762;
        bh=8mkUbS5/eb9njDiC5YQ9RiPIC0sVkH1EcbyzWZEu/ZE=;
        h=From:To:Cc:Subject:Date:From;
        b=QYADHZXg4w6ohZhB8o6Lvw2BwpqQwVh49m/1thAzio/0ZqZpwpEHz5s5hsLmTK9dP
         3V93ktgFkOnRbbqmTDO0vGgBVYQJyhVqJVdwGP/HLF0/zuriA3nnP3A2ybGTE7NoRr
         HLyzw7BuRzc4xNwWQUYKZ/2iSv6xuj1oUJihwjfaOH8kYAC1qktFV/pR9MkRlUmmud
         +uV4VvEK8E0xDyYnaEm4xpwVQ3iAOb6K+kcoh12NsOuWJGg+Pw6DpwvFRp9C3ANMlf
         1l1czLsTgbwda4Nx2PgxeDwFLEuimc7HmCK62TQBAoBSWPk6/aWe7Qy/VSIlmbNFZH
         RgSCpUYDDlmqQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v8 0/6] serial: mvebu-uart: Support for higher baudrates
Date:   Fri, 11 Feb 2022 20:12:32 +0100
Message-Id: <20220211191238.2142-1-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg, Stephen, Gregory,

at Pali's request I have reviewed, updated and tested his series adding
support for higher baudrates on Marvell Armada A37xx boards.

I have updated commit messages, some comments and indentation at some
places. As per Stephen Boyd's request, commit message of patch 3 now
contains more information about why we need to have UART
clock-controller binding defined in such a way (due to backwards
compatibility).

Marek

Changes in v7:
* fixed lint errors in yaml binding file
* added Reviewed-by tags
* changed commit messages and comments a little
* fixed indentation at some places
* swapped patch 2 and 3 (dt-binding defining new binding should go
  before the driver adding usage of that new binding)

Changes in v6:
* fixed yaml binding file and dts files

Changes in v5:
* fixed yaml binding file

Changes in v4:
* converted armada3700-uart-clock documentation to YAML
* split documentation changes into two commits:
  - first which adds clock documentation
  - second which updates UART documentation

Changes in v3:
v3 is rebased on top of Linus master branch and all already applied patches
were dropped. There are no changes in patches itself since v2.

Pali Rohár (6):
  math64: New DIV_U64_ROUND_CLOSEST helper
  dt-bindings: mvebu-uart: document DT bindings for
    marvell,armada-3700-uart-clock
  serial: mvebu-uart: implement UART clock driver for configuring UART
    base clock
  dt-bindings: mvebu-uart: update information about UART clock
  arm64: dts: marvell: armada-37xx: add device node for UART clock and
    use it
  serial: mvebu-uart: implement support for baudrates higher than 230400
    Bd

 .../clock/marvell,armada-3700-uart-clock.yaml |  59 ++
 .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  14 +-
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/mvebu-uart.c               | 596 +++++++++++++++++-
 include/linux/math64.h                        |  13 +
 6 files changed, 671 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml

-- 
2.34.1

