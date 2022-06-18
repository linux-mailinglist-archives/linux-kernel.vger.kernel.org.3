Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD80755075A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 00:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiFRWjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 18:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiFRWjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 18:39:09 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6031B845;
        Sat, 18 Jun 2022 15:39:06 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id c11so3547211vkn.5;
        Sat, 18 Jun 2022 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mWm3075zUyjZdm5Pr3I4IXYgBYEeEKabUfevN6De2+c=;
        b=SeU09hxP6cWVa5NOL8KUaKNDu2/W3aC9MAFhCe53ZTzDl6O8eWQj7PjKf6j8Bc52dT
         PoIpodjM7QxRTppxqUeTYN5yydJ7xw8YUQfaow2D5h6xxGP1V8ZqktTlXqqfLvdFhWuj
         oHqeatWhsWRIZP2zfBQMZj2HhGMjVmcYq38dP4W6Zbz7ABXeSvjLzxXlZnces2xLADuB
         7VOGJM9l+W+1NGlsCEcuhAu2UhYXxjKDFy8krXuRevA7LRJSIWxDeTBFJtmko/wkRB7b
         KLloUysSm2ADs4Bzq6edvqIHxBqlgG+4HtdTKdL0kEVwF7AbZQQ66hAVU0qIQ3YvQYWi
         470w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mWm3075zUyjZdm5Pr3I4IXYgBYEeEKabUfevN6De2+c=;
        b=PDTdweLd+EEqzvhrz9K9Py0z4l9EdaC5l1ZR52I06y5fH+mAUjDHYihDVueH8/Y/wH
         mLfuQBZgVLqFS+u0LB6q2JlBM4CmIFy5vVjfDmnCmT5zQWzc934Q746ZtcdoHHNMDzrI
         BgzcWDTlKN2o/cz1Lpx3+Ljcxf+SOc3eJvPH7LcUkpO1pWaXi2XKGdhRVp9VdSilUvPo
         Z51UFrmVwzrosua4tqgYNklrQjtXK175XT6s0ueClU4t8/euh2JnyhPZEXjeSOwX0jKu
         voF6voOiTuWMmm/LHiHnTrIuTQNNTPzCD9X0QgKL79nC6s29SkbFEX9fPQxIVZvn0uOC
         VDeg==
X-Gm-Message-State: AJIora/tdY0N7yi60C1odeGYEN69VxNr0+53fDSG4eYPsSJTqlrzvG6p
        TAWl3D3QXXcl1pOzK0cyJla0kZSTuvfLNhYwZwrFe7n3DeM=
X-Google-Smtp-Source: AGRyM1uCZJ225/VpReNjFcSZlrd2YXp/8Ij7WF2q0FMHRLjn5v41CMcCG1Jj/ozGFj3K14m+TEOrTUTfiNiFuO9Wxr4=
X-Received: by 2002:a1f:6d04:0:b0:36c:125:2edf with SMTP id
 i4-20020a1f6d04000000b0036c01252edfmr63817vkc.38.1655591945548; Sat, 18 Jun
 2022 15:39:05 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 18 Jun 2022 17:38:54 -0500
Message-ID: <CAH2r5mtJnW8Uq2Dk2xjid4Au9rM=g9_oBJC5ojJMd-Qksne+6g@mail.gmail.com>
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
b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc2-smb3-client-fixes

for you to fetch changes up to 5d24968f5b7e00bae564b1646c3b9e0e3750aabe:

  cifs: when a channel is not found for server, log its connection id
(2022-06-18 14:55:06 -0500)

----------------------------------------------------------------
2 smb3 debugging improvements
- one found to deal with debugging a multichannel problem and one for
a recent fallocate issue

Did not include the two larger multichannel reconnect (dynamically
adjusting interfaces on reconnect) patches in this P/R, because
recently found an additional problem with multichannel  to one server
type that I want to include at the same time.
----------------------------------------------------------------
Shyam Prasad N (1):
      cifs: when a channel is not found for server, log its connection id

Steve French (1):
      smb3: add trace point for SMB2_set_eof

 fs/cifs/sess.c    |  3 +++
 fs/cifs/smb2pdu.c |  2 ++
 fs/cifs/trace.h   | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)


-- 
Thanks,

Steve
