Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6779049B260
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378643AbiAYKvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377096AbiAYKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:48:33 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31D7C061753
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:48:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z14so14614610ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gu9HMdud+xkKETJLVBlwtrA+0/HcBrnYD8Y8ONHhjbw=;
        b=XqFH2feDD8JjHKuyp9SAg78+XlDrY5wAyHBaybW3XGs/mxABZasVQZRNrfJkKZPzBX
         41qMQLW4E4vL+Mu4o2jbMQl2B2PMuUHGWBXCK9xTFbDAe8UTaqPWMJz9Bd+N/n050Odg
         b2QDNR2PTuY1IxOGyaiE1MrJ/HNTJqPw6ycYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gu9HMdud+xkKETJLVBlwtrA+0/HcBrnYD8Y8ONHhjbw=;
        b=345cZAQqkJVCJ+XjAz0agGklAWXToopbLTyHbgm6YWGmTiFOjV8/ci7ffBUNdI4mk3
         KnjDbpyScqICVpS+ZRqvKiFTUPKXjXf3LteMIYgJBK74QYkrNUEoMt8vJfMB7y7LwLvn
         luu6ABD9j2nY95imfZfktGLqw/b9yotJavp0xqpEQeC9dJ35Nbj9a+yRYPUxGOX1Usz5
         B3n1c5npJPxkyubrX4ahhlRbIW/IxyYlgUpoID072k9y5qaloSigQM0JiVgYlMynwObn
         ub87xoqEiHf5wQXr/uHxvOWziNYw+9Ze2rIFd3xJH3Jgm13NkaNSjjF1Lw01ufppuQKp
         2FEA==
X-Gm-Message-State: AOAM533brF71q8Ju9+dkfmXXLHCAfsL7UIm9ysZcghYG6c19wWp2nBs0
        dhqf57vUiuA5ORUwmGg8IRwHPw==
X-Google-Smtp-Source: ABdhPJzoWpgBXJdXeQDWfB/o0rRTP0iziqQCqAaon+GoLfHwtxAwJbWZVBOrVhWYeqHsaZhcJ42FPQ==
X-Received: by 2002:a05:651c:91:: with SMTP id 17mr2512072ljq.211.1643107711256;
        Tue, 25 Jan 2022 02:48:31 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::221])
        by smtp.gmail.com with ESMTPSA id d16sm461896ljj.74.2022.01.25.02.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 02:48:30 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] mtdchar: add MEMREAD ioctl
Date:   Tue, 25 Jan 2022 11:48:18 +0100
Message-Id: <20220125104822.8420-1-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new mtdchar ioctl, MEMREAD.  Its purpose is to
serve as a read counterpart of the MEMWRITE ioctl, exposing a broader
set of capabilities for read operations (e.g. use of MTD_OPS_AUTO_OOB,
access to ECC statistics) to user-space applications making use of MTD
devices via /dev/mtd* character devices.

Changes from v2:

  - Squashed patch 1/5 into patch 5/5 to prevent breaking bisectability
    due to an incompatible ABI change between those two patches.
    Revised commit messages accordingly.

Changes from v1:

  - Added patches 2-5 which enable the new MEMREAD ioctl to report ECC
    statistics for the read operation back to user space.  (There are
    obviously different ways these changes can be split up into separate
    commits; I was aiming for maximum ease of review.)

  - The 'retlen' and 'oobretlen' fields were not set in the struct
    mtd_read_req returned to userspace.  This was done properly in
    Boris' original draft patch [1], but I missed it in my v1.

  - Invalid IS_ERR() checks were replaced with NULL checks.  This was an
    artifact of copy-pasting mtdchar_write_ioctl() in v1: unlike
    memdup_user() used therein, kmalloc() always returns NULL on error.

  - Minor subject prefix adjustment for patch 1/5 ("mtd" -> "mtdchar").

Michał Kępień (4):
  mtd: track maximum number of bitflips for each read request
  mtd: always initialize 'stats' in struct mtd_oob_ops
  mtd: add ECC error accounting for each read request
  mtdchar: add MEMREAD ioctl

 drivers/mtd/devices/docg3.c             |   8 ++
 drivers/mtd/inftlcore.c                 |   6 +-
 drivers/mtd/mtdchar.c                   | 136 ++++++++++++++++++++++++
 drivers/mtd/mtdcore.c                   |   5 +
 drivers/mtd/mtdswap.c                   |   6 +-
 drivers/mtd/nand/onenand/onenand_base.c |  16 ++-
 drivers/mtd/nand/onenand/onenand_bbt.c  |   2 +-
 drivers/mtd/nand/raw/nand_base.c        |  10 ++
 drivers/mtd/nand/raw/nand_bbt.c         |   8 +-
 drivers/mtd/nand/raw/sm_common.c        |   2 +-
 drivers/mtd/nand/spi/core.c             |  10 ++
 drivers/mtd/nftlcore.c                  |   6 +-
 drivers/mtd/sm_ftl.c                    |   4 +-
 drivers/mtd/ssfdc.c                     |   2 +-
 drivers/mtd/tests/nandbiterrs.c         |   2 +-
 drivers/mtd/tests/oobtest.c             |   8 +-
 drivers/mtd/tests/readtest.c            |   2 +-
 fs/jffs2/wbuf.c                         |   6 +-
 include/linux/mtd/mtd.h                 |   7 ++
 include/uapi/mtd/mtd-abi.h              |  64 ++++++++++-
 20 files changed, 276 insertions(+), 34 deletions(-)

-- 
2.34.1

