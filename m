Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED14A6475
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiBATBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbiBATBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:01:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7BC061714;
        Tue,  1 Feb 2022 11:01:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88711B82F6B;
        Tue,  1 Feb 2022 19:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B116C340EB;
        Tue,  1 Feb 2022 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643742091;
        bh=cVwY7uf25xXL0j0QUPYf5N1qHOInyxhDvkPW079SA40=;
        h=From:To:Cc:Subject:Date:From;
        b=JS1BjjmAzjQWsYp3zYQfRj0QMVYvf2qnStPbZScXwuySfQGo0GmCEy9tiAzD1Asqo
         +NlEZy403D9Dsokf8RX4cHgxPQ4vVcvgbZwKMFYM/OYnavjrCbKfzL/sHlTsYLOatj
         dCkW39bZQhlZdcGZAJ250z4V6FBhh7t3QY7n8n0AurhSg3bMeFN7BgPcDh+b6nlIQT
         izicVwv9pXvIti942M1oViQSVLsKac9mmcJEtfXvLUW0L4bkhJ6N+FdX7zyB+yoiZS
         SFO/uRYh9CbtUGvTvQpdgWa13cmHxJY/j1Sy12O19K9WyaXa90Ghq/75fTYzjQQgD3
         1287oUglFucOw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/7] 64-bit data integrity field support
Date:   Tue,  1 Feb 2022 11:01:21 -0800
Message-Id: <20220201190128.3075065-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVM Express protocol added enhancements to the data integrity field
formats beyond the T10 defined protection information. A detailed
description of the new formats can be found in the NVMe's NVM Command
Set Specification, section 5.2, available at:

  https://nvmexpress.org/wp-content/uploads/NVM-Command-Set-Specification-1.0b-2021.12.18-Ratified.pdf

This series implements one possible new format: the CRC64 guard with
48-bit reference tags. This does not add support for the variable
"storage tag" field, or any potential hardware acceleration.

Changes since RFC v1:

  - Generated the reflected CRC table and cacluated CRC accordingly
    instead of reflecting the input/output (Eric Biggers, patch 3)

  - Fixed Kconfig.debug dependency for CRC tests (patch 4)

  - Fixed endian conversion sparse error (patch 7).

  - Added support for PRACT (Klaus Jensen, patch 7)

Keith Busch (7):
  block: support pi with extended metadata
  nvme: allow integrity on extended metadata formats
  lib: add rocksoft model crc64
  lib: add crc64 tests
  asm-generic: introduce be48 unaligned accessors
  block: add pi for nvme enhanced integrity
  nvme: add support for enhanced metadata

 block/Kconfig                   |   1 +
 block/bio-integrity.c           |   1 +
 block/t10-pi.c                  | 198 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/core.c        | 167 ++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h        |   4 +-
 include/asm-generic/unaligned.h |  26 +++++
 include/linux/blk-integrity.h   |   1 +
 include/linux/crc64.h           |   2 +
 include/linux/nvme.h            |  53 ++++++++-
 include/linux/t10-pi.h          |  20 ++++
 lib/Kconfig.debug               |   4 +
 lib/Makefile                    |   1 +
 lib/crc64.c                     |  26 +++++
 lib/gen_crc64table.c            |  51 ++++++--
 lib/test_crc64.c                |  68 +++++++++++
 15 files changed, 576 insertions(+), 47 deletions(-)
 create mode 100644 lib/test_crc64.c

-- 
2.25.4

