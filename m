Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1464804A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 21:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhL0Uln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 15:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhL0Uln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 15:41:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DBAC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 12:41:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s1so34358139wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 12:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HVMGJarzF/4wgn1qo+B7sxCXySOqg0vqGBip2iWeHFE=;
        b=W5szm1tSH7RDfpp67ZzggS+TcJNNBj4zkpob7WffHJhOMFENn0hbOHAB7XXPiyomzq
         0PEI/kREGXScjVb5ynpdcAWl/x303zSpuUw9IE9QI8Q7pGrAW3H90v8pF62dTHC4PYm+
         vDQ3Q2X+b1soyNGZ5khdtYyW4wYY0gqmBEI5YnzU5SfBFHtohZdI9JYxIJsYgaLgQhKn
         2yTtfNcx5XeeAPbo1H3uSUm0zj22USSVXtF3jqOb2oGJrzUhqHYuvTFMDnD0zd6FME16
         ic80JPaS5LyfyHaEUJuZDhCwikGmm5nkKl4W/aiM76oPnUJwHq1yZ6rDNp+DNQ0fqpNR
         hZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HVMGJarzF/4wgn1qo+B7sxCXySOqg0vqGBip2iWeHFE=;
        b=n1PSkjUFfiSUwy8sbUEWv8TpQ40h0PCqkt4Rhy1RzPpQTFrmDIp2CUJAguutKLaWIy
         1YJlsOB5Zl9PY3r2wFPgnR0/jeqMSeKZjDND/whmmRAuwwSStFsE3eVsM808g/4E5flO
         8Ojfsm6HYpxpaj/+653ohXEnODmn4kbrGUWOXzpFIioQHDZCxf6kI0XiZPoVPNs7Hxq4
         h6LDRLgtQw/XJAPfEFLGZVoUq4hsFVonmT/dccP6TSnMvW2SDeHFrb4RKZmfDPu7+FLi
         CSNKyNbLN5iJNjvdpFh71mfqo4gURJkodKS85TfudRZH2wzDTSlZWrG5Fu022YWWxbbM
         vVFg==
X-Gm-Message-State: AOAM5308NEz1b7UgseJF8cMgOJd3od6ZfvvxJTwPl3Lpdj64ABinQM3Y
        KZVlxIGL6oGIQga20SmMOSZ7
X-Google-Smtp-Source: ABdhPJzzOIPp0YnSMz4L0Ck1i6cOZExG5oUL2uvynxR/CDqZCrxiYBw7vTJ6ugcWrF9hLj1h7mZemQ==
X-Received: by 2002:adf:ab43:: with SMTP id r3mr14419802wrc.585.1640637700520;
        Mon, 27 Dec 2021 12:41:40 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:c0a7:e611:c768:7ba5])
        by smtp.gmail.com with ESMTPSA id d10sm17975028wri.57.2021.12.27.12.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 12:41:40 -0800 (PST)
Date:   Mon, 27 Dec 2021 20:41:36 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: remove kset from struct kset_uevent_ops
 callbacks
Message-ID: <YcolAAn+fnXy05Cz@google.com>
References: <20211227163924.3970661-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211227163924.3970661-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 05:39:24PM +0100, Greg Kroah-Hartman wrote:
> There is no need to pass the pointer to the kset in the struct
> kset_uevent_ops callbacks as no one uses it, so just remove that pointer
> entirely.

In the future, if someone needs the kset they can always find it by looking for
the first non-null kset in the kobject or its parent chain, right? IOW, we're
not losing any information by removing this.

> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Wedson Almeida Filho <wedsonaf@google.com>

