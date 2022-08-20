Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B986059B0CB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 00:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiHTWep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHTWem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 18:34:42 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D4024F1A;
        Sat, 20 Aug 2022 15:34:42 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id m21so3013797uab.13;
        Sat, 20 Aug 2022 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=by7P29WzyDQZWKMc3u1rTd95KTpSR/76OJDe1maH1Fg=;
        b=d1OiDBBhsLaV7ul3MoPkk8c3Pl56vvQM3un9tAmHhJ4rwX4n6Glv/Pq2XqqrFrm1V0
         26p/nsV2Ca2D7vMvKBeAbf8OPLdxfFgv8cnu33gThS0xuRO/OAkoir/Z8S88AeG/sbx7
         YYe7zNdcBVEgcGhIbeSLlsezLTME58KKh8NmUaPqaSqJ+x9D88hJi1OaOAit9p8NBIvS
         oVwHtE3fkur9GfX9i8YArSOO8oKaIoefeXg6vaEfq7qSqKxBxbipt/G9g4lLb9Ok4IFv
         drWBqCcvlq1bB1xTPKidJtlVUPlTc3CntdWJeb4QzzyVXEgD7pQ3bdPuPvHt8s805/rt
         x8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=by7P29WzyDQZWKMc3u1rTd95KTpSR/76OJDe1maH1Fg=;
        b=wBJi2cyUosmyvJa5dii/6qKypDU2FuuiOW/XnMYIsW5ILbnOeCsidhVWbZFtFVMxZZ
         KwkkIiEjrZVhx1fahe2pe+xDXVBOynQVZuqDGP1PY3WqDgJi5VUljhUaFb8DRAhJvX5f
         38NngAxgcNgYNVTVwWsDJG7so7OYV7c4EJCIgSiVS5mF5CiTpwu9I7/+4hMuQAVAgA7V
         9Dtkyze0vUuM7L1lJf6zQomvDT7UG2eIuI6AQEpXao+m1B/Tp/nLoCvImWRUdc0eY41T
         E3/28pMHdHEhp6KGQHwpyFmQo+w8f9vBUFSa6jk9wvmXkvnUfwfrV4E6rBzp8KS+KORP
         qqrQ==
X-Gm-Message-State: ACgBeo3OvznMPSFeuOvewfxRsk6/SxeDuxh2HmM4nBoFBV4J2nTCgis9
        A+VekgJ+Hwlu71ME57vJXqMSv/vLETikZCKFLCVnAkv0hDAHCQ==
X-Google-Smtp-Source: AA6agR4H5KnetTaZ4vP+233a5Hc7j9AIgFd0JU5vzNQmXoB82Z4vgMoYBOBCbIUmFp3LOgOhRFWJy1xAo+W+RPzTDnM=
X-Received: by 2002:ab0:3bc6:0:b0:381:c4db:ef5 with SMTP id
 q6-20020ab03bc6000000b00381c4db0ef5mr5270608uaw.81.1661034880960; Sat, 20 Aug
 2022 15:34:40 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 20 Aug 2022 17:34:30 -0500
Message-ID: <CAH2r5mtDFpaAWeGCtrfm_WPM6j-Gkt_O80=nKfp6y39aXaBr6w@mail.gmail.com>
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
568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.0-rc1-smb3-client-fixes

for you to fetch changes up to 13609a8b3ac6b0af38127a2b97fe62c0d06a8282:

  cifs: move from strlcpy with unused retval to strscpy (2022-08-19
11:02:26 -0500)

----------------------------------------------------------------
5 cifs/smb3 fixes, one for stable
- memory leak fix
- two small cleanup
- trivial strlcpy removal
- update missing entry for cifs headers in MAINTAINERS file

There are a pair of important fixes for insert range and collapse
range that are being tested
now that I plan to send next week.
----------------------------------------------------------------
Enzo Matsumiya (2):
      cifs: remove unused server parameter from calc_smb_size()
      cifs: remove useless parameter 'is_fsctl' from SMB2_ioctl()

Steve French (1):
      cifs: missing directory in MAINTAINERS file

Wolfram Sang (1):
      cifs: move from strlcpy with unused retval to strscpy

Zhang Xiaoxu (1):
      cifs: Fix memory leak on the deferred close

 MAINTAINERS          |  1 +
 fs/cifs/cifs_debug.c |  2 +-
 fs/cifs/cifsglob.h   |  2 +-
 fs/cifs/cifsproto.h  |  2 +-
 fs/cifs/cifsroot.c   |  2 +-
 fs/cifs/connect.c    |  2 +-
 fs/cifs/misc.c       |  8 +++++++-
 fs/cifs/netmisc.c    |  2 +-
 fs/cifs/readdir.c    |  6 ++----
 fs/cifs/smb2file.c   |  1 -
 fs/cifs/smb2misc.c   |  4 ++--
 fs/cifs/smb2ops.c    | 37 ++++++++++++++-----------------------
 fs/cifs/smb2pdu.c    | 22 ++++++++++------------
 fs/cifs/smb2proto.h  |  6 +++---
 14 files changed, 45 insertions(+), 52 deletions(-)

-- 
Thanks,

Steve
