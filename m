Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED34E50E648
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbiDYQ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiDYQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459743AA7A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:54:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A497D6148F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E4DC385A4;
        Mon, 25 Apr 2022 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650905660;
        bh=LAvXRisArrRdEcB0PKg1yD+9tEfDqEzSgD//WM5MfZI=;
        h=Date:From:To:Cc:Subject:From;
        b=OaQIKlE3ZclurMEiaNRU+4W58DXIBbh9proFJJCfC9SknLZMZxCxySZXN2gfMNj65
         KYE0BgQqXgAgskJNbUgyrrzrQBRKopXYfgvWyuXCNXyHB34hWboynf1+SsqtR81jhA
         VETHmfzfHhTkelRjMsSGGtlhnW6YhpaD9m4VnC8lTXVk0VlcUX230WjlFedhjovXKm
         KOkuR+liHyAhQ+z4cypFnuUEFuXTp6Uqs27AKbB3wy0QeFlLnj+Vb2j9cQKBmX0NJ5
         wI/aRatPYgP+s7/zqox0Yimb0TVfbU9a6C9FsNNzH6AqGVQd97ovtC+SwEFo6fijFH
         0eNNXHqZQ1XoQ==
Date:   Mon, 25 Apr 2022 09:54:18 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs fix for 5.18
Message-ID: <YmbSOkjjP5ekfcGk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-5.18

for you to fetch changes up to 4d8ec91208196e0e19195f1e7d6be9de5873f242:

  f2fs: should not truncate blocks during roll-forward recovery (2022-04-21 18:57:09 -0700)

----------------------------------------------------------------
f2fs-fix-5.18

This includes major bug fixes introduced in 5.18-rc1 and 5.17+.

- Remove obsolete whint_mode (5.18-rc1)
- Fix IO split issue caused by op_flags change in f2fs (5.18-rc1)
- Fix a wrong condition check to detect IO failure loop (5.18-rc1)
- Fix wrong data truncation during roll-forward (5.17+)

----------------------------------------------------------------
Jaegeuk Kim (4):
      f2fs: remove obsolete whint_mode
      f2fs: keep io_flags to avoid IO split due to different op_flags in two fio holders
      f2fs: fix wrong condition check when failing metapage read
      f2fs: should not truncate blocks during roll-forward recovery

 Documentation/filesystems/f2fs.rst | 70 ----------------------------
 fs/f2fs/checkpoint.c               |  6 +--
 fs/f2fs/data.c                     | 33 ++++++++-----
 fs/f2fs/f2fs.h                     |  9 ----
 fs/f2fs/inode.c                    |  3 +-
 fs/f2fs/segment.c                  | 95 --------------------------------------
 fs/f2fs/super.c                    | 32 +------------
 7 files changed, 27 insertions(+), 221 deletions(-)

