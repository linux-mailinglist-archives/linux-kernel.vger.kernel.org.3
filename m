Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB5E4C9D91
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiCBFpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiCBFpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:45:47 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C9559A56;
        Tue,  1 Mar 2022 21:45:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z15so931975pfe.7;
        Tue, 01 Mar 2022 21:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tohk2aT5d/PEXoglufun4n2w1nrJyfac6nbJ8qICq5Q=;
        b=QYya+4yAeYQWV7i8sPDYAAIsdsxbOT14DjzMlDQ4rOtjwZkFDZJPHurgCUw3mjXo5y
         IeEe3XJyhY0xCKtyrSGgKsqLtlq75yH9ZNiN/Lr+e74kw/nluaHSZ1OJmCvbGaK+6/kg
         Ig390Hx768kI53+RwYlmY8e8WABB+Cg+LTsR/CfETs1GyzUnfk2DYivUwmrirYmZLZw7
         b900lkJNZzZ88g0Hxs23svKB4y0zpCQUdsu6recCXAYTQkfz4+wPRTNxbyDY8Yn+FO9S
         bKowStt6mi+6k61rPoKL9umkfxHGWPt2X/dGCMDjpYi3SSie62ssh0Ozl0ZCE1nnAIdT
         7ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tohk2aT5d/PEXoglufun4n2w1nrJyfac6nbJ8qICq5Q=;
        b=o1bDsoz2arO5FU2NOAqkWvbflnA70UE4EuUelW0nE287YtBwgmhJg9JDutLaAFGzey
         hKBHNVMyBQeNq9NWufMl1VrZFIvvEvrTHw7PY4PxFhnKxgi+TcW5CZ+hA/+i88rC8t4F
         xvIrWyGBlVdCoEVfGXp9Yc7kRGwegrIJMTZvMlTY16kkgLkMKG0yuwJZP7FFppOQ4NM8
         Aaa5qF4nSCLoCxA/Y3X1N8Bi1A4QhdObE7W/vBUG6jaVtq84otbRMA9kdxQoPXS1WA15
         17PegeBVehFSjZUTpNAXbDFaclKIh2BwnJUiOtn7tB/s2CAjT8EV40E5DB+y/8yCPCP9
         spig==
X-Gm-Message-State: AOAM5331KdbkwPLc0rfPY+3FJFNkKWNQzk8cyzlZmMWJQrBfn+CGpeFO
        gy8MzIy7Z17WrVNfcT+Rx+o=
X-Google-Smtp-Source: ABdhPJxY7/+36xcLRk2VrCnkd4waYYinZtr37DiqqpvHFdAeVd093oK66Kc83DvYun1BC57Ay/QByg==
X-Received: by 2002:a05:6a00:d4c:b0:4e0:27dd:37c1 with SMTP id n12-20020a056a000d4c00b004e027dd37c1mr31609928pfv.86.1646199904547;
        Tue, 01 Mar 2022 21:45:04 -0800 (PST)
Received: from VICKYMQLIN-NB1.localdomain ([5.44.249.43])
        by smtp.gmail.com with ESMTPSA id o17-20020a056a0015d100b004e1c11d833fsm20237289pfu.90.2022.03.01.21.45.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Mar 2022 21:45:04 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:44:57 +0800
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Eugen.Hristev@microchip.com
Cc:     mchehab@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: atmel: atmel-isc: Fix PM disable depth
 imbalance in atmel_isc_probe
Message-ID: <20220302054457.GA1088@VICKYMQLIN-NB1.localdomain>
References: <20220105111056.4662-1-linmq006@gmail.com>
 <20220301071859.24285-1-linmq006@gmail.com>
 <4661c8c3-8975-d1f5-9728-f7d1d585437e@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4661c8c3-8975-d1f5-9728-f7d1d585437e@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 01:51:02PM +0000, Eugen.Hristev@microchip.com wrote:
> > ---
> > changes in v2:
> > - remove unused label.
> > ---
> >   drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> > index 1b2063cce0f7..7f1ebbb25437 100644
> > --- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> > +++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> > @@ -559,6 +559,8 @@ static int atmel_isc_probe(struct platform_device *pdev)
> >   cleanup_subdev:
> >          isc_subdev_cleanup(isc);
> > 
> > +       pm_runtime_disable(dev);
> > +
> 
> Hello Miaoqian Lin ,
> 
> Could you please perform the same change (or similar) in 
> atmel-sama7g5-isc , as the sama7g5 ISC will perform the same and has the 
> same bug.
> 
Hi, Eugen Hristev:

I think you are referring to microchip_xisc_probe() function in
atmel-sama7g5-isc, and I have look into it. After it calls
pm_runtime_enable(), it only have a regular path whichs return 0 and
indicates
the probe is successful. It doesn't have error handling path.

regmap_read() function returns a negative errno in error cases, but it
is used to get Microchip XISC version. I am not sure if failure means
the probe fails.
> >   unregister_v4l2_device:
> >          v4l2_device_unregister(&isc->v4l2_dev);
> > 
> > --
> > 2.17.1
> > 
> 
