Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3104D0208
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbiCGOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243686AbiCGOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:52:54 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D7D91AF6;
        Mon,  7 Mar 2022 06:51:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNyN94fqKYI3gEyiRrbnx56UETq6m4HfQiAw+S+bkMYcM8pkv5H7HsijnQsZTN3U3kbWoSp5v6qrFTSy0JKvtE3SJZTTosoxWMeMCPxs7MiNypT1h69dSbGF3VHzDZfB7hqfoQnTWzaZCo7KZddBZ2SdUXXEER8gpUyXdVBu04402P43rzAYHitbKzlRJkNPZZbRUwS8x/LYBIKsLGjGAyFvhTiBZpL03u8ik5Az5vLYpPZ2f0wcbhH2dYtOdyT83eHQ+bEKBebiUre7ULvZRxpUOY3OYkQmqibQWk1KK4L75XEoGaighluvDpXMaw9rbxu5JVtqp9k5H2+xYDhRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGKocbnDUtaF0jveVBi7DzSqizhKT0LP71WilsO4fUE=;
 b=IP0SQ9GocPN3vjEL4WuEllbkvhE+p3fYXzRM61V38Qy/CInPXXTrvcbJY3JEQXF2T6hkqtvgJm1nr3Sq1+CQXc/Kw5rO11nOfq3igOl2xb0Ubgf9J6vd+LVm1agUTjQgljCKCGvB/sqg4o4NNXOW9Yv7/Iwljk7EFXpBnW7H7Xn1XBUpnAt1zmDHlLP+n743DefDWNiB/QOibwnHrMpn7KLQO0h5GOh/J6bY5mW1nZZgXEyh9fYnBq1Ea9DEL2l5ey5ISM3tkuy26nJ4+0hK4U58dFYIVM2P9gXutpHxFboSYd6ugBhBrnKQZ/Tyke2TwfJD8jCX2Laac0DzM1nDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGKocbnDUtaF0jveVBi7DzSqizhKT0LP71WilsO4fUE=;
 b=mKaf5WFBkV9vTo3c1dYUNS5yG9bmn15AmLXHyAl9WtK1WJm0TTSCFLM+Unlz8yxX5WhfBWI5duEtTHDf3Rmbr0IiUjPFDyRW5Wv3YdPXYcRB2Ld5ULdYNbWqdCJaoRFzPBJAPL2MNVjl8xC58XDx/fIgeJDKOymcC3tJ8eks4F8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by DB7PR04MB5226.eurprd04.prod.outlook.com
 (2603:10a6:10:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Mon, 7 Mar
 2022 14:51:31 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf%3]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 14:51:31 +0000
Date:   Mon, 7 Mar 2022 16:51:28 +0200
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: max9286: fix kernel oops when removing module
Message-ID: <20220307145128.x6cxhj4dgvyyjqj2@fsr-ub1664-121.ea.freescale.net>
References: <20220307133750.29708-1-laurentiu.palcu@oss.nxp.com>
 <164666323196.11309.2192554853786525085@Monstersaurus>
 <YiYYQE4gyGY468Jz@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiYYQE4gyGY468Jz@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: FR0P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::23) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 487e08b9-416b-4636-f2b9-08da0049f745
