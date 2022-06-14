Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83FD54AE29
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353469AbiFNKTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiFNKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:19:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76780427E0;
        Tue, 14 Jun 2022 03:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHq6QLIO8Gu610zluRkW1hpPevQLFpH4+e2ZL5y6PubIUq6jz6QC8f5Zo22jqbJsi2xAjcAzMoZb05OrrS0PF/IGURaIhthWSb+e3aWsgAlqpof9zQqfClIIK/3jYzzj975eiwaARY66U+3MCnCUyApqbM1KjpTpHKr6Kuopy8+T5fOgg2en1ltIpKiIoGtyhpxCCp36NQMl1VAA7Q6Sa0VrHgtNzMronSeFe3aGDHduqaXL76r6T2oLYcZ/zt8mxpo7jjCpuNh84PfXAj/+9SXYpS4PqHEZfj4SS5LCQlb/8Y+r2MPO2/zI/Nq+JadxZKHSmbI2R5kyXB2O07O+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3cH6gLeUiHOeBYHUEdEzIdscyqktofXeVbIgF8LXmo=;
 b=RxP9O2OKziU+H0pDIIzXmt7nFBkq9Q0FoBk2eozgTbUj35bjmFsZVeT9kJ+mjEk88jtePL4Vfo/3E24RgnAD5vRdoQpyr9ac6godNsF8V5HzpW3tSapgO7Om3pDPas6piJcAqXnesUC7Der6E4ywQFd2+/L3jdnbyQZcuCr6LqV0G3wDCz/m3P4gURt4sL7ZShXTP3uQ1jL1UJxdL67lIdsJjvqpG6P39FxXzD19egChn4Srbac0llglKf5nDM7ZZG806Tk3dlEp6pQeNGvRk/uYBSQ1DH2+TnjHkohLx5cFoj4MyXdnZLrsISpUpOo6KZxfActjxYfONEW9DBSvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3cH6gLeUiHOeBYHUEdEzIdscyqktofXeVbIgF8LXmo=;
 b=RvZBWxZ1G4eoW2UGbevtGQO7VH8Qq3/7ySrHLhTrsyR3Iebt6yUR1iJtHbnzFbxd0GAhBuRHEReJIFinBy3pPlo+mDByuNhWLv+lO+8mfKlNosP5+VwXonCEzK6jzYrZnBqVTdQ3iwpawl+pC7HK6JAMNDyUoPaG5Tr/ncX3sa9/fgTXXBnGDkFMKIH82bEjzQnLSEqtsk1GOcPKhVjeIi1Am4ciMydmoIfgtWO11xd1tqkX7GWYlGe3pEDgOXT0A3DcYC3DpTbnRRUF3hyPmcDHBuuAThNwrG/VcQJZ2GzBFAK47AZB1Ace8CaOsuQnu3anmZ8EBiF9ivlcTUtabQ==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.20; Tue, 14 Jun 2022 10:19:35 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::417d:fb69:2acf:c566]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::417d:fb69:2acf:c566%4]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 10:19:35 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: RE: [PATCH v3 0/2] perf: ARM CoreSight PMU support
Thread-Topic: [PATCH v3 0/2] perf: ARM CoreSight PMU support
Thread-Index: AQHYcAOGF4muJtj7wEO6ZGULdDD9ja1Ozy/g
Date:   Tue, 14 Jun 2022 10:19:35 +0000
Message-ID: <SJ0PR12MB567619199883426A6EEBBABDA0AA9@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220515163044.50055-1-bwicaksono@nvidia.com>
 <20220525064837.7263-1-bwicaksono@nvidia.com>
