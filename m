Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE14850C004
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiDVTAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiDVS7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:59:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989D020D634
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndPu5zBvla/iKb1S4gOSMWTxJRl3psCTcfqOvPIAw2QCEwxDq1tK7d5Beobsd7gSESlGsod6+jUIam+DDk4JdQPWP8t55qN3+cH6A7263+Q/PhJfag4qQKiDsXzSzzzumd58lF+WPeER2N80Jr3XFufTn/u0PdkPRiYJKYIC2GGMFcq1q+gDAIacru2MkiY/ezH/RqoqcYs9ulOksvV+zQcpiCzSdeOqyf2sYUExMu9YSBL3EqWntjGMZJPRjz0NyfhUH5M4DUvlR42wgRdWgMchn7/6EYBPA5WHji4I1HJeeuXNDOoKY0gd7YhYtzyNZlB8YkK9uPiH75Wc/+YJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7iUKiYSSocyDQG6RQ8Xt0P3DLrTr8+W1szEZ7X4v8E=;
 b=ev3ekHETRb7i4FIm6ZIUjh6fJNw+fNzRnfZHvXOu69i4AJqMrjscv1KIcm8JUFdHnoeKofeI7lm6i3Rp92A7sbYZ3rct73boC387k1N1VV0dZk5S1H2xBASJWFl3AEvE35gMrNRlJ25mrDDlvklJSREhlPXiYBlBmY4QxDY3W0yqIZuPXh8tbNogF7+vRBunO9D6e4WJ7wbEGysiT3wnYIgt9q/dvynNNLeQIzR8vhv7dlbMNGOxhgtgyr99gw4zyAMGbCzeoRQpH+nxjh4ALWty36DT7eTAajb8es8Kdi/QJSmE+LuQErIXZAqxWQcEZuETxEQwOoAQmxKp0fkG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7iUKiYSSocyDQG6RQ8Xt0P3DLrTr8+W1szEZ7X4v8E=;
 b=COohQnwsaAXvdiD8o1mkJ/NQ0uDII0CTPGISfpUl2k43DsQkUmz20kTDnUm3X8/M5teLiNTS8JCKKubFJrbNraifDM3Ao+pQGexvgnNskPvmlUZF4l+ILRksBqcw8rfKc1ttwNxZuaaghfU5c3yWULktI8jFGT1uKwWoWUjSNBTjpvPaa75sFAAAL0VWz7PDQwlEZ5sijaT4N6/WSVsVdGDCLyaro0Ki0WyNwYYftqcEk2+Kf1txQIPCeKZPzlMPzwlJB07+xf5aBHpXuoNlIN61LoJzRuD3tNoV7KAWE1lU1i/EApwJz6sE8zai/nu4t9SeqoFweKcWHFTXYLfZjw==
