Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735CF4DC88A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiCQORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiCQORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:17:00 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17461FF23A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:15:42 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 13so4273365qvq.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ERYHSpe1+FU1IDWhLgLoQAdxEsWkuy46KP5iCR1Nx+g=;
        b=FdQQ96Mh3YSy+Of2eEjk1Rnqy3rZvWFhpdup4t6PrzMoUZseo/plcyKlTZ+Mw1LdUZ
         fQQg8Xw4s5gs23P5Pyh81GiHafAUeT/0CHxLAeaAMztrcfP6Vc8Wzpk7O2GguaOYtsHt
         yLxunmA6pswpUg/WCr77cdsJOFUknVOjpBfBmYvrg6FUgHJrhVVafP6QYFWIkQbqlbw0
         /dSlC49HGv4+RtzFTA/p8sl5knXRdiG/zxvo6mvfrgF5euYrlWm5whfoPA/F7wENWglD
         s6eiAkUFEit7htOtINT6yp7iE08qEAVugCJdbBvqJ/EAMH82OwaVhw5z3QdxPaJZCii/
         yJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ERYHSpe1+FU1IDWhLgLoQAdxEsWkuy46KP5iCR1Nx+g=;
        b=hX+e0QHG9+Nvo7dJX003MsCpp19JHzj5Jk6xAdJGC8HiP6K80kFt7jECwhCoQqL6ai
         4TY27E7Cj0UbroHXklfhqWlOAVmVVwirYF2taPdBCJjvLk7wuCQRqGnmSrhlpLX9ktoA
         DSOgaRdOSU7IXJmqNImiDidwJMFi5dnBt4CylD0k7ju5b7N1AaXwqyADBY/mkTJQJnKk
         KDeEsNyHwV+qaC7t2kLtQn3CI1gaQYOg9gjxwOcv0fP6wUEYP+BV6+9qWIkxT1IQIdHv
         o/qdbXIrrUp35jeCe/0x7vz8EizNtL9T2NxWtnG2sCKLv7p/91YSNCfLrH4IsjQHwNqc
         bPnA==
X-Gm-Message-State: AOAM531kL+1HlGjnsULxdOhGWFzRBSZApy0lhcY8tJSNiprdr1Np9fzd
        9bhcxRKV2fQCpyVIsZMoMhTIZSzZg3iQOA==
X-Google-Smtp-Source: ABdhPJzDaxqCpSNI0Z7pJR6AfVQtHqwyxvpCBKzwLxqFvxFcKV2fKmmPyrZTM8f/tQAk9iCZ+Yq6Qg==
X-Received: by 2002:ad4:5f8f:0:b0:435:9505:b243 with SMTP id jp15-20020ad45f8f000000b004359505b243mr3388907qvb.18.1647526541819;
        Thu, 17 Mar 2022 07:15:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm3697547qtx.89.2022.03.17.07.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 07:15:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nUquh-001tXD-Q8; Thu, 17 Mar 2022 11:15:39 -0300
Date:   Thu, 17 Mar 2022 11:15:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Message-ID: <20220317141539.GD64706@ziepe.ca>
References: <20220311033050.22724-1-mpenttil@redhat.com>
 <20220314182439.GB64706@ziepe.ca>
 <d9b9c82e-4012-cf0a-d966-d9669a684a27@redhat.com>
 <20220315183922.GC64706@ziepe.ca>
 <8e836d75-97b0-d301-4d6a-92025e91cad5@redhat.com>
 <0f53c5ff-1711-861d-9a12-0634d4ab9fca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f53c5ff-1711-861d-9a12-0634d4ab9fca@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 08:58:52AM +0200, Mika Penttilä wrote:
> @@ -1225,7 +1232,11 @@ static int dmirror_device_init(struct dmirror_device
> *mdevice, int id)
> 
>         cdev_init(&mdevice->cdevice, &dmirror_fops);
>         mdevice->cdevice.owner = THIS_MODULE;
> -       ret = cdev_add(&mdevice->cdevice, dev, 1);
> +       device_initialize(&mdevice->device);
> +       dev_set_name(&mdevice->device, "%s", dmirror_device_names[id]);
> +       mdevice->device.devt = dev;
> +
> +       ret = cdev_device_add(&mdevice->cdevice, &mdevice->device);
>         if (ret)
>                 return ret;

Right, miscdev isn't that helpful in the end..

Jason 
