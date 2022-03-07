Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F204D0130
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243197AbiCGO2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbiCGO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:28:10 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0728EB74;
        Mon,  7 Mar 2022 06:27:15 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 65D52478;
        Mon,  7 Mar 2022 15:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646663234;
        bh=xNVCGDrxwmjHsSDnPzLrO4mBK8yfw9lvvqKIBV1PTK4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E7FfwJkKzENdaEStSVjO3vakRPxAooNrLFvp3M2BFUOYRwKuSpwoQ4ci2LYE3LjOa
         MWwSB6JmfFKcKooAA0aySGEW48+S6UdkyIYhA8OkamD4rxIpIBK8hCsbKrjSMj+Q1v
         XtOysM2aZFXQxdvPC6cc0Krg98toH+ovI9cHTg4M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220307133750.29708-1-laurentiu.palcu@oss.nxp.com>
References: <20220307133750.29708-1-laurentiu.palcu@oss.nxp.com>
Subject: Re: [PATCH] media: i2c: max9286: fix kernel oops when removing module
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?utf-8?q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Date:   Mon, 07 Mar 2022 14:27:11 +0000
Message-ID: <164666323196.11309.2192554853786525085@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

Quoting Laurentiu Palcu (2022-03-07 13:37:50)
> When removing the max9286 module we get a kernel oops:
>=20
> Unable to handle kernel paging request at virtual address 000000aa00000094
> Mem abort info:
>   ESR =3D 0x96000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x04: level 0 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000004
>   CM =3D 0, WnR =3D 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000880d85000
> [000000aa00000094] pgd=3D0000000000000000, p4d=3D0000000000000000
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in: fsl_jr_uio caam_jr rng_core libdes caamkeyblob_desc ca=
amhash_desc caamalg_desc crypto_engine max9271 authenc crct10dif_ce mxc_jpe=
g_encdec
> CPU: 2 PID: 713 Comm: rmmod Tainted: G         C        5.15.5-00057-gaeb=
cd29c8ed7-dirty #5
> Hardware name: Freescale i.MX8QXP MEK (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : i2c_mux_del_adapters+0x24/0xf0
> lr : max9286_remove+0x28/0xd0 [max9286]
> sp : ffff800013a9bbf0
> x29: ffff800013a9bbf0 x28: ffff00080b6da940 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> x23: ffff000801a5b970 x22: ffff0008048b0890 x21: ffff800009297000
> x20: ffff0008048b0f70 x19: 000000aa00000064 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000014 x13: 0000000000000000 x12: ffff000802da49e8
> x11: ffff000802051918 x10: ffff000802da4920 x9 : ffff000800030098
> x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
> x5 : 8080808000000000 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : ffffffffffffffff x1 : ffff00080b6da940 x0 : 0000000000000000
> Call trace:
>  i2c_mux_del_adapters+0x24/0xf0
>  max9286_remove+0x28/0xd0 [max9286]
>  i2c_device_remove+0x40/0x110
>  __device_release_driver+0x188/0x234
>  driver_detach+0xc4/0x150
>  bus_remove_driver+0x60/0xe0
>  driver_unregister+0x34/0x64
>  i2c_del_driver+0x58/0xa0
>  max9286_i2c_driver_exit+0x1c/0x490 [max9286]
>  __arm64_sys_delete_module+0x194/0x260
>  invoke_syscall+0x48/0x114
>  el0_svc_common.constprop.0+0xd4/0xfc
>  do_el0_svc+0x2c/0x94
>  el0_svc+0x28/0x80
>  el0t_64_sync_handler+0xa8/0x130
>  el0t_64_sync+0x1a0/0x1a4
>=20
> The Oops happens because the I2C client data does not point to
> max9286_priv anymore but to v4l2_subdev. The change happened in
> max9286_init() which calls v4l2_i2c_subdev_init() later on...
>=20

I think this needs a Fixes tag, but it looks like it happened when we
merged the driver. So that makes it:

Fixes: 66d8c9d2422d ("media: i2c: Add MAX9286 driver")

I see in max9286_probe() we set
	i2c_set_clientdata(client, (struct max9286_priv) priv);

And indeed, then we call=20

max9286_init()
 max9286_v4l2_register()
  v4l2_i2c_subdev_init(&priv->sd, priv->client, &max9286_subdev_ops);

So I think this patch should probably also remove the call to=20
i2c_set_clientdata() in probe to prevent confusion.



> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  drivers/media/i2c/max9286.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> index d2a4915ed9f7..04f5b7e3a9e5 100644
> --- a/drivers/media/i2c/max9286.c
> +++ b/drivers/media/i2c/max9286.c
> @@ -1385,7 +1385,7 @@ static int max9286_probe(struct i2c_client *client)
> =20
>  static int max9286_remove(struct i2c_client *client)
>  {
> -       struct max9286_priv *priv =3D i2c_get_clientdata(client);
> +       struct max9286_priv *priv =3D sd_to_max9286(i2c_get_clientdata(cl=
ient));

What happens if the module load failed before calling max9286_init(), in
that case, would the i2c_get_clientdata() return NULL?

If so, should this be checked?

--
Kieran


> =20
>         i2c_mux_del_adapters(priv->mux);
> =20
> --=20
> 2.17.1
>
