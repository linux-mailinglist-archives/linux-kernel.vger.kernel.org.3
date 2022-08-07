Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC858B9A4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 07:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiHGFEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 01:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiHGFEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 01:04:06 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07606CE18;
        Sat,  6 Aug 2022 22:04:05 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id v13so3032883vke.3;
        Sat, 06 Aug 2022 22:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tLOHBQaZOIsg9Rm+gqF0Na/UuY2D/0p5RcOU7ABOfsg=;
        b=RPzcBSmoasbhr6paviVd8IydSahFbVk79ZOMUY9upIJzZCRXczx2P39qbQznA3itqC
         M4JefWs1dzl18PxkcAI8nK6q31wqcjbees1hzqyy5zL51+MkI+d15xb9ydGzTEoDodKC
         AdqPGCSsluEVcA2XoKeMKTxHxa6L5KGgIvaz40kF6wlVXb6Qqqd/aR3fWUYs7xZsANKJ
         5xSUhhBtfUDhaRETuGKNUaxn++bYpJEDC/LwC4vG9HyHrV8LLcQf3rGf6LQ7j2F4WxNS
         vSnU4QJNvwZdDhVHiAsjPZ/O15tqPfXzPNN+/S0gkzV0ZbB3DOdNegqArGztFU2U/tWD
         0qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tLOHBQaZOIsg9Rm+gqF0Na/UuY2D/0p5RcOU7ABOfsg=;
        b=3nk0AohHivWzCiZcitn2pULGdwCyXA1xnxcxXJFk2Co+2A5e3myniYaKPaEBPrB845
         owuJivqHVZODkSIel9ck3qm4wIV07wDXHpwx/a6/Y83ymQ2J9iU1BQVn0NzFszqLH3Xk
         jsOy2xwror84pwk25q5ek2DXxXTH5s3O2HIg+1jPZdrRuTqgR08/Lw7SfoTAhIAXzYil
         4VEt7HmeR1jxjzwEiEhKRK74NIDIQiSMH0NPVFgpggbKE9+zXFMfYCIQRu56hJYml1Pz
         4aq43iY7k97u14B69pw4yVFRiVcpf9a/m20XcSoBGGoD36jfoOafrMDltISD6A82sfrP
         nNJQ==
X-Gm-Message-State: ACgBeo3Sm5hrJClcssIC1iQyMNSr13+rgjAb6W5ott7sxBTlHTJByHSB
        EO9WxoAB/m3cVx8lHJ32B82hF2YHH7xvHD0xL8DFiD+l3PZEDA==
X-Google-Smtp-Source: AA6agR5zEjkWtzRYAiD8+rVKrEpGs4tHC+a6Jc+ZyrG1NCtf00ybbvXlB9ldUSjkq4gc/2+PeguxXoJdWVttLXKTTiw=
X-Received: by 2002:ac5:cdd4:0:b0:377:2e13:3512 with SMTP id
 u20-20020ac5cdd4000000b003772e133512mr5588504vkn.3.1659848643870; Sat, 06 Aug
 2022 22:04:03 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 7 Aug 2022 00:03:50 -0500
Message-ID: <CAH2r5mvaTWyWnPpYk=OPCbud85LEo5Oj=K2ZK56jmri6452zRQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
3d7cb6b04c3f3115719235cc6866b10326de34cd:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.20-rc-smb3-client-fixes-part1

for you to fetch changes up to 0d168a58fca34806b575c7cba87afb11208acb54:

  cifs: update internal module number (2022-08-05 11:24:17 -0500)

----------------------------------------------------------------
19 cifs/smb3 fixes, mostly cleanup, including:
- multichannel perf improvement patch
- 1 to moving additional SMB1 code to not be compiled in when legacy
support is disabled.
- 3 bug fixes, including one important one for memory leak
- 12 cleanup patches

We are still working/testing some deferred close improvements
including an important
lease break fix for case when multiple deferred closes are still open,
and also some
additional perf improvements - so those are not included in this P/R
----------------------------------------------------------------
Colin Ian King (1):
      cifs: remove redundant initialization to variable mnt_sign_enabled

Enzo Matsumiya (4):
      smb2: small refactor in smb2_check_message()
      cifs: list_for_each() -> list_for_each_entry()
      cifs: remove useless DeleteMidQEntry()
      cifs: remove "cifs_" prefix from init/destroy mids functions

Matthew Wilcox (Oracle) (1):
      cifs: Fix memory leak when using fscache

Shyam Prasad N (1):
      cifs: avoid use of global locks for high contention data

Steve French (9):
      smb3: check xattr value length earlier
      cifs: remove some camelCase and also some static build warnings
      cifs: remove minor build warning
      cifs: update MAINTAINERS file with reviewers
      cifs: remove remaining build warnings
      cifs: trivial style fixup
      cifs: when insecure legacy is disabled shrink amount of SMB1 code
      cifs: alloc_mid function should be marked as static
      cifs: update internal module number

Yang Yingliang (1):
      cifs: fix wrong unlock before return from cifs_tree_connect()

Yu Zhe (2):
      cifs: remove unnecessary type castings
      cifs: remove unnecessary (void*) conversions.

 MAINTAINERS             |   7 +-
 fs/cifs/Makefile        |   4 +-
 fs/cifs/cifs_debug.c    |  72 +++-----
 fs/cifs/cifsacl.c       |   2 +
 fs/cifs/cifsencrypt.c   |   6 +-
 fs/cifs/cifsfs.c        |  53 ++++--
 fs/cifs/cifsfs.h        |   4 +-
 fs/cifs/cifsglob.h      | 135 +++++++++-----
 fs/cifs/cifsproto.h     |  10 +-
 fs/cifs/cifssmb.c       | 477 ++----------------------------------------------
 fs/cifs/connect.c       | 299 ++++++++++++++++++------------
 fs/cifs/dfs_cache.c     |   8 +-
 fs/cifs/dir.c           |   8 +
 fs/cifs/file.c          | 283 ++++++++++++++++++++++++++--
 fs/cifs/inode.c         |  64 ++++++-
 fs/cifs/ioctl.c         |   2 +
 fs/cifs/link.c          |   8 +
 fs/cifs/misc.c          |  33 ++--
 fs/cifs/netmisc.c       |   2 +-
 fs/cifs/sess.c          |   5 +-
 fs/cifs/smb1ops.c       |  10 +-
 fs/cifs/smb2misc.c      |  49 +++--
 fs/cifs/smb2ops.c       |  61 ++++---
 fs/cifs/smb2pdu.c       |  32 ++--
 fs/cifs/smb2transport.c |  38 ++--
 fs/cifs/transport.c     | 334 +++++++++++++++++++++++++--------
 fs/cifs/xattr.c         |   5 +-
 27 files changed, 1104 insertions(+), 907 deletions(-)

-- 
Thanks,

Steve
