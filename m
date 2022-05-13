Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACC05267E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382763AbiEMRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382762AbiEMRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213BB6161F;
        Fri, 13 May 2022 10:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B17376201D;
        Fri, 13 May 2022 17:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00530C34100;
        Fri, 13 May 2022 17:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652461706;
        bh=yyta1JDBNdTqYBJ7QeiOI5lEnbOq/t1YaTxEBduqntY=;
        h=Date:From:To:Cc:Subject:From;
        b=Zsl5a0c3oklW3J24GmN19JMzXlCtDk0w0R4CkKkbYTih9+4C3LPSyb2g12acZxvts
         JGIfBdDRclKn5YGxu4nBR+/Fs4ktdS4lcM7qCbfXGX7xlQzwWL/s6DjZljPfcrhCKa
         nAHNRzjHPOuiA6RsW7uuu9CdGbIXGAUTUgN4lK/4=
Date:   Fri, 13 May 2022 10:08:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 5.18-rc7
Message-Id: <20220513100825.701c0801de7f18168c4d838c@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a bunch of hotfixes for 5.18-rc7.


The following changes since commit 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4:

  Merge tag 'drm-fixes-2022-04-29' of git://anongit.freedesktop.org/drm/drm (2022-04-28 18:00:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-05-11

for you to fetch changes up to 9039b8335276569670caaf23606335946625e764:

  MAINTAINERS: add a mailing list for DAMON development (2022-05-09 17:34:29 -0700)

----------------------------------------------------------------

Seven MM fixes, three of which address issues added in the most recent
merge window, four of which are cc:stable.

Three non-MM fixes, none very serious.

----------------------------------------------------------------
Hyeonggon Yoo (1):
      mm/kfence: reset PG_slab and memcg_data before freeing __kfence_pool

Joel Savitz (1):
      selftests: vm: Makefile: rename TARGETS to VMTARGETS

Kalesh Singh (1):
      procfs: prevent unprivileged processes accessing fdinfo dir

Martyna Szapar-Mudlaw (1):
      mailmap: add entry for martyna.szapar-mudlaw@intel.com

Mike Rapoport (1):
      arm[64]/memremap: don't abuse pfn_valid() to ensure presence of linear map

Naoya Horiguchi (1):
      mm/hwpoison: use pr_err() instead of dump_page() in get_any_page()

Niels Dossche (1):
      mm: mremap: fix sign for EFAULT error return value

SeongJae Park (1):
      MAINTAINERS: add a mailing list for DAMON development

Xu Yu (2):
      Revert "mm/memory-failure.c: skip huge_zero_page in memory_failure()"
      mm/huge_memory: do not overkill when splitting huge_zero_page

 .mailmap                            |  1 +
 MAINTAINERS                         |  1 +
 arch/arm/include/asm/io.h           |  3 +++
 arch/arm/mm/ioremap.c               |  8 ++++++++
 arch/arm64/include/asm/io.h         |  4 ++++
 arch/arm64/mm/ioremap.c             |  8 ++++++++
 fs/proc/fd.c                        | 23 ++++++++++++++++++++++-
 mm/huge_memory.c                    |  7 ++++++-
 mm/kfence/core.c                    | 10 ++++++++++
 mm/memory-failure.c                 | 15 +--------------
 mm/mremap.c                         |  2 +-
 tools/testing/selftests/vm/Makefile | 10 +++++-----
 12 files changed, 70 insertions(+), 22 deletions(-)

