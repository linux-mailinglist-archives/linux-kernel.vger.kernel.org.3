Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D144FC1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348377AbiDKQIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348401AbiDKQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:07:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C995C15A1D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:05:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g12-20020a17090a640c00b001cb59d7a57cso252163pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2ZVM+uUN1f/2A/tQjCJg2XZaTmIc9l7CBHqE7eGXoA=;
        b=y6f5hsUGntFT6S4n2zsP1kEp9rJQ+87eoPbABrJJH9l0AQZaZFs5QlX32M9CS90e2r
         CjHDV5FSAEhIF+73ChX0GJ9aPWP65KZ2XmckqQGZdpLT97jz5T184532eIMbf3OX6LAt
         yQKNnw5Wo82PZVqjC9UhRxqaknA2vYVPjAyh+hXmwnlz7GiUydwrUCLwUPHfu9k/7NkD
         BGTLDf8vQRKB1M/eqUUFWY7ZBtNrnMnsdnCbBPosDDoPg4FOU+leS1YnNabdUAEsoU9u
         6ojHaYQV5Smq4GMli79jIU60AfQQnltfhumI3vaNiu8YZKM+FzrI/oTvMdOp8lfPv9P5
         PXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2ZVM+uUN1f/2A/tQjCJg2XZaTmIc9l7CBHqE7eGXoA=;
        b=BqnbzpVD3S++f8BIKsv8JhMezsAmgKu+10GkpOBMIcRuXLZKOuk98u7s5NIG5dBcb2
         4So4+RNEdXWRqhU8Tp6TBBJjHeFC9oWVVtXK9qnf1U2RINpOxryfDJ9lbs1DIHqh2tso
         2UKJa+/uUJHQiEDwm4zYGv0qeXazoOECtbHWDzTMHvdvKn/z1zYY9UOAxqbMQl0K1m/b
         l8D8aPnyMRbWn+CT5tMBRT0IZvxXVClN9XrZp/2jbCR2TSNAgxZWu42GxwS8F8Mil9yN
         WXVOluhbkbQh9a5JMfbItYxqZgRyS4YVYLY6VIVA3WuqaqN9k0dBDvl+mfdG+Vq1W7XP
         WoUg==
X-Gm-Message-State: AOAM532/L6VxQjhEtvc9N9V4wYgv2lTGF3a5NZrrEijokYdexs4DijqS
        C8Y4j3zbnDIc+4rLtn5kkMRRUg==
X-Google-Smtp-Source: ABdhPJww3R3+fHQuPtSyzAUIOAtlisxsGH73ioWbG8cgSCfoqR8jwf4OUv9JNQjV4Jzi+j2z6SkClQ==
X-Received: by 2002:a17:90a:bb10:b0:1cb:57fa:309 with SMTP id u16-20020a17090abb1000b001cb57fa0309mr16735758pjr.191.1649693116077;
        Mon, 11 Apr 2022 09:05:16 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id lx13-20020a17090b4b0d00b001c9989c721esm22166989pjb.17.2022.04.11.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 09:05:14 -0700 (PDT)
Date:   Mon, 11 Apr 2022 10:05:12 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: Don't bother checking the return value of
 debugfs_create*
Message-ID: <20220411160512.GB323343@p14s>
References: <20220329154616.58902-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329154616.58902-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:16:16PM +0530, Manivannan Sadhasivam wrote:
> DebugFS APIs are designed to return only the error pointers and not NULL
> in the case of failure. So these return pointers are safe to be passed on
> to the successive debugfs_create* APIs.
> 
> Therefore, let's just get rid of the checks.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> * Removed the error check of rproc_create_trace_file().
> 
>  drivers/remoteproc/remoteproc_core.c    |  4 ----
>  drivers/remoteproc/remoteproc_debugfs.c | 17 ++---------------
>  2 files changed, 2 insertions(+), 19 deletions(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 69f51acf235e..56c3f70723a9 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -684,10 +684,6 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
>  
>  	/* create the debugfs entry */
>  	trace->tfile = rproc_create_trace_file(name, rproc, trace);
> -	if (!trace->tfile) {
> -		kfree(trace);
> -		return -EINVAL;
> -	}
>  
>  	list_add_tail(&trace->node, &rproc->traces);
>  
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index b5a1e3b697d9..2e2c4a31c154 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -386,16 +386,8 @@ void rproc_remove_trace_file(struct dentry *tfile)
>  struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
>  				       struct rproc_debug_trace *trace)
>  {
> -	struct dentry *tfile;
> -
> -	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
> +	return debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
>  				    &trace_rproc_ops);
> -	if (!tfile) {
> -		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
> -		return NULL;
> -	}
> -
> -	return tfile;
>  }
>  
>  void rproc_delete_debug_dir(struct rproc *rproc)
> @@ -411,8 +403,6 @@ void rproc_create_debug_dir(struct rproc *rproc)
>  		return;
>  
>  	rproc->dbg_dir = debugfs_create_dir(dev_name(dev), rproc_dbg);
> -	if (!rproc->dbg_dir)
> -		return;
>  
>  	debugfs_create_file("name", 0400, rproc->dbg_dir,
>  			    rproc, &rproc_name_ops);
> @@ -430,11 +420,8 @@ void rproc_create_debug_dir(struct rproc *rproc)
>  
>  void __init rproc_init_debugfs(void)
>  {
> -	if (debugfs_initialized()) {
> +	if (debugfs_initialized())
>  		rproc_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
> -		if (!rproc_dbg)
> -			pr_err("can't create debugfs dir\n");
> -	}
>  }
>  
>  void __exit rproc_exit_debugfs(void)
> -- 
> 2.25.1
> 
