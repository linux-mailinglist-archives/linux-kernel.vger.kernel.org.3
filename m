Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A89F59E0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357777AbiHWLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358011AbiHWLcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:32:15 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2F76456;
        Tue, 23 Aug 2022 02:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRhKBHm0J8MLYp0G3aarwTZEpuMxj34jcpnh+b8wcRmmbwqaIeVMUIBOlJ2NrOogQ9tN6Uy70/SoOcC1l74ins6f6rzcHXL3ap32gTByaobUSMVzsHerAzilsKa3avFn6TPY722ktKvRI2fKy2y66L9ohdskxXi3SPYI4e6CkQt1pXO7QyDP1xmIbR9gjY0f/NZ2zIsmpnMgBbKD2P9f7rxx0vHgCKsguero2fnJ6SndERrMtJMp6gcZhJxI1cWWTBs9v44hYTRYolNrzIxEJEwAGr4rAKph9RjGelL/2mU6XJYlK1LQumP2Vh+1Kx97i9FV7YWHJ9v62XbDVVvtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ns+wvHquKjd7Uyo3zkICgD+UuQ6bdfzIePqVTgTxTs=;
 b=CLA3qOqx3RvK0BMXChC5+ioAVrvHaVlqgKQBBxF2TSI5Y4QsKXXqzJg6jv88b2Y0R6rRDMxF9xfvSOUWU3Xx7aVyZ/c7GX7+EOG4BDVD6my23kYmg4cEOHPPec3c4Ogd98Dc4Az6/JCd5nlWMDmreECBst0YdY18zNDsIzRFhpGkf9moKb0ar+AtSjRXFjNDr+n9F2BZQYxowL0A+WXtlYCKlSV+QWVXxlpW/P5HRBC4VPhTuYwDW7Oou2g3ftfh/1NSMYoA9bj9fuTMPps/3HiJwrQnn2+l7iTA5HRQnBXrSlgvLsuyXIJAEhr1pqCrtoJWfdxBFhToGsA3gGgqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ns+wvHquKjd7Uyo3zkICgD+UuQ6bdfzIePqVTgTxTs=;
 b=h+PLrP5UJ5ZPOLJa/LvB/zl76XNmx4fNBebEujLthajFs/AM2SolLsiqy/4/qwLzyvppzhEM2d8TRg4h/cpS7ODeuk1yL9egdzNUA6aTVZ7draCgQmc05RNMRdK5YIivN/9+73kqDQE9N0T0uTKz/B1xaBuKHdHRcMUMvCbUpSLs5xeT3r65DuQ7Zmd6yVTTKJQCtrXTos58aNwxDjUW8gV7PsLQauNuvrF4+uO4U1D5lV2ttMNlpZRvBLC+qNOrwbGWp+Y+xGvyRy9+ncF4xMJv5SsiwIPlaxL1q5AbJbR4iFEX+n5ABFkf12JpfCik+zORN4UUxksQi6NGz/ZRAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB3PR10MB6787.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:437::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 09:26:26 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 09:26:26 +0000
Date:   Tue, 23 Aug 2022 11:26:15 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     simon.guinot@sequanux.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Subject: Re: [PATCH v3 1/4] gpio-f7188x: Add GPIO support for Nuvoton
 NCT6116
Message-ID: <20220823112615.2e2a96b7@md1za8fc.ad001.siemens.net>
In-Reply-To: <YvY33D9YLm7/g14N@76cbfcf04d45>
References: <20220811153908.31283-1-henning.schild@siemens.com>
        <20220811153908.31283-2-henning.schild@siemens.com>
        <YvYSl2FpOGnqZfTZ@76cbfcf04d45>
        <20220812122312.7f6f6a30@md1za8fc.ad001.siemens.net>
        <YvY33D9YLm7/g14N@76cbfcf04d45>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:610:54::15) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b78809aa-5583-45fd-5359-08da84e98d49
