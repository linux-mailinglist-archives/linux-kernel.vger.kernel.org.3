Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1173B4D2C01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiCIJa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiCIJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:30:54 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8859A16EAAA;
        Wed,  9 Mar 2022 01:29:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNnusOlR6abIkKYIry6DMjv6d0ou1ABrBU+tps7ZWMjLAwDKzN4vziZrcLWRoVWYu67MJQLI5gaWals52DCgmKV4ce1T19srRRZRLCpdgqyH4Y3hXezVF2sv9IH6kBE4DKeyzJK2HAwY3uQuTmFZ+wCT0ncJKeiySymAiptCG2zJx0oktNSKsQcv1VhfnEC2n6Bc8ULn8MZDVwpmENcpJORrEUxTQ6D6GJV1WwTJPwS0EPmLL2gL+w14sP9wzdpsJvHiWgQfDhxP3fJKL+kLdVJ6VJPviajRsSKxp9lT/JjgPOM7eiowDAZhoo+9o4pdCZEHSLL60ZMSds7wlOdg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFiGxjnuwDzTcWbu3rUrTl/LsXHzrmiwnP9ACe183Fg=;
 b=EoaVMJYGy9+RPItaUa/mWXslNevd3hNtEucJzhOf1vzhlkMXVYGIhw4F0sJjB8SFpG7T3DqK/wCUpeviRvUX6Whbt0v2M8Adl1ZbrSrM5dk5Gu2RIivYBgH/sJ1XKzzSBQzXTCDBOVAVjUrBJ0fEhNFpbpKqGAt67QPjrQlhB+er2amaKD+7P6K4LR9MejhRip+wrtLaAs2B2zs6wz7ftBxbkKBS9iVqVdi0qg7Sj/FpIQ6D8Gydf2d7Lc7LCZ8zIguqm+MsTm8tjlniOIUwYCXW8zJoaUhgDCsjbRgQsXJREzbe30FAAnMp2zWnpnl8xruuWIOuL5idQHPNeXsOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFiGxjnuwDzTcWbu3rUrTl/LsXHzrmiwnP9ACe183Fg=;
 b=bj2dvS4xTK8ZEFn9+XkAeoqAEUH6kMwhAE9K3+i3aLkZgdgq+gBeCZ41dDQSsFrK3viie1lACoClk3UFXh27LYNWtyl3Wsjqa01z1sgyEznpBS/YSGB6ViEvybBoyZyo/ixGMiRHQ75EF3jtvwzaarDMI63C28sai6a7vZvpK9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by DU0PR04MB9298.eurprd04.prod.outlook.com
 (2603:10a6:10:355::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.23; Wed, 9 Mar
 2022 09:29:48 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::7075:9a92:d8b1:61cf%3]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:29:48 +0000
Date:   Wed, 9 Mar 2022 11:29:44 +0200
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: rdacm2x: properly set subdev entity function
Message-ID: <20220309092944.oxddlm4z7mzv63sw@fsr-ub1664-121.ea.freescale.net>
References: <20220308125549.9676-1-laurentiu.palcu@oss.nxp.com>
 <20220309084311.vn3awybkxzxd32i4@uno.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309084311.vn3awybkxzxd32i4@uno.localdomain>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AM4PR0101CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::17) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e34970-1aab-4088-f9bc-08da01af5ab2
