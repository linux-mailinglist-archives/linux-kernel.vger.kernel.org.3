Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D134D23B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiCHV6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350525AbiCHV5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:57:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D5E50E07;
        Tue,  8 Mar 2022 13:56:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47A70B81E00;
        Tue,  8 Mar 2022 21:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E0AC340EC;
        Tue,  8 Mar 2022 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646776614;
        bh=4XzJPlpa9kz5NaKF4aBUOW8yQiX35WK9mvoNY2IoxUc=;
        h=From:To:Cc:Subject:Date:From;
        b=EdmwsT93cR85kvRGXLJNWLy6O+FHjhyliK7EJ2gURYymWVwKiJGa5JJZtzjzXA1ZN
         YKChNieE4EHJIKTlWdwmavfCZpbxUvGJ2i+dSKWeK6ZMKA5htfKVZW+5yvYJcp3+fR
         HJ9M0ZjWf4lSlL3rpybHW1ylLH+dAK+Zanvv5wj09/ql5hre80r4WXl3BQM0iZi4xv
         tZo1zFyvL1T4fhtUtc95NR8ZVKJoxHSta/wpUQqCZv8of7SMwXc3hqA3UUzlQaiP77
         0sWvPfS2CuOGsBg5pB41wJmKOXNBGMSXC/kkopstfr251l89gth13ExQ4Fv5V9wTcR
         xSuGfanLtjBEg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     alexs@kernel.org, arnd@arndb.de, arnd@kernel.org, dsterba@suse.com,
        elver@google.com, jani.nikula@intel.com, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mark.rutland@arm.com,
        ndesaulniers@google.com, ojeda@kernel.org,
        torvalds@linux-foundation.org
Subject: [PATCH 0/4] [v4] Kbuild: std=gnu11 changes
Date:   Tue,  8 Mar 2022 22:56:11 +0100
Message-Id: <20220308215615.14183-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I've incorporated the feedback from Masahiro Yamada in this
version, splitting out one more patch, rebasing on top of 
the kbuild tree, and changing the order of the patches.

Please apply to the kbuild tree.

       Arnd

Cc: linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev

Arnd Bergmann (3):
  [v4] Kbuild: add -Wno-shift-negative-value where -Wextra is used
  [v4] Kbuild: move to -std=gnu11
  Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS

Mark Rutland (1):
  [v4] Kbuild: use -Wdeclaration-after-statement

 Documentation/process/programming-language.rst             | 6 +++---
 .../translations/it_IT/process/programming-language.rst    | 4 ++--
 .../translations/zh_CN/process/programming-language.rst    | 3 +--
 .../translations/zh_TW/process/programming-language.rst    | 3 +--
 Makefile                                                   | 7 ++++---
 arch/arm64/kernel/vdso32/Makefile                          | 3 ++-
 drivers/gpu/drm/i915/Makefile                              | 1 +
 drivers/staging/greybus/tools/Makefile                     | 3 ++-
 fs/btrfs/Makefile                                          | 1 +
 scripts/Makefile.extrawarn                                 | 1 +
 scripts/mod/modpost.c                                      | 4 +++-
 11 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.29.2

