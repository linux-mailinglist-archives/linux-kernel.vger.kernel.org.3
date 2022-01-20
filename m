Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30ED49542F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346676AbiATS21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiATS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:28:26 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82985C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:28:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u11so5830133plh.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cll/Fz+oRzTg4NkYGgse3QyvCmyGspXQFPzsSfhpD4Q=;
        b=XTbLMgr6L9Hf10tLGk72ynIT5OU06Oi/93dAe867TV67BFnxFSL7S54t3bJEN1hzB3
         GBalv7/XAe2tp/skOHkOvqgpT0CZtMxIMMIEwneAx5lF9mugf5ADQ89q0kJ4/8Vi2zWk
         XFK0uNXhdQ2VgGdzMgxmHNHaQmUZIyxJsZDBfSKGyxhLO5eL91ji53ckCuXzbNsOMekR
         IwZaQiEjzdzaPq6g6VNDxWqf3/KH13kE5IiGJwpBvyigdUAYxVVn0XB12HRqCyD3HTq3
         4FgeoCoABh93e9JDeijtrhTDlPpZpJK6nlX/oWXeNXyaKr16/gf3jBRlhEJZvfuYm2nT
         WB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cll/Fz+oRzTg4NkYGgse3QyvCmyGspXQFPzsSfhpD4Q=;
        b=5n1MTE4SYyJouKgHwtJPPVlFxvhSBUod7rsXnxgPQjKntqUNx1o965Wah+S+FYoDqd
         iyrUzYGA7DPQe00aILGwuMwufAU7gBQg72GZuWrYlX506mK5K7pqeHsldzlezjdctkNd
         PvOq5RBZlHzRPO9smxU1w2tXferNiy3M0EeIW0KkrQitmxyJ+X6bdLX6Utkc534jIWzD
         4I9+bT39lySH6JUskwAh/WkzT3IxLTt4ApHK6t8oY7N+aGuYfLmFV3FiqkYAwoAakgae
         px9jdoo4eYcQs54c6dzxbJFIQrZzO9b6YHW6k5r29aQvjTObRBk/EJ3iQ/pu40au+4gp
         wntQ==
X-Gm-Message-State: AOAM533d16BTlkYKYq2Fk88SEMbsUaITCY+lpQvkN958OKrozo6zVGTx
        e/UI7c90j3H8AHoiLYRfSQQt1w==
X-Google-Smtp-Source: ABdhPJzaPlt6MPQpB5TqcZOSwNiTVTpKDx+isyPvbrL5Zw93YzzhMY1p4pVnjgjvN5lkHq1Z+lKBYQ==
X-Received: by 2002:a17:902:a38f:b0:14a:ec8d:51ac with SMTP id x15-20020a170902a38f00b0014aec8d51acmr11724250pla.132.1642703305917;
        Thu, 20 Jan 2022 10:28:25 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t9sm9197455pjg.44.2022.01.20.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:28:24 -0800 (PST)
Date:   Thu, 20 Jan 2022 11:28:22 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: syscfg: Fix memleak on registration failure
 in cscfg_create_device
Message-ID: <20220120182822.GA1342128@p14s>
References: <20220110073100.15497-1-linmq006@gmail.com>
 <20220120175642.GB1338735@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120175642.GB1338735@p14s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 10:56:42AM -0700, Mathieu Poirier wrote:
> Good morning,
> 
> On Mon, Jan 10, 2022 at 07:31:00AM +0000, Miaoqian Lin wrote:
> > device_register() calls device_initialize(),
> > according to doc of device_initialize:
> > 
> >     Use put_device() to give up your reference instead of freeing
> >     * @dev directly once you have called this function.
> 
> That is _if_ device_initialize() is called manually.  In this instance
> @dev is registered with device_register() and unregistered with
> device_unregister().  The latter conforms to the comment you pointed out and
> calls put_device() as expected.

I originally misunderstood the context - you are referring to the failure path in
cscfg_create_device().  You are correct about needing to call put_device() but
your solution will not work when the module is unloaded properly and
device_unregister() is called by way of cscfg_clear_device().  In that case
device_unregister() is already calling put_device().

Here simply calling put_device() instead of cscfg_dev_release() in the error
path should do just fine.  That will call cscfg_dev_release() and the memory
allocated for cscfg_mgr will be release.

> 
> Thanks,
> Mathieu
> 
> > 
> > To prevent potential memleak, use put_device() instead call kfree
> > directly.
> > 
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-syscfg.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> > index 43054568430f..007fa1c761a7 100644
> > --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> > +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> > @@ -764,7 +764,7 @@ struct device *cscfg_device(void)
> >  /* Must have a release function or the kernel will complain on module unload */
> >  static void cscfg_dev_release(struct device *dev)
> >  {
> > -	kfree(cscfg_mgr);
> > +	put_device(dev);
> >  	cscfg_mgr = NULL;
> >  }
> >  
> > -- 
> > 2.17.1
> > 