X-MS-TrafficTypeDiagnostic: DB3PR10MB6787:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOqvSiODQMIuPif3zF719hxWw2roJNQquU5c2n82J1G6jYXfqreLDwlLtF0l9y5JTjajfBZat9gNcukkBwbYhxw+MouUpB3b50IcEVw54Ivmx1H8aoGPYl6PNAQw9rxLYP2pn5DJx/BeodbcFFr/DJ8GAIcVIjeEjPqObGUT74VYub2Sl3Nb2H61sfq/jOC+GF0LJsTj4k7Ylo2aYVY7K6LlHMMUguzbRwD7EAwbFDXcZOgKlvd3yErtQ8rz6LDpquFUqxwBeKZM4r3qlyoyOX93aoPFFgiH4EGOvhlPe13QNlDgtXEoXM2/PQtOjleAaNEVc+Ki19fQqmMDkqScvWU4FpdCxuhfuOdcCMESVfHYK5kkaut7OQo/L9pQS00sOMDPVp4w4aGuGN8+RFHFvFpZ6ewZd7wSvbZqF2qQel/lP7a68wDtCHeuz+Oq3f3IdDXgewHhrz7M2xJNAU4Et597TND7IIKqminZMYih4JcYFSk8Gei/xugOSsW0cbhmziFFVwN1iHpXzx6hn6N062RcU/WfjXT1WcEFFMEjg9NqR/fpSQKIDhQHwPXi+fAefBq9rjPXWayPi/zd6+9DIK20z/LMGP6wWD9DGFFSH/M+lyWsGnEFGgxvL764NLdNj5lyFTaNscZFTWm+3W5rEuZaA6hpH0Z/naEttwjGq3Y3ZQfohzuM8BwDQ8e6QJP3Id+oC7rPBH8nwswNPoJwhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(5660300002)(66476007)(4326008)(66556008)(86362001)(2906002)(8676002)(9686003)(66946007)(6506007)(26005)(38100700002)(44832011)(6512007)(6666004)(1076003)(8936002)(186003)(6486002)(41300700001)(83380400001)(54906003)(7416002)(316002)(82960400001)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ih1b96Yiz/D37kKJvbUCJdaUWorYZXjLTzviRGh8+SWRBJ8wp4HRpp8ieMY8?=
 =?us-ascii?Q?pj0Gp+N4fYXrliXPVBU17gTlhET+v1GbeL+1eUMAqr8yvSdXYGAz9PEGxrmd?=
 =?us-ascii?Q?pmJ+Po5MZZqhwm9rlXOY6ezBuRLth0vtXwXFulgUSfcbakUXd0UEnD2qG6qR?=
 =?us-ascii?Q?bfNomWl4DXmGwM14Ipor+hYNPOUZkSBB6QiiiIZgU8vRs0e/jGe02luZb1Qp?=
 =?us-ascii?Q?h73LpdBADtRL51jmzvcOmZ1ZO0ry9IDaYB+GW5kYDIUy2RIDxIVVuNZKgMnH?=
 =?us-ascii?Q?RIRHoZJ4CodrkOSQWzcsWbmUuUK6Uah+o8gc/g2Lcl/+HyEDMbwIUGqxusFP?=
 =?us-ascii?Q?/6oBldSDlFDTPVpZM57O7tlVyLHbhVnbggOv/Vmjkn5oxLJx8ChO6mKP47Bf?=
 =?us-ascii?Q?3WZnJR432ZF+01uBQx0sSBv0Qx7Wmes7UQkhYUzX1zsBjWfZCS5NWRkEqVZV?=
 =?us-ascii?Q?Q4Ucb7XgfMmfuFENI31G8qkZI2YBiL6oHPZ/iapduvdXS80/u9bXY6GziZBn?=
 =?us-ascii?Q?vlfrXyXjCm86El0/LtMQPk4W+0rZfrrQXLan0MqaiWi0gEeHVLHw1Upmn0a3?=
 =?us-ascii?Q?UxoQWj2qFJD9kgl3T6iRBVBb+YiEhqh/VNHbT92B5mVHrZRk6yhslUf3ucPi?=
 =?us-ascii?Q?d9KZ4TzK2gE9unED0zzqXcA1YHEvEybz4bvIxkbKkF+U05O1q1hIkxhE7GXF?=
 =?us-ascii?Q?sSx5lLxEuCiZKODmfPbxMrn56uPPKBjXdxpKsRqalTVHzGvi8UsMyCJ0bKIE?=
 =?us-ascii?Q?GDXzptgBEal0O3Li4ahFKuOCqLvXQl5kW2Qc+gtq6pdajqZTgoyK1AGTezqH?=
 =?us-ascii?Q?m2VIDi7xoi0U9ssJljqMf1tcXOsbBl0jkF19ndPpr9JvJaG837dMwP8uk2BF?=
 =?us-ascii?Q?7gGjwLK1cv8P9ayQllkajXYWJJx5ICxU4q9BKVVictTdFkkvC1kuoDrsjqyo?=
 =?us-ascii?Q?GCsYIYGWyUCiSgmieCTA0ntUkS3ol9QDm3RdjdXjPgX6sjVS2YKUzL27xZFu?=
 =?us-ascii?Q?MlAHnpL87cg5iNd/NHnBJgME007XO1tkbgkrSJ//0UUTPSzS7NLDAoHjfzY2?=
 =?us-ascii?Q?LjTNiD97Avwmwhmg/Nb1VvyyYaGStMPvhpKeVtHagsHn1y6ezgE6IEe2ZtBg?=
 =?us-ascii?Q?wKFVkqFPwEcZ7BQG6JDqeOCKfbyzkPKhTJb7l/2lnQRpOTbhFT85oZ6XMtD1?=
 =?us-ascii?Q?QzQcdGfJO7aK71do1x+t6w23SfoR1C50iSzOsV50cI7ZbQUwEOibrm2HE7cQ?=
 =?us-ascii?Q?vrBxuRZMxbWqKG9c67aURtev4wLjPCstqPDGo2CxQnJXS4qoIA68XH9o1NX/?=
 =?us-ascii?Q?tQ6say1d5XsJgQO/SLaPAnYev0sxbuS/ezuao8CRBjqDLMdeRo5aeJpeu55R?=
 =?us-ascii?Q?Qyu/tsU0j9PPMyrh1xCCI+4bHdImDRLPVZ1mIMP/1AAY99HTCN4o+9otzAGH?=
 =?us-ascii?Q?VIUqEWanuxF98qT/oWemW5M2h36+0IWkKTZYkIQuuOjKo6sDKtoXF7ZeN2p+?=
 =?us-ascii?Q?Fqacd8Wagcj/CqE+a6s5bXkmc59qLrvuCe1eWqC5RmtOKxkYpDgmGIHW8gst?=
 =?us-ascii?Q?nOEKLEIM1qlgppdWhka8DoyGIXepJiwrALzsarlEPADYpJl2Sg8bDbQ1RUP8?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78809aa-5583-45fd-5359-08da84e98d49
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 09:26:26.1172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3d8NuyPz6n9hsu0T2kCXp8qy7YKQaQ98Rb5kBBeWQEopJVcPebaS7hlvdhEbIRh5bVjk3yanIsSWPLOZQyUg8i9lYgog79L4vmQLFLuP8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6787
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 12 Aug 2022 13:22:04 +0200
schrieb simon.guinot@sequanux.org:

