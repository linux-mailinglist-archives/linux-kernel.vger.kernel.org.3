Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09324A8F52
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354601AbiBCUqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356270AbiBCUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:08 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE9C0617A9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:42:45 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so3596322otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 12:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9YhYiGrMThXgjtARncjWlXyWhx8xPMFx0EhdM5KOatg=;
        b=w7pkS3GtOfpfBqiF5ERFxhZFm8E1H3vn7QVKcj6sQRrFUwnzrPS0Z27fW2lZMN55bC
         U/aG6D8dMYSzq5mnGn7j6AxcV8XG14eCA6uvhlyjFObR79MfYy8k5qrWIVCYaYehrgDG
         qlzsTwEBt7P97jy8eceolXjVtPzloZO6iiZFpqqu/KMDd5Wv7ntA7hI/ct68wExeaVlB
         9+SvmeYxjAS+jwA9ByUnQIaaL5S/BsoEo5KDUz8IaZKXXTLwezJEwp0Qj0nGchuXESZ/
         EUaFvtk/rXjjjt1FstUmVvjVeKolw4yhxwqBLResbLBrB236T9cDmj13EyrP/OQFMgAo
         /J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9YhYiGrMThXgjtARncjWlXyWhx8xPMFx0EhdM5KOatg=;
        b=5AdBeGNsVLeQk10m5arsu1Qk+WxS4Jc2iuppUiLbxD4pKmId/ug2JOYogW/SBMje64
         w+2HFB+jQwX+zWquhk8qMmy4dB4QZKXWOU+ojZW135BembvAfR91AU/wq/fluXiH7AOV
         aAiZuOCylO49tQ45rAF1mlhyj+KISMMq1dVBlsNFwBRRZ4RNw8ye60n8huYDRzuZI0vM
         BT48kBNbYDWEbeZHVN1msq4ZwXGqfnLd6u4MXF+FIgZHvAEMwcI1dSenuFFJX/Pgarh/
         IVWoAGFZ9Fa+rPREbq7QB3WlVCpVS1aFuiwxXYfDA+GqO6x19x5Hcccdv6vV9DmLBtG3
         JbGA==
X-Gm-Message-State: AOAM530D9bBdg6PBcRUkxQwjKI6bjtjINnJtdfl8H8MTRAFC4eBP12zZ
        Gh+lFu9d1ZatBJ/Yos8bqRQX5A==
X-Google-Smtp-Source: ABdhPJyvp/DHNYio8qfrOT7OrHzJNzTFJov3KT3hzWws0jWr4B0rdPZHHdHrJKuVqOvZUQZkAfnyDA==
X-Received: by 2002:a9d:5c8a:: with SMTP id a10mr19959607oti.248.1643920964763;
        Thu, 03 Feb 2022 12:42:44 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id bb16sm6709251oob.42.2022.02.03.12.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:42:44 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:43:01 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, kishon@ti.com,
        vigneshr@ti.com, s-anna@ti.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: [PATCH 1/2] remoteproc: Introduce deny_sysfs_ops flag
Message-ID: <Yfw+VdrUJFjl6ZAQ@ripper>
References: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
 <1643638312-3912-2-git-send-email-p-mohan@ti.com>
 <20220203183700.GB2982815@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203183700.GB2982815@p14s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Feb 10:37 PST 2022, Mathieu Poirier wrote:

