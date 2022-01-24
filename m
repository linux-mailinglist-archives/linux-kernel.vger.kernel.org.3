Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB472498402
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbiAXQBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:01:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54440 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbiAXQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:01:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFECBB810FD;
        Mon, 24 Jan 2022 16:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EDAC340E5;
        Mon, 24 Jan 2022 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643040070;
        bh=D3cFc/NBIAKXRfJhPp6StLK8ULApGVcFR4ulS3YCWUQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LpXp9TSxT9DE4dWhl8kwwb+u+FDuQ6R5RNmldAa79eAXhv+4zjfK/cR2DNrCGh66T
         4GpN1b6bmLoZ3osKkobMbihcZgC+XOBs451dIO7hfTvNeqXlw9qRDfXjEk4sviVPHc
         cvRMBnCN4y/EUq+pWRRADhslAEllBDQX2BqUCkalrTprazEQRlwmrmzrEr2l8vWcm4
         RrUwYu2gfY4aKJF5udNbRjCkctX8RqIAr4Oo2iSZYmf/1/EVFU/E/hfsIE/7OIiZch
         46pUfq3eQl+7JFul6fXguYURidLaO7ywGE/iaMyVn7V8Oc0v8/QrOD7DEZaJStBNC4
         S25nsPZR42T1w==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 0/7] 64-bit data integrity field support
Date:   Mon, 24 Jan 2022 08:01:00 -0800
Message-Id: <20220124160107.1683901-1-kbusch@kernel.org>
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
"storage tag" field.

The NVMe CRC64 parameters (from Rocksoft) were not implemented in the
kernel, so a software implementation is included in this series based on
the generated table. This series does not include any possible hardware
excelleration (ex: x86's pclmulqdq), so it's not very high performant
right now.

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
 drivers/nvme/host/nvme.h        |   1 +
 include/asm-generic/unaligned.h |  26 +++++
 include/linux/blk-integrity.h   |   1 +
 include/linux/crc64.h           |   2 +
 include/linux/nvme.h            |  53 ++++++++-
 include/linux/t10-pi.h          |  20 ++++
 lib/Kconfig.debug               |   3 +
 lib/Makefile                    |   1 +
 lib/crc64.c                     |  79 +++++++++++++
 lib/gen_crc64table.c            |  33 ++++--
 lib/test_crc64.c                |  68 +++++++++++
 15 files changed, 608 insertions(+), 46 deletions(-)
 create mode 100644 lib/test_crc64.c

-- 
2.25.4

