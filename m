Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3E492E49
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348403AbiARTRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237859AbiARTRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:17:54 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:17:53 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id m8-20020a9d4c88000000b00592bae7944bso22482170otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RndWnG63hC9GiAGmx76qqI29dqe7Vqx89DCPaLYncN8=;
        b=z7GFutigYH1M8I3nQKuB55wkKm3Rbbdg4zwxqyflJeLMT8cX29rTwC1AXsItiex/VR
         hl6f/C+gj5Co9+4ul+Ezm5F+qMP/U/qG93xjISMxV7iCOgQc38eOfzL3JvxWs7g7bd5K
         FGFmw2A1cRnCNNclU7zzWCl4NzOk8s4Pt020VC+D5cJUW5DFFQfxomPCKFSt2ottEF4k
         7kV6gjE2kXQIkQgWAWgJ7qnCLQvPY/AZj60F12Qj91Z7lE2xEdAJS8gD6eUTXzi1slYW
         wMnweyJya+/l/pf6o8HSiNYE7ZQLzM7Q9pXAp+MA2oZqNNo9uL17YnkiADmZVzWoxsJy
         f1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RndWnG63hC9GiAGmx76qqI29dqe7Vqx89DCPaLYncN8=;
        b=Jevd3stz5dTOK1eFCK3JVdLFwLf0zUa172MBQHGNra9rnZ0MK+fLuWpt8qB3drBPtI
         lTo9U2tjNp/4dfKI58tiwR3/oGkmiG4s9Q4LxLShxcnlJXdbkl/pPRt0zVd7xiUeOBE/
         6djey9zz7iX9J19YRIat6+hB2Td7nWg0ycYruIZOVS8SbkeQ6XDxkgG1ctYCqMJ47oGx
         2zFBNPKobRgIXHgCE5dDMZ6hIGOR6vuVIGLLzUAmMCe+iuLzB+Mah29m9PGegI3HLYoL
         EP7Jd+rRfWKji6tdo42aGNgP/R9YJ/QDVgnwDzmALkrPiQHCmAj5B/+u+iKxrBHIKwB0
         UaEg==
X-Gm-Message-State: AOAM532L4BmtkTdkx+EKNJxV6KjiT797mosCbTMcQB6bsbfFi2NELucL
        mBudQu5eBW1q7bBM1Q3Xm4nQOA==
X-Google-Smtp-Source: ABdhPJwLymRH6H8v4hYJtWO8ifHWw31laYW6E+NPDZZWkYBiVY3R3XVCm2SWE0Opdwl4IJNljRj2dQ==
X-Received: by 2002:a9d:1b0f:: with SMTP id l15mr21210879otl.38.1642533472867;
        Tue, 18 Jan 2022 11:17:52 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 17sm7809183oij.21.2022.01.18.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:17:52 -0800 (PST)
Date:   Tue, 18 Jan 2022 13:17:50 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Miaoqian Lin <linmq006@gmail.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com
Subject: Re: [PATCH v3] remoteproc: Fix NULL vs IS_ERR() checking in
 rproc_create_trace_file
Message-ID: <YecSXpGRTCKClS8w@builder.lan>
References: <20220105064201.3907-1-linmq006@gmail.com>
 <20220105131022.25247-1-linmq006@gmail.com>
 <20220117170600.GA1119324@p14s>
 <YeXuOwm3yJW2gnSE@builder.lan>
 <20220118165621.GA1207193@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118165621.GA1207193@p14s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18 Jan 10:56 CST 2022, Mathieu Poirier wrote:

> On Mon, Jan 17, 2022 at 04:31:23PM -0600, Bjorn Andersson wrote:
> > On Mon 17 Jan 11:06 CST 2022, Mathieu Poirier wrote:
> > 
> > > On Wed, Jan 05, 2022 at 01:10:22PM +0000, Miaoqian Lin wrote:
> > > > The debugfs_create_file() function doesn't return NULL.
> > > > It returns error pointers. Fix check in rproc_create_trace_file
> > > > and make it returns return error pointers.
> > > 
> > > s/"returns return"/return
> > > 
> > > > Fix check in rproc_handle_trace to propagate the error code.
> > > > 
> > > > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > - return PTR_ERR(tfile) in rproc_create_trace_file
> > > > - fix check in rproc_handle_trace()
> > > > Changes in v3:
> > > > - return tfile to fix incorrect return type in v2
> > > > ---
> > > >  drivers/remoteproc/remoteproc_core.c    | 6 ++++--
> > > >  drivers/remoteproc/remoteproc_debugfs.c | 4 +---
> > > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > 
> > > I will fix the above, add a proper "Fixes" tag and apply this patch to
> > > rproc-next when v5.17-rc1 comes out next week.
> > > 
> > 
> > We're actually not supposed to check debugfs_create_*() for errors.
> 
> I'm interested in knowing more about this - can you expand on the specifics or
> perharps provide a link?
> 

