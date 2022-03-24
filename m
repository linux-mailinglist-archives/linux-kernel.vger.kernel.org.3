Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4CB4E6ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355506AbiCXWqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355484AbiCXWqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:46:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1A1B6E49
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:44:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A89A5C0192;
        Thu, 24 Mar 2022 18:44:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 24 Mar 2022 18:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=j+TZHkjacQVCUMqJUGbs0PNUyDxfYCsbVptSbv
        Tldoc=; b=ea6FSxkna2NLpLPBrMIC6WomMrene8cDRtHA/GTu9fI098qvs8f+iK
        8CPIaFWJ8I8YaSYnBEF5OPIZ4/Un5ARwfNB3zdaYXM0k2CbFC535vm712O713Ebq
        4dLA+syb0iKrn+NwZAq2gUikMKRLCB4VoEg+y6OH76dzWStAWRcXraS9cJQL1GoY
        fCkUGiHcrwfz3Kr1Wj2DCwAcq2rEyrZx9Tflkm5gj4l+GgYRGFRR9+xZcqTkanYd
        QrFQZ3pQE88Su1rx/twxQbbT0lqVtHIPZZfkPEtUuDmIT31lbZL952drC6eLEUxg
        0YcReixPDhj+t07sfcE3qcROWJNc5CIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=j+TZHkjacQVCUMqJUGbs0PNUyDxfY
        CsbVptSbvTldoc=; b=Of1Gk3Lem13lyqJ0pG03KECRCL9ZDxAYBiSocAl4PIbR5
        LuxR/8+Alf9n4tuOtg91/PT6jTj9w4xxd1C1fGWsGrPm9tOX9vpJ4Ip6VG/t76yG
        86hWa13G2lZjNdcMDpQJ2REq13lSiw7mlSRdav1cdF9Yksr0fbfEDyw4ft4Jlaqf
        jGR3GUHPRVMhtnd4shRTaZncmQdiBcZW8+4eobCV19y7OzHapdMxPkSajRnz9ajw
        /Z2sEwVynsecnuQp2nzM4Xc4YtJ1DyxJTFLU7yh+Gui+uhwD0OCoANHFV7VBQRPu
        NiMVG9fOy+l6lyLH/oEvWPYbbfFI6MVkKR4uSfa2Q==
X-ME-Sender: <xms:V_Q8Yr12Vaelkxec3YUPO4N0sjumVHZwYsA9HTTxWi_EkTfOewgO6Q>
    <xme:V_Q8YqF4Q6xiwAZ83KImQBTK08Yn4ao09tRj_hX5nQ2NwawDNpIHYRWOtMj8fPJBm
    GIwYc-SjynFsZsxQQ>
X-ME-Received: <xmr:V_Q8Yr5a58AfbT5IToqSxMjLnBgN6WWb1YuUa_tCLm0dnfr-gPeSehgF-3sIuclAPYqMMO283hTtUxojFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitd
    ejgffhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:V_Q8Yg3DE67ztsWtZ66NJBHS1BxR7K6Swzws3FADx38WfmfZGk7Zcw>
    <xmx:V_Q8YuF-5zETrRPN7PLVjX1f6zAR608Mj-IWJHBXxRF-JQhPh4Wt7w>
    <xmx:V_Q8Yh_I4dGlOtqGB5v3A_JfrmYjQ9u1clCkAMb8X7mFcb_DNk1unQ>
    <xmx:V_Q8YhDBg7m0hlDmkiP82XqFdD4f76rC84n8SFc8gnVHAkDStSrtag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 18:44:38 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v9 0/5] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Thu, 24 Mar 2022 18:44:30 -0400
Message-Id: <20220324224435.17794-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
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

Hi David,

This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-03-16-17-4=
2.

Changelog
=3D=3D=3D
V9
---
1. Limited has_unmovable_pages() check within a pageblock.
2. Added a check to ensure page isolation is done within a single zone
   in isolate_single_pageblock().
3. Fixed an off-by-one bug in isolate_single_pageblock().
4. Fixed a NULL-deferencing bug when the pages before to-be-isolated pagebl=
ock
   is not online in isolate_single_pageblock().

V8
---
1. Cleaned up has_unmovable_pages() to remove page argument.

V7
---
1. Added page validity check in isolate_single_pageblock() to avoid out
   of zone pages.
2. Fixed a bug in split_free_page() to split and free pages in correct
   page order.

V6
---
1. Resolved compilation error/warning reported by kernel test robot.
2. Tried to solve the coding concerns from Christophe Leroy.
3. Shortened lengthy lines (pointed out by Christoph Hellwig).

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

Zi Yan (5):
  mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
  mm: page_isolation: check specified range for unmovable pages
  mm: make alloc_contig_range work at pageblock granularity
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.

 drivers/virtio/virtio_mem.c    |   6 +-
 include/linux/cma.h            |   4 +-
 include/linux/mmzone.h         |   5 +-
 include/linux/page-isolation.h |   4 +-
 mm/internal.h                  |   6 +
 mm/memory_hotplug.c            |   3 +-
 mm/page_alloc.c                | 244 ++++++-----------------
 mm/page_isolation.c            | 342 +++++++++++++++++++++++++++++++--
 8 files changed, 397 insertions(+), 217 deletions(-)

--=20
2.35.1

