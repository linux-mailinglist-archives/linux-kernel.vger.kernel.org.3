Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D2E4FB32B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiDKFVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbiDKFV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:21:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A70B0;
        Sun, 10 Apr 2022 22:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY3KCiu0hj1hDyJuG09upnjbky2MNB8C/D1+tcXZzRfFtCde9I0OS+y3nGouo2WldajSbuMTxbz6hb/8nKT7aoXjmqIxTDyXEJtOB3U3X4Mp3/7U4OkcRU4AwZoWwK4KdkR6MRqDaHCUD8LqTnVv5LlLaECMXAcrbzQf6Nkg6i2Q8Y5/dAzKaRP9qFlbMWbGVyU08ebUKyx+GOkw8DkuEa9gwcMJ2NH+ZVdq+B/HI69Z27P+M4IEpj0FAX7izLCWuvMwFag+Jo+DAVPTagyjJFBabeT1w8UaPW9pyu4Kfx5E1hJXegHNCV3FNIEQnpUOIbmMnywkFgx9VvKpDJa/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiYcWI3hoHROwhtaUlDzbzGkRZAPVq4cs6zqwjoq9eY=;
 b=NsisK1wVtS4KByPx5pT1C0XHAt/3Pkw+P9kk/cChRcttA152zV+Ia2nie2Y15WoPF+1biK9W+ih7IdRn9g7S73YUMz9R7t3/hmDMbeCXo1VKPwlL4yARZQqZxujzzDnYEI5IEqqTW/dTfyS5BSTXizgRBBUXOqQcJwkhpmSPc27CneQM4sHmEHLBUBrd0W8uf/0CLt5hKF/nWeviDRDKb0PFG9X/m3U/dhqM5rBudnjIoJOCc7sp1X8n1ca8SeF8F18e6YA1F98AxZAcO9FWVoDt6v21JVyLcNOmMd2GYXNTnUeksBTnvBZbfxZA/Y6yDN7jEizIGF07Mh0n0HXCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiYcWI3hoHROwhtaUlDzbzGkRZAPVq4cs6zqwjoq9eY=;
 b=oWg2yV8iVcBoC0crnVLZ4tfy4ELJIKrAU1BcSUkpZzynJmF8bnemubFc5Jv/jPSQe2VMiF0I5CRrKaUpgp2z6nX1VK4Tg1BXrpi74uVCuW24nF8mt++NhAiey02kcMn/qyY5PoJmn+akFUdlJ/p2Q/aD/L9zkDSknOkE3804arM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR04MB3159.eurprd04.prod.outlook.com (2603:10a6:6:11::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 05:19:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 05:19:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 0/2] remoteproc: support self recovery
