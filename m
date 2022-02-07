Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C464AC426
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385386AbiBGPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358773AbiBGPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:40:29 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A23CC0401C1;
        Mon,  7 Feb 2022 07:40:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDZsptayZFr7HalZXw7FOy1/Lq9maoNRvC9xxwKH1YQHuTHBxjxWZ1GbZqLyFaaGoFMDEKJzy8wze1CXYcf6I1o9aUBjbgWYnn3T+QKWE4yVGNO2DRcvuey/NCczyiSYsK4xMzFnOQmPW050sEUrT7YsDMA9qU8Jfu7NkUBJwg+gDczhIJYWE3teveR0JDH4ki/9BeFNTj7ky+SRtCOjuvsxr1YcXuOm6qnClR1/z4VBhqddV00ec85xep3reJBNEzLxvvBaO815Js3/AHnTKq6TQ3JhH6fFVb745gmtLpVojtRZ+oS4qUnC2VXqzP44KLkL8iiVAj9lJMWoaxA6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61R1Yh7jBfm8NzOMmfOKM2iGP5i6GL8J34GT6MouGXw=;
 b=Odru0+MTYJKHZ5uJJ1zv10D+Uz2v/A4a/IzTWdNJvjNXjMvq15HGZQ32OEYAm8MgplrXjEqRDenXkxzrIwXUUK2eAv0XWbAqlVXXVuDWzg2NIVTUDZMgkScH7MgrRHQgQu9zNbF4SK851mLtW0TBSKFw/zuoELKsEXFTV6sWPB2LnNWt2RErw/gKdQQCAx/z5M/6Eu/Szr3NhiqaDvvPsSOUxEPERFkiLH8BwBeoZxyYIxtIZhCM5tB6Y9TlJZAM15KwGbE4hhcUlWnSSKtO+li2JosI0KZUsvCruTLa3Bf5UqIUmJ7sIXpJglihzkoskRLdjcYxnPFv4rwLX4+uiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61R1Yh7jBfm8NzOMmfOKM2iGP5i6GL8J34GT6MouGXw=;
 b=mUxHsTaK00nOwjnaDtrot0L4Z5mWJyzA45w7aooc28tc4ssjsHjT8fq3jyYVCSzgMaqZQi9NFHt3rzQUKU9GlgjDZO3g5AE+rA8yPCXlEbapqirEpidY/r2uU+fv2CHWn6j7KDcGnt6WYrbQk4ldz+A05ScyGeaxyYp2yUjwjefx/Vq8NHV6e7xIOUJZHTmYRl6yINEF9IL2sU8pdTf2J3rw7yx/PLaG08RnQH2uctAlTyIFyFzLhLrxi04bCzQ17KRkjpi2OH33DzSF42BoYIxWArolJL6HiHoGiBK7JBuUdMEMrF/XrKcBMe6JYpadKrJ9v8H1hvCL7KcKMQC4VA==
Received: from DM6PR12MB3563.namprd12.prod.outlook.com (2603:10b6:5:11a::19)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 15:40:27 +0000
Received: from DM6PR12MB3563.namprd12.prod.outlook.com
 ([fe80::5125:d2ad:cbef:fcd4]) by DM6PR12MB3563.namprd12.prod.outlook.com
 ([fe80::5125:d2ad:cbef:fcd4%7]) with mapi id 15.20.4909.019; Mon, 7 Feb 2022
 15:40:27 +0000
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
Subject: RE: [PATCH 6/6] spi: tegra210-quad: combined sequence mode
Thread-Topic: [PATCH 6/6] spi: tegra210-quad: combined sequence mode
Thread-Index: AQHYGbI5hON+MFM3SE2C51fYICcN6ayDbjeAgATDdiCAAAM7AIAACcCg
Date:   Mon, 7 Feb 2022 15:40:26 +0000
Message-ID: <DM6PR12MB35630E186CE9507BFF620840C32C9@DM6PR12MB3563.namprd12.prod.outlook.com>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
 <1643970576-31503-7-git-send-email-kyarlagadda@nvidia.com>
 <Yf0zkdS2nqHOZjMG@sirena.org.uk>
 <DM6PR12MB35630A9020EC4B309D877086C32C9@DM6PR12MB3563.namprd12.prod.outlook.com>
 <YgE1PD2irQeinD9N@sirena.org.uk>
