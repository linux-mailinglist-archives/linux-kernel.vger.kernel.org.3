Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA24659A61E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350836AbiHSTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350282AbiHSTRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:17:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5370112332
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DB03B827CD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6356C433D6;
        Fri, 19 Aug 2022 19:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660936620;
        bh=o2xdg2Rv7BFF7s0EqoFYePZNdZZxEEpjrxSZiJdS454=;
        h=From:To:Cc:Subject:Date:From;
        b=BT30kbtwqKYX/hXb+AIqTNCjLdPWg82/lzDYYjxClWZzn9WmenyRGsHjghTYqoPNz
         WaH7bZYWNedvwGKYJHuTPLTAJ8oAlbv1yjXbyInsNU4ZPSc3el3HkbWKADtEigEOU5
         vVB7JnF6xsTOXsXooBUdYgJeKtUclQLnVhE32MLBm4Rf9gZMPFF2WRlRdi9UHiH2eh
         sYdyf1PfpB/sGVB8B7zIGhAo3YKK5FKueJRJJP24FK48o/z+DVgSnkFosfaagHHNWV
         xrI4gw0BzDsRWXi9xUwXuzGP1sX0yDSv5iGuBLqQ9QDXMo5oY8wJo+9bxQvyULLvhT
         h6AojjkBNNeCQ==
Received: by pali.im (Postfix)
        id DDAA3761; Fri, 19 Aug 2022 21:16:56 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sinan Akman <sinan@writeme.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] powerpc/85xx: p2020: Create one unified machine description
Date:   Fri, 19 Aug 2022 21:15:50 +0200
Message-Id: <20220819191557.28116-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

This patch series unifies all P2020 boards and machine descriptions into
one generic unified P2020 machine description. With this generic machine
description, kernel can boot on any P2020-based board with correct DTS
file.

Tested on CZ.NIC Turris 1.1 board with has Freescale P2020 processor.
Kernel during booting correctly detects P2020 and prints:
[    0.000000] Using Freescale P2020 machine description

Pali Rohár (7):
  powerpc/85xx: Mark mpc85xx_rdb_pic_init() as static
  powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
  powerpc/85xx: p2020: Move all P2020 machine descriptions to p2020.c
  powerpc/85xx: p2020: Unify .setup_arch and .init_IRQ callbacks
  powerpc/85xx: p2020: Define just one machine description
  powerpc/85xx: p2020: Enable boards by new config option CONFIG_P2020
  powerpc: dts: turris1x.dts: Remove "fsl,P2020RDB-PC" compatible string

 arch/powerpc/boot/dts/turris1x.dts            |   2 +-
 arch/powerpc/platforms/85xx/Kconfig           |  22 ++-
 arch/powerpc/platforms/85xx/Makefile          |   1 +
 arch/powerpc/platforms/85xx/mpc85xx_ds.c      |  25 +--
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  46 +-----
 .../platforms/85xx/{mpc85xx_ds.c => p2020.c}  | 144 +++++++-----------
 6 files changed, 75 insertions(+), 165 deletions(-)
 copy arch/powerpc/platforms/85xx/{mpc85xx_ds.c => p2020.c} (53%)

-- 
2.20.1

