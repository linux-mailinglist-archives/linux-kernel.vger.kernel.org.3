Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61234F72B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbiDGDMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiDGDMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:12:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A4B227C58;
        Wed,  6 Apr 2022 20:10:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l7so2665674ejn.2;
        Wed, 06 Apr 2022 20:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6G3zddOtH8eyIxvQmfflWw1/4QptoCpMZ2g0zuWQJE4=;
        b=nsb1zr3FcdGj2BTMPaxGW4jXWziAfDjqWTGNOM/ere5rA+I7OedBX9FN9atCOecIGt
         pcRc2c5DFkGY8a6Ik0Uh5YRSD4muI4yDahqMHXN5KbWzCAWmeGpNXHAapwijgrzbh/up
         +0DkhUUKfgYpP2iDFI/+qEhD+4SYlRQ9Iff104cFNNsllrvGRgvhnYlQ9OJPxOkLf9zR
         lYKVizquQRl/Ex5NNdnNtZPZBiSOdRXGpOpTFGT+1vYsPK1wDGbaha2BYIqt7p6Odlsj
         onYQ4aCvJg47l+RjUblnRAhl0N9pEIqc2hcZYeb9ah2tbLPodebxcFdTGLUaTi9mqnfa
         KsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6G3zddOtH8eyIxvQmfflWw1/4QptoCpMZ2g0zuWQJE4=;
        b=8O+Rsf1118BbJCg+TdNedraZdvCMfz9ORYGvuaRsPJk7Mt0SaPjAtvLqjYwF3BJz4y
         pnweLzvxNpfagM2cIVn+H4zA2Jhqye6VOl+jPnGwfydqykXm1Lhb5TbJDTMGVz7f3gMU
         asIDCOWg47tB13aQnQMKXpYSHOh42D5TuMAiDMLG5eaufpjiiUH7ag2Q0CT73048K1bM
         yZnMZIC1LaLj38yp8Qlb6bwz/CL1FzghxXhhzd/BUWV7HmsW7sE0gN2IclpyldWQdhkr
         1UhRojzYAyAKgk/sggmYnx+nggFDdKraT2TQ1D/tT0e6qEicg5bCUv28eGh6Pf4boYfa
         dPHQ==
X-Gm-Message-State: AOAM532vYDlsQd/q3pQrZEdeHGXU0V9PS595Ql7ye1PQEq68KglBC1BJ
        HI0czn8wciAVA0chFizaA1MFAVcqg0HLPmdzMEk=
X-Google-Smtp-Source: ABdhPJxI9ltkUnnn2XwyGKwQSgLHlnE+U25/ZiqM/ZnUB51X94ZZgD8fddLhu8IXGk5t/J2oDvKOAQMOqIcgdVtZyC0=
X-Received: by 2002:a17:906:3a15:b0:6cf:ea4e:a1cc with SMTP id
 z21-20020a1709063a1500b006cfea4ea1ccmr11755209eje.753.1649301007335; Wed, 06
 Apr 2022 20:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220407024001.11761-1-hbh25y@gmail.com>
In-Reply-To: <20220407024001.11761-1-hbh25y@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 7 Apr 2022 11:09:41 +0800
Message-ID: <CAD-N9QV27nJW=_goZKB0666Nq1pNphbgoHeYn_FmSkkJh9vyKg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: misc: fix improper handling of refcount in uss720_probe()
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 10:40 AM Hangyu Hua <hbh25y@gmail.com> wrote:
>
> usb_put_dev shouldn't be called when uss720_probe succeeds because of
> priv->usbdev. At the same time, priv->usbdev shouldn't be set to NULL
> before destroy_priv in uss720_disconnect because usb_put_dev is in
> destroy_priv.
>
> Fix this by moving priv->usbdev = NULL after usb_put_dev.

Hi Hangyu,

good catch as priv->usbdev is still used after the probe function.

I agree with this patch.

Reviewed-by: Dongliang Mu <mudongliangabcd@gmail.com>

>
> Fixes: dcb4b8ad6a44 ("misc/uss720: fix memory leak in uss720_probe")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>
> v2: fix a stupid UAF in the previous version.
>
>  drivers/usb/misc/uss720.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
> index 748139d26263..0be8efcda15d 100644
> --- a/drivers/usb/misc/uss720.c
> +++ b/drivers/usb/misc/uss720.c
> @@ -71,6 +71,7 @@ static void destroy_priv(struct kref *kref)
>
>         dev_dbg(&priv->usbdev->dev, "destroying priv datastructure\n");
>         usb_put_dev(priv->usbdev);
> +       priv->usbdev = NULL;
>         kfree(priv);
>  }
>
> @@ -736,7 +737,6 @@ static int uss720_probe(struct usb_interface *intf,
>         parport_announce_port(pp);
>
>         usb_set_intfdata(intf, pp);
> -       usb_put_dev(usbdev);
>         return 0;
>
>  probe_abort:
> @@ -754,7 +754,6 @@ static void uss720_disconnect(struct usb_interface *intf)
>         usb_set_intfdata(intf, NULL);
>         if (pp) {
>                 priv = pp->private_data;
> -               priv->usbdev = NULL;
>                 priv->pp = NULL;
>                 dev_dbg(&intf->dev, "parport_remove_port\n");
>                 parport_remove_port(pp);
> --
> 2.25.1
>
