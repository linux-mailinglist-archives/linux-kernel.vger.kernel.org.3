Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C884B9214
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiBPUEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:04:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiBPUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:04:54 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E22E2B165A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:04:41 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id p15so2172535oip.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p2YTwFNc3ICXWv/s85vDqxZ1xSdkq0Hufu5d0bc0A8Y=;
        b=ShDIiG7IqOeZlZJd+lOTHVz4sQnn4UTTgLdoXPvdbfFg4sB5Jx184dwnyM7TXIyDAC
         WXTyRl2Xxk2ILmfzsohfmL/pHi3wV2l2fa4wIkrSe6j0+miNDN9LO5lwzt3HnFRi0P30
         MHHVgwAHu6lpcWSmvOLlRsK2k3JhNNH7x3M2exo7YeoPGuGGQOONu3qlOrJosNgyfI9N
         Tt6ZG9qwubzj9RSqE6JVmuK9p2DFwuGpHOLov4d3x6EfffdpiiQAlAQzbxrk64XPQCXd
         Yx5ds9BwjkzP4sw33ZuEd4vXjvIDEb6dj5hI6bue5Deafp+sUmtTkX7a3W0p8FBrrEzV
         yltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p2YTwFNc3ICXWv/s85vDqxZ1xSdkq0Hufu5d0bc0A8Y=;
        b=KoDiSMFSCAmV533ylUcWEyD6KHqc8pLMDhMMmFlvk8Rr9vNT8gp4K5gNNdJ6V+kev/
         NSZDUtwf0YrszhYqe0gpoKT2kRkln7TlMzB2ftEhJ2pqwcBGDvPOW6JlSnruFDteXFz6
         5wHlW32EkgHmYMS7yVMhDqX+oQNmN00AFzBcOUozKjvQaNix9UJx+n9xgyxRusvnilTR
         Uykyjimz8T8U1/ZDARV25mS82XwoZ20QqudF0qiQKRRKdsW3UKgf7AQSBZaUd9L+QPc5
         J6mUVg9jKuCLsnkqeTg2CRbLX+/jXQ4hmKj8xTvi8xNvju3nEhTQ67T73M7WvktVwzAo
         WAfw==
X-Gm-Message-State: AOAM530r4n3YMpafE9flQwE4NhXEX46jyCkKix9QFcow3ayhRWZie050
        dfvw5kNd/v58gaUVIgXCzxQtEWZvowz2iQ==
X-Google-Smtp-Source: ABdhPJyfFXY8f2acavlDqsG3T3QaNMqhHhohq4+eKFpTxvCuif/UZ/sHPs8HMl5vC/5Yf/qifBqBTg==
X-Received: by 2002:aca:1a17:0:b0:2bc:a78c:7ba2 with SMTP id a23-20020aca1a17000000b002bca78c7ba2mr1414813oia.120.1645041880944;
        Wed, 16 Feb 2022 12:04:40 -0800 (PST)
Received: from yoga (rrcs-97-77-166-58.sw.biz.rr.com. [97.77.166.58])
        by smtp.gmail.com with ESMTPSA id w7sm15506869oou.13.2022.02.16.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:04:40 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:04:37 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Puranjay Mohan <p-mohan@ti.com>
Cc:     kishon@ti.com, vigneshr@ti.com, s-anna@ti.com,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/2] remoteproc: Introduce sysfs_read_only flag
Message-ID: <Yg1Y1dtT9CjZTxgW@yoga>
References: <20220216081224.9956-1-p-mohan@ti.com>
 <20220216081224.9956-2-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216081224.9956-2-p-mohan@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16 Feb 02:12 CST 2022, Puranjay Mohan wrote:

> The remoteproc framework provides sysfs interfaces for changing
> the firmware name and for starting/stopping a remote processor
> through the sysfs files 'state' and 'firmware'. The 'coredump'
> file is used to set the coredump configuration. The 'recovery'
> sysfs file can also be used similarly to control the error recovery
> state machine of a remoteproc. These interfaces are currently
> allowed irrespective of how the remoteprocs were booted (like
> remoteproc self auto-boot, remoteproc client-driven boot etc).
> These interfaces can adversely affect a remoteproc and its clients
> especially when a remoteproc is being controlled by a remoteproc
> client driver(s). Also, not all remoteproc drivers may want to
> support the sysfs interfaces by default.
> 
> Add support to make the remoteproc sysfs files read only by
> introducing a state flag 'sysfs_read_only' that the individual
> remoteproc drivers can set based on their usage needs. The default
> behavior is to allow the sysfs operations as before.
> 
> Implement attribute_group->is_visible() to make the sysfs
> entries read only when 'sysfs_read_only' flag is set.
> 
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> Changes in v4->v5:
> Rename deny_sysfs_ops to sysfs_read_only.
> Make coredump readonly with other files.
> 
> Changes in v3->v4:
> Use mode = 0444 in rproc_is_visible() to make the sysfs entries
> read-only when the deny_sysfs_ops flag is set.
> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 19 ++++++++++++++++++-
>  include/linux/remoteproc.h            |  2 ++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index ea8b89f97d7b..abf0cd05d5e1 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -230,6 +230,22 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(name);
>  
> +static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
> +				int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct rproc *rproc = to_rproc(dev);
> +	umode_t mode = attr->mode;
> +
> +	if (rproc->sysfs_read_only && (attr == &dev_attr_recovery.attr ||
> +				       attr == &dev_attr_firmware.attr ||
> +				       attr == &dev_attr_state.attr ||
> +				       attr == &dev_attr_coredump.attr))
> +		mode = 0444;

Change looks good now, but just to make sure, you actually care about
the content of these files for the Wakup M3? Read-only vs hiding them...

regards,
Bjorn

> +
> +	return mode;
> +}
> +
>  static struct attribute *rproc_attrs[] = {
>  	&dev_attr_coredump.attr,
>  	&dev_attr_recovery.attr,
> @@ -240,7 +256,8 @@ static struct attribute *rproc_attrs[] = {
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
> index e0600e1e5c17..93a1d0050fbc 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -523,6 +523,7 @@ struct rproc_dump_segment {
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>   * @auto_boot: flag to indicate if remote processor should be auto-started
> + * @sysfs_read_only: flag to make remoteproc sysfs files read only
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
>   * @elf_class: firmware ELF class
> @@ -562,6 +563,7 @@ struct rproc {
>  	size_t table_sz;
>  	bool has_iommu;
>  	bool auto_boot;
> +	bool sysfs_read_only;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  	u8 elf_class;
> -- 
> 2.17.1
> 