I'm not able to find anything going into the reasoning behind it, but
you can find lots of examples where Greg says that we shouldn't do this:

$ git log --grep "no need to check return value of debugfs_create functions"

E.g.:
https://lore.kernel.org/r/20200818133701.462958-1-gregkh@linuxfoundation.org

> > 
> > > Thanks,
> > > Mathieu
> > > 
> > > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > > index 775df165eb45..5608408f8eac 100644
> > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > @@ -656,6 +656,7 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
> > > >  	struct rproc_debug_trace *trace;
> > > >  	struct device *dev = &rproc->dev;
> > > >  	char name[15];
> > > > +	int ret;
> > > >  
> > > >  	if (sizeof(*rsc) > avail) {
> > > >  		dev_err(dev, "trace rsc is truncated\n");
> > > > @@ -684,9 +685,10 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
> > > >  
> > > >  	/* create the debugfs entry */
> > > >  	trace->tfile = rproc_create_trace_file(name, rproc, trace);
> > > > -	if (!trace->tfile) {
> > > > +	if (IS_ERR(trace->tfile)) {
> > > > +		ret = PTR_ERR(trace->tfile);
> > > >  		kfree(trace);
> > > > -		return -EINVAL;
> > > > +		return ret;
> > 
> > 
> > And actually catching and propagating the error here means that we will
> > start failing rproc_boot() for firmware including a RSC_TRACE when
> > debugfs is disabled...
> > 
> > So if we really want to save the heap space we should at least cleanly
> > ignore the error, by cleaning up and returning 0 here.
> 
> Humm... To me the _intent_ of the upstream code has always been to propagate
> errors reported by rproc_create_trace_file().  The fact that is hasn't happen
> because of inappropriate error handling is something that should be corrected.  
> 

I share that view, in general. I suspect that the idea with debugfs is
that it's for debugging purposes and you don't want your remoteproc to
stop working just because there might be an issue debugging it.

> That being said disabling debugfs is a common practice for production systems
> and I agree that handling such a condition by returning 0 when
> rproc_create_trace_file() returns -ENODEV is the right thing to do.   
> 

Right, but even with debugfs enabled, do you want to prevent your
remoteproc from booting just because the debugfs, for some reason,
wasn't able to add the trace file?

For me the question is if we should clean up the "trace" object or not,
as this only relates to the debugfs file. Ignoring the error would imply
that we just keep this memory allocated - which I'm fine with for the
sake of avoiding the error handling.

> Thanks,
> Mathieu
> 
> > 
> > > >  	}
> > > >  
> > > >  	list_add_tail(&trace->node, &rproc->traces);
> > > > diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> > > > index b5a1e3b697d9..2ae59a365b7e 100644
> > > > --- a/drivers/remoteproc/remoteproc_debugfs.c
> > > > +++ b/drivers/remoteproc/remoteproc_debugfs.c
> > > > @@ -390,10 +390,8 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
> > > >  
> > > >  	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
> > > >  				    &trace_rproc_ops);
> > > > -	if (!tfile) {
> > > > +	if (IS_ERR(tfile))
> > > >  		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
> > 
> > And I therefor think this function would be better reduced to:
> > 
> > 	return debugfs_create_file(...);
> > 

Taking another look at the implementation of debugfs_create_file() this
dev_err() should be removed, because there will already be a more useful
error printed by debugfs_create_file().

Regards,
Bjorn

> > Regards,
> > Bjorn
> > 
> > > > -		return NULL;
> > > > -	}
> > > >  
> > > >  	return tfile;
> > > >  }
> > > > -- 
> > > > 2.17.1
> > > > 
