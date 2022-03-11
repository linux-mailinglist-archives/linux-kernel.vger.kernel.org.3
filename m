Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20FB4D687E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbiCKSie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350900AbiCKSic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:38:32 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDAAEF086
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:37:23 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 891E15C0280;
        Fri, 11 Mar 2022 13:37:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 11 Mar 2022 13:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=TgAjhIkOL4djBM5FpuEMFxa6KkvWDlqtD7Es4i
        7z+08=; b=LDGb0KVvLWeQS+mPr4Et8KmMFsGtZM9+RcNalFsoxqWXm7k8dFvpyC
        9nzilJJ3qMfDUqr9nyK8iUsWToh+yx85qWOwio4g1LITqMN4xkTiDBhSTz+nst5A
        htNDIM5ykSepTsTv24x4hQMcXHK+np4DB29/9X3rRswSbCtj8X5Q2o1GvmCYemT0
        WAFWjgMiT2qEKwGzpyr8XchXLMpQxZaVJSxaBLXufVyx4azVhAfVmQXTUIA2LZTC
        jhE+Q5LT9clc+yR4Ev52lNiGZaMA2mVhFSxrh1j2t32hlREKbCvDdILqBi257qri
        6suU6yfOm05sJVTky/2FKyj8ThCy3AXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
        :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=TgAjhIkOL4djBM5FpuEMFxa6KkvWD
        lqtD7Es4i7z+08=; b=oscN0QG2dR2yBHicaGI5+zcxJRXwma/ZDZMbaIQv/ImN1
        EL+U0IR7uM/89zDl4xQxwLnfopc7mp0Hu3VI1VyNbkohITeqvzMaAkIjlhwJAMg+
        XsNwaupVJYqBbvSausqa5Aq2RgzgAyYrl246w5Xeqshj6DTRnZDwkybatnRPdkcd
        oVBtMQGrsrzQyxgEMjKu592Df5JCD+yZbucPJQSa97oxk8AAt5CNZTu8lx4a0iUw
        MLVonAsJUqL9LK2ZyiYiTYSpmdLgFv+h1wgPDoNHeTq0Gk3QN9YLTTTozPcNW/jA
        gSPI2j/pudcufPee6zK/kyu6EIN7bGMjG8zFu2XTA==
X-ME-Sender: <xms:4JYrYspUh7COeeVYDNVsU5jwEvlC6pPE7biK2aSI6t_ft_DA4zVQlg>
    <xme:4JYrYiqy-l10Un6HFAnc9GnrwnApp45BA4W6_4V_n-PBJJh2S5XGzn9BH15fBvdkF
    J5u3gye9_2Ph1dO2A>
X-ME-Received: <xmr:4JYrYhPw5-GlG7xy-0oEE1lVt8PAmQVnEw37aZ1Z4mMV5Njlb44Gow5iz_gdYjjckpr153eO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitd
    ejgffhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:4JYrYj622aF6XrLHEogg5o92Pkx61xHkDRHehqiTD4Ts6UU8Y5_Qfw>
    <xmx:4JYrYr4Q2oQOBtc86wWTxgLibVmjeQpi_j2lqf2M80vw0YXtNrANfg>
    <xmx:4JYrYjhx8i9CggaPZbZ8JGjrAxB9jymom3GUjQDs428xHdVde5lUNw>
    <xmx:4ZYrYoHi4LzlUYXpzRKT-zp_CCa86IZLpYQJp-M78TWEoyCxk07qiQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Mar 2022 13:37:20 -0500 (EST)
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
Subject: [PATCH v7 0/5] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Fri, 11 Mar 2022 13:36:51 -0500
Message-Id: <20220311183656.1911811-1-zi.yan@sent.com>
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
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-03-10-21-3=
8.

Changelog
=3D=3D=3D
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
 include/linux/page-isolation.h |  14 +-
 mm/internal.h                  |   6 +
 mm/memory_hotplug.c            |   3 +-
 mm/page_alloc.c                | 246 +++++++--------------------
 mm/page_isolation.c            | 296 +++++++++++++++++++++++++++++++--
 8 files changed, 367 insertions(+), 213 deletions(-)

--=20
2.35.1