> ---
>  Documentation/core-api/kobject.rst                    |  7 +++----
>  Documentation/translations/zh_CN/core-api/kobject.rst |  7 +++----
>  drivers/base/bus.c                                    |  2 +-
>  drivers/base/core.c                                   | 11 +++++------
>  drivers/dma-buf/dma-buf-sysfs-stats.c                 |  2 +-
>  fs/dlm/lockspace.c                                    |  3 +--
>  fs/gfs2/sys.c                                         |  3 +--
>  include/linux/kobject.h                               |  7 +++----
>  kernel/params.c                                       |  2 +-
>  lib/kobject_uevent.c                                  |  6 +++---
>  10 files changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/core-api/kobject.rst b/Documentation/core-api/kobject.rst
> index d3b5bf9f643a..3d6e3107315d 100644
> --- a/Documentation/core-api/kobject.rst
> +++ b/Documentation/core-api/kobject.rst
> @@ -373,10 +373,9 @@ If a kset wishes to control the uevent operations of the kobjects
>  associated with it, it can use the struct kset_uevent_ops to handle it::
>  
>    struct kset_uevent_ops {
> -          int (* const filter)(struct kset *kset, struct kobject *kobj);
> -          const char *(* const name)(struct kset *kset, struct kobject *kobj);
> -          int (* const uevent)(struct kset *kset, struct kobject *kobj,
> -                        struct kobj_uevent_env *env);
> +          int (* const filter)(struct kobject *kobj);
> +          const char *(* const name)(struct kobject *kobj);
> +          int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
>    };
>  
>  
> diff --git a/Documentation/translations/zh_CN/core-api/kobject.rst b/Documentation/translations/zh_CN/core-api/kobject.rst
> index b7c37794cc7f..95634083dca0 100644
> --- a/Documentation/translations/zh_CN/core-api/kobject.rst
> +++ b/Documentation/translations/zh_CN/core-api/kobject.rst
> @@ -325,10 +325,9 @@ ksets
>  结构体kset_uevent_ops来处理它::
>  
>    struct kset_uevent_ops {
> -          int (* const filter)(struct kset *kset, struct kobject *kobj);
> -          const char *(* const name)(struct kset *kset, struct kobject *kobj);
> -          int (* const uevent)(struct kset *kset, struct kobject *kobj,
> -                        struct kobj_uevent_env *env);
> +          int (* const filter)(struct kobject *kobj);
> +          const char *(* const name)(struct kobject *kobj);
> +          int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
>    };
>  
>  
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index a64454f5f8c0..97936ec49bde 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -163,7 +163,7 @@ static struct kobj_type bus_ktype = {
>  	.release	= bus_release,
>  };
>  
> -static int bus_uevent_filter(struct kset *kset, struct kobject *kobj)
> +static int bus_uevent_filter(struct kobject *kobj)
>  {
>  	const struct kobj_type *ktype = get_ktype(kobj);
>  
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d712ea11066b..60d703ebd123 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2261,7 +2261,7 @@ static struct kobj_type device_ktype = {
>  };
>  
>  
> -static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
> +static int dev_uevent_filter(struct kobject *kobj)
>  {
>  	const struct kobj_type *ktype = get_ktype(kobj);
>  
> @@ -2275,7 +2275,7 @@ static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
>  	return 0;
>  }
>  
> -static const char *dev_uevent_name(struct kset *kset, struct kobject *kobj)
> +static const char *dev_uevent_name(struct kobject *kobj)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  
> @@ -2286,8 +2286,7 @@ static const char *dev_uevent_name(struct kset *kset, struct kobject *kobj)
>  	return NULL;
>  }
>  
> -static int dev_uevent(struct kset *kset, struct kobject *kobj,
> -		      struct kobj_uevent_env *env)
> +static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	int retval = 0;
> @@ -2382,7 +2381,7 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
>  
>  	/* respect filter */
>  	if (kset->uevent_ops && kset->uevent_ops->filter)
> -		if (!kset->uevent_ops->filter(kset, &dev->kobj))
> +		if (!kset->uevent_ops->filter(&dev->kobj))
>  			goto out;
>  
>  	env = kzalloc(sizeof(struct kobj_uevent_env), GFP_KERNEL);
> @@ -2390,7 +2389,7 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
>  		return -ENOMEM;
>  
>  	/* let the kset specific function add its keys */
> -	retval = kset->uevent_ops->uevent(kset, &dev->kobj, env);
> +	retval = kset->uevent_ops->uevent(&dev->kobj, env);
>  	if (retval)
>  		goto out;
>  
> diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
> index 053baadcada9..2bba0babcb62 100644
> --- a/drivers/dma-buf/dma-buf-sysfs-stats.c
> +++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
> @@ -132,7 +132,7 @@ void dma_buf_stats_teardown(struct dma_buf *dmabuf)
>  
>  
>  /* Statistics files do not need to send uevents. */
> -static int dmabuf_sysfs_uevent_filter(struct kset *kset, struct kobject *kobj)
> +static int dmabuf_sysfs_uevent_filter(struct kobject *kobj)
>  {
>  	return 0;
>  }
> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index 10eddfa6c3d7..0bbb346cb892 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c
> @@ -216,8 +216,7 @@ static int do_uevent(struct dlm_ls *ls, int in)
>  	return ls->ls_uevent_result;
>  }
>  
> -static int dlm_uevent(struct kset *kset, struct kobject *kobj,
> -		      struct kobj_uevent_env *env)
> +static int dlm_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
>  {
>  	struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
>  
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index c0a34d9ddee4..a6002b2d146d 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -767,8 +767,7 @@ void gfs2_sys_fs_del(struct gfs2_sbd *sdp)
>  	wait_for_completion(&sdp->sd_kobj_unregister);
>  }
>  
> -static int gfs2_uevent(struct kset *kset, struct kobject *kobj,
> -		       struct kobj_uevent_env *env)
> +static int gfs2_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
>  {
>  	struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
>  	struct super_block *s = sdp->sd_vfs;
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index 683172b2e094..ad90b49824dc 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -153,10 +153,9 @@ struct kobj_uevent_env {
>  };
>  
>  struct kset_uevent_ops {
> -	int (* const filter)(struct kset *kset, struct kobject *kobj);
> -	const char *(* const name)(struct kset *kset, struct kobject *kobj);
> -	int (* const uevent)(struct kset *kset, struct kobject *kobj,
> -		      struct kobj_uevent_env *env);
> +	int (* const filter)(struct kobject *kobj);
> +	const char *(* const name)(struct kobject *kobj);
> +	int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
>  };
>  
>  struct kobj_attribute {
> diff --git a/kernel/params.c b/kernel/params.c
> index 9b90e3c4d3c0..5b92310425c5 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -926,7 +926,7 @@ static const struct sysfs_ops module_sysfs_ops = {
>  	.store = module_attr_store,
>  };
>  
> -static int uevent_filter(struct kset *kset, struct kobject *kobj)
> +static int uevent_filter(struct kobject *kobj)
>  {
>  	const struct kobj_type *ktype = get_ktype(kobj);
>  
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index c87d5b6a8a55..7c44b7ae4c5c 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -501,7 +501,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>  	}
>  	/* skip the event, if the filter returns zero. */
>  	if (uevent_ops && uevent_ops->filter)
> -		if (!uevent_ops->filter(kset, kobj)) {
> +		if (!uevent_ops->filter(kobj)) {
>  			pr_debug("kobject: '%s' (%p): %s: filter function "
>  				 "caused the event to drop!\n",
>  				 kobject_name(kobj), kobj, __func__);
> @@ -510,7 +510,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>  
>  	/* originating subsystem */
>  	if (uevent_ops && uevent_ops->name)
> -		subsystem = uevent_ops->name(kset, kobj);
> +		subsystem = uevent_ops->name(kobj);
>  	else
>  		subsystem = kobject_name(&kset->kobj);
>  	if (!subsystem) {
> @@ -554,7 +554,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>  
>  	/* let the kset specific function add its stuff */
>  	if (uevent_ops && uevent_ops->uevent) {
> -		retval = uevent_ops->uevent(kset, kobj, env);
> +		retval = uevent_ops->uevent(kobj, env);
>  		if (retval) {
>  			pr_debug("kobject: '%s' (%p): %s: uevent() returned "
>  				 "%d\n", kobject_name(kobj), kobj,
> -- 
> 2.34.1
> 
