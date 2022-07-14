Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2822D574174
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiGNCeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGNCd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:33:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67D13F6D;
        Wed, 13 Jul 2022 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657766036; x=1689302036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I5hjFOSDtYbEsmlYEojMoJNQjvq4evioSAOLKrCe7hw=;
  b=i2GdmA7lH/bIAOxczeu8QxULCqj8dndMeV6Acw2ltGhjcEPFy/I2Awit
   7HH5iuoFDMxIvhTZ++8o6ByITszcV/9y8p7IuQtPuL+EHFwVeNeyCzUcf
   QRIQa0lC57Q5kYf9GN0D81zSdRkx4lJzZg9T+vtIdHZReSfgCvI8Kx/Jf
   3JaL4QKp4BW3USNj6m8aV3B2q4A9HYFz1BBUSjI1OGhiiF9lbIlaemZW/
   PXX8fUKMF2Vf05HBUZ+jVkTG2oZ5vDKlfbWYzVvzm0h9CeZ2u4MHKfWjr
   GVE9cJCPSi1YcqzTMIa8hqrIuMRYD1aT7qjv8P+F76hhKKkndd1GMnyeh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="284151378"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="284151378"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 19:33:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="653670813"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 19:33:54 -0700
Date:   Thu, 14 Jul 2022 10:33:46 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [xfs]  47a6df7cd3: Assertion_failed
Message-ID: <Ys+AiruchaUl697w@xsang-OptiPlex-9020>
References: <Ys0gqOUcLr+2dle5@xsang-OptiPlex-9020>
 <20220712214745.GL3861211@dread.disaster.area>
 <Ys5lVZF3V53LQ+Ty@xsang-OptiPlex-9020>
 <20220714012421.GO3861211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714012421.GO3861211@dread.disaster.area>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

On Thu, Jul 14, 2022 at 11:24:21AM +1000, Dave Chinner wrote:
> On Wed, Jul 13, 2022 at 02:25:25PM +0800, Oliver Sang wrote:
> > hi Dave,
> > 
> > On Wed, Jul 13, 2022 at 07:47:45AM +1000, Dave Chinner wrote:
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > 
> > > > 
> > > > [   94.271323][ T9089] XFS (sda5): Mounting V5 Filesystem
> > > > [   94.369992][ T9089] XFS (sda5): Ending clean mount
> > > > [   94.376046][ T9089] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
> > > > [  112.154792][  T311] xfs/076       IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
> > > > [  112.154805][  T311]
> > > > [  161.426026][T29384] XFS: Assertion failed: xfs_is_shutdown(mp) || list_empty(&tp->t_dfops), file: fs/xfs/xfs_trans.c, line: 951
> > > > [  161.437713][T29384] ------------[ cut here ]------------
> > > > [  161.443155][T29384] kernel BUG at fs/xfs/xfs_message.c:110!
> > > > [  161.448854][T29384] invalid opcode: 0000 [#1] SMP KASAN PTI
> > > > [  161.454536][T29384] CPU: 1 PID: 29384 Comm: touch Not tainted 5.16.0-rc5-00001-g47a6df7cd317 #1
> > > 
> > > 5.16-rc5? Seems like a really old kernel to be testing....
> > > 
> > > Does this reproduce on a current 5.19-rc6 kernel?
> > 
> > yes, it's still reproducible. however, it's actually random on both 47a6df7cd3
> > and 5.19-rc6, as below.
> > it's clean on 40 runs of v5.16-rc5,
> > on 47a6df7cd3, it's reproduced 9 times out of 40 runs,
> 
> Of course, 47a6df7cd3 introduced the ASSERT that is firing. You'll
> never see the failure on kernels before this, even if the issue is
> occurring. It also points out this isn't a new issue, it's been
> around since before we added detection of it.

understood. for such kind of ASSERT (or WARNING, etc.) we normally reported
on the commit we could bisected out (like this 47a6df7cd3 :) ) just for
information since it could help people in the area to notice there is maybe
something wrong around.

it's kind of hard for us to backport the commit to old commits then each step
of bisection to figure out when the issue really starts to happen,  (but hope
we can do this one day :) )

> 
> > on v5.19-rc6, it's reprodced 7 times out of 20 runs.
> 
> Hmmm. I've just run 50 iterations here on my 5.19-rc6 based VMs
> and I haven't seen a single failure. So it's not failing regularly
> here which means it is influenced by environmental factors.
> 
> How big are the disks you are testing with?

for this xfstests/4HDD-xfs-xfs-group-07 test, we used 4 HDD, each with the size
of 300G.

but I noticed the ASSERT always happen after xfs/076, which seems only use two
of them (below sda2, sda5)

[   92.590707][ T1440] run fstests xfs/076 at 2022-07-13 01:44:34
[   93.231849][ T8987] XFS (sda2): Mounting V5 Filesystem
[   93.267497][ T8987] XFS (sda2): Ending clean mount
[   93.274183][ T8987] xfs filesystem being mounted at /fs/sda2 supports timestamps until 2038 (0x7fffffff)
[   95.221223][ T9080] XFS (sda5): Mounting V5 Filesystem
[   95.384072][ T9080] XFS (sda5): Ending clean mount
[   95.409130][ T9080] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
[   95.425082][ T9089] XFS (sda5): Unmounting Filesystem
[   95.752530][ T9111] XFS (sda5): Mounting V5 Filesystem
[   95.827062][ T9111] XFS (sda5): Ending clean mount
[   95.833635][ T9111] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
[  113.521272][  T306] xfs/076       IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
[  113.521286][  T306]
[  162.318194][T29029] XFS: Assertion failed: xfs_is_shutdown(mp) || list_empty(&tp->t_dfops), file: fs/xfs/xfs_trans.c, line: 993
[  162.330026][T29029] ------------[ cut here ]------------
...

root@lkp-ivb-d04 ~# lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0   1.8T  0 disk
|-sda1   8:1    0   400G  0 part
|-sda2   8:2    0   300G  0 part     <----------
|-sda3   8:3    0   300G  0 part
|-sda4   8:4    0   300G  0 part
`-sda5   8:5    0   300G  0 part     <----------
sdb      8:16   0 223.6G  0 disk
`-sdb1   8:17   0 223.6G  0 part


root@lkp-ivb-d04 ~# lsblk -f
NAME   FSTYPE FSVER LABEL      UUID                                 FSAVAIL FSUSE% MOUNTPOINT
sda
|-sda1 btrfs                   1c70720c-3bc1-4cda-b623-7eeebdf0eace
|-sda2 xfs                     f03ce528-b832-4844-8a14-65977d07ecf2      <--------
|-sda3
|-sda4
`-sda5 xfs                     e95d9e0e-46a3-4fe6-8b4c-19bc1e2b2dfe      <--------
sdb
`-sdb1 ocfs2  0.90  single_run a218e812-7152-4a71-a666-2379ff94dd40



> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