> On Fri, Aug 12, 2022 at 12:23:12PM +0200, Henning Schild wrote:
> > Am Fri, 12 Aug 2022 10:43:03 +0200
> > schrieb simon.guinot@sequanux.org:
> >   
> > > On Thu, Aug 11, 2022 at 05:39:05PM +0200, Henning Schild wrote:  
> > > > Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO
> > > > chips are very similar to the ones from Fintek. In other
> > > > subsystems they also share drivers and are called a family of
> > > > drivers.
> > > > 
> > > > For the GPIO subsystem the only difference is that the direction
> > > > bit is reversed and that there is only one data bit per pin. On
> > > > the SuperIO level the logical device is another one.
> > > > 
> > > > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > > > ---
> > > >  drivers/gpio/gpio-f7188x.c | 71
> > > > +++++++++++++++++++++++++++----------- 1 file changed, 51
> > > > insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpio/gpio-f7188x.c
> > > > b/drivers/gpio/gpio-f7188x.c index 18a3147f5a42..7b05ecc611e9
> > > > 100644 --- a/drivers/gpio/gpio-f7188x.c
> > > > +++ b/drivers/gpio/gpio-f7188x.c
> > > > @@ -1,6 +1,7 @@
> > > >  // SPDX-License-Identifier: GPL-2.0-or-later
> > > >  /*
> > > >   * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882,
> > > > F71889 and F81866
> > > > + * and Nuvoton Super-I/O NCT6116D
> > > >   *
> > > >   * Copyright (C) 2010-2013 LaCie
> > > >   *
> > > > @@ -22,13 +23,12 @@
> > > >  #define SIO_LDSEL		0x07	/* Logical device
> > > > select */ #define SIO_DEVID		0x20	/*
> > > > Device ID (2 bytes) */ #define SIO_DEVREV
> > > > 0x22	/* Device revision */ -#define SIO_MANID
> > > > 	0x23	/* Fintek ID (2 bytes) */ 
> > > > -#define SIO_LD_GPIO		0x06	/* GPIO logical
> > > > device */ #define SIO_UNLOCK_KEY		0x87	/*
> > > > Key to enable Super-I/O */ #define SIO_LOCK_KEY
> > > > 0xAA	/* Key to disable Super-I/O */ 
> > > > -#define SIO_FINTEK_ID		0x1934	/*
> > > > Manufacturer ID */ +#define SIO_LD_GPIO_FINTEK
> > > > 0x06	/* GPIO logical device */ +#define
> > > > SIO_LD_GPIO_NUVOTON	0x07 /* GPIO logical device */    
> > > 
> > > Please indulge me and add a new line here.  
> > 
> > Mhh ... how about you write exactly how you would like to have that
> > define block. So we do not have taste issues in the next round.  
> 
> Sure. Considering the manufacturer IDs you have to keep and add, I
> would go with your original approach (i.e. a section per
> manufacturer). But I would add extra new lines and comments and use a
> sligthly different namming for the LD_GPIO definitions.
> 
> /*
>  * Super-I/O registers
>  */
> #define SIO_LDSEL               0x07    /* Logical device select */
> #define SIO_DEVID               0x20    /* Device ID (2 bytes) */
> #define SIO_DEVREV              0x22    /* Device revision */
> #define SIO_MANID               0x23    /* Fintek ID (2 bytes) */
> 
> #define SIO_UNLOCK_KEY          0x87    /* Key to enable Super-I/O */
> #define SIO_LOCK_KEY            0xAA    /* Key to disable Super-I/O */
> 
> /*
>  * Fintek devices.
>  */
> #define SIO_FINTEK_ID           0x1934  /* Manufacturer ID */
> 
> #define SIO_F71869_ID           0x0814  /* F71869 chipset ID */
> #define SIO_F71869A_ID          0x1007  /* F71869A chipset ID */
> #define SIO_F71882_ID           0x0541  /* F71882 chipset ID */
> #define SIO_F71889_ID           0x0909  /* F71889 chipset ID */
> #define SIO_F71889A_ID          0x1005  /* F71889A chipset ID */
> #define SIO_F81866_ID           0x1010  /* F81866 chipset ID */
> #define SIO_F81804_ID           0x1502  /* F81804 chipset ID, same for
> 					   f81966 */ 
> #define SIO_F81865_ID           0x0704  /* F81865 chipset ID */
> 
> #define SIO_FINTEK_LD_GPIO      0x06    /* GPIO logical device */
> 
> /*
>  * Nuvoton devices.
>  */
> #define SIO_NUVOTON_ID          0xXXXX  /* Manufacturer ID */
> 
> #define SIO_NCT6116D_ID         0xD283  /* NCT6116D chipset ID */
> 
> #define SIO_NUVOTON_LD_GPIO     0x07    /* GPIO logical device */
> 
> Please, note it is not only a matter of taste. New lines and comments
> are really helping the reader. Also, note that I am not asking for
> this change, only suggesting it.

