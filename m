Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE9853EB15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbiFFO6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbiFFO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:58:17 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322014093
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:58:16 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7C485FF802;
        Mon,  6 Jun 2022 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654527495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=G5rmJAvan3aX1SCJeI8dLxn4vqFTK+kq/60NkF5cUlI=;
        b=YkhG3XH0X5IhFm7d7W6q5x4fScATmJC+5V9wozKmb+YFtONIA0cWFZPjDK+9vHYupz3t2K
        J3+KBJiPPmx/Z2Ix+ERiU+ykArLaOfZN0PnWzJOqiv8rbSQZuS2XbGvrSVd0hkNQeEtqN0
        RdOA+UI5Gof0wKUOAVCFjLfg/uxq030Q3/pCh8+WhKnEjjE3ZtpgOOweChaZd+cP4Y/IwP
        3/Tz/PoX3oB9WYjBD+roNiX/C/x/pqcr3Koi34uJmguWzAkors3yuo7yrdu1YzXnigNEiD
        /Mq3eN8UlONFDJCStP5qDLNoFoBmisvcD+Wwvd1CNQBGdJszOvGUWlNbWigrag==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/2] ARM: at91: add support for L2 cache write_sec() callback
Date:   Mon,  6 Jun 2022 16:56:59 +0200
Message-Id: <20220606145701.185552-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running under OP-TEE the L2 cache is configured by OP-TEE and
can't be modified for the moment. Add necessary function to get
the current execution world of Linux and add early_setup() callback
that will set the .write_sec() callback for the outer cache.


Clément Léger (2):
  ARM: at91: add sam_linux_is_in_normal_world() function
  ARM: at91: setup outer cache .write_sec() callback if needed

 arch/arm/mach-at91/sam_secure.c |  6 ++++++
 arch/arm/mach-at91/sam_secure.h |  1 +
 arch/arm/mach-at91/sama5.c      | 17 +++++++++++++++++
 3 files changed, 24 insertions(+)

-- 
2.36.1

