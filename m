Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D495485348
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiAENM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:12:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35956 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiAENMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:12:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 033B0210FA;
        Wed,  5 Jan 2022 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641388344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgqNXcHhamZNGVKg1hJQ64mpwXkw4AeSirQXhLHj9Z8=;
        b=fdvqs690/hY20ATTHnfpXqIoDL9Mlbf8bNWBzWsBPMiAataE05lM6xsK//i/L6PrQpPId/
        DekXff16q40k8NDpxD4opwY6YfZGJKumSInia3FoDur04PmnZNlQ+4A0k5SxURVp7OQGRk
        +D9AWLBmPfRLsEkRS2zpefDhBojn58U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641388344;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgqNXcHhamZNGVKg1hJQ64mpwXkw4AeSirQXhLHj9Z8=;
        b=0FpgwTUQZF8Xx4tjSmBlFDGe047LE1gy15fEPKD3RVhrQh4gvOXf1xJuGc80wU/00sYlVF
        331vXlNNUTP4ZFDQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 57092A3B87;
        Wed,  5 Jan 2022 13:12:23 +0000 (UTC)
Date:   Wed, 5 Jan 2022 14:12:22 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20220105131222.GG117207@kunlun.suse.cz>
References: <20220104170505.10248-1-msuchanek@suse.de>
 <YdWGQ+Kxeo9Q7Kli@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdWGQ+Kxeo9Q7Kli@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 05, 2022 at 12:51:31PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 04, 2022 at 06:05:05PM +0100, Michal Suchanek wrote:
> > 
> > When the kernel is locked down the kernel allows reading only debugfs
> > files with mode 444. Mode 400 is also valid but is not allowed.
> > 
> > Make the 444 into a mask.
> > 
> > Fixes: 5496197f9b08 ("debugfs: Restrict debugfs when the kernel is locked down")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  fs/debugfs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Why has it taken so long for anyone to notice this (2 years!)?
> 
> Is that because no one uses the lockdown mode and tries to read debugfs
> files?

It's because people use those LTSS kernels that don't have this change.

> > 
> > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > index 7d162b0efbf0..950c63fa4d0b 100644
> > --- a/fs/debugfs/file.c
> > +++ b/fs/debugfs/file.c
> > @@ -147,7 +147,7 @@ static int debugfs_locked_down(struct inode *inode,
> >  			       struct file *filp,
> >  			       const struct file_operations *real_fops)
> >  {
> > -	if ((inode->i_mode & 07777) == 0444 &&
> > +	if ((inode->i_mode & 07777 & ~0444) == 0 &&
> 
> You are now allowing more than just 0400, is that intentional?

The intent is to allow files that have permissions that are subset of
0444. The only one that makes sense and people complain about is 0400
but if you had 0440 or 0004 it would be permitted as well.

> I never understood why files that were 0666 were not able to be read
> here as well, why not allow that as well?  What was magic about 0444
> files?

I don't understand that either but I am not really trying to challenge
that part.

Thanks

Michal
