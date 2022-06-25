Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7737155ACC9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 23:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiFYVix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 17:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFYViw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 17:38:52 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C6613DFB;
        Sat, 25 Jun 2022 14:38:51 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id b5so2781756vkp.4;
        Sat, 25 Jun 2022 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BbwHVtDC3wfcy6qW4/JHuwflwwFO4Gor8K2bRgHCz+8=;
        b=S1MmapeV/AyncM6GanNSYWXsaV4c0+KCrMjMK+C2iOhSN9FT0RJEr3FRKge83XEyhu
         a8qDLOSi3NV6SM3C7vLJKwJSlvXassSK5VDPy6/l+wB1l9Rk1GN3rdCYBdQPVQIX7vR4
         9ra7p/UEs+0ivkazpQQa3eeJ0+yRVHmx33Kk7rmF5Hd5V8xANCVMGjntJ3Qa9WUdtvGj
         VlV9i4E90if2tsQozbMB3kk+XD3l8d0NeUnCXnBI+Ttrw+n6oNjl9AS1LKF0UITWzeD8
         wqvrbS32eihR5CDVXP3ufvalr4Vzz4z303vVdNkmib+J9qTql9k1xt0krkpmSg3feRDv
         ZcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BbwHVtDC3wfcy6qW4/JHuwflwwFO4Gor8K2bRgHCz+8=;
        b=y7dOvikfkKny4cT8/X8UwpcTqJB78lY7zUu4ufm2kcSLTOerM/wQ1RWLsrc8NDAHlB
         QO6LeLnDWR/l4+EjTjIeco3IjzfLqUPTBfFYQ550A3PICGBWgaazyMZmvpoFnn6xqPBN
         I3T1Y6q53B+51iOpTqEPRlxUDIZuMpZATLzNl6ECAT/KFrHBid4bS993R+xcN5vw+8LB
         SnvGrN/NiMbGt3AS2bxFQo/HlbVfptFZR8XAvrQVspblxry22BHUCCCOykQj0Lg6usqC
         0urukCz5OtwsQvS7TAX+dIknfJyJQWqjNQBtUvjTfO0Yx6sDivwVLra3DOutvSJFVL0z
         ZGRg==
X-Gm-Message-State: AJIora8P/NyVsrGwipMWJFID4ugeiuNYUxI/wZ1FcIqtI6Qc+QKwcXRZ
        y3p7A702ejZjnT0ChrWJYHZAiMUuDUhWJhXYwvOF8mdTtrg=
X-Google-Smtp-Source: AGRyM1sMucNe20GAaizEts0fYD+M0OX29pCgrJnJIuZ9Z6eQVW8kfJG/4Sh2mibm9kA1xHjw7+cJDK8jKatyDxP4noE=
X-Received: by 2002:a1f:45d2:0:b0:36b:fa17:d542 with SMTP id
 s201-20020a1f45d2000000b0036bfa17d542mr2093543vka.4.1656193130687; Sat, 25
 Jun 2022 14:38:50 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 25 Jun 2022 16:38:40 -0500
Message-ID: <CAH2r5muuxg3iDXMkcasnRoCfi8WeE1i3Y=GTgBB8qMQShFppdQ@mail.gmail.com>
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
a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc3-smb3-client-fixes

for you to fetch changes up to af3a6d1018f02c6dc8388f1f3785a559c7ab5961:

  cifs: update cifs_ses::ip_addr after failover (2022-06-24 13:34:28 -0500)

----------------------------------------------------------------
7 SMB3 fixes, addressing important multichannel, reconnect issues.
Multichannel mounts when the server network interfaces changed, or
ip addresses changed, uncovered problems, especially in reconnect, but
the patches for this were held up until recently due to some lock conflicts
that are now addressed.   Included in this set of fixes:

- 3 fixes relating to multichannel reconnect, dynamically adjusting the list of
server interfaces to avoid problems during reconnect
- a lock conflict fix related to the above
- 2 important fixes for negotiate on secondary channels (null netname can
unintentionally cause multichannel to be disabled to some servers)
- a reconnect fix (reporting incorrect IP address in some cases)

----------------------------------------------------------------
Paulo Alcantara (1):
      cifs: update cifs_ses::ip_addr after failover

Shyam Prasad N (5):
      smb3: use netname when available on secondary channels
      cifs: change iface_list from array to sorted linked list
      cifs: during reconnect, update interface if necessary
      cifs: periodically query network interfaces from server
      cifs: avoid deadlocks while updating iface

Steve French (1):
      smb3: fix empty netname context on secondary channels

 fs/cifs/cifs_debug.c |  12 ++--
 fs/cifs/cifsglob.h   |  58 ++++++++++++++++-
 fs/cifs/cifsproto.h  |   7 +++
 fs/cifs/connect.c    |  59 ++++++++++++++++--
 fs/cifs/misc.c       |   9 ++-
 fs/cifs/sess.c       | 166 +++++++++++++++++++++++++++++++++++++-----------
 fs/cifs/smb2ops.c    | 173 +++++++++++++++++++++++++++------------------------
 fs/cifs/smb2pdu.c    |  21 +++++--
 8 files changed, 366 insertions(+), 139 deletions(-)

-- 
Thanks,

Steve
