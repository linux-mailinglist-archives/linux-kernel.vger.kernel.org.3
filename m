Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2C56D2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiGKBo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGKBoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:44:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE73167E9;
        Sun, 10 Jul 2022 18:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWoujrd9a9VPal14doCOY8BlgsDxU3lUctDtIksac264I5s9wk6uHJ8azZjezgNOI1snnZG/0HlC4oUzeJ8UaH11WP2JLhdAAZpp538rBpKCBgzhLzIXOwa4QYNWPeNtRZV5b8GuEtuJlOO9WZX9NKLL9BMo/xS7KjL/koFMvlsUZOMA65HuXhzaHLUJPZb7Goh7lxtSp7+fUd4oIjvPdpgrWZy7717zowpTNjpC2u2+/bHkyTs1Hb3X6a3MvsAxZrL34N4MkiMHxLLGTHGAilPwQjxfxTyBUg3laK3h5gGqaWEsrFIutpszIMSqIfLl/D5C/84kJkzP7sCJIDG1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUvQncMr0OTNp3YL04iar1w4K5LdIo45fSPSnGyTEF0=;
 b=ndx2u/SkFi7aE8HhgziKszO/E+JUtM+g5uiT0iTLPtqkZ/b+LuoPbxxN/QUhOWixfpMwRYoPucXMZhR+teNOYWpRHBf4bohnDk0FDTvHG7p3XmeftTEodti/L2TlO6VPUYGkPKyMkxe8/0rIYuh1YFYhP+P0mKIstB7ovAkMu1p6KSC5gOu76jHnxpB53k9+VXWy9phyU0WQdPKDvhs7yQQRNYddAY/bAXekUbG3HRlZhqgw2vCbYj3nOa5Uv7lBzem6MsqvuUmwaeieSR9QXp2f8rfodpStICbhlB2ilGtNWuhQLN2+v/LDRvU7UAcPERfMXHO472207KruGqnWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUvQncMr0OTNp3YL04iar1w4K5LdIo45fSPSnGyTEF0=;
 b=wA2aP28ccULxheqcWncS7dJKMKH3p5ilQrOzNgI0WesKkqJDIwv/idTw+F1Zas5mz2OwkH2EDsD6IIlGiJiQ+zcyqqP3nLycJcI/mLGKnmmFwRyET7F89EhpL7oaDLWZo2zioZtErkH+xZ14aMXSE6ANkzeQfQzuJrJsG4jNtmE=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 01:44:52 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 01:44:52 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu release and
 acquire
Thread-Topic: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu release
 and acquire
Thread-Index: AQHYk572EuKZuGe1vEeWclJdooiFQa14ViMAgAAJLkCAAAfKAIAAACug
Date:   Mon, 11 Jul 2022 01:44:51 +0000
Message-ID: <DM4PR12MB52785445038C33C8EF1AA5669C879@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220709141940.836412-1-Perry.Yuan@amd.com>
 <20220711003934.rn2igfoxtpcsiocm@vireshk-i7>
 <DM4PR12MB5278B192484CF7B728875DD59C879@DM4PR12MB5278.namprd12.prod.outlook.com>
 <20220711014018.xgflrf55bpahdvtg@vireshk-i7>