X-MS-TrafficTypeDiagnostic: DU0PR04MB9298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB9298094FCAC5AE2F919EE633BE0A9@DU0PR04MB9298.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TfL+rD1/44LQUz8I1sO1BotOYqrWKtWvOixpYliEqZHcIF09Kz//n2iuQt7OITuwcFMFdcwMhskzeG9y4hCnaxX61Slh4w6VvvYlGOmamNY4GomUE3O9Xrhh03MRVGqHBcJex2O0OdTvk0GjDf2pZmR5pc2ox1B0lBehS7wOS4KJo2scgIX0ew+CSYmuoJNAENVHz9KHbWcx6gllpa62OGN0pdW17cDnGRYVn+Ue2rPK06TofM2J05qG3Z4/f6HtNZtl2QrtsDHdDX6mU6pFUpHDENQtV1CYZpVHf8zgENkSr0qcmLKGm/rwtKvudRJvZBlUWG/c31J9qCP7q1c8hW3u7qAeZz0ZsA/pI2bSSZWKKqapvtxbpZDrEaUE77BTr+vN/jG2Eb0gdojPEPK0/AwepZKCBP3hS9mxXwv2oM/zAcRDVWuqqTetODN1wk85H78tHi2aDL+HsPs5pfFHv4ZKYh7VXwL4BWsKe9eo5oU7AfgP1TeBxSpW69hkPGbDfLj0HURzilt2yEO7LS/tbyaQW3nD79klS8GNTpbJcG8R/XYGPma6nyY5R4eFhXBL2/N/ytDOC/8jJ6R1xJ/xroRs5dvjqMAbgnfeNNL9+vQ7HtrBJJAoo/SjhJcIzEtyZo3EzC1jRJBSRORNc7ZC4xH1ExPwNxknp579OCPVjYHDiZ/n4hiK9E02cm2Ij/SpbQZjyLko1mIuuMvCnugoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(8676002)(186003)(2906002)(6666004)(52116002)(8936002)(66476007)(66556008)(66946007)(4326008)(83380400001)(6486002)(5660300002)(26005)(6512007)(9686003)(86362001)(54906003)(38350700002)(498600001)(44832011)(6506007)(6916009)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDaGdYF3/cWz+Hb4d6HRJ3AFswlXYWIgnpWx+pU8cgaSFhE4tlEHyeRRvJgC?=
 =?us-ascii?Q?avnVkEYaU4wXS8RC3FkgImR8h/2OaUFrgEeqcmJDNK6GYWeYDhFfnnxXT2RK?=
 =?us-ascii?Q?kJPVnDhBB0wE9aBpDowc7kA4WYwV/ak9mZd5pOzE3jmKwCzD6ngM7kL3PTCe?=
 =?us-ascii?Q?7vLLpEW0o1qxQONj70t2ZJm6jRaAi62iDrBqtjffjoP2ABk/KpW5WVEXf6U8?=
 =?us-ascii?Q?4EOgFqK5eqH2QFbBifY+2lTQ1tysREtzBXLvOYoQLL1rkAphn6724nwWnVpi?=
 =?us-ascii?Q?or9RQ3tC8qdYCNae+tJQdymi99ojLUMdTdOjHhx0gU6qFfYMOwJOLkONHxEv?=
 =?us-ascii?Q?YmUQGjEF0WQmMsZxBuvGbFNvTq8cWHSSmq45WRoMknsJuRZtv6yjwnR0ltxO?=
 =?us-ascii?Q?Xzo7SuSQljCkPGmJcRZ2+RFfCc80qukl3iXjzQwbBJEkJrO7mG9H/V3Te3gy?=
 =?us-ascii?Q?43bT4TDpDvPws1V5YVbesG3KNs7wK75pIf2014yW3LpkuniIc+rdc6XUjTEa?=
 =?us-ascii?Q?ieYaaWvUDjgTnWjcPJJmSVjX5ZSR6NVNL12s7IY+ES+sb/t5y0O99PS3piSC?=
 =?us-ascii?Q?9P1yCd9aQClSBULHTLFMJzqYOr28sk4mxnPGWIRAU1xkRFGLV/fLZ3Yukdpk?=
 =?us-ascii?Q?gU/hi1c/n38oqEBBmyf7olpEuQ5cCwY4BbiglubZzEFnGMBivSw7NbTPTO3i?=
 =?us-ascii?Q?Je7VEzIaEcGyIKPgg3kaT1DmZKmjYO3TbL+7nCRU2ISSlMiFCH0VTxJVhmRr?=
 =?us-ascii?Q?kGGZ64eZAtIEluBXs0ihOAuvAvKk93zcMIUAGCdgs9lavS+nVOl4TZvr1tnb?=
 =?us-ascii?Q?Mq6AiMObL/IQpT7nsevWRBmUJ5kUzoRqTuQtrBFQZ2fUKvpSZOPfbiPNG+45?=
 =?us-ascii?Q?JlIBXu7snbwL80XZG+pfVw2k4aSTqvgFI1mALoD8N9iLySHGEDYSTHwyLLB8?=
 =?us-ascii?Q?0eck2obFetwVwv7FJoVxzDKShzOKB3Lbdg7mYWX9L9lOe5gVoRfs9/2L16vl?=
 =?us-ascii?Q?ArwEPKTAnu1uKrQB3pWbouyPL9kfB+WDJ5dzF+SJrFAQvQuG2IuYWjiKwYkw?=
 =?us-ascii?Q?nM1ujK8fuyKxJlkRYgJb02hq+ZgTk552ay7Nld/TJLQTLTeqrMngeRUh8lLD?=
 =?us-ascii?Q?t4kN5Q+l9jyH+WdGodU87FHx0+rJ2FKeXaKVbaRVo48e9hmZKERm6nxk9aZn?=
 =?us-ascii?Q?7mE8vYPImverZasrtmCT4ivx8bwLvD1wjtiEPPSic2PWAUZ641uPe/AtQC6k?=
 =?us-ascii?Q?oUNTaIUm4e5Sa5dfTKNYaB+xU8sBPUA9vr+lwtHc6MRZ6Lx1a1QZCeXYuFDY?=
 =?us-ascii?Q?E61zk6EwdB+wn3lrJbwS5AQnRysdRTYj/f9rcyNHJ8JSDipLU/R/Mue7AeRv?=
 =?us-ascii?Q?DpNfh4Ol2Zvu1wEah8HhOno2mcFrRZRR6Nx0OUX8GaeDTKJBwK+Aw20qophw?=
 =?us-ascii?Q?zJDfzeosxjRkex4uEXY1y30hGp8bjoUV3b7/RInX9oVLhKUQBrcP7wFHLCGG?=
 =?us-ascii?Q?7c0ucaZfVmwrH+xA6oSPnkcDso8hdFDNFXHHwnxzTqPDQnUSAJCU6cz9Myrc?=
 =?us-ascii?Q?iuUE3Z6hqkmzSEAbUL67DoipEMhyXcAFnXjAzM1RoDTftU6CHOv8HWHfzSCk?=
 =?us-ascii?Q?BISx/Izh7SjxcvJAu/+r20A=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e34970-1aab-4088-f9bc-08da01af5ab2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:29:48.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljzIY9JT1wjWtxtmSROu0AQkST3D3fhmlPBhA1In5Cs7wJvuwKoeQual2ZE5HaoT1lKlX3ZmWigTjD1+Mnl0DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Wed, Mar 09, 2022 at 09:43:11AM +0100, Jacopo Mondi wrote:
