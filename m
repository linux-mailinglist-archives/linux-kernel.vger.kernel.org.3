Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D489C4B28E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351284AbiBKPOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:14:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbiBKPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:14:29 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2120.outbound.protection.outlook.com [40.107.20.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F669B08;
        Fri, 11 Feb 2022 07:14:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8IqG6x0dcmgpEEPEMWkWBv55UcoOjqKfXYLwvykFjV08MZDAMe+OClwDlw69cL/H6E3ltpaQs1CBFVuQZf9rgRITdKsGipQjC8kybMSAXF+t1nBWnkEwhi2U4udE50vXMyFaHFJ8ShZk371AQnOcQqUQumMjQIvakPP0ikljpK3qgL/SWPJ7IERceorMMF2sDN/4tb5PZzBgRH4Uvj12uxGv7a2Fm5olsVLIHTd30F0Llhp0Rx72vo/XdKZMsGkiEff3BhtY8pzfj0p/KvKyxZ8CdJdJSh3nHt6Stiu9ga/Jt0+AG3fSYthCaU3sHXi2F1KpakBVnNz6Gkf6MlXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D86kNJLgkRpTtP18ioST64yzG4h0vF/bkpBUSX3ZAWY=;
 b=bMDdVFL/Lk6g0w8ku4aFshJZ0qD0Y7SyaZFH3r05VzDTnMhBzRCtWo/WMV7aXf1trSGms1H/de0rCDecVTdYk7EyQjT6WOu9qmMOer613H1Qa6gkJ8bVcGQ2N0q/LnBZXL6DrysJR7M6CLoIPhEJoTLVmFS5HxFhisSFXzzJPFQkTNvs5um5/GOzbZhDXvKn3dO+wOZkn77dESYeygzT+amCwzI+c840zfh8nztkKFrWxLgHGZ2Svt8HQqEsO5aQl/sq3KBfhncr0A/IqGIQGi/POuXCpKcAaNFa+Q09jfZzFWjONOrQEDM1KGhaOqwAtiBfH8M92rhLu7uTNopGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D86kNJLgkRpTtP18ioST64yzG4h0vF/bkpBUSX3ZAWY=;
 b=bpcMeGwMYc5wPYkPjqZ0VCPpooHPz1iBJNgnm3qy9AXefx9Rw2AF9b6hzVhgmHyJDQ0UKS+UaA44k6VJFYkiAvAh5Q7HvNc9hZ4oqYZt9lfyztM7hGdSore3/xJg627EJiwAq0ZqK8DEl8k6hskXiBsfnQpWd4hOD2ri5BPU43o=
Received: from AM6PR06MB5158.eurprd06.prod.outlook.com (2603:10a6:20b:68::13)
 by DB6PR0601MB2679.eurprd06.prod.outlook.com (2603:10a6:4:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 15:14:25 +0000
Received: from AM6PR06MB5158.eurprd06.prod.outlook.com
 ([fe80::3023:7e7b:d682:52e]) by AM6PR06MB5158.eurprd06.prod.outlook.com
 ([fe80::3023:7e7b:d682:52e%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 15:14:25 +0000
From:   TOSCANELLI Massimo <massimo.toscanelli@leica-geosystems.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "caihuoqing@baidu.com" <caihuoqing@baidu.com>,
        "aardelean@deviqon.com" <aardelean@deviqon.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        LI Qingwu <qing-wu.li@leica-geosystems.com.cn>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: RE: [PATCH RESEND 0/2] Solve data access delay of ST sensors
Thread-Topic: [PATCH RESEND 0/2] Solve data access delay of ST sensors
Thread-Index: AQHYHAHdqzj0liTuW0e//ykxzOjMXKyIHbAAgAVzJACAAOW/gA==
Date:   Fri, 11 Feb 2022 15:14:24 +0000
Message-ID: <AM6PR06MB5158D9EF6708A89D48AE6D43A0309@AM6PR06MB5158.eurprd06.prod.outlook.com>
References: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
 <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com>
 <20220207135858.00000745@Huawei.com>
 <CACRpkdarYo06heRhhi0o5bKbMnVveQ+2j+oKHokxCNftCzq_cg@mail.gmail.com>
In-Reply-To: <CACRpkdarYo06heRhhi0o5bKbMnVveQ+2j+oKHokxCNftCzq_cg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee62ca1-5183-4aa7-48c8-08d9ed713089
x-ms-traffictypediagnostic: DB6PR0601MB2679:EE_
x-microsoft-antispam-prvs: <DB6PR0601MB2679550B93AB38CA59A8FE14A0309@DB6PR0601MB2679.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RG6G9H6fpTr8DO2uSgsS3mg6AIstfksPuLCAWBb3EWMiSTcgOVQhFl+FAJt2gPJqSXku+m+dJFmqi+3Apf9xjQlsMRN1Xf4319bTMKkMGdShBRTSd/7JDNWn3pYElcmxrcBAscDrMegZL4s3sLpDSxMshLIMPpewCcDmmXLNLAlTxi/aUHG44acMvtdDoM3E5fGQmBH0n3SDEmMjKm85Xv0xEV18XtDxecw+Ha3At6gLvrmpekDojBjTFy8K1DP2DS9zFqucYZoGLZQlyWsL+mRLIfJl215lFD2SEcsuX4Ba/bq32oV9mN0DhcoZV0eSDoleRub9al4kVMmetnlZ2UcCDWqCqvk5JanKHfOtLGiFrUBUlik4YbL1zNit69skDeBaTwPPiXbOeUFYEC39lCGPuF3Cc+BAbWp0/By3E5CNQaAte0hRd1uWkyYWl43IB+5uQEsn9Li+XebQae4o8ox6KqA0OMGV0OfcaHeGi8a4QbWjfOZs971vj0c9gM9ViM7jhRo+ecddjcKWgKfAJrNLrgMdce9Jxep+gkq9dDtY8IoWI8ZoOM42NJePbDucEkQoJAKR24WrXvsbAeJVdkoHWNA5XZeA+fJ/j5+PsJoqi1M9Khm+z0CChz3CLeN7ZC5HOwQfC0W7AqcyvADP+VLylJAbVWtPKUFvFVl3W/FTAc7drjPHpDP5eHvnf+Z9ZbhQ2+p03XP0QqbBdffvng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5158.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(86362001)(508600001)(54906003)(6506007)(122000001)(7696005)(316002)(38070700005)(33656002)(55016003)(8676002)(8936002)(71200400001)(186003)(107886003)(38100700002)(4326008)(83380400001)(66476007)(52536014)(9686003)(2906002)(5660300002)(7416002)(53546011)(66946007)(66556008)(26005)(76116006)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?USgif5bsMRsQxzemJlMCGViHYyijVVrm339ARLbaQnMAL734mPA/VTwVaM9N?=
 =?us-ascii?Q?gNfiSOq3SAqhkNDjinYpA4KdNNQ/zWMX1Uaoc1vu96wpeFfct/NXMShn9VHR?=
 =?us-ascii?Q?qfNy/HmQDS3enVnBtfUvVnWmyr7gKwJdNyXTeqmJd/RYOULSYGF2OxNpOWQn?=
 =?us-ascii?Q?6H3rBoZL+tF7CRU2mjBAu4KueUMgfnE4Th20rBSPnZTTCW7sOpOASS+wlbZF?=
 =?us-ascii?Q?jSzxGqypc52o1WLC1ge1HHAdq+p1GsQxn5lwvniEddRVdp5XdCcoy2FvqhoF?=
 =?us-ascii?Q?cjvbEAzcdOl0Giqt+LBF1inH78nngDGFw0jR+gmwo0+n6y7isEMjl+ZWzMW9?=
 =?us-ascii?Q?dJBy2AFedFqixFwZ2qsZL/IZC/VOHwpMUNJyMrb9j2qt+taPRN44HMXON5ra?=
 =?us-ascii?Q?Jm1cXDyAa/pMKMYatSXWV++OvEUiFriPfEQBCr6CgrW+bm1bQAb9Nv6Fxc+j?=
 =?us-ascii?Q?bIPvOwpCuDZZNhJpOZdWnOIeoELJsMwA+crxej/15CYKGYh0hhMcyl/bIq7V?=
 =?us-ascii?Q?uj064ku0kFPT9idjdMKAQeg0BiM8Ds+ryrOxDi9wJHgbgfwvdEa21F12WwS9?=
 =?us-ascii?Q?lCGCOr50B54aMDgvp7d7jcGKtk3sI8coCRE+S4MozLoeielL6vI3aC3KHA9B?=
 =?us-ascii?Q?mw6XFrhAMaAjM6uzmzpmuLtQeH0FRe73UU/6bIKzUIMw/OdRGYP1Si8DcvHz?=
 =?us-ascii?Q?UhKTTsawejrfiNnDmaYzfRk6YkDvg+PjNpcpx4r0q1FbNqhDcHGx6Ix72ARL?=
 =?us-ascii?Q?Rf1aqTLiPanMGRsifzaYZIJPdNWoLpTy6B1kgIwqVzxGwTDluIkqzFpSmJ9L?=
 =?us-ascii?Q?v/twq5xi5eqLrmI4WuL19rgNLz/IAZdSb8BWweMzWh+Q1pnIfLdkelDOE/6a?=
 =?us-ascii?Q?pM4ZQ1MCH8e9hWqgKHkHxfK2bbFCshJ4+qXlB5kaVQoNj83WdGJ0vcn7HeB5?=
 =?us-ascii?Q?goOmSpRdbMIZWKqwWgeiIhWcjCyhGhpT8G0hZH+FdtYcnFP4ScGTMD4LlDqY?=
 =?us-ascii?Q?CfRHnD8v+9oGnWIyueWVYdZXY/lXoFdulpgIKh5O1sda0BckdqCOn7kvA9qh?=
 =?us-ascii?Q?JpxGWm+gd7FuZ28b9JThqefE5YIM9CPwsoQ3GKuWh6k7vhDY1cPhQjb1ow8k?=
 =?us-ascii?Q?Ao61TxIbLLMZF5/9PUE7wvrKevisRVmGQnS4JbeF24fkWSbGAhPkFa3s7qmy?=
 =?us-ascii?Q?RLnYlGDdAlEcqK0G4vvDP/xqBwEntX48v1dSjDwJ+Y/UKjmuFZ5UTvLyddg0?=
 =?us-ascii?Q?wmMYc/NCutXgOUSWVYw7RGSDFwmjbilH18g8/CEMhFawPXt/dI75oy8j+3YT?=
 =?us-ascii?Q?XJPx6fFB8/9iVzHZP+Yorc+8vfw186SXuWCG/qLvjizdWe8LfVLElwXaUpX9?=
 =?us-ascii?Q?ehSoTkWgvQN4kINyPSR9Q+6Ji+7PkwtTLUp9gwn36BZadZgndaVk62rvcCiA?=
 =?us-ascii?Q?V6IUZ6bqPsecN5I9sQIcm4qZFpo0+GFVxrQphqw8LliJTRRVAXcyD+0hKlLu?=
 =?us-ascii?Q?pwdmiDYY75feIMRryawhXU1WDb+SfozfgzrpmeCfcfslmRekmeaw4qVVXuoD?=
 =?us-ascii?Q?Aoduj2j9sXxqYe9VBX5voQYmN/fHvY5FuUFNl93ScTznx4NQcM7Qz1OsCGel?=
 =?us-ascii?Q?8gilRjeT5y+kVPmj61JeQdpn9ssXXG5bzJ4c2zHiWc0jPmnoa4gnPHQfrVYk?=
 =?us-ascii?Q?tvPQ3kUlVNijH0VNR2B+2RMreAqOqROOkvzaZ2Zs7ks6SfZR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5158.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee62ca1-5183-4aa7-48c8-08d9ed713089
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 15:14:24.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tApJYwIg9J0I3LlVjNyCRXoGna8gaRZom6csuzVaXCpyku9k7ELIv/Wtwf2VkEMWdJW8QinmTEMi3pyXhtpfOlGukJqSR8A5hfAbbZ5zaD12AZ7nOom8eDF8W7T1RJJb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2679
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus and Jonathan

> -----Original Message-----
> From: Linus Walleij <linus.walleij@linaro.org>
> Sent: 11 February 2022 02:12
> To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: TOSCANELLI Massimo <massimo.toscanelli@leica-geosystems.com>;
> linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de;
> caihuoqing@baidu.com; aardelean@deviqon.com;
> andy.shevchenko@gmail.com; hdegoede@redhat.com; LI Qingwu <qing-
> wu.li@leica-geosystems.com.cn>; stephan@gerhold.net; linux-
> iio@vger.kernel.org; GEO-CHHER-bsp-development <bsp-
> development.geo@leica-geosystems.com>
> Subject: Re: [PATCH RESEND 0/2] Solve data access delay of ST sensors
>=20
>=20
> On Mon, Feb 7, 2022 at 2:59 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Mon,  7 Feb 2022 09:04:41 +0000
> > Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com> wrote:
>=20
> > The standard approach to avoiding rapid power up and power down cycles
> > is to use runtime_pm with autosuspend and a period set at a period of
> > perhaps 1 second.  Would that work for you?  You'll pay the costs of
> > power up only on the first read after a period of not reading.
> >
> > Exposing the control to userspace for this sort of thing is normally a
> > bad idea because userspace generally has no idea if it should use it
> > as there is no clean way of telling userspace the costs of not using
> > it (as those will be device specific).
> >
> > If you have a usecase that requires regular reading you should also
> > think about whether using the buffered interface is more appropriate.
> > IIRC that will keep these devices powered up continuously whilst the
> > buffer is enabled and will provide a lower overhead way of reading
> > data than sysfs reads.
>=20
> I see that I have repeted similar comments.
>=20
Thanks a lot for your suggestions, I decided to go for the second solution =
proposed by Jonathan.
Using the buffered interface should be enough, you can discard the patches.

Massimo
