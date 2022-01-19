Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7854749434E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357631AbiASW5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357621AbiASW5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:57:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:57:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC9E614AB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 22:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA879C004E1;
        Wed, 19 Jan 2022 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642633049;
        bh=WXbJm60Y8i0E7yI6QfuZUdp9C4e7sxUkKhBYaq/RnAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OqmhbW4OzWLfMCgxRHCC+cagdVBZ+leePTpJIApJjPxZw6oh3s7yZZNpgShCz5qA4
         JeKs38pd1pC08jMpDF21BQvKC+lrWDrkIvU1z1F1QndGGOZS0h377N+FiwVENorj8R
         LTP3Az39fmXDJ7Az1GF6JC97jYBR6+uPY9bvG7QuSSxof6Tt+2D+n/6ZsDS3bdUjoV
         ehel2osn9h0TiUQe1sUq5+aa/4fz/7Q+3X2nY9bGRIb+a3gHkUSPv33meEqz5b5WkK
         OHFtQU90N2bgg0KMAPTt1c8AuOgKiaal8ax3+WTieJjW6K44Tbykory9kEqRIxSesp
         O/FdVh826XZKQ==
Date:   Wed, 19 Jan 2022 14:57:27 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <20220119145727.2034a180@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <Yeh/oEYGyg2+XYSJ@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
        <YXe7AnMmiWXk36NC@zn.tnic>
        <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YehZsGAqgd3tJyDV@zn.tnic>
        <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <Yeh013gIveIKdFMP@zn.tnic>
        <20220119123714.22b54d4c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <Yeh/oEYGyg2+XYSJ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 22:16:16 +0100 Borislav Petkov wrote:
> On Wed, Jan 19, 2022 at 12:37:14PM -0800, Jakub Kicinski wrote:
> > gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3)  
> 
> I have
> 
> $ gcc-8 --version
> gcc-8 (SUSE Linux) 8.2.1 20180831 [gcc-8-branch revision 264010]
> 
> but I can't trigger anything with it either.
> 
> So I had a report about a randconfig from the 0day robot guys which
> doesn't look like allmodconfig but which triggered some of the issues
> you're seeing and I have fixes for that one which we wanna queue after
> -rc1.
> 
> You could try them to see if they fix your warnings too. First take the
> 2 here:
> 
> https://lore.kernel.org/r/20220113155357.4706-1-bp@alien8.de
> 
> and then this one ontop:
> 
> https://lore.kernel.org/r/YeWsopFagTZ4W8WA@zn.tnic
> 
> Thx.

That does fix one of the warnings, it seems.

Before:

vmlinux.o: warning: objtool: mce_start()+0x5e: call to __kasan_check_write() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.isra.1() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_read_aux()+0x8a: call to mca_msr_reg() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0x196: call to mce_no_way_out() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_severity_amd.constprop.1()+0xd1: call to mce_severity_amd_smca.isra.0() leaves .noinstr.text section

After:

vmlinux.o: warning: objtool: mce_start()+0x5e: call to __kasan_check_write() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.isra.1() leaves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0xa32: call to mce_clear_state() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_severity_amd.constprop.1()+0xd1: call to mce_severity_amd_smca.isra.0() leaves .noinstr.text section


At a glance mce_read_aux() is gone and do_machine_check() complains
about a different call.
