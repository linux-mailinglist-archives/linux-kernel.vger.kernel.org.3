Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E24FB8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344931AbiDKJ7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiDKJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:59:09 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C574198F;
        Mon, 11 Apr 2022 02:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LocTBl9rhZzmN8pNgX8L13afO440DnIiWhBZENNGhLGTKpCHJoMXoXfAp/IecP/rgJCDTHj00Yok7w8PC8woem8L4u8aXR+Ai7JyZJjtp/tleXc19xZV3yzvU/c/6mip9zul8kortDTTKUGZllYb+c0ZEAQWxkGPQKCv/571dpUlELpthlhYKaCuh0rsecQOqr+eTsK19ew0Vsn78Jc/am0rnxRUK5VobwWoilD+7PuVmFDcf3iyQjdZ+aAfUiFr/r1Y7s1tis7vxY6hR3YdniEEZ1sX2ZP5WyLxA7Bzf1u445quaprCCkCyW16N2lQI1NFvbPD9+NIROb2I9VvTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhYjP1kZ3vDoGDfCCUE6x/3n0BZkDNvAx0XLl4Sp4yc=;
 b=lSBElbVnjTss6fTzJhcfLZexjr13SkE80QW5+fkjU9Kyp5iLt4R997J3mfCvuBa3Ofpsrj+UmxQAeIudrQjP96rd/cqjip2fqGAuSVZSX4L6YRdJnDtXrZDktZvXBwpPwzHXroDlLuI6lnB1vebBc71eCTRmdagxJk7u3DjMDnxVdTKajBPhddC1+YfXhMA65kYDFCyUF2Gl58nv5pz4lVYTqcRn7osJOZJ9kLYa0UMey/ZOEHMYlnfhlgrBvS21hh1HKMoJFQ6bF81q9a5Fm55suQ4zCAisXkVOJ9Rbiph7U25EujiZ22GGJKnSWjESYaWQvx7nZBMOGOdmzzpzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhYjP1kZ3vDoGDfCCUE6x/3n0BZkDNvAx0XLl4Sp4yc=;
 b=fubKlPsVaOrt3Cu/ogPA7njZ8pTULA/ML+Ba7wPBBZVIfEZc2uXP5KTvjlkYQbrysBpiUBcKDNdVSqiK94zeH0iP3UMEVg2AodHImm84uET+0z7WJMj1RNj1+Q5yaXio4asbDojdceVMTHuE2IaCUn/FaDGo/PVzclqKQFPzycW+wj9dNonH7JBGx4Hc2Z8eCRxbTGeW3LBFH1J0Q9/csbcdqQ8aecnKBxvzZ4qgly8WE9+H6Tf/9GhhCxMK2X0vFkLujS+WjvKYCXfmmnIQng5fX+T+oqwAFZiCfZU7F0GqbHGQ/0dTgEn9rpW2Yuz8mt8obCwyYVtFOVBIp1LkKQ==
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Mon, 11 Apr
 2022 09:56:50 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::19f2:449f:425c:5214]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::19f2:449f:425c:5214%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 09:56:50 +0000
From:   Mohan Kumar D <mkumard@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH] arm64: tegra: Enable hda node for P3737 + P3701
Thread-Topic: [PATCH] arm64: tegra: Enable hda node for P3737 + P3701
Thread-Index: AQHYQBkRdsbuuAnfB0G3lPb1B4cizqzPszIAgAAis4CAAAMjgIAH7hSAgBLNnNA=
Date:   Mon, 11 Apr 2022 09:56:50 +0000
Message-ID: <DM6PR12MB4435AC886F9980A124C6ED39C1EA9@DM6PR12MB4435.namprd12.prod.outlook.com>
References: <20220325072141.28597-1-mkumard@nvidia.com>
 <f35537de-6352-e6db-b4a6-17b1ab96deda@kernel.org>
 <32e425be-5d78-e1e0-6ec4-70ea21895e15@nvidia.com>
 <ca18fa50-f63b-8131-07a2-8c44daed9f26@kernel.org> <YkQ1bWg00BSRV8W0@orome>