In-Reply-To: <YgE1PD2irQeinD9N@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1214dc77-1e1e-429e-81e0-08d9ea5029e1
x-ms-traffictypediagnostic: BY5PR12MB4178:EE_
x-microsoft-antispam-prvs: <BY5PR12MB417899410DA164ACA0E8E785C32C9@BY5PR12MB4178.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGKKVEguNFsIxoj5BUy9A//tnlNZLGu6lNr3PXvBl0zVv8qADo5d3ehMM2VYLN676NPXTkNjumbufGWn8UMEy9n9w4LtNe/5Wr/lyHZI2iGcLepV42ebiInLn7PEqt2WNYw/yHnVPWGEcJ53uYhkvgdeWzSGt4faZO/4E+nuWYwmbu+wyUpNWCdhQdH8GBRMQsryPjjuVo/NI0wKY1hKYf36u/yaz6XWcHy1YxWlQyeV3NAcHq6WF65+kC/+QXI8oyXsTHR6fJ8gfBl1Lhcbi+C4TrnufMyq7+s8XiDAgzv9dG72xx2LkAAbpZuLMgUmEhPt8gjF5xHOMMGk3bFldIUsPYTBPcUwK70qQhRTJwsjkjzzvZgxpaWVhV4MQrpt4ZbAmXhnJCSTbYUH9S79m2QU27a2oRrei389dR1r3Bk45luXjbG5kaVUyCaICJoO466nZ8OoILha0yR64zuwSQaxle9e0jYmd2jk2pXL+4RxLu8L+fIIvfuTir1atnJMP/lBzDjumaI4BjU6loVj3VnHP03NsRKU4LTwOmBsWcwuofDUf1pF8i1MGeo7e/WA9r5w2JTf5OfC6AX2YF1X54wxpZgFfjY3z3Zytam399sgSb2dIpEy96DDmp7A/mZbuKp+5TPuyVY5MzaGEN8Q6YhtEJ2/eEBTrZ6O7qQGI6bwUBVxv3nlGGBaSy7vNUMs4+NMYw8LElZKKA9pgqYeOTv7OPHfFv241eQbsuW3YgnAwNen8ogK2DHunH8tUlee
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3563.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(38100700002)(2906002)(53546011)(7696005)(55236004)(8936002)(8676002)(9686003)(76116006)(66946007)(66476007)(64756008)(66556008)(66446008)(6916009)(316002)(54906003)(122000001)(52536014)(508600001)(26005)(38070700005)(5660300002)(55016003)(4326008)(186003)(83380400001)(71200400001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wsrw8mgx3xat5PADQRgFkUzGctpejNeDAuW00pDWav0kZAObOKbzqojDgUhY?=
 =?us-ascii?Q?fr9EnwDI9A5bTMphMVSjUbUj5TsOPuw1tPfjeQaG2vbWyLoRCACweAv9zn8R?=
 =?us-ascii?Q?94OKKLcjgI+3LjcQkIovihtv0aRmMBM1a0VOzOKtdpnLK7Ivk+T4YyCAAUBa?=
 =?us-ascii?Q?vdKi3QUd/CJbZ0ZViCOvaZ/j5q/NPjeyB7KajhC6RgWw9bL6xtfdsUzJGxUh?=
 =?us-ascii?Q?eNSke0MeL30GpAprNbFGAxiCuNZf0/uMDzYlNsGWFwBNdUiBPEWOlKcwbvZF?=
 =?us-ascii?Q?hsKRakPionDFl9S0pWR451Bcep0CXbvlbKBOaucMb9NiWchG6ZCyh+R3S0fG?=
 =?us-ascii?Q?1Du5VM3aGpeSgfULazZI8Cfc2ig2CzB/UD5XYPuJ9pqCvsJDBLf+YeTWjOuo?=
 =?us-ascii?Q?RiSNEILxHlTcq2arJaKBKTRp7eZzV7vfKP6ddpdK2AClIv3b9Z45nN9aoHKS?=
 =?us-ascii?Q?o7NZAmB2qKRFOcx9E/XbIgCFYE1lfnkstXJ92NYR2VmzQf/OPca/AKzdPfak?=
 =?us-ascii?Q?2AEgaLDIXkWj6/Gbn7BRMJUhDprGdzi7VeJ3ZSlT6nJoM/XlkyICkK/QRg6G?=
 =?us-ascii?Q?sbTZvVIvS7eqbZ0+3pjwWDsLqmQyXUHi7/mVtUr6F5TUS0/ROBwnTa+QA0WG?=
 =?us-ascii?Q?y9E0d5a+TzyHvMwniyJVvpTQB49n5/F2GtTlc6fvQccK0Qpl+wPbQAhq9L0K?=
 =?us-ascii?Q?DDJUgXAJOgf705mR+rTdh7jJISFzU4v1D+OTRfF9vwCA+GKX3ehF5XP1RIKl?=
 =?us-ascii?Q?x9QS2CppwMv6AA7lE7EJK68+3yAbmhSS7C6A4izfUjoY7E62DkaR9y3XApnc?=
 =?us-ascii?Q?IKrhIIUnhIkW+hYr74ApAWzHnqfA5paC/bNsEHIZY7bBSwxIyHsZkGwNlHRs?=
 =?us-ascii?Q?8WNySDHSGqBimtF/ApprmndK0BwISc0SYO4K8jvUI6IPod1GU2NH4FtT/Tlw?=
 =?us-ascii?Q?SANKpbXaXMoq02LITQ0gHqDdCVa/CMG5alvDbQbVYVn+SWq4++DhNlBjkH3l?=
 =?us-ascii?Q?EQWNVQSF9tToJ3wCjn4/x3Y4yowoV93EeqoXqfpUYK5VOtx8eLJzQb+eCvVq?=
 =?us-ascii?Q?QqQJivFo7bfsgBwLvoiJJSRW80zFDKaBnnejPvdLp/FUqjln3dEWqlLLSqhI?=
 =?us-ascii?Q?v2lgadlUHQ6jKZ+JNIAyoqjMAm6PTC4iQ3N9W8LMCdN8rkmrCcy63Lo0dY+t?=
 =?us-ascii?Q?2BkZ6vGkh9sPyFJq3+lrzTnpErgF9TN6De3fl5S4VyZ7TSwjhsEKO+zM64IF?=
 =?us-ascii?Q?xqOhcrQhcKmKk6Nhg2ZSczi7qjIl0HHoV47R78DBZqKeVYVB31rWvOTN66Rq?=
 =?us-ascii?Q?g/9e33kH8JFXHMJp0/e/xEwJhIZHDXmrN38J5esM8+YgagyQKWiBVUsjiYBw?=
 =?us-ascii?Q?C+wEcs4zIlbiQyzWYOiR7tJ6SOdv8JNdxteJ9Rf9gRd6iduHLHlsHa1Z7Ow6?=
 =?us-ascii?Q?hrZCVDjJJJd1mW57a+qD+YMX1xkGnbYGvwjxxWbdDlw/pXAgMhDXKdQpZ3cl?=
 =?us-ascii?Q?PiTnkMD6xGMQ9QWeht4pCk70SPFpaAM0W1UKNKy0Iy+OrV8wBme9wtzLhpES?=
 =?us-ascii?Q?DpECyvNckcEsbJBrSylFh8E/2A0+Rd/ilXmn2VYyza2Fl67oskEmeM9Z4b5U?=
 =?us-ascii?Q?+fgQFtvQLZXoS0b2X5bxOa4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3563.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1214dc77-1e1e-429e-81e0-08d9ea5029e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 15:40:26.9782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUQsH+bfKGmW8iB84ULbJnXF0ibfZXBttwsojf20DpEGx+xP8off/t/fWrODJBldVaeXaWbnqWrLX7SXbODYLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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
> Sent: 07 February 2022 20:36
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> linux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; Sowjanya
> Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>; robh+dt@kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> p.zabel@pengutronix.de
> Subject: Re: [PATCH 6/6] spi: tegra210-quad: combined sequence mode
>=20
> On Mon, Feb 07, 2022 at 02:54:00PM +0000, Krishna Yarlagadda wrote:
>=20
> > > > +	if (cdata->is_cmb_xfer && transfer_count =3D=3D 3)
> > > > +		ret =3D tegra_qspi_combined_seq_xfer(tqspi, msg);
> > > > +	else
> > > > +		ret =3D tegra_qspi_non_combined_seq_xfer(tqspi, msg);
>=20
> > > This check needs to be more specific.  But like I said in reply to
> > > the binding patch I don't see why we can't just pattern match on the
> > > data without requiring a property here, we'd need to check that the
> > > message is suitable no matter what.
>=20
> > There is no real-world use case we encountered so far preventing us sti=
ck
> to pattern.
> > But this was to avoid any corner case where there could be 3 different
> transfers sent in single msg.
>=20
> So you'll remove the property and just pattern match on the message?
Yes. I will send out V2 without property.
>=20
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
Sorry. Fixed mail client now.
