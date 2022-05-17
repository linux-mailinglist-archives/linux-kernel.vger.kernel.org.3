Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E124529FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbiEQLAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245036AbiEQLA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:00:28 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5E49266
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4P0ZlDrmRIeFF6BrM+gTy4JPB6JUADIpWAd/aJ7t2dFfs7sb0EcACkUgVapHu0TYk4a12f+x7KvnvELB/8JTtyhyy+rcaUPI6Gd9PzQoHweqGdiakQWAzAyxXq8B8XeUHhhRUHascoEZAcW0p/T/OQtzeg7472InjyOaglMokAhq/5KHw5EZyBN/aC7RYNZhj0DC6Nx5LBD7URwjpE0Ka67pFuwZhLYtz5Ou03u4eF6A4F1WbtcqaiLyqvVRrRtqel5SIKnsJG4jI/Hnijr57a0grSrK/xVioA7GQPvf9hOKX72Wn7KICPnn5Dq8zaqS8+T92DsjLT7SVvqGCB9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMpAwsmAd0fiBnmlBVhGTIEgwfumrLk9KI+kjMVZ6AU=;
 b=IV4QVyo91j4zKM9IRGUyCUuT0NqOOeJXLL4Y3YheQ/MqpPit8vGBGbpPEuXS+tgtgqYvQvgvWQYMJQD7o66PPm05IwVUlaYbeZsSlVTt3zoAOR0Ny8RwkuL5nB4k80hdTEY7n4Brp0cWq6ghxxHTenp/LiJmu3yhpfDV0DDYcCYSnGkiJGGmE4BbJBnBkuPrsVbarIUVryrU7flvKCdJYNmo9OAv68jd3rnHzenlyRpQmFqOspXqNnNFA5G69ADqdz9QAFXzeNkPOVzCv+m2S0AlgHBvomBXgBsSV8z727gOYXcqRQMsU7n9nrdbL2S0cTDc8AQw59SxgzrrzRLBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMpAwsmAd0fiBnmlBVhGTIEgwfumrLk9KI+kjMVZ6AU=;
 b=KZB+ivFkHsIBFXHYeZ3t3UpLhlfvtCesd0V3yPx6Y+ekk7CXvngkrYe93uT8x1cPC8mMAC0H8N08AQuyHB91HO/6KQN0axDdzEtWaS15vO+en8z/1Rg2y8I1f6tOvCGYanAn3o0SLZwqKBe3DFOKYloamnfnX0jktivIg2EeRcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by DM5PR1101MB2282.namprd11.prod.outlook.com (2603:10b6:4:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 11:00:24 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::f8c2:3f6c:3211:7b29]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::f8c2:3f6c:3211:7b29%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 11:00:24 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: fix use of DMA_BUF_SET_NAME_{A,B} in userspace
