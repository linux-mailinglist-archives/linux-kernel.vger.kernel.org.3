Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08A94BC923
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiBSP2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:28:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiBSP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:28:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2325D1B4;
        Sat, 19 Feb 2022 07:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C9B760B49;
        Sat, 19 Feb 2022 15:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CB4C004E1;
        Sat, 19 Feb 2022 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645284503;
        bh=Zp99ZALL2GLR+KoST1rSrJJL3Bn7AKOzAhGX3czeT7c=;
        h=From:To:Cc:Subject:Date:From;
        b=fkPVJSh+nU3kVkf7wDGr1M6JV9aX+bpsLtx7KibilB8P2BvEs0WwcsuvoVrYCGIha
         xc8ipPf3f96nMCdIb2idOqG2Iv4wMql+DomJNxT70VvKS6u8cmLk5UUpovbz0yPmST
         6vP2u32yYX2xZff7KCpAdgsLjkejWMwuscCljThdaE8GtsaqvmkTP9ypTIzSO4x5VW
         bZnvrMot57eqTTO8jFzilW+DOayNg/N67zNexYZdbrmfBjKxfQctESVrJAf0o8uubW
         Oxq6Si7Tepf8MCtf2NGbXl5S1TRXINDy2Lky2Ckbd3+UzjTPG1590OV6cwV2HSwJ9q
         XOvKTp273idxQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v9 0/6] serial: mvebu-uart: Support for higher baudrates
Date:   Sat, 19 Feb 2022 16:28:12 +0100
Message-Id: <20220219152818.4319-1-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

this is v9 of series adding support for higher baudrates on A37xx UART.

I've fixed the two things discovered in v8 (commit message typo and
order of last two patches).

Marek

Changes since v8:
* fixed typo in commit message of patch 3
* switched patches 5 and 6 as requested by Gregory Clement

Changes since v7:
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
  serial: mvebu-uart: implement support for baudrates higher than 230400
    Bd
  arm64: dts: marvell: armada-37xx: add device node for UART clock and
    use it

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

