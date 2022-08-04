Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3C589B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiHDMLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiHDMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:11:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5909143E6D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pzn3cVZiXEehS8A9gXIZ79VWkCtRGPsqlFOZsnd/3mr/AwM5rv+szMIhXqRlHeNTS443JGVTSle/FqMUDYM87q7AmbXd4b7V2nfhX5Ww+rzLfp5aB5g0EGxe6AJzwUEinf7QyJ1iOidSiqzaIArZkSh2QIbYCRkZRcuwBjR/VmyKpYfXZg1f4htWMzYDLxbqZa75GOPdy5wW7y/N/f7O0l7UD92JDuFnPrizQgZ3fh1Wrh38irdLv79Jt32LKwDjY/nNhG1dR5z/CNQ9u3dfRPAmczPcE5wT7ziJudWFMVUn5oYp512apA1QYIqNLQk3973kjXoxvb3u7PCluZS+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yozL0Jtn2Y8ZJhq61gRyYy6ImRLTiVNWo9NiV3peZSo=;
 b=mO/u72/WNggjtfrTwRZhiJrdhPTwSnI5gyWJI5TFAmqu1iSO91NapA/pxm62biEzjSOMO77UTIdRs/Qnh1PgfJnNbLu6dq4cUGo9kPyiiwMswILQhXrk8iy2a/P9WxN5ogvm/59+GYjuHpaGo1ZLLPMGXoqEbhrxzaVWf4JEms3Ow7uqGV4WMwAaFVLJGn+I+Q3ax6h487N8sbovDX03/Pmx+HrG0KvbrfGBWjYjb5ympOMUVc1tYaWNAFNsktsjA+oc0C+Tif5U0uWalVKnyYtJ8l51rT1+R1pczngOHi2P8BSUsmoGh3a9+qn5rZmkjD9F2JpazOmMHh+hmAD57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yozL0Jtn2Y8ZJhq61gRyYy6ImRLTiVNWo9NiV3peZSo=;
 b=tvxNadCO3XAsuWoOhZt71ccEZrAMvCIZSN50sf+gsukjiMhg/q1BHSNLPAX9CHXf9FBy6UZV4K1F3SHxjgucoZH9WtUZU3mNfJCIrZ8FnFdPjn0qzT60inGg67R2+zd7msbK3iLCFHb6ZpNMKgeTey5wuxja8PYKp203BQdEmb4=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by BL0PR12MB5689.namprd12.prod.outlook.com (2603:10b6:208:8d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Thu, 4 Aug
 2022 12:11:43 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec%6]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 12:11:43 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
Subject: RE: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with gic-its
 domain as parent
Thread-Topic: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with
 gic-its domain as parent
Thread-Index: AQHYpzRgdVlYVwtHmECHDGmKRNvx7a2eb+cAgAAA0ZCAAB2ZgIAAAotw
Date:   Thu, 4 Aug 2022 12:11:43 +0000
Message-ID: <DM6PR12MB3082D9CA3ABEFC2BDAD7E40AE89F9@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
        <20220803122655.100254-2-nipun.gupta@amd.com>   <87pmhgwfyp.wl-maz@kernel.org>
        <DM6PR12MB3082B8F57D02A359FC61F449E89F9@DM6PR12MB3082.namprd12.prod.outlook.com>
 <87mtckwaxa.wl-maz@kernel.org>
