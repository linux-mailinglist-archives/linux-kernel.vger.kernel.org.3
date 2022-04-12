Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD54FCC96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiDLCrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiDLCrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:47:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2C812094;
        Mon, 11 Apr 2022 19:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et6C1UnxR8Gmc7SIgT8N8kebTmr1rs6fzK20oP2scx9S0AzJ4T0QkSHXhTxckZsYIWXr6qZyYTOdeLtFgNfXHVcu94sp/G+DR06FjucO2cR84S6hVEC6zn3ztOJ6Ncuh8FblXXq+ovzRRe5NczaCQWB9w2Huu3f5QjQkjekEyC2WQzdciLhA2+g0M87K3XhcA/0YfgSf6wo5Bm36kdRY2jFkGkgRCnqAIfwcrsseBcXolq2OpNMi1TxOyIn9snQHeK6DKKknaRnKEGuKbYzgbYurOdLzHNyB0hVyHYbePDCN0huf2HoTZCeEX2tjOy7WxFslfxR4zYAZ6WjhKGJtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hn5SSPbtwY4blSeTMutuJJItVOEveucX29DHcBwdpo=;
 b=Y69Sb45RJQ+WLdbcnjd+cZN8m/r5RsOnWRfU0d51wAqSwtb8DS+pQgT8Qve78V/IxTb7dCyiIR2LvYnovPK3DgKXUK8o6JSQCV1JfXtLr1VBEyImW72R59yNWV3oX7qtgj2z6lsVU2v4a2EJooFxYMju+xBgksKHlVHexnppfWL6UOpVmOX3C9XXT9CXuw/W3kfM7df+owrTFX95nTyRyunwDR39zbWrlldRZyyEQsLSS3FHb8JESld2EIiLkA3lirYsNe03kLnDgBwDbueV+jxW9l00IXn96ybXpSzlfsxMYwsrCGWjQnp8HORTKoqJl3ilD59KJeDb75no0phZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hn5SSPbtwY4blSeTMutuJJItVOEveucX29DHcBwdpo=;
 b=Boe/msXzkrSdRQ0EoLlO/z06VGfnfa3K5UP+9VddNLsToFxc+nNU6/2j18i9+x4u4KpApJnBauXvpCDWjWv0/Lp3AK+N1S5KWIeQvHdTtLW+vcm3MUxZj5Wp0K+aTCzmSV2050pmS+lllf7eZt+GRXemkaAC/xVjsW+GGT7SA4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by SN6PR08MB4189.namprd08.prod.outlook.com (2603:10b6:805:2c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 02:44:57 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::700f:b135:8bfa:4408]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::700f:b135:8bfa:4408%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 02:44:56 +0000
Date:   Mon, 11 Apr 2022 21:44:49 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-input@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input - aw8695: Add driver for AW8695 haptics
Message-ID: <20220412024449.GA5456@nixie71>
References: <20220408115311.237039-1-luca.weiss@fairphone.com>
 <20220408115311.237039-2-luca.weiss@fairphone.com>
 <20220409211532.GA4178@nixie71>
 <CJ7BKZTQR40M.24FTPTRB2OX80@otso>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CJ7BKZTQR40M.24FTPTRB2OX80@otso>
X-ClientProxiedBy: DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17)
 To SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03290f73-813a-4a3f-a017-08da1c2e6dd2
