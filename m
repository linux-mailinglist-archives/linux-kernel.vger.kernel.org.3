Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7964ED054
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiC3Xr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351876AbiC3Xru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:47:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9CE62A38;
        Wed, 30 Mar 2022 16:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62C3F61835;
        Wed, 30 Mar 2022 23:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23781C340EC;
        Wed, 30 Mar 2022 23:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648683962;
        bh=GKY2nkutF3lmAHdPzsNgl0EhMG/oi0wjZcHuQTHuwrM=;
        h=From:To:Cc:Subject:Date:From;
        b=VPX8T1PPxXCJI5oINyci0DA2oKkDf22JKFLyECkGzPY6GHVu+wwr2jWMXsJosAF9Q
         lk9xQn7DCZ3d6qG5gbtU0H+Lmk9RI9uiAYxUQfKLoD0BdFNCyRBSnkYhndxIgWgQCU
         Bz8svjBs7G3qeAHCoPNkg82/IghYre8HUYqEtr4DLBBpktDmm6nXIVNWdtBReuODPp
         ELqRBmjgE7TWmxzRteU2WV/czoARDZjyRhWDlP+UqWGA+FWl7EK4gq39svJ2ceSDHf
         7iRgLEkuK487quar4414lvtx/NAQk3ZIoG2rKlTsPR85fR68kYE+JtjfGo0pChuw5V
         hYBuV5jR4sIuA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] Remove '-mno-global-merge' from KBUILD_CFLAGS
Date:   Wed, 30 Mar 2022 16:45:26 -0700
Message-Id: <20220330234528.1426991-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

As discussed at [1] and [2], this series removes '-mno-global-merge'
from KBUILD_CFLAGS for clang, as it causes warnings for UML, and it
no longer appears to be necessary, as I do not see any modpost warnings
with LLVM 11 through 15 with several different ARCH=arm and ARCH=arm64
configurations.

[1] is currently in the UML tree, destined for 5.18, but it is buggy, as
I note in [2]. This series is an alternative to [2], which has not been
picked up yet, so it is based on the current UML tree. If [2] is picked
up, I can rework the first patch to remove the '-mno-global-merge'
filtering from arch/um/Makefile; otherwise, this should be picked up in
place of [2].

I intentionally kept the first patch vague around what fixed the modpost
warnings, as I am not too sure. [3] seems somewhat likely, but I don't
think that will revert cleanly on main to test. I think the testing is
enough to show that the original issue is resolved but I do note that we
can add this flag back in the architecture specific Makefiles if needed.

Please review and ack as necessary.

[1]: https://lore.kernel.org/r/20220303090643.241747-1-davidgow@google.com/
[2]: https://lore.kernel.org/r/20220322173547.677760-1-nathan@kernel.org/
[3]: https://github.com/llvm/llvm-project/commit/863bfdbfb446adaef767ff514d1f2ffb5d489562

Nathan Chancellor (2):
  kbuild: Remove '-mno-global-merge'
  Revert "um: clang: Strip out -mno-global-merge from USER_CFLAGS"

 Makefile         | 4 ----
 arch/um/Makefile | 4 ----
 2 files changed, 8 deletions(-)


base-commit: 82017457957a550d7d00dde419435dd74a890887
-- 
2.35.1

