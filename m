Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8D5368E1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354826AbiE0WhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348700AbiE0WhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:37:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0070C62A13;
        Fri, 27 May 2022 15:37:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a13so5331127plh.6;
        Fri, 27 May 2022 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mTucJIAdTYoZ9+9FflOuOtffCw1Kf5R1Q78VOC2SxTM=;
        b=UlpD72C/pdaYe8g1qzMZnwicMnDDgsyyi77oCr60uzPBV2ybDM4soXRA3zxsK71Tv/
         +wfE6e7n/jzRoV73KZBBbKJ5ApIC1JxvVtbVpxHObNhCBLgbkRSa+WoKgp3KE+bYrpX9
         54vSmRWAyZy7EHp5pqr2YVwBD/j0+4I36h8wdb11SElXPILpMHNmwT8pR7Rg36q2eoKr
         Dw8cX5D1xrAFbFI92w8FT8ToJi6TbU3377aqlHi3+RhrZHNFpb+CjJWeU4PRRUe4a1ro
         5D0cIVO7n/XaRWBCGdM7ib3LQ9Mog13uQaZpaRfge3zyjyr+P3DFp6EowueA9x3EG0yD
         8UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTucJIAdTYoZ9+9FflOuOtffCw1Kf5R1Q78VOC2SxTM=;
        b=sZmqFMVE0hcLHfARWxrJRDc8nX0y1AsCeXEwMAl4wE3ExnBSZfamE+kmU+XKeFFrJE
         eRhr4IRVNXTRy2gih9viYYjuifwo/l6WNImrZGGC1IPN9zSlWVbpg+K4Kqi/8AwlbuoG
         b00TSbkMUrNvhMOFgVpIEBUBNhjZKUAZWXI3ihJ7jfJfPGE08dJ4i96Uejde/1PYzoro
         q4soJgQlTiczhVw2Fbj4FFoW65xjYf6YLfYWNYqXCB3iEBvW1vICCQNjb23f3RjtW7gN
         ahI6R/+syKIwFv25OfCHBkEHdhWs98Jy8eQ7hoboK4EHEOfyxmaqKDRZvni7qZivx/C+
         A3qw==
X-Gm-Message-State: AOAM530aQfu1ISA+Mb1tisJaeiPqPgrxzvn3OjVPG2f1dxo2Tb2LzszD
        BiPdkv1DVht1n3bLJrSklYA=
X-Google-Smtp-Source: ABdhPJzxI5awUQGI2bH48hM11x0FspvEDs0u+628RbozurSTcwFKJVHkFvrEznQCK3TL/22I8/YIWQ==
X-Received: by 2002:a17:902:6b03:b0:161:51d6:61b with SMTP id o3-20020a1709026b0300b0016151d6061bmr21052203plk.23.1653691038315;
        Fri, 27 May 2022 15:37:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:331d:9bef:6841:67a4])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090aab8900b001df82551cf2sm2076195pjq.44.2022.05.27.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 15:37:17 -0700 (PDT)
Date:   Fri, 27 May 2022 15:37:14 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-input@vger.kernel.org, Furquan Shaikh <furquan@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: cros_ec_keyb - handle x86
 detachable/convertible Chromebooks
Message-ID: <YpFSmsQ8hRM0cYG4@google.com>
References: <20220526231230.2805147-1-dmitry.torokhov@gmail.com>
 <20220526231230.2805147-2-dmitry.torokhov@gmail.com>
 <CAE-0n51CVEUF4knuSAK7RWACaUF3Fmi3jmMORZb1cVFyARnHTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51CVEUF4knuSAK7RWACaUF3Fmi3jmMORZb1cVFyARnHTw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 05:35:36PM -0400, Stephen Boyd wrote:
> Quoting Dmitry Torokhov (2022-05-26 16:12:30)
> > From: Furquan Shaikh <furquan@chromium.org>
> >
> > Some detachable/convertible x86 Chromebooks use EC buttons/switches
> > interface to signal volume up/down and other buttons. This configuration is
> > signalled via presence of GOOG0007 ACPI device. The main keyboard on such
> > Chromebooks is still using the standard 8042/atkbd combo.
> >
> > Signed-off-by: Furquan Shaikh <furquan@chromium.org>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> Two questions below.
> 
> >  drivers/input/keyboard/cros_ec_keyb.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> > index e8338b1c5776..c14136b733a9 100644
> > --- a/drivers/input/keyboard/cros_ec_keyb.c
> > +++ b/drivers/input/keyboard/cros_ec_keyb.c
> > @@ -677,14 +678,19 @@ static const struct attribute_group cros_ec_keyb_attr_group = {
> >
> >  static int cros_ec_keyb_probe(struct platform_device *pdev)
> >  {
> > -       struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
> > +       struct cros_ec_device *ec;
> >         struct device *dev = &pdev->dev;
> >         struct cros_ec_keyb *ckdev;
> >         bool buttons_switches_only = device_get_match_data(dev);
> >         int err;
> >
> > -       if (!dev->of_node)
> > -               return -ENODEV;
> > +       /*
> > +        * If the parent ec device has not been probed yet, defer the probe of
> > +        * this keyboard/button driver until later.
> > +        */
> > +       ec = dev_get_drvdata(pdev->dev.parent);
> 
> Does cros_ec populate the child node before setting the drvdata? Or in
> ACPI designs this device is created as a child of cros_ec before the
> driver probes?

Yes, ACPI "bus" gets scanned and all device objects are created
regardless of the driver presence and whether probe has completed or
not.

Thanks.

-- 
Dmitry
