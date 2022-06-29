Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C25560113
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiF2NN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiF2NNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:13:22 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AFD15714
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656507466; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=g+U/Zi8rGFDy2JVAXgqR+hQw1131kIFYJ4LIjA5mI09mSzBk0MMlwoZ0C1Xd1P0Wg73N0dOU4TuEzOwy2dwq1PsqCv/R0pEWq1gSiH4zP1vU1etvnilWiVoNSp5zU0OfxnnPCXgrsExddB+cyzZwJg/itBADlbVd5YIKlTUKE8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1656507466; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=jd5EmsSka8mZXEbstWwZePiOzECLljr5+URCKuNvUOM=; 
        b=f9b/eQ0goMr47U+aTEQnFSy7+4O1UIII01+FbX2fhcZejwK0Kh7JuXwiaWbrdtNCueiCiWbwS8OUdSAv8i7ykQ0A5ZgnH9OQwxKN0mdpzXKzcjCXQl+20UsNaPkPvmAIsbGOzu5opOXsC0D7IQkP02x5Ju/lrGEz7U7ASTfRtm0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=kempniu.pl;
        spf=pass  smtp.mailfrom=kernel@kempniu.pl;
        dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656507466;
        s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=jd5EmsSka8mZXEbstWwZePiOzECLljr5+URCKuNvUOM=;
        b=DmyUTyq6XglneK+t7163HQ2YYDzWblLSjdriJhoKXRjUylkKAL0ghv/8yFdqN04b
        jocUOHEhpDg2oP4uhFZbhkN/yZSkjiJcQSsj7jknOpE69GQd8fz2YrN8xIUs4D/en3v
        Yh0bUiHqXoOoPymzmRHk/y5ubwQh1LVX5UUABKdw=
Received: from larwa.hq.kempniu.pl (212.180.138.61 [212.180.138.61]) by mx.zoho.eu
        with SMTPS id 1656507465222376.59903136972116; Wed, 29 Jun 2022 14:57:45 +0200 (CEST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20220629125737.14418-1-kernel@kempniu.pl>
Subject: [PATCH v4 0/4] mtdchar: add MEMREAD ioctl
Date:   Wed, 29 Jun 2022 14:57:33 +0200
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new mtdchar ioctl, MEMREAD.  Its purpose is to
serve as a read counterpart of the MEMWRITE ioctl, exposing a broader
set of capabilities for read operations (e.g. use of MTD_OPS_AUTO_OOB,
access to ECC statistics) to user-space applications making use of MTD
devices via /dev/mtd* character devices.

Changes from v3:

  - Fixed two issues found by Richard Weinberger [1]:

      - prevent integer overflow,
      - use kvmalloc() for potentially large allocations.

    (Identical fixes have already been applied to mtdchar_write_ioctl(),
    i.e. the write counterpart of the ioctl proposed in this patch
    series, in mtd/next. [2] [3])

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

[1] http://lists.infradead.org/pipermail/linux-mtd/2022-February/091276.htm=
l
[2] http://lists.infradead.org/pipermail/linux-mtd/2022-June/093829.html
[3] http://lists.infradead.org/pipermail/linux-mtd/2022-June/093828.html

Micha=C5=82 K=C4=99pie=C5=84 (4):
  mtd: track maximum number of bitflips for each read request
  mtd: always initialize 'stats' in struct mtd_oob_ops
  mtd: add ECC error accounting for each read request
  mtdchar: add MEMREAD ioctl

 drivers/mtd/devices/docg3.c             |   8 ++
 drivers/mtd/inftlcore.c                 |   6 +-
 drivers/mtd/mtdchar.c                   | 139 ++++++++++++++++++++++++
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
 20 files changed, 279 insertions(+), 34 deletions(-)

--=20
2.37.0