In-Reply-To: <YkQ1bWg00BSRV8W0@orome>
Accept-Language: en-US, ta-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5317cb3-9da1-491c-fdaa-08da1ba1998b
x-ms-traffictypediagnostic: LV2PR12MB5943:EE_
x-microsoft-antispam-prvs: <LV2PR12MB5943EADDFCD5A181EC4A9005C1EA9@LV2PR12MB5943.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOKgG2ckgcKYCcpPwvTAODSfT/RksArFbe8EsV6kE0y9oCIWgmJfBtHt7uttUH3lhhD+QuOfzVrbsX7v09lBIRFzRlIqWOIkO9GieNWFggBV6CoVFDouQye5Su6AJIyHjsDXPoz2nVb/h/tJFoPit/ce6iIr+kyDZzVdOLP8Rvl6ZwLTTJX9FjcTfTOymfwLhnsxZwtfvXYHt32oIqyk0/xMwPtXFRq7KHSULwOpeorQY2nw0PHP5Ts/+4WcHLZJ2rID+odmwRVdBcrTUPfYdRb8xP2s67VVi++9l/mXRSbldLIYmHQyXyDx6YHyh9rJZ75wXnTjY6GlAlJzcfx+VwbI+CdvdeqZY2rOh5SQTsznwRb5hR0LDleJPbn0g4qd9sVbbcR0YWTpx13/LHFu7H7plEqyr5Egj9EK0AYlGqMKU4fDrDbw3Q0v0x6K1ZdWOwK8KKaiUapSw1wRNDh0JgiTpvvTQ9mOjU2UoIbgl2AIzj23p5t3BrNKQhjibqrS5XMqYyNkQKIl7YA6HuKCRCDQm5Vl+IwAQxJvRFvxFBopTG6saWE7j6dN/cLPb+F+GYcekNAeq2MJ48S8M+ka72gkpUlIhjvAdv368I7aJ9n4dm1pHMTFHHD954VfKbw4uIa+qmcVDbiYovKCWKj2l/5EY1JpL/zss9L3GjvQFLkZ9vPHswIYh92mF12vpMTM7/Leo11qsgeTm/+wPkc3XQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(8936002)(52536014)(33656002)(54906003)(186003)(8676002)(26005)(107886003)(83380400001)(4326008)(5660300002)(66556008)(38100700002)(6506007)(55016003)(86362001)(316002)(7696005)(66476007)(71200400001)(38070700005)(508600001)(64756008)(66946007)(66446008)(76116006)(2906002)(122000001)(53546011)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XNKzshEX/HrJVRcJFcKun1zmrBl02uy9oMVwbEjxjVx3/6KR0fBc66+j5T7/?=
 =?us-ascii?Q?jHVMHQ/ptt8J0C+nZ9Dlr22/X11bwAKbwgyz02kWyjNIqkScWSLXXHN/8BUu?=
 =?us-ascii?Q?3wQ+vj6hGaB5ldJT03KFkEDPG725CCVlFc8xVmq0wjsAmVk+RJXVw4nsJ5Ri?=
 =?us-ascii?Q?vzSkELYx6kvIfBUc0cZQ6dmiWwpd70dRBSNe5KawS909DLdKFq04OnX4s8/s?=
 =?us-ascii?Q?5oi4lyoEwah1iPONM6siD+0Ys46E/WaOckKpEavgGNFL3J17ObDuOXW0Yn8K?=
 =?us-ascii?Q?HEIqGD+dzOnHoOBIjMrnZKVQVIw7S9kQFxBywMBMaXudrb7OVbsN+bFAOitJ?=
 =?us-ascii?Q?W6VmPQF2BijscHTcD9+R9CRIqR8aPBJ4sgnOlqpSUy0OtANDV1VLxK87OX/l?=
 =?us-ascii?Q?2IeUYuzZGtCFttr4AfDOdF/Q+ga3SJpqkNPiMeRB9nou+FYcH2p74OXgIU9Z?=
 =?us-ascii?Q?CYOvUgHbKpfKqBYMZnCwIAJOUkCyN+M1oh9KoIfV4MbnTeonX4D1qRhZL7zZ?=
 =?us-ascii?Q?RxV0YAYGlUPjqpx2ONX5t5BxUp7YTrAVji2g16n1fwlf4bv0peb7LapQaYwc?=
 =?us-ascii?Q?dbMSZ4d61DcFX+4twVjAtJMfisBfthYB3epSRTjHz5e/xeSYoe2RXo0AXTFe?=
 =?us-ascii?Q?ySFaUE073ahRyfd7u89f+Mz1jUXl17gRfPTmaxLe257qI4nOLrrxRrk3EFl5?=
 =?us-ascii?Q?Z5U+XUUBzo227eIeCeABDr3wsEZLJCMjCJmbSx+5xxuZidoJYqGJotoUqs1U?=
 =?us-ascii?Q?yZqKC7G7jwrcP1jxFtRuh2NuYWySN5kT9lmWapyk7KP9LMs9p55dqqOKU7uL?=
 =?us-ascii?Q?XND61TRcIzTqe+72U4hJ8Jq32/DZ1W47dJFgwP0sydh6pW+Yrao06u56kgBL?=
 =?us-ascii?Q?notjUjiS3/Y8UGl3adc+oyU3ZgROZCC5qsgnIYH7OrcFzF6Lli25JlpEaB1j?=
 =?us-ascii?Q?WOX2QGt4YGLdE0OST2B0Icm1n5wI35SvuBCVhPCP/k68MwXpcSxX30Q4bNYT?=
 =?us-ascii?Q?2H5IjkG7XNg3kF3fV7nPFHBqwgb3nVuA8Frd3jQ2LdB/y53l2kycjj9BKxAy?=
 =?us-ascii?Q?8zLPQirrDhWnjyP4uyYNWwRAIlTh2UJC8j+5EnZLXihafnBXq2mA8Xmne3WA?=
 =?us-ascii?Q?nKayiLW6QILYPhyerL7P03O/BNfsnQX+t/V8ySART6R8t78a3Zo1T2Sam2nj?=
 =?us-ascii?Q?FGeq2Fe6ApvFh5z6IylP7bmm2+JMhRNo63zIYTowpKcwcMsS4gDcIh2UBA4B?=
 =?us-ascii?Q?yjoWT1OKvvrA2dO7U/KMy6APTwP1MNPFgMIZqNOguawM8uRtTuKPYwKuOFyp?=
 =?us-ascii?Q?rE4P6I8+Rdj3pzk2CEJsu6dpv/P/wMSzRb3yYihEOjq+yva0sp10UdrAYGcm?=
 =?us-ascii?Q?6AjqyUBfPG2jV6cMwWAIn/fn5O9SytBCu127GNwXoDm/fzExq8de8aGjUVKu?=
 =?us-ascii?Q?yC3qe6UAUUBa4+mdenfrRnNevY5dideLEJrP9F/pThnT3TKhCmVzYY1CoZ4h?=
 =?us-ascii?Q?2d8RuDsTy0YWaZ1vXairSwx1PFHfpX5IE+AohuaXZpE1xHQ2cz80+TGz6eZC?=
 =?us-ascii?Q?BqbzWl7sGaMehXFJCAcWtwNoIgMMJTenaB315fwPa1YXOHks0zgmfj3x4TDB?=
 =?us-ascii?Q?UbxOyWtu+RTi3vu6uCgkyB/WxyoVDiAYHQqLTymEV903So5QA/7u5+CN1VEB?=
 =?us-ascii?Q?nSGTDTIgfvQKFnowfZ8E83/dE7Hwkx7meDnu+TZMa3VpgExdwdFVA87fMTqg?=
 =?us-ascii?Q?az46oWURCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5317cb3-9da1-491c-fdaa-08da1ba1998b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 09:56:50.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmCzH9erAM+waUbjkk+xukI86HOxI/bk9IKuTeWhSYAPiciCZvDguub/Mw4eYJgmUpaTgGt8uUOyBG48nCBsXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry,
