Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641C5531D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiEWVOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEWVOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:14:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C417CDFD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:14:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q4so14166484plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPTyGkXNBh5K/gOO6jZInJgHMCEA96LD8k/0LUFStZ4=;
        b=Se+wojXWBSMoWBMFQzqRuN/lilmcgwOJ0w9xsNmag95RoY+2gTXCvLe5tdVAvrecHy
         Hlhcds//5lFoyGo8JHxtIsQXU44aQ8FKoFXTZQBbo13zJ85pH1lXNG7Nl/dzDk5aYG3p
         agVHprGLoVOOM7Rd03iwXivfVa2d2+eQd4fv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPTyGkXNBh5K/gOO6jZInJgHMCEA96LD8k/0LUFStZ4=;
        b=fx1OiVKwNXbll6a87rbTrja43y+lQhbmqIiyOyzYMEjU/mhBMSsp3ArQY2fx81yZTn
         tAIQODTim45hNmEurX7pCwXdnWoX77f6P7N3LxAVBbPPuLxvOOvpniqhpauBRx9680K5
         Jbsdnem5mrYvnrajW+sUftmyGWfaxgLmgPmg5hEjJ5ajWtXcd7Zqwrzjere/CJAkVkN2
         hH1u90Fr6k6rq4YIettyk2BF/Yt+iQ0hgqs+VAljimoRn3SL1eNGz4Jt7N1Q2yH8YRyz
         RrMyuWjaCyvJdKZAsZqRUFFsaWzhxF6Q7KFsMZ9fR7rn7/MgrDdShVLpO3/UXAbey3wr
         CuBw==
X-Gm-Message-State: AOAM531kfVhZmc6bmFCRggAqfJoyFkvxGmy2jmu2fAQKU8HnhhoCebcM
        lGzWSwbmC+geQ5Vg10MV91zumg==
X-Google-Smtp-Source: ABdhPJxuy1BlOdM7/6/pWUeJ4rY6QYNUiWdgdqvs5v1dBxBEoVPPJiiikm8Wc0ZrXEJ58Wa1GZauSA==
X-Received: by 2002:a17:90a:f3cf:b0:1e0:2abc:9387 with SMTP id ha15-20020a17090af3cf00b001e02abc9387mr940221pjb.39.1653340443350;
        Mon, 23 May 2022 14:14:03 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:d9e2:8472:9ac:8532])
        by smtp.gmail.com with UTF8SMTPSA id i136-20020a62878e000000b0051849bc0c23sm7795894pfe.23.2022.05.23.14.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 14:14:02 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 0/3] LoadPin: Enable loading from trusted dm-verity devices
Date:   Mon, 23 May 2022 14:13:57 -0700
Message-Id: <20220523211400.290537-1-mka@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now LoadPin restricts loading of kernel files to a single pinned
filesystem, typically the rootfs. This works for many systems, however it
can result in a bloated rootfs (and OTA updates) on platforms where
multiple boards with different hardware configurations use the same rootfs
image. Especially when 'optional' files are large it may be preferable to
download/install them only when they are actually needed by a given board.
Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
at runtime. As an example a DLC package could contain firmware for a
peripheral that is not present on all boards. DLCs use dm-verity [2] to
verify the integrity of the DLC content.

This series extends LoadPin to allow loading of kernel files from trusted
dm-verity devices. LoadPin maintains a list of root digests of verity
devices it considers trusted. Userspace can populate this list through an
ioctl on the new LoadPin securityfs entry 'dm-verity'. The ioctl receives
a file descriptor of a file with verity digests as parameter. Verity reads
the digests from this file after confirming that the file is located on the
pinned root. The digest file must contain one digest per line. The list of
trusted digests can only be set up once, which is typically done at boot
time.

When a kernel file is read LoadPin first checks (as usual) whether the file
is located on the pinned root, if so the file can be loaded. Otherwise, if
the verity extension is enabled, LoadPin determines whether the file is
located on a verity backed device and whether the root digest of that
device is in the list of trusted digests. The file can be loaded if the
verity device has a trusted root digest.

[1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
[2] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html

Changes in v6:
- added missing dependency on CONFIG_SECURITY_LOADPIN to
  CONFIG_SECURITY_LOADPIN_VERITY
- s/loadpin_trusted_verity_root_digests/dm_verity_loadpin_trusted_root_digests/
- s/trusted_root_digest/dm_verity_loadpin_trusted_root_digest/
- removed unnecessary symbol exports

Changes in v5:
- changed dm_verity_loadpin_is_sb_trusted() to
  dm_verity_loadpin_is_bdev_trusted()
- deleted bad semicolon in declaration of stub for
  dm_verity_loadpin_is_bdev_trusted()
- bumped verity version number to 1.8.1
- added 'Acked-by' tags from Kees

Changes in v4:
- a trusted verity device must have a single target of
  type 'verity'
- changed struct trusted_root_digest to have an unsized
  u8 array instead of a pointer
- use shared list of verity digests, deleted
  dm_verity_loadpin_set_trusted_root_digests()
- use newline as separator in digest file instead of comma
- after reading an invalid/corrupt digest file deny further attempts
  of setting up the list of digests
- added comment to read_trusted_verity_root_digests() explaining that
  an invalid digests entry invalidates the entire list of digests
- minor refactoring of verity related code in LoadPin

Changes in v3:
- added securityfs for LoadPin (currently only populated when
  CONFIG_SECURITY_LOADPIN_VERITY=y)
- added uapi include for LoadPin
- changed the interface for setting up the list of trusted
  digests from sysctl to ioctl on securityfs entry
- added stub for loadpin_is_fs_trusted() to be used
  CONFIG_SECURITY_LOADPIN_VERITY is not select
- depend on CONFIG_SECURITYFS instead of CONFIG_SYSTCL
- updated Kconfig help
- minor changes in read_trusted_verity_root_digests()
- updated commit message

Changes in v2:
- userspace now passes the path of the file with the verity digests
  via systcl, instead of the digests themselves
- renamed sysctl file to 'trusted_verity_root_digests_path'
- have CONFIG_SECURITY_LOADPIN_VERITY depend on CONFIG_SYSCTL
- updated Kconfig doc
- updated commit message

Matthias Kaehlcke (3):
  dm: Add verity helpers for LoadPin
  LoadPin: Enable loading from trusted dm-verity devices
  dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional
    compilation

 drivers/md/Makefile               |   1 +
 drivers/md/dm-verity-loadpin.c    |  74 +++++++++++++
 drivers/md/dm-verity-target.c     |  33 +++++-
 drivers/md/dm-verity.h            |   4 +
 include/linux/dm-verity-loadpin.h |  27 +++++
 include/uapi/linux/loadpin.h      |  22 ++++
 security/loadpin/Kconfig          |  16 +++
 security/loadpin/loadpin.c        | 167 +++++++++++++++++++++++++++++-
 8 files changed, 342 insertions(+), 2 deletions(-)
 create mode 100644 drivers/md/dm-verity-loadpin.c
 create mode 100644 include/linux/dm-verity-loadpin.h
 create mode 100644 include/uapi/linux/loadpin.h

-- 
2.36.1.124.g0e6072fb45-goog