Date:   Tue, 17 May 2022 13:00:17 +0200
Message-ID: <2386810.irdbgypaU6@pc-42>
Organization: Silicon Labs
In-Reply-To: <ca9866f0-622d-a55c-ded5-48b32340de51@amd.com>
References: <20220517072708.245265-1-Jerome.Pouiller@silabs.com> <3847797.kQq0lBPeGt@pc-42> <ca9866f0-622d-a55c-ded5-48b32340de51@amd.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MR2P264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::24) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50907653-0db3-409e-7989-08da37f4719d
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2282:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2282DD284E2E2C0454B5914593CE9@DM5PR1101MB2282.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DB88u/hWhHIBeP41OfpPMcvEIPhPK7OattmUi1M6bYsYRmvWvNgKhH7+/aUYaJ4Hkys0/aBStogTQgpk3w/7GrclqiE9yL6p22Hk00l/qv8bfq49W+bg5zWnkqE1HmnWI4OImy+YfniqAPO2uyg791U4M0geBfrH39/zsKJc5EUfjF9Qk+V3XCw2zX4NyGpaav/DSkb+u67Z57XCn7g6RbDRL+48dJYREgcmwktBBeVxwOnoF2JOxyGvdThTI/OAD2goV1p+AOCm2O1ppxDChmJ2ig8CtRZVjH5/avoxrRY9TzUiny6+5x1nCgslHx+01g0SrqmZJZr3EGXWVLi2SDTwRzU4EsvsHmHbT7CZH0FaOJLCMAe1F2PLo4hX+j0cshaoIfsAhBYZT+JJn+8Vq4SF+78cw6/mMO3XW+JTh6z2VOxeov4q3sHUjkRxTShrva6m73L8YtRNhXx9Ni2u4VfF2f5Ck50OXXl9dhwD4kxWQb/9qPg5tEb2z4ANgEUC4DYQJ1kKYsYoio1CDMtaJreuA4P1OsYoEZ7oON4hv+jTJIVVpIf5UkwXt8ipAB9R6vsbQBTh898/lfVcTf7aJDqD8rToEgMEh7yHoS3dx23oGc1nDQTOnEHWhYYReAixvwvc4ML23GjENqWKAzfyNK6kyh2+YQQWtT0ijESbEtNSc9yCwKBiLMNqCDdiU5ZjFEI1L4HRDpjKeXSjlb6ntFcd6aVZu3EhBh4YB5ymlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(6666004)(36916002)(52116002)(66556008)(4326008)(2906002)(186003)(33716001)(66946007)(9686003)(86362001)(110136005)(508600001)(38350700002)(26005)(8936002)(6486002)(5660300002)(316002)(8676002)(66476007)(38100700002)(6512007)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QSszMVBwQkhQTkViVVk4UXRvY2JDMEhIOTRXbE1NU0NXK2lVTnpaOElrMUVz?=
 =?utf-8?B?cFBEMmJiS05XamQ4QmxIUnpZUmwzd2NCRUcvZVJWZWlZaGtNdUowek91Vkc4?=
 =?utf-8?B?L1phL2RnZmhVRklBMTZwak53NmJZTjlhMU1Udkh0MjYwazRSMW1adDlOeDBo?=
 =?utf-8?B?d0FObjRPeTVHeEtRNFM4aXQ5cW1odnVDaTQwQm1wM2NnME5QTHlTZkhUNXlD?=
 =?utf-8?B?ZG8wU0JhT2ZCM0F2aFl4TGNoUTY0RUhFM21zZzBHSk0zUlpkcUdUZGlnN2Jt?=
 =?utf-8?B?MEx2cXU4Z1dUdFFyZmFLM2xqNlBGU0xmcXhDWDRzUkIwMWJDdFJKd3ozUGdq?=
 =?utf-8?B?U29tS0l2b0ppZ0trSUhzYlJXRDlMLy9CRk05N3FwdXUxenR5b3o0SFkzTm1R?=
 =?utf-8?B?alRvWkF2dS8xTUFHTzhzOU1TNVFwdndkQng5TkpIelpkaVFiNU9DZzM0N2x1?=
 =?utf-8?B?RHRHajN2anNxZzFvZlhlbkhFSDlQRDhabG5CcEhwK3EvcHdCbUV6eUxNSHNJ?=
 =?utf-8?B?ZXJqdmNCei9lY1MydE9wQjMwY2JLTGVXSjgwRTN3TmlvMVZsbEthZ2Z4aEgr?=
 =?utf-8?B?M2ZFbjdvUy9GQ3FsT0gxVHpiTXB3dVRsaWxMaVpLRjJZRkx0QTU2dFNrZVhS?=
 =?utf-8?B?VE03VkUxcVc2VkNkSytWMW01cEZkaE1EMmtxTHJVeE1SNGthVFdiclhMREda?=
 =?utf-8?B?OFV3bzQwb29uZXJRai9BSVJrWk1ZZnNXM3paRlJ5NmxmZVlJbU1lTDhVWnI3?=
 =?utf-8?B?RkMvQmthNDBsajN4amc1cVFIRHRaaFp4allDMHFBalB5U1ZhcVE3R0NEWjZn?=
 =?utf-8?B?Ky9CanBWNThmVHJ5elhGd012OXZOYkZ1ZWtXNnkrcXVrcE9KcWR5TUlNY2w4?=
 =?utf-8?B?M0U4TStYUjV3aHZ0dUcxc3NsQnBHc3p5Lyt2c21CR2ZoUXA2M1NOTVo5aldU?=
 =?utf-8?B?MXNxRkovMllIMi8wUFc3bVJzQ3J2V1YzNnhwL0VLcU1wenVkRkRPaFZUVkxK?=
 =?utf-8?B?TjhQNWg3Y3AzVkY0NFlwOUlZd0ZaalJ2dTdPTnZXeXBlRmVIWVBML1BCTjVB?=
 =?utf-8?B?ZGhLbSt2UldTMjhNUGVmK042d0Vib0RrbFB2U0ZUaURmR1hlVXdiMXBQaEpt?=
 =?utf-8?B?QzJqc0FZc04xT2RZS1psZERrTUlwT0czOFR6Qnh2R05qQTdSRkswNEZUQVU0?=
 =?utf-8?B?UTdobGEwTFpzWFBtQXk2WXNZZ1hyUkZsVDJtU0dxRC9RaXRVZ2x6V2EzeDR0?=
 =?utf-8?B?VlZyZkhVeTMzTkc5bVhITE44VGZyZ2tZbno5cGJZZDZqeXIwbktjQW5xalRl?=
 =?utf-8?B?Rml5SDdsbjJWMG45L0dNeWVuWU9CbXBNUEJVcG5LSUh1WUF3K3BVZERLQWk1?=
 =?utf-8?B?cUZmOHNtNXpscHJhOWdmbEFzTmUxZStTQkY5alhqMmVoNkxGK1BCVmRLV0ha?=
 =?utf-8?B?Y1F5NlF0TUlnV2pwaVRqWFdNVGMxcFp5TVUrc1NyZjNnYXZPdGRPVC9IWnA4?=
 =?utf-8?B?WElxY3R1ZXRTUTN2SU9iQng1YWRkcjQvanRkTFdvdHFweFY2bnFzVHlzME1K?=
 =?utf-8?B?U3Jpc0ErZEJweWF3NGN3Uisrdll0OW9RSkZVeFIyTGlVbzYwcUw0ZVBOL0Yx?=
 =?utf-8?B?R3RpN0xuMGdYeHVta0VhL0pTU1pmeENLdjZycXc1ZFlFdGhFTjJCVW9oNitz?=
 =?utf-8?B?WlZvcnlNc1pZUlNLOVdZMGVGSHlHV3pZSWc3RTVBa1pNTkgwbGozcmVlVUc3?=
 =?utf-8?B?aTFmQ3lGR3FCQldFdkpZTVlxeS9helNrQUREVXJHRE9iYlNrWGNzVWdZcXBC?=
 =?utf-8?B?aFFCaFZFL3h2TEQ5UzBCeldGamoyV25pcnFac2g5OXAvQzQxMXl4TGJkaWM1?=
 =?utf-8?B?Vmtnbk1nSzRDOW5UWXFpd21lNlc2MFB5WDFudkJGWE1FbFlEUkV2V21WcEY0?=
 =?utf-8?B?QXdyaWdILzAwNU1YVXdpc2lxak1nWFo2aXpFNkFrVlpsWmVKZzEySHFKQ1Rl?=
 =?utf-8?B?RnZDQ0R0QXUvK2tTb0dKanRSU2lpNjBrVlNacVFQZDNjTmF4b2E5MERKUWRS?=
 =?utf-8?B?Qkg5dWlndm1Jc201ZW9aVkROaytnMElMaVVaUWQ0dExhdzlKcGh2VGc1UW5y?=
 =?utf-8?B?akU0dWhzWnFPbWJVQTJiVjkrdlp5V2ZTWGJqeGlqbWlIeVhKY3ZCT3R6Tm9K?=
 =?utf-8?B?Rk16ZXY0UEdmOGF5Ui9sOGlrTVJidFhOSFRsd08rblFVUkZqVkhEdUNMQ0xF?=
 =?utf-8?B?ejZhNHc5ZlhySlpnVTN5Ykx4N1FtNHdtc3hyRG8xMVFXeXJEZ2tKRGo0RkZS?=
 =?utf-8?B?WmpsQ1BMMWFSeWNJSjlNMkNYV2k0TmdTT1dRY2tyVC9zSVJGd1M2Zz09?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50907653-0db3-409e-7989-08da37f4719d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:00:24.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QnUjUhkqbk+TDD12zO4EtlsbZjYx5RXCd8MvTGCwxZqlvQZQSnL1k3ocJ83tYgBjOc2HUwrWds+69ILc8MNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2282
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 May 2022 11:37:27 CEST Christian K=C3=B6nig wrote:
> Am 17.05.22 um 10:32 schrieb J=C3=A9r=C3=B4me Pouiller:
> > [add stable@vger.kernel.org to the recipients]
>=20
> Well, that's not what I suggested :)
>=20
> The question was if we should add a CC stable tag while pushing this.
>=20
> Greg might be complaining that you shouldn't CC the stable list manually.

