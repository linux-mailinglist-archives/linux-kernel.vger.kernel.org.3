Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86E4B7299
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbiBOPmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:42:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241642AbiBOPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:41:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1719DB65
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:35:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C89616A0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15830C340EB;
        Tue, 15 Feb 2022 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644939347;
        bh=WwwCEUptRQNEOeF0BNXF+xx9Qur6a0L+BPYNrj74ML4=;
        h=Date:From:To:cc:Subject:From;
        b=rOHu2/LhaO7fHu2VHeol8vWk8YYZ/0UpeMD4agxzaaHjJMnVrB6/21mitW1d9AWpg
         ulWJBMza1COGX55mrxvXuMIvL1woTzZEj//naGbzGleCXVzH6p1c9T6r0kcfmRUw8P
         IhJRzp9YwOJwbKScFiRj2oZZCVTuy1XBotPGFzlv7fxNhuUynAET0EKWvdnWaJ1hT+
         SZUBPS0cNGhnMxu4lOeL42qgXR2OHfOXdt+qN8X1OHQ6zlXeIPe0wqaVwZFCVZ3eqk
         b65pDxQbtIjJG/L0kUQbv0Gu56Dhy1FFD/Uvg4g+rEZrPeOKIJTVAzw3v1nydFTbJ9
         34OXMKqqW4sKA==
Date:   Tue, 15 Feb 2022 16:35:43 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2202151633100.11721@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem fixes.

=====
- memory leak fix for hid-elo driver (Dongliang Mu)
- fix for hangs on newer AMD platforms with amd_sfh-driven hardware 
  (Basavaraj Natikar )
- locking fix in i2c-hid (Daniel Thompson)
- a few device-ID specific quirks
=====

Thanks.

----------------------------------------------------------------
Alex Henrie (1):
      HID: apple: Set the tilde quirk flag on the Wellspring 5 and later

Basavaraj Natikar (7):
      HID: amd_sfh: Increase sensor command timeout
      HID: amd_sfh: Add illuminance mask to limit ALS max value
      HID: amd_sfh: Handle amd_sfh work buffer in PM ops
      HID: amd_sfh: Correct the structure field name
      HID: amd_sfh: Disable the interrupt for all command
      HID: amd_sfh: Add functionality to clear interrupts
      HID: amd_sfh: Add interrupt handler to process interrupts

Daniel Thompson (1):
      HID: i2c-hid: goodix: Fix a lockdep splat

Dongliang Mu (1):
      HID: elo: fix memory leak in elo_probe

Sergio Costas (1):
      HID:Add support for UGTABLET WP5540

 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             | 76 +++++++++++++++++++++-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h             |  4 +-
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  |  4 +-
 drivers/hid/hid-apple.c                            | 16 ++---
 drivers/hid/hid-elo.c                              |  1 +
 drivers/hid/hid-ids.h                              |  1 +
 drivers/hid/hid-quirks.c                           |  1 +
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c            | 28 ++++----
 8 files changed, 102 insertions(+), 29 deletions(-)

-- 
Jiri Kosina
SUSE Labs

