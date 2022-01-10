Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9794489FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbiAJTNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242602AbiAJTNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:13:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ABDC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:13:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a18so56609074edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BoP1G46rPlFtsHhN/PqC1uH6olKYYS83SHhNDUnVgJY=;
        b=13Zy1aSws1bkUkLo9uf+hjTfMfN+2DvO+w8FUiAEr0F70I3xdJqvvyvRg2p5Xi4+8a
         wOlBVoXcInaOCRUMZGgt2onmqf5BMZDm3H5ENelAH0Cv4T9eBhbzeBMljqfnH/rdMNJv
         a7EUN4jTMwrhYL9AcWTFqKs1rEz4O5+VWZCA0gorHRs2S+b9yOr6agVhqgfGTcLrMUp1
         +ci17KMjPBcITgrxPXXHY2MIuO+jNf7qMCGl0JeJ/uXeMBykKC1rAkGf/k/w0NF3WT7G
         TN5IraDee4hmq9STiNHbZ9L3AZE5FnHUrjEqBCrOflxzeVKkezIeZhBHsKeaO3pwrYAf
         GrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BoP1G46rPlFtsHhN/PqC1uH6olKYYS83SHhNDUnVgJY=;
        b=X+4qSS2Wkz83OTak+/TWWClrqSOgQ8LQCJIk0BFgrZC/3o6tNexUfHK0AUdVTH9hT0
         w7dm5vZPTSfk5gvP7zrM6+MF5me8j+vrACtiRJ4dG98fo/jUOWvro1jycrt0PuqhaGFO
         7fZYJatXD9g/RREGS2PFZU4PEFKGTYXiAR7hGMhitD++hMfn5V8NN8BzCpak2P5TO4QA
         yEE/nr+ulzWnHbq5kcieEb1jUU73cjNQ0j0TXebZuipgrABKy6juzJqCRvtIE/1Cemtt
         N05voRwfQX1VAFWs3YPNiSqTqprkrRRKcwVYF2IIolGGPgZw0Fa9maqp8aB5HGQtFBZL
         W87w==
X-Gm-Message-State: AOAM5305s6PF2VIQJepfGZiQpj678I6eKqpHY/AuDN1eJCkLuRrU7g1s
        7BjhIHpUzvPTlP8qlolS1QhgwVBEW/OR6ut8W97vYFTUugTI
X-Google-Smtp-Source: ABdhPJziaH0HLf/xJ8xouOSKSmXXC4GZMZNDlmr5JVyrgZ/c/DXmm7JzB/Z0fBUDpuwO+XtDwYHu3KkewbJw5MN81DQ=
X-Received: by 2002:a17:907:1b0d:: with SMTP id mp13mr880890ejc.29.1641842018874;
 Mon, 10 Jan 2022 11:13:38 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jan 2022 14:13:27 -0500
Message-ID: <CAHC9VhRS4a2iK-n8mmo+5qKZ2jz6k6oie6isEPP1Qc=LEWc+cQ@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Nothing too significant, but five SELinux patches for v5.17 that do
the following:

- Hardened the code through additional use of the struct_size() macro.
- Plugged some memory leaks.
- Cleaned up the code via removal of the security_add_mnt_opt() LSM
hook and minor tweaks to selinux_add_opt().
- Renamed security_task_getsecid_subj() to
security_current_getsecid_subj() to better reflect its actual
behavior/use.

Please merge.

-Paul

--
The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

 Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20220110

for you to fetch changes up to 6cd9d4b97891560b61681cad9cc4307ce0719abc:

 selinux: minor tweaks to selinux_add_opt() (2021-12-21 15:14:45 -0500)

----------------------------------------------------------------
selinux/stable-5.17 PR 20220110

----------------------------------------------------------------
Bernard Zhao (1):
     selinux: fix potential memleak in selinux_add_opt()

Ondrej Mosnacek (1):
     security,selinux: remove security_add_mnt_opt()

Paul Moore (2):
     lsm: security_task_getsecid_subj() -> security_current_getsecid_subj()
     selinux: minor tweaks to selinux_add_opt()

Xiu Jianfeng (1):
     selinux: Use struct_size() helper in kmalloc()

include/linux/lsm_hook_defs.h         |  5 +--
include/linux/lsm_hooks.h             | 10 ++---
include/linux/security.h              | 12 +----
kernel/audit.c                        |  4 +-
kernel/auditfilter.c                  |  3 +-
kernel/auditsc.c                      | 11 ++++-
net/netlabel/netlabel_unlabeled.c     |  2 +-
net/netlabel/netlabel_user.h          |  2 +-
security/apparmor/lsm.c               | 13 ++++--
security/integrity/ima/ima_appraise.c |  2 +-
security/integrity/ima/ima_main.c     | 14 +++---
security/security.c                   | 14 ++----
security/selinux/hooks.c              | 84 +++++++------------------------
security/selinux/ss/sidtab.c          |  2 +-
security/selinux/xfrm.c               |  4 +-
security/smack/smack.h                | 16 -------
security/smack/smack_lsm.c            |  9 ++--
17 files changed, 70 insertions(+), 137 deletions(-)

-- 
paul moore
www.paul-moore.com
