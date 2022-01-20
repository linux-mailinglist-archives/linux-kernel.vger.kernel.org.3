Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C2D495535
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377546AbiATUFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377529AbiATUFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:05:20 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2008CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:05:20 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i65so6554020pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wHjoIaDVZb3U/EHjsENWmQp9GXF9mNsSLLXq3Gksg2Q=;
        b=VeN5p/tiaTaLsJPPMbZoCiHAwnp+zZmc48JvKaG2+9Qhh817tNlFhiC3hQTeZCvBK0
         fmf5Vo1UQchPCq88/GrexsaTtE3oBZiXK7jZPY1ElLRIi42U1JFRhR1a7JZ6bN0xpEP5
         eeF76RHYQXoHG6kk/Z60lEYe4QOxC1+oa2cb4FAK0to44JrnLhaRkGzXfj+ktJ3mEQUF
         kkDodCcwVIPIMi3fo4wlYKbOgha5UHa7FLkqx/nNGFT+KPSNa4eQvKCPquUm7jOr/q/n
         JQR6YzvtBbc/kqQ1Tme/kJ+Mob1giIBpres/wUS/rCLkZ/Vh43cyEzGrYKG08sxfj6e+
         01CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHjoIaDVZb3U/EHjsENWmQp9GXF9mNsSLLXq3Gksg2Q=;
        b=08ZIzkaMOsHYgz69n9QeUjZUQrzhy0dz+mFBG/lCtQfUEcug6woAvN71I3IBW29wG4
         SKCLMJ1NfEFl5CsWy2FVHYH7hz/GMZyvFjqVtaoI4cx9Rqy694ozpa9DIHFUy02UnNqR
         oaToh5ERgt6OsxkBfjCTf67UoH1lk40VDsGTq9n2ptLt8yQjRJyy87syUZs0jy9leR+A
         tCypqnWi3n5SH2O7LNumLY2j9S01GcktJUG/GcPSp1jsP0msRE5g+GeDQWA4Hfd6pCTY
         6x/4yQ4YxkLlh8Ag8KyaOeePbkJuOavugJ0k1YowolsXomf0zfe0t26ToxgECzi63fLA
         /Xmg==
X-Gm-Message-State: AOAM531PFPyi5igGx8Y1gnig/UlQzlVULMzsJjpzhTPlKe2Cuefv30y6
        TEh98UETQ5fjj4+n32MgPHzqrg==
X-Google-Smtp-Source: ABdhPJzVjh145XPHiOEZ5dflryXS4RcgNqxRnLNGBPw4EpVZda65QlJOLPaFaq26UvQOQ8Nht6wPAg==
X-Received: by 2002:a65:5a8c:: with SMTP id c12mr341956pgt.54.1642709119472;
        Thu, 20 Jan 2022 12:05:19 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f7sm4634906pfv.30.2022.01.20.12.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:05:18 -0800 (PST)
Date:   Thu, 20 Jan 2022 13:05:16 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Miaoqian Lin <linmq006@gmail.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com
Subject: Re: [PATCH v3] remoteproc: Fix NULL vs IS_ERR() checking in
 rproc_create_trace_file
Message-ID: <20220120200516.GA1343808@p14s>
References: <20220105064201.3907-1-linmq006@gmail.com>
 <20220105131022.25247-1-linmq006@gmail.com>
 <20220117170600.GA1119324@p14s>
 <YeXuOwm3yJW2gnSE@builder.lan>
 <20220118165621.GA1207193@p14s>
 <YecSXpGRTCKClS8w@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YecSXpGRTCKClS8w@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 01:17:50PM -0600, Bjorn Andersson wrote:
> On Tue 18 Jan 10:56 CST 2022, Mathieu Poirier wrote:
> 
> > On Mon, Jan 17, 2022 at 04:31:23PM -0600, Bjorn Andersson wrote:
> > > On Mon 17 Jan 11:06 CST 2022, Mathieu Poirier wrote:
> > > 
> > > > On Wed, Jan 05, 2022 at 01:10:22PM +0000, Miaoqian Lin wrote:
> > > > > The debugfs_create_file() function doesn't return NULL.
> > > > > It returns error pointers. Fix check in rproc_create_trace_file
> > > > > and make it returns return error pointers.
> > > > 
> > > > s/"returns return"/return
> > > > 
> > > > > Fix check in rproc_handle_trace to propagate the error code.
> > > > > 
> > > > > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - return PTR_ERR(tfile) in rproc_create_trace_file
> > > > > - fix check in rproc_handle_trace()
> > > > > Changes in v3:
> > > > > - return tfile to fix incorrect return type in v2
> > > > > ---
> > > > >  drivers/remoteproc/remoteproc_core.c    | 6 ++++--
> > > > >  drivers/remoteproc/remoteproc_debugfs.c | 4 +---
> > > > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > > >
> > > > 
> > > > I will fix the above, add a proper "Fixes" tag and apply this patch to
> > > > rproc-next when v5.17-rc1 comes out next week.
> > > > 
> > > 
> > > We're actually not supposed to check debugfs_create_*() for errors.
> > 
> > I'm interested in knowing more about this - can you expand on the specifics or
> > perharps provide a link?
> > 
> 
> I'm not able to find anything going into the reasoning behind it, but
> you can find lots of examples where Greg says that we shouldn't do this:
> 
> $ git log --grep "no need to check return value of debugfs_create functions"
> 
> E.g.:
> https://lore.kernel.org/r/20200818133701.462958-1-gregkh@linuxfoundation.org

