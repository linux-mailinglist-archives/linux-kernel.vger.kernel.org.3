Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C50A4AB4E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbiBGGg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiBGGdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:33:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C018C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OAyNE091yCbn5wGWEV3bEarGLGijE2hU2ufW9HOL5jw=; b=WGwvHWbsXwe5wqUsSmyCBTNueH
        xk61jWDsclmQ3MXQmxsiFbu7uwHqSJFlej9Qi/rp8m99Hw0XniTY4A3Grnbh0Jpf1VGSxuMJfmUYm
        ReqqD/bAe6zwXBv/R5upJOQ70pLXbkMeYTzwwq4aNSgZRXW50435OU8wfWZmtiH9zyihvpaAef/c2
        f6w1YXhaNOSTsMQILzMse2D6uGCZM5oEEQZ/xpWwfHUziH6xa1jBRLQm7OyXnhPuzWDdfaOOTiCP6
        7AOcgAjdJsbIAuZ1YHMjx3F+HE0yRYwKzMGjA9gEucL9tbBUAcfeQjrYaEbc0IpLFJ2GpP5tb3eKs
        ZwA+tflg==;
Received: from [2001:4bb8:188:3efc:2cbe:55d7:bb63:46d2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGxZz-0099GK-6j; Mon, 07 Feb 2022 06:32:51 +0000
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
Subject: start sorting out the ZONE_DEVICE refcount mess
Date:   Mon,  7 Feb 2022 07:32:41 +0100
Message-Id: <20220207063249.1833066-1-hch@lst.de>
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

Diffstat:
 arch/arm64/mm/mmu.c                      |    1 
 arch/powerpc/kvm/book3s_hv_uvmem.c       |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |    1 
 drivers/gpu/drm/drm_cache.c              |    2 
 drivers/gpu/drm/nouveau/nouveau_dmem.c   |    3 -
 drivers/gpu/drm/nouveau/nouveau_svm.c    |    1 
 drivers/infiniband/core/rw.c             |    1 
 drivers/nvdimm/pmem.h                    |    1 
 drivers/nvme/host/pci.c                  |    1 
 drivers/nvme/target/io-cmd-bdev.c        |    1 
 fs/Kconfig                               |    2 
 fs/fuse/virtio_fs.c                      |    1 
 include/linux/hmm.h                      |    9 ----
 include/linux/memremap.h                 |   22 +++++++++-
 include/linux/mm.h                       |   59 ++++-------------------------
 lib/test_hmm.c                           |    4 +
 mm/Kconfig                               |    4 -
 mm/internal.h                            |    2 
 mm/memcontrol.c                          |   11 +----
 mm/memremap.c                            |   63 ++++++++++++++++---------------
 mm/migrate.c                             |    6 --
 mm/swap.c                                |   49 ++----------------------
 23 files changed, 90 insertions(+), 157 deletions(-)
