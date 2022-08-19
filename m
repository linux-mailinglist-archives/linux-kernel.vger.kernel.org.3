Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA7599452
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbiHSFEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiHSFEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:04:02 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AED43E7E;
        Thu, 18 Aug 2022 22:04:01 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id l7so3231935vsc.0;
        Thu, 18 Aug 2022 22:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=CdbKXW75g+zxbPdeaovDkK4CZBW+NEQi8jRJBmf9Ixs=;
        b=M6beXsMvrlGTm+80ywyxl/8CpD/mkss2ZDrNaYfPfcF1twcqj0jcC4Y+lAyv++qCBG
         qXReWiySSFv3BTFdJz6/nIenzQ4RULPcVtq1LM0ZOJycJUv8C4y2oT0Gk4FKkdGBClNF
         racQ8BieVu5QDKxLxijf5EbIAVjZNshLY4rtFXk2rrx82/ufMhhjKQWc7Vrxaxzznhe8
         e9JSevmmnFjRRImg6ADngN3Xj9dM7VqwyxdtiAUVKJAOSY113G5YNMigq8HTyCUBYubX
         QC5DZaNgsgSL4LzUEjHpriyTg54PHNwRQVuvVJ9xlfMYFxsrvWcYwODCTK4ZMkAOZEVM
         cVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CdbKXW75g+zxbPdeaovDkK4CZBW+NEQi8jRJBmf9Ixs=;
        b=cexmdNcF36HQWx5cIwa+6uIRB40CuUOm+38EdmAxg1isLRP6dh/+mjzIg4EjFCC+R/
         nd6gdBeVRkim3JzPAUI/u2mCcb1daY3ihR4EeoPvXQyMOERApj/rF2WocSpda4RwRVAZ
         RKiSFuVX3TQ5CT7L3Y39cbxJ4aVk8JXq+eY5eG334vbtsxeM7Akw5zaeEfj+gsEC96VF
         tqQy6/zY2O9AcgtgYWkB6F/apoG1la8Ly+WQQ+39zIJL5ccMrzCiAcY+zYCyZjxaIBiX
         mKjDSQPhxJyoc0xvyz/uxRcMHip6A/JtN33vVPEoBUvbPRQkz1QB4dduJhU73CdHR/xK
         EMwA==
X-Gm-Message-State: ACgBeo3pJgoX5c+Xn6MqeP8EUb6sW6bMnC3olWKYwOro4SYtn6oOT1Qr
        Y+vFJ3Ujl1EvaUgXMCof11vtN8o4SqlclsehJRsIO+rDO8lM3g==
X-Google-Smtp-Source: AA6agR6URLbPjWEBpixlGOAJ/yCwoBwFCWVI827oHz6DfJvC6kCyOWmac89CiJStrWasp1/9vl73iXmOPiNHXEJ/p8k=
X-Received: by 2002:a67:b401:0:b0:387:8734:a09 with SMTP id
 x1-20020a67b401000000b0038787340a09mr2151401vsl.61.1660885439827; Thu, 18 Aug
 2022 22:03:59 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 19 Aug 2022 00:03:49 -0500
Message-ID: <CAH2r5mso_xy2RpCcez+NuR91nCUkv7R6Dffs6yT32zjzymRz=w@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
eb555cb5b794f4e12a9897f3d46d5a72104cd4a7:

  Merge tag '5.20-rc-ksmbd-server-fixes' of git://git.samba.org/ksmbd
(2022-08-08 20:15:13 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/5.20-rc2-ksmbd-smb3-server-fixes

for you to fetch changes up to 17661ecf6a64eb11ae7f1108fe88686388b2acd5:

  ksmbd: don't remove dos attribute xattr on O_TRUNC open (2022-08-15
21:07:01 -0500)

----------------------------------------------------------------
4 ksmbd server fixes:
- important sparse file fix
- allocation size fix
- fix incorrect rc on bad share
- share config fix

----------------------------------------------------------------
Atte Heikkil=C3=A4 (1):
      ksmbd: request update to stale share config

Hyunchul Lee (1):
      ksmbd: remove unnecessary generic_fillattr in smb2_open

Namjae Jeon (2):
      ksmbd: return STATUS_BAD_NETWORK_NAME error status if share is
not configured
      ksmbd: don't remove dos attribute xattr on O_TRUNC open

 fs/ksmbd/ksmbd_netlink.h     |  2 ++
 fs/ksmbd/mgmt/share_config.c |  6 +++++-
 fs/ksmbd/mgmt/share_config.h |  1 +
 fs/ksmbd/mgmt/tree_connect.c | 16 +++++++++++++++-
 fs/ksmbd/smb2pdu.c           | 35 ++++++++++++++++-------------------
 5 files changed, 39 insertions(+), 21 deletions(-)

--=20
Thanks,

Steve
