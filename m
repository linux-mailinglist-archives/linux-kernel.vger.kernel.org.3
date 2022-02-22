Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2814BFEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiBVQdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiBVQcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:32:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FA6113AF4;
        Tue, 22 Feb 2022 08:32:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB23ACE17B2;
        Tue, 22 Feb 2022 16:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9012BC340F5;
        Tue, 22 Feb 2022 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547539;
        bh=GJp5srIWu1c79tiofwNLlNLZx6fG9DBOwi7z0tds3LI=;
        h=From:To:Cc:Subject:Date:From;
        b=XdA8/bxNpbpVX6QJl+I/qhRyqv6XOhDuEMTsHWEumj7DeyznddJGH/53kesCj5+K1
         l5bFGUXHsk9D7Ls0v6wkM/b/469AUrJmpD0FSDRE81CyfTqi0meX209dvMYqTwOcs4
         kjZ/AbLbmfWj9n5fycJOWsrBlFqcgyB7rCKVn+/vx85iqnmkgOgIp2D8j/QBLKKxep
         7csetHDCTeThLrtJbfN725lc3epyEvIvq99XhPv3jZMD9eQanGBsQ421geAa1YHv+i
         jCyRK9FT6zBfcitT1n09gHoSmbfIDOqAozALpu63mZ05b7lOnC4ru5R4fTiJUlbsPY
         uWWoyp/8P36Hg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 00/10] 64-bit data integrity field support
Date:   Tue, 22 Feb 2022 08:31:34 -0800
Message-Id: <20220222163144.1782447-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes since v2:

  Introduced lower_48_bits() (Bart)

  Added "64" suffix to crc names to distinguish from other crc
  calculations (Martin)

  Added module support to crypto library, and have the integrity
  generate/verify use that instead of directly calling the generic table
  lookup implementation. This is modeled after the t10 implementation.

  Added an x86 pclmul accelerated crc64 calculation

  Added speed tests to the test module so that the generic and library
  function could be compared.

  Bug fix in nvme to select the correct integrity profile.

  Added reviews

Note, I am not particularly well versed with x86 assembly, so I'm reasonably
sure that the pcl implementation could be improved. It currently is
about 20x faster than the generic implementation, but I believe it could
be over 30x faster if done more efficiently.

Keith Busch (10):
  block: support pi with extended metadata
  nvme: allow integrity on extended metadata formats
  asm-generic: introduce be48 unaligned accessors
  linux/kernel: introduce lower_48_bits macro
  lib: add rocksoft model crc64
  crypto: add rocksoft 64b crc guard tag framework
  lib: add crc64 tests
  block: add pi for nvme enhanced integrity
  nvme: add support for enhanced metadata
  x86/crypto: add pclmul acceleration for crc64

 arch/x86/crypto/Makefile                  |   3 +
 arch/x86/crypto/crc64-rocksoft-pcl-asm.S  | 215 ++++++++++++++++++++++
 arch/x86/crypto/crc64-rocksoft-pcl_glue.c | 117 ++++++++++++
 block/Kconfig                             |   1 +
 block/bio-integrity.c                     |   1 +
 block/t10-pi.c                            | 198 +++++++++++++++++++-
 crypto/Kconfig                            |  20 ++
 crypto/Makefile                           |   1 +
 crypto/crc64_rocksoft_generic.c           | 104 +++++++++++
 drivers/nvme/host/core.c                  | 175 ++++++++++++++----
 drivers/nvme/host/nvme.h                  |   4 +-
 include/asm-generic/unaligned.h           |  26 +++
 include/linux/blk-integrity.h             |   1 +
 include/linux/crc64.h                     |   7 +
 include/linux/kernel.h                    |   6 +
 include/linux/nvme.h                      |  53 +++++-
 include/linux/t10-pi.h                    |  20 ++
 lib/Kconfig                               |   9 +
 lib/Kconfig.debug                         |   4 +
 lib/Makefile                              |   2 +
 lib/crc64-rocksoft.c                      | 129 +++++++++++++
 lib/crc64.c                               |  26 +++
 lib/gen_crc64table.c                      |  51 +++--
 lib/test_crc64.c                          | 133 +++++++++++++
 24 files changed, 1252 insertions(+), 54 deletions(-)
 create mode 100644 arch/x86/crypto/crc64-rocksoft-pcl-asm.S
 create mode 100644 arch/x86/crypto/crc64-rocksoft-pcl_glue.c
 create mode 100644 crypto/crc64_rocksoft_generic.c
 create mode 100644 lib/crc64-rocksoft.c
 create mode 100644 lib/test_crc64.c

-- 
2.25.4

