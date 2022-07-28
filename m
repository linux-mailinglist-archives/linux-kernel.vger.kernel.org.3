Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530F358440B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiG1QT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiG1QTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:19:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E886E89D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgGMsMXo8cSetqBCbgcGAHqA08cUeJtrmb7kliSho6J2Xm5NH/ZUAX6qrdWA3VH+G3a4iHOf0THywBdjJ5aptfRBkHnPQx9NFxvsifT/Q2EgsszZ1iFGH6RHnZ2OFHHNiDXnHZ9LhNlXvpxdMdZlsqiXOIIAOkmVeDrHWLqOoelINJkMqBPNWbfN6MWKT5UZsuTwXd+KYCJhWDKviojaaVs/qfMIVtvvZ2ohc9KuUm1B3JA1i9dIBuY0kPwbqv0pI0JBieR7mZcu3qykNwPh/GJPqMpUJxRoTt83Wq63OVQduFDMLICgJSwhIY5EoLZepUaUI6WYRuQyOtjIn0cQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PJitFgFng2KF6q+0i6O4mJ1x9MGI1eO5Jc5/sXoXLE=;
 b=b1Gpu7aFZT1APCwiHHO6ceAzB6/Zzk4IBvvO7fheieG/159srVhYguGtIGRggT/D50P4amQTwcZz9PnpkSDTIVm9dbnWWMAnTGuzbG/BY3DxSXmbadyy7fJe7JrfrRi/mKyOO6020suYq8TSf1coRheATXj/3lSve1src5SnnXhPfZUExMS7LqDn3NOw3Nmu3bjoB0GiZ09mp/rSOKE797LvEei3JpCMJ967TzoiCnsS9rnyRqR/K2ypzSx5TMPHcM3egmxoZxNA50719g4tppukiKHBgc0AyKc2ttXWl1R2SVb9MtCGWGkA/B1dysCy8tM8mGCC4I5DG/WMNLMTNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PJitFgFng2KF6q+0i6O4mJ1x9MGI1eO5Jc5/sXoXLE=;
 b=c0+OuM021PIhRaK4jNxj+9zM7S6OshiK50nJp927/FELRczR0Yta3rpEYXHgeA7AU+MzTN+I6HMuuI09pwz7QlnTT1LHJk33sbglX/m0zeFVWs3J/bPAyFmz1i2NWGpMl4vf8OGLqiA9qXdULmIBiXOqMM/UXH8cG1J+QvIZZqg=
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by AM6PR04MB6263.eurprd04.prod.outlook.com (2603:10a6:20b:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 28 Jul
 2022 16:19:50 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::c8f2:4b12:f7ac:3609]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::c8f2:4b12:f7ac:3609%6]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 16:19:50 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Sean Anderson <sean.anderson@seco.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Topic: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Index: AQHYopBXddIttVt6zkGyOalTC33MGK2T52GAgAAAzYCAAARPAIAAChgA
Date:   Thu, 28 Jul 2022 16:19:50 +0000
Message-ID: <20220728161948.gzc7kekygrfdumq6@skbuf>
References: <20220728144254.175385-1-vladimir.oltean@nxp.com>
 <501b52ba-7691-0263-c007-38174c7e5c22@seco.com>
 <20220728152815.6h4ytx52ll2gzjj3@skbuf>
 <532c8141-2a8b-6842-c9a2-cc4d17afd73d@seco.com>
