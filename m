Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D014EAF41
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbiC2Odg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiC2Ode (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:33:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A51AF35
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:31:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a16so878760plh.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lsP70CCaXDaE2udz5nTAsHVpadgeSMC46x2B6kOKiJQ=;
        b=fMwa8vv5SwPhBGFC75W4BQQ5WY2CI99tuPzzJZ+X5ITg8Lh3RLEe1zM2G8WxMWv6IE
         j3GrtHftNkEbR3cU8tDBFJqgvT5/9GepeX7aPPwB8Zilv9QWyBgkArgiXlOdsjtb8gqa
         h/5CmpSX2N7oJqhoUqTJQiMf6Ll7bg8vlozCOc1w0fVPuwdV7fXwG0uNIg6CDR4yYsfB
         iBfHjakcc9pqzL2JJZytwv/EqaJIV4NeS0kTb606qFvhlPdVY4RJECWl5o84knLFk92r
         pLN4W+298EFOqb+EDY5FHclBHUxo6fG39kjg8v1nzl1QC/4ZdjBsx93cw8Rzq3YjHYWz
         m3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lsP70CCaXDaE2udz5nTAsHVpadgeSMC46x2B6kOKiJQ=;
        b=F8E084gtJKBDpKrwt3mhy1tW9b7WatfA49++DMLqukXm+VeQpNH9B5Vz3sMoa9xxH8
         pZ6yyQ3/rhIMmO6SDdcR2TZ7s0qsxdb8T03NaC1mk7juVAefKJaLDlGD/Iq3z90KADPQ
         viMAWc5dZnX/C00lGOWbFOhb13zt4+Q2GINiildrAJJ/PhT6syK6Y56XDzkOqHBwEada
         okqtki0X6oB9aXSxLwbljJe+/SSoROYRyHeuWnpFQYam57sqCkp0P0c2L2ejeNa4KXNH
         Dx9wh65OHAzURpTEM2xDkIMViveHZHQ1yCe4zmfkWJC3ia6j40h5nsok5guLxy4NBbHt
         i8OQ==
X-Gm-Message-State: AOAM531SVpvLC/qDRwtum8nUP4pbZm/R0LZ8URpGA6g0m+nOquahYJBH
        ofsXwowSdPvau93yfA5IQpcr
X-Google-Smtp-Source: ABdhPJzpE1FYDJsc5tTxrz8in/qSw0DgAFt3quMPCz0DVaHZ3rP6uWeZiHIBljgpxDUit+IE1ERO0g==
X-Received: by 2002:a17:90b:4a83:b0:1c6:f037:bc73 with SMTP id lp3-20020a17090b4a8300b001c6f037bc73mr4811286pjb.44.1648564311071;
        Tue, 29 Mar 2022 07:31:51 -0700 (PDT)
Received: from thinkpad ([117.217.181.81])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004cdccd3da08sm20983552pfl.44.2022.03.29.07.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:31:50 -0700 (PDT)
Date:   Tue, 29 Mar 2022 20:01:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: Don't bother checking the return value of
 debugfs_create*
Message-ID: <20220329143146.GA2137@thinkpad>
References: <20220324181224.21542-1-manivannan.sadhasivam@linaro.org>
 <20220328155123.GA3722211@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328155123.GA3722211@p14s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Mon, Mar 28, 2022 at 09:51:23AM -0600, Mathieu Poirier wrote:
> Hi Mani,
> 
> On Thu, Mar 24, 2022 at 11:42:24PM +0530, Manivannan Sadhasivam wrote:
> > DebugFS APIs are designed to return only the error pointers and not NULL
> > in the case of failure. So these return pointers are safe to be passed on
> > to the successive debugfs_create* APIs.
> > 
> > Therefore, let's just get rid of the checks.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_debugfs.c | 17 ++---------------
> >  1 file changed, 2 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> > index b5a1e3b697d9..2e2c4a31c154 100644
> > --- a/drivers/remoteproc/remoteproc_debugfs.c
> > +++ b/drivers/remoteproc/remoteproc_debugfs.c
> > @@ -386,16 +386,8 @@ void rproc_remove_trace_file(struct dentry *tfile)
> >  struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
> >  				       struct rproc_debug_trace *trace)
> >  {
> > -	struct dentry *tfile;
> > -
> > -	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
> > +	return debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
> >  				    &trace_rproc_ops);
> > -	if (!tfile) {
> > -		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
> > -		return NULL;
> > -	}
> > -
> > -	return tfile;
> 
> Please see this thread [1] for an earlier conversation on this topic.
> 
> [1]. https://lore.kernel.org/lkml/20220105131022.25247-1-linmq006@gmail.com/T/
> 

Thanks for the pointer! I believe the conclusion was to return 0 here
and ignore the return from debugfs_create_file(). If that's the case, it looks
fine to me and I'll send a follow-up patch.

> >  }
> >  
> >  void rproc_delete_debug_dir(struct rproc *rproc)
> > @@ -411,8 +403,6 @@ void rproc_create_debug_dir(struct rproc *rproc)
> >  		return;
> >  
> >  	rproc->dbg_dir = debugfs_create_dir(dev_name(dev), rproc_dbg);
> > -	if (!rproc->dbg_dir)
> > -		return;
> > 
> >  	debugfs_create_file("name", 0400, rproc->dbg_dir,
> >  			    rproc, &rproc_name_ops);
> > @@ -430,11 +420,8 @@ void rproc_create_debug_dir(struct rproc *rproc)
> >  
> >  void __init rproc_init_debugfs(void)
> >  {
> > -	if (debugfs_initialized()) {
> > +	if (debugfs_initialized())
> >  		rproc_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
> > -		if (!rproc_dbg)
> > -			pr_err("can't create debugfs dir\n");
> > -	}
> 
> The above two are fine since debugfs_create_file() and debugfs_create_dir() can
> deal with @parent being an error code.
> 

debugfs_create_* APIs would never return NULL, so these checks are wrong.
Moreover, Greg recommends not to check the return value for any of these
functions.

I've found the mail thread where Greg explained the reasoning behind it:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1907800.html

Thanks,
Mani

> Thanks,
> Mathieu
> 
> >  }
> >  
> >  void __exit rproc_exit_debugfs(void)
> > -- 
> > 2.25.1
> > 