In-Reply-To: <20220525064837.7263-1-bwicaksono@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38b29cee-87be-4403-10dc-08da4def616a
x-ms-traffictypediagnostic: DS7PR12MB6262:EE_
x-microsoft-antispam-prvs: <DS7PR12MB62623247EC1E8231EC621D8EA0AA9@DS7PR12MB6262.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 572VB0gwIu2Lv5Ct8M0mRmWFZ4cHA916sMcGCgPMI89Gx81h/l+NQMshdT0gGobijGBVbwHJckwzOCrozyrvl/4wlLzamllwaw3K7aIIj2APlnEKs/SykROjQuaoqz9Nd5DO2w46SE1EJTGUeTuw96xqSZzhGIx7tM7KFFBjjb1Ier+8dGzZjF411wWC+KmmzCSXwVa2ysKpx3d6tDwKWaux6vtcUvTrbcr8N3QKrQty2/EfAz7ubsQUgd08A7IsvvfnjeoD+fKtqixhD7N+ETYXZl0ZNfGFSK5tOsLuRip3TbLp5bZnLSqFiUhVdhLAh4ttgwJAlYzxEX/farhPeMBNwIDi48RbD5M2ZSVa1oQuSe9ds7AkNcWKP2o1goBlW/sqL/jwcpBNCjwVJKtydHJVzxNjGlJiCTcWFhUFRSAKTBqhWi8k6TWsH7mVAzKO9p21+O8avuhlN9SJkb+JREHjKL9Mr9Ax2C8P3QZOEbhXEXd90Q/1EAaKoRJxNHkpipGaNuH2Ou6Oa/RJV/MhMRc+QgvtWaDJPfgWn8zxCke7ViHYmUHtpSz+D+E6iqbyBsYqyiIbE6AMsGuViWCkiHJxYrS7eaE5wvdbmimNgXr7pFjQ9WvFGvBWH3U1Bwr9ocS5y4H874hsNdJvKhzxvNWmOj9hf9Px8BbwD1iTDP96YBLmoGQEwGbZOSxMlbE7VUvNbMu1o4fX32pcc+mgVBqt8Cew5B5XJoorAY3zcb0sV5/snTLyLaKYpocUIzgRXMOpWE7Cm2ki9RIfwree20yxPJWMHEmzH7Z9jVj8mOuBY6oOGtswFxhPR3idqdYhB/gRwCsLjHGvpFFvpm3wOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(9686003)(6506007)(26005)(53546011)(5660300002)(966005)(55016003)(33656002)(107886003)(122000001)(508600001)(52536014)(7416002)(186003)(7696005)(83380400001)(66476007)(66946007)(66556008)(71200400001)(8676002)(38070700005)(4326008)(110136005)(54906003)(8936002)(66446008)(64756008)(86362001)(76116006)(316002)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EHxX1Nz1f5DUl4dU9CLhQ8YAfWTMxY0wwWgVea9nlGFfuD4h5WZ2e0rYJY4+?=
 =?us-ascii?Q?Pbmsd5U/Cc+NIX599+gacO14Ctnd9gwztsNTebK76fyFTsDCJk+cBsOl3Fmx?=
 =?us-ascii?Q?hByv5yqKZun+eXiz8qdsPHqta8aR33lR0Tkg6ocA3VaqnnyKV17SYcxsWH//?=
 =?us-ascii?Q?2UHpHhsRAQcuW8nP0lsmnL8x24iLa9cwYS/3qZwoZmSVMXkye5JGxjB1QIdV?=
 =?us-ascii?Q?wBk/6xPHGBlGuxPq6FlNBWl5TyuZtxqHEhSrjDOEx0OwyMd4p7u4eXMUMdz9?=
 =?us-ascii?Q?IOAOG8KD0Gd5eji6yTMkWy0TUJbWhj6yzlJ/HUEcxWEQKUi956jPRXYk0C2y?=
 =?us-ascii?Q?6Jdwzd4Y4y7oxPrQ6jQiG5Fb5JsXswhI1lXzqa8IUO5JF7JdWJQhfgP0/M2h?=
 =?us-ascii?Q?A8iHxWSId99N0se38Xfxr0wbEo56IJRW5pUj2LOFqlS/UZR70J1hgYj59E6y?=
 =?us-ascii?Q?8AC9E9b1Ybu3OAVGhT5xUbjjOn1xdS/KzO03iPx7F/yPIViWEQTB0ZBKYe/V?=
 =?us-ascii?Q?1KI0DJUzkN1ZCKX6Dz19GmTYxX0Fv7CtHJQilkpD/hwhKPPaBldJqxWptFmz?=
 =?us-ascii?Q?MLAu3/XxPJAhKMK/Vn2XLXSU/W+Rjhf/AXsvLlpkN09b84OuphGEn0o3f0SV?=
 =?us-ascii?Q?ej2Pt7eLblu1h4naamlrnUSi4dgYBsP/bZnZQ/yUQqAm6hesgIn8i8dyEuAN?=
 =?us-ascii?Q?4AdP23o0Dmkect3kXT4G36hE+Ah3NZEpXQZLbpqfIymesZ+XZVrGsxh6djC0?=
 =?us-ascii?Q?RGvUsbCkVqk0M9iwTiydVmwLs7XTRSNorvkq9w9ftmdxmfjYHJBQgInMrFDX?=
 =?us-ascii?Q?wSZNbj/usqmE52/cBa5BwwGcMW67ztvVJ5AWU7Zae3xxA23v3tQ7Tfs5DgHf?=
 =?us-ascii?Q?t8RIinywm5mbKmWmrJWz6C9HyCDCako5+3yYC2Qut+DCTukrE2OyfGU5CYls?=
 =?us-ascii?Q?/L7Wilwf5gRmmdS53ds24jdxSsPnHKnveCvt3/loBAWb0td7zx3U0UGu0wNH?=
 =?us-ascii?Q?zhn8WkgAjZ1qTR/txoK5Uyr18ZBi1YMxQoNUR50Gx4ul3vnarwWmS8JOkjnX?=
 =?us-ascii?Q?zSiMA2C156n0+5vMq1jfBSc6XQ2Y38e+M6UdRWd8P532tVnICwpRZgSuvvSv?=
 =?us-ascii?Q?83hl+/UNG5hKg4zpBMjaDgxRCNuYxGlqKfnEeOafw1atNdmoYlXKeOOD5hq9?=
 =?us-ascii?Q?O/15Bab9KxU2U1QAoa1wCQ0xv9afBrbrNvyzf0+erovGfXFgv8hrKYnybkxU?=
 =?us-ascii?Q?edE4+A1Gegy17sVwCecYjC1fepEFbNU2EVbICeSksDqlrwfLq0Ft/6jxNcdt?=
 =?us-ascii?Q?VnRl+WDoZFFaCW6ildYthwK3NQmuqEzpG5h80mX0kWgQAeizsRp0roIZZpuB?=
 =?us-ascii?Q?aqvlp39QX08QiWBzajFTqfu4X6tSZK5mjZz7QL+oSZrkEz1vMEqVhlJPfgOz?=
 =?us-ascii?Q?4ch9mCWm7WpI7EXPWossLZ+FF1+drVgI3SXw0wnaiQ1H1kJxkbVvFDsnGgSV?=
 =?us-ascii?Q?tWPB17wJwWwUX9+zVtoBnUlCTsPHcxvkyBu12y+DPyFi8Whwnjp9EMrFbYt1?=
 =?us-ascii?Q?YHn0FNFwmXxUEIM7By2dqrDZahzUctxnrUQyK2ux0k0rWLfR9O4hG5nNmJRm?=
 =?us-ascii?Q?la3HTTZ7QvP/4Y0bZKh7iRDKmpVOIO/fnU7B9KX43Tt642JmeHuG6+RPHVg+?=
 =?us-ascii?Q?Oh92EfXj+HUHs4Stly3vBow76lZFIHm9HSgGtlSLbu76oHCAqTrdtPWR7Hl0?=
 =?us-ascii?Q?/cTr+Ndssw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b29cee-87be-4403-10dc-08da4def616a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 10:19:35.3053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pnfn1PZBRLNKwJJsnqOm7mnyRbLqappFro0UqC7zNB8KAY0l0fxxx7c/g7V4ySyqCCyrtqwIiFTXtN5ck1j8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping. Any comment or suggestion is appreciated.

