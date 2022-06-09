Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD365447B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiFIJhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiFIJgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C4D322BEB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654767412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/OByrRXmDTIXHhVMaR8PwxE73rUJySQV3skcisuRFW4=;
        b=NbLHW3KzgcdOZatpJOl2Ak/tJW8ww0vC59suiP9DZ2HM9NVhweWB7j9up4ul9TTZDucKWa
        4syAK+2KB6C6HhISYimd4cfokxWjhg5tnbjJXF81vZiU2niDgjvyK4kaQmusB393M2we6q
        hbr1fB9utMPlNp2uq2/TWo65tlL1hXc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-siX57AKxOZivtZzi5MVoKA-1; Thu, 09 Jun 2022 05:36:51 -0400
X-MC-Unique: siX57AKxOZivtZzi5MVoKA-1
Received: by mail-wm1-f70.google.com with SMTP id ay1-20020a05600c1e0100b0039c3a3fc6a4so8184095wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OByrRXmDTIXHhVMaR8PwxE73rUJySQV3skcisuRFW4=;
        b=HtA4iNJ/2DTtaNETSyckk1o1PSyJY3mcbh2QzWYP75iXNUDM++WWwdu0+PyLRR6grf
         m+WmDExVTDT9vgtIs+2Os2Bkc12YrnIuGHrvbNbbaISen78M8o4iy1Xt7JBxZCSjZD0N
         kekh2Hbdd8jxl36S1sBvXzCAfT8xHiavjdNvPd9dZ/E1YeAdba35PW2eAUvrbWAIrvhG
         S9/S3NWxAh9Jd//vVNvA5sfbPsr1cWm9+JZK73jDEnnNR0aiAexd6RqgSH+zUESwhYbC
         EfMS7EbyF39d5AoI1jBlDwk8QZJekVu/iPz2DRO/+iNvKVJQzjfQWWnNAzLEQR2DWAqm
         eiYA==
X-Gm-Message-State: AOAM533BS2Xl8wcJzIe21rxe+wY8f4+vafwvs7wmCKsOsKQVBNyGNeWS
        FoAuXNpGuZ9uaC+9U1/ltETzi8SOV6kaKoGFb9UToDexG+UCNugm39j1xUHdcGcvclbRK9lW/pY
        92E+YRaEC+CvU0MrHh08W45kOreeO5bZcZQsI1jDCqcMvxKblIgtndKu5QFiyEqe2cayJUUFBHx
        8=
X-Received: by 2002:a05:600c:35d4:b0:39c:2541:7571 with SMTP id r20-20020a05600c35d400b0039c25417571mr2416251wmq.33.1654767409909;
        Thu, 09 Jun 2022 02:36:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxagyxXmNQ+1mS5Njzg5qZw4m+MOCfmM5s7ZpgXcjOQTicyuD9GsAuwHJBY1jTTuq6vvVGW4g==
X-Received: by 2002:a05:600c:35d4:b0:39c:2541:7571 with SMTP id r20-20020a05600c35d400b0039c25417571mr2416215wmq.33.1654767409553;
        Thu, 09 Jun 2022 02:36:49 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00397122e63b6sm27385580wms.29.2022.06.09.02.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:36:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@verbum.org>,
        Alberto Ruiz <aruiz@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Kellner <ckellner@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Carlos Maiolino <cmaiolin@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v5 0/4] fat: add support for the renameat2 RENAME_EXCHANGE flag
Date:   Thu,  9 Jun 2022 11:36:33 +0200
Message-Id: <20220609093638.664034-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The series adds support for the renameat2 system call RENAME_EXCHANGE flag
(which allows to atomically replace two paths) to the vfat filesystem code.

There are many use cases for this, but we are particularly interested in
making possible for vfat filesystems to be part of OSTree [0] deployments.

Currently OSTree relies on symbolic links to make the deployment updates
an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
to achieve a similar level of robustness when using a vfat filesystem.

Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
support, patch #2 moves some code blocks in vfat_rename() to a set of
helper functions, that can be reused by tvfat_rename_exchange() that's
added by patch #3 and finally patch #4 adds some kselftests to test it.

This is a v5 that addresses issues pointed out in v4:

https://lore.kernel.org/lkml/18d9e587-b4f7-6ee7-185a-af0e667e0ec5@redhat.com/

[0]: https://github.com/ostreedev/ostree
[1]: https://github.com/ostreedev/ostree/issues/1649

Changes in v5:
- Only update nlink for different parent dirs and file types (OGAWA Hirofumi).

Changes in v4:
- Add new patch from OGAWA Hirofumi to use the helpers in vfat_rename().
- Rebase the patch on top of OGAWA Hirofumi proposed changes.
- Drop iversion increment for old and new file inodes (OGAWA Hirofumi).
- Add Muhammad Usama Anjum Acked-by tag.

Changes in v3:
- Add a .gitignore for the rename_exchange binary (Muhammad Usama Anjum).
- Include $(KHDR_INCLUDES) instead of hardcoding a relative path in Makefile
  (Muhammad Usama Anjum).

Changes in v2:
- Only update the new_dir inode version and timestamps if != old_dir
  (Alex Larsson).
- Add some helper functions to avoid duplicating code (OGAWA Hirofumi).
- Use braces for multi-lines blocks even if are one statement (OGAWA Hirofumi).
- Mention in commit message that the operation is as transactional as possible
  but within the vfat limitations of not having a journal (Colin Walters).
- Call sync to flush the page cache before checking the file contents
  (Alex Larsson).
- Drop RFC prefix since the patches already got some review.

Javier Martinez Canillas (3):
  fat: add a vfat_rename2() and make existing .rename callback a helper
  fat: add renameat2 RENAME_EXCHANGE flag support
  selftests/filesystems: add a vfat RENAME_EXCHANGE test

OGAWA Hirofumi (1):
  fat: factor out reusable code in vfat_rename() as helper functions

 MAINTAINERS                                   |   1 +
 fs/fat/namei_vfat.c                           | 232 +++++++++++++++---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fat/.gitignore      |   2 +
 .../selftests/filesystems/fat/Makefile        |   7 +
 .../testing/selftests/filesystems/fat/config  |   2 +
 .../filesystems/fat/rename_exchange.c         |  37 +++
 .../filesystems/fat/run_fat_tests.sh          |  82 +++++++
 8 files changed, 325 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fat/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

-- 
2.36.1

