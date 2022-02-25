Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E274C3D02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiBYEUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBYEUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:20:22 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2071.outbound.protection.outlook.com [40.107.95.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A6127579D;
        Thu, 24 Feb 2022 20:19:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar9pWuzJKIPlTBdcCVzKXPU+aTBFLknTCNR8iBpSPuYkXedkownY8MnwMc4fLbcPBFmfwmHhUcJnedb1s/YIFpoOACK6NWsPBUnV1N66i7qY2L4+Ywkk823u98DPHTPCBHWefRBOAv2mVWCsyZVKbYEoipyTlVSNQf0lBFI4UxVeo+EZNIW3l6UPZqIEMPWuSS+xqJmEdApMKcTNU0zrYT12DjVEGR47P8WT+Ha+u7J7ft2phGaHbJHl3ePmPKoTOrK4BKar3ICeg4ejK8NC72i3NiNTq5yegl7dngyiG7L95Mmud2uWLTsuH2dn1stsCx18Z9QDjrU0+jz0TmrnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqXH1MBRtNt+n6NCeBoUpzEeGmCk4xVnR7RXEIUTHeI=;
 b=OHwSizii0Agn4u6zFLRNYf4zhHF/RQw4BUZsarI/FlY2z/QeHb1wDsVGBaEEaPVcIiENDi+ziGU0JY3TUKXeEuD4dKW+SoCUNJhKOX2g8k02PoTt/qoHltzpALrl35CwtwpGvn/aBvpgnt/SSN6j9X+Oa8/8S6X5fz6X86E7CRgmZanHp3ISQp0roMNHHYJuueHVhFigQ+tX+njMjfFPUlHgu/cT4aaGsgSKR+OAp0qhcRfPawTYij7Oe13J2GNjhgdPK9rPU+8rUyUi4k+liGMtyrkWbD9frCvx2NijI2F3n2mVEBmzKxcxhwhIzCk2WESMs+grcA3YhhSI2byVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqXH1MBRtNt+n6NCeBoUpzEeGmCk4xVnR7RXEIUTHeI=;
 b=uuHusxzRhTraajHHGubzmFNRW+gA4/kHauRDr1jUKJQ11mhGhZ+nHZoD2pq9//i8tPURnqZSEN1FYXeX0mJQeSuPjzJQfWtIuxeoCQiB/id78jNAsqq2th+XYZDBbVGBlYnewbsBHGaZ4TU9MXQrSKJWFqQU0xwbJAZ9ICZSvig5XcALDYy4ck/Va5QwlbxN7MpbSY2+DknWd94EACAh8IASGxegJOc94FpcdFPnist/+eiGHl38yj/8wGQMopr+w0f1sHtmVd0JaRfCnJ+zJ3D9+HQnFpP3U919G8uFC6dG5K4CqYyrZcnHL3HRXt99J0YoNAMsHkdBoK97dUL3dQ==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 BN6PR1201MB2498.namprd12.prod.outlook.com (2603:10b6:404:ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 04:19:49 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::d91c:c44d:f621:18b6]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::d91c:c44d:f621:18b6%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 04:19:49 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Subject: RE: [PATCH v2 4/5] spi: tegra210-quad: add acpi support
Thread-Topic: [PATCH v2 4/5] spi: tegra210-quad: add acpi support
Thread-Index: AQHYKBWa+O2JqvcM5kOPguoIZ3KOyqyf5iWAgADIESCAAliAAIAApvfQ
Date:   Fri, 25 Feb 2022 04:19:49 +0000
Message-ID: <DM4PR12MB5769C42A0DFD716508CD737CC33E9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
 <20220222175611.58051-5-kyarlagadda@nvidia.com>
 <YhUtQ/8Kgcx4OY4S@sirena.org.uk>
 <DM4PR12MB57693F28A727964ED67BBEB4C33C9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <YhfM1DO8vmvHah+f@sirena.org.uk>
In-Reply-To: <YhfM1DO8vmvHah+f@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6920da16-e5b5-423d-9f8f-08d9f8161056
x-ms-traffictypediagnostic: BN6PR1201MB2498:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB2498B7515E900F5EBDF1B8B5C33E9@BN6PR1201MB2498.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7cxQ3z+qIA5qKiBNjtUuDNqz6TA9C/ZTMXwrwxiaoP4YmV2l7hTuZ1xF90hjks7XXF0XA78l6ywn2856OM1it55DntH8yv2LhQEJ6OWuhnQ4V8zXuEj5kyuaLhLXOjJwUvzaUrsssKa8lHE3CuU/p5go9lya9SitGARDOFrac7lz4iPhVe/HD6YDz0KsRKwOrpdljrJEBWsN+S+nU0QydIvswmSgCTiDA1kTG3OZWBwo16wHYXPFIh5H8hQyDRc99TRomt4VGu7JogTTwCTKWFmwsUvrohyrs4iUx3fVChojAkWQvfd0A0hWFy5+1guNoTV+VWfCgQ/yJemdbb1TOpHpiZsI5v7Qfa8+OCCidMrgow+En+41tiydEvO4jqlW/nyguD9Dw2eBX8HK2MOXDBTTjZFTB0YPPjzFhRJA+Rch6Kfila3B2bpv1I9q6vziI0o4Kw6gM846jNnQk6SPM3JOqIHI7dX6AWu7wo0Vzeer7ia9nIlZFwhmJepx0yfOQ5bM4mdR1eYrWNiDaYt+UNbFdjkKwK+/NThY/vd1zsFp1fThcwug3RAYet109CfJL8NgvheFyu8IuijpyEsxNKrBOmdn3XVkl5rZ2igOxivX/Huqn5mcEF/NNXGQRPdsYq+ssHYKdPWV2lbrRx4E4LwS2wCwdj3+UiNVReCKC0CjCQmCBOKYSKnZ4ccpXORkjIQz1dRn8c+E3ofeipwMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(508600001)(122000001)(38070700005)(71200400001)(83380400001)(33656002)(2906002)(316002)(6916009)(4326008)(64756008)(8676002)(186003)(38100700002)(66946007)(54906003)(66476007)(66556008)(76116006)(7696005)(6506007)(53546011)(9686003)(8936002)(66446008)(52536014)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d1tqiEns7HotNNiVMwFlAVFPXCa+71u37Qss92Zgp0bIpg453C3bTaA/SZO/?=
 =?us-ascii?Q?2tYmB6iVTq4UfreDsW+62k2WfEDNUJzLpALxgSuUjZtj5HJyojDkLSBf+BmD?=
 =?us-ascii?Q?aBtMZG1B1kKJYqBg6zwupsD/yMwj2HiJrT64QpUtZAQYd4n0e9UV+66Tfg1B?=
 =?us-ascii?Q?T6Z3IBI0sH8232ZaWqvKucdGk0rFcaTQABIucYFvdCI1wImBxllG+oVIoATQ?=
 =?us-ascii?Q?O1CqtnBJgwiBZaCvt1b+LvVBGtPuhQERHw92ODD4SEhHljwM61WFZ6HSPUvO?=
 =?us-ascii?Q?QPMbYX37FUxP35bXCDUt6dBJ35oN1V2YKo3SHgeue6ZxOpnr3aBWEE+RVdaN?=
 =?us-ascii?Q?2GW5sIL73yZsmYNwHx0jdFaUtuLSRhd0nej/oq8Iex2w5H9a/okS0BBeBhmb?=
 =?us-ascii?Q?kyBSzRueQu69M8mrSZtQjsFJoJ8u2ijyCeHvs3wl1vY/uncJppd9SJ25lXkP?=
 =?us-ascii?Q?8bbsm194DeeXZk9fHDfyhNtuqS6SSaLZEpkYYxuYep0RHJX05FKuzlb6oBNx?=
 =?us-ascii?Q?VqGDAFf/LNMHjFK+c3mm6Uo7tFXZbCmNhk2IT5F5iavcQOC2M0NyYYuAyB+8?=
 =?us-ascii?Q?fKXA0Ip0RDQYBE7y0kYV8rJnN2zUl5g7JQSaKn3kscQUcAMAhMTHmx9gJ4gh?=
 =?us-ascii?Q?ry1HsjERybbxTlmmyodEHx+cOMPc5u7HxtM/6I5w0PAS2Atb67FA2C6BXLJC?=
 =?us-ascii?Q?nVT2weEnUt4drvNt4irOwOOUX7N3HATjfTTMGr673jSaF3h30loib+kOTdfq?=
 =?us-ascii?Q?8spVHsqTICYxEgrt1YPdm0PVfruVec3Q+/BlaL/DUn1AGngD+27Ks2jxfia+?=
 =?us-ascii?Q?9If0qasu1ozRY/AnerXxickJcfPhhtBZEc8a3XR+vxcV/ZlniOKrKtOR6hzB?=
 =?us-ascii?Q?9cKQ/ZTdTVnWvNJsE5wMMXIlYSqRXl5RRRQZKVJKj/Co+qnPqu3C9cLFY0Pj?=
 =?us-ascii?Q?QRajpVBBIL3Ix/SJMHrzVfAA6OIeUdXO2hXmcCkTatdZWlIQ4rX7LI/hzlcz?=
 =?us-ascii?Q?LJQaRBJAw5OM9AabdlqBIi78s9BBYdWewRnfZhAVcIrTKCc6BeixvJousZ+/?=
 =?us-ascii?Q?E11s8zmRE08hi/rbHBunX+bU0Oaf9VHYT+EUVcZ2QRE2riIo4ZrRaxJOKTjX?=
 =?us-ascii?Q?Aiqv9xIDb47BfQ6YNX4QTQjAOdN9H5LT68Qq1ouN0iFuRVBxlwZxsGhGr9o9?=
 =?us-ascii?Q?gso3JLWLttMyrSXV8nsnJNfFDUcufzbZXHmAW9+5IUfsLXWYVbUBV5luUYez?=
 =?us-ascii?Q?zuIpWzFrQUw7bv7NpNQYLY/EVk/k8DC6js9nQG7cnroKk7sWztmX7kevbl0U?=
 =?us-ascii?Q?GeY1yV+u4CTP2Rh8fcjY8orBgdGhJHY/f6qLi7CrFt0wc1oUAgsI3OZwLoM5?=
 =?us-ascii?Q?bPXz1EzzJFN+hOGtTET9JCHWMMxFYbEhoPZ32GTx3kcONkb5i6ki318ziRkK?=
 =?us-ascii?Q?4BkKlN+Ik1QDomnl7BlIXbBAPgxFyDVbJVcHqVfJFjJzivIT+hu1vTvSm6Id?=
 =?us-ascii?Q?DeE2fg5sd8rwJIGRLIuFx7FhAa7tri4xDum2zzixau42rE3XQWF2NmdaOdEb?=
 =?us-ascii?Q?6RMq/GLziw0+zkOQFqWBJi/c75c1ANzss78IIx3h9dQohYSSeKgGcf58CSam?=
 =?us-ascii?Q?N38sKeBlzm7G/TC61FW6HhR+nDdcNLlA5vshWWASniH+J2nYWVUYGwAJIBXP?=
 =?us-ascii?Q?/dvNITuqTVP4AcYvrBlSGLMBg4s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6920da16-e5b5-423d-9f8f-08d9f8161056
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 04:19:49.5936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrDVw0jy3ukSctAF/84+tNtN8XKvaZYh9ebzqK2CDaHh6pGN53DEoE0kudihKk4z8gRa+quvP2LxJwnxCs/FDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2498
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 24 February 2022 23:52
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>; lin=
ux-spi@vger.kernel.org; linux-tegra@vger.kernel.org;
> Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@=
nvidia.com>; robh+dt@kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; p.zabel@pengutr=
onix.de
> Subject: Re: [PATCH v2 4/5] spi: tegra210-quad: add acpi support
>=20
> On Wed, Feb 23, 2022 at 06:32:56AM +0000, Krishna Yarlagadda wrote:
>=20
> > > > +	if (has_acpi_companion(tqspi->dev))
> > > > +		return 0;
> > > >  	/* flush all write which are in PPSB queue by reading back */
> > > >  	tegra_qspi_readl(tqspi, QSPI_COMMAND1);
>=20
> > > As well as clock stuff this is also skipping flushing of pending writ=
es
> > > - is that intentional?  It's not called out in the changelog and seem=
s like
> > > something that could cause issues if someone runs on a system where
> > > the firmware does implement runtime suspend.
>=20
> > Runtime suspend is not enabled with ACPI firmware. Converted compiler f=
lag in v1 to runtime check.
> > We must add more changes like setting DPM flags for runtime pm support =
with ACPI.
> > Can take this as part of a different series.
>=20
> It at least needs to be clearer what's going on here, the changelog
> doesn't match the code and it's not obvious from the code that ACPI
> won't kick in and power manage the device as things stand.
Understood Mark. I will add comments to make it clear.
Also update change log indicating runtime suspend does not work
with ACPI.
