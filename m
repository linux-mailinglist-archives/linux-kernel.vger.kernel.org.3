Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4968F4A8BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353077AbiBCShF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbiBCShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:37:04 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53EC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 10:37:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f8so2984591pgf.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 10:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vzZUhs+LvlRcv0A+Ri6qvyj7oWe7wjman1xGhk401Ro=;
        b=f2PMz7JEUoXN9aqJmBJlduYN3ABzpb5WPq4s9IdL2ZyLCNggfy7ctONKqgxe1rt6C5
         Nv2gnFfoJJ3EQtAWTFApijfxF4tTPOGe8wcWlThL6MK3bjS2ITAbpOukmLkrUVP//H9c
         BbD8p7HzMSLMV5YBetgfFQgJU/yIW/MsISDNwe+/M5m0tzOa/C3lkn8103/BCZfTyy8O
         gUVQ/41ndMMRpkrxu6xMSf5F4l1PVL5ocF7yQy4wKdcND9byEA7uZnNq6S2At2k4xrUG
         B+TfzpwzL8qgXeQ2/QzetfcKqxe0p6uNCIrdB/wl1v9p4u/ZNzqKF2rnwUsSTurPY4M+
         uyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzZUhs+LvlRcv0A+Ri6qvyj7oWe7wjman1xGhk401Ro=;
        b=IP6Z0UVaKq9BoPtktYvB3jyowH2/hGu86hpj4IGJuWLlrEGdv8f+bhA86sX1F8DPq0
         60sQCWhVio9AJiOfxEVOwSRja74v1mvpKqyQRSb6+33CXOwLAqtTyXKNUJN9uSvKHsJl
         CMVN6xWhpSwP3EoL7qC2YAz+nJgGYzfmRHhaUs4dtndJ7l0BLOpbPA8vbqDQKABudv0w
         IDivfSm6aCSNkEMVpXY5UKlftmHEDcfv0GFVQ2+MV5sFdqubAVhWTKRHE3HynPoV3Yw1
         d+/nLwUqOSZKg3MYl5jLZcQbRYQClvXGcoaYRTfKzmDCkOZseXHXi5iv3GDSHuVu4Ns7
         4sFg==
X-Gm-Message-State: AOAM530ML48W/9PNgEfL2VcGnIQnGF+JlC48oQLSbxRewYvHBAlD5qPd
        Kv6PlXjdBH9fVGC1u9g20d5Z7Q==
X-Google-Smtp-Source: ABdhPJxknTdG19mZXvMk18istJ7ki/4RPtCUMeJmi/D0pr22BTygxcdPXcMdwRjfOjjOyEwA+ZLlYA==
X-Received: by 2002:a63:710c:: with SMTP id m12mr28808753pgc.591.1643913423798;
        Thu, 03 Feb 2022 10:37:03 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id mh1sm11806612pjb.29.2022.02.03.10.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:37:02 -0800 (PST)
Date:   Thu, 3 Feb 2022 11:37:00 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     kishon@ti.com, vigneshr@ti.com, s-anna@ti.com,
        bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: [PATCH 1/2] remoteproc: Introduce deny_sysfs_ops flag
Message-ID: <20220203183700.GB2982815@p14s>
References: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
 <1643638312-3912-2-git-send-email-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643638312-3912-2-git-send-email-p-mohan@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Puranjay,

On Mon, Jan 31, 2022 at 07:41:51PM +0530, Puranjay Mohan wrote:
> The remoteproc framework provides sysfs interfaces for changing
> the firmware name and for starting/stopping a remote processor
> through the sysfs files 'state' and 'firmware'. The 'recovery'
> sysfs file can also be used similarly to control the error recovery
> state machine of a remoteproc. These interfaces are currently
> allowed irrespective of how the remoteprocs were booted (like
> remoteproc self auto-boot, remoteproc client-driven boot etc).
> These interfaces can adversely affect a remoteproc and its clients
> especially when a remoteproc is being controlled by a remoteproc
> client driver(s). Also, not all remoteproc drivers may want to
> support the sysfs interfaces by default.
> 
> Add support to deny the sysfs state/firmware/recovery change by
> introducing a state flag 'deny_sysfs_ops' that the individual
> remoteproc drivers can set based on their usage needs. The default
> behavior is to allow the sysfs operations as before.
> 
> Implement attribute_group->is_visible() to hide the sysfs
> state/firmware/recovery entries when deny_sysfs_ops flag is set.
> 

The address in the "To:" field of this email doesn't match the one in the SoB,
Something that makes checkpatch angry.

> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 18 +++++++++++++++++-
>  include/linux/remoteproc.h            |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index ea8b89f97d7b..4a41abdd1f7b 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -230,6 +230,21 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(name);
>  
> +static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
> +			       int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct rproc *rproc = to_rproc(dev);
> +	umode_t mode = attr->mode;
> +
> +	if (rproc->deny_sysfs_ops && (attr == &dev_attr_recovery.attr ||
> +				      attr == &dev_attr_firmware.attr ||
> +				      attr == &dev_attr_state.attr))

I toyed with this solution for a little while.  I think the use case is valid
but hiding the above options will also result in a system that is difficult to
use (and debug) because they convey important information.

I suggest introducing a new kernel configuration options to make the attributes
of the rproc_devgroup return -EINVAL when it is set.  So in remoteproc_sysfs.c
do something like:

#if CONFIG_REMOTEPROC_SYSFS_RO
static bool option_is_read_only()
{
        return true;
}
#else
static bool option_is_read_only()
{
        return false;
}
#endif

[...]

static ssize_t recovery_store(struct device *dev,
			      struct device_attribute *attr,
			      const char *buf, size_t count)
{
	struct rproc *rproc = to_rproc(dev);

        if (option_is_read_only())
                return -EINVAL;

	if (sysfs_streq(buf, "enabled")) {
		/* change the flag and begin the recovery process if needed */
		rproc->recovery_disabled = false;
		rproc_trigger_recovery(rproc);
	} else if (sysfs_streq(buf, "disabled")) {
		rproc->recovery_disabled = true;
	} else if (sysfs_streq(buf, "recover")) {
		/* begin the recovery process without changing the flag */
		rproc_trigger_recovery(rproc);
	} else {
		return -EINVAL;
	}

	return count;
}

Thanks,
Mathieu

> +		mode = 0;
> +
> +	return mode;
> +}
> +
>  static struct attribute *rproc_attrs[] = {
>  	&dev_attr_coredump.attr,
>  	&dev_attr_recovery.attr,
> @@ -240,7 +255,8 @@ static struct attribute *rproc_attrs[] = {
>  };
>  
>  static const struct attribute_group rproc_devgroup = {
> -	.attrs = rproc_attrs
> +	.attrs = rproc_attrs,
> +	.is_visible = rproc_is_visible,
>  };
>  
>  static const struct attribute_group *rproc_devgroups[] = {
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e0600e1e5c17..3849c66ce38f 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -523,6 +523,7 @@ struct rproc_dump_segment {
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>   * @auto_boot: flag to indicate if remote processor should be auto-started
> + * @deny_sysfs_ops: flag to not permit sysfs operations on state, firmware and recovery
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
>   * @elf_class: firmware ELF class
> @@ -562,6 +563,7 @@ struct rproc {
>  	size_t table_sz;
>  	bool has_iommu;
>  	bool auto_boot;
> +	bool deny_sysfs_ops;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  	u8 elf_class;
> -- 
> 2.24.3
> 
