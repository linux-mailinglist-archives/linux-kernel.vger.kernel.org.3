Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59454911BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbiAQWbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiAQWb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:31:29 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC72FC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:31:29 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bf5so3503429oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ezz9PAehs6LNLlaQQh3cmzTyTdtnTOJxTBDceBsK9SA=;
        b=rU4jzRLkTRlXpiSl4hnSTZ/FQf1KZaaBPdaGwuSp4mE+A+c8YE0vBTIeQM/WxM9jw3
         u5IAk7tCjvXGrvOgJUgziLBnt9a6c/9Oc0VzKeioBUVQR7iZzXhTSD9N2eG0WNHohkUQ
         V8CkGnD80lJrTOTXsg9mHzSj3Gy1AZSYmVZqN7RkEcn9NiSCp0CeCnjjIBBh6zebcF2H
         rjIs5Ue0kkz56f/xEtbPT4fbycOPArIJo6BdOLtOOFnKyorRANYPlu0T7AhYt6mSnEX2
         h26iRZMkYZDCFopJYh6ZVALEjahUCSH0opjyAhQarEzbL6zYPPfadPihja6cUfu2fwv/
         6gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ezz9PAehs6LNLlaQQh3cmzTyTdtnTOJxTBDceBsK9SA=;
        b=zN7G9+GoyBVTwC1tKs5JoAW7Hloh8A1klHuFNqLpUI+0TsyZcPx0Ye3kJ/y3X7YL2L
         fCDm6OqNmUaTwpY93F2CtUTSjZQ10b6kGuiSRmmnE93XROLafKfim7lUraVQpmznO3n2
         P8NPhosiI6dhrOB/uUcBIyCWTITdmCzOZ3QTwDcH5n0pqfKK4pjMH6HFOmx1F7WIQkHM
         eM9pgIPD1dkr65X2QIeftqn2sC1TjOm2w32kj8VZnsM1khWPNQJyW0Br7r24FTzuoocF
         vw9D1pjpW4d6eDPVsKItHrBoWGyAyudDtMAa8gH72l/1TwI/lMlQX0zqnljwGFRQ6t6X
         Mhfg==
X-Gm-Message-State: AOAM533VUeopVrU/AHbCbA+9mEZf/Vl936oM44eiX/Z+Lpk/Qxcc3ylD
        a5HwXH5OoardPaVXYdSisBQjF2WT5tkJRg==
X-Google-Smtp-Source: ABdhPJztnMJvU/dS4XrXXfw4b3+yubkFgV2fy70WNU6nFS6ASxK0Br1IkDQlQmqdKCV//NrF29O3MA==
X-Received: by 2002:a05:6808:d4f:: with SMTP id w15mr19175154oik.49.1642458688896;
        Mon, 17 Jan 2022 14:31:28 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i5sm6210777otj.3.2022.01.17.14.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 14:31:28 -0800 (PST)
Date:   Mon, 17 Jan 2022 16:31:23 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Miaoqian Lin <linmq006@gmail.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com
Subject: Re: [PATCH v3] remoteproc: Fix NULL vs IS_ERR() checking in
 rproc_create_trace_file
Message-ID: <YeXuOwm3yJW2gnSE@builder.lan>
References: <20220105064201.3907-1-linmq006@gmail.com>
 <20220105131022.25247-1-linmq006@gmail.com>
 <20220117170600.GA1119324@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117170600.GA1119324@p14s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Jan 11:06 CST 2022, Mathieu Poirier wrote:

> On Wed, Jan 05, 2022 at 01:10:22PM +0000, Miaoqian Lin wrote:
> > The debugfs_create_file() function doesn't return NULL.
> > It returns error pointers. Fix check in rproc_create_trace_file
> > and make it returns return error pointers.
> 
> s/"returns return"/return
> 
> > Fix check in rproc_handle_trace to propagate the error code.
> > 
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> > Changes in v2:
> > - return PTR_ERR(tfile) in rproc_create_trace_file
> > - fix check in rproc_handle_trace()
> > Changes in v3:
> > - return tfile to fix incorrect return type in v2
> > ---
> >  drivers/remoteproc/remoteproc_core.c    | 6 ++++--
> >  drivers/remoteproc/remoteproc_debugfs.c | 4 +---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> 
> I will fix the above, add a proper "Fixes" tag and apply this patch to
> rproc-next when v5.17-rc1 comes out next week.
> 

We're actually not supposed to check debugfs_create_*() for errors.

> Thanks,
> Mathieu
> 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 775df165eb45..5608408f8eac 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -656,6 +656,7 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
> >  	struct rproc_debug_trace *trace;
> >  	struct device *dev = &rproc->dev;
> >  	char name[15];
> > +	int ret;
> >  
> >  	if (sizeof(*rsc) > avail) {
> >  		dev_err(dev, "trace rsc is truncated\n");
> > @@ -684,9 +685,10 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
> >  
> >  	/* create the debugfs entry */
> >  	trace->tfile = rproc_create_trace_file(name, rproc, trace);
> > -	if (!trace->tfile) {
> > +	if (IS_ERR(trace->tfile)) {
> > +		ret = PTR_ERR(trace->tfile);
> >  		kfree(trace);
> > -		return -EINVAL;
> > +		return ret;


And actually catching and propagating the error here means that we will
start failing rproc_boot() for firmware including a RSC_TRACE when
debugfs is disabled...

So if we really want to save the heap space we should at least cleanly
ignore the error, by cleaning up and returning 0 here.

> >  	}
> >  
> >  	list_add_tail(&trace->node, &rproc->traces);
> > diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> > index b5a1e3b697d9..2ae59a365b7e 100644
> > --- a/drivers/remoteproc/remoteproc_debugfs.c
> > +++ b/drivers/remoteproc/remoteproc_debugfs.c
> > @@ -390,10 +390,8 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
> >  
> >  	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
> >  				    &trace_rproc_ops);
> > -	if (!tfile) {
> > +	if (IS_ERR(tfile))
> >  		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");

And I therefor think this function would be better reduced to:

	return debugfs_create_file(...);

Regards,
Bjorn

> > -		return NULL;
> > -	}
> >  
> >  	return tfile;
> >  }
> > -- 
> > 2.17.1
> > 
