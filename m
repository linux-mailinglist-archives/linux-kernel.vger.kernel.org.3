Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539C0497C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbiAXJ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:59:53 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51508 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbiAXJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:59:51 -0500
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E80718E7;
        Mon, 24 Jan 2022 10:59:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643018390;
        bh=zikyjJ6eavrl7X8+8F5Jt2Gv2ZdrXPqzPkYSSY0eaaM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=C1rIlJzCSLnS5M5A30ZSdfU1RPxjQHqc6t/s0i6doKpmJw2aPJHM+3qHalmUZyW7+
         f1o/4+GoTVP0m+sFp2zPCpc8EdXDzEu1dqVzfM6LX8E3q19qSHE1GByycJsa67dTfj
         rcTQBXV5nXB9sUv6iBrFOF56riHPYFEIJVkVv9GY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220120081530.799399-1-nikita.yoush@cogentembedded.com>
References: <20220120081530.799399-1-nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH v2] media: vsp1: mask interrupts before enabling
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Date:   Mon, 24 Jan 2022 09:59:47 +0000
Message-ID: <164301838774.10801.3973367832884627893@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the v2,

Quoting Nikita Yushchenko (2022-01-20 08:15:30)
> VSP hardware could be used (e.g. by the bootloader) before driver load,
> and some interrupts could be left in enabled and pending state. In this
> case, setting up VSP interrupt handler without masking interrupts before
> causes interrupt handler to be immediately called (and crash due to null
> vsp->info dereference).
>=20
> Fix that by explicitly masking all interrupts before setting the interrupt
> handler. To do so, have to set the interrupt handler later, after hw
> revision is already detected and number of interrupts to mask gets
> known.
>=20
> Based on patch by Koji Matsuoka <koji.matsuoka.xm@renesas.com> included
> in the Renesas BSP kernel.
>=20
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
> v1: https://lore.kernel.org/all/20210926155356.23861-1-nikita.yoush@cogen=
tembedded.com/
> Changes since v1:
> - move interrupt masking to a dedicated routine
> - update comments and patch description
>=20
> > I think I would rather see the code to reset them done in
> > vsp1_reset_wpf(), rather than in probe directly as that is what we are
> > doing, and is I believe already in the call path.
>=20
> First, vsp1_reset_wpf() does not get called on driver early init.
>=20
> It is normally called from within vsp1_device_get() when device is powered
> on, but vsp1_probe() calls vsp1_device_get() when vsp1->info is not yet s=
et,
> and in this case call from vsp1_pm_runtime_resume() to vsp1_device_init()=
=20
> is skipped.

aha, I seem to have a long mail to you stuck in my drafts that didn't
make it out to reply to your last mail. I'm sorry about that, but it
looks like we're progressing anyway.

But in that draft, I agreed that yes, we have catch 22 around setting
that ->info, as we need to power up to determine the specific model.

