Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625E54D2DB8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiCILPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiCILPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:15:33 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51B13CA1E;
        Wed,  9 Mar 2022 03:14:35 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2db569555d6so18335637b3.12;
        Wed, 09 Mar 2022 03:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXHpYkfJW7jBmBNFMclcDkzdMin2P6Ml1MYW+332E1w=;
        b=hCifVydiTw930qv1RnwhpicXVtyNfJX3L0JcvqeHGT4zAbaeDHC05bPp14Ucipa/9Z
         7TWxC/4jFKXSMlayYn72i6rl642q8jdQXDMb+UhaJFs0n91q3kvZ5xtTj5pP5SU/3KHE
         6S/XSouo4M6Q3+HIhCtc7D+QVrZ9iPhHeP3p/JklUoAKcA1C69DU7B0sAfOp975IMP30
         VcDTQpPD7EPmWZQOehMhZJpfMug+rsZrvsvSUJ9ZrJ7WJAAIIsLTfaRKbNtzQZRCTMdk
         +itPmRqtgqselTM1A+orPlMmZ/OjMyNlWfhTyIXvj9XN9dkM5uCwgM2u25VRuYotyPyk
         fFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXHpYkfJW7jBmBNFMclcDkzdMin2P6Ml1MYW+332E1w=;
        b=2+1yjzvZ2r9i1LVChPWowfrl7s/CcRW0nt0YvN6EZJS/WceU1bKDQXrlBoHN98sqpP
         SYNAtAYwV5SaLlSEMspxILQNs81nekY0b7WG8LeCWdKxR6jdtO8jAe/FjMf38qneD3eR
         gmV1w4g4KsZKgBykNnMCT/zMipOQLPeufOnUW/JNFHys+wgiTvzJRNW5Eh0rMLOu4441
         Z9WlAJpJH0bWYYuzSLpKs9aXTbXyvDjvTlF2jNeI8forMwiVXghlrynNSKeXNCrdRgDJ
         NsTJEtptxuq78FhceYnSr94/IWq08TItSOgLNL0G1s+GJs818WqGrF8QQLOYU2fkOZ9U
         aDZg==
X-Gm-Message-State: AOAM5321PalMrgBE0R33yoG/CWbb/e6wXhkQTBJ081TNATlNZAbOffyH
        ncQazkMLNVPFpU3ra5qQd9nay7doCOOywly2o+kQk+lupYaK8w==
X-Google-Smtp-Source: ABdhPJzJgbD/NnoXwaG2bLoYsUbVfrLNI4gaym16qCRCsmDbE8UKEgc4grL76evfdhzUk62srwcPvygXdM/ogqvYwcU=
X-Received: by 2002:a81:2f12:0:b0:2d7:d366:164a with SMTP id
 v18-20020a812f12000000b002d7d366164amr17064120ywv.265.1646824473797; Wed, 09
 Mar 2022 03:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20220309035648.2080945-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220309035648.2080945-1-chi.minghao@zte.com.cn>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 9 Mar 2022 11:14:07 +0000
Message-ID: <CA+V-a8tZaOYxr32Hn43N6GNBR0kx856j_fcRYOhwCRPjkituTA@mail.gmail.com>
Subject: Re: [PATCH] media:davinci:vpbe_display: Use platform_get_irq() to get
 the interrupt
To:     cgel.zte@gmail.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

Hi Minghao,

Thank you for the patch.

On Wed, Mar 9, 2022 at 3:56 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
>
> It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
> for requesting IRQ's resources any more, as they can be not ready yet in
> case of DT-booting.
>
> platform_get_irq() instead is a recommended way for getting IRQ even if
> it was not retrieved earlier.
>
> It also makes code simpler because we're getting "int" value right away
> and no conversion from resource to int is required.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>  drivers/media/platform/davinci/vpbe_display.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
NAK, vpbe_display driver doesn't use DT.

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
> index bf3c3e76b921..e0aabcb333ac 100644
> --- a/drivers/media/platform/davinci/vpbe_display.c
> +++ b/drivers/media/platform/davinci/vpbe_display.c
> @@ -1363,7 +1363,6 @@ static int vpbe_display_probe(struct platform_device *pdev)
>  {
>         struct vpbe_display *disp_dev;
>         struct v4l2_device *v4l2_dev;
> -       struct resource *res = NULL;
>         struct vb2_queue *q;
>         int k;
>         int i;
> @@ -1405,14 +1404,13 @@ static int vpbe_display_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -       if (!res) {
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
>                 v4l2_err(v4l2_dev, "Unable to get VENC interrupt resource\n");
>                 err = -ENODEV;
>                 goto probe_out;
>         }
>
> -       irq = res->start;
>         err = devm_request_irq(&pdev->dev, irq, venc_isr, 0,
>                                VPBE_DISPLAY_DRIVER, disp_dev);
>         if (err) {
> --
> 2.25.1
>
