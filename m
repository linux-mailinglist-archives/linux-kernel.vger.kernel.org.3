Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF64C4D02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiBYR42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiBYR4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:56:25 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F642399EF;
        Fri, 25 Feb 2022 09:55:53 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2d646fffcc2so42093377b3.4;
        Fri, 25 Feb 2022 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARW/8wYeL9NnYtTyW8vKBNuProdpU0uaVTh1REnUsFc=;
        b=TH8gobN/Ow5yp88DQxDjRnsCJHmspygnFoJ7ZIuN9mXyLXdDm0/SmrjDJgsp6dN6cT
         z/AcU9klYwdX1O2WF5a8muV28NrFLUnB9oNepAv61ZoMEdy+i9cHGMufQ4NNkWAWpzoG
         SRVWmfSe3vVhtOlm3z2+O5BUkcu/+nlXXU9Mqp4n6df4b2xw0TURloaFDZa8FawY+m5u
         Cdds1HoH+OCPvDGIg6zXzyedh20/b3Wcmtr4LP8yRYx+A59WTZ6omENs+VlL5Iciv1Jr
         BWZ55d9iaBF5YsUz6ofxNSAUWcHa4zz9CzoEwXX08cPeYhpsMoSeAlG+GYFVoLLOBIDK
         XI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARW/8wYeL9NnYtTyW8vKBNuProdpU0uaVTh1REnUsFc=;
        b=0eI8V83zabx6YAJ4mf5o+66aajMDutsJZ89dxgIqilXxVGCsvNhtV+S3D8E74e+xRz
         gsJ0DvuDQS7eLDEJfAnAPmTSvFyQMTTTWam2Hsqvof6Dg+4MqHjv4XQyJV3uhcO2bwl1
         r7s8eMZR6dRLutwtgJXtgKiZCqXdOHK5PjnUSManPJgLzniV7KxkBb6pUniqT4Wj2G/v
         WkdDKx+c013lAEG6O5+o/SbehWBH8GkNHX+N4ueevRbcY5ueafNzw6tfm71MNdbMRO2L
         VL7Hb7YI059EhLhKtE1N1oDiipgU/HlfHpcVuNiEXWozwVH43kIn2QitXl2W/kjJUbFe
         3Tsw==
X-Gm-Message-State: AOAM532BC0Daok5N48vJ/o973Dq76H1CtVprz8M4rtN2594LFtV46AQR
        k+UhMX/IzJzojroD3o/xzp+suw83yFonqtxh0oQ=
X-Google-Smtp-Source: ABdhPJzbhRYtduGB0jyQirTuOrvJTlsVp6G8VDz4JZYxg4CjXJpZ/0WaVTeKVHC68DqMnfsZs5+heai0OwdIkKYMM6I=
X-Received: by 2002:a81:1613:0:b0:2d7:c68f:bf21 with SMTP id
 19-20020a811613000000b002d7c68fbf21mr8804810yww.414.1645811752158; Fri, 25
 Feb 2022 09:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20220225145432.422130-1-pgwipeout@gmail.com> <20220225145432.422130-7-pgwipeout@gmail.com>
 <76abe7a9-4e75-b91d-8428-a4df1f6d97b1@wolfvision.net>
In-Reply-To: <76abe7a9-4e75-b91d-8428-a4df1f6d97b1@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 25 Feb 2022 12:55:41 -0500
Message-ID: <CAMdYzYpdd3-rOeG15dsDt7W1+AkSLJSQe18StjLtG8jzuKeajA@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] usb: dwc3: add rk3568 dwc3 support
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Feb 25, 2022 at 12:08 PM Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Peter,
>
> On 2/25/22 15:54, Peter Geis wrote:
> > The rk3568 dwc3 controller is backwards compatible with the rk3399 dwc3
> > controller.
> > Add support for it to the dwc3-of-simple driver.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  drivers/usb/dwc3/dwc3-of-simple.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> > index 9dc6295df6b1..1d52a261af55 100644
> > --- a/drivers/usb/dwc3/dwc3-of-simple.c
> > +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> > @@ -49,7 +49,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
> >        * Some controllers need to toggle the usb3-otg reset before trying to
> >        * initialize the PHY, otherwise the PHY times out.
> >        */
> > -     if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
> > +     if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") |
> > +         of_device_is_compatible(np, "rockchip,rk3568-dwc3"))
> >               simple->need_reset = true;
>
> Maybe read this value out the match data...

This is a good idea, thanks!

>
> >       simple->resets = of_reset_control_array_get(np, false, true,
> > @@ -176,6 +177,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
> >       { .compatible = "hisilicon,hi3670-dwc3" },
> >       { .compatible = "intel,keembay-dwc3" },
> >       { .compatible = "rockchip,rk3399-dwc3" },
> > +     { .compatible = "rockchip,rk3568-dwc3" },
>
> ... so all future variants that are compatible to the rk3399 can share it?
>
> Best regards,
> Michael
>
> >       { .compatible = "sprd,sc9860-dwc3" },
> >       { /* Sentinel */ }
> >  };
