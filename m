Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D1C4A6B3E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 06:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiBBFHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 00:07:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:29058 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234057AbiBBFHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 00:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643778450; x=1675314450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MICOQFSyvbysplRl7bQUGyuNX3gvOK6K990ruv6RAOs=;
  b=kxNOqlBBDWNXo1SSpd9/mJTcrGIAq2Eayu3qZ+jhKh2aHSIhWDujQSUC
   B2wrzXk+mS4MaPqLotCSKhMYtpbcl+v5l3UYGgsxQCIoYa8ZwV9ovaJ+M
   6QENZoMo13sZdAsBH3By5cfnDatbFRLx2cAFL54+X4cb3HzaePchbmCss
   vskeEu4ZYfPKKasrVTsO8qmAwJapOhNJfctO0Zfmc0jWOv58mNPEPa1qg
   NUeHSXuvKNJO3D+v2xy5kQqHDfOkL1iyUFoMvMquAIv8oSrC6BMRAdg6a
   yPPDgBDJKwMgX688lBXlqM+ErJ/xuoAnSDtn8saXW2qfX8BXze4mmHAA2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="228506027"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="228506027"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 21:07:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="523343802"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2022 21:07:27 -0800
Date:   Wed, 2 Feb 2022 13:07:27 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug for ZSTD kernel decompressing
Message-ID: <20220202050727.GA19004@shbuild999.sh.intel.com>
References: <20220128045330.GB87412@shbuild999.sh.intel.com>
 <682F137E-25D6-43F7-88FC-D8C7ECE4517B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682F137E-25D6-43F7-88FC-D8C7ECE4517B@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Mon, Jan 31, 2022 at 08:31:10PM +0000, Nick Terrell wrote:
> 
> 
> > On Jan 27, 2022, at 8:53 PM, Feng Tang <feng.tang@intel.com> wrote:
> > 
> > Hi All,
> > 
> > Recently 0Day reported a 32bit i386 kernel decompression failure for my
> > patch [1], which essentially increase the kernel data section's size
> > from 19MB to 53MB, with error message:
> > 
> > 	early console in setup code
> > 	early console in extract_kernel
> > 	input_data: 0x05077079
> > 	input_len: 0x00f8a633
> > 	output: 0x01000000
> > 	output_len: 0x045c4328
> > 	kernel_total_size: 0x05040000
> > 	needed_size: 0x05040000
> > 
> > 	Decompressing Linux... 
> > 
> > 	ZSTD-compressed data is corrupt
> > 
> > 	 -- System haltedBUG: kernel hang in boot stage
> > 
> > From debug, it is likely a problem of ZSTD decompression code, as when I
> > reverted my patch and  hacked to increase the size of kernel data
> > section by 32MB, the same error will happen.
> > 
> > Some other hints are:
> > * same i386 config with lz4 and xz algo can boot
> > * X86_64 + zstd also boots fine
> > 
> > This could be reproduced by qemu cmd:
> > 
> > qemu-system-i386 -machine pc -cpu host -enable-kvm -kernel bzImage -m 2048m -smp 4 -serial stdio  --append "earlyprintk=ttyS0,115200 console=ttyS0,115200"
> > 
> > i386 kernel config is attached, and the debug patch as below:
> > ---
> > diff --git a/init/main.c b/init/main.c
> > index 767ee2672176..873f40ddf96e 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -162,6 +162,10 @@ static size_t initargs_offs;
> > static char *execute_command;
> > static char *ramdisk_execute_command = "/init";
> > 
> > +#define DT_SIZE		8192000
> > +static unsigned long tbuf[DT_SIZE] = { 1, 2, 3, 4, };
> > +
> > /*
> >  * Used to generate warnings if static_key manipulation functions are used
> >  * before jump_label_init is called.
> > @@ -690,6 +694,11 @@ noinline void __ref rest_init(void)
> > 	struct task_struct *tsk;
> > 	int pid;
> > 
> > +	unsigned long i, j;
> > +	for (i = 0; i < DT_SIZE; i++)
> > +		j += tbuf[i];
> > +	printk("j = 0x%x\n", j);
> > +
> > 	rcu_scheduler_starting();
> > 	/*
> > 	 * We need to spawn init first so that it obtains pid 1, however
> > 
> > Please let me know if you need more info.
> > 
> > [1.] https://lore.kernel.org/lkml/1627456900-42743-1-git-send-email-feng.tang@intel.com/ 
> 
> I've been unable to reproduce this issue using the provided patch + config based on
> Linux v5.17-rc2.
> 
> What version of Linux are you testing on? Zstd was updated in v5.16, so if you're not
> testing on v5.16 or later, can you please re-test on v5.17-rc2?
 
The original report I got is against commit 8cd7c588decf 
"mm/vmscan: throttle reclaim until some writeback completes if congested"
which is post 5.15.

I just retested and the issue can _not_ be reproduced against 5.17-rc2.
Thanks for the check and fix, and sorry for not trying latest kernel.

- Feng