In-Reply-To: <20220711014018.xgflrf55bpahdvtg@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-11T01:40:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a82fa7b9-4dd0-43dc-937c-ce30f5c235c1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-11T01:44:49Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3cd0316f-9f16-4c7a-8d93-15cea7dec887
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce009582-8ec8-453f-95c7-08da62def29e
x-ms-traffictypediagnostic: MN0PR12MB5929:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDGP4/syp5mftihhM7eVn6Z5Mtpj5WKpfueWQR+RIRBg4CMROWUIw5d6vlPKMQY+sQ7eIMajwMTHD3oMvKrGLhycV/gW7koe5T8BsZzD0nkO1r4P926mzAP6E6CV73UUjbO58O5CM+iRN1q47OEInqmkR2Hm0fJeKml+Puwi3Qbzzxf8bvt+sqNjJCiGrv0nX5BU0XVvrL2dj5tcIip5nH3wV1wZZYg1AFN97eyOlryh/44Bq0zmD7CygUWhjv/r0pO83dw/FW1dBCAXwuW5ya04Wyrg0zJtpWbW9z8lEoi69T4YOJ5I6N/IUAVvej2hQH5BcsiYD8hhx8fjsJrKFRQjSncn5Ucmy9F70Tb7igS260Utc++uuIHhLOp2IH+RvLaLRuj2RkeHM0+QxB/4Sx+wLO8pjX2V9GlZoJYTPryNMA+SkNZvvS27OyXoxJnqZfRbTBXuh1FF/4CuQeLeA137d4XbFBNYijRJ320/5wRJsBPfJBy+NNbCaNb+4NUgHcSSBnXSr0FD+nbuzbmiTruAEKIGmayRPN0hCaLziGuyYM/B7JkdPjlr2bcsQZQGnmZm9UHht95MUwzuvenC/4pKVf4TNeH3XfLq+eLKv0lge45nlnmHv6GX7XG5eiafAjf8XNPEN+2nM12NE4/aDtxU2qfUjEsYlnH5UJCVOTJmTeFhFiqxepNMfw7vxm0xL3rtd1Fyk9VQt+EqU4++hWztH0DybUm/yeqmcTPXfUOqHTNm9l1Ku8qfndV3UabNs+YUq4LYOzQ+clM1Fzv8SKI5BQ6gE6XP2jV1sjogI0ASjj5jIptsrBF2hxHM8e55
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(53546011)(186003)(26005)(86362001)(83380400001)(55016003)(7696005)(6506007)(9686003)(2906002)(122000001)(41300700001)(4744005)(8936002)(5660300002)(6916009)(52536014)(478600001)(54906003)(76116006)(71200400001)(64756008)(66446008)(66556008)(66476007)(8676002)(38100700002)(4326008)(66946007)(33656002)(316002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zWwJ+y8rph3fe1IynzcVPidYrEGn1x9JC0PGq6Pv1rCwQRgT6YNBbaI2NY4g?=
 =?us-ascii?Q?V8LNshOt1U1kbEsU9L7Wkc95CeXrYsTCcfsTgTpjioB1XptOXcnBnpkm+dpM?=
 =?us-ascii?Q?P+ht6Lk7sqkpcpZg7YG4eGROaWMZoU3f7aGV1qIxSg3/ZwuD/CwCGXvSPuoC?=
 =?us-ascii?Q?4sautqEWnJuJVFv7gp9OWElw1nVsJomA6MCNpam6zxLs1LHBwVl2T9nbDm6K?=
 =?us-ascii?Q?DSgipFBQ2MoE1M1f4owJ5ZGo7muWz1AlyG4P751I8cX6dWz3PaTc1vLcywau?=
 =?us-ascii?Q?b4zsn0uU91HoZroMieucO+v86OYAhEejKx+PMXYGwu3vPsz2cKJc1wNh46s0?=
 =?us-ascii?Q?SzZcj5Z9Pq1gLKjlh/lD6fnuWhzgtYJ5wEBqlx7FkzSyUcMGt8/RJ1M+4PkW?=
 =?us-ascii?Q?lO1ZraEtc3p3sx1FBUT1ZK26vjH670NKYPs1/NYxwTNBvDIOlzjtrsLicDho?=
 =?us-ascii?Q?DSiiPgR1YMo8LiItivnSGdaL5avhsJ0qsrLwsZdift0bEIi4tKdDu8u8jeLZ?=
 =?us-ascii?Q?TYUkwNvmdeFK9DqlPwQ934CUhDnrW4JFS+2HSui8R6JJcpxfT8PF75q75GVB?=
 =?us-ascii?Q?sS0q12Uz7D4SFbA3UJmzlX7Z3b0vAJTKUZl2TkHLHvhRsgTcruo7FL09SBu1?=
 =?us-ascii?Q?COoDR3qmaXPDUAW7YtzrJdEmf9igjsKmk7De3eo8K2cWJh/IRYW9mcXM9usN?=
 =?us-ascii?Q?FB65eBWPzHzxWOVSWBB+7rXoVHuXCt20yxKJbjBAhSfnjYd7OgwCIMA4I68q?=
 =?us-ascii?Q?ciYBTyeLfDUhHlUtgjqvRZSXNWTOG6YO+aWz6K88XbbDqvk81Y6dR/FgYdqp?=
 =?us-ascii?Q?5rr5HoXpESwPsKOyL/KRNuu+gqcE6ZQVkbwocPpWuDjm2bzvjjXEa1zVwroh?=
 =?us-ascii?Q?nRLfQ9Qy/Mo0vvVd1owvf/KZsi2aw8pAFAEDUlgsh6JyIrMugVakRQ56OBxv?=
 =?us-ascii?Q?5GCK7ELeh6OA+ZeshtucXTRdeSeGLrL7s/AZn3muiOMvOC9ppj+NpVYMdj4b?=
 =?us-ascii?Q?IOOWlBqbLAJ2AtDs38CtYPkXXTywqif1SfzIKXLLci7ydN+yq0KNi+khbDxL?=
 =?us-ascii?Q?CEoCUndAm/XWwIRvnfbhWn9U1QFyLF7mgDdXWVU9Q+IneeeEGhaDt1oHvw5+?=
 =?us-ascii?Q?P2wMeYK00AG9KSUYJxIwkMh6TX+iB3LZX2gkWxolmQwNNEK7r40Uxw0PyiIX?=
 =?us-ascii?Q?PqWuJRG09Hc+4iFbF0ImVauDJ6dTrzEn9t1UprXH36aIyT3DEu7KkbaL2afD?=
 =?us-ascii?Q?8GS1PoVloHHmExY6n6wJgmEQ1Eg0VoYNcDgaIEvRB9HGvGjLhGdc+sIIJVRU?=
 =?us-ascii?Q?fxvVYebXgiHWgB9hx2sktWNNIhH28s0V1+HGxniUEoQjauTsyxeZhPcpCG5/?=
 =?us-ascii?Q?FHJwxpVXKiiJQ+17+6+aTex4eHWuEsoganEnD28S9+T7W7Jeb6FSGw84e2mP?=
 =?us-ascii?Q?hEGcwea5CE+bFmIbfFSSwakjiGf5jFmAwudwKS9DilEpkr6Ofp3xRFvVLVPV?=
 =?us-ascii?Q?KogYe248Vo1THW6bWE9Zvb+aZgsvSWpDtDfC1HI2vY3UATVCxSu6HVkmfDT6?=
 =?us-ascii?Q?bnj76m83RkWoonMCdwyeIOdHUsCeq7RglZ3hnAya?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce009582-8ec8-453f-95c7-08da62def29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 01:44:51.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wbk3w2LWkyO5ey+xvPB33fqFlypvcL4hXRVMtcpHcBJy4gxOZcGVp9l5XcZd6CHk/BdNNcDaZwtR4xlCd9U8wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Viresh,

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Monday, July 11, 2022 9:40 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> Sharma, Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu releas=
e
> and acquire
>=20
> [CAUTION: External Email]
>=20
> On 11-07-22, 01:39, Yuan, Perry wrote:
> > The amd-pstate for EPP mode is under testing, I will push that patchset=
 in
> a few days for reviewing.
> > If this patch makes confusing, maybe I need to move this patch to comin=
g
> patchset.
>=20
> Yeah, it should come with users and not like this.
>=20
> --
> viresh

Thanks a lot for your feedback=20
Will remove this patch from current patchset in V3.

Perry.