This is fine. I will take this. Only slight difference will be in the
revid and manid, those are Fintek specific and do not apply for Nuvoton.

regards,
Henning

> >   
> > > >  #define SIO_F71869_ID		0x0814	/* F71869
> > > > chipset ID */ #define SIO_F71869A_ID		0x1007
> > > > /* F71869A chipset ID */ #define SIO_F71882_ID
> > > > 0x0541	/* F71882 chipset ID */ @@ -37,7 +37,7 @@
> > > >  #define SIO_F81866_ID		0x1010	/* F81866
> > > > chipset ID */ #define SIO_F81804_ID		0x1502  /*
> > > > F81804 chipset ID, same for f81966 */ #define SIO_F81865_ID
> > > > 	0x0704	/* F81865 chipset ID */ -
> > > > +#define SIO_NCT6116D_ID		0xD283  /* NCT6116D
> > > > chipset ID */   
> > > 
> > > ... snip ...
> > >   
> > > > @@ -485,12 +516,8 @@ static int __init f7188x_find(int addr,
> > > > struct f7188x_sio *sio) return err;
> > > >  
> > > >  	err = -ENODEV;
> > > > -	devid = superio_inw(addr, SIO_MANID);
> > > > -	if (devid != SIO_FINTEK_ID) {
> > > > -		pr_debug(DRVNAME ": Not a Fintek device at
> > > > 0x%08x\n", addr);
> > > > -		goto err;
> > > > -	}    
> > > 
> > > Sorry for missing that at my first review. You can't remove this
> > > block of code. This driver is poking around on the I2C bus, which
> > > is not great. So we want to make sure as much as possible that we
> > > are speaking to the right device.  
> > 
> > Ok fair enough, we can make that more conservative and match the two
> > manufacturers and also make sure that not one can bring a chip id
> > that the other one uses for another chip.
> > A v4 is coming earliest in 1.5 weeks.  
> 
> Great. Thanks for your patience.
> 
> Simon

