Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE71511391
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbiD0IkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiD0IkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:40:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55154474F;
        Wed, 27 Apr 2022 01:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=entV1OPfnp5vANpATpsJHUvCo4/ZXT9JnIp7EEUuN9ZY8mtZu0VL3q/biA/WbkbdTYqt1mqbuzF844j0BfH2WKo9ywsNJKAgkTk9DUL58jiVanYc5q+ihh5YcoMbUV8pISjuRyVPOUpkdxungyeKD9aBFr1fMO52N+tkm+hoP4kiR//IvBR5t4itGpJgpA9UGfUQ86KcDiolwTVxOGaildQP7P8Ul5AOggYSeWRK5OsO5fjbCg+Sa7rYQxmmIfvJyxS4Iqnus1Xnv7DsDvBX+/T0O6JbZuY6lLIl7qAcZRUoUUtaBQXvJp6FSoxmY+3j1u7p7o5DwNx3AlmzV5kx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmRtlrfkIFIfDsrYsvUiieMZLo21+zaHfe9u2UOewLg=;
 b=WWok0V++wgzhT3ufyDioMUIhAPayIJwhd8ZpsXzZZpNlYIZrLpRRQjg2l43AXEwiMvs07P5veJr6XhZYuWQbo0CWTH1DN4nn2q9mILvJON8nFkLw0AhHNCOpf5pk0ZCJlreMPuGC3B1GEaTs1owHjAfNvsQSCxEzrOv33cYbicRM21JjnKwqwoUdZVVLt2Rtnuc+vcAXnS09o+yuhSkvpO2VmG9pRY3CB+Ca4BYr5822QNOF8iAolCkbMMX6BdC5aFZkdv4hF6pJACFFUqIMftKoNWNOidfoPgO7A6LJK/z533wdxOwYyfOC6qoezH9HZ9AiX6Vd4IYVcVU5KtW67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmRtlrfkIFIfDsrYsvUiieMZLo21+zaHfe9u2UOewLg=;
 b=OONV55wfw9ekNPLN98uFWoMrlxYmU8BgDnG6UFogvDoa/j3VZkq1lGE1MC7JJnANsUljFgZ3omtrnsu6d20Jfm6qzm1HemnIGeNGWibCzYlKvNUmnI7cvQ17wXA8SmfEVTW0QCuwf89zBnVHt7m7JPZD3rXZH1NAF1OHhLpBVn0=
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by HE1PR0401MB2266.eurprd04.prod.outlook.com (2603:10a6:3:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 08:36:59 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::587c:b068:1987:da36]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::587c:b068:1987:da36%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 08:36:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 0/2] remoteproc: support self recovery
Thread-Topic: [PATCH V4 0/2] remoteproc: support self recovery
Thread-Index: AQHYPmf++LGhIClrIEWGGPn9m1AHwKzqSoNAgBlcR0A=
Date:   Wed, 27 Apr 2022 08:36:58 +0000
Message-ID: <PA4PR04MB941647A5E0E06DD776A1A1F588FA9@PA4PR04MB9416.eurprd04.prod.outlook.com>
References: <20220323034405.976643-1-peng.fan@oss.nxp.com>
 <DU0PR04MB941780AEF9B375294283B75188EA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB941780AEF9B375294283B75188EA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba124b7b-e14b-4f51-fee5-08da2829181b
