Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B34C0C96
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiBWGfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiBWGfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:35:13 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A536765157;
        Tue, 22 Feb 2022 22:34:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFOnXS4Q0oc0mVdM08fI/e17Bmd9jtdeto+61vc5ooHhHepZ5Ukkkvp6uLviv6o0oPvNtsFAutuVAfrx18Re9gfBPwvw6drTl/J0ZF6uYq1pCwWbli3Az6GrFdH/hXULpe7AmiCiqzln9TPcS8qiJevqx8UNoRTIIhdtG3GJL7Ln3YPmkJ3m6VxSdxjbzNYIAuHbiKC5BpZaP1YR29TINIWky6L6N3zpet+q8rlIZgVOUiqiW4dDinWFjPJfM6v2whApgdYIhSpmf49XqqAYKc4WHtoOyixr4D7AsObcu5EaANUFVkjLb8IimT3QUdNDwZsxo6g27W80kBIDZC6KQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlDlgV7EzevhxNtd5599zjcKEY7YHcpBEPEh+1DIUrs=;
 b=QQuY/6FC10wcJb4w7br4CRkBZzpOSF2tkdWfUzIWrHUPHK69f3fp7NWXFTyuYzg5uzVuYlqcMvQqfMObJSLTDu4LWYvODTppXUVvzJxgEo/kSggsJ/jmu4KL/EXG9xa//uMTSho86LxD7vp1+hgfjPu/cm67P7PcCfJ/LoLOMawRJs7/BVYDr2tCeJ/L1ppizMB6crVHOyJcgsCe08+/2pH2iuqX5mYl02cRb/IBSAi2Minvm7n/nGtSgL1qV1oYONsdlpsZVxraeRf96DFzkuO/7M/bnUSK88X3EcYz2L+OCCc1AAqy0BAsO2b2xvJWGs+M0nnIdl4Yh4yfV4/B5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlDlgV7EzevhxNtd5599zjcKEY7YHcpBEPEh+1DIUrs=;
 b=XlEgMBiZSJgMxikeNL2Ydftsat8e0I9K+/arB4WA67lfDRnyGOujBT6Y0KSVddtyCfQw1zJCHAoSPYe4RMSDw/zZb/aR8FacsOu5tAybqnJifgb9cP6Tfto4YOSYpD0Y8fyDQURVV6WMEpqqGadTWx+3ytMNDuekWrooqSeCCheuOSrTP/nUkxQQM6pOwu/u3VsnD1TLiQkzjfvXZ07BdJK4qBq/hm257dOKQPp9yYDbO/L+MOJNlXfwO9j1TTbAxJsEQ8X2Kl0YPocsvVq0cbmBMm2CFTPzRn9o3uIyw3OiOWgFjJ3ZaMx7Hbk7DnGncyK4ZMmRVs+FzKOxWe5xBw==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 MN2PR12MB3406.namprd12.prod.outlook.com (2603:10b6:208:c9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Wed, 23 Feb 2022 06:34:44 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::d91c:c44d:f621:18b6]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::d91c:c44d:f621:18b6%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 06:34:44 +0000
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
Subject: RE: [PATCH v2 5/5] spi: tegra210-quad: combined sequence mode
Thread-Topic: [PATCH v2 5/5] spi: tegra210-quad: combined sequence mode
Thread-Index: AQHYKBWjj4LbNoGwBkCe53Tr2h3kVayf53KAgADHQ5A=
Date:   Wed, 23 Feb 2022 06:34:44 +0000
Message-ID: <DM4PR12MB5769CB86A0348A669647D0F3C33C9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
 <20220222175611.58051-6-kyarlagadda@nvidia.com>
 <YhUuW+MlgeQRTVZB@sirena.org.uk>
