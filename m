Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8107493FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356705AbiASSWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbiASSWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:22:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13581C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:22:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A784161687
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CD4C004E1;
        Wed, 19 Jan 2022 18:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642616572;
        bh=51gQtOW+O8tDEHkDFKwBjmriyMVvm72nFccDEtL619Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PU4IGxh/GHjO4VtwvawkkVJIp1+KOBwFQ16o6zcmJJJlu3tw13SNKKvXXtGU+FRsc
         UIMHcg48JDuv7P2PxaJv+2umEM3FLiZskPy3Dvq+IyH1qAgounjd4KDHJbWbY8JynB
         7CaV8hkOp64uEK56JQuOdtj7N1aLJg9RDVWxauoIZJIUa2ChEGOTs2+1BOnifmMFL7
         KgapTIbMCABSkxDh7bl2nk+ONoNLXcbS9OwfrjX1XJrfG7xEpuL04U+pg9UgzFlsD/
         3knQLtrakXYfruJwQa9/osPmmn2EghoG/ELnfxfsR2MVRMmDt1CC3L/7Ywl7pcV40b
         54UtAyx+r3Pww==
Date:   Wed, 19 Jan 2022 10:22:50 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <YXe7AnMmiWXk36NC@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
        <YXe7AnMmiWXk36NC@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 10:23:30 +0200 Borislav Petkov wrote:
> On Tue, Oct 26, 2021 at 04:16:21PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
> > commit: 7bb39313cd6239e7eb95198950a02b4ad2a08316 x86/mce: Make mce_timed_out() identify holdout CPUs
> > date:   10 months ago
> > config: x86_64-buildonly-randconfig-r006-20211022 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7bb39313cd6239e7eb95198950a02b4ad2a08316
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 7bb39313cd6239e7eb95198950a02b4ad2a08316
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> 
> if you have the technical capability to ignore all noinstr warnings
> coming from the mce code, please do so.
> 
> I have a patchset to address that but more important work preempts me
> constantly from cleaning it up and sending it out properly. ;-\

Any progress? Anything I can help with?

I was hoping that 5.17 would fix this but I just merged Linus's tree
with netdev today and the warnings are still there :(
