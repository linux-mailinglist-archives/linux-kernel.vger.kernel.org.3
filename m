Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2553501D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbiEZNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbiEZNlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 893ACC37
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653572493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=psF/SAzkqXSB5iGV88JF4c0l1o2XBFHBME6W1tXw3ac=;
        b=AmqgL/GsrxjuyOelWRk7em7nlpWf4qDOre00tY/6CIIV7iBN11SyRUj8KPvjYYYfproZLm
        YMvxmFH0dH8JO8RKp75yj0pBFj3/U79uBS9+4jVxWI8dv6lDd2kBjKwD187nGbRFDTy2U0
        g1MiD9mVZ8hbHvpqyUSHxEa7bDu9zD0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-cn927Y5WPf-4aiw0WUX__g-1; Thu, 26 May 2022 09:41:32 -0400
X-MC-Unique: cn927Y5WPf-4aiw0WUX__g-1
Received: by mail-wm1-f72.google.com with SMTP id bg40-20020a05600c3ca800b00394779649b1so3089319wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psF/SAzkqXSB5iGV88JF4c0l1o2XBFHBME6W1tXw3ac=;
        b=ERXidw/61TUnU9Z3BdwCiEsaL1L7W6j9uSHL8Fl/BWFJoc1SiKf5dccY54w7mPw3Ya
         SdRh4apmaPNayOi6Df58hmH39L+kLnWgplOv4OOKU7Ry/S/tWYMapHi2ZoU8cUWwkmSo
         7dE6XU2Dhyj7l6urHMLy1HmavDu3vgOS/H6NBDkmQfG/rWzDVgQ+FJ7skM0bCyAs7TyG
         v5SJtMboiBMmlF+DH/A3b9PKHEdvAYD0dC+A7cFXu9SUEb8m8v50DUj7arIwI7j/N1ZJ
         AUI1p6oPBabmlZ0hzzN+jNTPzvZX0zaNT271VfR+/MMmNoToDEk1x6uJmzYJmWcyof8o
         GLZg==
X-Gm-Message-State: AOAM53310VCz9GpEBiBGDTUQxOcGQIuZtSWP71F/TmtsfGCqsBQzUUjd
        cVcWnAQ+w/ZFenavXFym/NotuXDBHr8pmRZ/Fslx1kZyfZtaAaA3EHzgAqIptjN5Rv9rHBQ1XfD
        Ed9pKkpe1ucFjpJb2ieKisrGZuvl/y0iI0IPvP+FxV+dZi3OCjVYQdxOx7K2K/JWoiNffLjlrqM
        I=
X-Received: by 2002:a05:600c:3583:b0:397:3d93:75b8 with SMTP id p3-20020a05600c358300b003973d9375b8mr2349336wmq.76.1653572490610;
        Thu, 26 May 2022 06:41:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytVlrrsRs5q4UkJKl030m3nelnOfkqzrldHtQRWFAJgXuye49B/o43k9DqzgJar7qeJweWgQ==
X-Received: by 2002:a05:600c:3583:b0:397:3d93:75b8 with SMTP id p3-20020a05600c358300b003973d9375b8mr2349295wmq.76.1653572490088;
        Thu, 26 May 2022 06:41:30 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d5046000000b0020c547f75easm1765022wrt.101.2022.05.26.06.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 06:41:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Kellner <ckellner@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/3] fat: add support for the renameat2 RENAME_EXCHANGE flag
Date:   Thu, 26 May 2022 15:41:16 +0200
Message-Id: <20220526134119.242182-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series add support for the renameat2 system call RENAME_EXCHANGE flag
(which allows to atomically replace two paths) to the vfat filesystem code.

There are many use cases for this, but we are particularly interested in
making possible for vfat filesystems to be part of OSTree [0] deployments.

Currently OSTree relies on symbolic links to make the deployment updates
an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
to achieve a similar level of robustness when using a vfat filesystem.

Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
support in patch #2 and finally patch #3 adds some kselftests to test it.

This is a v3 that addresses issues pointed out in the second version posted:

https://lkml.org/lkml/2022/5/24/137

[0]: https://github.com/ostreedev/ostree
[1]: https://github.com/ostreedev/ostree/issues/1649

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

 MAINTAINERS                                   |   1 +
 fs/fat/namei_vfat.c                           | 193 +++++++++++++++++-
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fat/.gitignore      |   2 +
 .../selftests/filesystems/fat/Makefile        |   7 +
 .../testing/selftests/filesystems/fat/config  |   2 +
 .../filesystems/fat/rename_exchange.c         |  37 ++++
 .../filesystems/fat/run_fat_tests.sh          |  82 ++++++++
 8 files changed, 318 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fat/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

-- 
2.36.1