Thank you,
Besar

> -----Original Message-----
> From: Besar Wicaksono <bwicaksono@nvidia.com>
> Sent: Wednesday, May 25, 2022 1:49 PM
> To: suzuki.poulose@arm.com; robin.murphy@arm.com;
> catalin.marinas@arm.com; will@kernel.org; mark.rutland@arm.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-tegra@vger.kernel.org; sudeep.holla@arm.com;
> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; Besar Wicaksono <bwicaksono@nvidia.com>
> Subject: [PATCH v3 0/2] perf: ARM CoreSight PMU support
>=20
> Add driver support for ARM CoreSight PMU device and event attributes for
> NVIDIA
> implementation. The code is based on ARM Coresight PMU architecture and
> ACPI ARM
> Performance Monitoring Unit table (APMT) specification below:
>  * ARM Coresight PMU:
>         https://developer.arm.com/documentation/ihi0091/latest
>  * APMT: https://developer.arm.com/documentation/den0117/latest
>=20
> Notes:
>  * There is a concern on the naming of the PMU device.
>    Currently the driver is probing "arm-coresight-pmu" device, however th=
e
> APMT
>    spec supports different kinds of CoreSight PMU based implementation. S=
o
> it is
>    open for discussion if the name can stay or a "generic" name is requir=
ed.
>    Please see the following thread:
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2022-
> May/740485.html
>=20
> The patchset applies on top of
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   master next-20220524
>=20
> Changes from v2:
>  * Driver is now probing "arm-system-pmu" device.
>  * Change default PMU naming to "arm_<APMT node type>_pmu".
>  * Add implementor ops to generate custom name.
> Thanks to suzuki.poulose@arm.com for the review comments.
>=20
> Changes from v1:
>  * Remove CPU arch dependency.
>  * Remove 32-bit read/write helper function and just use read/writel.
>  * Add .is_visible into event attribute to filter out cycle counter event=
.
>  * Update pmiidr matching.
>  * Remove read-modify-write on PMCR since the driver only writes to
> PMCR.E.
>  * Assign default cycle event outside the 32-bit PMEVTYPER range.
>  * Rework the active event and used counter tracking.
> Thanks to robin.murphy@arm.com for the review comments.
>=20
> Besar Wicaksono (2):
>   perf: coresight_pmu: Add support for ARM CoreSight PMU driver
>   perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute
>=20
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/perf/Kconfig                          |    2 +
>  drivers/perf/Makefile                         |    1 +
>  drivers/perf/coresight_pmu/Kconfig            |   11 +
>  drivers/perf/coresight_pmu/Makefile           |    7 +
>  .../perf/coresight_pmu/arm_coresight_pmu.c    | 1316
> +++++++++++++++++
>  .../perf/coresight_pmu/arm_coresight_pmu.h    |  177 +++
>  .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  312 ++++
>  .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
>  9 files changed, 1844 insertions(+)
>  create mode 100644 drivers/perf/coresight_pmu/Kconfig
>  create mode 100644 drivers/perf/coresight_pmu/Makefile
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
>  create mode 100644
> drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
>  create mode 100644
> drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h
>=20
>=20
> base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
> --
> 2.17.1

