Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96484EF3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349508AbiDAO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347609AbiDAOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:35:34 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC31EFE0D;
        Fri,  1 Apr 2022 07:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd3BS7O5E7fyz09PUeYana02T6SPHg8mcJRLgoY/wNceEUCO6b2jpAoRDnJE2VtBkham6QzlHzTgIuUi0Ppc9Z3u1fBP6lngyU1+UWBLumXduFPJ7QHUZ0jU+KC9BMoEfIdkrHILBjFiNYAs+pyQIkuaiOqclZXyQhjSjKOedNsuw1zTAUUza6L4KFBM4G8w8NthduC7IlDWYxnyI/p3n0JalpR9hoLey0A1zbijyqINgWASwH1C4D7gYYpsioFxFFhIUp7VmM0BtQeO/vytESw8VwUqZYEaY1QgsW6U7hLyK1w8Ut6ZHgPUyTgW+L2KJFi6TQ5ViM5JqtlRDT/K8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR+BjUeRSBY2Ko5gWrIPvku5NqQ0NXDrCICQNuLRoQw=;
 b=gfv9QNCZOay10tMz71oREw8b0y5XQOSZxuyQ/XUy+QL/tvkgScgzVp6q13eFyvZZxDRZqK6QyW9w8lEpuzQVjBk4EaQzpvr5W0HdxIqbhNgI8uilwzgw8xXHvoH3R3Fh4ov40vcqmj0qEem6n8t3/v2MDjmnwfjmCX+em5yIc0QH3h0RZJ+dlkC0I1wSXxVVtpIM96Qey9eKx2o61i4LkOhb0Uz43M6+6XhU5BYSUlNOEtQ2EOYPR8p8AVo3Yol6/6TQ/2AUYfLBWJTp2lOpOELHD3cSrs3p+h/fHCYT6G7/M7AaTZzj0w+wiomCzF655OjBLePb2HMTozMVaDcOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR+BjUeRSBY2Ko5gWrIPvku5NqQ0NXDrCICQNuLRoQw=;
 b=mvTSfCbwyhKlh80ixqvxpAJt63nMGAHrxZxc+Nt9fsbjKd7OkjauWxy4+ujdlfcKo2S5Vfbbu3tJWfWYx92CBKN7XD5n+ZB+hOXu0Gh/8vfJOhssE8iInWBTS2jQFrcpJTrOjKwr8kHGCeOfD4EgFG6Jm/QzwS2aCeG4+LSu10uBpdrL3FcaIlvl2nG8G4dwQs1xT4sCnXHuuwOUkGemfmt9KP2+vLmVd5gEwIcy3HoGBPhJ8Zh+FrGGY1wt5pmL5Xsn9VBL38IwMSOyKhqD6bge2x4FTwliQf+7QS+uuQ7XZ/AesVagWAftXs4lm+s+5MJ4lrpRgDAkSyMHHf7XNw==
Received: from DM5PR12MB1628.namprd12.prod.outlook.com (2603:10b6:4:7::13) by
 BN8PR12MB2947.namprd12.prod.outlook.com (2603:10b6:408:6c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.23; Fri, 1 Apr 2022 14:33:12 +0000
Received: from DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::144a:7c01:7727:1846]) by DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::144a:7c01:7727:1846%9]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 14:33:12 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        Bibek Basu <bbasu@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch V2] soc/tegra: pmc: update Tegra234 reset sources
Thread-Topic: [Patch V2] soc/tegra: pmc: update Tegra234 reset sources
Thread-Index: AQHYRbY4CHAhw9BDf0Sqw3zUKbkBBqzbEcSAgAAMX6A=
Date:   Fri, 1 Apr 2022 14:33:12 +0000
Message-ID: <DM5PR12MB16289B09CD1A9CF4E9FAF098ADE09@DM5PR12MB1628.namprd12.prod.outlook.com>
References: <20220401104935.9149-1-spatra@nvidia.com>
 <YkcBt74odxdoBlQ3@smile.fi.intel.com>