In-Reply-To: <87mtckwaxa.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-04T12:12:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=aec602d7-43fa-4b52-89ef-d6819c56589e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cef40860-f713-4f68-4a1c-08da76127eb2
x-ms-traffictypediagnostic: BL0PR12MB5689:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fInt4dMmtdL/eNcVo5sUxUY+KJRuiMl8YFYow7GGYGdrkTLp64Ivn4A0gKjKiLMAf9mFIdPcZ7Y6tnZ+IkYPt/k/XV3VGpz9gSxkf2ce9lOQy5EBh1wRmWe3CWwgJaDxrIktia0oZIMRYQraKgtF1jRjam40EROD0bRckzkbBqtXcF6G9w1VwFH1wR6H6Pxkmrj5Tpo2Ej8bDkSg9Yzs4AkOduiJO2D5kRav0+OqecUgpHJLFxqs2iDbkTeVWVX4KoRNfWnNgBSqHkjYasWnWCH594hbzsNrvZAMwfgYwDXKiB/XcSUladM0nUZ7bUw+/5L3fKmHXWJJfmSuBUnmuMj8WdMo/6WvZOHyEtMel/w3shja4gUQBLgIavaPQt1qlJnOaF8lQ7pWts4tojcSfPUcDnayZW98DZYUeY/nVDNEDuiOk9jJAyioCZMNLD4anWbSrY1q+7SP8KyfNUv8tfX1QhfF+hyj5GVq9wwAzeo6PgArVoOrehQWTn8Hj7rRwk9mSB7RMq8HXuI62s/zOYSaNkHEWjF915Lw5skYIWLLv1MT7ESYyunrMfmUEK+Kz0mw+mMUfm/UMZBt1QpAoqM7mjPHY4fsTrKLahvS9MyKuapzNSTMhGU0V7SvTD4xzN3zXemX7TxqewNaFZHnAOl5z8q732oBAbQi7lDISQsrISWp2n+zkggoiuQVw4n4eRY9XudHJJ1Oqgy/iSYLIpDkZ33uy3S8orCKtwwX6MDTiPh+9KRipo+1cYDZfdThCELoBmecfmzI3HDN0Jzk5bCF8t2dE/NF+eUolM6Aa+BwfKd24qnCf2wnrM5mOzSZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(38100700002)(52536014)(33656002)(7696005)(9686003)(6506007)(478600001)(26005)(71200400001)(66476007)(55236004)(66446008)(53546011)(66556008)(41300700001)(5660300002)(86362001)(2906002)(38070700005)(122000001)(8676002)(76116006)(8936002)(4326008)(83380400001)(6916009)(54906003)(316002)(55016003)(186003)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?njWQvNrT1BUgNNaAcMi7csZcEDnLfatxy24lpgx/qleD93aWLaiCHhxNJyCs?=
 =?us-ascii?Q?sxRnjPA8JqIiyboujRMyRbZNCdaxgzfS8Y9e46N24OLC6i9bJ818OW8Wk2gJ?=
 =?us-ascii?Q?3ZoByJicDwFNF3Xgc6by+sq9StQJVzjo/9YKIcTEF3qt/rH6RRQL9U5oW5zd?=
 =?us-ascii?Q?pPicFhOQKtCFLL02pMKa2ih5W3Rh2Gk58R9/kpc7wQXicSPnzgS/FkGGTrIq?=
 =?us-ascii?Q?+iQ7LEQOIFkOFA1K6M7sdofNQcggYYVmlm/iD3BHyJjZNG3F/X6GDYvATD0R?=
 =?us-ascii?Q?M9VOHSzkZZBq+0dy3FEA+c3HtASOC0s8qSxVt/NNLJPDYfC8d9d6ukiicPKr?=
 =?us-ascii?Q?cZmKIEhGNapcLHDWU9dTJhWKVuiDJPBFc08J5gysUYzywDJrig77IVfWYDxX?=
 =?us-ascii?Q?nsd24REQ0K0z0ltOKEFrfwDV9HS9C1G11v5Rry38WCGtYRVV2avreAEJsZyq?=
 =?us-ascii?Q?Yj1UKHKX5XWiacPLyAReLkij3Y56qj+0etgCARQt2PBacX/CDZSCBYLUC/+z?=
 =?us-ascii?Q?pcIgbvaDact+bBopBQiVsIsLDZR5qlj1JAZVxUKVBspsXfnh6qJDaWG97S4n?=
 =?us-ascii?Q?gJEbXKV8OTuzKWg7RgGRQt/YVwZOJtzZWoyBWCgFcTzp8J7XljzUOOOC3YFg?=
 =?us-ascii?Q?0eb7Fy6cMXFIJshhbYBnjjAWaFeffFXT7OGtNLIVHd/UYpk+fuyHlNzbbj6l?=
 =?us-ascii?Q?xi0b8s5M2Gfka8lG9GSbqvmr3qpUblUpSbCIRzGlwFcyUIEkMejiBrKz/QiD?=
 =?us-ascii?Q?9Wg2T/gT0W9iXK0zQ8oCSQwSEmRSwNJhOvKXmNZdtG/XbOfgvi0YbUg13Gj8?=
 =?us-ascii?Q?crn/IdGejFsEdD+u6XSU3jZUDYroA4oG9SgVfcxbo0SPDj/HcL2IIgaHdhsD?=
 =?us-ascii?Q?YTgDarJ7LotRguzksdylWvVeHmXp6K962kWnrqCx93R034r7MojOEFHYGAr4?=
 =?us-ascii?Q?nWxH6tL3UkX1ArgPNPQTL9ZOMfSjS2xi3OSev2yTzLhu3ans06z//0NGjLRK?=
 =?us-ascii?Q?4BmhKjFt3pYZvUhWnnu1WNL2cr1wk/SiMoLF3P7quGDtAdttMLDyCTQ2nc0m?=
 =?us-ascii?Q?Lh+wHYtDcGr5q4nMAI98c9+bKWnR97HIvm1RLnkc1zD681Jbo1lev8Pydh0Q?=
 =?us-ascii?Q?XLMzrZ8HUVrGZZFWGF3TYznXbpq5TQ9yVbjxRJKpxY5Pyt7fgGNWvBNtffZv?=
 =?us-ascii?Q?tfcppVKMG5l9lSagGpjFT5PYz4G9Ydh4RFHi8D05XPcJnH2E5l0RVDPP5Uly?=
 =?us-ascii?Q?vWMsklFKZ2zZ0Xc2AVwdBmAv+JEU6niA7fqwIHSk0590uvJaRJfC6qbQxYXM?=
 =?us-ascii?Q?o93didc3S7j3edqlAI+hG9Q2Y+BJiHU16UI9YPldvTg8jUuRWwkbwf5DBbtx?=
 =?us-ascii?Q?wy6CNFOoawxI5Y78N1IN38EfMZkDWfM1c8Bqh2vvo9i1nWDXB55/7Xg0WtEK?=
 =?us-ascii?Q?HuCUaYhYltkr3JrwccOd3x+3kii6xBZqhK2JvYsTrK/tnDyV7mFyVqr09frk?=
 =?us-ascii?Q?9r4W2ekB9uzDl2bLAPUpV1pSwA4+bWG3Im3n1eJRWJeIdseI4xPXrY97XEll?=
 =?us-ascii?Q?5ZQ+2+05EXsck4Hij8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef40860-f713-4f68-4a1c-08da76127eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 12:11:43.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJ1/qAHkeXlmOKhqSGb7tWg+2o7on2cfmmJBLjQyoW1HZRtscp8faGLWVC6xtXZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Thursday, August 4, 2022 4:09 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> gregkh@linuxfoundation.org; rafael@kernel.org; tglx@linutronix.de;
