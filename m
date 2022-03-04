Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A604CCDCD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiCDGdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiCDGdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:33:42 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968312B19C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:32:52 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2246MIea041904;
        Fri, 4 Mar 2022 14:22:18 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Mar 2022 14:31:44 +0800
From:   Tommy Haung <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH v1 0/2] Add 1024x768 timing for AST2600
Date:   Fri, 4 Mar 2022 14:31:35 +0800
Message-ID: <20220304063137.12970-1-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2246MIea041904
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: 
  Add 1024x768@70Hz for AST2600 soc display timing selection.
  Add gfx flag for future usage.

Testing steps:

    1. Add below config to turn VT and LOGO on.

	CONFIG_TTY=y
	CONFIG_VT=y
	CONFIG_CONSOLE_TRANSLATIONS=y
	CONFIG_VT_CONSOLE=y
	CONFIG_VT_CONSOLE_SLEEP=y
	CONFIG_HW_CONSOLE=y
	CONFIG_VT_HW_CONSOLE_BINDING=y
	CONFIG_UNIX98_PTYS=y
	CONFIG_LDISC_AUTOLOAD=y
	CONFIG_DEVMEM=y
	CONFIG_DUMMY_CONSOLE=y
	CONFIG_FRAMEBUFFER_CONSOLE=y
	CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
	CONFIG_LOGO=y
	CONFIG_LOGO_LINUX_CLUT224=y

  2. The Linux logo will be shown on the screen, when the BMC boot in Linux.
  3. Check the display mode is 1024x768@70Hz at AST2600.
  4. Check the display mode is 800x600@60Hz at AST2500.

Tommy Haung (2):
  drm/aspeed: Add gfx flags and clock selection for AST2600
  drm/aspeed: Add 1024x768 mode for AST2600

 drivers/gpu/drm/aspeed/aspeed_gfx.h      | 15 ++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 35 ++++++++++++++++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 20 ++++++++++++--
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c  | 14 +++++++++-
 4 files changed, 81 insertions(+), 3 deletions(-)

-- 
2.17.1