X-MS-TrafficTypeDiagnostic: SN6PR08MB4189:EE_
X-Microsoft-Antispam-PRVS: <SN6PR08MB4189C825379F3E3A246893EFD3ED9@SN6PR08MB4189.namprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnVv6aWqJBR+ov3pExOxSXcm4WA5/7hU9HqxkguAmI1wod6cgsm5rPgPvkJbi9irfVK3lVmfWqRHkJ3UCyKyOQSdrsK9qRKcfQPpxhCauzNbggxTHJXJVY8M7XbAmqQGjLgcN35RjBlwSmTmH1BzTmTQjXCIhUsNShFesUDPyg4OTT5gEh62uYm/7GqYPctumXm465Jt1YuIdjQtF3QtmKTYcIoqpR218LZO4ihUv7ari7D75JIF0KdMm8lxf7+WzQwSS/r6FI2qeJz9Z1M69r4Oft2K5lwJFfMa1SQ9gbggUGwtPU5alPCsinTIEgAlrjysKXdfK0Sqvg1A+8TNZIwgvMg/ILaYAQVCMLkvDiDi4iwj2qdU7d2lRB2FvI1igQ07kcmaL2QNM8IcDH90ndveGWeVpJXBM7Pk5q4elnZpm778ryTTs4/eqBaEedVGKIl7rOIJcoagdGqiM17t9AfDfYvOgCba4WVk6S8pFwBdO1fSUFEnS7Zs7HEq06WOLd0uQOzYt8XUbB/lteSYA18auNC6Nb3sBM/YLwGrFyOPSHtAXR3gpvvl7N4pBrEJpvrsh1zrQS0EYegioOM+IMbKWXC+WU11GtKu6HvlS9U1QHJH7gM2COkgsdvPmHOo0KBSpI6f7WZCs3+b3TXYP1GyobUyM4S5eSA+J5twZj9IyN/AohflxRjwEiSIdlG5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(39830400003)(396003)(366004)(346002)(376002)(136003)(66556008)(33716001)(8676002)(66476007)(66946007)(186003)(38350700002)(8936002)(26005)(5660300002)(4326008)(2906002)(30864003)(83380400001)(9686003)(6666004)(6512007)(6506007)(86362001)(1076003)(38100700002)(52116002)(6486002)(316002)(54906003)(6916009)(508600001)(33656002)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?78KoMwHKVumUJbtZ+S8dihR0CCzYb9E89oo3WxdgTAn/qWlHYoHim1efhYd5?=
 =?us-ascii?Q?y0MxT3w0RhD5tmd+ERGqR2YvlplLHlDIQIkmQWA2gISiKE1yzU9YdFnkucEG?=
 =?us-ascii?Q?qwnHyGTR+M6KK4H0OmucScrY+WJXzAV2oFgJyzAiWaBQHikL9UIkjqCVZ80h?=
 =?us-ascii?Q?PL5MY40EQIU+RYg4oi9CyWXTiZ/dOysX1/UoMHzro5qdLVdECgEUE7D10I+g?=
 =?us-ascii?Q?7XSx2sUnY5AKlSk+uTLeSrul3rdzd6yP1Vh2V2N7kiyjaLFxQbDQj8ThEiQc?=
 =?us-ascii?Q?bS7risMsUWltwe8TvvoV2+s2C1SvNXzkD4IxpXSyV2Ywa40vJWB0PanR+wHV?=
 =?us-ascii?Q?sP/9ZZyoBTgnFrlDm3ZtG9sspl8DgKvKo2Wxj2DdDY+KjRmlk3Vm1UHstspT?=
 =?us-ascii?Q?Y1Lmn6fkWIPI2shYYsxjxPo8vXwfGGigjt2Sab8HsE04af47qMkoEj+0u448?=
 =?us-ascii?Q?92WuDXTGLEpl0vmNVZQVpCkwDOfshWKjMYkHQVZ9gXPwkXFogTorH3tvVWuh?=
 =?us-ascii?Q?ugkaohgNKsapYokW4bFVZ7h6gmbSHtx7hQkKUK0FjFFvFB6jaszIP4D2VNwi?=
 =?us-ascii?Q?mof10Bz6tPYfd+Yz6WQ2H1WxZrrSmk5xS760gsFVkzmv/2jtwRVEAKF40e4s?=
 =?us-ascii?Q?2PUUKPKZ3avGAksbJTjxNvVhWrD1bACjF9rWlY9aA3Vo1FfyAgfFS5pLBkhM?=
 =?us-ascii?Q?gQyee1WfVvoLQ23QfYSYUlaB/VHIlSmJRUrp6eE2J+jmM9VX4ReUy0ZORWyW?=
 =?us-ascii?Q?Q9vBt91E59C1gYVUSLIgaAwpRYcFon6+hw2JG4wfUT21pj7ttf7trArVPYtx?=
 =?us-ascii?Q?SAAo9TJPgLcFJWMJXCLASbONX4Dkm/IJPZue/2f04AV/YkwlWbPWnYdP7ijN?=
 =?us-ascii?Q?RJgFZCXxJqZyAPSw5xywMzWEbTZvxV2Rhf1wczXVaFn9yFx2PU4HyixDOWy/?=
 =?us-ascii?Q?A8CyMsfkz4GF95uZ2kFdcaAysF5kuJ6s2sFB/OQl5yx65l4owSNojj6Gh4ja?=
 =?us-ascii?Q?rSh+I1zLiKJTXxEVVpjm1KFKNlEyiTGPBhQ/c1sfleXhCO17JgkeHi8ZxWGv?=
 =?us-ascii?Q?BxhmE9BHMmu1rSSX4nCErggMwEnH+r8GfqNhLeOVaiojneY+iqh4R6CJMsqe?=
 =?us-ascii?Q?nrvnIEzXCtDj4DrdWkj8mDZhlPnDxg7myI8GAf/22vs0mIv7fKQfME20o4b9?=
 =?us-ascii?Q?qTPls+9UgqF71nOlE5XkrgolnkjzYJxJR3C/8AdO7t9XHuDGf2aFloap0TmB?=
 =?us-ascii?Q?C8pM4I73iVbvZikIWiCzr47hwRiaQF7BRZ6dwpec05QGf08OWsaB3SEXabuA?=
 =?us-ascii?Q?TA2nATlqtTkQkFd2gizM7bgJgjCpN4jqsPJi2pAnGWRF4jrdWUlXULQjHdgo?=
 =?us-ascii?Q?DNZwPcwQ8Oy3VBIqvs7GTZOewsgGMr6N3snplNTPlQnWquRhjl3Kjdk9O987?=
 =?us-ascii?Q?Gxbee9qDtnw0YiDasUhJaOhXMVvyWO2wk7OlfTl+ZtZ3LoZaG/IJ1uJA6Ydw?=
 =?us-ascii?Q?J+9i/ZYVJPoES5i2NC2NKFsXSiZbLyF0GgVoXf9bgLw+dkXghR0dm6yG/YvE?=
 =?us-ascii?Q?LmhtG+W8xPClKyU1PuiWjV9+4k0Ygrf4EZAl0Zx1Flf80ifKWTLQHynT/aWh?=
 =?us-ascii?Q?X2MvAN8S04oB9HgSj5TvmpbuU28RlezKTjtkBpSQ1QTvlEFfqKx7w6nyNZ/S?=
 =?us-ascii?Q?8cnOLrqCuep/xSOKO98zR4VI0x7ecbgYH5cJr8JOF2oMn20YvpbFdf609b+d?=
 =?us-ascii?Q?GOvRDjDlug=3D=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03290f73-813a-4a3f-a017-08da1c2e6dd2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 02:44:56.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rd7lydpAQB4hRwK6Mw+ebHaEBkWVKJ28xvz7VoRN8+SKc3VF7UwOdl4VuWyqhYhZ6azGUuqChSFK6HcMPrks5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4189
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Mon, Apr 11, 2022 at 11:57:33AM +0200, Luca Weiss wrote:
> Hi Jeff,
> 
> On Sat Apr 9, 2022 at 11:15 PM CEST, Jeff LaBundy wrote:
> > Hi Luca,
> >
> > On Fri, Apr 08, 2022 at 01:53:09PM +0200, Luca Weiss wrote:
> > > Add a driver for interfacing with the Awinic AW8695 LRA Haptic Driver.
> > > 
> > > The chip supports multiple modes of which only RAM mode is implemented.
> > > RTP mode would enable a user to "stream" waveform data but to my
> > > knowledge no such user space API exists in the kernel yet.
> > > 
> > > We upload a basic sine wave to the chip and play this on request.
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >  drivers/input/misc/Kconfig          |   11 +
> > >  drivers/input/misc/Makefile         |    1 +
> > >  drivers/input/misc/aw8695-haptics.c | 1391 +++++++++++++++++++++++++++
> > >  3 files changed, 1403 insertions(+)
> > >  create mode 100644 drivers/input/misc/aw8695-haptics.c
> > > 
> > > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > > index dd5227cf8696..40f4ece9075a 100644
> > > --- a/drivers/input/misc/Kconfig
> > > +++ b/drivers/input/misc/Kconfig
> > > @@ -119,6 +119,17 @@ config INPUT_ATMEL_CAPTOUCH
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called atmel_captouch.
> > >  
> > > +config INPUT_AW8695_HAPTICS
> > > +	tristate "Awinic AW8695 haptics support"
> > > +	depends on INPUT && I2C
> > > +	select INPUT_FF_MEMLESS
> > > +	select REGMAP_I2C
> > > +	help
> > > +	  Say Y to enable support for the Awinic AW8695 haptics driver.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module will
> > > +	  be called aw8695-haptics.
> > > +
> > >  config INPUT_BMA150
> > >  	tristate "BMA150/SMB380 acceleration sensor support"
> > >  	depends on I2C
> > > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > > index b92c53a6b5ae..18eb84a7bb17 100644
> > > --- a/drivers/input/misc/Makefile
> > > +++ b/drivers/input/misc/Makefile
> > > @@ -21,6 +21,7 @@ obj-$(CONFIG_INPUT_ATC260X_ONKEY)	+= atc260x-onkey.o
> > >  obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
> > >  obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
> > >  obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
> > > +obj-$(CONFIG_INPUT_AW8695_HAPTICS)	+= aw8695-haptics.o
> > >  obj-$(CONFIG_INPUT_BMA150)		+= bma150.o
> > >  obj-$(CONFIG_INPUT_CM109)		+= cm109.o
> > >  obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
> > > diff --git a/drivers/input/misc/aw8695-haptics.c b/drivers/input/misc/aw8695-haptics.c
> > > new file mode 100644
> > > index 000000000000..a122c8f0fab8
> > > --- /dev/null
> > > +++ b/drivers/input/misc/aw8695-haptics.c
> > > @@ -0,0 +1,1391 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
> > > + *
> > > + * Partially based on vendor driver:
> > > + *   Copyright (c) 2018 AWINIC Technology CO., LTD
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/firmware.h>
> >
> > I do not believe anything from firmware.h is used here.
> 
> I had firmware functionality during development but removed it later.
> 
> >
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/input.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> >
> > Nothing from regulator API either.
> 
> Will remove.
> 
> It seems I can also remove linux/slab.h (apparently mostly used for kfree which
> this driver doesn't need thanks to devm) and need to add linux/bitfield.h for
> e.g. arc architecture (as reported by the buildbot)
> 
> >
> > > +#include <linux/slab.h>
> > > +
> > > +#define AW8695_CHIPID			0x95
> > > +#define AW8695_RESET			0xaa
> > > +/* Default of BASE_ADDR* registers */
> > > +#define AW8695_RAM_BASE_ADDR		0x800
> > > +
> > > +#define AW8695_HIGH_MASK		GENMASK(15, 8)
> > > +#define AW8695_LOW_MASK			GENMASK(7, 0)
> > > +
> > > +/* Chip ID */
> > > +#define AW8695_ID				0x00
> > > +
> > > +/* System Status */
> > > +#define AW8695_SYSST				0x01
> > > +#define AW8695_SYSST_BSTERRS			BIT(7)
> > > +#define AW8695_SYSST_OVS			BIT(6)
> > > +#define AW8695_SYSST_UVLS			BIT(5)
> > > +#define AW8695_SYSST_FF_AES			BIT(4)
> > > +#define AW8695_SYSST_FF_AFS			BIT(3)
> > > +#define AW8695_SYSST_OCDS			BIT(2)
> > > +#define AW8695_SYSST_OTS			BIT(1)
> > > +#define AW8695_SYSST_DONES			BIT(0)
> > > +
> > > +/* System Interrupt */
> > > +#define AW8695_SYSINT				0x02
> > > +#define AW8695_SYSINT_BSTERRI			BIT(7)
> > > +#define AW8695_SYSINT_OVI			BIT(6)
> > > +#define AW8695_SYSINT_UVLI			BIT(5)
> > > +#define AW8695_SYSINT_FF_AEI			BIT(4)
> > > +#define AW8695_SYSINT_FF_AFI			BIT(3)
> > > +#define AW8695_SYSINT_OCDI			BIT(2)
> > > +#define AW8695_SYSINT_OTI			BIT(1)
> > > +#define AW8695_SYSINT_DONEI			BIT(0)
> > > +
> > > +/* System Interrupt Mask */
> > > +#define AW8695_SYSINTM				0x03
> > > +#define AW8695_SYSINTM_BSTERR_OFF		BIT(7)
> > > +#define AW8695_SYSINTM_OV_OFF			BIT(6)
> > > +#define AW8695_SYSINTM_UVLO_OFF			BIT(5)
> > > +#define AW8695_SYSINTM_FF_AE_OFF		BIT(4)
> > > +#define AW8695_SYSINTM_FF_AF_OFF		BIT(3)
> > > +#define AW8695_SYSINTM_OCD_OFF			BIT(2)
> > > +#define AW8695_SYSINTM_OT_OFF			BIT(1)
> > > +#define AW8695_SYSINTM_DONE_OFF			BIT(0)
> > > +
> > > +/* System Control */
> > > +#define AW8695_SYSCTRL				0x04
> > > +#define AW8695_SYSCTRL_WAVDAT_MODE_MASK		GENMASK(7, 6)
> > > +#define AW8695_SYSCTRL_WAVDAT_MODE_4X		(3<<6)
> > > +#define AW8695_SYSCTRL_WAVDAT_MODE_2X		(0<<6)
> > > +#define AW8695_SYSCTRL_WAVDAT_MODE_1X		(1<<6)
> > > +
> > > +#define AW8695_SYSCTRL_RAMINIT_EN		BIT(5)
> > > +
> > > +#define AW8695_SYSCTRL_PLAY_MODE_MASK		GENMASK(3, 2)
> > > +#define AW8695_SYSCTRL_PLAY_MODE_CONT		(2<<2)
> > > +#define AW8695_SYSCTRL_PLAY_MODE_RTP		(1<<2)
> > > +#define AW8695_SYSCTRL_PLAY_MODE_RAM		(0<<2)
> > > +
> > > +#define AW8695_SYSCTRL_BST_MODE_MASK		GENMASK(1, 1)
> > > +#define AW8695_SYSCTRL_BST_MODE_BOOST		(1<<1)
> > > +#define AW8695_SYSCTRL_BST_MODE_BYPASS		(0<<1)
> > > +
> > > +#define AW8695_SYSCTRL_WORK_MODE_MASK		GENMASK(0, 0)
> > > +#define AW8695_SYSCTRL_STANDBY			(1<<0)
> > > +#define AW8695_SYSCTRL_ACTIVE			(0<<0)
> > > +
> > > +/* Process Control */
> > > +#define AW8695_GO				0x05
> > > +#define AW8695_GO_ENABLE			BIT(0)
> > > +
> > > +/* RTP Mode Data */
> > > +#define AW8695_RTP_DATA				0x06
> > > +
> > > +/* Waveform #1 */
> > > +#define AW8695_WAVSEQ1				0x07
> > > +#define AW8695_WAVSEQ1_WAIT			BIT(7)
> > > +#define AW8695_WAVSEQ1_WAV_FRM_SEQ1_MASK	GENMASK(6, 0)
> > > +
> > > +/* Waveform #2 */
> > > +#define AW8695_WAVSEQ2				0x08
> > > +#define AW8695_WAVSEQ2_WAIT			BIT(7)
> > > +#define AW8695_WAVSEQ2_WAV_FRM_SEQ2_MASK	GENMASK(6, 0)
> > > +
> > > +/* Waveform #3 */
> > > +#define AW8695_WAVSEQ3				0x09
> > > +#define AW8695_WAVSEQ3_WAIT			BIT(7)
> > > +#define AW8695_WAVSEQ3_WAV_FRM_SEQ3_MASK	GENMASK(6, 0)
> > > +
> > > +/* Waveform #4 */
> > > +#define AW8695_WAVSEQ4				0x0a
> > > +#define AW8695_WAVSEQ4_WAIT			BIT(7)
> > > +#define AW8695_WAVSEQ4_WAV_FRM_SEQ4_MASK	GENMASK(6, 0)
> > > +
> > > +/* Waveform #5 */
> > > +#define AW8695_WAVSEQ5				0x0b
> > > +#define AW8695_WAVSEQ5_WAIT			BIT(7)
> > > +#define AW8695_WAVSEQ5_WAV_FRM_SEQ5_MASK	GENMASK(6, 0)
> > > +
> > > +/* Waveform #6 */
> > > +#define AW8695_WAVSEQ6				0x0c
> > > +#define AW8695_WAVSEQ6_WAIT			BIT(7)
> > > +#define AW8695_WAVSEQ6_WAV_FRM_SEQ6_MASK	GENMASK(6, 0)
> > > +
> > > +/* Waveform #7 */
> > > +#define AW8695_WAVSEQ7				0x0d
> > > +#define AW8695_WAVSEQ7_WAIT			BIT(7)
> > > +#define AW8695_WAVSEQ7_WAV_FRM_SEQ7_MASK	GENMASK(6, 0)
> > > +
> > > +/* Waveform #8 */
> > > +#define AW8695_WAVSEQ8				0x0e
> > > +#define AW8695_WAVSEQ8_WAIT			BIT(7)
> > > +#define AW8695_WAVSEQ8_WAV_FRM_SEQ8_MASK	GENMASK(6, 0)
> > > +
> > > +/* Waveform Loop #1 */
> > > +#define AW8695_WAVLOOP1				0x0f
> > > +#define AW8695_WAVLOOP1_SEQ1_MASK		GENMASK(7, 4)
> > > +#define AW8695_WAVLOOP1_SEQ2_MASK		GENMASK(3, 0)
> > > +
> > > +/* Waveform Loop #2 */
> > > +#define AW8695_WAVLOOP2				0x10
> > > +#define AW8695_WAVLOOP2_SEQ3_MASK		GENMASK(7, 4)
> > > +#define AW8695_WAVLOOP2_SEQ4_MASK		GENMASK(3, 0)
> > > +
> > > +/* Waveform Loop #3 */
> > > +#define AW8695_WAVLOOP3				0x11
> > > +#define AW8695_WAVLOOP3_SEQ5_MASK		GENMASK(7, 4)
> > > +#define AW8695_WAVLOOP3_SEQ6_MASK		GENMASK(3, 0)
> > > +
> > > +/* Waveform Loop #4 */
> > > +#define AW8695_WAVLOOP4				0x12
> > > +#define AW8695_WAVLOOP4_SEQ7_MASK		GENMASK(7, 4)
> > > +#define AW8695_WAVLOOP4_SEQ8_MASK		GENMASK(3, 0)
> > > +
> > > +/* Main Loop */
> > > +#define AW8695_MAIN_LOOP			0x13
> > > +
> > > +/* TRIG1 Edge Waveform #1 */
> > > +#define AW8695_TRG1_WAV_P			0x14
> > > +
> > > +/* TRIG2 Edge Waveform #1 */
> > > +#define AW8695_TRG2_WAV_P			0x15
> > > +
> > > +/* TRIG3 Edge Waveform #1 */
> > > +#define AW8695_TRG3_WAV_P			0x16
> > > +
> > > +/* TRIG1 Edge Waveform #2 */
> > > +#define AW8695_TRG1_WAV_N			0x17
> > > +
> > > +/* TRIG2 Edge Waveform #2 */
> > > +#define AW8695_TRG2_WAV_N			0x18
> > > +
> > > +/* TRIG3 Edge Waveform #2 */
> > > +#define AW8695_TRG3_WAV_N			0x19
> > > +
> > > +#define AW8695_TRG_PRIO				0x1a
> > > +#define AW8695_PLAYPRIO_GO_MASK			GENMASK(7, 6)
> > > +#define AW8695_PLAYPRIO_TRIG3_MASK		GENMASK(5, 4)
> > > +#define AW8695_PLAYPRIO_TRIG2_MASK		GENMASK(3, 2)
> > > +#define AW8695_PLAYPRIO_TRIG1_MASK		GENMASK(1, 0)
> > > +
> > > +/* Trig Pins Config */
> > > +#define AW8695_TRG_CFG1				0x1b
> > > +#define AW8695_TRGCFG1_TRG3_POLAR_NEG		BIT(5)
> > > +#define AW8695_TRGCFG1_TRG3_EDGE_POS		BIT(4)
> > > +#define AW8695_TRGCFG1_TRG2_POLAR_NEG		BIT(3)
> > > +#define AW8695_TRGCFG1_TRG2_EDGE_POS		BIT(2)
> > > +#define AW8695_TRGCFG1_TRG1_POLAR_NEG		BIT(1)
> > > +#define AW8695_TRGCFG1_TRG1_EDGE_POS		BIT(0)
> > > +
> > > +/* Trig Pins Config */
> > > +#define AW8695_TRG_CFG2				0x1c
> > > +#define AW8695_TRGCFG2_TRG3_ENABLE		BIT(2)
> > > +#define AW8695_TRGCFG2_TRG2_ENABLE		BIT(1)
> > > +#define AW8695_TRGCFG2_TRG1_ENABLE		BIT(0)
> > > +
> > > +/* Debug Control */
> > > +#define AW8695_DBGCTRL				0x20
> > > +#define AW8695_DBGCTRL_INT_EDGE_MODE_MASK	GENMASK(3, 3)
> > > +#define AW8695_DBGCTRL_INT_EDGE_MODE_POS	(1<<3)
> > > +#define AW8695_DBGCTRL_INT_EDGE_MODE_BOTH	(0<<3)
> > > +#define AW8695_DBGCTRL_INT_MODE_MASK		GENMASK(2, 2)
> > > +#define AW8695_DBGCTRL_INT_MODE_EDGE		(1<<2)
> > > +#define AW8695_DBGCTRL_INT_MODE_LEVEL		(0<<2)
> > > +
> > > +/* High Five Bits of Wave SRAM */
> > > +#define AW8695_BASE_ADDRH			0x21
> > > +
> > > +/* Low Eight Bits of Wave SRAM */
> > > +#define AW8695_BASE_ADDRL			0x22
> > > +
> > > +/* High Four Bits of FIFO AE */
> > > +#define AW8695_FIFO_AEH				0x23
> > > +
> > > +/* Low Eight Bits of FIFO AE */
> > > +#define AW8695_FIFO_AEL				0x24
> > > +
> > > +/* High Four Bits of FIFO AF */
> > > +#define AW8695_FIFO_AFH				0x25
> > > +
> > > +/* Low Eight Bits of FIFO AF */
> > > +#define AW8695_FIFO_AFL				0x26
> > > +
> > > +#define AW8695_WAKE_DLY				0x27
> > > +
> > > +#define AW8695_START_DLY			0x28
> > > +
> > > +#define AW8695_END_DLY_H			0x29
> > > +
> > > +#define AW8695_END_DLY_L			0x2a
> > > +
> > > +/* Global Control Data */
> > > +#define AW8695_DATCTRL				0x2b
> > > +#define AW8695_DATCTRL_FC_MASK			GENMASK(6, 6)
> > > +#define AW8695_DATCTRL_FC_1000HZ		(3<<6)
> > > +#define AW8695_DATCTRL_FC_800HZ			(3<<6)
> > > +#define AW8695_DATCTRL_FC_600HZ			(1<<6)
> > > +#define AW8695_DATCTRL_FC_400HZ			(0<<6)
> > > +
> > > +#define AW8695_DATCTRL_LPF_ENABLE_MASK		GENMASK(5, 5)
> > > +#define AW8695_DATCTRL_LPF_ENABLE		(1<<5)
> > > +#define AW8695_DATCTRL_LPF_DISABLE		(0<<5)
> > > +
> > > +#define AW8695_DATCTRL_WAKEMODE_ENABLE_MASK	GENMASK(0, 0)
> > > +#define AW8695_DATCTRL_WAKEMODE_ENABLE		(1<<0)
> > > +#define AW8695_DATCTRL_WAKEMODE_DISABLE		(0<<0)
> > > +
> > > +#define AW8695_PWMDEL				0x2c
> > > +
> > > +/* PWM Output Protect Configuration */
> > > +#define AW8695_PWMPRC				0x2d
> > > +#define AW8695_PWMPRC_PRC_ENABLE		BIT(7)
> > > +
> > > +/* PWM Debug */
> > > +#define AW8695_PWMDBG				0x2e
> > > +#define AW8695_PWMDBG_PWM_MODE_MASK		GENMASK(6, 5)
> > > +#define AW8695_PWMDBG_PWM_12K			(3<<5)
> > > +#define AW8695_PWMDBG_PWM_24K			(2<<5)
> > > +#define AW8695_PWMDBG_PWM_48K			(0<<5)
> > > +
> > > +#define AW8695_LDOCTRL				0x2f
> > > +
> > > +/* Debug Status */
> > > +#define AW8695_DBGSTAT				0x30
> > > +#define AW8695_DBGSTAT_FF_EMPTY			BIT(0)
> > > +
> > > +/* Boost Debug #1 */
> > > +#define AW8695_BSTDBG1				0x31
> > > +
> > > +/* Boost Debug #2 */
> > > +#define AW8695_BSTDBG2				0x32
> > > +
> > > +/* Boost Debug #3 */
> > > +#define AW8695_BSTDBG3				0x33
> > > +
> > > +/* Boost Config */
> > > +#define AW8695_BSTCFG				0x34
> > > +#define AW8695_BSTCFG_PEAKCUR_MASK		GENMASK(2, 0)
> > > +#define AW8695_BSTCFG_PEAKCUR_4A		(7<<0)
> > > +#define AW8695_BSTCFG_PEAKCUR_3P75A		(6<<0)
> > > +#define AW8695_BSTCFG_PEAKCUR_3P5A		(5<<0)
> > > +#define AW8695_BSTCFG_PEAKCUR_3P25A		(4<<0)
> > > +#define AW8695_BSTCFG_PEAKCUR_3A		(3<<0)
> > > +#define AW8695_BSTCFG_PEAKCUR_2P5A		(2<<0)
> > > +#define AW8695_BSTCFG_PEAKCUR_2A		(1<<0)
> > > +#define AW8695_BSTCFG_PEAKCUR_1P5A		(0<<0)
> > > +
> > > +#define AW8695_ANADBG				0x35
> > > +#define AW8695_ANADBG_IOC_MASK			GENMASK(3, 2)
> > > +#define AW8695_ANADBG_IOC_4P65A			(3<<2)
> > > +#define AW8695_ANADBG_IOC_4P15A			(2<<2)
> > > +#define AW8695_ANADBG_IOC_3P65A			(1<<2)
> > > +#define AW8695_ANADBG_IOC_3P15A			(0<<2)
> > > +
> > > +#define AW8695_ANACTRL				0x36
> > > +#define AW8695_ANACTRL_LRA_SRC_MASK		GENMASK(5, 5)
> > > +#define AW8695_ANACTRL_LRA_SRC_REG		(1<<5)
> > > +#define AW8695_ANACTRL_LRA_SRC_EFUSE		(0<<5)
> > > +#define AW8695_ANACTRL_HD_PD_MASK		GENMASK(3, 3)
> > > +#define AW8695_ANACTRL_HD_PD_EN			(1<<3)
> > > +#define AW8695_ANACTRL_HD_HZ_EN			(0<<3)
> > > +
> > > +#define AW8695_CPDBG				0x37
> > > +
> > > +#define AW8695_GLBDBG				0x38
> > > +
> > > +/* Data Gain */
> > > +#define AW8695_DATDBG				0x39
> > > +
> > > +/* Boost Debug #4 */
> > > +#define AW8695_BSTDBG4				0x3a
> > > +#define AW8695_BSTDBG4_BSTVOL_MASK		GENMASK(5, 1)
> > > +
> > > +/* Boost Debug #5 */
> > > +#define AW8695_BSTDBG5				0x3b
> > > +
> > > +/* Boost Debug #6 */
> > > +#define AW8695_BSTDBG6				0x3c
> > > +
> > > +#define AW8695_HDRVDBG				0x3d
> > > +
> > > +/* Waveform Protect Level */
> > > +#define AW8695_PRLVL				0x3e
> > > +#define AW8695_PRLVL_PR_ENABLE			BIT(7)
> > > +#define AW8695_PRLVL_PRLVL_MASK			GENMASK(6, 0)
> > > +
> > > +/* Waveform Protect Period */
> > > +#define AW8695_PRTIME				0x3f
> > > +
> > > +/* SRAM Address 0xhigh */
> > > +#define AW8695_RAMADDRH				0x40
> > > +
> > > +/* SRAM Address 0xlow */
> > > +#define AW8695_RAMADDRL				0x41
> > > +
> > > +/* SRAM Data */
> > > +#define AW8695_RAMDATA				0x42
> > > +
> > > +#define AW8695_GLB_STATE			0x46
> > > +
> > > +#define AW8695_BST_AUTO				0x47
> > > +#define AW8695_BST_AUTO_BST_AUTOSW_MASK		GENMASK(2, 2)
> > > +#define AW8695_BST_AUTO_BST_AUTOMATIC_BOOST	(1<<2)
> > > +#define AW8695_BST_AUTO_BST_MANUAL_BOOST	(0<<2)
> > > +#define AW8695_BST_AUTO_BST_RTP_ENABLE		BIT(1)
> > > +#define AW8695_BST_AUTO_BST_RAM_ENABLE		BIT(0)
> > > +
> > > +/* CONT Mode Control */
> > > +#define AW8695_CONT_CTRL			0x48
> > > +#define AW8695_CONT_CTRL_ZC_DETEC_ENABLE	BIT(7)
> > > +#define AW8695_CONT_CTRL_WAIT_PERIOD_MASK	GENMASK(6, 5)
> > > +#define AW8695_CONT_CTRL_WAIT_8PERIOD		(3<<5)
> > > +#define AW8695_CONT_CTRL_WAIT_4PERIOD		(2<<5)
> > > +#define AW8695_CONT_CTRL_WAIT_2PERIOD		(1<<5)
> > > +#define AW8695_CONT_CTRL_WAIT_1PERIOD		(0<<5)
> > > +#define AW8695_CONT_CTRL_MODE_MASK		GENMASK(4, 4)
> > > +#define AW8695_CONT_CTRL_BY_DRV_TIME		(1<<4)
> > > +#define AW8695_CONT_CTRL_BY_GO_SIGNAL		(0<<4)
> > > +#define AW8695_CONT_CTRL_EN_CLOSE_MASK		GENMASK(3, 3)
> > > +#define AW8695_CONT_CTRL_CLOSE_PLAYBACK		(1<<3)
> > > +#define AW8695_CONT_CTRL_OPEN_PLAYBACK		(0<<3)
> > > +#define AW8695_CONT_CTRL_F0_DETECT_ENABLE	BIT(2)
> > > +#define AW8695_CONT_CTRL_O2C_ENABLE		BIT(1)
> > > +#define AW8695_CONT_CTRL_AUTO_BRK_ENABLE	BIT(0)
> > > +
> > > +/* High 8 Bits Pre Setting f0 Value */
> > > +#define AW8695_F_PRE_H				0x49
> > > +
> > > +/* Low 8 Bits Pre Setting f0 Value */
> > > +#define AW8695_F_PRE_L				0x4a
> > > +
> > > +/* High 4 Bits of Delay Time Setting */
> > > +#define AW8695_TD_H				0x4b
> > > +
> > > +/* Low 8 Bits of Delay Time Setting */
> > > +#define AW8695_TD_L				0x4c
> > > +
> > > +#define AW8695_TSET				0x4d
> > > +
> > > +#define AW8695_TRIM_LRA				0x5b
> > > +
> > > +#define AW8695_R_SPARE				0x5d
> > > +
> > > +#define AW8695_D2SCFG				0x5e
> > > +#define AW8695_D2SCFG_CLK_ADC_MASK		GENMASK(7, 5)
> > > +#define AW8695_D2SCFG_CLK_ASC_0P09375MHZ	(7<<5)
> > > +#define AW8695_D2SCFG_CLK_ASC_0P1875MHZ		(6<<5)
> > > +#define AW8695_D2SCFG_CLK_ASC_0P375MHZ		(5<<5)
> > > +#define AW8695_D2SCFG_CLK_ASC_0P75MHZ		(4<<5)
> > > +#define AW8695_D2SCFG_CLK_ASC_1P5MHZ		(3<<5)
> > > +#define AW8695_D2SCFG_CLK_ASC_3MHZ		(2<<5)
> > > +#define AW8695_D2SCFG_CLK_ASC_6MHZ		(1<<5)
> > > +#define AW8695_D2SCFG_CLK_ASC_12MHZ		(0<<5)
> >
> > There seem to be a lot of unused register masks, many of which seem
> > like internal "chicken bits." If they're not relevant to the driver,
> > consider removing them.
> 
> I kind of wanted to keep them as they're quite complete, and otherwise
> only available in the downstream driver, not even the datasheet.
> 
> But I understand that's it's quite many lines of defines that the driver
> doesn't actually use. Let me know.

I don't think the mainline driver should be responsible for carrying
forward this missing information. As it stands, the register #defines
make up approximately one third of the line count, so I would vote for
trimming them down.

> 
> >
> > > +
> > > +/* Detection Control */
> > > +#define AW8695_DETCTRL				0x5f
> > > +#define AW8695_DETCTRL_RL_OS_MASK		GENMASK(6, 6)
> > > +#define AW8695_DETCTRL_RL_DETECT		(1<<6)
> > > +#define AW8695_DETCTRL_OS_DETECT		(0<<6)
> > > +#define AW8695_DETCTRL_PROTECT_MASK		GENMASK(5, 5)
> > > +#define AW8695_DETCTRL_PROTECT_NO_ACTION	(1<<5)
> > > +#define AW8695_DETCTRL_PROTECT_SHUTDOWN		(0<<5)
> > > +#define AW8695_DETCTRL_ADO_SLOT_MODE_ENABLE	BIT(4)
> > > +#define AW8695_DETCTRL_VBAT_GO_ENABLE		BIT(1)
> > > +#define AW8695_DETCTRL_DIAG_GO_ENABLE		BIT(0)
> > > +
> > > +/* Detected RL of LRA */
> > > +#define AW8695_RLDET				0x60
> > > +
> > > +/* Detected Offset of LRA */
> > > +#define AW8695_OSDET				0x61
> > > +
> > > +/* Detected VBAT */
> > > +#define AW8695_VBATDET				0x62
> > > +
> > > +#define AW8695_TESTDET				0x63
> > > +
> > > +#define AW8695_DETLO				0x64
> > > +
> > > +#define AW8695_BEMFDBG				0x65
> > > +
> > > +/* ADC Test */
> > > +#define AW8695_ADCTEST				0x66
> > > +#define AW8695_ADCTEST_VBAT_MODE_MASK		GENMASK(6, 6)
> > > +#define AW8695_ADCTEST_VBAT_HW_COMP		(1<<6)
> > > +#define AW8695_ADCTEST_VBAT_SW_COMP		(0<<6)
> > > +
> > > +#define AW8695_BEMFTEST				0x67
> > > +
> > > +/* High 8 Bits Detected f0 Value */
> > > +#define AW8695_F_LRA_F0_H			0x68
> > > +
> > > +/* Low 8 Bits Detected f0 Value */
> > > +#define AW8695_F_LRA_F0_L			0x69
> > > +
> > > +/* High 8 Bits CONT_ENG Gotten f0 Value */
> > > +#define AW8695_F_LRA_CONT_H			0x6a
> > > +
> > > +/* Low 8 Bits CONT_ENG Gotten f0 Value */
> > > +#define AW8695_F_LRA_CONT_L			0x6b
> > > +
> > > +#define AW8695_WAIT_VOL_MP			0x6d
> > > +
> > > +#define AW8695_WAIT_VOL_MN			0x6f
> > > +
> > > +#define AW8695_BEMF_VOL_H			0x70
> > > +
> > > +#define AW8695_BEMF_VOL_L			0x71
> > > +
> > > +/* Zero Cross Threshold High 8 Bits Configuration */
> > > +#define AW8695_ZC_THRSH_H			0x72
> > > +
> > > +/* Zero Cross Threshold Low 8 Bits Configuration */
> > > +#define AW8695_ZC_THRSH_L			0x73
> > > +
> > > +#define AW8695_BEMF_VTHH_H			0x74
> > > +
> > > +#define AW8695_BEMF_VTHH_L			0x75
> > > +
> > > +#define AW8695_BEMF_VTHL_H			0x76
> > > +
> > > +#define AW8695_BEMF_VTHL_L			0x77
> > > +
> > > +/* BEMF Detection Cycles Configuration */
> > > +#define AW8695_BEMF_NUM				0x78
> > > +#define AW8695_BEMF_NUM_BRK_MASK		GENMASK(3, 0)
> > > +
> > > +/* Drive Time Setting */
> > > +#define AW8695_DRV_TIME				0x79
> > > +
> > > +/* Non Zero Cross Time Setting */
> > > +#define AW8695_TIME_NZC				0x7a
> > > +
> > > +/* Drive Level Setting */
> > > +#define AW8695_DRV_LVL				0x7b
> > > +
> > > +/* Drive Level for Overdrive Setting */
> > > +#define AW8695_DRV_LVL_OV			0x7c
> > > +
> > > +/* Number Configuration for F0 Trace #1 */
> > > +#define AW8695_NUM_F0_1				0x7d
> > > +#define AW8695_NUM_F0_1_PRE_MASK		GENMASK(7, 4)
> > > +#define AW8695_NUM_F0_1_WAIT_MASK		GENMASK(3, 0)
> > > +
> > > +/* Number Configuration for F0 Trace #2 */
> > > +#define AW8695_NUM_F0_2				0x7e
> > > +
> > > +/* Number Configuration for F0 Trace #3 */
> > > +#define AW8695_NUM_F0_3				0x7f
> > > +
> > > +#define AW8695_MAX_REG				0x7f
> > > +
> > > +enum aw8695_work_mode {
> > > +	AW8695_STANDBY_MODE,
> > > +	AW8695_RAM_MODE,
> > > +	AW8695_RTP_MODE,
> > > +	AW8695_TRIG_MODE,
> > > +	AW8695_CONT_MODE,
> > > +};
> > > +
> > > +struct aw8695_data {
> > > +	struct input_dev *input_dev;
> > > +	struct i2c_client *client;
> > > +	struct regmap *regmap;
> > > +	struct gpio_desc *reset_gpio;
> > > +	bool running;
> > > +	struct work_struct play_work;
> > > +	/* Parameters from devicetree */
> > > +	u32 f0_preset;
> > > +	u32 f0_coefficient;
> > > +	u32 f0_cali_percent;
> > > +	u32 drive_level;
> > > +	u32 f0_det_play;
> > > +	u32 f0_det_wait;
> > > +	u32 f0_det_repeat;
> > > +	u32 f0_det_trace;
> > > +	u8 boost_debug[3];
> > > +	u8 tset;
> > > +	u8 r_spare;
> > > +	u32 bemf_vthh;
> > > +	u32 bemf_vthl;
> > > +};
> > > +
> > > +/*
> > > + * Sine wave representing the magnitude of the drive to be used.
> > > + * Data is encoded in two's complement.
> > > + *   round(84 * sin(x / 16.25))
> > > + */
> > > +static const u8 aw8695_sine_waveform[] = {
> > > +	0x00, 0x05, 0x0a, 0x0f, 0x14, 0x19, 0x1e, 0x23, 0x28, 0x2c, 0x30, 0x35,
> > > +	0x39, 0x3c, 0x40, 0x43, 0x46, 0x49, 0x4b, 0x4d, 0x4f, 0x51, 0x52, 0x53,
> > > +	0x54, 0x54, 0x54, 0x54, 0x53, 0x52, 0x51, 0x4f, 0x4d, 0x4b, 0x49, 0x46,
> > > +	0x43, 0x40, 0x3c, 0x39, 0x35, 0x31, 0x2c, 0x28, 0x23, 0x1f, 0x1a, 0x15,
> > > +	0x10, 0x0b, 0x05, 0x00, 0xfb, 0xf6, 0xf1, 0xec, 0xe7, 0xe2, 0xdd, 0xd9,
> > > +	0xd4, 0xd0, 0xcc, 0xc8, 0xc4, 0xc0, 0xbd, 0xba, 0xb7, 0xb5, 0xb3, 0xb1,
> > > +	0xaf, 0xae, 0xad, 0xac, 0xac, 0xac, 0xac, 0xad, 0xae, 0xaf, 0xb1, 0xb2,
> > > +	0xb5, 0xb7, 0xba, 0xbd, 0xc0, 0xc3, 0xc7, 0xcb, 0xcf, 0xd3, 0xd8, 0xdc,
> > > +	0xe1, 0xe6, 0xeb, 0xf0, 0xf5, 0xfa
> > > +};
> > > +
> > > +/*
> > > + * Header that gets written to AW8695 SRAM that describes the available
> > > + * waveforms being transferred afterwards.
> > > + *
> > > + * @version: waveform library version
> > > + * @start_address: start address of waveform in SRAM
> > > + * @end_address: end address of waveform in SRAM
> > > + */
> > > +struct aw8695_sram_waveform_header {
> > > +	u8 version;
> > > +	struct {
> > > +		__be16 start_address;
> > > +		__be16 end_address;
> > > +	} __packed waveform_address[1];
> > > +} __packed;
> >
> > Is there any reason to have an array-of-one here? It seems to unnecessarily
> > make the below definition harder to read.
> 
> I needed to "hardcode" the array size here because we use the size of
> the header below.
> 
> We might want to add a different wave at a later point, e.g. square wave
> or something (something that's not the sign wave from above), then this
> would be increased to two, and the struct usage below updated to add the
> second wave and change the addresses.
> I thought putting this data into a struct makes it more obvious what's
> actually going on in the SRAM of the device.

Since waveform_address[] appears at the end, can you simply define it
as a flexible array member? This way you do not have to hack the struct
definition every time you grow sram_waveform_header.

This begs the question as to whether a hard-coded sine wave belongs in
the driver, which has to be hacked each time a new waveform is added.

Can you bring them in from a file using request_firmware instead? This way
someone could generate waveforms using a simple Python script, etc. Maybe
something to save for later.

On a related note, what is the point of supporting f0 calibration later in
the driver if only a hard-coded sine wave is driven? Can the device not
generate sine waves on its own?

> 
> >
> > > +
> > > +static const struct aw8695_sram_waveform_header sram_waveform_header = {
> > > +	.version = 0x01,
> > > +	.waveform_address = {
> > > +		/* Simple sine wave defined above */
> > > +		{
> > > +			.start_address = cpu_to_be16(AW8695_RAM_BASE_ADDR +
> > > +				sizeof(struct aw8695_sram_waveform_header)),
> > > +			.end_address = cpu_to_be16(AW8695_RAM_BASE_ADDR +
> > > +				sizeof(struct aw8695_sram_waveform_header) +
> > > +				ARRAY_SIZE(aw8695_sine_waveform) - 1),
> > > +		}
> > > +	}
> > > +};
> > > +
> > > +static int aw8695_interrupt_clear(struct aw8695_data *haptics)
> > > +{
> > > +	unsigned int read_buf;
> > > +
> > > +	/* Clear UVLI bit by reading register */
> > > +	return regmap_read(haptics->regmap, AW8695_SYSINT, &read_buf);
> > > +}
> > > +
> > > +static int aw8695_haptic_set_active(struct aw8695_data *haptics)
> > > +{
> > > +	int err;
> >
> > The general practice in input subsystem has been to use 'error' rather than
> > 'err' or 'ret' for return values that either return zero or an -errno.
> 
> Sure, I could replace all err variable names with error, but I'm also not
> the first person to use "err" in the input subsystem.
> 
> $ git grep "int err;" drivers/input/ | wc -l
> 180
> $ git grep "int error;" drivers/input/ | wc -l
> 863
> 
> Let me know.

It is of course Dmitry's call, but for a brand new driver, I would stick
with what is 5x more common.

> 
> >
> > > +
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +		AW8695_SYSCTRL_WORK_MODE_MASK, AW8695_SYSCTRL_ACTIVE);
> >
> > This seems easier to read if indented as follows:
> >
> >         error = regmap_update_bits(...,
> >                                    ...);
> >
> > ...and elsewhere throughout.
> 
> If I indent this example to this format
> 
> 	err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
> 		AW8695_CONT_CTRL_F0_DETECT_ENABLE, AW8695_CONT_CTRL_F0_DETECT_ENABLE);
> 
> then the line becomes too long and would need to become
> 
> 	err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
> 				 AW8695_CONT_CTRL_F0_DETECT_ENABLE,
> 				 AW8695_CONT_CTRL_F0_DETECT_ENABLE);
> 
> Let me know if I should change.