> Hi Puranjay,
> 
> On Mon, Jan 31, 2022 at 07:41:51PM +0530, Puranjay Mohan wrote:
> > The remoteproc framework provides sysfs interfaces for changing
> > the firmware name and for starting/stopping a remote processor
> > through the sysfs files 'state' and 'firmware'. The 'recovery'
> > sysfs file can also be used similarly to control the error recovery
> > state machine of a remoteproc. These interfaces are currently
> > allowed irrespective of how the remoteprocs were booted (like
> > remoteproc self auto-boot, remoteproc client-driven boot etc).
> > These interfaces can adversely affect a remoteproc and its clients
> > especially when a remoteproc is being controlled by a remoteproc
> > client driver(s). Also, not all remoteproc drivers may want to
> > support the sysfs interfaces by default.
> > 
> > Add support to deny the sysfs state/firmware/recovery change by
> > introducing a state flag 'deny_sysfs_ops' that the individual
> > remoteproc drivers can set based on their usage needs. The default
> > behavior is to allow the sysfs operations as before.
> > 
> > Implement attribute_group->is_visible() to hide the sysfs
> > state/firmware/recovery entries when deny_sysfs_ops flag is set.
> > 
> 
> The address in the "To:" field of this email doesn't match the one in the SoB,
> Something that makes checkpatch angry.
> 
> > Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> > ---
> >  drivers/remoteproc/remoteproc_sysfs.c | 18 +++++++++++++++++-
> >  include/linux/remoteproc.h            |  2 ++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> > index ea8b89f97d7b..4a41abdd1f7b 100644
> > --- a/drivers/remoteproc/remoteproc_sysfs.c
> > +++ b/drivers/remoteproc/remoteproc_sysfs.c
> > @@ -230,6 +230,21 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(name);
> >  
> > +static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
> > +			       int n)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct rproc *rproc = to_rproc(dev);
> > +	umode_t mode = attr->mode;
> > +
> > +	if (rproc->deny_sysfs_ops && (attr == &dev_attr_recovery.attr ||
> > +				      attr == &dev_attr_firmware.attr ||
> > +				      attr == &dev_attr_state.attr))
> 
> I toyed with this solution for a little while.  I think the use case is valid
> but hiding the above options will also result in a system that is difficult to
> use (and debug) because they convey important information.
> 
> I suggest introducing a new kernel configuration options to make the attributes
> of the rproc_devgroup return -EINVAL when it is set.  So in remoteproc_sysfs.c
> do something like:
> 
> #if CONFIG_REMOTEPROC_SYSFS_RO

We should assume that people runs the common multi_v7_defconfig for arm,
or defconfig for arm64, and still want this support.

Based on Puranjay's proposed patch I think it's also reasonable to
assume that we might have platforms with a mixture of "read-only" and
"normal" remoteprocs (e.g. some power-management uC + some DSP).

> static bool option_is_read_only()
> {
>         return true;
> }
> #else
> static bool option_is_read_only()
> {
>         return false;
> }
> #endif
> 
> [...]
> 
> static ssize_t recovery_store(struct device *dev,
> 			      struct device_attribute *attr,
> 			      const char *buf, size_t count)
> {
> 	struct rproc *rproc = to_rproc(dev);
> 
>         if (option_is_read_only())

struct attribute_group has a .is_visible callback which I think is
better to base this on.

Regards,
Bjorn

>                 return -EINVAL;
> 
> 	if (sysfs_streq(buf, "enabled")) {
> 		/* change the flag and begin the recovery process if needed */
> 		rproc->recovery_disabled = false;
> 		rproc_trigger_recovery(rproc);
> 	} else if (sysfs_streq(buf, "disabled")) {
> 		rproc->recovery_disabled = true;
> 	} else if (sysfs_streq(buf, "recover")) {
> 		/* begin the recovery process without changing the flag */
> 		rproc_trigger_recovery(rproc);
> 	} else {
> 		return -EINVAL;
> 	}
> 
> 	return count;
> }
> 
> Thanks,
> Mathieu
> 
> > +		mode = 0;
> > +
> > +	return mode;
> > +}
> > +
> >  static struct attribute *rproc_attrs[] = {
> >  	&dev_attr_coredump.attr,
> >  	&dev_attr_recovery.attr,
> > @@ -240,7 +255,8 @@ static struct attribute *rproc_attrs[] = {
> >  };
> >  
> >  static const struct attribute_group rproc_devgroup = {
> > -	.attrs = rproc_attrs
> > +	.attrs = rproc_attrs,
> > +	.is_visible = rproc_is_visible,
> >  };
> >  
> >  static const struct attribute_group *rproc_devgroups[] = {
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index e0600e1e5c17..3849c66ce38f 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -523,6 +523,7 @@ struct rproc_dump_segment {
> >   * @table_sz: size of @cached_table
> >   * @has_iommu: flag to indicate if remote processor is behind an MMU
> >   * @auto_boot: flag to indicate if remote processor should be auto-started
> > + * @deny_sysfs_ops: flag to not permit sysfs operations on state, firmware and recovery
> >   * @dump_segments: list of segments in the firmware
> >   * @nb_vdev: number of vdev currently handled by rproc
> >   * @elf_class: firmware ELF class
> > @@ -562,6 +563,7 @@ struct rproc {
> >  	size_t table_sz;
> >  	bool has_iommu;
> >  	bool auto_boot;
> > +	bool deny_sysfs_ops;
> >  	struct list_head dump_segments;
> >  	int nb_vdev;
> >  	u8 elf_class;
> > -- 
> > 2.24.3
> > 
