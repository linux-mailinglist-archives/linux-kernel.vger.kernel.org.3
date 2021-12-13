Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6D472C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhLMMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:51:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50504 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhLMMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:51:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9767FB80EA2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A06CC34602;
        Mon, 13 Dec 2021 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639399871;
        bh=ZlDKrMNe27tXQ+2dNZiGYgd/rhANoS/NtseEN7lywOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZrxb4HVQnKM2EmMmrJ9xHYyreGadkLhvCOPKMUvgg9wJvu6xACdCnYmBqE2Ixpe3
         1nB4tc2WcYYfqWfvwxgh3d6b2dn7mXS/zxjtFA0kK9GyzWTPu3uk/QJcOXWWdc3A/C
         piv9O/uxQ17X7dFXMm92SYJSsMZzFSqe6+HiRYtw=
Date:   Mon, 13 Dec 2021 13:51:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai(A)" <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v3] uacce: use sysfs_emit instead of sprintf
Message-ID: <YbdBvNzmZn9twnej@kroah.com>
References: <20211206104724.11559-1-yekai13@huawei.com>
 <aeaa46e2-0adc-142e-f7e2-dcb4bbf8a74f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeaa46e2-0adc-142e-f7e2-dcb4bbf8a74f@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:05:56PM +0800, yekai(A) wrote:
> 
> 
> On 2021/12/6 18:47, Kai Ye wrote:
> > Use the sysfs_emit to replace sprintf. sprintf may cause
> > output defect in sysfs content, it is better to use new
> > added sysfs_emit function which knows the size of the
> > temporary buffer.
> > 
> > Signed-off-by: Kai Ye <yekai13@huawei.com>
> > ---
> > changes v1->v2:
> > 	modfiy the comments.
> > changes v2->v3:
> > 	modify the "changes" lines.
> > 
> >  drivers/misc/uacce/uacce.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> > index 488eeb2811ae..281c54003edc 100644
> > --- a/drivers/misc/uacce/uacce.c
> > +++ b/drivers/misc/uacce/uacce.c
> > @@ -289,7 +289,7 @@ static ssize_t api_show(struct device *dev,
> >  {
> >  	struct uacce_device *uacce = to_uacce_device(dev);
> > 
> > -	return sprintf(buf, "%s\n", uacce->api_ver);
> > +	return sysfs_emit(buf, "%s\n", uacce->api_ver);
> >  }
> > 
> >  static ssize_t flags_show(struct device *dev,
> > @@ -297,7 +297,7 @@ static ssize_t flags_show(struct device *dev,
> >  {
> >  	struct uacce_device *uacce = to_uacce_device(dev);
> > 
> > -	return sprintf(buf, "%u\n", uacce->flags);
> > +	return sysfs_emit(buf, "%u\n", uacce->flags);
> >  }
> > 
> >  static ssize_t available_instances_show(struct device *dev,
> > @@ -309,7 +309,7 @@ static ssize_t available_instances_show(struct device *dev,
> >  	if (!uacce->ops->get_available_instances)
> >  		return -ENODEV;
> > 
> > -	return sprintf(buf, "%d\n",
> > +	return sysfs_emit(buf, "%d\n",
> >  		       uacce->ops->get_available_instances(uacce));
> >  }
> > 
> > @@ -318,7 +318,7 @@ static ssize_t algorithms_show(struct device *dev,
> >  {
> >  	struct uacce_device *uacce = to_uacce_device(dev);
> > 
> > -	return sprintf(buf, "%s\n", uacce->algs);
> > +	return sysfs_emit(buf, "%s\n", uacce->algs);
> >  }
> > 
> >  static ssize_t region_mmio_size_show(struct device *dev,
> > @@ -326,7 +326,7 @@ static ssize_t region_mmio_size_show(struct device *dev,
> >  {
> >  	struct uacce_device *uacce = to_uacce_device(dev);
> > 
> > -	return sprintf(buf, "%lu\n",
> > +	return sysfs_emit(buf, "%lu\n",
> >  		       uacce->qf_pg_num[UACCE_QFRT_MMIO] << PAGE_SHIFT);
> >  }
> > 
> > @@ -335,7 +335,7 @@ static ssize_t region_dus_size_show(struct device *dev,
> >  {
> >  	struct uacce_device *uacce = to_uacce_device(dev);
> > 
> > -	return sprintf(buf, "%lu\n",
> > +	return sysfs_emit(buf, "%lu\n",
> >  		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
> >  }
> > 
> > 
> 
> Hi Hartman
> 
> Could you help to take this patch?

It has only been 1 week.  It is in my "to review" queue, please be
patient.  Patches that actually fix things and are new features are
always a higher priority than changes like this that have no functional
change at all.

thanks,

greg k-h
