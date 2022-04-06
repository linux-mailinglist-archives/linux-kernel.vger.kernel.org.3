Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7634F68E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbiDFSRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240530AbiDFSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:16:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D7C213539
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIVp2H2OG1sRNTO+TkERPBGZqbB8TQfHCVbqedl3QWgoya9qz1mCLcz7ZmnPkM9leRJ7eNThlnndji8ZB9KjQD/kECKPXeQiYw3/buDuSHvt91UcqIjw92CnpPm9TrTi0ffXhEpgHaDSMaI3GuRymwbUNMdOPl1Lg0UpGszmJ2evD2Z0LDPZx3XiIK2KELTa4dy01DnKmCdgQLMARlbbaO400YMt611HgyOzweTU5zncxlX8UAy9Eh4X+2YhzW3WJPkqpIbz2y58tWXLxI/iUMEGL8D2tfqTAoZIhF6riee+a27p5Gg+DIgqiMuSZtO99yF77Afa4u9IDmhWvmhjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfvxcTQDTgDqhSc2wFi5vCho5d93bIDpD3o+coql27M=;
 b=ExwzzFpPjpdwKS9wEdfd69qQEJNaQUxTQqjjzSiuaY6My8V30Dg9eBSnvauil19xp7LV8/p9KHaUPMyutYFdkIL1waH+waUQIh7IrFcrhBy/A8M5zHwNr/nGU8addA+8ifcgc3zo7p/1W4mpYIpBiKF1F3vsz4FT3+YFZdAa+xst54JScE5iNKwJHI3T0URFyQ0T8n/gEzot3I89YFEZBLi49NLJ+61bssBufOtUl6niSmiEPPeHpnmqc843GMH8iVzQeq78Ti4ik881ay414IFdl4UFMgkQDK/Kz9PBDw5kIyl8CddojK9jbITyTpvI4dAHmWqj/dECobvUUz62Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfvxcTQDTgDqhSc2wFi5vCho5d93bIDpD3o+coql27M=;
 b=Taz1LlkAfJfMmu0ohFE7wW84S+ugCzD1OFtpnEnXRbXxDISgAkP44TLMGtfQXgaix5HkKjb/OS7JgRaWAlz3U9rdEYR/ztyRvFfhsnodptXIaUIxYxRAjvKQF2a+1pLtbq4HO3YtvLfnorJacgZlNJprbRg6Gscwifcyz+kisTc=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN8PR12MB3346.namprd12.prod.outlook.com (2603:10b6:408:45::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 17:04:52 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 17:04:52 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Thread-Topic: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Thread-Index: AQHYSGU4VLqCQ4qdF0CtZP84uy0tRKzgu/wAgAJi57A=
Date:   Wed, 6 Apr 2022 17:04:52 +0000
Message-ID: <BL1PR12MB5157E55F2F469E66B46157CDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-2-mario.limonciello@amd.com>
 <YkvGwMlrv8JKjHJQ@infradead.org>
In-Reply-To: <YkvGwMlrv8JKjHJQ@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-06T17:02:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d64b452b-3851-497e-a185-0de296ea80cc;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-06T17:04:51Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a3888b1f-c219-49cd-9dc0-3a9e3f46fab4
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8376250-633b-49d0-5ea7-08da17ef9128
x-ms-traffictypediagnostic: BN8PR12MB3346:EE_
x-microsoft-antispam-prvs: <BN8PR12MB334685E1927BE2003EF3B946E2E79@BN8PR12MB3346.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWiB5hEXev8QfOVdDRgjSuNY8gaStVErcgmrhovicCaYkouR2j2ZOizf+7V7sbWSf7ECCHkLqjuZL099C/W5vSpZKwflKpat9zYb4eBAFFHXsJ8qtcavjvVV6qJ2Y1eSqvLyiZDjgQ0BXjcRFEyoqNxBVFRs0SCRN1YrC9POXRSjJ7msvFfnsQ258Eg584/DAXvfjm4XMpuWvQ0xFQTA4WlySTJ9K3E4ekEQzPBQxHsb46VlGUlj145od1+u4luIcrQgGgo6vnoPLDsZgDarwxmL3tbTboMw2L9xRA/oQlJPtHclt4P+TNCXBAO2Zbij/9JQ48Lu/qbsM85IpJgp+GhJk4TANrXudySgbxVgP8VfiZEyas61Z/0i50U2Ih1zVV/ekGz/BP3ezw0/NP52yHj5+iNT+wnZxiBicWsAxVCvCHjwQlBkbwSKBy1iRdSMI0H1hc66wqH+g0QuYNm1mlJJFMoWnibyoDePhiBI7LvqubYsffsxuKcuFK2HO57bf+MpgDlgrNOoU6+zZ6nzmTqLIkMbUpNunJ+Li6PDYmDdg92VdS16qFbtvHeEh0V2Zyq0sSaKSgH2PoI+QxYsHOVRJqkZxTpTTqkDo0551wsq2I0vD1yZ0TKiPuE6xw+DLGrmFOHxtM4Tj72tBU8DsU53yTAbddH3G4PMlJQ3GML6Zdp9+KYQOp/6ppcT23OEwVe7bHh09LegesW6eG47jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(4744005)(83380400001)(2906002)(53546011)(6506007)(7696005)(5660300002)(9686003)(508600001)(186003)(86362001)(8936002)(316002)(52536014)(38100700002)(54906003)(122000001)(38070700005)(66446008)(64756008)(6916009)(76116006)(66556008)(71200400001)(66476007)(4326008)(66946007)(55016003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9K4hBYLhszwIiv6QoDHZJJCCqdbxEeuNrgT8LigEqTcZZ7M5cy5cdmGyVDVa?=
 =?us-ascii?Q?Wy7kbHIceuOrO+WT65KHGnKNX0qnPvVlcP7cyO/PQi1WdxOd+S4620RidWr9?=
 =?us-ascii?Q?gwsUdqwUK8HVPkU2HDYnS7EqFdOxUtguRCYZvy7GfobWDMq4Stm0f5ggrAnx?=
 =?us-ascii?Q?Hm040QBEOEHDL0GVPFpzDZGQKn15zNIRSs4rRnDufrEsYPked8BJ0xZ2iVpf?=
 =?us-ascii?Q?VUv0i+BLW7scenPDsN/UxPQFqsmfAE/krvb6eI02SMDAMFzshySRMjXjZ/zq?=
 =?us-ascii?Q?wQlHRpCWk9aF/Ay6Czw1gs8AAGTPaYCq6zjWiOH24LbgmrXk6WTwNt77Fnu7?=
 =?us-ascii?Q?y67ZPHvKNz/JQkzXnuJmegVzk1dMtByfVZRKRYDGrx3tqEyB5bo9khqAgase?=
 =?us-ascii?Q?EryfDqvoyu3cdKftPBf6WgA7egFHEp1b/3dVh0a3KOzB7b+7FVrAPN3JP1SP?=
 =?us-ascii?Q?zwx9YvI7p+00W61HfEUFVQ2++dRi43CIdHnPIKHl5YX04ebd2Bpij8lwJ2Ia?=
 =?us-ascii?Q?6dRDti4pILvv1tz7FayCH0Q3j9+9MSZgjfN+R0+aJm2Dc5irun+fx9AM5vCu?=
 =?us-ascii?Q?KJ5DtNtMwTRN+YPYAWoO0YRaFzG92IPWkC/N0zokbk6J+KvYqg+gXSUfs8Gg?=
 =?us-ascii?Q?5/GH1pPC0r2MNFdar+1iQW2TDpJyzDJauEGOelc17j3J2RiT14oDq8MVcG7Q?=
 =?us-ascii?Q?RekwURiZDwntCiOeBY/VT7110atf0xx3clELe8IEfovVThQTe0q2mCzAjZ4T?=
 =?us-ascii?Q?27cWYMf1tC75lMq7wfuJ7xELoVMBoLVaDlFVDqoeSH1J2ShUq7M4N6jKSCAr?=
 =?us-ascii?Q?MdvPf6OdQdrE0vylKUhUmIoXFGDBUHUbsDFu3cCoXS7TzyfXGeHQpFL/Inop?=
 =?us-ascii?Q?Kpx+D0Nwbtm7wJs5d1FYC/xnJXaL2ljSnF9I50nx/wDeIHTa6hzbZ1UAXoa3?=
 =?us-ascii?Q?sbT2cpnrW+9nFaHu6+WLGcbjhwMcgvoXQJB7MtP0279ISu+Y9w/ol9G+lF7D?=
 =?us-ascii?Q?KBV1Pu6RLyB0HlB1sjUEEFg8qoJORZv6Q5jK1iR9cvSkFC1vRmfdFp2HbLIc?=
 =?us-ascii?Q?gdpoa9Gv6GCz++dCgNEEpDUQ1jSzq7HNmQ22EHrERGu9ZTtrGbf6bL24HwKn?=
 =?us-ascii?Q?BjB0Fqn2RkRFVqE8E6vVgmpbyJ3WYtbxnSXA5VpfwWwaR4WQuRD/dVXC+vaC?=
 =?us-ascii?Q?ZmPTDYyUdPS7cYo5HDrWWsUB/gUsSczsTwQiDwxL0SeFIpZXyvqZTZ07ChHE?=
 =?us-ascii?Q?PmWEyDI2NpA6OOEKohx5gLIXH2hG4JlmGSw/r/zoQ5hw6wy68+pqyvFv3MxH?=
 =?us-ascii?Q?QZcBZK5eT/0fvmorjDQEuVe+SAtVUf0f7ipCGI3miApb4noJm32EcLefbngb?=
 =?us-ascii?Q?Nao1LFX3RC91wnNGio1gpk4mUgUgCOn6YpcSExyp4a0yEoKZH4fOr9qjlIlp?=
 =?us-ascii?Q?IYw0f5+eSckd67Xeq7RQQxfuKwgP04loHLoDJ+5YNHoXKk+e7ag2oK4iUAEO?=
 =?us-ascii?Q?eSyIMBCnylaDPcorsCZqwlr3kqKe/4rpZa/1kZN6p8nKCBvjwO5P/izkhmur?=
 =?us-ascii?Q?9KFvQobJ42W7e7yIAqtizahHdJlVi70Unik3cDdgyt6Ituza104lusrZWZR9?=
 =?us-ascii?Q?SBBf0Si0HMnq6qV4Bvq4JPUsFIk29Ey5xC6MeatBjzWGvD77cHV2MHOQJ6+5?=
 =?us-ascii?Q?I8C7eh1OlYU88A0pp1/It3nQRw+cbuVZjkjkvPIjQ2XaGYMxlWUIr52cVAgu?=
 =?us-ascii?Q?gqMeIn2hJTXlbUULxICUbZ+STr4nwe4+rTrlAsIrp2SHyNp0XcRIO8bbCbO5?=
x-ms-exchange-antispam-messagedata-1: 62zUx0ub/bggBA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8376250-633b-49d0-5ea7-08da17ef9128
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 17:04:52.5686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNi+5skjDNcZtR9S5088UKp4kLRx3oBkmK7c+nWKZbMEOv8v38o562R0hKY3hGaiB8xTTftWpbHq3SAb5Q92fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Monday, April 4, 2022 23:34
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>;
> Christoph Hellwig <hch@infradead.org>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Robin Murphy <robin.murphy@arm.com>;
> open list:IOMMU DRIVERS <iommu@lists.linux-foundation.org>;
> Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; Hegde, Vasant
> <Vasant.Hegde@amd.com>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
>=20
> Looks good:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

Considering before this fix effectively swiotlb was turned off on most AMD
systems, when this is picked up I think y'all should consider to add a:

Cc: stable@vger.kernel.org # 5.11+

As well.
