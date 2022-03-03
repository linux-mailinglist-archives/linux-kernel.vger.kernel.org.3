Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF294CC6DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiCCUOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiCCUOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:14:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10253B2D59;
        Thu,  3 Mar 2022 12:13:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8006561C36;
        Thu,  3 Mar 2022 20:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F49C004E1;
        Thu,  3 Mar 2022 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646338396;
        bh=ABLdWJrAQW/8RUZhNjgn3CF1lBXfUSvESej/WFPyg+U=;
        h=From:To:Cc:Subject:Date:From;
        b=SnSqinzexpa9E+Lxi/xlr1Il5+n7c0NFqtnAb745hk2p0v/QK24gXGOPUkD8BDrYR
         MR8SXFYaq+KE8hnbzi3I6THzwOIP+00Bwlctfb0sgsG3vCjXmSKpsCaNo/viPFeHgZ
         PLZbFoGHjBzGx4aualGnah2uMU/8hKeW51slGn6YLgKrwQZqQtgwpSCTPQ44+BQw4I
         TL2wLqSEtu93ExGJODfi82BR+y5OnE3dl6vX6KLOVyrbuoucklkrl5lYCHbsyXEpUU
         aSrWCaVc+j5cgXmUiSrwohQE3/x2CJnMi2OOtu4thFXyXJTrdDNZaKWrY2mo0P+xiU
         diKG1JVr8J7lQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/8] 64-bit data integrity field support
Date:   Thu,  3 Mar 2022 12:13:04 -0800
Message-Id: <20220303201312.3255347-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes since v3:

  - Replaced lower_48_bits() macro with inline function, and replaced
    0xffffffffffffull with the equivalent (1ull << 48) - 1

  - Replaced crc64 test module with new entry in crypto/testmgr.c

  - Renamed nvme_ function prefixes with ext_pi_

  - Placed bit inversion within crc64 calculation rather than rely on the
    caller to pass in an inverted initial value. This is necessary to
    update the crc value when its buffer is discontiguous, or updated in
    chunks.

  - Removed 'inline' from nvme driver's ref tag setup.

  - Added Review's for unchanged patches, removed reviews for the ones
    that changed.

  - lib/Kconfig dependency fix

  - Dropped the x86_64 PCLMULQDQ accelerated calculation. This task will
    be completed by people more experienced in this area, so expect a
    follow up soon.

Keith Busch (8):
  block: support pi with extended metadata
  nvme: allow integrity on extended metadata formats
  asm-generic: introduce be48 unaligned accessors
  linux/kernel: introduce lower_48_bits function
  lib: add rocksoft model crc64
  crypto: add rocksoft 64b crc guard tag framework
  block: add pi for nvme enhanced integrity
  nvme: add support for enhanced metadata

 block/Kconfig                   |   1 +
 block/bio-integrity.c           |   1 +
 block/t10-pi.c                  | 198 +++++++++++++++++++++++++++++++-
 crypto/Kconfig                  |   5 +
 crypto/Makefile                 |   1 +
 crypto/crc64_rocksoft_generic.c |  89 ++++++++++++++
 crypto/testmgr.c                |   7 ++
 crypto/testmgr.h                |  15 +++
 drivers/nvme/host/core.c        | 165 +++++++++++++++++++++-----
 drivers/nvme/host/nvme.h        |   4 +-
 include/asm-generic/unaligned.h |  26 +++++
 include/linux/blk-integrity.h   |   1 +
 include/linux/crc64.h           |   7 ++
 include/linux/kernel.h          |   9 ++
 include/linux/nvme.h            |  53 ++++++++-
 include/linux/t10-pi.h          |  20 ++++
 lib/Kconfig                     |   9 ++
 lib/Makefile                    |   1 +
 lib/crc64-rocksoft.c            | 129 +++++++++++++++++++++
 lib/crc64.c                     |  28 +++++
 lib/gen_crc64table.c            |  51 ++++++--
 21 files changed, 773 insertions(+), 47 deletions(-)
 create mode 100644 crypto/crc64_rocksoft_generic.c
 create mode 100644 lib/crc64-rocksoft.c

-- 
2.25.4

