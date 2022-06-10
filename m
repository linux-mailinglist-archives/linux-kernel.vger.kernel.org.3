Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2480E545BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbiFJFiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243950AbiFJFiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:38:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126D2584C2;
        Thu,  9 Jun 2022 22:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654839499; x=1686375499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mm671fARQkehGag+uwU37hxKBr75xWcEw+/mL45ZIZ4=;
  b=nj8fJ9FHgGK5L6gQaJSgHpsiw2c5qhr+KB0zxXV3o31Lmp6rs3RQ4DkF
   j9R9i6bYHrqPIKjq8bQsdev2m9zCkU0TqWkl5SuMDE7gOAMyYJ6IPsCvl
   bOahgEi0oBkwSxGBloaNn5JD0ytkVvmw2Ll3fVjx/gg8iAngp5xbmomCw
   lu7FZImkEzbihDaHyBbyD+YzulE6vf0nEHU3+jeTwHkuYIN97plNGiYKl
   HnEzNqIU1ioPjtGADr7rOV2JH8LCD7M6Jw+NPOj1sDjSqHOLbPQmkZxim
   SeiBpkhPQhc9Ih/7EMGaH7FNQDEbTCxMEjuxNkzDJzy924SgdgAFrca6e
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341586257"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="341586257"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 22:38:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637944682"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 22:38:16 -0700
Date:   Fri, 10 Jun 2022 13:38:07 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [xfs]  1eb70f54c4: xfstests.xfs.348.fail
Message-ID: <20220610053807.GA9136@xsang-OptiPlex-9020>
References: <20220602090409.GD27190@xsang-OptiPlex-9020>
 <20220602214436.GF1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602214436.GF1098723@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Fri, Jun 03, 2022 at 07:44:36AM +1000, Dave Chinner wrote:
> >     ...
> >     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/348.out /lkp/benchmarks/xfstests/results//xfs/348.out.bad'  to see the entire diff)
> > xfs/349	[failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/349.out.bad)
> >     --- tests/xfs/349.out	2022-05-16 16:42:32.000000000 +0000
> >     +++ /lkp/benchmarks/xfstests/results//xfs/349.out.bad	2022-05-18 11:53:51.101272360 +0000
> >     @@ -1,3 +1,2 @@
> >      QA output created by 349
> >      Format and populate
> >     -Scrub
> >     ...
> >     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/349.out /lkp/benchmarks/xfstests/results//xfs/349.out.bad'  to see the entire diff)
> 
> You are running a test in the "dangerous_fuzzers" group that isn't
> in the auto group. This is a test for developers to find error
> detection issues and, as such, failure is kinda expected. It is not
> regression test that can be used for pass/fail testing....

Thanks a lot for guidance! we will disable auto tests in "dangerous_fuzzers"
group.

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