> okaya@kernel.org; Anand, Harpreet <harpreet.anand@amd.com>; Simek,
> Michal <michal.simek@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>
> Subject: Re: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with gi=
c-
> its domain as parent

<snip>

> > > > +static int __init its_cdx_msi_init(void)
> > > > +{
> > > > +     its_cdx_of_msi_init();
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +early_initcall(its_cdx_msi_init);
> > >
> > > I really don't think we should have any more of this muck. Yes, the
> > > other busses are also doing that, but here's our chance to do
> > > something better.
> > >
> > > Why can't the *bus* driver (I assume there is one) perform these
> > > tasks? It would really help if this patch was shown in context,
> > > because I have no idea how this fits in the grand scheme of things.
> >
> > Agree, bus driver could do this stuff, and I was considering it too,
> > but as this was the norm so added these changes in this IRQ chip :).
>=20
> Well, let's not miss this opportunity to improve things! :-)
>=20
> > Bus driver is not out yet, and we have pushed these as RFC changes
> > for early feedback (mentioned in the cover letter), but yes, these
> > patches would be clubbed as a part of overall changes.
> >
> > And we can move it as a part of bus driver itself. I hope that suits?
>=20
> It certainly sounds better than the above looks! Please Cc me on the
> submission of this infrastructure.

Sounds good!! Then we will move this inside the bus infra itself and would
add you as a reviewer for the bus series.

>=20
> Thanks,
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.

On a lighter note, on the earlier mail I thought this was a comment for the
patch, as this change matches where norm is bus drivers adding domain in IR=
Q
chip, but now it seems this is the tagline you have :)

Thanks,
Nipun=