In my humble opinion, the existing single-tab indentation is difficult to
read, especially later on where multiple lines are packed along with if's
that are necessarily indented by one tab.

The new example you've shown is much more readable and is exactly what I
am suggesting.

> 
> >
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = aw8695_interrupt_clear(haptics);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return regmap_update_bits(haptics->regmap, AW8695_SYSINTM,
> > > +		AW8695_SYSINTM_UVLO_OFF, 0);
> > > +}
> > > +
> > > +static int aw8695_set_work_mode(struct aw8695_data *haptics,
> > > +				 enum aw8695_work_mode mode)
> > > +{
> > > +	struct device *dev = &haptics->client->dev;
> > > +	int err;
> > > +
> > > +	switch (mode) {
> > > +	case AW8695_STANDBY_MODE:
> > > +		err = regmap_update_bits(haptics->regmap, AW8695_SYSINTM,
> > > +			AW8695_SYSINTM_UVLO_OFF, AW8695_SYSINTM_UVLO_OFF);
> > > +		if (err)
> > > +			return err;
> > > +		err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +			AW8695_SYSCTRL_WORK_MODE_MASK, AW8695_SYSCTRL_STANDBY);
> > > +		if (err)
> > > +			return err;
> > > +		break;
> > > +	case AW8695_RAM_MODE:
> > > +		err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +			AW8695_SYSCTRL_PLAY_MODE_MASK, AW8695_SYSCTRL_PLAY_MODE_RAM);
> > > +		if (err)
> > > +			return err;
> > > +		err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +			AW8695_SYSCTRL_BST_MODE_MASK, AW8695_SYSCTRL_BST_MODE_BYPASS);
> > > +		if (err)
> > > +			return err;
> > > +		err = aw8695_haptic_set_active(haptics);
> > > +		if (err)
> > > +			return err;
> > > +		break;
> > > +	case AW8695_CONT_MODE:
> > > +		err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +			AW8695_SYSCTRL_PLAY_MODE_MASK, AW8695_SYSCTRL_PLAY_MODE_CONT);
> > > +		if (err)
> > > +			return err;
> > > +		err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +			AW8695_SYSCTRL_BST_MODE_MASK, AW8695_SYSCTRL_BST_MODE_BYPASS);
> > > +		if (err)
> > > +			return err;
> > > +		err = aw8695_haptic_set_active(haptics);
> > > +		if (err)
> > > +			return err;
> > > +		break;
> > > +	default:
> > > +		dev_err(dev, "Unhandled mode: %d\n", mode);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return err;
> >
> > This is largely personal preference, but since you don't have to do any
> > clean-up down here, you can simply return from each case as opposed to
> > breaking just to return.
> 
> It seems if we return from each case then we can also remove the final
> return. As I don't foresee anyone adding new code after the switch, I
> will change.

