Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF783494092
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbiASTP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:15:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45418 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiASTPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:15:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33272616E2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 19:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE81C004E1;
        Wed, 19 Jan 2022 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642619724;
        bh=GLg5tVHffUGosysqNpCWCNh8xPePUm1+lSi2VFPI/hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pZvWBLhgQxMuoEePhKBw+hzFZEKVJxkXtTExdT8mjFHdzFHZCzJObHzSO+7VOJmMd
         Jb/uKEEUAuKliRXNKw/KsI872UiTyO7yFkGAwu/SJJOpWmoHMs4jLdVbodUzE1QX14
         N4PDvG+P3D1V25EYglNv8/wi2EThfzC8iPbkM9WAS9aYqzbwp1xD7NjME4vO+E8N8K
         6Fbfzla3HQBxx4zoz1xG63YM0XIxreZgz4GeJ/vdbnN1WcGRjEFRXztqDoaFaKii2q
         l6yShpQr9sprt6CZXswkiVPxQiYEsja5CjrBZkyz05cAMV+IGItxuCSKK2xl2qtCGn
         RTwcB5awGfYOA==
Date:   Wed, 19 Jan 2022 11:15:23 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
        <YXe7AnMmiWXk36NC@zn.tnic>
        <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YehZsGAqgd3tJyDV@zn.tnic>
        <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 10:40:17 -0800 Jakub Kicinski wrote:
> On Wed, 19 Jan 2022 19:34:24 +0100 Borislav Petkov wrote:
> > Hmm, weird. The set which is supposed to address this got merged last
> > week:
> > 
> > 7e740ae63504 ("Merge tag 'ras_core_for_v5.17_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> > 
> > How exactly can I reproduce what you're seeing?
> > 
> > I need to merge which commit into which branch and then use which
> > .config to reproduce?  
> 
> allmodconfig 
> 
> Merge: 1d1df41c5a33 ff9fc0a31d85
> 
> 1d1df41c5a33 is linux/master 
> ff9fc0a31d85 is
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master
> 
> I see:
> 
> vmlinux.o: warning: objtool: mce_start()+0x5e: call to __kasan_check_write() leaves .noinstr.text section
> vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.isra.1() leaves .noinstr.text section
> vmlinux.o: warning: objtool: mce_read_aux()+0x8a: call to mca_msr_reg() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_machine_check()+0x196: call to mce_no_way_out() leaves .noinstr.text section
> vmlinux.o: warning: objtool: mce_severity_amd.constprop.1()+0xd1: call to mce_severity_amd_smca.isra.0() leaves .noinstr.text section
> 
> Let me try again with a clean check out.

Indeed, still present with a fresh tree.