He did :). I was indeed unaware of this process.


> > On Tuesday 17 May 2022 09:30:24 CEST Christian K=C3=B6nig wrote:
> >> Am 17.05.22 um 09:27 schrieb Jerome Pouiller:
> >>> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> >>>
> >>> The typedefs u32 and u64 are not available in userspace. Thus user ge=
t
> >>> an error he try to use DMA_BUF_SET_NAME_A or DMA_BUF_SET_NAME_B:
> >>>
> >>>       $ gcc -Wall   -c -MMD -c -o ioctls_list.o ioctls_list.c
> >>>       In file included from /usr/include/x86_64-linux-gnu/asm/ioctl.h=
:1,
> >>>                        from /usr/include/linux/ioctl.h:5,
> >>>                        from /usr/include/asm-generic/ioctls.h:5,
> >>>                        from ioctls_list.c:11:
> >>>       ioctls_list.c:463:29: error: =E2=80=98u32=E2=80=99 undeclared h=
ere (not in a function)
> >>>         463 |     { "DMA_BUF_SET_NAME_A", DMA_BUF_SET_NAME_A, -1, -1 =
}, // linux/dma-buf.h
> >>>             |                             ^~~~~~~~~~~~~~~~~~
> >>>       ioctls_list.c:464:29: error: =E2=80=98u64=E2=80=99 undeclared h=
ere (not in a function)
> >>>         464 |     { "DMA_BUF_SET_NAME_B", DMA_BUF_SET_NAME_B, -1, -1 =
}, // linux/dma-buf.h
> >>>             |                             ^~~~~~~~~~~~~~~~~~
> >>>
> >>> The issue was initially reported here[1].
> >>>
> >>>
> >>> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> >> Good catch, Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.co=
m>
> >>
> >> CC: stable?
> > Done
> >
> >> Fixes: ?
> > Fixes: a5bff92eaac4 ("dma-buf: Fix SET_NAME ioctl uapi")
>=20
> Going to push that to drm-misc-fixes with the Fixes: and CC: stable tag
> added.


--=20
J=C3=A9r=C3=B4me Pouiller


