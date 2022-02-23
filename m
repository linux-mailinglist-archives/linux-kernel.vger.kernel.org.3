Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858004C09D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiBWDC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiBWDC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:02:26 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B7C40A2B;
        Tue, 22 Feb 2022 19:01:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnoZwo63JSe637u3NV2OUtuI+Ahf0yIFbOmqcUxddI6gwONGAQGUg3HeR7nUi9SPSLRaahbdKWPY72jQQUfh9DvsPvVFRPorkD9PoQ4wdnM1OHhVl75pbxa68zDPffbogZnTEcmsd307ukADTJud6Wvc2eFDFGg987pNbK3L5aeGDZUMcDSLrg9J6iAr88RvPuOiqmSu2bIy0xNAwmCjcLvfUi0sgtBfXmrajE4/06r9OLaTx6Y/QAZcBMj8+NhHEILNHELUO48nLBqO5n44+aBbJgqdTEoxCQgxHzbDRkG8LaBER1ihfVGiN/7YPsd/pmpuyAxScJ7QwOO2+QVZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGROMFgY2/LtyNCc4I2UJr0p9UOCroE+iOx8LJU95LE=;
 b=AngqzC+1hA/4Yfc/C/Oi6pu79a8c/XOYquXArhu1Xi0dSXwkdyQ3wSfbY00r6WCxmyhrBnW9z6lACnBe//gsyLhT16CYeidr7MxzafUnK9tQ1N7RxhpPNzyrs/UA/w7ZUuly32jAQEx9a+zCDZ7NdUDzuuB52cCA5c3QxVZRtgzwnRqean0LD+wVEgmH7rjmWDmfPKBfEAuBJ0uz8D9wPy8CLR7BYkgdhBwbjDUVV/jcZqeo/I2FvRONTls9iK7XwETIYn4EIcCrxOrKQOW0B3yoAmGuDktHyeBbGyL+cWxCnv8GkipAjoyiqfTy4+D5n0iSPQAhwFsTlvvEPc8K0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGROMFgY2/LtyNCc4I2UJr0p9UOCroE+iOx8LJU95LE=;
 b=YkErW4wMvn6ARCdnLC2mxbVJLUJL/PVcLRhLEfQzhistODU+Ckq/28mPo6kKbxKwjyT3QT2U7sg5pCZC1rEbevVPbeqpQRpjvjY14SnuuS1g450RNFWti4aksIxIoRwMA/0/B4CaZzj5cM4DnwxQCmcNb4/p79q3jqxtSwqlvghzjOHSoNVu8ECcMEZJF+RG0FSTiFQMeQEDhbqHxmnLUS8OUvOIt2SpoHfkbNjvGGj/DRaKBwCPvq43vhbi39P+GwluoWpUFza6cd2ExzspaFTxS8ruxl/LKcDzqg2bNh8r9Cwsw/0tUztte6ljlGC/krl62oQvL/SY158WtybAuw==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 BL0PR12MB4738.namprd12.prod.outlook.com (2603:10b6:208:8e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Wed, 23 Feb 2022 03:01:52 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::d91c:c44d:f621:18b6]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::d91c:c44d:f621:18b6%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 03:01:52 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Subject: RE: [PATCH v2 2/5] dt-bindings: spi: Tegra234 QUAD SPI compatible
Thread-Topic: [PATCH v2 2/5] dt-bindings: spi: Tegra234 QUAD SPI compatible
Thread-Index: AQHYKBWYtWPHAOm4hUqZVqh+BMWsdqygBPuAgABtiCA=
Date:   Wed, 23 Feb 2022 03:01:52 +0000
Message-ID: <DM4PR12MB57695126D8BF37F74E98DB42C33C9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
 <20220222175611.58051-3-kyarlagadda@nvidia.com>
 <YhVHIVJlCwhbVAH7@robh.at.kernel.org>