Agreed; it seems this will save several lines.

> 
> >
> > > +}
> > > +
> > > +static int aw8695_haptics_play(struct input_dev *dev, void *data,
> > > +			       struct ff_effect *effect)
> > > +{
> > > +	struct aw8695_data *haptics = input_get_drvdata(dev);
> > > +	int level;
> > > +
> > > +	level = effect->u.rumble.strong_magnitude;
> > > +	if (!level)
> > > +		level = effect->u.rumble.weak_magnitude;
> > > +
> > > +	haptics->running = level;
> > > +	schedule_work(&haptics->play_work);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int aw8695_haptics_stop(struct aw8695_data *haptics)
> > > +{
> > > +	int err;
> > > +	unsigned int read_buf;
> > > +	struct device *dev = &haptics->client->dev;
> > > +
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_GO,
> > > +		AW8695_GO_ENABLE, 0);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_read_poll_timeout(haptics->regmap, AW8695_GLB_STATE, read_buf,
> > > +			(read_buf & 0x0f) == 0, 2000, 2000 * 100);
> > > +	if (err) {
> > > +		dev_err(dev, "Did not enter standby: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	return aw8695_set_work_mode(haptics, AW8695_STANDBY_MODE);
> > > +}
> > > +
> > > +static int aw8695_haptics_start(struct aw8695_data *haptics)
> > > +{
> > > +	int err;
> > > +
> > > +	err = aw8695_haptics_stop(haptics);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Configure for waveform #1 to be played infinitely */
> > > +	err = regmap_write(haptics->regmap, AW8695_WAVSEQ1, 0x1);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_WAVLOOP1,
> > > +		AW8695_WAVLOOP1_SEQ1_MASK, 0xf0);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_write(haptics->regmap, AW8695_WAVSEQ2, 0x0);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_WAVLOOP1,
> > > +		AW8695_WAVLOOP1_SEQ2_MASK, 0x0);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Configure for RAM mode */
> > > +	err = aw8695_set_work_mode(haptics, AW8695_RAM_MODE);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Start vibration */
> > > +	return regmap_update_bits(haptics->regmap, AW8695_GO,
> > > +		AW8695_GO_ENABLE, AW8695_GO_ENABLE);
> > > +}
> > > +
> > > +static void aw8695_close(struct input_dev *input)
> > > +{
> > > +	struct aw8695_data *haptics = input_get_drvdata(input);
> > > +	struct device *dev = &haptics->client->dev;
> > > +	int err;
> > > +
> > > +	cancel_work_sync(&haptics->play_work);
> > > +	err = aw8695_haptics_stop(haptics);
> > > +	if (err)
> > > +		dev_err(dev, "Failed to stop haptics: %d\n", err);
> > > +}
> > > +
> > > +static void aw8695_haptics_play_work(struct work_struct *work)
> > > +{
> > > +	struct aw8695_data *haptics =
> > > +		container_of(work, struct aw8695_data, play_work);
> > > +	struct device *dev = &haptics->client->dev;
> > > +	int err;
> > > +
> > > +	if (haptics->running)
> > > +		err = aw8695_haptics_start(haptics);
> > > +	else
> > > +		err = aw8695_haptics_stop(haptics);
> > > +
> > > +	if (err)
> > > +		dev_err(dev, "Failed to execute work command: %d\n", err);
> > > +}
> > > +
> > > +static void aw8695_hw_reset(struct aw8695_data *haptics)
> > > +{
> > > +	/* Pull reset low */
> > > +	gpiod_set_value_cansleep(haptics->reset_gpio, 0);
> >
> > This is backwards. gpiod API accepts logical level, so you should pass
> > a 1 here and define the pin as GPIO_ACTIVE_LOW in dts assuming the pin
> > is in fact active-low.
> 
> Good catch, I took this over from downstream driver. I'm easily confused
> with the active-high/active-low so didn't think much about it ;)
> Probably the way to think here (after the change) is "assert reset pin"
> which on hardware side (configured in dts) means pull it low and then
> later "deassert reset pin" which on hardware side means pull high.
> 
> The datasheet indeed mentions it's a active-low hardware reset, with
> high meaning active/standby mode and low power-down mode.
> 
> Will update all 3 patches to reflect this.

Your understanding is correct on all counts.

> 
> >
> > > +
> > > +	/* Wait ~1ms */
> >
> > These comments just add noise; there is no question as to what the line
> > below is doing. Alternatively, you could say something like "satisfy the
> > minimum reset pulse width specified in the datasheet," etc.
> 
> Will remove them.
> 
> >
> > > +	usleep_range(1000, 2000);
> > > +
> > > +	/* Pull reset high */
> > > +	gpiod_set_value_cansleep(haptics->reset_gpio, 1);
> >
> > Same here; this should be zero (i.e. deassert). I also recommend leaving
> > out any comments about high/low in case the board has an inverter or glue
> > logic, in which case dts is responsible for specifying the polarity.
> 
> Sure, will adjust.
> 
> >
> > > +
> > > +	/* Wait ~3.5ms until I2C is accessible */
> > > +	usleep_range(3500, 4000);
> > > +}
> > > +
> > > +static int aw8695_haptic_offset_calibration(struct aw8695_data *haptics)
> > > +{
> > > +	unsigned int read_buf;
> > > +	int err;
> > > +
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +		AW8695_SYSCTRL_RAMINIT_EN, AW8695_SYSCTRL_RAMINIT_EN);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_DETCTRL,
> > > +		AW8695_DETCTRL_DIAG_GO_ENABLE, AW8695_DETCTRL_DIAG_GO_ENABLE);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_read_poll_timeout(haptics->regmap, AW8695_DETCTRL, read_buf,
> > > +			(read_buf & AW8695_DETCTRL_DIAG_GO_ENABLE) == 0, 10000, 10000 * 50);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +		AW8695_SYSCTRL_RAMINIT_EN, 0);
> > > +}
> > > +
> > > +static int aw8695_haptic_read_f0(struct aw8695_data *haptics)
> > > +{
> > > +	struct device *dev = &haptics->client->dev;
> > > +	unsigned long f0;
> > > +	unsigned int f0_reg;
> > > +	unsigned int read_buf;
> > > +	int err;
> > > +
> > > +	err = regmap_read(haptics->regmap, AW8695_F_LRA_F0_H, &read_buf);
> > > +	if (err)
> > > +		return err;
> > > +	f0_reg = FIELD_PREP(AW8695_HIGH_MASK, read_buf);
> > > +
> > > +	err = regmap_read(haptics->regmap, AW8695_F_LRA_F0_L, &read_buf);
> > > +	if (err)
> > > +		return err;
> > > +	f0_reg |= FIELD_PREP(AW8695_LOW_MASK, read_buf);
> > > +
> > > +	if (!f0_reg) {
> > > +		dev_err(dev, "Failed to read f0 value!\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	f0 = 1000000000 / (f0_reg * haptics->f0_coefficient);
> > > +	dev_dbg(dev, "Read new f0: %d\n", (int)f0);
> > > +
> > > +	return (int)f0;
> > > +}
> > > +
> > > +static int aw8695_haptic_get_f0(struct aw8695_data *haptics)
> > > +{
> > > +	struct device *dev = &haptics->client->dev;
> > > +	unsigned int read_buf;
> > > +	unsigned int f0_trace_ms;
> > > +	unsigned int f0_reg;
> > > +	int f0;
> > > +	int err;
> > > +
> > > +	err = aw8695_haptics_stop(haptics);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_write(haptics->regmap, AW8695_TRIM_LRA, 0x00);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = aw8695_set_work_mode(haptics, AW8695_CONT_MODE);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
> > > +		AW8695_CONT_CTRL_EN_CLOSE_MASK, AW8695_CONT_CTRL_OPEN_PLAYBACK);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
> > > +		AW8695_CONT_CTRL_F0_DETECT_ENABLE, AW8695_CONT_CTRL_F0_DETECT_ENABLE);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* LPF */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_DATCTRL,
> > > +		AW8695_DATCTRL_FC_MASK, AW8695_DATCTRL_FC_1000HZ);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_DATCTRL,
> > > +		AW8695_DATCTRL_LPF_ENABLE_MASK, AW8695_DATCTRL_LPF_ENABLE);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* LRA OSC Source */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_ANACTRL,
> > > +		AW8695_ANACTRL_LRA_SRC_MASK, AW8695_ANACTRL_LRA_SRC_REG);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* preset f0 */
> > > +	f0_reg = 1000000000 / (haptics->f0_preset * haptics->f0_coefficient);
> > > +	err = regmap_write(haptics->regmap, AW8695_F_PRE_H,
> > > +			FIELD_GET(AW8695_HIGH_MASK, f0_reg));
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_write(haptics->regmap, AW8695_F_PRE_L,
> > > +			FIELD_GET(AW8695_LOW_MASK, f0_reg));
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* f0 driver level */
> > > +	err = regmap_write(haptics->regmap, AW8695_DRV_LVL, haptics->drive_level);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* f0 trace parameter */
> > > +	err = regmap_write(haptics->regmap, AW8695_NUM_F0_1,
> > > +			FIELD_PREP(AW8695_NUM_F0_1_PRE_MASK, haptics->f0_det_play) |
> > > +			FIELD_PREP(AW8695_NUM_F0_1_WAIT_MASK, haptics->f0_det_wait));
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_write(haptics->regmap, AW8695_NUM_F0_2, haptics->f0_det_repeat);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_write(haptics->regmap, AW8695_NUM_F0_3, haptics->f0_det_trace);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = aw8695_interrupt_clear(haptics);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* play go and start f0 calibration */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_GO,
> > > +		AW8695_GO_ENABLE, AW8695_GO_ENABLE);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* f0 trace time */
> > > +	f0_trace_ms =
> > > +		(1000 * 10 / haptics->f0_preset) * (haptics->f0_det_play + haptics->f0_det_wait +
> > > +		(haptics->f0_det_trace + haptics->f0_det_wait) * (haptics->f0_det_repeat - 1));
> > > +	usleep_range(f0_trace_ms * 1000, f0_trace_ms * 1000 + 500);
> > > +
> > > +	err = regmap_read_poll_timeout(haptics->regmap, AW8695_GLB_STATE, read_buf,
> > > +			(read_buf & 0x0f) == 0, 10000, 10000 * 50);
> > > +	if (err) {
> > > +		dev_err(dev, "Did not enter standby: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	f0 = aw8695_haptic_read_f0(haptics);
> >
> >         if (f0 < 0)
> >                 return f0;
> >
> 
> Missed that, thanks!
> 
> > > +
> > > +	/* restore default config */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
> > > +		AW8695_CONT_CTRL_EN_CLOSE_MASK, AW8695_CONT_CTRL_CLOSE_PLAYBACK);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_CONT_CTRL,
> > > +		AW8695_CONT_CTRL_F0_DETECT_ENABLE, 0);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return f0;
> > > +}
> > > +
> >
> > Nit: extra NL here.
> 
> Thanks :)
> 
> >
> > > +
> > > +static int aw8695_haptic_f0_calibration(struct aw8695_data *haptics)
> > > +{
> > > +	struct device *dev = &haptics->client->dev;
> > > +	unsigned int read_buf;
> > > +	int f0_cali_step, f0_limit, f0;
> > > +	char f0_cali_lra;
> > > +	int err;
> > > +
> >
> > ...and here.
> >
> > > +
> > > +	f0 = aw8695_haptic_get_f0(haptics);
> > > +	if (f0 < 0) {
> > > +		dev_err(dev, "Failed to read f0: %d\n", f0);
> > > +		return f0;
> > > +	}
> > > +
> > > +	/* make sure the f0_limit is not more than f0_cali_percent % away from read f0 */
> > > +	if (f0 * 100 < haptics->f0_preset * (100 - haptics->f0_cali_percent) ||
> > > +	    f0 * 100 > haptics->f0_preset * (100 + haptics->f0_cali_percent)) {
> > > +		f0_limit = (int)haptics->f0_preset;
> > > +	} else {
> > > +		f0_limit = (int)f0;
> > > +	}
> > > +
> > > +	/* calculate cali step */
> > > +	f0_cali_step = 100000 * (f0_limit - (int)haptics->f0_preset) /
> > > +		(f0_limit * 25);
> > > +
> > > +	if (f0_cali_step >= 0) {
> > > +		if (f0_cali_step % 10 >= 5)
> > > +			f0_cali_step = f0_cali_step / 10 + 1 + 32;
> > > +		else
> > > +			f0_cali_step = f0_cali_step / 10 + 32;
> > > +	} else {
> > > +		if (f0_cali_step % 10 <= -5)
> > > +			f0_cali_step = 32 + (f0_cali_step / 10 - 1);
> > > +		else
> > > +			f0_cali_step = 32 + f0_cali_step / 10;
> > > +	}
> > > +
> > > +	if (f0_cali_step > 31)
> > > +		f0_cali_lra = (char)f0_cali_step - 32;
> > > +	else
> > > +		f0_cali_lra = (char)f0_cali_step + 32;
> > > +
> > > +	err = regmap_write(haptics->regmap, AW8695_TRIM_LRA, f0_cali_lra);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_read(haptics->regmap, AW8695_TRIM_LRA, &read_buf);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	dev_dbg(dev, "Calibrated TRIM_LRA: %x\n", read_buf);
> > > +
> > > +	/* restore default work mode */
> > > +	err = aw8695_set_work_mode(haptics, AW8695_STANDBY_MODE);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +		AW8695_SYSCTRL_PLAY_MODE_MASK, AW8695_SYSCTRL_PLAY_MODE_RAM);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return aw8695_haptics_stop(haptics);
> > > +}
> > > +
> > > +static int aw8695_init(struct aw8695_data *haptics)
> > > +{
> > > +	int err;
> > > +	unsigned int read_buf;
> > > +	struct device *dev = &haptics->client->dev;
> > > +
> > > +	aw8695_hw_reset(haptics);
> > > +
> > > +	err = regmap_read(haptics->regmap, AW8695_ID, &read_buf);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to read ID register: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	if (read_buf != AW8695_CHIPID) {
> > > +		dev_err(dev, "Chip ID mismatch: expected %x, got %x\n",
> > > +			AW8695_CHIPID, read_buf);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	err = regmap_write(haptics->regmap, AW8695_ID, AW8695_RESET);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to reset: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	/* Wait ~1ms after reset */
> > > +	usleep_range(1000, 1500);
> >
> > Why to issue a software reset and wait again if we have already done a
> > hardware reset?
> 
> The datasheet doesn't mention anything about the hardware reset, only
> that the software reset will reset the circuits and all registers.
> 
> Generally the sequences in this driver are taken over from the downstream
> driver so I'm unsure of the reasons why the exist in the first place.

Interesting; typically one does one or the other (if at all) unless the
vendor has published an erratum specifically stating otherwise.

> 
> >
> > > +
> > > +	/* Clear UVLI bit by reading register */
> > > +	err = aw8695_interrupt_clear(haptics);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to clear interrupt: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	/* Set interrupt mode to edge */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_DBGCTRL,
> > > +		AW8695_DBGCTRL_INT_MODE_MASK,
> > > +		AW8695_DBGCTRL_INT_MODE_EDGE);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to set interrupt mode: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	/* Configure interrupts */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_SYSINTM,
> > > +		AW8695_SYSINTM_BSTERR_OFF, AW8695_SYSINTM_BSTERR_OFF);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_SYSINTM,
> > > +		AW8695_SYSINTM_OV_OFF, 0);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_SYSINTM,
> > > +		AW8695_SYSINTM_UVLO_OFF, 0);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_SYSINTM,
> > > +		AW8695_SYSINTM_OCD_OFF, 0);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_SYSINTM,
> > > +		AW8695_SYSINTM_OT_OFF, 0);
> > > +	if (err)
> > > +		return err;
> >
> > These masks are all part of the same register; it seems wasteful to do
> > five read-modify-write operations. Assuming there is no requirement that
> > the bits are written in a sequence, just do something like:
> >
> >         error = regmap_update_bits(haptics->regmap, AW8695_SYSINTM,
> >                                    a | b | c | d | e, 0);
> >
> > ...or just use regmap_write(), assuming the rest of the bits represent
> > other interrupt sources that will remain masked.
> 
> Will switch to updating all bits at once, and hope that it will still
> work correctly.
> 
> >
> > > +
> > > +	err = aw8695_set_work_mode(haptics, AW8695_STANDBY_MODE);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_PWMDBG,
> > > +		AW8695_PWMDBG_PWM_MODE_MASK, AW8695_PWMDBG_PWM_24K);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_write(haptics->regmap, AW8695_BSTDBG1, haptics->boost_debug[0]);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_write(haptics->regmap, AW8695_BSTDBG2, haptics->boost_debug[1]);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_write(haptics->regmap, AW8695_BSTDBG3, haptics->boost_debug[2]);
> > > +	if (err)
> > > +		return err;
> >
> > Will a bulk write not work here?
> 
> Seems appropriate, but will wait if anything develops in the dt-bindings
> patch regarding including the register values in dt - unfortunately
> undocumented values.
> 
> >
> > > +	err = regmap_write(haptics->regmap, AW8695_TSET, haptics->tset);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_write(haptics->regmap, AW8695_R_SPARE, haptics->r_spare);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_ANADBG,
> > > +		AW8695_ANADBG_IOC_MASK, AW8695_ANADBG_IOC_4P65A);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Set boost peak current */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_BSTCFG,
> > > +		AW8695_BSTCFG_PEAKCUR_MASK, AW8695_BSTCFG_PEAKCUR_2A);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Adjust motorprotect config */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_DETCTRL,
> > > +		AW8695_DETCTRL_PROTECT_MASK, AW8695_DETCTRL_PROTECT_NO_ACTION);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_PWMPRC,
> > > +		AW8695_PWMPRC_PRC_ENABLE, 0);
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_PRLVL,
> > > +		AW8695_PRLVL_PR_ENABLE, 0);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Adjust auto boost config */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_BST_AUTO,
> > > +		AW8695_BST_AUTO_BST_AUTOSW_MASK,
> > > +		AW8695_BST_AUTO_BST_MANUAL_BOOST);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = aw8695_haptic_offset_calibration(haptics);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Set vbat compensation mode */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_ADCTEST,
> > > +		AW8695_ADCTEST_VBAT_MODE_MASK, AW8695_ADCTEST_VBAT_HW_COMP);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = aw8695_haptic_f0_calibration(haptics);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* beme config */
> > > +	err = regmap_write(haptics->regmap, AW8695_BEMF_VTHH_H,
> > > +			FIELD_GET(AW8695_HIGH_MASK, haptics->bemf_vthh));
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_write(haptics->regmap, AW8695_BEMF_VTHH_L,
> > > +			FIELD_GET(AW8695_LOW_MASK, haptics->bemf_vthh));
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_write(haptics->regmap, AW8695_BEMF_VTHL_H,
> > > +			FIELD_GET(AW8695_HIGH_MASK, haptics->bemf_vthl));
> > > +	if (err)
> > > +		return err;
> > > +	return regmap_write(haptics->regmap, AW8695_BEMF_VTHL_L,
> > > +			FIELD_GET(AW8695_LOW_MASK, haptics->bemf_vthl));
> > > +}
> > > +
> > > +static int aw8695_ram_init(struct aw8695_data *haptics)
> > > +{
> > > +	unsigned char *ptr;
> > > +	int err;
> > > +	int i;
> > > +
> > > +	/* Enable SRAM init */
> > > +	err = regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +		AW8695_SYSCTRL_RAMINIT_EN, AW8695_SYSCTRL_RAMINIT_EN);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Set RAMDATA write address */
> > > +	err = regmap_write(haptics->regmap, AW8695_RAMADDRH,
> > > +		FIELD_GET(AW8695_HIGH_MASK, AW8695_RAM_BASE_ADDR));
> > > +	if (err)
> > > +		return err;
> > > +	err = regmap_write(haptics->regmap, AW8695_RAMADDRL,
> > > +		FIELD_GET(AW8695_LOW_MASK, AW8695_RAM_BASE_ADDR));
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Write waveform header */
> > > +	ptr = (unsigned char *) &sram_waveform_header;
> > > +	for (i = 0; i < sizeof(sram_waveform_header); i++) {
> > > +		err = regmap_write(haptics->regmap, AW8695_RAMDATA,
> > > +			ptr[i]);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > > +	/* Write waveform data */
> > > +	for (i = 0; i < ARRAY_SIZE(aw8695_sine_waveform); i++) {
> > > +		err = regmap_write(haptics->regmap, AW8695_RAMDATA,
> > > +			aw8695_sine_waveform[i]);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > > +	/* Disable SRAM init */
> > > +	return regmap_update_bits(haptics->regmap, AW8695_SYSCTRL,
> > > +		AW8695_SYSCTRL_RAMINIT_EN, 0);
> > > +}
> > > +
> > > +static irqreturn_t aw8695_irq(int irq, void *data)
> > > +{
> > > +	struct aw8695_data *haptics = data;
> > > +	struct device *dev = &haptics->client->dev;
> > > +	unsigned int read_buf;
> > > +	int err;
> > > +
> > > +	err = regmap_read(haptics->regmap, AW8695_SYSINT, &read_buf);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to read SYSINT register: %d\n", err);
> > > +		return err;
> > > +	}
> > > +	dev_dbg(dev, "Interrupt: SYSINT=0x%x\n", read_buf);
> > > +
> > > +	if (read_buf & AW8695_SYSINT_BSTERRI)
> > > +		dev_err(dev, "Received boost short circuit protection or over-voltage protection interrupt!\n");
> > > +	if (read_buf & AW8695_SYSINT_OVI)
> > > +		dev_err(dev, "Received wave data overflow or DPWM DC error interrupt!\n");
> > > +	if (read_buf & AW8695_SYSINT_UVLI)
> > > +		dev_err(dev, "Received under voltage lock out interrupt!\n");
> > > +	if (read_buf & AW8695_SYSINT_OCDI)
> > > +		dev_err(dev, "Received over current interrupt!\n");
> > > +	if (read_buf & AW8695_SYSINT_OTI)
> > > +		dev_err(dev, "Received over temperature interrupt!\n");
> >
> > Just to confirm, is the system not responsible for taking any action in
> > case these errors occur, such as toggle a power-up/down bit?
> 
> Again, the datasheet doesn't mention anything, but the downstream driver
> also doesn't do more than reset some logic in the driver for
> functionality that isn't implemented here (audio_ready, haptic_read,
> pre_haptic_number & rtp_routine_on).
> From what I understand the aw8695 itself makes sure that it disables
> itself in case of these errors.

