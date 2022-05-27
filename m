Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDFF536693
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353140AbiE0R3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiE0R3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:29:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A44DF4D;
        Fri, 27 May 2022 10:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B379DB82563;
        Fri, 27 May 2022 17:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D019C385A9;
        Fri, 27 May 2022 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653672588;
        bh=dXRXn3acix0mFrOqchNGNDczfWUrkP/pulD2yGBjfkQ=;
        h=Date:From:To:Cc:Subject:From;
        b=nrntJh4TXFaYHXCTbctJ1Cj5ZkRZzPRHtfxCQeSXMZ5IdYsRaLGBA54hk73bXJAKT
         hkaQTUIxdK8dwardv9BvxPLzL3AlinxKNLQWQghX61Y2UUxo9bsNaAhIUT2O5O4y5t
         TklLgl1oZ1FAsvvYv47ihQiEuGVRKTP2WD5f7cTY=
Date:   Fri, 27 May 2022 10:29:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 5.19-rc1
Message-Id: <20220527102947.9c7e74d491765ba74bb81374@linux-foundation.org>
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


The following changes since commit 9039b8335276569670caaf23606335946625e764:

  MAINTAINERS: add a mailing list for DAMON development (2022-05-09 17:34:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-05-27

for you to fetch changes up to 24c8e27e63224ce832b4723cb60632d3eddb55de:

  mm/page_table_check: fix accessing unmapped ptep (2022-05-27 08:55:18 -0700)

----------------------------------------------------------------
Six hotfixes.  One from Miaohe Lin is considered a minor thing so it isn't
for -stable.  The remainder address pre-5.19 issues and are cc:stable.

----------------------------------------------------------------
Dong Aisheng (1):
      Revert "mm/cma.c: remove redundant cma_mutex lock"

Mel Gorman (1):
      mm/page_alloc: always attempt to allocate at least one page during bulk allocation

Miaohe Lin (1):
      mm/page_table_check: fix accessing unmapped ptep

Mike Kravetz (1):
      hugetlb: fix huge_pmd_unshare address update

Naveen N. Rao (1):
      kexec_file: drop weak attribute from arch_kexec_apply_relocations[_add]

Sultan Alsawaf (1):
      zsmalloc: fix races between asynchronous zspage free and page migration

 arch/s390/include/asm/kexec.h | 10 ++++++++++
 arch/x86/include/asm/kexec.h  |  8 ++++++++
 include/linux/kexec.h         | 46 +++++++++++++++++++++++++++++++++++--------
 kernel/kexec_file.c           | 34 --------------------------------
 mm/cma.c                      |  4 +++-
 mm/hugetlb.c                  |  9 ++++++++-
 mm/page_alloc.c               |  4 ++--
 mm/page_table_check.c         |  2 +-
 mm/zsmalloc.c                 | 37 ++++++++++++++++++++++++++++++----
 9 files changed, 103 insertions(+), 51 deletions(-)

