Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E129A591CC5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 23:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiHMVpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 17:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiHMVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 17:45:11 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F74E1A3AE;
        Sat, 13 Aug 2022 14:45:10 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id q190so3984061vsb.7;
        Sat, 13 Aug 2022 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=2LaJ+HSf5Wo05084gkL82LU3w+Nr0TU5q/ddOuveLoc=;
        b=cyVGZydgHtT8TR/T52xw69rHFlvJsEEiWMpqaAq/Y/y5dU/GADpUHj/94c4WFXJuAf
         1PdN9swPhDfCzicM+87VQmwuHLWPcAvNJ032lvGTl0zLZz5s1vOKE/fTInhPY+CTqylQ
         KICa0aDVI+8SYjEwvYAGebzIsp3+7IrXRSwpbKZzGy4Oaaxk+8tNr0adVqxbrWgQTKpF
         M8FOcOfGONdZ09c4WORkShC62MvPyf0pIJ2/7rQaOhRUWbf39Z8K98/BBT6Vv18od3mB
         y58u2DPe7IVhlUk0uemiyCm1kBpGlI8aHGYGQt5yEOpL0mOI7756LLrkZld1ORfwjm+h
         a33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=2LaJ+HSf5Wo05084gkL82LU3w+Nr0TU5q/ddOuveLoc=;
        b=5w6ToDo/K01OrtWe6dBelbPjqyLzlFSjcM3d19cUoulhHRDHQJiGl0vQjFDvNvrzww
         KKJBqNmqfFvEznGEDiqd9aPaSpkTIhsKzmq4iO8n9VghaMHmTAVI6i9EgC1SzJOJfyw0
         koF65aUDgy3cQow0oVa9VItRkLwx6TJaDSUV+h646AkDILwAu8xba/T+95KSahJIXzHR
         /qW10+At9SoO694qhKn5+CtrOzVAdxwT3ixxkNJ5ug4kZigCu2HsPi4TNWg6nSks6COK
         VmUFfETDWORsN6RvBQJ9M0NFVwIyuOoQvUIDArq96UH3sk8XkeT7ZwxIZaVnU2zx/CAw
         /GgQ==
X-Gm-Message-State: ACgBeo1O3vECdMEvnM0xP3KODnEsHnx7csA0P9BCvZr5ElABv1qfUB+V
        54l2WIqNucYOknZ9WhSEGf2RyO+XCwe7/lmjcpOYqIpxZq0=
X-Google-Smtp-Source: AA6agR7I3+uxMwW4hTZxX9Mjn8u3IxZ6A6bWS0JxDuSRterADevpIu4vvF+1i9cTbGWAYfnWA0PufhAP6/V0eBFp8zI=
X-Received: by 2002:a05:6102:3e82:b0:38a:ab1a:2702 with SMTP id
 m2-20020a0561023e8200b0038aab1a2702mr3056953vsv.29.1660427109342; Sat, 13 Aug
 2022 14:45:09 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 13 Aug 2022 16:44:58 -0500
Message-ID: <CAH2r5msY4JmT5aZ_zAC9bMozQ=R4iTaa5SPF5JWpR73OcbUDZA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
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
0d168a58fca34806b575c7cba87afb11208acb54:

  cifs: update internal module number (2022-08-05 11:24:17 -0500)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.20-rc-smb3-client-fixes-part2

for you to fetch changes up to 7eb59a98701d3113671b513593bb489cc76f58d2:

  cifs: Do not access tcon->cfids->cfid directly from
is_path_accessible (2022-08-12 17:40:15 -0500)

----------------------------------------------------------------
8 cifs/smb3 fixes:
- two fixes for stable, one for a lock length miscalculation, and
another fixes a lease break timeout bug
- improvement to handle leases, allows the close timeout to be
configured more safely
- five restructuring/cleanup patches
----------------------------------------------------------------
Bharath SM (1):
      SMB3: fix lease break timeout when multiple deferred close
handles for the same file.

David Howells (1):
      cifs: Remove {cifs,nfs}_fscache_release_page()

Paulo Alcantara (1):
      cifs: fix lock length calculation

Ronnie Sahlberg (4):
      cifs: Move cached-dir functions into a separate file
      cifs: Do not use tcon->cfid directly, use the cfid we get from
open_cached_dir
      cifs: Add constructor/destructors for tcon->cfid
      cifs: Do not access tcon->cfids->cfid directly from is_path_accessible

Steve French (1):
      smb3: allow deferred close timeout to be configurable

 fs/cifs/Makefile     |   2 +-
 fs/cifs/cached_dir.c | 388 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/cifs/cached_dir.h |  64 ++++++++
 fs/cifs/cifsfs.c     |  21 +--
 fs/cifs/cifsglob.h   |  42 +-----
 fs/cifs/cifsproto.h  |   1 -
 fs/cifs/connect.c    |   2 +
 fs/cifs/file.c       |  39 +----
 fs/cifs/fs_context.c |   9 ++
 fs/cifs/fs_context.h |   8 +
 fs/cifs/fscache.h    |  16 --
 fs/cifs/inode.c      |   1 +
 fs/cifs/misc.c       |  20 ++-
 fs/cifs/readdir.c    |   5 +-
 fs/cifs/smb2inode.c  |  11 +-
 fs/cifs/smb2misc.c   |  11 +-
 fs/cifs/smb2ops.c    | 320 +++-------------------------------------
 fs/cifs/smb2pdu.c    |   3 +-
 fs/cifs/smb2proto.h  |  10 --
 19 files changed, 528 insertions(+), 445 deletions(-)
 create mode 100644 fs/cifs/cached_dir.c
 create mode 100644 fs/cifs/cached_dir.h


--
Thanks,

Steve
