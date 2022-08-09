Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9D658D480
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiHIHZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiHIHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:25:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C95110E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51E92B80EED
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA290C433C1;
        Tue,  9 Aug 2022 07:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660029922;
        bh=0LChqBLur/1vL8sdoGSRTnx+IdOJAGSm3zJMhTg8KE4=;
        h=Date:From:To:Cc:Subject:From;
        b=BY4Ymap+shoQoX56j+8nP+I9i2/rms0IdC8STp9ov5xJheah+wNWG89c517MvdbFj
         z2bRDbbXprdlxgIVUM2YggYJv7nj0xEH5sP+M/+rWCTBXdHfzVKKYs+egg++QQpTU2
         0/gPQt/zTXmOCF11aXxCg+VOfcmDLeQr2bAdLq5w2ZavidVmeqHZlffE1NoUvn2Hhv
         qcPocXoOn4Jtk21xXlnw1RLYs6BRxAP9Po83VywzUIMt1JfgJiqcfulCb37u6JShn5
         vmSlsciuOh34ggTVyMMFL3mKvn59NgZBIFfMHwhpH0P8VnoL0pz64QDCwnzaPso2Re
         V0xss4SZRf/Rw==
Date:   Tue, 9 Aug 2022 10:25:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, Jinyu Tang <tjytimi@163.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>,
        Ma Wupeng <mawupeng1@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock updates for v5.20
Message-ID: <YvIL0wn1WTDxjFVr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.20-rc1

for you to fetch changes up to 04d9490986d1e04a38db88276115e6b3c9ec3faa:

  memblock test: Modify the obsolete description in README (2022-07-30 11:46:49 +0300)

----------------------------------------------------------------
memblock updates for v5.20

* An optimization in memblock_add_range() to reduce array traversals
* Improvements to the memblock test suite

----------------------------------------------------------------
Jinyu Tang (1):
      memblock: avoid some repeat when add new range

Liu Xinpeng (1):
      memblock tests: fix compilation errors

Rebecca Mckeever (5):
      memblock tests: Makefile: add arguments to control verbosity
      memblock tests: add verbose output to memblock tests
      memblock tests: set memblock_debug to enable memblock_dbg() messages
      memblock tests: remove completed TODO items
      memblock tests: change build options to run-time options

Shaoqin Huang (1):
      memblock test: Modify the obsolete description in README

 mm/memblock.c                                    |  11 +
 tools/testing/memblock/Makefile                  |   3 +-
 tools/testing/memblock/README                    |  17 +-
 tools/testing/memblock/TODO                      |  14 +-
 tools/testing/memblock/internal.h                |  11 +
 tools/testing/memblock/linux/memory_hotplug.h    |   8 +-
 tools/testing/memblock/main.c                    |   2 +
 tools/testing/memblock/scripts/Makefile.include  |  10 +-
 tools/testing/memblock/tests/alloc_api.c         | 225 ++++++++++-----
 tools/testing/memblock/tests/alloc_helpers_api.c | 129 ++++++---
 tools/testing/memblock/tests/alloc_nid_api.c     | 351 +++++++++++++++--------
 tools/testing/memblock/tests/basic_api.c         | 337 +++++++++++++++-------
 tools/testing/memblock/tests/common.c            | 118 ++++++++
 tools/testing/memblock/tests/common.h            |  54 ++++
 14 files changed, 920 insertions(+), 370 deletions(-)

-- 
Sincerely yours,
Mike.
