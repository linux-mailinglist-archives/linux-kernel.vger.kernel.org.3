Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C022A4B7086
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiBOOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:52:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbiBOOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:51:58 -0500
Received: from outbound-smtp21.blacknight.com (outbound-smtp21.blacknight.com [81.17.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E91120
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:51:23 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id AADE0CCB67
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:51:22 +0000 (GMT)
Received: (qmail 13583 invoked from network); 15 Feb 2022 14:51:22 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 15 Feb 2022 14:51:22 -0000
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
Subject: [PATCH 0/5] Follow-up on high-order PCP caching
Date:   Tue, 15 Feb 2022 14:51:06 +0000
Message-Id: <20220215145111.27082-1-mgorman@techsingularity.net>
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

Commit 44042b449872 ("mm/page_alloc: allow high-order pages to be
stored on the per-cpu lists") was primarily aimed at reducing the cost
of SLUB cache refills of high-order pages in two ways. Firstly, zone
lock acquisitions was reduced and secondly, there were fewer buddy list
modifications. This is a follow-up series fixing some issues that became
apparant after merging.

Patch 1 is a functional fix. It's harmless but inefficient.

Patches 2-4 reduce the overhead of bulk freeing of PCP pages. While
the overhead is small, it's cumulative and noticable when truncating
large files. The changelog for patch 4 includes results of a microbench
that deletes large sparse files with data in page cache. Sparse files
were used to eliminate filesystem overhead.

Patch 5 addresses issues with high-order PCP pages being stored on PCP
lists for too long. Pages freed on a CPU potentially may not be quickly
reused and in some cases this can increase cache miss rates.  Details are
included in the changelog.

 mm/page_alloc.c | 128 ++++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

-- 
2.31.1