Thanks for your explanation.

Krzysztof,=20
Let me know if you still have any concern on the current patch.

-----Original Message-----
From: Thierry Reding <thierry.reding@gmail.com>=20
Sent: Wednesday, March 30, 2022 4:18 PM
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mohan Kumar D <mkumard@nvidia.com>; robh+dt@kernel.org; krzk+dt@kernel.=
org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Jonathan Hun=
ter <jonathanh@nvidia.com>
Subject: Re: [PATCH] arm64: tegra: Enable hda node for P3737 + P3701

On Fri, Mar 25, 2022 at 10:42:17AM +0100, Krzysztof Kozlowski wrote:
> On 25/03/2022 10:31, Mohan Kumar D wrote:
> >=20
> > On 3/25/2022 12:56 PM, Krzysztof Kozlowski wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> On 25/03/2022 08:21, Mohan Kumar wrote:
> >>> Add iommus property for hda and enable the node for P3737 + P3701=20
> >>> platform.
> >>>
> >>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> >>> ---
> >>>   arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
> >>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi                      | 1 +
> >>>   2 files changed, 2 insertions(+)
> >>>
> >>> diff --git=20
> >>> a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts=20
> >>> b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> >>> index 34d6a01ee1c6..156d5d95fde7 100644
> >>> ---=20
> >>> a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> >>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dt
> >>> +++ s
> >>> @@ -1751,6 +1751,7 @@
> >>>
> >>>                hda@3510000 {
> >>>                        nvidia,model =3D "NVIDIA Jetson AGX Orin=20
> >>> HDA";
> >>> +                     status =3D "okay";
> >> Nodes are enabled by default. Why do you need this?
> > hda node status is set to "disabled" by default in soc dts file=20
> > tegra234.dtsi. The enable is controlled by platform specific dts files.
>=20
> Oh, surprise... why do you override nodes with full path? This is=20
> error-prone and makes any changes (like node name fixing) difficult.
> This should be overridden by label.

I disagree, though I admit that this is probably very subjective. In my exp=
erience label references lead to completely unreadable DTS files.
We've had bad experiences with these kinds of references early on, so at so=
me point we decided to discontinue that method on Tegra.

Reflecting the tree hierarchy in board-level DTS files on the other hand ma=
kes it very clear what you're changing and keeps the board-level DTS quite =
readable.

Fixing node names hasn't been a big problem for us and any potential remain=
ing issues are entirely gone now that we can validate DTS files using dt-sc=
hema.

Thierry
