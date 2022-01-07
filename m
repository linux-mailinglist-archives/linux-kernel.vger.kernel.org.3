Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C770F487F13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiAGWtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiAGWtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:49:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77430C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 14:49:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B46DBB82411
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 22:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A920C36AE5;
        Fri,  7 Jan 2022 22:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641595744;
        bh=ViSqgQgJuvP+htaIPnhi8An9uFQEuN9qNJ/GiLYWh+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1oCrg9LFE1Jvd6RAH9k2xELL+kLGarb8CZsayVgHdtMIvEHSd954rjT0/h/vgDkJ
         MpYyr7hl6H4CWPGTx3439RkplHvCY55qpaVJGndfucNbQvIn9Iymj+K7GLh5rKCoks
         d69kq4uXX0gwXguQeQwuZZi9TBwkdprAMFqRI+VRr2pZ7cDz36FN2y8wgYijT3hrBd
         rB6bCFVMEQD+XgWq4ccMp2s2ysLS/5o77YvCIFS6hR2MRwFL8gefSwCApG83MM8NYS
         dVCkXbrZKfnNSsUpWsFw414UvdLkMmk72imthqc/e5G+iz3NR6iPW9GkuY5dfulAMf
         Z6pGm4B+hGWhA==
Date:   Fri, 7 Jan 2022 14:49:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, ltp@lists.linux.it
Subject: Re: [LTP] [f2fs]  a1e09b03e6: ltp.ADSP024.fail
Message-ID: <YdjDXiXYjQMJnr/c@sol.localdomain>
References: <20211226132851.GC34518@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226132851.GC34518@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 09:28:52PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: a1e09b03e6f5c1d713c88259909137c0fd264ede ("f2fs: use iomap for direct I/O")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20211221
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: f2fs
> 	test: ltp-aiodio.part2
> 	ucode: 0x21
> 

This is caused by an f2fs bug where it exposes DIO-allocated blocks to users
before they have been initialized.  This test actually fails both before and
after my commit "f2fs: use iomap for direct I/O".  It is nondeterministic, which
is why it may have appeared to be a regression.

I'll start a separate discussion on linux-f2fs-devel about this, since this
thread has too many irrelevant mailing lists and this has been discussed before.

- Eric