> I've tried to add extra vsp1_device_put() / vsp1_device_get() calls to the
> probe path, and dumped related registers in vsp1_pm_runtime_resume() after
> return from vsp1_device_init(), and got
>=20
> [    2.477315][    T1] vsp1 fea28000.vsp: VI6_DISP_IRQ_ENB(0) =3D 0x00000=
100
> [    2.483933][    T1] vsp1 fea28000.vsp: VI6_DISP_IRQ_STA(0) =3D 0x00000=
121
> [    2.490556][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_ENB(0) =3D 0x000100=
02
> [    2.497088][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_STA(0) =3D 0x000100=
03
> [    2.503618][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_ENB(1) =3D 0x000000=
00
> [    2.510148][    T1] vsp1 fea28000.vsp: VI6_WPF_IRQ_STA(1) =3D 0x000000=
00
>=20
> which shows that
> (1) WPF interrupt is not cleared by WPF reset,
> (2) also DISP interrupt is enabled and pending, and driver does not seem
> to control it at all.
>=20
> Given that, I think it is safer to explicitly mask all interrupts before
> setting the handler. I've moved interrupt masking to a separate routine.

Thankyou, at least being a separate function makes it a bit cleaner and
clear that it's not specifically a part of probe() but something we act
upon to clean up.


> > (But I'm reallly ... reallly concerned that the hardware is not really
> > getting reset when it should, and that might merit some further
> > investigation).
>=20
> The documentation for WFP reset bit has notes that under some situations,
> reset is postponed for a long time, and reported via interrupt. I'm not
> sure what exactly goes on there, but I'd assume that such logic implies
> that interrupt subsystem is not reset.
>=20
> I agree that not having exact understand of hardware state is not good.
> But, given that no signs of misfunction have been detected for a long time
> (the patch was in vendor BSP for years), I think we can assume it is
> "safe enough".

Yes, well I think this is adding the safety by re-asserting our
assumptions on probe time. Which sounds like a good thing given the
circumstances.


Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

>  drivers/media/platform/vsp1/vsp1_drv.c | 34 ++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platf=
orm/vsp1/vsp1_drv.c
> index c9044785b903..92a95e2c21c7 100644
> --- a/drivers/media/platform/vsp1/vsp1_drv.c
> +++ b/drivers/media/platform/vsp1/vsp1_drv.c
> @@ -550,6 +550,16 @@ static int vsp1_device_init(struct vsp1_device *vsp1)
>         return 0;
>  }
> =20
> +static void vsp1_mask_all_interrupts(struct vsp1_device *vsp1)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < vsp1->info->lif_count; ++i)
> +               vsp1_write(vsp1, VI6_DISP_IRQ_ENB(i), 0);
> +       for (i =3D 0; i < vsp1->info->wpf_count; ++i)
> +               vsp1_write(vsp1, VI6_WPF_IRQ_ENB(i), 0);
> +}
> +
>  /*
>   * vsp1_device_get - Acquire the VSP1 device
>   *
> @@ -819,13 +829,6 @@ static int vsp1_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
> =20
> -       ret =3D devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
> -                             IRQF_SHARED, dev_name(&pdev->dev), vsp1);
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "failed to request IRQ\n");
> -               return ret;
> -       }
> -
>         /* FCP (optional). */
>         fcp_node =3D of_parse_phandle(pdev->dev.of_node, "renesas,fcp", 0=
);
>         if (fcp_node) {
> @@ -855,7 +858,6 @@ static int vsp1_probe(struct platform_device *pdev)
>                 goto done;
> =20
>         vsp1->version =3D vsp1_read(vsp1, VI6_IP_VERSION);
> -       vsp1_device_put(vsp1);
> =20
>         for (i =3D 0; i < ARRAY_SIZE(vsp1_device_infos); ++i) {
>                 if ((vsp1->version & VI6_IP_VERSION_MODEL_MASK) =3D=3D
> @@ -868,12 +870,28 @@ static int vsp1_probe(struct platform_device *pdev)
>         if (!vsp1->info) {
>                 dev_err(&pdev->dev, "unsupported IP version 0x%08x\n",
>                         vsp1->version);
> +               vsp1_device_put(vsp1);
>                 ret =3D -ENXIO;
>                 goto done;
>         }
> =20
>         dev_dbg(&pdev->dev, "IP version 0x%08x\n", vsp1->version);
> =20
> +       /*
> +        * Previous use of the hardware (e.g. by the bootloader) could le=
ave
> +        * some interrupts enabled and pending.
> +        */
> +       vsp1_mask_all_interrupts(vsp1);
> +
> +       vsp1_device_put(vsp1);
> +
> +       ret =3D devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
> +                              IRQF_SHARED, dev_name(&pdev->dev), vsp1);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to request IRQ\n");
> +               goto done;
> +       }
> +
>         /* Instantiate entities. */
>         ret =3D vsp1_create_entities(vsp1);
>         if (ret < 0) {
> --=20
> 2.30.2
>