X-MS-TrafficTypeDiagnostic: DB7PR04MB5226:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB522636B4CBD719E0559090C1BE089@DB7PR04MB5226.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Evo+63Fq/DbEg8unm1IOpBKXEywMReqjRSAY40BTOCT6zES60y8UxFEBc1hmNkd2H1DqXZKjus2NIvaI57NrcpSunULWqAx+bduZ2U+SogHfx4XyptRm6f7IcfqjvSDCgRoBzaGx+y9C5Rt7ft6LhbKy2op/GRhGkyck4JUJIuO46DsdmMd0KDaAtqbrnQFOhKr2K3U53prydrNCHRJwDLWnMrGY66erZmkvnCPHnbiwRxB4epeTrSSVqfFFwj5OeWahjChudsGIfm5ZNU9XXoHMf1bitnFsIEDg0yKFEMx84JwUiXI2sxFQmMn89nSIjUMIGC/VtlB+C3zbSGU99AhOGR6cb2wl43W0B0JCrFKhIOPW94FvaJLSIfKRG3RJ3OE0TFV85v53igmp4N1EQywsNbNDKGcnpvQrMEsK9JBtcPowRHY2sJZm/+1WKhOOAqPhaIPLl36INKUgxnt1fgF/DmOD2YhCRW0cAwZmt/TK3ohSUTzJgw4pRRPFMuC2ita7483sJHkGZ81zXqoYMLoYeRIezCK8bKP8YtbA1f5M/WAcc/SFB7cgq7Np9gBH2DOAGiYyt6kyRhRboBsp1kVo7FyOvMvwISF2zD7sJ4OjH37TToyp45YT01lc6/n7+0HPCc26cH/S0ft8A7rh3v1Xe7icCjrvx2F7ZEMNq0TPznTzc3vFU/8bR0hqeZBALjnj/JyFgptzQgUmvmA+SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(54906003)(6486002)(508600001)(45080400002)(66946007)(4326008)(8676002)(2906002)(8936002)(5660300002)(44832011)(86362001)(66476007)(66556008)(316002)(38350700002)(6916009)(186003)(52116002)(9686003)(6666004)(6512007)(6506007)(83380400001)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VpEcuFYgNvMq4gFGyIldpfVTgn5ZgJhhEQby5EolvsRh+cIWaW59h/Hsc+E6?=
 =?us-ascii?Q?ZlZKaY1b0rxt7QRJj/feEihmaL9K4qOzCK+PavSg5PUzXXf51PHFz+RjzXb3?=
 =?us-ascii?Q?Ifgdu4AUocdwncoAMkaqS8qNBh+QeM1ae2yBlYjksnS2JiCHFXs2VTu2zDdo?=
 =?us-ascii?Q?jmFqYSdqG9i6o1I15/zkS/vKK+HgRvUkWgux+ow5znW+4ze6LdrqzL+tQFX6?=
 =?us-ascii?Q?YY8G7cBvmiA5eMgxzPBSl7/A7sDBQQO7d2xPMAfH4yB3uSKl04rz0kqbwlnq?=
 =?us-ascii?Q?KeIP7iOQuIn2eIwqLwSub7ZLFFIr+NiT/L/DfjZKXIWh+vIoHha32ZCx17vA?=
 =?us-ascii?Q?iQ2ylR2S9wcErju81/2ISSgpgGySXY7MGbLjcLdG2Brr29L79H+OhbCn37W6?=
 =?us-ascii?Q?c8WIRqNNICc1Z79QE8iAwQnqisCRMkOprI/qyee0cQhuxoXMKwUKoM4B4lXE?=
 =?us-ascii?Q?KoOObr2xErsvcNg0swx8h4BIPxkA3ekDcLNY8F7+vDwZrQ7bvWgP83o3hjcV?=
 =?us-ascii?Q?g5Z1Uzb3GpPdX9H1720Q2M8kxwwh1fa2yCi3RPmwGIRFDQQ1DHqUl4JLRM/3?=
 =?us-ascii?Q?706FudtiCL6lzjqZRROzPJZJ4046TmN1F3LNBYYMgO+sAUl/92PHTT4ERDma?=
 =?us-ascii?Q?GFna7FYAc6Wd9UWeLm5zOwxVLufQcdR3Yt5VeV3IizfJkDnRWBjbpMxZPBPc?=
 =?us-ascii?Q?cx/c66JPUO7LY5tbRAwTYjI/6Rm5CCmV/Svy9XZvv8bn8FYeH5CBQxsow9F0?=
 =?us-ascii?Q?ulKKh8o7hrUtpKx9k186rS7xqC5H1XOqkYkHbVYMkz4GyySottLGSxTU4kjd?=
 =?us-ascii?Q?TrofYjSDZpHjYj/8xE+0Trh8I9bOikxct7/z5IKE+cEihBuJ1rUHpiHuh2BL?=
 =?us-ascii?Q?t8KaKYr10IMxoH5V6egG7rNOzfQ+76V6Mc6EiYZgQHXYmhnGyXt8mkXAX8ZA?=
 =?us-ascii?Q?RNqIFokThVhoGl65nTTYwPbD5bnR32KWgDJL/zRpjC00bU1hZVg5+wWzMG2O?=
 =?us-ascii?Q?JG2IzQSBxB1Swh5kBQkBFFZlWHjV3SXF60+8gNSWvJ0Zi9HQKZ4DXHctIDn8?=
 =?us-ascii?Q?a+SY+HPjUQAZiGZMYerzm7CgKqw0W0oG6Mi95T8W7//dXi9twHXLNQHBWXjY?=
 =?us-ascii?Q?cH2k4QG3MbB0S5snkw5GwBXqgmpRL8V+mDG+H3famxnQN94mxnDRrzIKDEWi?=
 =?us-ascii?Q?sjQoo/TPjSqa1dpUT5+xV2oQlVRr7mofNXjiU0wz3PMG5qsIWI2FbFd8tRSo?=
 =?us-ascii?Q?aV//6bjqfibRc8wdSRmlCB99kNm5rMeW1Y5eTQo/ad75Jd+2redinm4hbo+q?=
 =?us-ascii?Q?mrMhQ4czh9P7T2Agl62FNED0tojQBhMEVgOaKdRna46EKJtSw6QZpH2HhI2D?=
 =?us-ascii?Q?kKQVUWjdw7Ko8mcU9iF5SZ+xbbHwvi3qCxygYVNZjyJdZvSd3oHjBTsM23A7?=
 =?us-ascii?Q?q9rYKy20NgDT2TbSUrCBTZ9FeQsEdkpCcS0qR1YxcXTQviDvXwcMdRhnj83E?=
 =?us-ascii?Q?YZgqDBjEajD0mTYPxWT4unf0wNqs5jTtpYN7EfvYJbmurLK1PpqgCcPpaQ4F?=
 =?us-ascii?Q?tXUmjI9GUnFyjC8ekDLd6SM6vyxgvIsJHhxtlZSqXZcnWgCacFkAFay/qYrL?=
 =?us-ascii?Q?NUgvT36sM20pocVGWClAoHU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487e08b9-416b-4636-f2b9-08da0049f745
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:51:31.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+4BvgyAol67uqgQeQAVaKOOydx0a1OyeoTaV2gaUO4T0mNgBxmLpN/miCjpRp/KAmIb/YlSDRgIotOnvIXzFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran, Laurent,

