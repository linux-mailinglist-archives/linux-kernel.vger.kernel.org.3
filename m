Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7448664C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbiAFOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:48:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57006 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiAFOsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:48:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B23DFB821F9;
        Thu,  6 Jan 2022 14:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DDBC36AE3;
        Thu,  6 Jan 2022 14:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641480513;
        bh=nWE1NvVdvw3F50Dw3lCt/graz38zrRc1KYnLhW89Lc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0DcCygoOq4XqozKgMCOKfKYk8oKfsJ+D9FIsvNW9I5yFzJ8lEG6dxXyre+LdVyP0
         W/Rg5HThU6tdfE2gSV5OvSOYZ0glDWqXfZu0cCP7ZiFv5rFBYg1lEYvjlacV0jakae
         etmb0yCwrs5RsLPY0WTPrxLOq5p9OIwi+DT9C8QI=
Date:   Thu, 6 Jan 2022 15:48:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] debugfs: lockdown: Allow reading debugfs files that are
 not world readable
Message-ID: <YdcBPmzaoibUEg4K@kroah.com>
References: <20220104170505.10248-1-msuchanek@suse.de>
 <YdWGQ+Kxeo9Q7Kli@kroah.com>
 <20220105131222.GG117207@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105131222.GG117207@kunlun.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 02:12:22PM +0100, Michal Suchánek wrote:
> Hello,
> 
> On Wed, Jan 05, 2022 at 12:51:31PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 04, 2022 at 06:05:05PM +0100, Michal Suchanek wrote:
> > > 
> > > When the kernel is locked down the kernel allows reading only debugfs
> > > files with mode 444. Mode 400 is also valid but is not allowed.
> > > 
> > > Make the 444 into a mask.
> > > 
> > > Fixes: 5496197f9b08 ("debugfs: Restrict debugfs when the kernel is locked down")
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  fs/debugfs/file.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Why has it taken so long for anyone to notice this (2 years!)?
> > 
> > Is that because no one uses the lockdown mode and tries to read debugfs
> > files?
> 
> It's because people use those LTSS kernels that don't have this change.
> 
> > > 
> > > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > > index 7d162b0efbf0..950c63fa4d0b 100644
> > > --- a/fs/debugfs/file.c
> > > +++ b/fs/debugfs/file.c
> > > @@ -147,7 +147,7 @@ static int debugfs_locked_down(struct inode *inode,
> > >  			       struct file *filp,
> > >  			       const struct file_operations *real_fops)
> > >  {
> > > -	if ((inode->i_mode & 07777) == 0444 &&
> > > +	if ((inode->i_mode & 07777 & ~0444) == 0 &&
> > 
> > You are now allowing more than just 0400, is that intentional?
> 
> The intent is to allow files that have permissions that are subset of
> 0444. The only one that makes sense and people complain about is 0400
> but if you had 0440 or 0004 it would be permitted as well.
> 
> > I never understood why files that were 0666 were not able to be read
> > here as well, why not allow that as well?  What was magic about 0444
> > files?
> 
> I don't understand that either but I am not really trying to challenge
> that part.

Fair enough.  I don't care about the locked-down mode stuff, so I'll go
queue this up now, thanks!

greg k-h
