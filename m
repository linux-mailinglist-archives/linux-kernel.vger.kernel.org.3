Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C365B4BC851
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 12:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbiBSLxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 06:53:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiBSLxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 06:53:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861424838E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 03:53:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2256760765
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 11:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEDCC004E1;
        Sat, 19 Feb 2022 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645271580;
        bh=AayHqAqVb7KiskS5v6uNdsnkDLQ2GWjesXK+ixoD+Ig=;
        h=From:To:Cc:Subject:Date:From;
        b=GOXKdHBHAqRnJvZYKSwV5LouGWz+n1KirK7LXoeAht4hAPxHpsVZZXxIYq28SyAr/
         MrP0ZvAbGHMSDB7TCS5kIyA9SWrEpwKOVfHtsNqho1N2xmKaFVUOVr6/iizeV90Sw2
         PBn3+WgfGLvGgHDH5N7Ly9mG7Rw5r3hbbtSUUilMTojaSQjMOqjllfKmQUjEHScxDq
         YyDSXPJuc2RkwlCg6iyyVaXcA3q7twDaH59/kVW6DeOX85HbIi7VKROsBvuo//lmsA
         /1bK0oSvUvALO0NueRNGKQK8+4x+iPBIvmFB+cSIDMwr2WJl+t94EnR8xgLRnruVdD
         BhksTd8Ew6dnA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] pidfd for v5.17-rc4
Date:   Sat, 19 Feb 2022 12:50:50 +0100
Message-Id: <20220219115050.3635237-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
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

Hi Linus,

/* Summary */
This fixes a problem reported by lockdep when installing a pidfd via
fd_install() with siglock and the tasklisk write lock held in copy_process()
when calling clone()/clone3() with CLONE_PIDFD.
Originally a pidfd was created prior to holding any of these locks but this
required a call to ksys_close(). So quite some time ago in 6fd2fe494b17
("copy_process(): don't use ksys_close() on cleanups") we switched to a
get_unused_fd_flags() + fd_install() model. As part of that we moved
fd_install() as late as possible. This was done for two main reasons. First,
because we needed to ensure that we call fd_install() past the point of no
return as once that's called the fd is live in the task's file table. Second,
because we tried to ensure that the fd is visible in /proc/<pid>/fd/<pidfd>
right when the task is visible.

This fix moves the fd_install() to an even later point which means that a task
will be visible in proc while the pidfd isn't yet under /proc/<pid>/fd/<pidfd>.
While this is a user visible change it's very unlikely that this will have any
impact. Nobody should be relying on that and if they do we need to come up with
something better but again, it's doubtful this is relevant.

/* Testing */
All patches are based on v5.17-rc3 and have been sitting in linux-next. No
build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts showed up doing a test-merge
with current mainline.

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd.v5.17-rc4

for you to fetch changes up to ddc204b517e60ae64db34f9832dc41dafa77c751:

  copy_process(): Move fd_install() out of sighand->siglock critical section (2022-02-11 09:28:32 +0100)

Please consider pulling these changes from the signed pidfd.v5.17-rc4 tag.

Thanks!
Christian

----------------------------------------------------------------
pidfd.v5.17-rc4

----------------------------------------------------------------
Waiman Long (1):
      copy_process(): Move fd_install() out of sighand->siglock critical section

 kernel/fork.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
