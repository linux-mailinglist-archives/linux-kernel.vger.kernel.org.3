Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4F476C07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhLPIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhLPIec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:34:32 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51F7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:31 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l7so37369765lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bJOl4JkalmkkKaSfxJZNe6fs4zRAwFffrMK7a1d+U4I=;
        b=jnhRuiTbeU78C+OUofudoXlAy+jqgmR5VIGlzVM8fTZAVSAKBHcOURAxvOgeHA6w9D
         vMiaDZldxfTYBiw//2OLgy5H+ry3YJjMV2pFLRke2Xb/8r3zy50csfnFxqGvQpUhOgaj
         kdZUbuPncKGBnHwsT85SvH3nZT/ho+bVtQWio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bJOl4JkalmkkKaSfxJZNe6fs4zRAwFffrMK7a1d+U4I=;
        b=xW/mwOW8nY27HFimDaiN7mLdOb25T8hQ7uw6RsOT2ZionkNavbFb7xC6efmR2HAUzE
         a7zqyExbLzwRRi2RApQzEyI1qasjdR7KfPbSHRPkkDXYmaTU8FMVq7kqPNBD+99WcAV0
         5twUMFI+pqE4cW/Jwelh5LDmnPdo63evr9YIfyDcGSQsSUD845xcfLkWmmfFvuaiiOYW
         jS5UyzxqsMIcz2r+s7pyTeq8L+SRQEQCfWxZBllmgS8EDZfdzC0PZPRDR2KPG8Mt5TE6
         JZu0KG5fAf829azZMpNUvdvcxsVII4Cok02NKCyXfAMO3wV/hja2bqovSuGtQHXYFccD
         M3UA==
X-Gm-Message-State: AOAM533K6L9wz1/tDj3ubrPNXrmn/nM8Jx07V5G0J+jmmx+8uwYWOkOE
        frD/JHBs+QrG+WmKSk+8zYKs/w==
X-Google-Smtp-Source: ABdhPJxpEdkTJ7XAiaDmXTExNTDlhMnD5luYX0j+GFWk6L3K2/pqWTO+l2yYKH4qUJ6zfUrwOm1bzw==
X-Received: by 2002:a05:651c:106a:: with SMTP id y10mr14313443ljm.455.1639643669994;
        Thu, 16 Dec 2021 00:34:29 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id c2sm985679ljf.50.2021.12.16.00.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:34:29 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] mtdchar: add MEMREAD ioctl
Date:   Thu, 16 Dec 2021 09:34:13 +0100
Message-Id: <20211216083418.13512-1-kernel@kempniu.pl>
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

[1] https://www.infradead.org/pipermail/linux-mtd/2016-April/067187.html

Michał Kępień (5):
  mtdchar: add MEMREAD ioctl
  mtd: track maximum number of bitflips for each read request
  mtd: always initialize 'stats' in struct mtd_oob_ops
  mtd: add ECC error accounting for each read request
  mtdchar: extend MEMREAD ioctl to return ECC statistics

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