In-Reply-To: <YhUuW+MlgeQRTVZB@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 220d7fe8-22ff-403f-6451-08d9f6969432
x-ms-traffictypediagnostic: MN2PR12MB3406:EE_
x-microsoft-antispam-prvs: <MN2PR12MB34060B999D0CB8466E3DA345C33C9@MN2PR12MB3406.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QokCMFXQ79eDpkyJvX2NSTbblFH4aLJMtAfE0bHFyaPAkDMhIMaWGKHWR1L2DREWr8gNgT3gRXbrhfi/Wv50GCIXH+snvfahDx+Z2GsuVIHOe7vYFEIf+RLIUQFjEZWYa7yN7rroA5HXwX4NW0GAKzxgY2SiBFjYUTqM1jW56Z83lba8RlopjkBxFUvUzl8mxmlgwbEsQjrRRVORibIzSwnVm8SSbtPlPK9EX2YnQX+DQnqsEFnJmv+w1fg/glSVlh9fX/qPbPV1ETrn5AMeMFm/ctHseijz9KF8eeh3gInwj9T3kKJyLmxRaYMA0SrjXU4sgKJMe0VE69CMBa+xMyiB2yUNeH9JRLiMr8eatkaP7aWfpG74riQ4+kgy5hZpnx31l6xLDraAP/TzOk/TxzwnWuv9sl6OwZ5uy7OTgTXTeOIwzz08MdCUAbUO/UBrVIvnZMeTs6C90HVcqniHY990uXSja914akEjvYKoPSJZkT8zRevg7SQuJSVf9zbEz8GZCV7Mkvl30J2gsaFJLG/uMb7AwxzMG84igsPJ1F8JZdkPzUYG9v/XGAFOcIOM5F2Yv0m5so+IWPWOZg1oH8GzjadKx3TWIj/+prDkJTd8ISnEBcM6isqnqFc+csdx5wKly/4JzUdDxNYvJ7N/4WMWnQFfzy5uVTHA6XJaOoSw22o1t5SOEGg1UiXoJrVIPJRHlRaAQeSbnY2YtzYMcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(186003)(53546011)(26005)(55236004)(66946007)(76116006)(66556008)(9686003)(6506007)(7696005)(6916009)(316002)(86362001)(54906003)(66446008)(64756008)(122000001)(8676002)(508600001)(71200400001)(4744005)(38070700005)(83380400001)(52536014)(4326008)(38100700002)(55016003)(5660300002)(8936002)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/MCi2vy9R3cWx4ftZVIzZGDFvqi/CUgp/gIBfokobY49L2sxWNfPpJFGB2Hr?=
 =?us-ascii?Q?wIVtR60EHHOIUnjbW8oQe7dy6ocF7MvDXZvdYBDaqoha7A5VFhG0WJo60W6B?=
 =?us-ascii?Q?kNfVcw2Rk3SgHUhJuD0GG8HjMQcQQ6GV9Q8lPWY2ylC7qcL2ofKg1UqwiAn7?=
 =?us-ascii?Q?PguyKsiK3zWydga38WR2o0XjU6P58V/3rpRg70UO8igK9yhLoDnRazwia2nq?=
 =?us-ascii?Q?dB5+5cspIUNuY5T48AEyY7VYYBgnySM9ZpM0RxSKhS35IWJM4tZtqGxYxVAe?=
 =?us-ascii?Q?mNcivvN0cGP+vUT+sOoBw1GMlvC/vz39wzJpu+lR2ZCMGlM2832palXsHPSW?=
 =?us-ascii?Q?z89JuGXyS0yK29SR403S9dobgAeuEPq638bAjhGGaud3djfd7HD3QjFNQfJB?=
 =?us-ascii?Q?51rR/GU2fapn3f9Yc33nXxFaElcTVgqqvdgOKH8+abBsQ/b175H1eEJ3P7SM?=
 =?us-ascii?Q?0FGH+uVk1Xzn4LIhLAWEeh67NgGWj6vV36NsWyIdP+YSw0Ry6gTz8EEYGHGB?=
 =?us-ascii?Q?myl5bRl7QZpg7zL4jm+gqB44Ryd7kcBduwKIPPetsP/dskQRa/OwRJv6oEeP?=
 =?us-ascii?Q?lf/g5pO3rt/SoRHxYLC45a8GaRAPRsGHpT9mlk07EyUkUK6k1EuHFHwQH4uo?=
 =?us-ascii?Q?EtiRLBkT3WDusE80qX11V6+C9ZXRbcuQk3Prcz9fbGoDG179Uy0u1D9WJ24V?=
 =?us-ascii?Q?DaWdmCqjbC8X3msDHvvXV+av4uYJC/1XM9pfPkdTu/9HWgWB9wnFzZeMrewq?=
 =?us-ascii?Q?o2fGAIWyfhL1+3mQaPDVWWMGzD4GbTmUd9t3Q+3oNJk89kGwwL+xzZ3bgkON?=
 =?us-ascii?Q?f9NQgMLvnIKDEAN1hWzTGXNz6INXzyegmJUDEXDkcgfgiLJTWPv1hhXtK624?=
 =?us-ascii?Q?LdYHkA5U01+hivcsTwzDn6gGP6oUOhtSHbF1AR9orf+JOPyoDJ7GXJrpu0jd?=
 =?us-ascii?Q?w4ZE8iIvYQBIJWvdrjQSBFtfUvnEY1tK+aL01IpCiNKuat3RSnlUfJabvRA5?=
 =?us-ascii?Q?yr24a1HSlI5SbqMQnBHPMM/VnP/jBro/HHmnrw/HhyqywObq0RwJs4gZcrZl?=
 =?us-ascii?Q?xq7K5yWA3vh7uEXlZzRYLmoTYJiz4vhBpHaAcDKaqkr1vbR6uvaTd7lif5GI?=
 =?us-ascii?Q?Z+kS0I6beRNjN4L7HukF+GCRcM2E0rATB46/rG6qT6MW5165NxSixQyjt9gY?=
 =?us-ascii?Q?KXWSXCd+GGz+4eWC06RGvLWLbSBnDQ3Xn2actLqZePi/wuouOoThIOb/eQbT?=
 =?us-ascii?Q?D3JD7LphpcOvDikhJ8CW6OxmBKXatGl1Mp7K0TAopZxSfBhtOguyKbfE3BKi?=
 =?us-ascii?Q?KivD/ULATWK8YOwYhrs6EUw5EABtsTxh+Xj4dV5evv9ZK0DzuSBeW+ykTO4x?=
 =?us-ascii?Q?oe2FRovn5GlJ7uHaRQgf+299z6fFhg3taB5abmKpZlBgksZQ8g+KpSxui772?=
 =?us-ascii?Q?mu5cYe1gyMyXKny6r9Fb+XOXnbQ2hb0TUGpWVlwnfYYQJMIu8g0eOpWkSuFH?=
 =?us-ascii?Q?RiSIIzYQxJjfVE5d4y4NrkueE3VnzNQY5aJmHoA/W5eUvEQjj02fPObd2QrJ?=
 =?us-ascii?Q?GM2V7v3glgHhyFOaXsAzvDdz74+9SKBfiOUbbA2lCLemqkxw6F4rZt0N0r1K?=
 =?us-ascii?Q?mBT6a6W0Gn1NHWbGLqyfzfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220d7fe8-22ff-403f-6451-08d9f6969432
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 06:34:44.0243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWf4OTMhdep6LIYXwXTcVe2zl18GA7b1Y84Uv/NnWziT4B753hzKQkQd88nlnVgMlePlmEi6ygWUfxt4o/Dbkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3406
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
> Sent: 23 February 2022 00:12
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; linux-spi@vger.kernel.org; linux-
> tegra@vger.kernel.org; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>; robh+dt@kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> p.zabel@pengutronix.de
> Subject: Re: [PATCH v2 5/5] spi: tegra210-quad: combined sequence
> mode
>=20
> On Tue, Feb 22, 2022 at 11:26:11PM +0530, Krishna Yarlagadda wrote:
>=20
> > +	val =3D tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
> > +	val |=3D QSPI_CMB_SEQ_EN;
> > +	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
>=20
> I notice that nothing seems to clear QSPI_CMB_SEQ_EN - is that self
> clearing or something?
Need a change in non-combined sequence code to reset this.
Will add the change in v3
