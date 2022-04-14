Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA3501CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346619AbiDNUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiDNUpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:45:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D05ED92E;
        Thu, 14 Apr 2022 13:43:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o16so7498462ljp.3;
        Thu, 14 Apr 2022 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uVgST8u9bbBwztxgQYBnFBcLDjNOtfBEnZ4UOREspJE=;
        b=kKhsaayCQtJszovsEStS1c7QPwfsOftEekF0ZmPWIzY0vgw1nNiqtjDDIuhDJiLXEp
         Iu6VrZJI3xN8cUTNRmTazzOFDJ832oMUh2IVHddkTxSEpbOrEvRT/AV41ldBZ9dvsnwX
         OZ9J5mmFInjMjT3y3w2iyUAFTj40Adk9UFeBHNVAXrZT8Oi6BZFXk+R6LzyXv9GMDLEH
         8+CKnbbwkY6Kt+gjoifrvowDgkrUwb8keQiLXOdUx1/uhE40/UeXmhzsB4ve9NWguD18
         mCXSRmM2L+vqBNtIM+gFHGw8utEcb23zhApfXjhGls7W6p4O+eKewi44HmwFHuAPD80o
         aHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uVgST8u9bbBwztxgQYBnFBcLDjNOtfBEnZ4UOREspJE=;
        b=u2T8XIrTUcVC/kqzLfHQy7LJWyokf6oGlLmq+aK8jRw5z8FHPyhz1A2GhnJIHjPqFS
         XLn6ZetMF44VXMECep4rqVOWRfgnhrnbB5aSAnmzvm22IlnFmSP03ni6SuxlvR/NsSE9
         MK3w8h0ATKiYE8ACIym1e9PVpNaCnWJNlMQRAQhT6tD6aqbOtc3rPCa+IxxS2BbxZET/
         hceeTMNqQsZhPqkRF3b0ELA31gFcAmxvjbJ8o6VRyPEAJEAPu/n5kbm7QxzYbY/wYUHT
         8KwsSfVjLktJO+XCJCFnnkRmosJGhdvH+cPvizZgL9Q7C7orDbAGrx/N973h9r/hoF+g
         IxEw==
X-Gm-Message-State: AOAM531etrvUaivg/m52tWNVl4rdSbXzGRP75/kJZx7Rv4PO+j151OQW
        ZVZ/rW/i99dCTAFNrmEUzlokb+cL0C++huuhjvilby0J
X-Google-Smtp-Source: ABdhPJzbapp/Rp1rMQf+Le9k86VKc7mROsVRlkrVNhSVI19S1tXJZDzkRn3yQ6zln0IGH4gIr8VYmhlymnSHJyNfG0s=
X-Received: by 2002:a2e:bf08:0:b0:247:f79c:5794 with SMTP id
 c8-20020a2ebf08000000b00247f79c5794mr2503013ljr.398.1649968989815; Thu, 14
 Apr 2022 13:43:09 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 14 Apr 2022 15:42:58 -0500
Message-ID: <CAH2r5mvdJYtYrBuQWoqvBH+YadJE5iv3C3Es0HjRRBY5vospyA@mail.gmail.com>
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
5a5dcfd1e8789053730908c96639151b4151c4d0:

  Merge tag '5.18-rc1-smb3-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2022-04-07 19:16:49 -1000)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc2-smb3-fixes

for you to fetch changes up to 8b6c58458ee3206dde345fce327a4cb83e69caf9:

  cifs: verify that tcon is valid before dereference in cifs_kill_sb
(2022-04-14 00:07:36 -0500)

----------------------------------------------------------------
5 fixes to cifs client, 1 for stable
- two related to unmount
- symlink overflow fix
- minor netfs fix
- improved tracing for crediting (flow control)

----------------------------------------------------------------
David Howells (2):
      cifs: Check the IOCB_DIRECT flag, not O_DIRECT
      cifs: Split the smb3_add_credits tracepoint

Harshit Mogalapalli (1):
      cifs: potential buffer overflow in handling symlinks

Ronnie Sahlberg (1):
      cifs: verify that tcon is valid before dereference in cifs_kill_sb

Shyam Prasad N (1):
      cifs: release cached dentries only if mount is complete

 fs/cifs/cifsfs.c    | 30 ++++++++++++++++--------------
 fs/cifs/connect.c   |  2 +-
 fs/cifs/link.c      |  3 +++
 fs/cifs/smb2ops.c   |  9 ++++++---
 fs/cifs/trace.h     |  7 +++++++
 fs/cifs/transport.c |  4 ++--
 6 files changed, 35 insertions(+), 20 deletions(-)


--
Thanks,

Steve
