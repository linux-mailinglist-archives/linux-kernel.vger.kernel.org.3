Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1FE55EDEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiF1TnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF1TmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:42:02 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0975712AF1;
        Tue, 28 Jun 2022 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656444898; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=/1MnTYWyt51NXn6RgxCYe0CkzHXPTLpl2a2hNvaqk80=;
        b=Cmse+StQGkXxjJjvRcjdNUVdl7CUTH5cxiE8maefVCspFiqAube0HwghR3xy8k8/2kTvYL
        Ai1AaFphQPAlkJ5GZelF5UrIm7fbDGj6PhBDkNIPrypafBbMV32XyyRYFpNgh9djSlZNTc
        3QzwLJ56nhff4M1Ru2hRMn18DUCyF7w=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/8] watchdog: Remove #ifdef guards for PM related functions
Date:   Tue, 28 Jun 2022 20:34:41 +0100
Message-Id: <20220628193449.160585-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After my work [1] to introduce a new set of macros to be used with PM
callback functions, update the few watchdog drivers that do still
protect their .suspend/.resume implementations with a #ifdef guard to
use the new macros instead.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards. Not using #ifdef guards means that the code is
always compiled independently of any Kconfig option, and thanks to that
bugs and regressions are easier to catch.

Cheers,
-Paul

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/pm.h?id=c06ef740d401d0f4ab188882bf6f8d9cf0f75eaf


*** BLURB HERE ***

Paul Cercueil (8):
  watchdog: bcm7038_wdt: Remove #ifdef guards for PM related functions
  watchdog: dw_wdt: Remove #ifdef guards for PM related functions
  watchdog: mtk_wdt: Remove #ifdef guards for PM related functions
  watchdog: s3c2410_wdt: Remove #ifdef guards for PM related functions
  watchdog: sama5d4_wdt: Remove #ifdef guards for PM related functions
  watchdog: st_lpc_wdt: Remove #ifdef guards for PM related functions
  watchdog: tegra_wdt: Remove #ifdef guards for PM related functions
  watchdog: wdat_wdt: Remove #ifdef guards for PM related functions

 drivers/watchdog/bcm7038_wdt.c |  8 +++-----
 drivers/watchdog/dw_wdt.c      |  6 ++----
 drivers/watchdog/mtk_wdt.c     | 10 +++-------
 drivers/watchdog/s3c2410_wdt.c |  9 +++------
 drivers/watchdog/sama5d4_wdt.c |  8 +++-----
 drivers/watchdog/st_lpc_wdt.c  |  9 +++------
 drivers/watchdog/tegra_wdt.c   | 14 +++++---------
 drivers/watchdog/wdat_wdt.c    |  7 ++-----
 8 files changed, 24 insertions(+), 47 deletions(-)

-- 
2.35.1

