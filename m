Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A053ABF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356335AbiFARcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350828AbiFARcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0760749258
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654104738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9j7eRl43TvKBFSOtZ+/1hyFNQx8CtaTWLXvv1KcuR0k=;
        b=WNAIg33NnAd2897UnzOWETgtWXOMkq+ZMvQL0fRyzfQackfaxDxkX0fz3F38WoRRJgOUoh
        UJr4uuePTeeH3bQG38fwZFwoWkPFQk00iPWrhlJNjWb0JWjYcNz5dDraYovSYGh/G0ufFQ
        H1Gf3+vk6UX2mtiiUJx1rKeyMAtNDPI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-rULL82qCN1Kw8Os4QUlHAw-1; Wed, 01 Jun 2022 13:32:17 -0400
X-MC-Unique: rULL82qCN1Kw8Os4QUlHAw-1
Received: by mail-wm1-f71.google.com with SMTP id bg40-20020a05600c3ca800b00394779649b1so3711001wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 10:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9j7eRl43TvKBFSOtZ+/1hyFNQx8CtaTWLXvv1KcuR0k=;
        b=64iwL47dWTtYcHYkfoFTicmPVMuEkNSvez65Lnp90As+JpuEsazrXKaanrtpU0JJ5o
         14E4CidW/R98z0i4+lSGN1bnzNn8gbJ21KiAuou4JXHgwMWPRc6UnFtVn4yMfNk3hZQ2
         W55ujhjHAIEpQ5gqR3+ljv5dogR8Z/2bczhZjLU+oSmGPxnUboNwGQH6eHueINUtnkUt
         CtmK5VQVoUVKawKgwWisWAkc+mG8CaAyQlhoNE9aJNCRhV7pOWa9lKm3PMGy8FQ+zbU9
         c5JNeBJSDBJFyz65fD8KSkUv2wEHbWu8Lh/AxMjfqOi19LxFPFIwOnMgDX8Cw756lK3v
         OQyw==
X-Gm-Message-State: AOAM530+5Uwa2Wb5rJpgSIVIrwZtywdZgUjnTkTqjI8zT0rKF6oE5/Fp
        YU63e1x+ZFwCHadx8/PNWtN/1Hr1qlB+JgGu+eRGzyYWri4qfUpcTIljJL5bPW4JthMytUl9lcG
        LbZZ4DbQ/5JQ6W+WWG/QHLohKX708Ea+yyhmAB3Qt7yApEXb3FtQ7LUybsCGbrGkEVn7BvuN9mM
        U=
X-Received: by 2002:a05:600c:1d8b:b0:397:4106:a6d4 with SMTP id p11-20020a05600c1d8b00b003974106a6d4mr440711wms.25.1654104735679;
        Wed, 01 Jun 2022 10:32:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvg9jMhoapm1O3mM0l1d9O/d19ObnuDehlBumPVG5NaR1H7yewkzlcSBml62FQybXtLeE/Hw==
X-Received: by 2002:a05:600c:1d8b:b0:397:4106:a6d4 with SMTP id p11-20020a05600c1d8b00b003974106a6d4mr440675wms.25.1654104735342;
        Wed, 01 Jun 2022 10:32:15 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c2cce00b0039751bb8c62sm6525625wmc.24.2022.06.01.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:32:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 0/4] fat: add support for the renameat2 RENAME_EXCHANGE flag
Date:   Wed,  1 Jun 2022 19:32:00 +0200
Message-Id: <20220601173204.1372569-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

This is a v4 that addresses issues pointed out in the third version posted:

https://www.spinics.net/lists/kernel/msg4373694.html

[0]: https://github.com/ostreedev/ostree
[1]: https://github.com/ostreedev/ostree/issues/1649

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
 fs/fat/namei_vfat.c                           | 222 +++++++++++++++---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fat/.gitignore      |   2 +
 .../selftests/filesystems/fat/Makefile        |   7 +
 .../testing/selftests/filesystems/fat/config  |   2 +
 .../filesystems/fat/rename_exchange.c         |  37 +++
 .../filesystems/fat/run_fat_tests.sh          |  82 +++++++
 8 files changed, 315 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fat/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

-- 
2.36.1

