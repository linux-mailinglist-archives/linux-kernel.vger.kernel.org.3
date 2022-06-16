Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEA54DCA5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358692AbiFPIPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiFPIPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:15:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741A45D5D7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:15:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x5so1115728edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NTbh4MI+QCwbcpkgIpo7198UESJ/mO1+VW3Q06LAB7c=;
        b=jaqw6FnWxB/5UThR+ZDWPxP3LWg0yS0YKOWgNceuoysE3QYfS+oCxZDmNCa3RDthiA
         nkA25n9Yi8JFYV85REMoUBn+G4y6pDSV2DxU42hO4xQRb7+rgdKay4JL4s8VmPBn1nC2
         yF85m7F7VZaH+V+s+cRL0dGTy2NlNoYtbSfZ1CPjfZrocAUyoNrf37+MCeIEcVKY9Mdz
         1i9VibVT2e/BJ4fdVSxoKa4OFM3U6ip5yjEZWjhIfkQsGUiBh6VjTAV2L2vDPEt837o3
         6rPCfBieZXhr+OtkAuMNYQbYzuIY8e5Vdeqa07pg+PV/0s2Uo8oR92+b05AsASWc2IXa
         l2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NTbh4MI+QCwbcpkgIpo7198UESJ/mO1+VW3Q06LAB7c=;
        b=x4A/SFHnDE9qbmTlkmKoOOOF0YRFW4dfZ6lZ9XtW5zBm6q5q4BGFzO9OrwU/DhkzId
         UCKFD26w+1vDnkR8ud6NaYdSNgo+KzbtqAdBKf1ax3AmKZ6Hew1JcvzYhHJapKy1QD+A
         ENAgxD2u3eHcZoVC9iqphEeeoWdjDGdSjjWOSs5+r9dK+c5HdmZwRUQ4xFsV49xyMRN2
         +xkQh3CC3PLlnsJGSq7T33J+pNUg+XjmH34Qhzt1hxYXCzjVaumXwfEm4ifXJxVW0fty
         8d8Pm49/Kq+EIurq2vXC6AoN9MST4zPzg0JyxkLdH7pAEQHmLsNR2fu6lU/qG7/AmoFf
         z/DQ==
X-Gm-Message-State: AJIora9Lcsr+jidEZIBLHINlITkJfyEmDitVaWDqTnrG8G83LUjPsvkN
        iYQmSrbQkjlrYO+MdtVFc54zdXqA926QEg==
X-Google-Smtp-Source: AGRyM1tAV7ubqxgWT2Y3vDm33RYC1UL1k8VL4cdyLifra2KOoXTU0YbVtJhJ79SiTn0ipQMr4EiJtw==
X-Received: by 2002:a05:6402:100c:b0:42d:f407:b050 with SMTP id c12-20020a056402100c00b0042df407b050mr4735798edu.39.1655367307984;
        Thu, 16 Jun 2022 01:15:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709060d6200b006f3ef214e2csm471585ejh.146.2022.06.16.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 01:15:07 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:14:44 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Yang Shen <shenyang39@huawei.com>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YqrmdKNrYTCiS/MC@myrica>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:10:18PM +0800, Zhangfei Gao wrote:
> > > diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> > > index 281c54003edc..b6219c6bfb48 100644
> > > --- a/drivers/misc/uacce/uacce.c
> > > +++ b/drivers/misc/uacce/uacce.c
> > > @@ -136,9 +136,16 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
> > >   	if (!q)
> > >   		return -ENOMEM;
> > > +	mutex_lock(&uacce->queues_lock);
> > > +
> > > +	if (!uacce->parent->driver) {
> > I don't think this is useful, because the core clears parent->driver after
> > having run uacce_remove():
> > 
> >    rmmod hisi_zip		open()
> >     ...				 uacce_fops_open()
> >     __device_release_driver()	  ...
> >      pci_device_remove()
> >       hisi_zip_remove()
> >        hisi_qm_uninit()
> >         uacce_remove()
> >          ...			  ...
> >     				  mutex_lock(uacce->queues_lock)
> >      ...				  if (!uacce->parent->driver)
> >      device_unbind_cleanup()	  /* driver still valid, proceed */
> >       dev->driver = NULL
> 
> The check  if (!uacce->parent->driver) is required, otherwise NULL pointer
> may happen.

I agree we need something, what I mean is that this check is not
sufficient.

> iommu_sva_bind_device
> const struct iommu_ops *ops = dev_iommu_ops(dev);  ->
> dev->iommu->iommu_dev->ops
> 
> rmmod has no issue, but remove parent pci device has the issue.

Ah right, relying on the return value of bind() wouldn't be enough even if
we mandated SVA.

[...]
> > 
> > I think we need the global uacce_mutex to serialize uacce_remove() and
> > uacce_fops_open(). uacce_remove() would do everything, including
> > xa_erase(), while holding that mutex. And uacce_fops_open() would try to
> > obtain the uacce object from the xarray while holding the mutex, which
> > fails if the uacce object is being removed.
> 
> Since fops_open get char device refcount, uacce_release will not happen
> until open returns.

The refcount only ensures that the uacce_device object is not freed as
long as there are open fds. But uacce_remove() can run while there are
open fds, or fds in the process of being opened. And atfer uacce_remove()
runs, the uacce_device object still exists but is mostly unusable. For
example once the module is freed, uacce->ops is not valid anymore. But
currently uacce_fops_open() may dereference the ops in this case:

	uacce_fops_open()
	 if (!uacce->parent->driver)
	 /* Still valid, keep going */		
	 ...					rmmod
						 uacce_remove()
	 ...					 free_module()
	 uacce->ops->get_queue() /* BUG */

Accessing uacce->ops after free_module() is a use-after-free. We need all
the fops to synchronize with uacce_remove() to ensure they don't use any
resource of the parent after it's been freed. 

I see uacce_fops_poll() may have the same problem, and should be inside
uacce_mutex.

Thanks,
Jean
