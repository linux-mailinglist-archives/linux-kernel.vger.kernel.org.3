Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C979959EBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiHWTOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiHWTOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:14:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BAF123782
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:51:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h22so10974921qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UIzDP5vwti9FmU1AI9oaSSCd8EVdsxXrvtKhWPii6Ls=;
        b=n9EyyFTG/4qV8hBj/xZT7cxhDCcCzWUnXlR28oIo8BqRbO+yb4WdH3fOZBTkuSvL1W
         XThcrSdj/+NAkxDa8Uc2/svIiL8VWEik9zFt7182JEFTajKgOFWXVAE9EU03/VhoVTnX
         jrtysU+h9taVmG9fYTKKNqip/XsM03qFL9tLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UIzDP5vwti9FmU1AI9oaSSCd8EVdsxXrvtKhWPii6Ls=;
        b=0gtj9DqNOMNnQfZigeb8iHa8QPPqtQ5YeOKtXRIpypZaUxFFFDedGWDRfceXkAbxl+
         gpVeNSFxFlhSMQGI6RQfxp5PxN4d2ulJIjPBOXK1VQQPKJ4JXxcerYRTnPlcdwpm9br1
         5KsEmFsoUqEmYVGt7dJHoBeBANTR1B/zxk+5yTRjECHU6PwlJ5fDQOTqcD6UH985wz4e
         Sm8qZjfyZoacEji3AAj5QLJRYV+Nwmb+FJRJDl4tJBVyCNz0MRuDdkccu4tCPoYtaWXc
         8Arpq1AfdYsa6VNYwOYty9zCP8IIH91LBvhQFjh2OCQkwalwS71xMgZcqsuUOtRm2szg
         Wq2Q==
X-Gm-Message-State: ACgBeo0/yzF6HMiEJ/WBMM2T9lYjP+4hKWllCNlvflxsKKFaQMFJjfFQ
        +Nd+1ITM3pBfPBOwzoR0dj35ShgXqGN3BA51mizs3g==
X-Google-Smtp-Source: AA6agR730EhiRgym3AI3/b6SGv53XnXR1qB8rLkxcwKm55lfnHnwCeRBZkbhjbDTZoObhYPD5IgkvjoUGi8OhYwlX64=
X-Received: by 2002:a05:622a:15d6:b0:344:6a92:d8ca with SMTP id
 d22-20020a05622a15d600b003446a92d8camr20584786qty.540.1661277070554; Tue, 23
 Aug 2022 10:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-5-pmalani@chromium.org> <YwRbCvOy8WXUEphH@google.com>
In-Reply-To: <YwRbCvOy8WXUEphH@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 23 Aug 2022 10:50:58 -0700
Message-ID: <CACeCKaduPJuBqwnLbaaEfvxiVrJ0qmVkcWsvbDarCJi0u8-TBw@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/chrome: cros_ec_typec: Use Type-C driver data
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

Thanks for reviewing the series.

On Mon, Aug 22, 2022 at 9:43 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 7daf4207c11e..e3f75440030d 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -379,6 +379,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
> >               ret = cros_typec_parse_port_props(cap, fwnode, dev);
> >               if (ret < 0)
> >                       goto unregister_ports;
> > +             cap->driver_data = cros_port;
>
> Same as previous patch.  I would suggest to send it in later series.  For
> example, I have no knowledge to judge if `cap` is a correct place to save
> the driver data.
>
> For example, I'm wondering: is the `cap` "the Type-C port's driver"?

The Type-C framework uses [1] the cap->driver_data while creating the
port device.

That said, sure, I can resend patch 3 and 4 when I upload the alt mode series.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/usb/typec/class.c#L2098