In-Reply-To: <YhVHIVJlCwhbVAH7@robh.at.kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8a1dfe9-08b9-49fc-41ea-08d9f678d7d4
x-ms-traffictypediagnostic: BL0PR12MB4738:EE_
x-microsoft-antispam-prvs: <BL0PR12MB4738CEF605D207725B27BC34C33C9@BL0PR12MB4738.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XfzUieZQ5ZfSTpf8zB+puaMvFC0KryfR47VuP/NH0lLJd1JrmauVecwm+akjo+zTryv1TZYetnfXGZ6NqIaQSGX0pPA5hST4DWyMUgNT5CbnKsSqpCzwNFn5yvVzQm4H4IuiLMU6uhLjYBUqk8s7p508x042zj9tQxuiLIdHs6X4WlxCaVWGvrsJCziNUIvsXJ69DnY1btF956xAJkHW6D28G5hOIaeBuyBmlIbRGeh+ZAqn+AC9N4Big7sRb9PuYExgef6W8rKJMYxhk3ltW2FcbVj4UEhF+sVgUxQBSXIsMZ8obijKSzMBpFIGFCeo1ksJRT7iBRlq4ZUqsgbbeqdk8+a5hIfxMQV9dOyXZ58ix6K8iw5qVEIqSy2oP8k87hKKqF7Nn2fq7rEm5xutg9aACl/EIRLYlEb3YV1XXoTVRMI8CqplfGUD8+KDyB0YcG0skWNMfr4CqNt2Mn82JCO3JF8AYHju/WK9FWqQ5XVg/DkjKM+pVYrG5GA2RzjQHg55C2lKq1vjMEGRfMMl1gxbHS+3Kg82UwMRNVNdXSBLVqMoz7zgjaRKAGB8h/pPnKmaM/FFJh64C+AAEtm2lgH7E7Co8YEzT3Cwre+LY9RpJJNdIG6r4U8abn7ONVyIeL3KExSJ56a4A84/0GpMJVDNKUJ40raOyfmZH5q470lfPOR4U6RHFYZb+qd/xOTd7StD4TcLTwfiwJxK+PrrXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(122000001)(7696005)(316002)(6506007)(71200400001)(86362001)(33656002)(38100700002)(26005)(9686003)(83380400001)(53546011)(55236004)(54906003)(6916009)(186003)(66946007)(66476007)(55016003)(66446008)(76116006)(8936002)(5660300002)(64756008)(66556008)(8676002)(52536014)(4326008)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZNCWH3zohUY8pPZ3lkhU/OnFMRw53f5GkH8AplKoNj71yujqrESj2E5pHuc5?=
 =?us-ascii?Q?Glw2Fa3F9AaZoHcCYZxHVlR2m3NIlcw+EayzxX/G0yZhydRCTt8sNrIzohdU?=
 =?us-ascii?Q?eHlcJbNwtTaK3P/aGYJrTVrDC+A7mxHsaRCU3qo8r1qXc0+SJ848j4Ar/Juk?=
 =?us-ascii?Q?11z76SHJPe6plmAjKgp0ajggTpyH3gwKhXwYeI6vD1iq+uq+cUQJSkWDbAtP?=
 =?us-ascii?Q?JWBQJribbAWrw96jlZG5rC4jQ+v6bNZV+3uN6lVVqhr3caN1vcq4RTWcSrN9?=
 =?us-ascii?Q?oZnkYvKzQuocdafZin3aKZ494+hxIj0nfS/Z4bqEP9kBk9zLUx2v/RoR43l2?=
 =?us-ascii?Q?lp2p3fHmelmpQqBl6Z1tCYF2o2Unw/NwL20AVnNdt4v2DxanfbtMf+X/UQgO?=
 =?us-ascii?Q?VP3jXUTzVWXlhm7L+8bICSf1wJ6oF4i23IYnlu2Wfmti8EXjyJNpOvEQhTsb?=
 =?us-ascii?Q?E10tV88Bez55ciMiSZQpTit4f5htjh+v0PCOLe6m30/Wc6f2sJpGsHEXdifc?=
 =?us-ascii?Q?joeKfIMn4lZfzzuZ/pxyWpCOy2daQuKyxq4cdcLWea5vpIiQh9sHXM5LR9Qy?=
 =?us-ascii?Q?nNicgkifMo4iZS4/h83SXflFaUhGR7zKBcXBvkhD/gxcaJ5lh1sVyqtPw81q?=
 =?us-ascii?Q?oYsx+zyxnenql5hk2W1vUvgwSWhU2vxqnF9IbVCO+cA9HpUD9UpOUGaCe5Rp?=
 =?us-ascii?Q?oT0PkVb4cwFaV3+5VtnDnGXR/OhRX4AtzFuCnjnt6hWNnI0+mF798Q72mTvq?=
 =?us-ascii?Q?aZeTLGb46L5XDf/Ffa+Tk9qDbincDwu1C7ykbUVcN0M1pWRC2N3BLCx1rF90?=
 =?us-ascii?Q?/6Vyv2rQm3HUz785WfWrukXhANAaqb9MkAWsB9PblGykp65Z/EY9Mjel48Xz?=
 =?us-ascii?Q?edmjvgG1vr1QgjLLnQRg2wjVxrYLYHcq0H9v/Yss99JmVO2jKgHqpNP7GtSg?=
 =?us-ascii?Q?0xG/s/qFvZq/nKBloZ9jULaU3pLlQsYDkjls3/bti1dabc+40qa4Iou0yQL/?=
 =?us-ascii?Q?X+z1ee7UNBkefmEpbF2YIXVpDkrnSOBWkbi+tWZeNdIQqC/oobQ/WTORbkwN?=
 =?us-ascii?Q?k4EqIAw9sM3/e1fMLa6XieCTCfjjgPFRGb+rZ5bQJjGJ7yuCDiCj6yvkqc/l?=
 =?us-ascii?Q?6uSkyYYwKYZXfwk9e0vlhtyULBnhWo2chOHV/yawe6rwPZzD7YuBPV8wtxxW?=
 =?us-ascii?Q?9Z5VLkHLtNIeIDVBcd5HEhryKiAKFj3Jre3TIaY1/QgVBBTfuZHyv/b8tB0X?=
 =?us-ascii?Q?bt37oWZr6jNd3YcaqYDxLhsQz4OC7fZm8Myg1an5zBd0/wjY554WmZSYRWTg?=
 =?us-ascii?Q?0os6YZxAkOs5kpZLpaIAqRpK3jEKUWzb+80ikMINCbNa+2UZWstMxnNQQI/r?=
 =?us-ascii?Q?UQRZxL/XiLP8HSy56NiTvHSBdxCi60ZVs0dhmBQV/cqmjKbBikX0SyLExSrm?=
 =?us-ascii?Q?oR2SPpNe7oYhhy+OZ9VZiQyxGafHTBSyLF5QZn5OBWKu7Y0ODiu1HBHDmBta?=
 =?us-ascii?Q?kbR8TVkqZPBnsFe9X11lZMhFx2rrk93OyGy4SGATIJBaJ64HE+/XKyoAwzWx?=
 =?us-ascii?Q?BKA0/advoE1bQRI8hiLWHHQuZSgWDyzFpBgtG37I4LJWh4wOy1PBOBklpGWq?=
 =?us-ascii?Q?hy2wFcGSYgw6bEpBDeR4/k0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a1dfe9-08b9-49fc-41ea-08d9f678d7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 03:01:52.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFTMaknjrkGFUBKU1Rt5UBpDHTl2x6qqcUbQaivweQrLTph7rrDDiUke0sHE2WNsUDhO7jsJiG+eclqQuIhSjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4738
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Regards
KY

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 23 February 2022 01:57
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: broonie@kernel.org; thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; linux-spi@vger.kernel.org; linux-
> tegra@vger.kernel.org; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; p.zabel@pengutronix.de
> Subject: Re: [PATCH v2 2/5] dt-bindings: spi: Tegra234 QUAD SPI
> compatible
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Feb 22, 2022 at 11:26:08PM +0530, Krishna Yarlagadda wrote:
> > Add compatible string for Tegra234 for Tegra QUAD SPI
> >
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions.
Sure. Will do that next time.
> However, there's no need to repost patches *only* to add the tags.
> The upstream maintainer will do that for acks received on the version
> they apply.
>=20
I resent the patch as it was not clear to me if this patch can be applied.
I received warning and assumed this cannot be applied without resend.
-- This breaks an x86_64 allmodconfig build
> If a tag was not added on purpose, please state why and what
> changed.