x-ms-traffictypediagnostic: HE1PR0401MB2266:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB22668BDA38D877C1D16C0D7D88FA9@HE1PR0401MB2266.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKB9O1pvH5AuMpwhsE2mOGnejDBQzS/8+gfas0rATs96Jpx9dZ2gdjLRJCf5sWmiuJLLjQNODL58L9g/V/NAH6DVLHmnbgMLpebZLxT8Dyu/D3qjkZQ+v9BXpg228RPWTrUBKkU5uf07TT+9f2Dvlw2Ulwz2MauZMJTTs2ikh1WhX2CUZgd87Tud2oWtH2v3Wi95ppRIcZU398HaZIWgzaXZCxQDQSfVVUqW2JXVYo3EaD0M/UhCbzX/hkNH/Tn+ekMoh6IWk/GSxiojWelmGP1Aeym3inXgs2goxexbito4N2iFsw8WlnnejuMY8gHwnVVg/RNEVAGtCQHCTUDY9C+XqVqRZSAMyM2ayd+nEpFz4MpidLMqX98ZD4m4+Jva7XrckVrDRwqfAXL/n2FLYmcdPoqd6S0o0LZp4iGUgsGD88QDOtMYS37bNDu5fQUILB8k3fZYvk8FdjfRc2jKdvhNNFnMzKivhUT/RdoIWQRvKV4ch/iTQXm7gQt9Tj3gGxfI/5ld/S8piL0QfEtyV7KzyvWY2ZnzdNekD8H2pdxMt7yPoB7jxTLkFxs07ph/KmmcVBdiSY+Lcz4o9qtQbvTDiKLqozPgKtXtKjyeBvLI3rOZheK60B2fnOYDMq1iyakGhs0rnva1lNrVBPRt+ZniUrv7iV0HY7MFy0AKEpv8KQaP+WiX+gWCg9ynfMYlswGGBoRoCsCIR4Q6kATsGSG+DYkrmu4fOHx4omP0ApuLrCNb6d3wURIz8u0MT6GFXAp/2U6yKUqbnRyvUP9H0UmgDClh1TyclT7uQ0Sz7xk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(64756008)(186003)(8676002)(66476007)(66446008)(4326008)(316002)(44832011)(52536014)(55016003)(5660300002)(8936002)(26005)(9686003)(33656002)(83380400001)(76116006)(54906003)(966005)(71200400001)(508600001)(110136005)(6506007)(7696005)(45080400002)(38100700002)(38070700005)(2906002)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GTHNYAwCLl3+gQp284VWaZQrdNSPBvPxQkhjR6thVLxzMHf72qUV1wzzfxDW?=
 =?us-ascii?Q?XNVw4R6lDPBnArTELNbyq30TEW/VQWCQ8w9fT57j0zwvuyL8XNv2VdsU++ak?=
 =?us-ascii?Q?s+qZccW7frpf4c7Z2o3XgxT/bXyBMnIwVScv/EFhl99DRtaqE9HucDI2thNw?=
 =?us-ascii?Q?tN/mzWroQsIZr+my7p3elnrKfH4K17l0mCJt8xcAJ25CLMxT/igfEcvxX/sm?=
 =?us-ascii?Q?mJG6k4w5Rx0AZXQ+4ei9DALj/+cmu98399idqx8eqiO7YZcwQDo5B8S5r28J?=
 =?us-ascii?Q?IhoT9eBPEbyVtuiG2VC7O3Wm3QLoG0bzbyMcan/CQP2v7dvdcAQKJynZg2QG?=
 =?us-ascii?Q?aFXTMEPVmkIquQfff1LCnsMBbDfuPwwN7e5kfhZfRbkzb/kQfplL0Bnf+Qao?=
 =?us-ascii?Q?36IpUIDS1YA2Qa54Uyk0VL8IntfvGs63i5WmCVRpSS1LYTwUF82Prh773ObM?=
 =?us-ascii?Q?zHuYFIa4I2jFC3c8REJnDw8NVNNQ/wXTvRxX8S6FNd8ItGmRxqJijrOYfjN4?=
 =?us-ascii?Q?TKvUxDL+i4+zru5Psgge8IaIeVvNiCmdHNp71CO0y12XpKpqmK5BG/K8efo9?=
 =?us-ascii?Q?sDsC3OtC2s9H3ATy+b7+YQ44d8y1QXNawWs28dALVU/S5TvlNIPbSK+ocPVc?=
 =?us-ascii?Q?KURqNaezw7oJyVFZrMPr0jTgB+LdsMrO5JN1IWElWeP9FYPf6eiWHPyK+c4C?=
 =?us-ascii?Q?GUzo+0/pT3Pu7pNEjZIdoiyxjwnhbq68k0G8Z8u0oc/A9aF1xMwQKym2qVZ5?=
 =?us-ascii?Q?GFa0Wz4ifEN03iqAiXW4Hj64wC969RdNe1lL0j2r12wrSlCCigN5/I1TCB5O?=
 =?us-ascii?Q?X4aS9yyKGUyauf6UOWER3R1xDWuZ/d7SAOYqqCk3eqvU7T+51o7JaKU0x9Mt?=
 =?us-ascii?Q?V5YhXGjFzCE9p+q9d2NFKkWmbEbXqO+h3y5H/aMENl5aoqmhKBQcbIO2Q1Yy?=
 =?us-ascii?Q?6bW5gmxuC5KSLHIgaoe/7qAXLcUUZozIY8Uhk1uJPe+NGzA9tlTDwgREQvv+?=
 =?us-ascii?Q?JRek4AoVb3T9Xp173/whuh5EWs0owTrE0UZVEw0F8mLXOri1YUQcKovPB9E0?=
 =?us-ascii?Q?UuX1+jhH1gqx3J45IYkyQgnt3yx8jKDSQ9AwZ6z71gVlj2m+VJEkD+Hxaabb?=
 =?us-ascii?Q?ZaoPWHjfkZ5EXyK5Iy7kytzzxaUqdwZLDJZ+OOK9MxazMpMwBgEtkQQgOYk5?=
 =?us-ascii?Q?3b8NWsWmR3onDDyORe7oX05dLEU041CmT5Jo8cwRzl/GUjPSl0LptIWFZfS4?=
 =?us-ascii?Q?z4jktbnBNd7YwCW2kMzp2k7zbGn+E4QmRd/govL+ER6SZqMp2oF6/m2bBr2a?=
 =?us-ascii?Q?EIIs5b/stcdB7TMo+w+BBJ95pm8RZRMlUAz3sYeT3WLZTKmfsisjl78vsi9G?=
 =?us-ascii?Q?zRS2WURtJaGMqaXrS5FIoazcb0eitNM/kyNcbj/r0ZWCWLSSKDVGYivPYU1M?=
 =?us-ascii?Q?fn6a5O5bC4qPeTktoAtk5P0c4m+EDUHtj5L4ARPXWhjbrSbxL+mqcft9EXK/?=
 =?us-ascii?Q?d3o0pqqHDKSE283ZMpDskiB+sOiE+CgU6wzZpWjjkYMBiGg3x/HZK7maRE2M?=
 =?us-ascii?Q?Lg3e2xvF+9jgHRI8kxvebflumi3Vsdk6gfFZELVsjQmIn6z3asX8NOPWKLjG?=
 =?us-ascii?Q?vX1ceBP0PKvpRZEzrQrYDk8TdvjrTfZLiLBNXPT1agWduzsP+X6kaHtODjrO?=
 =?us-ascii?Q?i8dimFI0IvPM3PVAm9zOkCOD9TODBAJN1IyGnMMH1/T499FRA45Q+48yvozb?=
 =?us-ascii?Q?wDh25t3TEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba124b7b-e14b-4f51-fee5-08da2829181b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 08:36:58.8979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzFotLaDd/iAmhnOTY7CVpqBNbMvmwYTEdSlJj4J7vyR6vekuT1No3XcGsDy+/flEs3aDugA/dP+GT6/t7MY0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu, Bjorn

