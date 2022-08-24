Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4CA5A0233
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiHXTjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiHXTju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:39:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07016263E;
        Wed, 24 Aug 2022 12:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7/vitY5unYMh86ZgfVpOtRKUY7P0iLhTmyPBTW3INyG3Kj5+gr1aKjgAobZvZACWNwRcN302/jzoy3ZJk8rEC97KGTL+GTFgZwBFg7g3HZZ+HjjSXAYXlFhMWP+zlJ5+ch9dRur7ZF79209xxALo8pbAGy7ghcF7Bm9paKb1WmQO/nioY2qM+BTQSPjwGFfROLbA6nyRxlo13nDJBcX2zmGCvQPAHUZxY0Cd2KhZxEHUQv+oGp3jo/aFfzPRCi3IHifVQZ1WdWzwfV5naveNFNSzuiejsDhCD0hePk2W+ob21Ag6motrXJ4uSZEg4mT677If4Ai1Cot309Xm4Ge2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbwluKD5MgBjrq3lC8jfGkwVJ8HrwIueXwzGG8vblNs=;
 b=hR+8Je3HrioF+uUq+Dewr5a+h29LHHxUb5iRHWFCcroGmIAJ4Z1kNwuhIQHgNpogxqGB8gxYYrMTwbsegdGMP6TrSnjVy8H5ljR7gUcs7wPOISAcpzc8vFEwGw9zUYoCxYbxYlSSyZeIUUZAV98CWwstRWvBbYhEET5g42Fhk7iZUxMO/ZhVGwpFuGeGrWXjsS6gFPTSPfy73iJ1OegAgUSAgVOpomKqdApSoavUPRIlDufxi2M6qGDaLQ42va04S2d52PH0XX/IQOhEiXQNdUZCIH17CuBD+IlGEnn+KiVUz3c5XRCm3OXuttRengygjJ5sgnV7z+hWaDpjC4AZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbwluKD5MgBjrq3lC8jfGkwVJ8HrwIueXwzGG8vblNs=;
 b=HSao6VyfqHFnVNb2ei9ntMMi15JtJyuLIJpEdfXAf1ukBFZ+L6OMfjmHm+iuqexxeB66VHoHG9VDsTCQUjmgeaTtg3T4NGNqKX0h9xWROZALnahDt1XZ40/vQwKy1ewP+LrrzAT4TCTcBHVJQyKOF5DlP05b4GISRW2kwxwzw2C9+nMIzIZkC212ZpZ8s/VDp5MtGnM1fikiTcIMwjh3lqUYDdM23LwM6m6t4j0ht//D0PTw4kkoaHvsbv6JQD4xidiDvpA/xmWxVOA02YAh5WM2mC5x6b2sJIpb4J1H+CaYy1VClXLoGXC5Uwh8RBSX8s1AjP3mqEIhs+TRh6Lw5g==