In-Reply-To: <YkcBt74odxdoBlQ3@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5523f3a2-8db7-4270-e95b-08da13ec8cf1
x-ms-traffictypediagnostic: BN8PR12MB2947:EE_
x-microsoft-antispam-prvs: <BN8PR12MB2947BF3D0B7889D5CAC1921FADE09@BN8PR12MB2947.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IgdL+XYmzHNlE0sIACbYqBvyZTQ3EwfPNcx3iS5kueaQEZB3eJOrIoNBfrvANKFMWZAoanTxk5s7QHIQ54OE/r8GqI/fW/Se9DeM062fp678uu/sFIv36DGvdXgpSw65ti1YTlLwOPXIs45+qVyKfM+fJYrlbcF3CZ6Q60qSjrQH7I40RHIEC2jkn6ZM5PvdRFUXxCMlb2sW8a4Asa4c+8q7yDbj/6PLdd/4TqJglqWYPAkEZ/5d5frc16Ryc4AMk7yoDYOblKcLNaB0qgr8OGW9z4wUVy6TbR1FhP+BDsOuyM3rncvH5nOfI6UVByZuVjcf4pRmPJNPfcwgzMKe/synZhzB494du1Q4RjPVqtT2jTIwBFSKHHMtlQv1z+LzDtcAfq8fWekxshiWqCcDb3txCEA6rg4P24md86M+24yvCpSWosKIsfhDmvzFqRHgPJwDR1CEgHIdYrN+LKwTjyebtNjRhwxeOrvqCpqhV/oCqcna1GBKxmH+uh8FYV6OQI4+5pVHMW0vPiTdEozjpmy/Ql+e53kLGQ7HZqQwQKJ9Rns1pzYmlLAzyMzwVdzDbwWhztqqGn9AZW/7RXd+9o6ATveIVpXw86s9FQsocOBObL2WBucrRxdmGhRW/HZcSesRySYUggC4YdCP7l9B0Dv++27eb2mlq31fMTfLy6iluXfy1CwIqEvzJJ2YpzBW6U5PXlTR+ZFUaHVyovxjtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1628.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(15650500001)(54906003)(2906002)(38070700005)(316002)(71200400001)(6916009)(83380400001)(55016003)(26005)(52536014)(86362001)(38100700002)(5660300002)(508600001)(33656002)(64756008)(122000001)(8936002)(76116006)(6506007)(7696005)(66476007)(66556008)(66946007)(8676002)(4326008)(9686003)(66446008)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mHFe2/00Of9YT0Zq7CB0xreEUceIIhgoE9luAX+DuL/QHA9HW+FpPpTU13M1?=
 =?us-ascii?Q?HC4eTAwWwu30FbcCPvan0jmwPFc0xxSEZRMXLZFtGtiklLnIiPOznSZGDeV8?=
 =?us-ascii?Q?DXf3vxgN2i/tK7Xs8imIsUUH4dNWptQKO+wXwvvfdHgzGmg58rPoQksY38ng?=
 =?us-ascii?Q?d+hff/mrKEnvnB8QxYTwm/u1TtmetvShpCv8yrWaUrTL9Dd+PuDkNtgaPl84?=
 =?us-ascii?Q?jVKuDlQqV7xbjsL+VZgzTCOUcuGXdnqIu0cBqowt/zyOA9dMn2PSbt7zWrMT?=
 =?us-ascii?Q?CWohmJqL87/+WNehK93zL6Efuss+HXp6trXq71D/Euo49VsAbjgW8GvCpZEO?=
 =?us-ascii?Q?LaibcTiVo6iZjXy9J2w5dYobLhsQ0vxqgr+K8o9SN9vYQLIcKjObcaqKz+re?=
 =?us-ascii?Q?tScD4Aj64W4f23CFbgGbOhcMPdpIcMSGDoBQPPIVEpL2WAyUGAEcoOfU9Ggl?=
 =?us-ascii?Q?ICWdatbRzc0u+rfDIoM3x6tl8A5YVad9NG5V42LhNXv8vl1aC8rr3B6J1Ufo?=
 =?us-ascii?Q?xVdaSLlEfeTrTq7BywpXGQC1+9ujEH0eYrGV0e3VPRyxPRm62o/kdHf/40Rg?=
 =?us-ascii?Q?1cxAfMag0BFUrei9fEmyI1mT/EhJ6S6du1gvbdNz0G6xIUGCkvd2LBASH26b?=
 =?us-ascii?Q?vx53vr6w/kCjujtbCzL5byp4tgE4eDm7lDkBbiw9jagwlDr3H9+UGEoycrcE?=
 =?us-ascii?Q?DdtqhGwc6hjb+Oi+OT18s0Y6evspWrYuSkF4yQLrLIoVhqg7laa0/iaPGITR?=
 =?us-ascii?Q?npi0yS7ZouDsFuQZQ3NscdFQfPgguZEE93JXuJNQxUGxYNC2W8UQhTxp0oPl?=
 =?us-ascii?Q?jgVKnFbTPR3TjLvUrL5j89pcHoXlbWu35+D6hepwbCmnYTIN2rSwDlauj0jI?=
 =?us-ascii?Q?3HnRDc/jhwH+asVTJM7++GmWfwAHR+1bfGorr7EuUKVcmBkZO8RxP1IuDhkY?=
 =?us-ascii?Q?zntfEenVhI2iaqHR6rjDJ9Q4kMpSgvos3V5DQMXZ0Ss3hA9L6wXAyXOHfQ3T?=
 =?us-ascii?Q?s5KLu+/p4mDLADKQHGYrEsZ899FHydE/Sz3LAbwk6ZYa7XkFNZxNoXdjfdRd?=
 =?us-ascii?Q?WrcrA9eRWQqzWmTknZ0oW5OrO+UxIS8wXiOAUMIQimhqcV++A4c9+uNLOiUC?=
 =?us-ascii?Q?vrcsN9AkhtgnPAAPn8H77ExWCTrTOBD+XSR6BOTUXq06NNnrV3+s5DBFR3h2?=
 =?us-ascii?Q?FbPRlH933EgUGOzZYMjQKlNzdAEDR/q5Oyq1jOc2nTYPxAcnT3507FRYJMuw?=
 =?us-ascii?Q?fQ3JNPealKHcim2+JrOkB0WvOzTvgGmeTagOAgJh5wXuJ8i2z+JWCEhO6xxW?=
 =?us-ascii?Q?0B+UxShQGqCnIu/FrT3OX4sfwbRaRwbzui1UhT5AcaIQEgHpU5c0cCZZghow?=
 =?us-ascii?Q?K8Fg7hM16cJsdwKlyoVGA7S2jXM0TzeKXqpGMcoUG0m7G+ffkmrONgSDUxDu?=
 =?us-ascii?Q?HWPCFa0LhgkoBcnC3SULjl8ufkkMDIBtOKR1mZzpLBspYUh3c9uYpY0WUtqf?=
 =?us-ascii?Q?snp1Z3ARjiqj/xgLWxp1IUg2c2PJH2YLkYm4EKzXfytlItEyQwgAO/mlsLKo?=
 =?us-ascii?Q?IEZ4OxwQI19UXVT4BCNSixc4639z7juz0TdmB/zNsZAupOfgzuNho7kfA3lU?=
 =?us-ascii?Q?XidifSsSnLGk/GeYcEte9vWdroTaPRXLq7r9Ed6QVxjB/64T4uaxvTvKacpA?=
 =?us-ascii?Q?pRwPKar4XngzRFUcaY6bTcPYDR4YHsgS+I8IgyDuXK+IU4+3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1628.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5523f3a2-8db7-4270-e95b-08da13ec8cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 14:33:12.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZemVha34S/7UcyZa8teevOwcZJMrgkjP5AdNc2rREVfWK+uXGXhPjbUUOqKMn1nWsEsQM7I1RDbiHbKJI3zyGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2947
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Andy.
Pushed V3 patch addressing recent comments.
Please help to review.


Thanks & Regards,
Sandipan

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, April 1, 2022 7:14 PM
> To: Sandipan Patra <spatra@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>; Jonathan Hunter
> <jonathanh@nvidia.com>; digetx@gmail.com; ulf.hansson@linaro.org;
> cai.huoqing@linux.dev; Bibek Basu <bbasu@nvidia.com>; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [Patch V2] soc/tegra: pmc: update Tegra234 reset sources
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, Apr 01, 2022 at 04:19:35PM +0530, Sandipan Patra wrote:
> > Reset_sources list is updated to add all reset sources and removing
> > ones that do not actually exist.
>=20
> ...
>=20
> > +     NULL,           /* 0x10 */
>=20
> I would suggest to add the comments more often, like every 8 entries.
>=20
> ...
>=20
> > +     "FSI_VMON"      /* 0x25 */
>=20
> It would be good to have comma here as if this ever getting expanded the
> additional churn may be avoided.
>=20
> >  };
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