> Subject: RE: [PATCH V4 0/2] remoteproc: support self recovery

Do you have time to give a look? i.MX8QM/QXP remoteproc
support depends on this feature.

Thanks,
Peng.

>=20
> > Subject: [PATCH V4 0/2] remoteproc: support self recovery
>=20
> Gentle ping..
>=20
> Thanks
> Peng.
>=20
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > V4:
> >   Based on Bjorn's comments on V2-2
> >   Move the rproc_has_feature/rproc_set_feature to
> > remoteproc_internal.h and  Keep rproc_features still in remoteproc.h,
> > because we use RPROC_MAX_FEATURES to declare bitmap.
> >   Update commit log for patch 2/2, and add comments
> >
> > V3:
> >  Resend the wrong labeled patchset
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Flinux-
> remoteproc%2Flist%2F%3Fseries%3D621
> >
> 311&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C79b37b5586cc4c913129
> 08da1b
> >
> 7ad5a8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637852511630
> 263603
> > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> JBTiI6I
> >
> k1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D5dxwnc716qj%2FQc6TzayLIn
> %2BiMJ8
> > oSwksVUIfmw6atVk%3D&amp;reserved=3D0
> >
> >  Write a cover-letter
> >  To i.MX8QM/QXP, they have a M4 core self-recovery capability without
> > Linux loading firmware. The self recovery is done by  SCU(System
> > Control Unit). Current remoteproc framework only support Linux  help
> > recovery remote processor(stop, loading firmware, start). This
> > patchset is support remote processor self recovery(attach recovery).
> >
> >  In order to avoid introducing a new variable(bool
> > support_self_recovery), patch 1 introduce a new function,
> > rproc_has_feature to make code easy to extend, cleaner, such as we
> > could move "bool has_iommu" to rproc_has_feature(rproc,
> RPROC_FEAT_IOMMU).
> >
> >  Patch 2 is introduce a new function rproc_attach_recovery for  self
> > recovery, the original logic move to rproc_firmware_recovery meaning
> > needs linux to help recovery.
> >
> >  V2-version 2:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Flinux-
> remoteproc%2Flist%2F%3Fseries%3D621
> >
> 311&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C79b37b5586cc4c913129
> 08da1b
> >
> 7ad5a8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637852511630
> 263603
> > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> JBTiI6I
> >
> k1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D5dxwnc716qj%2FQc6TzayLIn
> %2BiMJ8
> > oSwksVUIfmw6atVk%3D&amp;reserved=3D0
> >  Introduce rproc_has_feature
> >
> >  V2-version 1:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Flinux-
> remoteproc%2Fpatch%2F20220126085&am
> >
> p;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C79b37b5586cc4c91312908da1b7
> ad5a8
> > %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378525116302636
> 03%7CUnk
> >
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWw
> >
> iLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DeMRjdCSvLJrnvtS9QGUQYnr%2BtUPJkS
> RSryJ
> > p6%2BvvfNo%3D&amp;reserved=3D0
> > 120.3397450-1-peng.fan@oss.nxp.com/
> >  Nothing change in V2.
> >  Only move this patch out from
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Flinux-
> remoteproc%2Flist%2F%3Fseries%3D604
> >
> 364&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C79b37b5586cc4c913129
> 08da1b
> >
> 7ad5a8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637852511630
> 263603
> > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> JBTiI6I
> >
> k1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DeJSTzHgK7eMYgLoENZ1dfZds
> uj9O6kj
> > aPyBm61WDXpM%3D&amp;reserved=3D0
> >
> >
> >
> > Peng Fan (2):
> >   remoteproc: introduce rproc features
> >   remoteproc: support attach recovery after rproc crash
> >
> >  drivers/remoteproc/remoteproc_core.c     | 67
> > +++++++++++++++++-------
> >  drivers/remoteproc/remoteproc_internal.h | 10 ++++
> >  include/linux/remoteproc.h               |  7 +++
> >  3 files changed, 65 insertions(+), 19 deletions(-)
> >
> > --
> > 2.25.1

