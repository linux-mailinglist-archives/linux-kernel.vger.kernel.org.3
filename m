Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C2F492BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiARQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiARQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:56:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EAFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 08:56:24 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 133so10306419pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V/ljcXc947htbm7e8nRcOqipXDJ44mgk+bzTSDu9q+g=;
        b=SFECuiKAFxeX6yuZLWXqeAYfo4NB4D4NcL4UcGKndwoL3mlyhK1MnGck/U7UubIt1h
         gVJoE515zXRZzHt6dlDFHaWTpOBwQBHjTXHSGM3FsXcDVZ2RHCGda8OGpqI8P7i54rHj
         sh9EC12pQ9P6fmdSdCRgcGufBg3PjtgL528yXJYNY5PouUzLFYhLM/A000WEi+/q3M8i
         zHkVPQ0biFbq8zjFzewA3NkuoqI4Hk4uuurEloptIAsLyducOn+k1n2en5ghX8987CJN
         TU3wdB6piBBaWYeElJdIWYWfFcBQB+x6Axdgc2vNbfxTX/djPEDHrJah+jWTWrHdJ2Ry
         fy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V/ljcXc947htbm7e8nRcOqipXDJ44mgk+bzTSDu9q+g=;
        b=4GbvmnM7+uMqAIoZ6djVHqXh2H1sNzdsSL8RWLj6Uye1Meh5Y6SpWpsODetfTM+yUx
         36ZMol2H9I4OLadRV5rvJoUQafjpTd+sdT6piO9P+oTwXNynVRBuY37ky71Rdpx5kJVr
         9qXgX/HTw8MoRyZVODdB4d5IvItT/DSeWUWo8pvxx4WIJtSxAVY8cRBj1u/RRfCBdIU2
         BpngTwtU3C9LLvIvLNCSWsSMCZjYIvxb3qOGLHCalT08upPRn5Piq5kFUlReCP/FpEFY
         OtZfZ0fwOqhoZ0QjOQVtmA89WxTcpn15wat+yyUJ427Tp3BBRMWIEbR4bsYR/Bp/QOCP
         7sKQ==
X-Gm-Message-State: AOAM533cwzBTOYIio4zNv5m4ZmifW0ptAR+S8uEE5+AwoteGM1dSDHEq
        cWuWF3slwIDQjTuytz6bcfpJHg==
X-Google-Smtp-Source: ABdhPJztzxOIa8UA3CT7I4R7P1CFkUowZiS5Yadl7bu23OnEPV6p3/ervRCs72BMiZUeWfUaD8ogvg==
X-Received: by 2002:a63:8c0f:: with SMTP id m15mr23860440pgd.598.1642524984344;
        Tue, 18 Jan 2022 08:56:24 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w10sm3155270pjl.23.2022.01.18.08.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 08:56:23 -0800 (PST)
Date:   Tue, 18 Jan 2022 09:56:21 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Miaoqian Lin <linmq006@gmail.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com
Subject: Re: [PATCH v3] remoteproc: Fix NULL vs IS_ERR() checking in
 rproc_create_trace_file
Message-ID: <20220118165621.GA1207193@p14s>
References: <20220105064201.3907-1-linmq006@gmail.com>
 <20220105131022.25247-1-linmq006@gmail.com>
 <20220117170600.GA1119324@p14s>
 <YeXuOwm3yJW2gnSE@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeXuOwm3yJW2gnSE@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 04:31:23PM -0600, Bjorn Andersson wrote:
> On Mon 17 Jan 11:06 CST 2022, Mathieu Poirier wrote:
> 
> > On Wed, Jan 05, 2022 at 01:10:22PM +0000, Miaoqian Lin wrote:
> > > The debugfs_create_file() function doesn't return NULL.
> > > It returns error pointers. Fix check in rproc_create_trace_file
> > > and make it returns return error pointers.
> > 
> > s/"returns return"/return
> > 
> > > Fix check in rproc_handle_trace to propagate the error code.
> > > 
> > > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > > ---
> > > Changes in v2:
> > > - return PTR_ERR(tfile) in rproc_create_trace_file
> > > - fix check in rproc_handle_trace()
> > > Changes in v3:
> > > - return tfile to fix incorrect return type in v2
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c    | 6 ++++--
> > >  drivers/remoteproc/remoteproc_debugfs.c | 4 +---
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > 
> > I will fix the above, add a proper "Fixes" tag and apply this patch to
> > rproc-next when v5.17-rc1 comes out next week.
> > 
> 
> We're actually not supposed to check debugfs_create_*() for errors.

I'm interested in knowing more about this - can you expand on the specifics or
perharps provide a link?

> 
> > Thanks,
> > Mathieu
> > 
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index 775df165eb45..5608408f8eac 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -656,6 +656,7 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
> > >  	struct rproc_debug_trace *trace;
> > >  	struct device *dev = &rproc->dev;
> > >  	char name[15];
> > > +	int ret;
> > >  
> > >  	if (sizeof(*rsc) > avail) {
> > >  		dev_err(dev, "trace rsc is truncated\n");
> > > @@ -684,9 +685,10 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
> > >  
> > >  	/* create the debugfs entry */
> > >  	trace->tfile = rproc_create_trace_file(name, rproc, trace);
> > > -	if (!trace->tfile) {
> > > +	if (IS_ERR(trace->tfile)) {
> > > +		ret = PTR_ERR(trace->tfile);
> > >  		kfree(trace);
> > > -		return -EINVAL;
> > > +		return ret;
> 
> 
> And actually catching and propagating the error here means that we will
> start failing rproc_boot() for firmware including a RSC_TRACE when
> debugfs is disabled...
> 
> So if we really want to save the heap space we should at least cleanly
> ignore the error, by cleaning up and returning 0 here.

Humm... To me the _intent_ of the upstream code has always been to propagate
errors reported by rproc_create_trace_file().  The fact that is hasn't happen
because of inappropriate error handling is something that should be corrected.  

That being said disabling debugfs is a common practice for production systems
and I agree that handling such a condition by returning 0 when
rproc_create_trace_file() returns -ENODEV is the right thing to do.   

Thanks,
Mathieu

> 
> > >  	}
> > >  
> > >  	list_add_tail(&trace->node, &rproc->traces);
> > > diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> > > index b5a1e3b697d9..2ae59a365b7e 100644
> > > --- a/drivers/remoteproc/remoteproc_debugfs.c
> > > +++ b/drivers/remoteproc/remoteproc_debugfs.c
> > > @@ -390,10 +390,8 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
> > >  
> > >  	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
> > >  				    &trace_rproc_ops);
> > > -	if (!tfile) {
> > > +	if (IS_ERR(tfile))
> > >  		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
> 
> And I therefor think this function would be better reduced to:
> 
> 	return debugfs_create_file(...);
> 
> Regards,
> Bjorn
> 
> > > -		return NULL;
> > > -	}
> > >  
> > >  	return tfile;
> > >  }
> > > -- 
> > > 2.17.1
> > > 
