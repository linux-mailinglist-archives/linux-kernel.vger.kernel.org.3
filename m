Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D9A4AE111
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385116AbiBHSlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbiBHSlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:41:42 -0500
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5533EC0613C9;
        Tue,  8 Feb 2022 10:41:38 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1644345292; bh=qwDk3NRHUss8TCYpvU94JsFuSuZCb0TDgOBElpe8C1I=;
        h=From:To:Cc:Subject:Date;
        b=qVvJLIiiQ/plel3G1U1sBOEr+yT7cKbrhTU/snWoPZUVRlNlBIyZ0WHJCisZc8zFk
         IippyJsezK/c/tL8hnvw158TfJBf9tkOAFhd0MWifj3KQCYVxVJqxllObbbrMYkV7l
         OPSqEIzM7BK1W1VZXwGK4adUv7iX1MRuNxih/77s=
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH v4 0/3] Support for Apple SoCs' NCO blocks
Date:   Tue,  8 Feb 2022 19:34:08 +0100
Message-Id: <20220208183411.61090-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is v4 of common clock driver for NCO blocks on Apple SoCs. I have to send v4
because to some people I inadvertently send their copy of v3 PGP-encrypted.

Changes since v3:

 - change my email address
 - set MODULE_LICENSE to 'GPL' (was 'GPL v2')

Changes since v2:

 - move all under applnco_ prefix
 - move away from signed types in register value calculations
 - other minor things from Stephen's review

Changes since v1:

 - drop apple,nchannels property from the binding, rely on size of the register
   range instead to gauge the number of channels
 - add a lock to guard set_rate from racing with clock disable/enable
 - add short "theory of operation" comment
 - incorporate minor changes from Rob's, Sven's and Stephen's review (thanks!)

Martin

v1: https://lore.kernel.org/linux-clk/20211214120213.15649-1-povik@protonmail.com/
v2: https://lore.kernel.org/linux-clk/20220118191839.64086-1-povik+lin@protonmail.com/
v3: https://lore.kernel.org/linux-clk/20220121175441.9944-1-povik+lin@protonmail.com/

Martin Povišer (3):
  dt-bindings: clock: Add Apple NCO
  clk: clk-apple-nco: Add driver for Apple NCO
  MAINTAINERS: Add clk-apple-nco under ARM/APPLE MACHINE

 .../devicetree/bindings/clock/apple,nco.yaml  |  62 ++++
 MAINTAINERS                                   |   2 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-apple-nco.c                   | 333 ++++++++++++++++++
 5 files changed, 407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml
 create mode 100644 drivers/clk/clk-apple-nco.c

-- 
2.33.0