Greg's changelog leaves little doubt, thanks for pointing that out.

> 
> > > 
> > > > Thanks,
> > > > Mathieu
> > > > 
> > > > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > > > index 775df165eb45..5608408f8eac 100644
> > > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > > @@ -656,6 +656,7 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
> > > > >  	struct rproc_debug_trace *trace;
> > > > >  	struct device *dev = &rproc->dev;
> > > > >  	char name[15];
> > > > > +	int ret;
> > > > >  
> > > > >  	if (sizeof(*rsc) > avail) {
> > > > >  		dev_err(dev, "trace rsc is truncated\n");
> > > > > @@ -684,9 +685,10 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
> > > > >  
> > > > >  	/* create the debugfs entry */
> > > > >  	trace->tfile = rproc_create_trace_file(name, rproc, trace);
> > > > > -	if (!trace->tfile) {
> > > > > +	if (IS_ERR(trace->tfile)) {
> > > > > +		ret = PTR_ERR(trace->tfile);
> > > > >  		kfree(trace);
> > > > > -		return -EINVAL;
> > > > > +		return ret;
> > > 
> > > 
> > > And actually catching and propagating the error here means that we will
> > > start failing rproc_boot() for firmware including a RSC_TRACE when
> > > debugfs is disabled...
> > > 
> > > So if we really want to save the heap space we should at least cleanly
> > > ignore the error, by cleaning up and returning 0 here.
> > 
> > Humm... To me the _intent_ of the upstream code has always been to propagate
> > errors reported by rproc_create_trace_file().  The fact that is hasn't happen
> > because of inappropriate error handling is something that should be corrected.  
> > 
> 
> I share that view, in general. I suspect that the idea with debugfs is
> that it's for debugging purposes and you don't want your remoteproc to
> stop working just because there might be an issue debugging it.
> 
> > That being said disabling debugfs is a common practice for production systems
> > and I agree that handling such a condition by returning 0 when
> > rproc_create_trace_file() returns -ENODEV is the right thing to do.   
> > 
> 
> Right, but even with debugfs enabled, do you want to prevent your
> remoteproc from booting just because the debugfs, for some reason,
> wasn't able to add the trace file?

Greg's comments brings a different angle to the conversation - I agree there is
no need to dwell on debugfs error conditions.

> 
> For me the question is if we should clean up the "trace" object or not,
> as this only relates to the debugfs file. Ignoring the error would imply
> that we just keep this memory allocated - which I'm fine with for the
> sake of avoiding the error handling.

I would also be fine with not cleaning up the trace object, it will be free'd
as part of the resource cleanup process anyway.

> 
> > Thanks,
> > Mathieu
> > 
> > > 
> > > > >  	}
> > > > >  
> > > > >  	list_add_tail(&trace->node, &rproc->traces);
> > > > > diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> > > > > index b5a1e3b697d9..2ae59a365b7e 100644
> > > > > --- a/drivers/remoteproc/remoteproc_debugfs.c
> > > > > +++ b/drivers/remoteproc/remoteproc_debugfs.c
> > > > > @@ -390,10 +390,8 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
> > > > >  
> > > > >  	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
> > > > >  				    &trace_rproc_ops);
> > > > > -	if (!tfile) {
> > > > > +	if (IS_ERR(tfile))
> > > > >  		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
> > > 
> > > And I therefor think this function would be better reduced to:
> > > 
> > > 	return debugfs_create_file(...);
> > > 
> 
> Taking another look at the implementation of debugfs_create_file() this
> dev_err() should be removed, because there will already be a more useful
> error printed by debugfs_create_file().
> 
> Regards,
> Bjorn
> 
> > > Regards,
> > > Bjorn
> > > 
> > > > > -		return NULL;
> > > > > -	}
> > > > >  
> > > > >  	return tfile;
> > > > >  }
> > > > > -- 
> > > > > 2.17.1
> > > > > 