Thread-Topic: [PATCH V4 0/2] remoteproc: support self recovery
Thread-Index: AQHYPmf++LGhIClrIEWGGPn9m1AHwKzqSoNA
Date:   Mon, 11 Apr 2022 05:19:08 +0000
Message-ID: <DU0PR04MB941780AEF9B375294283B75188EA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220323034405.976643-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220323034405.976643-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92f9f49e-0296-4136-6739-08da1b7ace28
x-ms-traffictypediagnostic: DB6PR04MB3159:EE_
x-microsoft-antispam-prvs: <DB6PR04MB31590EBA853380591CE403FE88EA9@DB6PR04MB3159.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Fgdmob811SEIgNgMRBeExCOwIkIUn7maOdQ0jY95ljO/3GGNezWL5OxwRjnIg4KdIsIcbw1SfIizxR83Eqj1JCPdRtInOcZkIzF9q6O8ySbvigWvTnGoDBAZnT8S/D9vLW+zv7+Uksxg6OQf1f5sUL2iqtoRzzCEbZSlxE528WRtBSqTYBL0VmPq/NPbGtj6E5PMuyC9lm2vDWnJ6b/XtLepw8YycQvusu32s7sGKD0t8rp8StIPcjQIw6UusArimzSMcQQudyyaRNpoyui2fFtR9ajJsMBWjgZT935t0Zc6zb6Q3I9Wy74FagvVZOjKiRT1DVV5Py7NFf5O4Vvg9rWNf87/VV3NQcsHs1OZgrvmrXAevEOQsm41EGXKVPF7N9QzKY7x5cyE4vy8rC6ACTmWeUBh84lu6ENaRUq4vb0eRkcUemqusOaVR4CB6VT+oyLutJhvH7MQA2gv0xsqI50iP8B7yTFhFkF78N7G8vD57g4z2XaQrwiYZhubHj+xoS69O5icrjCQ57sbPCHFjQm1uyyI+TofjyXOgnidVIlFD7ek8qyExJiq7SNWQMDyX/NSrbFN2GKibin+nMSARa5cL26eiRfOl9KNYNAU9w607h8KGzbxMT/H1zAkUsPi1kO71KNvxRB4rADMVe6kZthfJt8lEMHDDnHl3EW4m8kiX4hvVamF24xRjcWFwAcde+hcrtAUHmD129lmQ6fOA6KYSHd+6Kao/3VvzOFC0yxC5b9SKqRS+4JKdk/SZOIcFO+Z9+6slpxq7IMq6zi3KWvkC+8EiG5RLrH8UmieR2WEgaaNjqfNPzL+4x23g1EA88nif5ee8Y9oIXd8OldYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38070700005)(52536014)(71200400001)(316002)(6506007)(8936002)(86362001)(83380400001)(966005)(38100700002)(2906002)(66476007)(122000001)(44832011)(8676002)(64756008)(66446008)(66946007)(66556008)(76116006)(4326008)(7696005)(508600001)(54906003)(9686003)(26005)(186003)(110136005)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xVsCr9jm0nPjk6euzDmCYNb/Upn2+cR3Jwa9u/bqVxHCk9jNWJi6sStZ3roF?=
 =?us-ascii?Q?IuX50rpkZY3pSDBWoWjP/5H+3eKthxN55gnCpjA2Z2ZJGlQSzne/p3NUvBV8?=
 =?us-ascii?Q?pWxtjAr1nWlPZ0GpJCLqnxRPfdcNDILRwweabETuZbAH5az7QWMrE/+PDhx8?=
 =?us-ascii?Q?5Pt4NpNYSDooWi+bWZLjwMNKjCIe0IISduqccSDQ4nii6bsi+4DbcuQ2BW0i?=
 =?us-ascii?Q?xjX/iPlPu4uzp2IP3r2ZezgzJLu1PZ0EcqFEgTElRWAx+dyfkTA42oeSlIGY?=
 =?us-ascii?Q?ftQd5lUATcl+lHGCz4GcbE18jKi4rHv4d5ZMc13QtNVy6m1KZXUF43AcWT9L?=
 =?us-ascii?Q?EISY8ZaV7rdvpGgY1lRF2QAlelj/g21Sa6d8naVEDQUrgNnfJI8kUQLvso9z?=
 =?us-ascii?Q?fVohNwKBqLbVxpKaQE1klhCVnG7IFrV7f5sK8vh6GnDYMbJ1/VYc3GO2SP44?=
 =?us-ascii?Q?g7sC69V/zgn7k6kZbrAgxvge3qMLPibK72uEcgNl9lpKtsIN2GAx/Ovjoy2L?=
 =?us-ascii?Q?cbn5BqJRgkH35mRcywi/ZKUXQuDsCFk2dW2dwj8UMjQG3SLsPXIN3zUeTbzt?=
 =?us-ascii?Q?u1vfg4KHAV5deF//NURUC7y4P2xc/mh7BpjR0FbqbTwgE0MrtsBTlSOK6Vgq?=
 =?us-ascii?Q?zsYMDn3NpYP09OOg6em8amc67uVQx6H/n9HG16LwVcO93mz3FpqIO5wcn5tv?=
 =?us-ascii?Q?KpfUBDkSTwxXZ06sAsdHZpqone7VSFIcNZWACvW2MVj9TmBg/i74eZw5Inio?=
 =?us-ascii?Q?ROJ3aN02TXK/G0GaJGDEJvOu0rEHU4/eUw6bLlz0wfJibCXHhsozHergG+Sn?=
 =?us-ascii?Q?4mVaMYOhCicgdyF2U2DKtnCJooeguKeH4o2xhmZLlQ1qT3zAxuTGoJH/S6VA?=
 =?us-ascii?Q?pbXtAriq/xn+X4G4WMP8/J3KsuKMLH041sqP7qgk2aSx2y+RSw7Gk6kuYOKQ?=
 =?us-ascii?Q?D8aRKUuAoJDCwNI0Q9yF8mlEYaUxWF0TpkX4ZfqYtBvRQ1VWB55SIQp2nCnO?=
 =?us-ascii?Q?K3RwwHVlv+bXamkV5mSrv1hw7dBxQ9FVfdEQtcgUYtPeMEgoVZMPGNtKCT0f?=
 =?us-ascii?Q?ci+rm6QixJeWx24YaD1KoDYKluD85MUNBCAd2R5LTn4E3bL4siDOkIdXfQOM?=
 =?us-ascii?Q?kjGebddizZQbDOtM9jqHutGdKE/T9HVCwHTn5Kmvi2UfxbGhYedgwWKF7OC6?=
 =?us-ascii?Q?Fg0KkKpSL25+O0G3hg0Oe2APPqxSmjILSihoEGuJJ8X/raMGC1w4hqzY6Zno?=
 =?us-ascii?Q?d3J5omDzFxDXLNkuFgBPwWFZHbI9e2PNxRmKxGmtb5k8e9XWxtJyzEghzCdU?=
 =?us-ascii?Q?5JozsHyxel25617Xxzpy9xneRYu0Nrp31KDNFgTDyi6ed88n8i8jVGU9D8cM?=
 =?us-ascii?Q?bR9ehPI5TCRMhh6f1gJyQF1ADfvGDGe4J6PJSF56mOC8lJgStaIayZ30/bU3?=
 =?us-ascii?Q?/M39NdTZEozFFAnTSlNoRMl88PBy3FHHbL6AK26CtXIqyJyU18xx9y0djM/P?=
 =?us-ascii?Q?bq0pM5q1Uc2VNzJtpYOSgwP9721LsKeBJ5+/OPwYszNKIO5rQS2n1NXMNqWI?=
 =?us-ascii?Q?Tt2noxUqtQ0PGs5F93GoQs+SPbjoSGgof0mzx2pwsgCqAKLbeGmzEq2YpY1a?=
 =?us-ascii?Q?4KZSWaqtrO88zCwY9HFL9sv4GsG+0I8JmbcgS8KXCAKC0e58EDXln24kOlaf?=
 =?us-ascii?Q?vSCsqLTNFPBgHOZvGPaPD9M5/z4n7y+pT+Sw9+I4u0iEHCf9XSH4kDUGmG/T?=
 =?us-ascii?Q?ImFFJBCm/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f9f49e-0296-4136-6739-08da1b7ace28
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 05:19:08.3811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBJRruDa8NVJRxT9qdwSBsfb6+fe6x1O7hxG9wT/oA81qdnV9gtZuTmcOnEVdzl5VNLdo92hP2Q0Hmvlrn9DXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V4 0/2] remoteproc: support self recovery

