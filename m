Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E74B2AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351760AbiBKQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:51:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351728AbiBKQvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:51:02 -0500
X-Greylist: delayed 553 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 08:51:00 PST
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911CDCCA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:50:59 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 48BE05801A3;
        Fri, 11 Feb 2022 11:41:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 11 Feb 2022 11:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=yn4EluHRFjIlAOq/f3660DeKnQykfQ+VjC9Svi
        DiUcQ=; b=LdE+LwdrS7vb8o8nfNSVlSj4rVFFw4oHar8ga/I9sHEKWwe6GMwTYw
        A9l1TC9pMw3Ce0fUnshitggrSRvGi/kBCqJeAedfFbyh9dHg6EaUCwKpV9momk4E
        HK1eZ4duGrtufvpbohtk+tXvFtKVZ4jhu5Ww88ISSq0/bO+OzQBbs9xWE9oK0qxW
        meb+rWN8T+MKOZMTRNrEi9XPuTr0vc+erhGrOdhRW/Cl7S4sVfGFtp3gFwDbBa0V
        gPVQQPiIC0zYrh6IQPjAvG4+aifGmOHcDKU899W9zgRVtZRVvDMF5clxclhbcAEg
        /YraeGdj6EksggCetKJnx+h2HoBrFmFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=yn4EluHRFjIlAOq/f3660DeKnQykf
        Q+VjC9SviDiUcQ=; b=Ipg7LKsLWh4QZ09hDyS6jxA1pzquPIkp3VZNNObGCO5R0
        EZAHG8gm2zX1i14doz/5VTiqAfFt8LWEaW3goX4eotgegTg6XFYxlf/dXUHM5t9N
        AGDvAn88dRfDo6guGNyzrONztvAaVbg61gQdqbaM1U3YlCuAQHs65Q1H88Jno3VI
        yyogEpGdka2teZglILqZyYarQPzTRXdLevdz+c62qNCTr5is/Ct2cgwapONuGE34
        Ir9XG0ei/3vNOgSv81Qb1asjX6zyDHW04XTC+3BylAhc1JkI8pQIgYiOerTDaUFS
        BjMfx/RDinYsREbrb63kH2aI1w914nMsrtI8Na7nA==
X-ME-Sender: <xms:x5EGYmKncaHEF1UdhiDGJmzmaD2yrBcb1HNvPp3U2tVV_awawzGjng>
    <xme:x5EGYuJsFGzOpVg9hlLVVdiuf0KHz15zqV4yj3xhJxqiyI9B_Hda-CbcClMJR5ayi
    7vwcV-TAsfeD872_g>
X-ME-Received: <xmr:x5EGYmvAPbLHaSg2Rdw1680ga65cQIoS5qFrG5RsunJb_fkJDvmxBoW9Feh7y2ldYd1GX3M1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcu
    oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitdejgf
    fhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:x5EGYrZ7stBQYd7OdV0zo7ZzuYtbRptVheIKi-XrCvgkpNyKy3stVw>
    <xmx:x5EGYtb0L1ODu_B3u0_uSL5KbS9aBFvF_vp_vHJnUV-7Axf7Qa1hOg>
    <xmx:x5EGYnAfkktLWYNMCOBS9M1unJvoNxT-JLktbx-T5X4ws7wV5ovgeg>
    <xmx:yZEGYjxyA-zHLLLU42PLY1_Elpui67zm6DG7NofcGUdJ8EPTYP6KSA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:43 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v5 0/6] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Fri, 11 Feb 2022 11:41:29 -0500
Message-Id: <20220211164135.1803616-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-02-08-15-3=
1.

Changelog
=3D=3D=3D
V5
---
1. Moved isolation address alignment handling in start_isolate_page_range().
2. Rewrote and simplified how alloc_contig_range() works at pageblock
   granularity (Patch 3). Only two pageblock migratetypes need to be saved =
and
   restored. start_isolate_page_range() might need to migrate pages in this
   version, but it prevents the caller from worrying about
   max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) alignment after the page ran=
ge
   is isolated.

V4
---
1. Dropped two irrelevant patches on non-lru compound page handling, as
   it is not supported upstream.
2. Renamed migratetype_has_fallback() to migratetype_is_mergeable().
3. Always check whether two pageblocks can be merged in
   __free_one_page() when order is >=3D pageblock_order, as the case (not
   mergeable pageblocks are isolated, CMA, and HIGHATOMIC) becomes more com=
mon.
3. Moving has_unmovable_pages() is now a separate patch.
4. Removed MAX_ORDER-1 alignment requirement in the comment in virtio_mem c=
ode.

Description
=3D=3D=3D

The MAX_ORDER - 1 alignment requirement comes from that alloc_contig_range()
isolates pageblocks to remove free memory from buddy allocator but isolating
only a subset of pageblocks within a page spanning across multiple pagebloc=
ks
causes free page accounting issues. Isolated page might not be put into the
right free list, since the code assumes the migratetype of the first pagebl=
ock
as the whole free page migratetype. This is based on the discussion at [2].

To remove the requirement, this patchset:
1. isolates pages at pageblock granularity instead of
   max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages);
2. splits free pages across the specified range or migrates in-use pages
   across the specified range then splits the freed page to avoid free page
   accounting issues (it happens when multiple pageblocks within a single p=
age
   have different migratetypes);
3. only checks unmovable pages within the range instead of MAX_ORDER - 1 al=
igned
   range during isolation to avoid alloc_contig_range() failure when pagebl=
ocks
   within a MAX_ORDER - 1 aligned range are allocated separately.
4. returns pages not in the range as it did before.

One optimization might come later:
1. make MIGRATE_ISOLATE a separate bit to be able to restore the original
   migratetypes when isolation fails in the middle of the range.

Feel free to give comments and suggestions. Thanks.

[1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@sent.c=
om/
[2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b947d2@r=
edhat.com/

Zi Yan (6):
  mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
  mm: page_isolation: check specified range for unmovable pages
  mm: make alloc_contig_range work at pageblock granularity
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.
  arch: powerpc: adjust fadump alignment to be pageblock aligned.

 arch/powerpc/include/asm/fadump-internal.h |   4 +-
 drivers/virtio/virtio_mem.c                |   7 +-
 include/linux/mmzone.h                     |   5 +-
 include/linux/page-isolation.h             |  16 +-
 kernel/dma/contiguous.c                    |   2 +-
 mm/cma.c                                   |   6 +-
 mm/internal.h                              |   3 +
 mm/memory_hotplug.c                        |   3 +-
 mm/page_alloc.c                            | 371 ++++++++++-----------
 mm/page_isolation.c                        | 172 +++++++++-
 10 files changed, 367 insertions(+), 222 deletions(-)

--=20
2.34.1

