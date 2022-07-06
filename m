Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4593D568BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiGFOwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiGFOws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:52:48 -0400
Received: from outbound-smtp27.blacknight.com (outbound-smtp27.blacknight.com [81.17.249.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A6B25E89
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:52:45 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 4C6FFCAC44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:52:44 +0100 (IST)
Received: (qmail 16294 invoked from network); 6 Jul 2022 14:52:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jul 2022 14:52:44 -0000
Date:   Wed, 6 Jul 2022 15:52:41 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        lkp@lists.01.org, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [mm/page_alloc]  2bd8eec68f:
 BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c
Message-ID: <20220706145241.GG27531@techsingularity.net>
References: <20220613125622.18628-8-mgorman@techsingularity.net>
 <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
 <20220703132209.875b823d1cb7169a8d51d56d@linux-foundation.org>
 <YsRB3fZHAfik0M/q@xsang-OptiPlex-9020>
 <20220706095535.GD27531@techsingularity.net>
 <20220706115328.GE27531@techsingularity.net>
 <YsWacP1k8wMgGfXx@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YsWacP1k8wMgGfXx@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:21:36PM +0800, Oliver Sang wrote:
> > I tried reproducing this on a 2-socket machine with Xeon
> > Gold Gold 5218R CPUs. It was necessary to set timeouts in both
> > vm/settings and kselftest/runner.sh to avoid timeouts. Testing with
> > a standard config on my original 5.19-rc3 baseline and the baseline
> > b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3 both passed. I tried your kernel
> > config with i915 disabled (would not build) and necessary storage drivers
> > and network drivers enabled (for boot and access). The kernel log shows
> > a bunch of warnings related to USBAN during boot and during some of the
> > tests but otherwise compaction_test completed successfully as well as
> > the other VM tests.
> > 
> > Is this always reproducible?
> 
> not always but high rate.
> we actually also observed other dmesgs stats for both 2bd8eec68f74 and its
> parent

Ok, it's unclear what the "other dmesg stats" are but given that it happens
for the parent. Does 5.19-rc2 (your baseline) have the same messages as
2bd8eec68f74^? Does the kselftests vm suite always pass but sometimes
fails with 2bd8eec68f74?

> but those dmesg.BUG:sleeping_function_called_from_invalid_context_at*
> seem only happen on 2bd8eec68f74 as well as the '-fix' commit.
> 

And roughly how often does it happen? I'm running it in a loop now to
see if I can trigger it locally.

-- 
Mel Gorman
SUSE Labs
