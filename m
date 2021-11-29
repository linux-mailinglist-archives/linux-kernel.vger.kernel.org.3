Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6027646160C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377473AbhK2NUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:20:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58660 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhK2NSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:18:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDBD861453
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF7DC004E1;
        Mon, 29 Nov 2021 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638191695;
        bh=ve4m3VQ8fonXJSCNHzCneGQA8SNJLTR4vEvXra8ml/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbxjY/DDufCVm4axAmNdwj0PovTL4cOqseXddsoBqPscPN5hiqG3d6CKsUs18/9J9
         FLY5dD8ObNlIdEzljiNGfNZxHGHefPuDSwoalHO+/HNAyhGEbAqT9I/ydXad/+Cdgf
         9WC6+EmM9qmRGaeBFxLD14k0lFFKhfYdyq3cM35M=
Date:   Mon, 29 Nov 2021 14:14:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:linux-4.19.y 565/981]
 arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33: error:
 initializer element is not constant
Message-ID: <YaTSTOOoCTJn1ZJc@kroah.com>
References: <202111271017.dLo8jJ8p-lkp@intel.com>
 <CAMo8BfL88Qc6o=WheT6+n4pOpXQbnw220UQa_GCQb98F=S9ffA@mail.gmail.com>
 <YaN+E5fuvU2VO+W5@kroah.com>
 <CAMo8BfKSaOUD5V5G+PBaLqcmcVnHw=JwrYP=hoLRoNj=oWDdLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfKSaOUD5V5G+PBaLqcmcVnHw=JwrYP=hoLRoNj=oWDdLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 05:00:55AM -0800, Max Filippov wrote:
> Hi Greg,
> 
> On Sun, Nov 28, 2021 at 5:03 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Nov 27, 2021 at 07:10:56AM -0800, Max Filippov wrote:
> > > This happens because the backported change
> > > 1c21a8df144f1edb3b6f5f24559825780c227a7d depends on the change
> > > d67ed2510d28 ("xtensa: use CONFIG_USE_OF instead of CONFIG_OF")
> > > which is not in that stable tree.
> > >
> > > Should I send the backported version of the d67ed2510d28 or should
> > > the change 1c21a8df144f1edb3b6f5f24559825780c227a7d be reverted
> > > from the stable? (IMO they are not the stable material).
> >
> > I have queued up d67ed2510d28 ("xtensa: use CONFIG_USE_OF instead of
> > CONFIG_OF") to hopefully resolve this.
> 
> Thank you. However the change that you've queued is missing one
> hunk of the original patch that makes the difference in this case.
> I guess it's missing due to conflict introduced by the change
> 6591685d5004 ("xtensa: move XCHAL_KIO_* definitions to kmem_layout.h")
> 
> I've posted another backported version of this patch that includes
> that missing part. Could you please apply it instead?

Now updated, thanks.

greg k-h
