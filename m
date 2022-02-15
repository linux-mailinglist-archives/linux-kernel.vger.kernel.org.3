Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E424C4B7158
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiBOOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:51:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbiBOOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:51:25 -0500
Received: from outbound-smtp06.blacknight.com (outbound-smtp06.blacknight.com [81.17.249.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E146011940B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:49:48 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 281F5C2AA9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:49:27 +0000 (GMT)
Received: (qmail 6599 invoked from network); 15 Feb 2022 14:49:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Feb 2022 14:49:26 -0000
Date:   Tue, 15 Feb 2022 14:49:24 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Shuang Zhai <szhai2@cs.rochester.edu>
Cc:     akpm@linux-foundation.org, djwong@kernel.org, efault@gmx.de,
        hakavlad@inbox.lv, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        regressions@lists.linux.dev, riel@surriel.com, vbabka@suse.cz
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20220215144924.GS3366@techsingularity.net>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <20220214211050.31049-1-szhai2@cs.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220214211050.31049-1-szhai2@cs.rochester.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 04:10:50PM -0500, Shuang Zhai wrote:
> Hi Mel,
> 
> Mel Gorman wrote:
> >
> > Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> > problems due to reclaim throttling for excessive lengths of time.
> > In Alexey's case, a memory hog that should go OOM quickly stalls for
> > several minutes before stalling. In Mike and Darrick's cases, a small
> > memcg environment stalled excessively even though the system had enough
> > memory overall.
> >
> 
> I recently found a regression when I tested MGLRU with fio on Linux
> 5.16-rc6 [1]. After this patch was applied, I re-ran the test with Linux
> 5.16, but the regression has not been fixed yet. 
> 

Am I correct in thinging that this only happens with MGLRU?

-- 
Mel Gorman
SUSE Labs
