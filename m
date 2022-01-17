Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840EC490F02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbiAQRNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbiAQRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:10:11 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE4CC061A7F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:06:04 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id s15so10711664pfw.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2gFGV0dtb9NAuE6SRHwipX2YahtHOLwxsg4HtVDywZM=;
        b=gD8BHzeEQ62CusYpTPibeVT4s8Aq0+xkC4N8G4VwFMu4JnpQEYGkna1MvwciuUq06x
         nJJ8R0M2YUIBnzEsI83G9l3MVwuqSvW/+BZOPFguIOZU1gE2E228usn88UxD9LkeHrFC
         KmRB54QYII2VkM8uNp2Q6Kt2FFNfEMVkchNlF67XIQT9RV6NjvHyFG4+LcMuNz3XyC+9
         9z+wP2MHbop5yJkyL7ohd2AOW//iqmsAVDIID1+3f5vz52QZMYsSPcV9wURXyRQs2VCS
         ZznKCy7mQsBQOIhgGGLuHUo1n/CWN3Ge+S6hHC7xqCusxa8E3leCJ+BJtlakM2ywep2J
         zA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2gFGV0dtb9NAuE6SRHwipX2YahtHOLwxsg4HtVDywZM=;
        b=KkRcDRSTY4HKxuDKuZfrQRBgILlo9fgUsJMWGUT/GcNKvdUumU387dyJbjSka0+B1T
         YPJLnrS+XaKSh0S/pvfRIk1K0YPQHlVThdmh3aWVVqq29jLlO4Zw1MUNrY5aJ/E19/q1
         T53lfn+ibIniz7XJM6JAiXHGBGbT2JQ+ShegZrO6GKHtK/PXz3pOdRMkE9AZhQCcgDeq
         bo2NHTFNTi9EFS+i2UIGckfN6Ez9hYX2TYVJPJkwCN7Xladp47m8Y+1D2pjTTieDbP1Q
         02vcgm1/04iQz/16MqIY55guU6+MQbTcRQ5KPDbYXx1gYaKaNjvvy58aZaAQIPwVXg4m
         HMuw==
X-Gm-Message-State: AOAM530cVI89rXGo9dr6hLRMH7aYZxIJ64FE6gE3Gr/RViqfavkys5n3
        4v8PqBdHQfGWUbHwyYzJPz3BwA==
X-Google-Smtp-Source: ABdhPJynb7czMzMKV2GsEF3v6alfyvYzw1oueRiDwPU8Ne8gjVQkI5vFXmW5d2LV9F0vStqyN3F02Q==
X-Received: by 2002:a63:1e0f:: with SMTP id e15mr5708832pge.577.1642439163968;
        Mon, 17 Jan 2022 09:06:03 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h5sm14378523pfi.46.2022.01.17.09.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 09:06:02 -0800 (PST)
Date:   Mon, 17 Jan 2022 10:06:00 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com
Subject: Re: [PATCH v3] remoteproc: Fix NULL vs IS_ERR() checking in
 rproc_create_trace_file
Message-ID: <20220117170600.GA1119324@p14s>
References: <20220105064201.3907-1-linmq006@gmail.com>
 <20220105131022.25247-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105131022.25247-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 01:10:22PM +0000, Miaoqian Lin wrote:
> The debugfs_create_file() function doesn't return NULL.
> It returns error pointers. Fix check in rproc_create_trace_file
> and make it returns return error pointers.

s/"returns return"/return

> Fix check in rproc_handle_trace to propagate the error code.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes in v2:
> - return PTR_ERR(tfile) in rproc_create_trace_file
> - fix check in rproc_handle_trace()
> Changes in v3:
> - return tfile to fix incorrect return type in v2
> ---
>  drivers/remoteproc/remoteproc_core.c    | 6 ++++--
>  drivers/remoteproc/remoteproc_debugfs.c | 4 +---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>

I will fix the above, add a proper "Fixes" tag and apply this patch to
rproc-next when v5.17-rc1 comes out next week.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 775df165eb45..5608408f8eac 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -656,6 +656,7 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
>  	struct rproc_debug_trace *trace;
>  	struct device *dev = &rproc->dev;
>  	char name[15];
> +	int ret;
>  
>  	if (sizeof(*rsc) > avail) {
>  		dev_err(dev, "trace rsc is truncated\n");
> @@ -684,9 +685,10 @@ static int rproc_handle_trace(struct rproc *rproc, void *ptr,
>  
>  	/* create the debugfs entry */
>  	trace->tfile = rproc_create_trace_file(name, rproc, trace);
> -	if (!trace->tfile) {
> +	if (IS_ERR(trace->tfile)) {
> +		ret = PTR_ERR(trace->tfile);
>  		kfree(trace);
> -		return -EINVAL;
> +		return ret;
>  	}
>  
>  	list_add_tail(&trace->node, &rproc->traces);
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index b5a1e3b697d9..2ae59a365b7e 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -390,10 +390,8 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
>  
>  	tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
>  				    &trace_rproc_ops);
> -	if (!tfile) {
> +	if (IS_ERR(tfile))
>  		dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
> -		return NULL;
> -	}
>  
>  	return tfile;
>  }
> -- 
> 2.17.1
> 