Fair enough.

> 
> >
> > > +
> > > +	if (read_buf & AW8695_SYSINT_DONEI)
> > > +		dev_dbg(dev, "Received playback done interrupt\n");
> > > +	/* FIFO mode is not (yet) implemented in this driver */
> > > +	if (read_buf & AW8695_SYSINT_FF_AEI)
> > > +		dev_dbg(dev, "Received FIFO almost empty interrupt\n");
> > > +	if (read_buf & AW8695_SYSINT_FF_AFI)
> > > +		dev_dbg(dev, "Received FIFO almost full interrupt\n");
> > > +
> > > +	err = regmap_read(haptics->regmap, AW8695_DBGSTAT, &read_buf);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to read DBGSTAT register: %d\n", err);
> > > +		return err;
> >
> > Here you are returning an int, but the function is of type irqreturn_t.
> > Since the device appears to implement clear-on-read interrupt registers,
> > consider returning IRQ_NONE in this case (i.e. interrupt was not handled).
> 
> Makes sense, will update the error returns in this function.
> 
> >
> > > +	}
> > > +	dev_dbg(dev, "Interrupt: DBGSTAT=0x%x\n", read_buf);
> > > +
> > > +	err = regmap_read(haptics->regmap, AW8695_SYSST, &read_buf);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to read SYSST register: %d\n", err);
> > > +		return err;
> > > +	}
> > > +	dev_dbg(dev, "Interrupt: SYSST=0x%x\n", read_buf);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static const struct regmap_config aw8695_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +
> > > +	.max_register = AW8695_MAX_REG,
> > > +	.cache_type = REGCACHE_NONE,
> > > +};
> > > +
> > > +static int aw8695_probe(struct i2c_client *client,
> > > +			const struct i2c_device_id *id)
> > > +{
> > > +	struct device *dev = &client->dev;
> > > +	struct aw8695_data *haptics;
> > > +	int err;
> > > +
> > > +	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
> > > +	if (!haptics)
> > > +		return -ENOMEM;
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,f0-preset", &haptics->f0_preset);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,f0-preset\n");
> >
> > I don't think dev_err_probe() makes sense here; none of these functions
> > should be returning -EPROBE_DEFER. In fact it seems you are using this
> > simply for every function that may fail during probe.
> 
> The documentation for the function mentions it can also be used for
> these cases:
> 
>  * Note that it is deemed acceptable to use this function for error
>  * prints during probe even if the @err is known to never be -EPROBE_DEFER.
>  * The benefit compared to a normal dev_err() is the standardized format
>  * of the error code and the fact that the error code is returned.
> 
> Let me know.

