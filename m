Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1C64DA280
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351100AbiCOSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345461AbiCOSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:40:38 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFEE2126F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:39:25 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kj21so167896qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c6BjYFfCINr1jbMqdvsvHsZfVzgMAvQu+FmAJGwHfQk=;
        b=LCi1mMZcSoeMOKheGc5YJbXIWo9H+JBKs1bU/F9v3Am+bgzh+6HZ8Kypkam3Fx9Ik3
         YL31XZCUPjwNJqiGpVkrkrK0utu+y2CDUPG9WQuWtIws9kguAu0/Rvwtj42BXTs2kH0v
         gr62iJW8cpA977drZHURZOBcvDhjJdvmCg0wJVBgToeZsMqoOPzMMXkLJsMS5kKuKy8/
         xtdNKlTAIO6MSD6ke3pJ/2gGtLUcp2WDqpN8h3giDGH0oK8WVzSS4dL7NLMcCARBNtYM
         9h+CdpzZRpRkS7fKu3csx88XO2KdW2e3iQvEYvklT/d92JE0nmx41ssGIoWKzgZjAlGE
         4R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c6BjYFfCINr1jbMqdvsvHsZfVzgMAvQu+FmAJGwHfQk=;
        b=d3j4K4Febv9Sno+KqAAqbd3vaIH+Tjem/g3fCzKUp2A2KqLuMm1xDmX/gAAHq6qomt
         ob1m80OmcBmJ4HBRHgu+aXykc/RMHkYQwdEcGBWwL/xo16NKF+P5NaPjzd0+hKfem+5S
         DSzHgXfQvjyRAkVT1CBiGA1korxnQ+jbktqThFSC8VnyaeClJXFCXjtMEflDKKb5E8EH
         O03TV11eIFMmLq2F9EZ0YpnmCODQozVue2iJH/T6gnCm2kqWKRt9ZcnLEcv29URv/RDa
         yxXIlkNvteSKhfYzlEfPfgz+2zQKkzYQuuzaHlW4BopFoSNijF9hFw6wKkddrARXtGqX
         oROA==
X-Gm-Message-State: AOAM531WDkvBtQmnhuwu9syPHNljk6q5nijGWapEqXgnHcMv37a1oMb4
        D9c9P6zcPHhQGKnRlaSKlMxzoA==
X-Google-Smtp-Source: ABdhPJzWBj4X5F6V31ECL1lv0nh007pV8FVtZk5v4tU1J1WdGNdd7Zb08gS086sB0gd9msCqcunMxA==
X-Received: by 2002:a05:6214:3016:b0:439:365c:56b6 with SMTP id ke22-20020a056214301600b00439365c56b6mr19278622qvb.47.1647369564762;
        Tue, 15 Mar 2022 11:39:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id e7-20020a37ac07000000b0067d7cd47af4sm6473808qkm.31.2022.03.15.11.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 11:39:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nUC4o-0010R3-Jf; Tue, 15 Mar 2022 15:39:22 -0300
Date:   Tue, 15 Mar 2022 15:39:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Message-ID: <20220315183922.GC64706@ziepe.ca>
References: <20220311033050.22724-1-mpenttil@redhat.com>
 <20220314182439.GB64706@ziepe.ca>
 <d9b9c82e-4012-cf0a-d966-d9669a684a27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9b9c82e-4012-cf0a-d966-d9669a684a27@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 05:22:15AM +0200, Mika Penttilä wrote:
> Hi Jason and thanks for your comments..
> 
> On 14.3.2022 20.24, Jason Gunthorpe wrote:
> > On Fri, Mar 11, 2022 at 05:30:50AM +0200, mpenttil@redhat.com wrote:
> > > From: Mika Penttilä <mpenttil@redhat.com>
> > > 
> > > HMM selftests use an in-kernel pseudo device to emulate device private
> > > memory. The pseudo device registers a major device range for two pseudo
> > > device instances. User space has a script that reads /proc/devices in
> > > order to find the assigned major number, and sends that to mknod(1),
> > > once for each node.
> > > 
> > > This duplicates a fair amount of boilerplate that misc device can do
> > > instead.
> > > 
> > > Change this to use misc device, which makes the device node names appear
> > > for us. This also enables udev-like processing if desired.
> > 
> > This is borderline the wrong way to use misc devices, they should
> > never be embedded into other structs like this. It works out here
> > because they are eventually only placed in a static array, but still
> > it is a generally bad pattern to see.
> 
> Could you elaborate on this one? We have many in-tree usages of the same
> pattern, like:

The kernel is full of bugs

> drivers/video/fbdev/pxa3xx-gcu.c

ie this is broken because it allocates like this:

        priv = devm_kzalloc(dev, sizeof(struct pxa3xx_gcu_priv), GFP_KERNEL);
        if (!priv)
                return -ENOMEM;

And free's via devm:


static int pxa3xx_gcu_remove(struct platform_device *pdev)
{
        struct pxa3xx_gcu_priv *priv = platform_get_drvdata(pdev);

        misc_deregister(&priv->misc_dev);
        return 0;
}

But this will UAF if it races fops open with misc_desregister.

Proper use of cdevs with proper struct devices prevent this bug.

> You mention "placed in a static array", are you seeing a potential lifetime
> issue or what? Many of the examples above embed miscdevice in a dynamically
> allocated object also.
> 
> The file object's private_data holds a pointer to the miscdevice, and
> fops_get() pins the module. So freeing the objects miscdevice is embedded in
> at module_exit time should be fine. But, as you said, in this case the
> miscdevices are statically allocated, so that shouldn't be an issue
> either.

Correct, it is OK here because the module refcounts prevent the
miscdevice memory from being freed, the above cases with dynamic
allocations do not have that protection and are wrong.

This is why I don't care for the pattern of putting misc devices
inside other structs, it suggests this is perhaps generally safe but
it is not.

> I think using cdev_add ends up in the same results in device_* api
> sense.

Nope, everything works right once you use cdev_device_add on a
properly registered struct device.

> miscdevice acting like a mux at a higher abstraction level simplifies the
> code.

It does avoid the extra struct device, but at the cost of broken
memory lifetime

Jason