Gentle ping..

Thanks
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V4:
>   Based on Bjorn's comments on V2-2
>   Move the rproc_has_feature/rproc_set_feature to remoteproc_internal.h
> and  Keep rproc_features still in remoteproc.h, because we use
> RPROC_MAX_FEATURES to declare bitmap.
>   Update commit log for patch 2/2, and add comments
>=20
> V3:
>  Resend the wrong labeled patchset
>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=3D621=
311
>=20
>  Write a cover-letter
>  To i.MX8QM/QXP, they have a M4 core self-recovery capability without
> Linux loading firmware. The self recovery is done by  SCU(System Control
> Unit). Current remoteproc framework only support Linux  help recovery
> remote processor(stop, loading firmware, start). This  patchset is suppor=
t
> remote processor self recovery(attach recovery).
>=20
>  In order to avoid introducing a new variable(bool support_self_recovery)=
,
> patch 1 introduce a new function, rproc_has_feature to make code easy to
> extend, cleaner, such as we could move "bool has_iommu" to
> rproc_has_feature(rproc, RPROC_FEAT_IOMMU).
>=20
>  Patch 2 is introduce a new function rproc_attach_recovery for  self reco=
very,
> the original logic move to rproc_firmware_recovery meaning  needs linux t=
o
> help recovery.
>=20
>  V2-version 2:
>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=3D621=
311
>  Introduce rproc_has_feature
>=20
>  V2-version 1:
>=20
> https://patchwork.kernel.org/project/linux-remoteproc/patch/20220126085
> 120.3397450-1-peng.fan@oss.nxp.com/
>  Nothing change in V2.
>  Only move this patch out from
>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=3D604=
364
>=20
>=20
>=20
> Peng Fan (2):
>   remoteproc: introduce rproc features
>   remoteproc: support attach recovery after rproc crash
>=20
>  drivers/remoteproc/remoteproc_core.c     | 67
> +++++++++++++++++-------
>  drivers/remoteproc/remoteproc_internal.h | 10 ++++
>  include/linux/remoteproc.h               |  7 +++
>  3 files changed, 65 insertions(+), 19 deletions(-)
>=20
> --
> 2.25.1

