Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3603E4B06FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiBJH2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:28:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiBJH2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:28:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866F726E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fKwV65Fx615k5LuIXkLcfiAVy//BhvLpTdyb0R61khg=; b=UBIrT7SYvmrOGapKs/IMJGZMJP
        rULomygyaaC55QDvs3eY68CeMZN8/C+Un5dhwOktX57xJXfoja7le1xanp8IT24T92jgKNogsi73U
        Vs9CL78FLc7OFzeln9OiPi/7vaiOEWqV6C55F6pZVXdbLeEo8ldf619JOUh2kLdEvFbEbfs4LZxZ3
        5qvQi9MVLtXFESagqUxWxaF5WV+V5JcZMy4pHRWVG/clCxw7rfcEHb30WuSh5pYSBuzRIj8PeF+Sn
        rhE6DpzHH+K5CChoU7tggXhlh61KLf/GmLxZLyL2cNDul5XrR+6rl7Cq4CkAIe4DZ9r8zj1m7ij2G
        Wyu4LoIQ==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI3sV-002rks-4y; Thu, 10 Feb 2022 07:28:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: start sorting out the ZONE_DEVICE refcount mess v2
Date:   Thu, 10 Feb 2022 08:28:01 +0100
Message-Id: <20220210072828.2930359-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series removes the offset by one refcount for ZONE_DEVICE pages
that are freed back to the driver owning them, which is just device
private ones for now, but also the planned device coherent pages
and the ehanced p2p ones pending.

It does not address the fsdax pages yet, which will be attacked in a
follow on series.

Note that if we want to get the p2p series rebased on top of this
we'll need a git branch for this series.  I could offer to host one.

A git tree is available here:

    git://git.infradead.org/users/hch/misc.git pgmap-refcount

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pgmap-refcount

Changes since v1:
 - add a missing memremap.h include in memcontrol.c
 - include rebased versions of the device coherent support and
   device coherent migration support series as well as additional
   cleanup patches

Diffstt:
 arch/arm64/mm/mmu.c                      |    1 
 arch/powerpc/kvm/book3s_hv_uvmem.c       |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |   35 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |    1 
 drivers/gpu/drm/drm_cache.c              |    2 
 drivers/gpu/drm/nouveau/nouveau_dmem.c   |    3 
 drivers/gpu/drm/nouveau/nouveau_svm.c    |    1 
 drivers/infiniband/core/rw.c             |    1 
 drivers/nvdimm/pmem.h                    |    1 
 drivers/nvme/host/pci.c                  |    1 
 drivers/nvme/target/io-cmd-bdev.c        |    1 
 fs/Kconfig                               |    2 
 fs/fuse/virtio_fs.c                      |    1 
 include/linux/hmm.h                      |    9 
 include/linux/memremap.h                 |   36 +
 include/linux/migrate.h                  |    1 
 include/linux/mm.h                       |   59 --
 lib/test_hmm.c                           |  353 ++++++++++---
 lib/test_hmm_uapi.h                      |   22 
 mm/Kconfig                               |    7 
 mm/Makefile                              |    1 
 mm/gup.c                                 |  127 +++-
 mm/internal.h                            |    3 
 mm/memcontrol.c                          |   19 
 mm/memory-failure.c                      |    8 
 mm/memremap.c                            |   75 +-
 mm/migrate.c                             |  763 ----------------------------
 mm/migrate_device.c                      |  822 +++++++++++++++++++++++++++++++
 mm/rmap.c                                |    5 
 mm/swap.c                                |   49 -
 tools/testing/selftests/vm/Makefile      |    2 
 tools/testing/selftests/vm/hmm-tests.c   |  204 ++++++-
 tools/testing/selftests/vm/test_hmm.sh   |   24 
 33 files changed, 1552 insertions(+), 1088 deletions(-)