On Mon, Mar 07, 2022 at 04:35:44PM +0200, Laurent Pinchart wrote:
> On Mon, Mar 07, 2022 at 02:27:11PM +0000, Kieran Bingham wrote:
> > Hi Laurentiu,
> > 
> > Quoting Laurentiu Palcu (2022-03-07 13:37:50)
> > > When removing the max9286 module we get a kernel oops:
> > > 
> > > Unable to handle kernel paging request at virtual address 000000aa00000094
> > > Mem abort info:
> > >   ESR = 0x96000004
> > >   EC = 0x25: DABT (current EL), IL = 32 bits
> > >   SET = 0, FnV = 0
> > >   EA = 0, S1PTW = 0
> > >   FSC = 0x04: level 0 translation fault
> > > Data abort info:
> > >   ISV = 0, ISS = 0x00000004
> > >   CM = 0, WnR = 0
> > > user pgtable: 4k pages, 48-bit VAs, pgdp=0000000880d85000
> > > [000000aa00000094] pgd=0000000000000000, p4d=0000000000000000
> > > Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > > Modules linked in: fsl_jr_uio caam_jr rng_core libdes caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine max9271 authenc crct10dif_ce mxc_jpeg_encdec
> > > CPU: 2 PID: 713 Comm: rmmod Tainted: G         C        5.15.5-00057-gaebcd29c8ed7-dirty #5
> > > Hardware name: Freescale i.MX8QXP MEK (DT)
> > > pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > pc : i2c_mux_del_adapters+0x24/0xf0
> > > lr : max9286_remove+0x28/0xd0 [max9286]
> > > sp : ffff800013a9bbf0
> > > x29: ffff800013a9bbf0 x28: ffff00080b6da940 x27: 0000000000000000
> > > x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> > > x23: ffff000801a5b970 x22: ffff0008048b0890 x21: ffff800009297000
> > > x20: ffff0008048b0f70 x19: 000000aa00000064 x18: 0000000000000000
> > > x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > x14: 0000000000000014 x13: 0000000000000000 x12: ffff000802da49e8
> > > x11: ffff000802051918 x10: ffff000802da4920 x9 : ffff000800030098
> > > x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
> > > x5 : 8080808000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > > x2 : ffffffffffffffff x1 : ffff00080b6da940 x0 : 0000000000000000
> > > Call trace:
> > >  i2c_mux_del_adapters+0x24/0xf0
> > >  max9286_remove+0x28/0xd0 [max9286]
> > >  i2c_device_remove+0x40/0x110
> > >  __device_release_driver+0x188/0x234
> > >  driver_detach+0xc4/0x150
> > >  bus_remove_driver+0x60/0xe0
> > >  driver_unregister+0x34/0x64
> > >  i2c_del_driver+0x58/0xa0
> > >  max9286_i2c_driver_exit+0x1c/0x490 [max9286]
> > >  __arm64_sys_delete_module+0x194/0x260
> > >  invoke_syscall+0x48/0x114
> > >  el0_svc_common.constprop.0+0xd4/0xfc
> > >  do_el0_svc+0x2c/0x94
> > >  el0_svc+0x28/0x80
> > >  el0t_64_sync_handler+0xa8/0x130
> > >  el0t_64_sync+0x1a0/0x1a4
> > > 
> > > The Oops happens because the I2C client data does not point to
> > > max9286_priv anymore but to v4l2_subdev. The change happened in
> > > max9286_init() which calls v4l2_i2c_subdev_init() later on...
> > > 
> > 
> > I think this needs a Fixes tag, but it looks like it happened when we
> > merged the driver. So that makes it:
> > 
> > Fixes: 66d8c9d2422d ("media: i2c: Add MAX9286 driver")
> > 
> > I see in max9286_probe() we set
> > 	i2c_set_clientdata(client, (struct max9286_priv) priv);
> > 
> > And indeed, then we call 
> > 
> > max9286_init()
> >  max9286_v4l2_register()
> >   v4l2_i2c_subdev_init(&priv->sd, priv->client, &max9286_subdev_ops);
> > 
> > So I think this patch should probably also remove the call to 
> > i2c_set_clientdata() in probe to prevent confusion.
> 
> Agreed.

