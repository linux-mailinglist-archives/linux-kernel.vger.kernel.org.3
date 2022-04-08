Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692584F8CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiDHDJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiDHDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97E2716F6CE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649387237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0mJcdW33+4gW1LiIaHWfczE7pJzHwlPUBk+4IAUF7M4=;
        b=gqHpKxRwq6UtNddJ06/44SwEKfh0B+TVU6300XcPF6W4i9kkbzRN9OfHQWkJUEIXwX6Em+
        74gOqgpeBzYcqr72TX+5yqpRC2XinL9ckQ3h+7kgnKLDf49xT0TyhyweDA9jrtbno9gMnN
        jMrpi01htjSbTqHETgn+MHsOGDdw2c0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-HKd9LzoOO8WTxtthrmgnrw-1; Thu, 07 Apr 2022 23:07:16 -0400
X-MC-Unique: HKd9LzoOO8WTxtthrmgnrw-1
Received: by mail-lf1-f70.google.com with SMTP id g6-20020a19ac06000000b00464f8022af9so1217327lfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 20:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mJcdW33+4gW1LiIaHWfczE7pJzHwlPUBk+4IAUF7M4=;
        b=NALQ4XjfVCPoAvGLOgzGB2xMdPwXo4fkGezDl0difSr9m6PesrZb7BGPmDwBWkTc/t
         TiAjFvMZPHjFgicd05l8UPfoZE9GCW9S5VnLiDeXYWv7bdA9F9I062z/Ifa2laQ+hSRx
         uACMl6DxvcsY55KEHEBlC0HIobUOUv379VndHshoRpci1xox3uBrwhgFLqsZuc0aMTzL
         02sUTEv96QfDryrq5YOacWWP242OpXisjXLxEIowRkgLilX8mSW/Wzj4AB2KXkHcusSq
         tOlDSTQpVvNuzmeh741X0DaS7G93YDqUxMi02ULuX5eGWa+K03sddN5UK3xxHiIeTlvY
         0L3Q==
X-Gm-Message-State: AOAM531+Pbr02OLphYBasAhlmEYzsqf3lquDhO2J3M72IYcKdS1s14EF
        /GLO/Nkvqmih/m9CHtNjldhCj8g8mnpkjYEHWDGUhJ4BP2V9Xii7dYBccyWtpbf4dQy5lHl39RL
        7jNy6GcvU4cjVrmU9WzN3siuxPEoW7p4ZvjmvHGJU
X-Received: by 2002:a05:6512:2586:b0:464:f75d:cfa with SMTP id bf6-20020a056512258600b00464f75d0cfamr3611241lfb.238.1649387234430;
        Thu, 07 Apr 2022 20:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgWwR3JIJz3D/8EgFkxuxkKo6iHijAl6dM7d1piH5tYY9YCkT5VihT277zbKJtx38DQE/DkghzZddgd4OX378=
X-Received: by 2002:a05:6512:2586:b0:464:f75d:cfa with SMTP id
 bf6-20020a056512258600b00464f75d0cfamr3611224lfb.238.1649387234117; Thu, 07
 Apr 2022 20:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220407105724.308930-1-hpa@redhat.com> <20220407115133.GL3293@kadam>
 <CAEth8oG_GAuammtSqKzyj+Vq6ZsQJJOEeFhgxYhxXHViDYvkow@mail.gmail.com> <20220407132609.GN3293@kadam>
In-Reply-To: <20220407132609.GN3293@kadam>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Fri, 8 Apr 2022 11:07:03 +0800
Message-ID: <CAEth8oHqqipXNR6QPgm_YNGPVBSZLm3EEg0k0M9tivFCwE5_2Q@mail.gmail.com>
Subject: Re: [PATCH v2] staging: media: ipu3: Fix AWB x_start position when
 rightmost stripe is used
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hans De Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Apr 7, 2022 at 9:27 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Apr 07, 2022 at 09:17:38PM +0800, Kate Hsuan wrote:
> > Hi Dan,
> >
> > On Thu, Apr 7, 2022 at 7:52 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Thu, Apr 07, 2022 at 06:57:24PM +0800, Kate Hsuan wrote:
> > > > A not calibrated x_start setting would result in an incorrect AWB location
> > > > configuration on a sensor when only the rightmost stripe is used. x_start
> > > > should be calibrated by subtracting the stripe offset to set the coordinate
> > > > to the correct position on the second stripe.
> > > >
> >
> > >
> > > I wish the commit description said more about what the bug looks like to
> > > the user.  This is the front facing camera, right?  Is part of the video
> > > blank or what's the deal?
> >
> > This is IPU3 image processor. I tried to fix the configuration issues
> > on stripe 1 coordinate settings.
> >
>
> So in terms of users, if you configure it in a certain way then it
> crashes?  What happens in terms of what the ordinary user sees?
>

It will not crash. Currently, application, such as libcamara only uses
stripe 0 to estimate 3A (AE AWB AF). The grid coordinate can be used
to determine the area on a sensor where we use this area to determine
the 3A status. If we start to move the grid and it crosses the stripe
1 offset. The grid will be at the rightmost edge of the sensor. The
user may only feel the location of AF, AWB, AE of the image is not the
user's expectation.

I'll update them in the v3 patch.

> regards,
> dan carpenter
>


-- 
BR,
Kate

