Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B2050CB85
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiDWPFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiDWPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:05:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E8F1759F8;
        Sat, 23 Apr 2022 08:02:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p189so6715701wmp.3;
        Sat, 23 Apr 2022 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AOe0YWTIxO20z66gzbsK5tfpgnik6/90iVqeOl0gU2Q=;
        b=WxD1riBOilQjVngzpg58exa20G16bL/OmpWTeWKaZhrqqc8nZgIXu57O0M5wBhb/g5
         VInT1OZtuDadKJIsq3H+DlUbxeceqHOkvfbJIzAbip9UQG5XzNDauAVR5Z3aF6rnhFfy
         acsYW35wzXA9d7ErCVw+T+yB3eYoJ0ZpY/oDFWyFMIDj5iGx/AmpFp/AJz+Ry8HBPpEh
         JqfzT62s4DBdX6MMmDGzSfHsmJTShurRUvSfSfyOPq5vFr9OOwc3gYGPkTaM7GXMuGWI
         0S3EVGP2OOnFXBksrGFrs/fyfP8uDqATgGlX49YI1AuP1F2xPBSd9C5LTWR/6JhCohGJ
         VMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AOe0YWTIxO20z66gzbsK5tfpgnik6/90iVqeOl0gU2Q=;
        b=pJzlVsj8iKwc1J1MCt8Jhmnch65gKLwjxpt2DXHBfQi4pricvdAQj3x57b8tszVmtt
         WOGUP5CgLy9eGv4uO4NRbvF92DtVuBog9gr7il+NuO0LoYJIV1VQDppuiyDROuQR7W6V
         C6wom6V8jSUykuMnaToC3YUJpnDZcTaqWzI/LnqphANHAptOL07xksmSPFpTasr2TRGR
         wZKdrY6yq74g3qrVaicqqLJMoSF3ajTgvabNJ57w6W0jdhipp6ByvRhQRyZ4fo/L2m20
         JmC9Xy2yLfPYQWaI6NRAbs2NxWjYGYoNQjRUC9nB/hh5O4YqFOFhhuSkNuUoGE46GPOu
         x5cQ==
X-Gm-Message-State: AOAM532HjaqTZ6256gxQjRQ+P+jZVQq7m22dHJhnj5jYJa4C+SW6hlvr
        kuCOfxm5uYygOWWqFkks+8A=
X-Google-Smtp-Source: ABdhPJzNuXFZIXG5ipXuEP2C/qhRymV/7TFGNq1TDlgw6SwbNK3ZVwdsWiutIp4TRHeJSM5AFCxADA==
X-Received: by 2002:a1c:6a02:0:b0:38b:3661:47f1 with SMTP id f2-20020a1c6a02000000b0038b366147f1mr8794342wmc.5.1650726138642;
        Sat, 23 Apr 2022 08:02:18 -0700 (PDT)
Received: from elementary ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm6969222wms.44.2022.04.23.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:02:18 -0700 (PDT)
Date:   Sat, 23 Apr 2022 17:02:12 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     hadess@hadess.net, dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        lains@riseup.net, jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] HID: logitech-hidpp: Fix double free on managed
 resource
Message-ID: <20220423150212.GA6661@elementary>
References: <20220422161709.30198-1-jose.exposito89@gmail.com>
 <20220422161709.30198-2-jose.exposito89@gmail.com>
 <876f7c92-4e50-401e-f0b0-c2942bd8b63d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <876f7c92-4e50-401e-f0b0-c2942bd8b63d@redhat.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 01:41:30PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/22/22 18:17, José Expósito wrote:
> > As described in the documentation for devm_input_allocate_device():
> > 
> >   Managed input devices do not need to be explicitly unregistered or
> >   freed as it will be done automatically when owner device unbinds from
> >   its driver (or binding fails).
> > 
> > However this driver was explicitly freeing the input device, allocated
> > using devm_input_allocate_device() through hidpp_allocate_input().
> > 
> > Remove the call to input_free_device() to avoid a possible double free
> > error.
> 
> Actually calling input_free_device() on a devm allocated input device
> is fine. The input subsystem has chosen to not have a
> separate devm_input_free_device(), instead input_free_device() knows
> if a device is allocated through devm and then also frees the devres
> tied to it:
> 
> void input_free_device(struct input_dev *dev)
> {
>         if (dev) {
>                 if (dev->devres_managed)
>                         WARN_ON(devres_destroy(dev->dev.parent,
>                                                 devm_input_device_release,
>                                                 devm_input_device_match,
>                                                 dev));
>                 input_put_device(dev);
>         }
> }

Hi Hans, 

Thanks for the code review.

Obviously, I completely misunderstood these functions, my bad.
Thanks for the explanation.

Please ignore the patchset.

Jose

> > 
> > Fixes: c39e3d5fc9dd3 ("HID: logitech-hidpp: late bind the input device on wireless connection")
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > index 81de88ab2ecc..9c00a781ab57 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -3957,11 +3957,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
> >  	}
> >  
> >  	hidpp_populate_input(hidpp, input);
> > -
> > -	ret = input_register_device(input);
> > -	if (ret)
> > -		input_free_device(input);
> > -
> 
> The original code does look wrong there though, since the input device
> is free-ed it should not be stored in hidpp->delayed_input, so this should be comes:
> 
> 	ret = input_register_device(input);
> 	if (ret) {
> 		input_free_device(input);
> 		return;
> 	}
> 
> 
> Regards,
> 
> Hans
> 
> 
> >  	hidpp->delayed_input = input;
> >  }
> >  
> 
> 