> Hi Laurentiu,
> 
> On Tue, Mar 08, 2022 at 02:55:49PM +0200, Laurentiu Palcu wrote:
> > The subdevice entity function was left unset, which produces a warning
> > when probing the device:
> >
> > mxc-md bus@58000000:camera: Entity type for entity rdacm20 19-0051 was
> > not initialized!
> >
> > Also, set the entity flags to MEDIA_ENT_FL_DEFAULT instead of
> > MEDIA_ENT_F_CAM_SENSOR which will be used for entity's function instead.
> >
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > ---
> > Hi,
> >
> > Only tested the rdacm20 part but I believe rdacm21 should work as well.
> >
> > Cheers,
> > laurentiu
> >
> >  drivers/media/i2c/rdacm20.c | 3 ++-
> >  drivers/media/i2c/rdacm21.c | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> > index 025a610de893..ea5b7d5151ee 100644
> > --- a/drivers/media/i2c/rdacm20.c
> > +++ b/drivers/media/i2c/rdacm20.c
> > @@ -611,7 +611,8 @@ static int rdacm20_probe(struct i2c_client *client)
> >  		goto error_free_ctrls;
> >
> >  	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
> > -	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
> > +	dev->sd.entity.flags |= MEDIA_ENT_FL_DEFAULT;
> 
> I'm not sure if setting the DEFAULT flag is right:
> 
>  * %MEDIA_ENT_FL_DEFAULT
>  *    indicates the default entity for a given type.
>  *    This can be used to report the default audio and video devices or the
>  *    default camera sensor.
> 
> In a typical setup there will be several RDACM2x in use, marking all
> of them as "default" seems not right (if I understood the flag
> description right).

My initial thought was to not set the entity flags at all. However,
since the old code had the flags set to MEDIA_ENT_F_CAM_SENSOR which is,
essentially, 0x20001, setting it to MEDIA_ENT_FL_DEFAULT (1 << 0) would
mean, basically, the same thing and would not affect existing user apps
that might already probe that flag... Removing the flag now might
potentially break existing apps. :/

Are there any other opinions on this one?

> 
> 
> > +	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> 
> This seems right, and it's probably worth a Fixes tag?

I'll send a v2 with the Fixes tag which I meant to add but totally
forgot...

Cheers,
Laurentiu

> 
> Thanks
>    j
> 
> >  	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
> >  	if (ret < 0)
> >  		goto error_free_ctrls;
> > diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
> > index 12ec5467ed1e..be89bd43e88b 100644
> > --- a/drivers/media/i2c/rdacm21.c
> > +++ b/drivers/media/i2c/rdacm21.c
> > @@ -583,7 +583,8 @@ static int rdacm21_probe(struct i2c_client *client)
> >  		goto error_free_ctrls;
> >
> >  	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
> > -	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
> > +	dev->sd.entity.flags |= MEDIA_ENT_FL_DEFAULT;
> > +	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> >  	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
> >  	if (ret < 0)
> >  		goto error_free_ctrls;
> > --
> > 2.33.0
> >
