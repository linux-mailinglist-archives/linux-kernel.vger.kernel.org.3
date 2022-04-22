Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB5350BDC9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbiDVRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiDVRDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:03:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E400D66CBB;
        Fri, 22 Apr 2022 10:00:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu29so15396970lfb.0;
        Fri, 22 Apr 2022 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=b3rzewQaFS9vbFCc+2pNDGoiMD/tDWvRJp+Iv+4ibzQ=;
        b=OJbSTCCH7f0gs4zpXBpUWTWDyRyojWE1fqnoIgW4mQRGw4iWiu5zhcoOjDsLsxGtd5
         a0UDxwNx4DAM0J8VMggu0ELLdfZY5Adsz04bAHu0dX5UuVls9GefMeZ6QAiuMd/D40hg
         yGcjpi+8BS94X0tFPVyxFYNJTPoDlsTbGzZ3ZjEQ2zF/0aEy9YKqykDFNUkM32NirCEJ
         cwxUrMSxoZp6bOqe3G/mnUiI84xlvyLNWjkS/NcV79WBLYGoSyD/DFZrdDrdmU3aUKoh
         qJ6tanDoeMpl5BmyAOMECLGf+Hsd+Hktpm59n0YYtevuvXCdxp7gdCQd8vyuVW/dl0BQ
         U8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=b3rzewQaFS9vbFCc+2pNDGoiMD/tDWvRJp+Iv+4ibzQ=;
        b=RF8nGwZcTop2efp1+mzsA90qd+OhFpHfZ7CGRTvuyyrOM1xkgmq6TfhUnzt8KVRZzE
         tZbIj6JN3d/YYTpOI6Kq++cR4nBiR5m+AjZBi5Bg4F3gyVLFNiwLbNUffL+MxY9RFhF8
         fdwlr4zOFfJIfsrUC0fAFFmfJrdmDKHpUrbPu0L2p7XN+PUKUT3vguFgR7WfLE7VI/6Y
         +HUPp1q5+Ml67fJ8aPjLumvwyu8iFiGzdCw4FIoCiPRkmyhtWAuqCMWFKr7VcD+WxP1c
         1AB4Ih8vdGe57zKG+gT5K1fxLDtjmhaMkShYuRoEnTE6IVgJOSvdyTiANGatZPsjzm1y
         MjYg==
X-Gm-Message-State: AOAM533n1J1BzjD9O6BbCdGkAKdCCFVWXBCJbG9b3rtYr7Jej60NBvjR
        kiYNWTyQE4lvGhW/jI46WzUTqnGQNgKZFVEQUYRgOr6BgsM=
X-Google-Smtp-Source: ABdhPJxqaaRy/JZruhaWvB9UILg3fAIDDSCmfUblFNOvQUJdfNVXCuRtN3Ic+LP0KpNSF3IzrtGHWFG6WUS2GNmA9c8=
X-Received: by 2002:ac2:4bd0:0:b0:46b:c3ea:ea04 with SMTP id
 o16-20020ac24bd0000000b0046bc3eaea04mr3572867lfq.537.1650646816871; Fri, 22
 Apr 2022 10:00:16 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 22 Apr 2022 12:00:06 -0500
Message-ID: <CAH2r5mtNyRzY2zxrS9Qgoj-NxAEyOEHjrWc1a6bingt61=xWHA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc3-smb3-fixes

for you to fetch changes up to f5d0f921ea362636e4a2efb7c38d1ead373a8700:

  cifs: destage any unwritten data to the server before calling
copychunk_write (2022-04-20 22:54:54 -0500)

----------------------------------------------------------------
4 fixes to cifs client, 2 for stable
- fcollapse fix
- reconnect lock fix
- DFS oops fix
- minor cleanup patch
----------------------------------------------------------------
Haowen Bai (1):
      cifs: Use kzalloc instead of kmalloc/memset

Paulo Alcantara (2):
      cifs: fix NULL ptr dereference in refresh_mounts()
      cifs: use correct lock type in cifs_reconnect()

Ronnie Sahlberg (1):
      cifs: destage any unwritten data to the server before calling
copychunk_write

 fs/cifs/connect.c   | 11 ++++++++++-
 fs/cifs/dfs_cache.c | 19 ++++++++++++-------
 fs/cifs/smb2ops.c   |  8 ++++++++
 fs/cifs/transport.c |  3 +--
 4 files changed, 31 insertions(+), 10 deletions(-)


-- 
Thanks,

Steve