I suppose the reason why i2c_set_clientdata() is called in probe() is
because max9286_init() uses i2c_get_clientdata() to get priv. But, that
would be easily fixed if we change the function declaration to

static int max9286_init(struct max9286_priv *priv)

From priv we can get both client and dev, which are used inside the
function.

I'll send a v2 shortly.

Thanks,
Laurentiu

> 
> > > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > > ---
> > >  drivers/media/i2c/max9286.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> > > index d2a4915ed9f7..04f5b7e3a9e5 100644
> > > --- a/drivers/media/i2c/max9286.c
> > > +++ b/drivers/media/i2c/max9286.c
> > > @@ -1385,7 +1385,7 @@ static int max9286_probe(struct i2c_client *client)
> > >  
> > >  static int max9286_remove(struct i2c_client *client)
> > >  {
> > > -       struct max9286_priv *priv = i2c_get_clientdata(client);
> > > +       struct max9286_priv *priv = sd_to_max9286(i2c_get_clientdata(client));
> > 
> > What happens if the module load failed before calling max9286_init(), in
> > that case, would the i2c_get_clientdata() return NULL?
> > 
> > If so, should this be checked?
> 
> .remove() isn't called if .probe() fails, so it should be fine
> 
> > >  
> > >         i2c_mux_del_adapters(priv->mux);
> > >  
> 
> -- 
> Regards,
> 
> Laurent Pinchart
