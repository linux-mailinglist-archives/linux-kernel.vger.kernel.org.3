Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F72457D875
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiGVCVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiGVCVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:21:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54108165A5;
        Thu, 21 Jul 2022 19:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE94A61FE3;
        Fri, 22 Jul 2022 02:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F8EC341C0;
        Fri, 22 Jul 2022 02:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658456500;
        bh=ncGLMjzdPPmGwsftGxVVHrTSznyG4+8eYOtav3O3ENM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZXmgh5CAKIBO0uWGZ6PYfe3yyzPWU2LLCnBILXDwAjY9xbwFR2UKlnxpeYSwAYUp
         mn0N5qYf8hrCA/G45tw+5HXpREdu835ZKnbkzKeunmfxS9dHqQePqiz7BmJ7dtIoKO
         NuKbSspV2XLxLcGl18XIR3QOIbB9lfD1PVSBuAQcAhcWwwZ228k1kId44mvjI5+Io9
         2x0odLgDayRVk/AIPJc3REu801gpkaYYQRlEfIIxaUCcPkL0nj2l0cwvSbDdPL0ACw
         xftrtTG0gHX8OxbQDASeCKxT+jUt12VVlRcwRCB7sF7LXUOH6ySW1zUOPvpasX2B8b
         EL8oJsgexxeTQ==
Date:   Thu, 21 Jul 2022 19:21:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [xfs]  345a4666a7:  vm-scalability.throughput -91.7% regression
Message-ID: <YtoJs8mv7vle8Mhh@magnolia>
References: <Ytlr9vZbF4SOfA2n@xsang-OptiPlex-9020>
 <20220721213337.GV3861211@dread.disaster.area>
 <YtnHa/IbHyD1QPh0@magnolia>
 <YtoG+kcaC8yfMEZW@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtoG+kcaC8yfMEZW@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 10:10:02AM +0800, Oliver Sang wrote:
> Hi Darrick, Hi Dave, and all,
> 
> sorry for this report is annoying according to Darrick and Dave's comments
> below.
> we will investigate this case and refine our report process.

FWIW, you can still send /me/ reports about the xfs development patches
I post to djwong/xfs-linux.git, but it's not necessary to cc linux-xfs
with that, since most of those patches are still under development
and/or working their way through patch review.

--D

> 
> On Thu, Jul 21, 2022 at 02:38:51PM -0700, Darrick J. Wong wrote:
> > On Fri, Jul 22, 2022 at 07:33:37AM +1000, Dave Chinner wrote:
> > > On Thu, Jul 21, 2022 at 11:08:38PM +0800, kernel test robot wrote:
> > > > 
> > > > (just FYI for the possible performance impact of disabling large folios,
> > > > our config, as attached, set default N to XFS_LARGE_FOLIOS)
> > > > 
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed a -91.7% regression of vm-scalability.throughput due to commit:
> > > > 
> > > > 
> > > > commit: 345a4666a721a81c343186768cdd95817767195f ("xfs: disable large folios except for developers")
> > > 
> > > Say what? I've never seen that change go past on a public list...
> > > 
> > > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git xfs-5.20-merge
> > > 
> > > Oh, it's in a developer's working tree, not something that has been
> > > proposed for review let alone been merged.
> > 
> > Correct, djwong-dev has a patch so that I can disable multipage folios
> > so that I could get other QA work done while willy and I try to sort out
> > the generic/522 corruption problems.
> > 
> > > So why is this report being sent to lkml, linux-xfs, etc as if it
> > > was a change merged into an upstream tree rather than just the
> > > developer who owns the tree the commit is in?
> > 
> > I was wondering that myself.
> > 
> > --D
> > 
> > > -Dave.
> > > -- 
> > > Dave Chinner
> > > david@fromorbit.com