Received: from DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 19:39:46 +0000
Received: from DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::c5ee:6ad4:e02e:f226]) by DM6PR12MB3164.namprd12.prod.outlook.com
 ([fe80::c5ee:6ad4:e02e:f226%4]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 19:39:46 +0000
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Kartik ." <kkartik@nvidia.com>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        Sandipan Patra <spatra@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc/tegra: pmc: Print reset info during probe
Thread-Topic: [PATCH] soc/tegra: pmc: Print reset info during probe
Thread-Index: AQHYsmmGR8fp18152ESxKlaB5UYTsq20xbIAgAm3/4A=
Date:   Wed, 24 Aug 2022 19:39:46 +0000
Message-ID: <DM6PR12MB316434A9BA61A01251E3BA3CB5739@DM6PR12MB3164.namprd12.prod.outlook.com>
References: <20220817184456.1184459-1-petlozup@nvidia.com>
 <Yv5XarzacTOkTL1k@orome>
In-Reply-To: <Yv5XarzacTOkTL1k@orome>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 046b2372-328c-464e-c1d5-08da86086686
x-ms-traffictypediagnostic: DM4PR12MB5747:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E2NOwxfpPn8CGQFNVWpTANenZhKz7qiReQFi0XNQfVCnsmurqKTA/yHOgYMuKR8ftHoUmudbk1U5lUNNdbi+ZrROMpjiuCRV/HSp4erYBDY4gkMA64MbVheARu/a6248stzYFTjOWc8cHhS6iqVXtj2xf6yX29qzT+y3zUcmodZJ43RdNN15UkrzeqT1OEHO9RlQzPGjsxWkJIn/T7sFzMwzvnealhz/aRPnCtA86SAsvtCKp5rctDo3ylf7MTPeHpFtix/b5bT9RHLt2ofkRKN/nBof46G3bM6QXcHLJSNcyLfIigWo9XSphZvS4zrlY6JVKtIyZzlvfhjv34QAfAACMgccbMhLBImyI+JBwH0pbx7LY2QC5swRzJpc+tCdRoXCdbvzzNw0py/Cdj1CZoB6g7LJvm5iaAa01RHomWT2wz5ojreWDVb+4SuBRGBVwOfFOvP7tyY8yXLsDfGpJ2Yn6pVGabKcCVeNM9XV9BDPwxfykntQ/5y8/Jj8WyWvdGuqX1F6SqTL8gQVgANw18At82cRat38aPNjluxs763qAmDlK7xc6IEw6elY2mq++5AwuROO1eRnz+oHjMAlUJYiDd0esydQZ/DtHJP5NMbuGEJrNOaJ5IfCT7hY9i+Scpc+/pByAgWT8qRtjrYZSNV53cHLPbWT9cnKxUlM7XfQsrbNVpth+MmCwWRguD+SSS7AE3vE/SmXinCjycn02KUWvfbP9qP8LrWtsIoItJ4iLb0E15IQI3Neb45jcAQcedhOD+vygCx9/dJO8v8wXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3164.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(33656002)(55016003)(76116006)(52536014)(66946007)(8676002)(64756008)(4326008)(66556008)(478600001)(66446008)(122000001)(9686003)(26005)(7696005)(55236004)(86362001)(2906002)(5660300002)(66476007)(6506007)(38070700005)(8936002)(41300700001)(4744005)(71200400001)(38100700002)(316002)(6916009)(186003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JD9E61RlYFFcYPLToOGC0sH96I2EzqxhUcgCi/9GCwLzAdpBzcV+/BWAVgn+?=
 =?us-ascii?Q?WMUOrVMwrk6CeoT6BG+DGNkz5zQs9VUPd4LM6PfQ4yp5M3KUj5A6mRPi864g?=
 =?us-ascii?Q?d1m54j3+X0sTgKLLlUROavIo1VT7+fhNOQC5lZhGvXpSbRM7YR25uPwHdwCk?=
 =?us-ascii?Q?GgR9jtZ4jv0KSQpVCVSlsRFmw3sHvE4JLQTRGVoOgfKjBK2yqrufNtA894UR?=
 =?us-ascii?Q?zbOmOHQa+OgehRoRFsOmHg+V+PPfyXHBfJHNQRajj8rn2p/cgQ3+c0eG4N0L?=
 =?us-ascii?Q?KH8ywAuGY9C/l5HHP3CvpKiE4kenXvH1g/DCK+9gj+CPWD8zBPc1V3D2k5P7?=
 =?us-ascii?Q?Vj822W3A+OH4NWdz8io9NVeNm38uJQ6Zd1wRtmkn0nBJttIrtvLpUCkl/G8p?=
 =?us-ascii?Q?cCQ8UXy3zYOsat2h7iAWvNFsMXkLM2QbkMtUoTwtNDaiCwUu3MmkSlRI7031?=
 =?us-ascii?Q?fUcfH+JVLQHKfM4mAgMX/A9KWWNyf29hhe1bKQR2Go3S1SOCKxrxIJJpNitB?=
 =?us-ascii?Q?feo1atTzsSr4/K1DR5JqxUBRzquHcMa0M87B5V3RgDxnowVDocTKq4e/r2jY?=
 =?us-ascii?Q?wpOCHY9v+ea4WiwwN9pw6ohJrQT5LQXfPTnjRRUHmz2IBxPg8ndeR4dAznty?=
 =?us-ascii?Q?FIfrnOFMmC1Kt+pm400EDCu1p5QRHoMtXs8kOJfgvi4D0HvolxJ/fieWX6SE?=
 =?us-ascii?Q?rBdjveNfgXxgpcTsPyi2YXeruK4gRjhKACNBrouLE5kFws9wTmzw1ApfYu2F?=
 =?us-ascii?Q?Jg0ndto12fndeaUbdx28n6eb5gZC5HdAxyTPdI65dJfvEK5OFHZ6AvJ/pg3A?=
 =?us-ascii?Q?5uYBzu74jq1tkDT151xNPkFlQeSO1wUdsqAVd6wn3GPsEbHlqhHkaDoh8Z2D?=
 =?us-ascii?Q?aIe14LwPkp643LOl42rxhZpFr2gS7GR9fVGt3W1jLsXSLqC2dUd1u80dwSXZ?=
 =?us-ascii?Q?uR4BTU+tdaBUTpUK8tdNo6ZWFYrdfvKkyZU9AoJc7ZtgJMPLoRUEgH2UxU4m?=
 =?us-ascii?Q?c3Qv9kA04BVTPjSyIh31XR3/iT77fkRNkHX0WuPB07nrb4M8vHhhKWkNwEzx?=
 =?us-ascii?Q?BAzhv58WgKeIkLZH9+MTH3erZ87faXsDRasZ7fstUqhAnZyK0CWscASfOeBN?=
 =?us-ascii?Q?WFXq6B6bp11eD/sv4nvZhPsd9aB4GJ/LBiztCtIKTRdFnFEecUIZ+PZ+ATU7?=
 =?us-ascii?Q?9Ay84jgpERbJqSFcQIlVOATyQah1WzxaJCOZiW0F+I0ZXW4iLBxqk4OAM+4v?=
 =?us-ascii?Q?vTX1RoNtwcnKMGW1vG9cwXSlJKpF1CymotB+umN1MVXkW9yPtsqt4duGMFtZ?=
 =?us-ascii?Q?JSG0J3dpy5lv7H4sN+oOHxg5mJdPuBFeq6IlKHwZ9YvhebXC/Wn9OtmAK89y?=
 =?us-ascii?Q?simWdRy9iNoEDvEePnWu98fG+F6nzZIcBOh/wkzknHumMXrnkFIQfAN9Q2Zf?=
 =?us-ascii?Q?3j3Z+UO+9r54ctK5HMSINnnRynsqbRHsXosb/lQmG7qZMvKfjOMGGJ4xPrzJ?=
 =?us-ascii?Q?h0p6GmKqi0/7QIRzhWTRX+yFZoUo94ceq3A7ZgfjeehblbiZwT/ROZWgbno/?=
 =?us-ascii?Q?hPB+Z6fuwvgJDV8+CFXp5GkgKxZc3oopNSug34oZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3164.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046b2372-328c-464e-c1d5-08da86086686
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 19:39:46.4001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9aMdgMx8ULHExe0wZE9PvFJ/NeqmLfaiADC6SQgmowxLKtcLrJp/wS+7XfJoJQAzuwmt6I1OgjQPSO7ef4DwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Wed, Aug 17, 2022 at 06:44:56PM +0000, Petlozu Pravareshwar wrote:
> > During PMC probe, print previous reset related info such as reset
> > reason and reset level.
> >
> > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > ---
> >  drivers/soc/tegra/pmc.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
>=20
> We already expose this information in sysfs, why do we need to print it
> during boot?
>=20
> Thierry
There are some tests which would parse the boot log for this information.
But I agree, since we are already providing this information through sysfs,
there is no need to print it during boot.

Thanks.