Received: from PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5)
 by BN6PR12MB1731.namprd12.prod.outlook.com (2603:10b6:404:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 18:37:09 +0000
Received: from PH0PR12MB5647.namprd12.prod.outlook.com
 ([fe80::5820:b6ff:15c:2acc]) by PH0PR12MB5647.namprd12.prod.outlook.com
 ([fe80::5820:b6ff:15c:2acc%9]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 18:37:09 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Thread-Topic: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Thread-Index: AQHYT/0ok9lNELUg+Eml6ifIWi+wbqz8Rbag
Date:   Fri, 22 Apr 2022 18:37:08 +0000
Message-ID: <PH0PR12MB56475FAF4A2E7DB0AE1C1217B3F79@PH0PR12MB5647.namprd12.prod.outlook.com>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
In-Reply-To: <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1903079-3bae-4b41-3d25-08da248f1bb5
x-ms-traffictypediagnostic: BN6PR12MB1731:EE_
x-microsoft-antispam-prvs: <BN6PR12MB173190FEEBC2F4AAEF586059B3F79@BN6PR12MB1731.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFkF/hScrKN6Hb4y42smHJoYs7zrO30HEQW3QMEfCOx977zmrukaytO+L88DXUSvGL6s/f3OGq50cOTKlsqyOWRkLUko2AHABc28zMKq3WMvteu+9Qtf+o9cidbjiARZXnOduxjU/FCC0lrGS0daeP7Mibq390H6qiLThQadBuuWznaHnAacY3MfsAonI1ZQOZSoyvh8kjmoOe15g5CfL940ljzxuzAYl8cWbYdNRfjfqPsg3+jBXIgPGpd91HL+KarbeOzw5ZtiYV6cwfNBn62u6Jj35bIRG8VXfl87D+KvdtDCX+yEdOrz7TWXkuDsNbGkF0L5RcH30mq8C5pnMhRPx5EWj3T1gAzPblyKycAsQNBodZoxmjgwLrQGKlWs9XzSxxcasaguW4NNRewCV5wzeakiufjkHgYZ0x5xrC9UsGb9BmEqcJNyPRa+C4qm+YBkJ8TbZyk+FnKmFx45i2GfeP7SbxYewQKvuZqyA8GwjJdFU+/WhWGpApOyosaHJY+JAXfKt//aA20VDrl2csm3uLPmb4Z3VosxUi56qUqP5/bB0xy6IEF/xONljJ74Qw55oe5TioSLWvyqGTt32VuF+884tEOo9PRF68Jhe0BJchdR7GVciwXBxe3zCHuhH/sEfELFHCC62M/MOQ4LJFawg4ct7tQ2r32IhIdgsZ+VrHg7sEwGQ7Jx8HOlAaJ8YkCiKinJWfUXrXqjottF6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5647.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(7696005)(7416002)(110136005)(122000001)(38100700002)(52536014)(8936002)(5660300002)(38070700005)(33656002)(6506007)(54906003)(55016003)(26005)(71200400001)(186003)(9686003)(4326008)(8676002)(66476007)(66556008)(4744005)(2906002)(66946007)(76116006)(508600001)(86362001)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PV8OFeTxiWpBKk9mg1al581uRc7DdrwdZDloCIM8OTNYrPbfynXsWOHVEv6O?=
 =?us-ascii?Q?wyb6n1rFEX2cpYSOj/Xrm/KGmv15CUd4qptPSdkktYM8jKB527/OQCzpG/iV?=
 =?us-ascii?Q?kxatzIId2ha2mlHiBLGYP09E4hY8sPY9bB0RDt7fdYlZZ0Gw7d5MSRX8PFkQ?=
 =?us-ascii?Q?BLuQ3YhWYkRcmuosvZfwtaDNsGj0a+5CBIw4ZLXoI1wvBEcAFm2UwK5PMy0R?=
 =?us-ascii?Q?r2QF2r2glLZvw/1/vax02HDnlFihMiCJNu8JGjRVrYZzVMIOCFGJRc5KNkM+?=
 =?us-ascii?Q?5CQAb3+dZDThNtj6ypi/zlTRl1JCY3TOb+9oNurGdfX7DNqr7AgfjzMANmL1?=
 =?us-ascii?Q?rQ/lkC42I6nEOI6dsOe+PweOolaUunAzOo8vkN+zWSPP2iwYhgFGqEybIZ+y?=
 =?us-ascii?Q?W7XSXM2rUtCkX/+/nfIwrSXwFwmpJhVB4hkajbb9SILIjdDsKKwbMToPOH52?=
 =?us-ascii?Q?J/LK9BCKTdsp+6zG2zDHqvNy5bYXUyMgEPRuxU8jVzGCFN7ZUTSYO6UQdQCf?=
 =?us-ascii?Q?1Gca8r7m7619sBlyf3mxhiE3VOHQuTPy5wMCzhcMTYzR77hK9iUuq6+1wq1n?=
 =?us-ascii?Q?nIELVW+8km3S6/6SfLgQ0NC8A6VeG6MMA2aQ6n0p+22pRGuplr9hglmUOfcM?=
 =?us-ascii?Q?NvraGdxxA0TsyuNTiJGRI3W3C2p9qOruF9lQeiS6Jc6xgO1zcZkn3v3lw+iL?=
 =?us-ascii?Q?SeuPeALXmGle4y7Tj48AfxxBHFPbTLgu6jgGvBpLKd3sEecvpgynyKjdOo3l?=
 =?us-ascii?Q?EVdo6xhAEHZ53AunH8AFIVivbc7XWyE7BzN9tA6tet+sYp/zA7dMZFR3Ku9B?=
 =?us-ascii?Q?qIXsyjXn2vQeuFp8+jPYq1LjZBuso4bcX3wUlWTmiFARqplDEFG4znsCzl2H?=
 =?us-ascii?Q?PFFAY7cxamad9mWPLkCj4WYgwt4WYL8A+qAm/msAVIyKzqurBaaf8z3dtG31?=
 =?us-ascii?Q?bl6c198tKW0j/rTWtvzngsvw3lSRSz66dMUEeC5ExgZcPd2UpS8Qce2HXqg4?=
 =?us-ascii?Q?jxBz4yV2FZFArm99sSA1vSV+ItbrZKfuwDucOBYVDRk0xAcqHz+BFnmFU8qT?=
 =?us-ascii?Q?g8yj5Xb0C3BYAFI3lmcn/Cpq6M1kwoCyGn3veI/SL8+5WYqWrx0LolLRiUcn?=
 =?us-ascii?Q?fyvtsIsfxd4ZwusZXONRmb0kiKY425kk+9W143KR+hWo2CpPH+EhrzDOxFMt?=
 =?us-ascii?Q?ejE9MzsNIo5sPjp9kGa7cbinZPKaK9VfhqftPHhAm+wrw4LNV5u3lXvhigaw?=
 =?us-ascii?Q?uVeOqxCZw8ukicEP82CfjcWzA5otMVIQbLOHEOZFIAh1KnCkcj5AFpHsSxog?=
 =?us-ascii?Q?8FbE0di4awdFnDc9tnqcrBYxos8kwMpfPbJGwYM5Gb5rIqWBxbVLzXqFpjgz?=
 =?us-ascii?Q?AvuHz/ZgbktdBo1Bu5CfK6w+Wbl7uxFguvBmoigy3BPggvA9Mvjz7DpN+sIO?=
 =?us-ascii?Q?x04BbTXymhK9esbA9ejwe9J0KL8WW8371u/mokpgPQ4V1G1/dYZwraUbHXLF?=
 =?us-ascii?Q?go5WIbFlKwfcgmXugaY8S0iGH2IxYWakxTniNh06SJr+Bp/C6SvOLwlFRJyv?=
 =?us-ascii?Q?P5lSsjXO2WYDlNOvtbH/Vc+OXZXpf66e1H3ffuLP0LWA+ZD1AxzKltifuC/h?=
 =?us-ascii?Q?FFueZ56DwswQSWPQa9yP/eVpERYBb9A+TMN7i4QYyYalAov0awfJtuzAntXF?=
 =?us-ascii?Q?Ic6dpqs1InB3NrWP8OD7PFDqwVX2ByVuVgKqDdGhPtLEYGhfXBUqRCIl/cej?=
 =?us-ascii?Q?vqu8eJYqdA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1903079-3bae-4b41-3d25-08da248f1bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 18:37:08.9507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DH3mxVTDq4FeiLbsE/2eb+FJM/Wl/UtcNg0YaZZzkEB/ev7GXwxTJLVwFwbGGMVowQUfwVYWZdHLL9ryF2jOvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1731
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good effort to isolate bus config from smmu drivers.
Reviewed-By: Krishna Reddy <vdumpa@nvidia.com>

I have an orthogonal question here.
Can the following code handle the case, where different buses have differen=
t type of SMMU instances(like one bus has SMMUv2 and another bus has SMMUv3=
)?
If it need to handle the above case, can the smmu device bus be matched wit=
h specific bus here and ops set only for that bus?=20


> +       for (int i =3D 0; i < ARRAY_SIZE(iommu_buses); i++) {
> +               struct bus_type *bus =3D iommu_buses[i];
> +               const struct iommu_ops *bus_ops =3D bus->iommu_ops;
> +               int err;
> +
> +               WARN_ON(bus_ops && bus_ops !=3D ops);
> +               bus->iommu_ops =3D ops;
> +               err =3D bus_iommu_probe(bus);
> +               if (err) {
> +                       bus_for_each_dev(bus, NULL, iommu,
> remove_iommu_group);
> +                       bus->iommu_ops =3D bus_ops;
> +                       return err;
> +               }
> +       }


-KR
