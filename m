Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4357F4DCD1F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiCQSC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiCQSCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:02:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C021C06B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22CF2B81F38
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8830C340E9;
        Thu, 17 Mar 2022 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647540089;
        bh=JEW54fZood4KCilmzL14XcFvhgaIqBFTiEYg2oezTIk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bV7Rf3JKOSC/BVgFIelEyR6gtZpzeCixm2JjCXRRWDmithtoFk2pL4glWOvo1C8Wj
         dhXPC3bHt4vudZ6fGesVg/VW9dcvdXNLTIFfvy3poCpeEBD5zl8AE00u0zi3y+H8ks
         HtqqOw82M9R1boqA/5gq7xB9Mg61XSNb/arUPbiwj7E4v+CmfzqgaK26PAQrnUvrrj
         +kn5s2RTZVmpquedmlzDxADO8vrH55XdlwwQd9tEXXNcuRUAyC3r+Y3pCKnIKc0rHK
         eJtkjqDmPIx/KF/KYjvTrgTfnKixq8hzzVhY/Uht3i+DDrObsqnZAqRc1pxvKtr1mc
         4pt3wArryZW8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7C0BF5C08A0; Thu, 17 Mar 2022 11:01:29 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:01:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [fixup! EXP srcu]  7bf8d644f8:
 WARNING:at_kernel/rcu/srcutree.c:#process_srcu
Message-ID: <20220317180129.GR4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220312155919.GD1189@xsang-OptiPlex-9020>
 <20220314203814.GZ4285@paulmck-ThinkPad-P17-Gen-1>
 <20220316165342.GA1931135@paulmck-ThinkPad-P17-Gen-1>
 <20220317071608.GB735@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317071608.GB735@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 03:16:08PM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Wed, Mar 16, 2022 at 09:53:42AM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 14, 2022 at 01:38:14PM -0700, Paul E. McKenney wrote:
> > > On Sat, Mar 12, 2022 at 11:59:19PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed the following commit (built with gcc-9):
> > > > 
> > > > commit: 7bf8d644f869260f63eaaedebabdd2054f59ecc4 ("fixup! EXP srcu: Check for too many zero-delay srcu_reschedule() calls")
> > > > https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.03.01a
> > > > 
> > > > in testcase: boot
> > > > 
> > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > > 
> > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > 
> > > > 
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > 
> > > > 
> > > > [ 27.088275][ T42] WARNING: CPU: 1 PID: 42 at kernel/rcu/srcutree.c:1555 process_srcu (kernel/rcu/srcutree.c:1555 (discriminator 3)) 
> > > > [   27.089252][   T42] Modules linked in: libata(+) serio_raw i2c_piix4 parport_pc(+) parport ip_tables
> > > > [   27.090253][   T42] CPU: 1 PID: 42 Comm: kworker/1:1 Not tainted 5.17.0-rc1-00191-g7bf8d644f869 #1
> > > > [   27.091212][   T42] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > > > [   27.092176][   T42] Workqueue: rcu_gp process_srcu
> > > > [ 27.092718][ T42] RIP: 0010:process_srcu (kernel/rcu/srcutree.c:1555 (discriminator 3)) 
> > > > [ 27.093653][ T42] Code: 6b f8 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 91 02 00 00 48 8b 43 f8 31 f6 48 83 f8 32 0f 86 02 fe ff ff <0f> 0b e9 fb fd ff ff 4c 8d b3 58 ff ff ff 48 b8 00 00 00 00 00 fc
> > > 
> > > I had a feeling that the simple fix wasn't going to cut it, so thank you
> > > for finding a scenario that proves that to be the case.  Fix in progress,
> > > to be folded into the original with attribution.
> > 
> > OK, the attribution isn't quite there yet, but the squished-together
> > commit is here:
> > 
> > ea0098f19115 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> > 
> > Does this version behave better for you?
> 
> we tested this commit, found the issue gone.
> please be noted the issue on 7bf8d644f8 is random and ~25% rate.
> so I queued to run 100 times for this new commit, which is finally clean
> according to tests.
> 
> =========================================================================================
> compiler/kconfig/rootfs/sleep/tbox_group/testcase:
>   gcc-9/x86_64-rhel-8.3-func/debian-10.4-x86_64-20200603.cgz/1/vm-snb/boot
> 
> commit:
>   feebd043ec6b ("Revert "srcu: Avoid expedited GPs and blocking readers from consuming CPU"")
>   7bf8d644f869 ("fixup! EXP srcu: Check for too many zero-delay srcu_reschedule() calls")
>   ea0098f19115 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> 
> feebd043ec6b9eab 7bf8d644f869260f63eaaedebab ea0098f191152c7fe3db5181a2e
> ---------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |
>            :16          25%           4:16           0%            :100   dmesg.RIP:process_srcu
>            :16          25%           4:16           0%            :100   dmesg.WARNING:at_kernel/rcu/srcutree.c:#process_srcu

Thank you for testing this!  Tested-by?

							Thanx, Paul
