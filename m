Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7A4B37D8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiBLUUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 15:20:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiBLUUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 15:20:46 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9FF606E0;
        Sat, 12 Feb 2022 12:20:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id i34so23057841lfv.2;
        Sat, 12 Feb 2022 12:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=X5OVboysZPiDCOkAvhjp7fSRieyzfEo9vFNfx2vogFs=;
        b=CTZbrezXOPYc4Vpts3lUK+DZ3LZDs+IEKNdG/zJNT1I6U8qlxCumo5ET7f1+hqFdY/
         1umZ0Y/v+era6Cvldralas22Db3m4F0k5VHj9AFzF4VZJRVMdrWsZ+M6xndDyiUwLGOm
         PgIkKZJAwFTe8wRVDKO+FkFW53gB9dT19mgXVUkytECdzjFniQYTxWj2qZBrpWImgd5W
         s33IFM6G/qVCX82uf5CNAxmrpuSRMnUlHytgszUB1PHkQ2QL80LXVREgQq/qsKy38Qoz
         Gimx6flufy2h9ge264d+qZCmYPddS2NVoIf0R8lODLr7Kh8ez9l6wLKKqmHVyE2tM91/
         lrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=X5OVboysZPiDCOkAvhjp7fSRieyzfEo9vFNfx2vogFs=;
        b=6ZZpjyUg0KPgQ8ZIJKwqG65uXMkRAFwimvbV2WUIxCRd5QP+7jx1ECMrWMIQEx0xVT
         0qe2Ax2xjU8LObRlqYnXEzRREmdP95iriKdYsUt2YDOG74uLuDr3UO0NrWPgTw4aADUl
         NgKrEyWcWBnjzhjfIiL8v4WHe9jTYFI5gBGsV96SiUkxb0sRrSstvxDnCz/3NHwyRIIs
         DEYe1U+uuJAoHqFGP64UupLz1hIyooZqLzqUoNXIdgOoU2l9pPM2b7lqQ0RQKZtNVFKO
         i7DfyFon8hF38WImJgekmpv7xx/0iaP5kK6MVh1dObB4HtI3pUlKxEqvjBQ1/RmnsNmW
         Fa9A==
X-Gm-Message-State: AOAM533mDLSnLELjjLwsDXA+cnCmb6LOWOzyccVG2uXjpg6TEAPASYmS
        e3TjeY69s5AGX1UGMqxyE6zVwn3oF8/Cn7pS7U2jpKeoYcw=
X-Google-Smtp-Source: ABdhPJzJa2TZFLoyWjRVQBSAVcqGj5oftexOoIl2da5fV/wNaFVxujB2hpG1mJmnGqWKTGE4Ee5Ldv+GGB7LiilePy0=
X-Received: by 2002:a05:6512:2248:: with SMTP id i8mr5383700lfu.595.1644697241127;
 Sat, 12 Feb 2022 12:20:41 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 12 Feb 2022 14:20:30 -0600
Message-ID: <CAH2r5mvoW2O5c6_SRTBaC5R0FQ1y70WZ-3hfs-k8jQ7UuqUMAw@mail.gmail.com>
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
dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc4-smb3-fixes

for you to fetch changes up to 2a05137a0575b7d1006bdf4c1beeee9e391e22a0:

  cifs: mark sessions for reconnection in helper function (2022-02-08
22:13:52 -0600)

----------------------------------------------------------------
3 small smb3 reconnect fixes and an error log clarification

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/897

This pull request does not include the recent snapshot fix and 2
ACL/SID fixes that are still being tested (I can send those next
week).
----------------------------------------------------------------
Shyam Prasad N (3):
      cifs: call cifs_reconnect when a connection is marked
      cifs: call helper functions for marking channels for reconnect
      cifs: mark sessions for reconnection in helper function

Steve French (1):
      [smb3] improve error message when mount options conflict with posix

 fs/cifs/cifs_swn.c  |  6 +++---
 fs/cifs/connect.c   | 31 +++++++++++++++++++++++++------
 fs/cifs/dfs_cache.c |  2 +-
 fs/cifs/smb1ops.c   |  4 +---
 fs/cifs/transport.c |  5 +----
 5 files changed, 31 insertions(+), 17 deletions(-)


-- 
Thanks,

Steve
