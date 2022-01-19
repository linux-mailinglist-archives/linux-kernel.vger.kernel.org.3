Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE37494015
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355480AbiASSkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:40:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49478 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242765AbiASSkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68FA261670
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985DEC004E1;
        Wed, 19 Jan 2022 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642617618;
        bh=16rUYPVIxG/FpfX2CQP2pr3OXFXQnCb7qk/r/7eQXvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p0hIiW6G8T7OR6f/hlueGY34fzIYHFoBoJfxXRNa+jFFWwpvcJOaDDpsIXLVsZ6U4
         gVL//sRhVuY3S63xIQxXJF6zHdgZKxr5Ofzo76AIFyF31/xapU0RFrZ/ex6gm81A1n
         yK4mGA2MeBdAuTFEianfLtprGMSixTUazWLXxeLj+cr3k8yFgYr3fdgNiwAk+Q+2Ee
         gtM1wCT7S4sU6ZUjGHx8ESmzbkyR1GMlZW4C59pbnVzaNQ9rwDsWNeOnv0kG5QP81t
         JZPKSQH2KGJfxXCZF7nrBy3thOXBZ+ja9dARUEBPuqZ8+jm30fi6UIY47bcmpJd3tz
         0k69JntrlI9+A==
Date:   Wed, 19 Jan 2022 10:40:17 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <YehZsGAqgd3tJyDV@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
        <YXe7AnMmiWXk36NC@zn.tnic>
        <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YehZsGAqgd3tJyDV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 19:34:24 +0100 Borislav Petkov wrote:
> On Wed, Jan 19, 2022 at 10:22:50AM -0800, Jakub Kicinski wrote:
> > I was hoping that 5.17 would fix this but I just merged Linus's tree
> > with netdev today and the warnings are still there :(  
> 
> Hmm, weird. The set which is supposed to address this got merged last
> week:
> 
> 7e740ae63504 ("Merge tag 'ras_core_for_v5.17_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> 
> How exactly can I reproduce what you're seeing?
> 
> I need to merge which commit into which branch and then use which
> .config to reproduce?

allmodconfig 

Merge: 1d1df41c5a33 ff9fc0a31d85

1d1df41c5a33 is linux/master 
ff9fc0a31d85 is
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master

I see:

vmlinux.o: warning: objtool: mce_start()+0x5e: call to __kasan_check_write() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.isra.1() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_read_aux()+0x8a: call to mca_msr_reg() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0x196: call to mce_no_way_out() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_severity_amd.constprop.1()+0xd1: call to mce_severity_amd_smca.isra.0() leaves .noinstr.text section

Let me try again with a clean check out.
