Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D153D8C4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 01:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbiFDXAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 19:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiFDXAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 19:00:47 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61776222AB;
        Sat,  4 Jun 2022 16:00:46 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id m30so870297vkf.11;
        Sat, 04 Jun 2022 16:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iXH/jEV1lkPHmewDXvPLrLnjXwdV18aJmKqCuT1yk2U=;
        b=TDXhn7zC219Ra5+Z33I9I1LN2zNpSemQE9yzvJrvSbR7A1i57pHYTEbgthWdZEnCHP
         fk236ZWCKAegqJJklxbakVwmqcccZFaQ/VUReGxxeGlGr7MCjBThfLWsTVz42k3DQs5c
         0iqyM/MoTgRs4oqfb5HNGvOX5SNNOz4FCNCiku7jkCGrSRmeGGrZhWY/6Iu/E4S6WfKV
         ATwhrJTgHFj00RmCSYV91DSFUo1uckvlj18JNt8oFNHgWjlHwziJxRDt+rONN6RE+/J9
         7xNsuOh8ehX2fhEj9abeAuoL9iqJYYc7aO5Il16tDlQW4KeOGUMpKuZEyxDYilEt/cH8
         xX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iXH/jEV1lkPHmewDXvPLrLnjXwdV18aJmKqCuT1yk2U=;
        b=ifuDv7AqIX+2GW9DQHfX6D19QIrw7QaI51w4k88mPVPgT0+z7Vfk5ZCRAQUwSaGQ7P
         S5vjpHxG0z69W7ltJCr8VgybmemNZWkO89mVdT6TZorP6bFEC5pTW3DksjSevPWsvteJ
         mayP7gd0cvXdKdujZ5ZmxeCaDCXsR4ECjwz9G/mEzfc6CFn1M0MELRz2QCbOPCDMfwbU
         XDxwDjsHgwCfhhV0ZSFb76o6g9uwh0d5kzaOnfbx+t5NDlD+JJJPiqx0PYiXRI+95PqF
         Hv3hMV1PeDnu3gtDBJxRu+jjJW2oKGzeE37I7ONRyKuTHhfeDj4tAgNDA2nWwxwKKW2S
         YKxw==
X-Gm-Message-State: AOAM532OcvpqWcYgDbT83iQkUsadsU9vL8DP4Zi07s+EYzzbGl7FL75F
        orvanADxci9jNWj3Vwsock5X7JSgjDUj9GDVpt8GxWL/Iy0=
X-Google-Smtp-Source: ABdhPJxr4ibx7jM++cGrbmy7R0BfgHq23PECuIKj6UzWr6NRtuoJmOKBBSdNEaZVLvVEftIYAuC3E+Y4OpJVHVejxMs=
X-Received: by 2002:a1f:3fc8:0:b0:35d:3816:b1e with SMTP id
 m191-20020a1f3fc8000000b0035d38160b1emr7557114vka.3.1654383644955; Sat, 04
 Jun 2022 16:00:44 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 4 Jun 2022 18:00:34 -0500
Message-ID: <CAH2r5mueybgm5M39d+y9bF53aKjsAavLGvPFc3YquQnuFTcFdg@mail.gmail.com>
Subject: [GIT PULL] SMB3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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
bf272460d744112bacd4c4d562592decbf0edf64:

  Merge tag '5.19-rc-smb3-client-fixes-updated' of
git://git.samba.org/sfrench/cifs-2.6 (2022-05-27 16:05:57 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc-smb3-client-fixes-part2

for you to fetch changes up to ee3c8019cce254f586b7fc2c5b836c275b275527:

  cifs: fix uninitialized pointer in error case in
dfs_cache_get_tgt_share (2022-06-04 13:33:42 -0500)

----------------------------------------------------------------
Includes various cifs/smb3 fixes:
- DFS fix
- double free fix
- potential deadlock fix
- fallocate (extend file size) improvement
- two legacy code cleanup fixes (do not include in build when legacy disabled)
- duplicate error message cleanup

This does not include the two multichannel (dynamic requery on interface change)
fixes, nor the important multichannel signing reconnect fix, which are important
but were recently changed by Shyam, so I wanted to give a few more days for
testing for them.
----------------------------------------------------------------
Enzo Matsumiya (1):
      cifs: remove repeated debug message on cifs_put_smb_ses()

Paulo Alcantara (1):
      cifs: skip trailing separators of prefix paths

Ronnie Sahlberg (2):
      cifs: fix potential double free during failed mount
      cifs: when extending a file with falloc we should make files not-sparse

Steve French (4):
      cifs: do not build smb1ops if legacy support is disabled
      cifs: version operations for smb20 unneeded when legacy support disabled
      cifs: update internal module number
      cifs: fix uninitialized pointer in error case in dfs_cache_get_tgt_share

Vincent Whitchurch (1):
      cifs: fix potential deadlock in direct reclaim

 fs/cifs/Makefile      |  4 ++-
 fs/cifs/cifs_swn.c    |  4 +--
 fs/cifs/cifsencrypt.c |  8 ++---
 fs/cifs/cifsfs.c      | 10 +++---
 fs/cifs/cifsfs.h      |  5 +--
 fs/cifs/cifsglob.h    | 24 ++++++++++++--
 fs/cifs/connect.c     | 27 ++++++++--------
 fs/cifs/dfs_cache.c   | 90 +++++++++++++++++++++++++++++----------------------
 fs/cifs/sess.c        |  6 ++--
 fs/cifs/smb1ops.c     |  6 ++--
 fs/cifs/smb2ops.c     |  9 ++++--
 fs/cifs/smb2pdu.c     |  6 ++--
 fs/cifs/smbdirect.c   |  4 +--
 fs/cifs/transport.c   | 40 +++++++++++------------
 14 files changed, 143 insertions(+), 100 deletions(-)


-- 
Thanks,

Steve
