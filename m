Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231BB4ACADA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiBGVEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiBGVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:04:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D140C06173B;
        Mon,  7 Feb 2022 13:04:19 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b9so29335766lfq.6;
        Mon, 07 Feb 2022 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IS0NV7Wj7WBc0nHIZQdxvQ5ddc8mhbJ83KJ/odH85X8=;
        b=TAMIOExM4wGKLVkc/S5VkKo7A12LDRzYBpci4A2FA/xQT2lI3GcNBYqVce/WO8j0Wt
         JBmZ7fas15zRLDoaYmvVgk0ypqD+sNm1Q9RWRUmOpocz7SMC5L3GLCOFrm+Xkx9r3/mO
         lN2lYQ09HdCM8RUyne+0qQN+1448gyOh4J4JAlZ5Q8iAdEHFiWfHbJoSZqnKiESVMbUf
         tH6YZ4wGHW21nlQVdB8qME6EBT0XaqJrZw7cnNqaHYPOnVeziJzVrR3grkfHh/yVBsl2
         TPZCI9mXaUEk8TAfhdOpfHBpDE/KiBQBY9opsG4I/b8wlS9FsYCZEnuOVlFPw5hscshe
         p3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IS0NV7Wj7WBc0nHIZQdxvQ5ddc8mhbJ83KJ/odH85X8=;
        b=PShQmgTZ41b4JPxlAXrmhvTmFQXrrO4k3lznlTL80zhf5nu/O4ASR9TwaZjLtezmNI
         jd01+uT5XY3ku05MrYW4sHd1wS5wao1xPGxImBVwtIfMWSHmke0yn1g44vYXZaVtoyL4
         o+637X64jnCCdw+f9J17+7XO/zCTVvK/SfuWzITog53vujvZih7pVHwy/UmUPA04/9UM
         co+WzqFAE9EDY6Fgjr5Hw6uVcnpEVThmMQXlbLi/FVroOv8OE0atqZQmSzpjd53W5Nzl
         Fv1zqqdzck69sw3ipxX+kpcoHiOOel+PXD0/7k4PD9CL9L9p4fUxL7WtJWTNQbberMxi
         WbrQ==
X-Gm-Message-State: AOAM530XvAUqGv639AoKOW0R//nXR8VMDlj7ylW7FqGlh4TCpY86Ab88
        TYLWrRsJGs96EVU+kGVfxNv8URpVIdjbUTcvpYkJP0iCEvw=
X-Google-Smtp-Source: ABdhPJzXtEMfZtRgZyOwYRCXj+FJI+yotQe1tVk6j9KP6xZSKGTr+dm5iR19bL4eVqnMgt+kWs2VnMviI+0KiJTl/4o=
X-Received: by 2002:a05:6512:c1d:: with SMTP id z29mr912257lfu.320.1644267857553;
 Mon, 07 Feb 2022 13:04:17 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 7 Feb 2022 15:04:06 -0600
Message-ID: <CAH2r5ms7nZOL5jiGO2+AY8WO_hVXuEK9WsA9jE8utZgyHMoxZA@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
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
e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/5.17-rc3-ksmbd-server-fixes

for you to fetch changes up to f9929ef6a2a55f03aac61248c6a3a987b8546f2a:

  ksmbd: add support for key exchange (2022-02-04 00:12:22 -0600)

----------------------------------------------------------------
6 ksmbd server fixes including:
- NTLMSSP authentication improvement
- RDMA (smbdirect) fix allowing broader set of NICs to be supported
- improved buffer validation
- 3 additional small fixes, including a posix extensions fix for stable

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/100
----------------------------------------------------------------
Hyunchul Lee (1):
      ksmbd: smbd: validate buffer descriptor structures

Namjae Jeon (5):
      ksmbd: fix SMB 3.11 posix extension mount failure
      ksmbd: fix same UniqueId for dot and dotdot entries
      ksmbd: don't align last entry offset in smb2 query directory
      ksmbd: reduce smb direct max read/write size
      ksmbd: add support for key exchange

 fs/Kconfig                |  4 ++--
 fs/ksmbd/auth.c           | 27 +++++++++++++++++++++++++++
 fs/ksmbd/smb2pdu.c        | 45 +++++++++++++++++++++++++++++++++++----------
 fs/ksmbd/smb_common.c     |  5 ++++-
 fs/ksmbd/transport_rdma.c |  2 +-
 fs/ksmbd/vfs.h            |  1 +
 6 files changed, 70 insertions(+), 14 deletions(-)

-- 
Thanks,

Steve
