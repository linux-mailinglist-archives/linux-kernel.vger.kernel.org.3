Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5341D485BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbiAEW4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:56:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245153AbiAEW4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641423392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V6m8u3gzEN+5Gs0rFxJGhSiVfAzF8qa8gCDneBudXU0=;
        b=dyV1wxPBjhlfxEU+yhirXalTtci2+fr28WiKYr84hRIXI/VS4gj+6XFcWkACtIlt0GAQQp
        0EGFecxvpheDRAHhAAbZ0eeMO4L9b/eKGZv6DWxAkaWHc0w4r0gvU84Kn4CCLwwGesikcn
        mf1NgbR/TH4qDDO0m5zVEHHoXsmayOQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-HksmvOi6MsGmhwwKTjdxYg-1; Wed, 05 Jan 2022 17:56:31 -0500
X-MC-Unique: HksmvOi6MsGmhwwKTjdxYg-1
Received: by mail-wm1-f70.google.com with SMTP id ay41-20020a05600c1e2900b00345a568e6b2so30565wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6m8u3gzEN+5Gs0rFxJGhSiVfAzF8qa8gCDneBudXU0=;
        b=yZEybXMmU/JWEM6KMZNMkR2bLpXYRXvPCfBrRrvzPvqt60tMqEwR4DsrT9iNgSTftk
         QXfqZyE311e7sf1KZ+AzsQrYev3Ay/kYvBZLktFCnGflZ/Ltchdx5VWsC97oV9i3zRBx
         1Z8P8Y41YZmaPjGi/DsNFWsqJKDQAXvtuPLyL6We2KcJxB5xVWg4p3qjnsZ4RWcIO/OX
         zG1JEndMMbZKyTZ5ZNrYabetfS+3bgRwKu36JQR1jHYzO5MA1fnsLWqWdR0WNPKllxQp
         nOsyLfZer7zt8uo2qARmJ9zSjHbSwRlHP0yHqlJXX/yz//w+ow7K8/8fV2RQnWMDMIKm
         NRXw==
X-Gm-Message-State: AOAM530TaaVOLlywIELPHL5YOiEkSA7DfJhPKs8tRmLaskRWpHIFI0rM
        rf/XzeR0HX8POgy9Ra5Yj/Sp/8u1ILli12b2a/WrgcG7xumlqUDRSCL+CtEkcnJrlboM0K4mG3q
        /H5zFELf6qqmsOd6BOhapaSms
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr4740045wmk.76.1641423390204;
        Wed, 05 Jan 2022 14:56:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6GS056LJrsFPlX+DWzR8kOeOYzSJU+SzRdhlUHdc4WnX+EscgIicaxJi8rPTXUjW1xh071w==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr4740039wmk.76.1641423390058;
        Wed, 05 Jan 2022 14:56:30 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
        by smtp.gmail.com with ESMTPSA id r9sm284494wrm.76.2022.01.05.14.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 14:56:29 -0800 (PST)
Date:   Wed, 5 Jan 2022 17:56:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Gabriel Somlo <somlo@cmu.edu>,
        qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu_fw_cfg: use default_groups in kobj_type
Message-ID: <20220105175546-mutt-send-email-mst@kernel.org>
References: <20220105183133.2812848-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105183133.2812848-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 07:31:33PM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the firmware qemu_fw_cfg sysfs code to use default_groups
> field which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
> 
> Cc: Gabriel Somlo <somlo@cmu.edu>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

OK then you know best I guess

Acked-by: Michael S. Tsirkin <mst@redhat.com>

feel free to queue.

> ---
>  drivers/firmware/qemu_fw_cfg.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 172c751a4f6c..c62f05420d32 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -395,7 +395,7 @@ static void fw_cfg_sysfs_cache_cleanup(void)
>  	}
>  }
>  
> -/* default_attrs: per-entry attributes and show methods */
> +/* per-entry attributes and show methods */
>  
>  #define FW_CFG_SYSFS_ATTR(_attr) \
>  struct fw_cfg_sysfs_attribute fw_cfg_sysfs_attr_##_attr = { \
> @@ -428,6 +428,7 @@ static struct attribute *fw_cfg_sysfs_entry_attrs[] = {
>  	&fw_cfg_sysfs_attr_name.attr,
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(fw_cfg_sysfs_entry);
>  
>  /* sysfs_ops: find fw_cfg_[entry, attribute] and call appropriate show method */
>  static ssize_t fw_cfg_sysfs_attr_show(struct kobject *kobj, struct attribute *a,
> @@ -454,7 +455,7 @@ static void fw_cfg_sysfs_release_entry(struct kobject *kobj)
>  
>  /* kobj_type: ties together all properties required to register an entry */
>  static struct kobj_type fw_cfg_sysfs_entry_ktype = {
> -	.default_attrs = fw_cfg_sysfs_entry_attrs,
> +	.default_groups = fw_cfg_sysfs_entry_groups,
>  	.sysfs_ops = &fw_cfg_sysfs_attr_ops,
>  	.release = fw_cfg_sysfs_release_entry,
>  };
> -- 
> 2.34.1

