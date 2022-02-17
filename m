Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1236B4B94E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbiBQAWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:22:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbiBQAWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:22:54 -0500
Received: from outbound-smtp26.blacknight.com (outbound-smtp26.blacknight.com [81.17.249.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC1137744
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:22:39 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 878D0CAD5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:22:38 +0000 (GMT)
Received: (qmail 22298 invoked from network); 17 Feb 2022 00:22:38 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 17 Feb 2022 00:22:38 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 0/6] Follow-up on high-order PCP caching
Date:   Thu, 17 Feb 2022 00:22:21 +0000
Message-Id: <20220217002227.5739-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replaces v1 of the "Follow-up on high-order PCP caching"
series in mmots.

Changelog since v1
o Drain the requested PCP list first			(vbabka)
o Use [min|max]_pindex properly to reduce search depth	(vbabka)
o Update benchmark results in changelogs

Commit 44042b449872 ("mm/page_alloc: allow high-order pages to be
stored on the per-cpu lists") was primarily aimed at reducing the cost
of SLUB cache refills of high-order pages in two ways. Firstly, zone
lock acquisitions was reduced and secondly, there were fewer buddy list
modifications. This is a follow-up series fixing some issues that became
apparant after merging.

Patch 1 is a functional fix. It's harmless but inefficient.

Patches 2-5 reduce the overhead of bulk freeing of PCP pages. While
the overhead is small, it's cumulative and noticable when truncating
large files. The changelog for patch 4 includes results of a microbench
that deletes large sparse files with data in page cache. Sparse files
were used to eliminate filesystem overhead.

Patch 6 addresses issues with high-order PCP pages being stored on PCP
lists for too long. Pages freed on a CPU potentially may not be quickly
reused and in some cases this can increase cache miss rates.  Details are
included in the changelog.

 mm/page_alloc.c | 135 +++++++++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 66 deletions(-)

-- 
2.31.1