Fair enough.

> 
> >
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,f0-coefficient",
> > > +				   &haptics->f0_coefficient);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,f0-coefficient\n");
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,f0-calibration-percent",
> > > +				   &haptics->f0_cali_percent);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,f0-coefficient\n");
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,drive-level", &haptics->drive_level);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,drive-level\n");
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,f0-detection-play-time",
> > > +				   &haptics->f0_det_play);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,f0-detection-play-time\n");
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,f0-detection-wait-time",
> > > +				   &haptics->f0_det_wait);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,f0-detection-wait-time\n");
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,f0-detection-repeat",
> > > +				   &haptics->f0_det_repeat);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,f0-detection-repeat\n");
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,f0-detection-trace",
> > > +				   &haptics->f0_det_trace);
> > > +	if (err)
> > > +		dev_err_probe(dev, err, "Failed to read awinic,f0-detection-trace\n");
> > > +
> > > +	err = of_property_read_u8_array(dev->of_node, "awinic,boost-debug",
> > > +					haptics->boost_debug, ARRAY_SIZE(haptics->boost_debug));
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,boost-debug\n");
> >
> > Just to echo Krzysztof's comments from the binding: you should not expect
> > platform engineers to populate raw register values directly. Instead, it
> > is the responsibility of the driver to translate human-readable boolean or
> > scalar properties into raw register values.
> >
> > Ideally one should be able to populate dts without having to refer to the
> > datasheet in the first place.
> 
> As mentioned in the dt-bindings email, the datasheet doesn't mention
> what these values are used for :(
> 
> >
> > > +
> > > +	err = of_property_read_u8(dev->of_node, "awinic,tset", &haptics->tset);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,tset\n");
> >
> > Are all of these properties truly required?
> 
> As I don't know what they do, I don't know whether they're required..

In that case, a platform engineer that's trying to wire this up doesn't
stand much of a chance either.

Is the vendor willing to help in this case? The concern is that some of
these registers likely dictate LRA drive voltage, and you risk burning
up an LRA if you get this wrong.

It's much more common for an FF driver to accept LRA drive voltage in mV,
then calculate the appropriate register settings from there.

> 
> >
> > > +
> > > +	err = of_property_read_u8(dev->of_node, "awinic,r-spare", &haptics->r_spare);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,r-spare\n");
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,bemf-upper-threshold",
> > > +				   &haptics->bemf_vthh);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,bemf-upper-threshold\n");
> > > +
> > > +	err = of_property_read_u32(dev->of_node, "awinic,bemf-lower-threshold",
> > > +				   &haptics->bemf_vthl);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to read awinic,bemf-lower-threshold\n");
> > > +
> > > +	haptics->input_dev = devm_input_allocate_device(dev);
> > > +	if (!haptics->input_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	haptics->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(haptics->reset_gpio))
> > > +		return dev_err_probe(dev, PTR_ERR(haptics->reset_gpio),
> > > +				     "Failed to get reset gpio\n");
> >
> > Is a reset GPIO truly required, or can it simply be optional?
> 
> The datasheet doesn't explicly mention that it can be always connected
> to high/low as I've seen in other datasheets so I think for now we can
> assume it's always connected to a GPIO.
> 
> Of course if someone comes across hardware where there's no reset gpio
> then the driver can be adjusted.

