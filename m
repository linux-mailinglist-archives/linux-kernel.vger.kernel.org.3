Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580A557D62C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiGUVi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGUViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:38:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA5A9363A;
        Thu, 21 Jul 2022 14:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E1CAB82694;
        Thu, 21 Jul 2022 21:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8F4C3411E;
        Thu, 21 Jul 2022 21:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658439532;
        bh=Mt09URF0i4HDUXQYs2ZJjNJO5v2gBmKKj3dP82wOvLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXtVTp1V12QLvDDLVppJpqLvBbRswptQjSkt8L4X23EtCItQ5vNS3xjGAFH8k1h5d
         e95yA5GnVRZrkYkZ798TLmtYB88PedrjPVTfF1R65LGKRuJN8rdPIUep8/3ZoR3WCs
         TIWBroRWpsHt99ZB/sCKHZhabrbRWGbZUWf9A/fk/o+0O8Vw6x+2paTqokfMD0ZryW
         O7whNe5PvvwilIv6iyWFnjPjYgwkanSYmfeHdr2sDtj3xRVhfw6EZJJi6BbAoli6Bb
         8DdktXRQwmS1A/5ojraCEo9qZlQTCrKL0yS88cYwhbCBcNJdcEeJiStSOF/hEe2dX4
         PIV7ksiyx0o1w==
Date:   Thu, 21 Jul 2022 14:38:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [xfs]  345a4666a7:  vm-scalability.throughput -91.7% regression
Message-ID: <YtnHa/IbHyD1QPh0@magnolia>
References: <Ytlr9vZbF4SOfA2n@xsang-OptiPlex-9020>
 <20220721213337.GV3861211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721213337.GV3861211@dread.disaster.area>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 07:33:37AM +1000, Dave Chinner wrote:
> On Thu, Jul 21, 2022 at 11:08:38PM +0800, kernel test robot wrote:
> > 
> > (just FYI for the possible performance impact of disabling large folios,
> > our config, as attached, set default N to XFS_LARGE_FOLIOS)
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed a -91.7% regression of vm-scalability.throughput due to commit:
> > 
> > 
> > commit: 345a4666a721a81c343186768cdd95817767195f ("xfs: disable large folios except for developers")
> 
> Say what? I've never seen that change go past on a public list...
> 
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git xfs-5.20-merge
> 
> Oh, it's in a developer's working tree, not something that has been
> proposed for review let alone been merged.

Correct, djwong-dev has a patch so that I can disable multipage folios
so that I could get other QA work done while willy and I try to sort out
the generic/522 corruption problems.

> So why is this report being sent to lkml, linux-xfs, etc as if it
> was a change merged into an upstream tree rather than just the
> developer who owns the tree the commit is in?

I was wondering that myself.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