In-Reply-To: <532c8141-2a8b-6842-c9a2-cc4d17afd73d@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88969825-3540-4a78-16a7-08da70b4ff0c
x-ms-traffictypediagnostic: AM6PR04MB6263:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EN/kMQ+6fI6tsjmF1Uw6HQs/bQBcjnRB/cI+Ihb/pi363i1B/OGuj/eCrq8d4zPxp2Ehjn5iRuvIcirp8YMc72E46Q+MyyhSCiEKV4nsQTs6famHoomJBquMRNZa6vKbiLWk9pgZvkGDn3UxppYAB0QczW9PvPDkUreM5jWhpfhpsG4eVcZ4PLEz9M7KK9BBydT92ircG56Gh4Gh5+6BsUrGuurbG6kLjuxpWCpjxGarvMESLZLWNkcq/vAMcdMpcGozyiF2O7bvZMqOLYu+1wlciyv8PhIf/XtBVmZJYkBkrad8tSOwx0Wd6G8mynNO7J63Y5Kc3OxDz3msD3ONSLA+p43udV1ErRjJhJixyEd0UPtrQk4hatllCY1JWtcaGp/tvDXzqFxcHVnAgmTfUhSp56YUsiL5kJ6AfAeKqL8JpU1u8mg3antHZ3boL0u267Sv1VCImtmBJOs3inpK67kEVraLNhPm9zwC3T1UoN9u0AOiIfgqWTCB5mApKEKNU1J4Ysyig37qPzten9RPW2OPGvg8ntIq2DZvfe7P/3v961xBxYN6M2171FObshS+oZtS+xkI4dDKbeiRUxz1Ru6psC1jagXXP2XFLd0cvA4n4S4orVR7JpXQ4MCskpH2dIZGVZU6HTslW2ruFlrIdVnJZWX8tWzxoH7Ig/3S393AzAdoSdal73j7HuBUomLAQEKbyod5fKHIREaqmi/1GwswEniR+seWg8Rysv8QA2qx+7gpzITYHOu6NOfIEGWZChVhEpr69lg28xidFIYhAZdqTPv64m6Xb6iKmmEL3EW+3eBNIrv7onyEbp6Ol8l1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5121.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(2906002)(64756008)(8936002)(9686003)(41300700001)(6916009)(6506007)(86362001)(6486002)(38100700002)(71200400001)(38070700005)(478600001)(26005)(186003)(6512007)(122000001)(8676002)(1076003)(66556008)(33716001)(316002)(4326008)(54906003)(66946007)(66446008)(83380400001)(5660300002)(44832011)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bBIugu6MsAq0DUKP7fyQy5lpJxIrkL+r2sPJd8pHlPV2kaxoSs2zdjfF87Tv?=
 =?us-ascii?Q?iJh5cJvD0xZG7MVo6D4axGS6yiqjOAKxKHKHLAOQ1tX7o+TAux2vCKDKbmAb?=
 =?us-ascii?Q?7qMz6KMHi0EBUIWaHmAo678wgLP4nFHoedtw/nOSxlIfyJOA2sTvVJIIPlYR?=
 =?us-ascii?Q?8jjEi4oVSRfvbnAfbYQT9oSsFLeyhKCuE/3e5Fd6P7x29YC6X2myrbsdbzWP?=
 =?us-ascii?Q?22lvkRX/dw/YegEWle+/GVWtf88G6+y5sex5K6sc504aUiZYrUx+EDRcg2VF?=
 =?us-ascii?Q?HmFU7C8fROIloYdThrjpPAJZYGYglzuWwz7yH+ZI5p0YsZQ7WDyMAHcj5ifA?=
 =?us-ascii?Q?vb1BVORapaBOkQz0RckB1qxPvkSIgiWwkf4MJ/QyTq1Zb8Cs/vTTorLbIhwN?=
 =?us-ascii?Q?l9BntksdorLCoUe+3emTEXeM+4LgD7mYpwRnNJd4G4+ePO4NwX41RaWJQPcY?=
 =?us-ascii?Q?zunnqKWPNZoJuFmokIEDYbA9DCfPkGrZpi8MJyXALQyVcY6kmgSRMUm1JGxh?=
 =?us-ascii?Q?UlYUvgmuMaX0ZgyPxjUE5+k8jJeYOiFQLyXwjU9RONX2vsMd7IqRkPa4PdOl?=
 =?us-ascii?Q?aLktkPCrNGUbfrvoUshS4SKeM/aQk7Y9jF5ToSXaJ2uGzv3/Eo8g49t4b1Bc?=
 =?us-ascii?Q?0tfkawFfPJfk0FcaagaXqfSiKf3em9BKxCmzYXCZcnKIGtp/3IyEBk6k3EaN?=
 =?us-ascii?Q?NuGHKc6lhv5wG5jE1xrTTdnYHRMvFlOfPUuP1Yv0xMuSr0Fnglpea18BHhIq?=
 =?us-ascii?Q?3uGzSJzQMh9bi5Yhw6ml1G9um3SAEwDAhtzYogKKftU791a3GxujH5jfKleV?=
 =?us-ascii?Q?x6BsLlC5X4eq76S3S1s5z2aIp9cAw92fxPGTLrt+tc25yvTaiN8JzfMiDH+2?=
 =?us-ascii?Q?x+flUVX3tBrGqksF4APYLKvkoY23JQdtbf8Z3vZIC5jAOhVF23D59iDrL4k8?=
 =?us-ascii?Q?ryehbdJ6NwVO8wZtcs3Zo0XyXi+csqA2kWNS3giR3HjUlG8k19UPRlTpJO2h?=
 =?us-ascii?Q?rJF91kW0file3YJuVVkzR7WB0DGr5mbqJjQw8ZxzCwoA1HGQhPhvnMmFWjQ1?=
 =?us-ascii?Q?dQVgnohPcIo+KpF06dJWpZIxAdo30TdPzv7/LRYz6QiYvff66xEkgdkp4NB7?=
 =?us-ascii?Q?XBUx22+GVINERKzhBR0SS8puldUEd2+pmYUn4XudmCfPM0GiE8UdaLQMpFlh?=
 =?us-ascii?Q?C5OSp5xJykln/SYEJCl9DFmSiu6wHaRWBxrzGazTBmfXbfkue1faAjSIGdVR?=
 =?us-ascii?Q?EsFTvZoU2Uw6PYCjPqKBH4xa4dFkW4TeG4ntnjjSiRrpmeuxmuYlmh1DUbBM?=
 =?us-ascii?Q?R0NafqrihpGZ4LSrBrb3OP1zS/9vI1iwfKYZe/F6lOVkYgpS8xfZjOStLzwh?=
 =?us-ascii?Q?cUAwdpB5RNxAFKr1MForxgDcrekaQZlSDOsrM+N+Zz9+aBl20UmlmpPnpLfT?=
 =?us-ascii?Q?FyfITNrghfwGoYby9ToDzFzZMI2eElLRUa0ZWgiQmp333QisUdV1aKn5M7Y5?=
 =?us-ascii?Q?/3zLKKqH26ZkzTD/wfeKeWbDOmnl/PRTspKFp1ChsuQPMmNPyrBsvp3RrgVO?=
 =?us-ascii?Q?4s5agAJ6v3kpWKsvXzi6G8MTIImeqOG09/Q1hQX654SuczQuhrL1cpgJFEyi?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <490D9F14A2B4324F96CAC717341F3935@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88969825-3540-4a78-16a7-08da70b4ff0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 16:19:50.1284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxgWjFtKMvrH6pibva5F16/C+vX1KdJWnJitL3qGXeq0p+oasTDGtn0ku7dEovCYfVkxTHRKf49BV/32BQ6hPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6263
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:43:40AM -0400, Sean Anderson wrote:
> > All of this should be rewritten to use of_device_is_big_endian(), and
> > reduce the whole thing to two cases (I don't think native endian makes
> > much sense anyway). I also wonder what the result is if none of these
> > properties is present...
>=20
> I think regmap_get_val_endian would be better here.

It needs a struct device.

> >> +
> >> +	priv->regmap =3D regmap_init_mmio(NULL, base, &extirq_regmap_config)=
;
>=20
> It could also be done automatically if we pass the syscon dev instead of
> NULL. The only downside is that some regmap error messages will use the
> syscon device

How do you get the struct device of the syscon?

> > Finally, what is the actual benefit of using a regmap here? It seems
> > like a very roundabout way of performing a RMW on a register whilst
> > holding a lock... Passing NULL for a device to regmap_init_mmio() also
> > seems to be an extremely rare idiom (only 5 cases in the tree), and
> > this doesn't seem completely right to me.
>=20
> The benefit is that you don't have to write (yet another) set of
> endian-converting read/write functions. The above (non-NULL) usage of
> regmap_init would also address your criticism here.

I don't have a particular attraction towards using regmap for a single
register either, to be honest.=