To that end, you could simply call devm_gpiod_get_optional() and then
return early from aw8695_hw_reset() if haptics->reset_gpio is NULL.

Hardware reset and/or interrupt pins tend to be first on the chopping
block if a board designer is running out of GPIO. Just my $0.02.

> 
> Regards
> Luca
> 
> >
> > > +
> > > +	err = devm_request_threaded_irq(dev, client->irq, NULL, aw8695_irq,
> > > +		IRQF_ONESHOT, NULL, haptics);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to request interrupt\n");
> > > +
> > > +	INIT_WORK(&haptics->play_work, aw8695_haptics_play_work);
> > > +
> > > +	haptics->input_dev->name = "aw8695-haptics";
> > > +	haptics->input_dev->close = aw8695_close;
> > > +
> > > +	input_set_drvdata(haptics->input_dev, haptics);
> > > +	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
> > > +
> > > +	err = input_ff_create_memless(haptics->input_dev, NULL,
> > > +				      aw8695_haptics_play);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to create FF dev\n");
> > > +
> > > +	haptics->client = client;
> > > +	i2c_set_clientdata(client, haptics);
> > > +
> > > +	haptics->regmap = devm_regmap_init_i2c(client, &aw8695_regmap_config);
> > > +	if (IS_ERR(haptics->regmap))
> > > +		return dev_err_probe(dev, PTR_ERR(haptics->regmap),
> > > +				     "Failed to allocate register map\n");
> > > +
> > > +	err = aw8695_init(haptics);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to init aw8695\n");
> > > +
> > > +	err = aw8695_ram_init(haptics);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to init aw8695 sram\n");
> > > +
> > > +	err = input_register_device(haptics->input_dev);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to register input device\n");
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id aw8695_of_id[] = {
> > > +	{ .compatible = "awinic,aw8695", },
> > > +	{ /* sentinel */ }
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(of, aw8695_of_id);
> > > +
> > > +static struct i2c_driver aw8695_driver = {
> > > +	.driver = {
> > > +		.name = "aw8695-haptics",
> > > +		.of_match_table = aw8695_of_id,
> > > +	},
> > > +	.probe = aw8695_probe,
> > > +};
> > > +
> > > +module_i2c_driver(aw8695_driver);
> > > +
> > > +MODULE_AUTHOR("Luca Weiss <luca.weiss@fairphone.com>");
> > > +MODULE_DESCRIPTION("AW8695 LRA Haptic Driver");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.35.1
> > > 
> >
> > Kind regards,
> > Jeff LaBundy
> 

Kind regards,
Jeff LaBundy
