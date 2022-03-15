Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD19B4D9A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347742AbiCOLR3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Mar 2022 07:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbiCOLRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:17:25 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C14F9C8;
        Tue, 15 Mar 2022 04:16:13 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id z7so21756558iom.1;
        Tue, 15 Mar 2022 04:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SHSnS045xOSqGUGYNxZz1bWOxpfWFGxEnCoZhA82baU=;
        b=3xfAtRGVXGHBLcX8+Mh3vpAwuXjYGkfopVBc94KvSfP1NcrqbaNyJONef7m4+N3OTa
         Z/RBOIL/EByyETatpL+pIGDsVci3FDg/MYfjaxD/cpZgP8ar0H8kha8UPTUM0YuTDPHo
         s2Xu5joW7JFZyCarbf9WRHfelFqXUZvsNc28V/fr5aozX3WaU8lxVVQ0OhVzd/zb42CS
         algVk6Efq9iLkA1ef6Rid82tfEYq8GyZ2FS7JNPDXG2ngMgRdvsm8mj/gDEiUwBz8CfU
         aCpFW8mcJ7hZxOlwSdVawraDJWtJJ/zVyucC6aUBBkZ+3rH6HiI150mscwzYT+BCIF9M
         dXfQ==
X-Gm-Message-State: AOAM5323WclRKWTa32v4CxUyaxpyDnSYjYBKAbRS0Yzy4r7sSNo9lrH5
        dYtV8uxWvHyg1EwPXxh4VLVlgtTiZdZTwWl2yTM=
X-Google-Smtp-Source: ABdhPJzi1K37T2uO44ZNsKuw/g+YHc0BL3RHRsR2lKGCgz1cR7gvf6hv3h3YACkfVRqhb8e8u22W4O3QZKPWM+TnQcw=
X-Received: by 2002:a02:aa05:0:b0:315:40b9:7439 with SMTP id
 r5-20020a02aa05000000b0031540b97439mr24177076jam.131.1647342972700; Tue, 15
 Mar 2022 04:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220308123712.18613-1-andriy.shevchenko@linux.intel.com> <20220314195138.20036-1-michael@walle.cc>
In-Reply-To: <20220314195138.20036-1-michael@walle.cc>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Mar 2022 12:16:01 +0100
Message-ID: <CAJZ5v0hbY8XCC-DfkoPFe15awV_FOpq91pUZvmZ9JrYi1QBMEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 8:51 PM Michael Walle <michael@walle.cc> wrote:
>
> Hi Andy,
>
> > Some of the fwnode APIs might return an error pointer instead of NULL
> > or valid fwnode handle. The result of such API call may be considered
> > optional and hence the test for it is usually done in a form of
> >
> >       fwnode = fwnode_find_reference(...);
> >       if (IS_ERR(fwnode))
> >               ...error handling...
> >
> > Nevertheless the resulting fwnode may have bumped the reference count
> > and hence caller of the above API is obliged to call fwnode_handle_put().
> > Since fwnode may be not valid either as NULL or error pointer the check
> > has to be performed there. This approach uglifies the code and adds
> > a point of making a mistake, i.e. forgetting about error point case.
> >
> > To prevent this, allow an error pointer to be passed to the fwnode APIs.
> >
> > Fixes: 83b34afb6b79 ("device property: Introduce fwnode_find_reference()")
> > Reported-by: Nuno Sá <nuno.sa@analog.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Tested-by: Nuno Sá <nuno.sa@analog.com>
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Acked-by: Nuno Sá <nuno.sa@analog.com>
>
> This breaks SFP/phylink (using the lan966x switch) on my board. See below
> for more details.

I'm dropping this commit for the time being.

> [..]
>
> > @@ -480,15 +485,16 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
> >  {
> >       int ret;
> >
> > +     if (IS_ERR_OR_NULL(fwnode))
> > +             return -ENOENT;
> > +
> >       ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
> >                                nargs, index, args);
> > +     if (ret == 0)
>
> Should this be "if (ret == 0 || IS_ERR_OR_NULL(fwnode->secondary))" ?
>
> > +             return ret;
> >
> > -     if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
> > -         !IS_ERR_OR_NULL(fwnode->secondary))
> > -             ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
> > -                                      prop, nargs_prop, nargs, index, args);
> > -
> > -     return ret;
> > +     return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
> > +                               nargs, index, args);
> >  }
> >  EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
>
> What happens before this patch is that sfp_bus_find_fwnode() will call
> fwnode_property_get_reference_args() and the first calls return -ENOENT
> which sfp_bus_find_fwnode() will handle in a special way. After your
> patch, -EINVAL is returned, because fwnode_call_int_op() on
> fwnode->secondary is always called regardless of the return value of
> the original fwnode.
>
> -michael
