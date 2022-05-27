Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304E05359AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbiE0GxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiE0GxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:53:05 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234BB631A;
        Thu, 26 May 2022 23:53:04 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id j7so3444262vsj.7;
        Thu, 26 May 2022 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gVT2+H6zyIakz/UAu5QzrweZZcue1nrsnDfliOy/bQY=;
        b=ZWR4uRcH/37PhBE9lMQte0rU686WET1ynrPOzj9fzztJUt3B6vfDCnVZzO996dPPgD
         M949X6ez39wcIWItUp0zaVt/OcKrKyCQo+GpYDnFHKOMzdih275OEvLe8ycO83/0YS7t
         BjyZfXkbilye/EukOpEVPu3BODovj+ADevH294XyTq+olXe7ViiUVOE6N+ALmWXfG4DP
         /d/Ju0cqfO8/UH+j/AF/9+daK6N3T5mMuQmmINIeVG4JWqcEYnSVejGeZ/7oQaA+Dno2
         so6Q7U6CDZpRz53sFTyVcHeMwjf2m5bXWhs/OGHAzGppJReIDPP3N67XOV0JGZJZ5bGc
         QlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gVT2+H6zyIakz/UAu5QzrweZZcue1nrsnDfliOy/bQY=;
        b=YoWMNpy6+wFVY6JyJb4Vie5IVnT5MCBfzRolHqk+dwhJRmUqTO6fA4TEj71Co4alAH
         56B2WskJvI2TlpYg1kNy5it8pK3af6Xt3AQGk8knBTum6DCILFKD16Gfg3WrfpjFSGu8
         QdomS1CmoZG1Szu4cud8WJEcbKwusSUEC5e40aOP3v3sMqKu8FG1H2FgPbKf8H2aTJ4k
         Oiwwc98qVjfqjApYVXuF3AfiM8y+Shn5kqzGIsL3fkfeXtmpNLAPwyJEg7kW8HlKTJPr
         OEJfWsP7h1hkZ7Vf6w96aIn1xhejCSywXvUn26MJ4HNSpSzvgneJsUfhGYWI6M6fDRwJ
         biYg==
X-Gm-Message-State: AOAM532M6l27zsKE3hzi7CIP0o8+vM4k/8D+ZVbCDP9o3VUpjgDYst+A
        Im/ASKRRKjNnglhIfvsVJ2IcyfyXkNZEtuHMlhHYbf0LmFA=
X-Google-Smtp-Source: ABdhPJw9Zy8z+7QhQRtgaQkZNdZDw80Rrd2UwgvhaW6ojTPkzHzMRPNtz/ungVM4MULyegijtz8kbpPevFeINS+UfmM=
X-Received: by 2002:a05:6102:2137:b0:338:f898:8bbd with SMTP id
 f23-20020a056102213700b00338f8988bbdmr4783224vsg.60.1653634383120; Thu, 26
 May 2022 23:53:03 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 27 May 2022 01:52:52 -0500
Message-ID: <CAH2r5mug2=wOYp-mwRKWJPRiyh2xtdP06A-i3fVL=JuidMsReQ@mail.gmail.com>
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
42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc-smb3-client-fixes-part1

for you to fetch changes up to 9f114d7bfc6c35ca23a82efce60e0db535a186f1:

  smb3: remove unneeded null check in cifs_readdir (2022-05-26 11:15:14 -0500)

----------------------------------------------------------------
Twenty eight cifs/smb3 client fixes, including:
- a series of fixes for multichannel fixes to improve reconnect after
network failure
- improved caching of root directory contents (extending benefit of
directory leases)
- 2 DFS fixes
- 3 fixes for improved debugging
- an NTLMSSP fix for mounts t0 older servers
- new mount parm to allow disabling creating sparse files
- various cleanup fixes and minor fixes pointed out by coverity
- the first part of Dave's updates for iov_iter support

Not included in this P/R are the last two patches in Dave's series
converting i/o paths in cifs.ko to use iterators,
as well as some RDMA (smbdirect) fixes and a patch to dynamically
requery and adjust the network interfaces on the
fly - all of which are still being tested.
----------------------------------------------------------------
ChenXiaoSong (1):
      cifs: return the more nuanced writeback error on close()

David Howells (4):
      iov_iter: Add a function to extract an iter's buffers to a bvec iter
      iov_iter: Add a general purpose iteration function
      cifs: Add some helper functions
      cifs: Add a function to read into an iter from a socket

Enzo Matsumiya (3):
      cifs: don't call cifs_dfs_query_info_nonascii_quirk() if nodfs was set
      cifs: return ENOENT for DFS lookup_cache_entry()
      cifs: print TIDs as hex

Julia Lawall (1):
      cifs: smbd: fix typo in comment

Paulo Alcantara (2):
      cifs: fix signed integer overflow when fl_end is OFFSET_MAX
      cifs: fix ntlmssp on old servers

Ronnie Sahlberg (4):
      cifs: move definition of cifs_fattr earlier in cifsglob.h
      cifs: check for smb1 in open_cached_dir()
      cifs: set the CREATE_NOT_FILE when opening the directory in
use_cached_dir()
      cifs: cache the dirents for entries in a cached directory

Shyam Prasad N (3):
      cifs: do not use tcpStatus after negotiate completes
      cifs: use new enum for ses_status
      cifs: avoid parallel session setups on same channel

Steve French (10):
      SMB3: EBADF/EIO errors in rename/open caused by race condition
in smb2_compound_op
      smb3: add trace point for lease not found issue
      smb3: add trace point for oplock not found
      Add defines for various newer FSCTLs
      Add various fsctl structs
      cifs: fix minor compile warning
      smb3: check for null tcon
      smb3: don't set rc when used and unneeded in query_info_compound
      smb3: add mount parm nosparse
      smb3: remove unneeded null check in cifs_readdir

 fs/cifs/cifs_debug.c       |  11 +++-
 fs/cifs/cifsfs.c           |   2 +
 fs/cifs/cifsfs.h           |   3 +
 fs/cifs/cifsglob.h         | 124 +++++++++++++++++++++++++++------------
 fs/cifs/cifsproto.h        |  12 ++++
 fs/cifs/cifssmb.c          |  99 ++++++++++++++++++++++++++++++-
 fs/cifs/connect.c          | 123 +++++++++++++++++++++++----------------
 fs/cifs/dfs_cache.c        |   6 +-
 fs/cifs/file.c             |  13 +++--
 fs/cifs/fs_context.c       |  33 +++--------
 fs/cifs/fs_context.h       |   4 +-
 fs/cifs/misc.c             |  11 ++--
 fs/cifs/readdir.c          | 179
++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/cifs/sess.c             |  33 ++++++++++-
 fs/cifs/smb2inode.c        |   7 ++-
 fs/cifs/smb2misc.c         |  12 +++-
 fs/cifs/smb2ops.c          |  32 +++++++++--
 fs/cifs/smb2pdu.c          |   5 +-
 fs/cifs/smb2pdu.h          |  22 -------
 fs/cifs/smb2transport.c    |   7 ++-
 fs/cifs/smbdirect.c        |   2 +-
 fs/cifs/trace.h            |   2 +
 fs/cifs/transport.c        |   8 +--
 fs/smbfs_common/smb2pdu.h  | 108 +++++++++++++++++++++++++++++++---
 fs/smbfs_common/smbfsctl.h |   6 ++
 include/linux/uio.h        |   8 +++
 lib/iov_iter.c             | 133 ++++++++++++++++++++++++++++++++++++++++++
 27 files changed, 816 insertions(+), 189 deletions(-)


-- 
Thanks,

Steve
