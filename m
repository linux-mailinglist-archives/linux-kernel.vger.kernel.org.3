Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EEC595333
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiHPG6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiHPG55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:57:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531FE9930;
        Mon, 15 Aug 2022 19:20:51 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIc7Wu022794;
        Mon, 15 Aug 2022 19:20:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-id : mime-version
 : content-type : content-transfer-encoding; s=facebook;
 bh=j9M8bWindV9wPCAIIUYaiF9S3CWVarPGAglLPLFwicY=;
 b=V1EpCOkwUhyDLJFl0+rthZrDHteaiL3zqjhvMLlRavhOrHFd7Q1GrbvIJu6Ly79Fhyv+
 01YJZKqoeYCtBuCQ1X1p3Mir85qGEmoxGuRFHUKxy3f1uZBUgQR/xdt11jTSQXG3H33o
 foKMTokwlcpzpFgfySl07ynoqvntak7KQKQ= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hyr9dm6jc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIPemDuBA1ThyFFnTnxB83XyyN2t1xLReKNwDHR1DtV1B6FP8/a6PaIAGYXF7D2z6R/0xL1Zxv3olI5zqwQMfI8XWJ7xE9dezYb6jXxLS60egrvNoJzGT+cP9bJyG8dMgcKSX0DAIlv4o0TDuQyZX8qH0PToNUBIQyWiSE70tO2DGXUdjNZSdW3tfq+o1PgUGaNIK7ZCWSPBfXe80g15RhUg7KIimrohJEW/ZppsG1Gh0SrSdzPgvP9DyYkS94jF1l9VXuYTd3qBlu3maQCo8r61FqLfwEdpWKkfPL6Z6qH69yeeU1sv5l8U8H46Q+JmxT7lBuT/VJQTNS/A/vqapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2AFoMgIAM6113YcaBtBZ6azvtXcqEJIG4l9JET7VnY=;
 b=ZXCIq/TuinvHNJNI5vYwxWGLspQT+pLQonBwA27f6mCSSXRMS0NqFyB/XGCkCnVpPQn4exDIbHd5vGIfG1/nus6t0H5xBQFnaB1odLzsTv+siTPyzqBtLX/UL+JSfOpxG/NfRTKZSS2Xq3o7rT2m5t9WK5Na9xpsR/eP2jkc7hgBghWf06xYNeor1ZzBzntzrmEkTvZjhNa9QMpM2NoncGp4C7FqCrhWmGZGC5Jq+wuVdLS8K4MJ4jHPa/7+/D888OFzLQcblSf5rX7FN/dK3ValR35PF3QFUCTZ1dJoWitdUMzWaZXe/Ei4TVeTt42Uqi6OuEM3TiE/d4olFxwpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by DM5PR15MB1276.namprd15.prod.outlook.com (2603:10b6:3:b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 02:20:48 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5525.011; Tue, 16 Aug
 2022 02:20:47 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "bobwxc@email.cn" <bobwxc@email.cn>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] docs: admin-guide/mm:
Thread-Topic: [PATCH] docs: admin-guide/mm:
Thread-Index: AQHYsNYQGHO4DFbf8U6QRgEoDFGoL62wyqAAgAABSQA=
Date:   Tue, 16 Aug 2022 02:20:47 +0000
Message-ID: <28DC6B52-482E-4880-AA36-085B6D113793@fb.com>
References: <20220815183706.2508116-1-alexlzhu@fb.com>
 <7538e307-63c8-7394-c069-44ff732dae81@gmail.com>
In-Reply-To: <7538e307-63c8-7394-c069-44ff732dae81@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61488c6e-9bfd-4e80-ebe6-08da7f2dee28
x-ms-traffictypediagnostic: DM5PR15MB1276:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TW7wlXWhp1sYMo4yWMSRJD0WNVhfuNJwpkxpu6FtqfhWxVAGCaRqpu0lLHOry5nZW2HffXbp5/z2/OqlCF1ve18TMuB8ZMZ3yYHiRCwbq4glD5jMccGh/svZG0pH/KqPlJH0MBpOIsrEPFmf/vjrDU8uLrw1zGJe5Y5EDcanAUlp9pgGZDT00Nr2qnttUXxRxvtyAxTnomiEArY9NQ+hkfoje54CMp1cOOP02TDB5s2hEaBhiWBVWtGfaTUaV2MGqHdz/ZiUkQSd4Z6t6+hjFE9qm4cEAXHQu8NvXoeeXY8UApDb9yleZLDQSZNdvbIuPYhPJbgZJrkuUaxZEj+2AgzcEUB72kV7xrQZYqOZeOT1ps8SnzQFiDDZHyWaMEPsKSNY0aMu8iUS/LOQm1nupi09m1MCtWuUN7+C4420QVkgJhFNvn1sRL050mGoxuoSAurO6vhMZz9YwQpn1pp4BlYnMZPZIZ7PZ6TE0Gqi4aaYaaCXEGhaq6+EgVUaDrsY1tkwNbnmHEQ8FoUL+bmSx1Qi2lUdXbrIi3K6/slLw4BrffMFJig7RS1sjRdOE07GOGsTwlBM0jRDhJF4w/tGO46/qrPooh9Ziz6Zk/Vj0zc64a/uWi2T/L/y95ppdzqCCTeUct7pT9y6FTjvkjOm2yH9nKh9YojCkb33NZNTcSwp39ZLNmH6uD+gjIPWLk81YeyAqanzQy61TidXM7xuAHUwXHUasWjBx734vVFzn/Yh/6fID8ZkbNPxK296rJrQwnq/y1SMxk6uSMyO8AYUU575drQDbwUCwbdqrs2X7Bmvwh3mRu/++oum4qlFaeEgwzXsuGsphaXtRgcySctsnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(38100700002)(6916009)(4744005)(66446008)(5660300002)(2906002)(66476007)(33656002)(478600001)(6486002)(66946007)(66556008)(64756008)(8936002)(122000001)(38070700005)(8676002)(41300700001)(6512007)(36756003)(6506007)(86362001)(71200400001)(53546011)(2616005)(83380400001)(54906003)(316002)(186003)(4326008)(76116006)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CwIH7lW322gZvapaDLDnb3nDTMfN+kYprQC0bOGr1Jg4KfYpNQzguOvIM7T7?=
 =?us-ascii?Q?/gBG6OyMdNFoEs9zPzzNhkxkrqZwtzVhhm3p0e9lT9ONBpfIREcoiuD12O6K?=
 =?us-ascii?Q?7tKmU2JxbJSVK+zw+JFFwlyd4MSEblHkAtANt6YphGTNL1bNvYQrICpPDK9V?=
 =?us-ascii?Q?qdpco6AiWrQa/NCUAcKE+b2qnuJyCW0UMiiJyTmfY3D4Oh+PG8TT2MbnbScG?=
 =?us-ascii?Q?buP97YRwQ1X0msVOuxn+yNxD5rkt7k8nHrSLzTxQN60jWwDazYrCBmkvZqDB?=
 =?us-ascii?Q?hww8KNVt4vsOFxZczr+Q8BPwaHFoXH+g2RGrrAevHZ+d24jOqqUqTN1D0WgW?=
 =?us-ascii?Q?1lFjd1K/7G8bM8PIrKbNhCcvvTG3H+Ra7PVaJqV7ysJBMCCVzDG+/nE0ZsXW?=
 =?us-ascii?Q?q/IRtwfgjn3OQOmjOTHavIpBIZWbpGTqC/y2vKGYwgOBibU3C4rQUNQvqgqb?=
 =?us-ascii?Q?XnqtjNHbPqxSwqcgUHs1rg+gYO8HALUS/UvYAPJEu66XBNiP5jYdiNhv4TJB?=
 =?us-ascii?Q?G0rIPsIA7QXGkBvnBTKVgJJYi3QQt6fKtQlp/xxK7KFhHIfMj5/o5m0qaMC7?=
 =?us-ascii?Q?m/LA98UmjfeNlE8elnQWMRktd5EcGPu5UYDyO5J9v9YAaRTTDtWYCAGbLdLc?=
 =?us-ascii?Q?VCEHLAX9KmuXU8JZKLZuubtL5g8HLg1+RkZy3CAWsqokUiUMxJUMvrCt7d+e?=
 =?us-ascii?Q?7qbV/EHD7kXvRwNXaSjsGQ0G4KXP8ref2I2Z/IBqulvJeYjwtFi2OP9mm+aP?=
 =?us-ascii?Q?jb75pSqdNsn8HfH+gio1Q9Zt4nWwWo5qKmYDCqmVhelrbJ0doFpyDyEmg2/V?=
 =?us-ascii?Q?Mr7R1jSM7FrxTX86/m3T0ihxVN+pK+VGuvnrE3Ca3T+4vBqdko8NalvvnxgM?=
 =?us-ascii?Q?DyhhIH5prAsrw4KIxyVaY+GKyWSTnI0STNb1sQYI+TgIYSqyQyO7tAwAEaff?=
 =?us-ascii?Q?N3ALacBgBSeo2pT/ZZvbh0LzyE+IcXgcOJnUg1XAeSw64Eex1yYiPBGIN2sQ?=
 =?us-ascii?Q?t7VmxOlytpH3iddnE1RSEYcD0A+Np5IFxfVFF9dqeT7bFfR8/mYTz77C1eOx?=
 =?us-ascii?Q?1kQ0PJf97QLUnaen2rCHg2N2s1zd48YdLFdCWtZR34uGiTS4nkyDCKinoHPe?=
 =?us-ascii?Q?9tGOPAfTYWpw6DKOJ/OFEQ21c/DX3CLyHKuVqSKgwVZSmbVLBx9YN0EuVyYt?=
 =?us-ascii?Q?T18mj6PmiPbXvle/zRnZ9cYrtLRzadmHmyQxTaISxThyALuXyEXOQhtw5s2g?=
 =?us-ascii?Q?JqahdQ8UmAOcKXjpZZ2Oz7EcTcVcey4QPY/VyvT2TEtjKJE6sSWlHPQxKn48?=
 =?us-ascii?Q?dZ5QwP1Aog613syPVlPXiTwhiNpCagFBYrSrLL1PADWIsYUv6f8gMIw1Annh?=
 =?us-ascii?Q?2g4r+8lvPlMXV9k9iO2WttNM/QUj85NVW/wTn14bO1Bd97h1mI7sMXZDUsux?=
 =?us-ascii?Q?xswRGte+glG9+3C0mH3wQhuk4wmf1YdOQMO5UlWleKh3zm+ke6v/pnxwAUF+?=
 =?us-ascii?Q?HMVQd3Ix+Z/eDI3vCMOW/96ePYyhE6J/OgyPLFdgEclmEbAfBcC+qin3fqUJ?=
 =?us-ascii?Q?sCKlFlviE+ZtI9ZFZVhqLSSC1AsehPDZB2zlFXDdNAAxbwM1rs0di2ETljgI?=
 =?us-ascii?Q?BI8tKcMjCVDO75LMQYJYpvQ=3D?=
Content-ID: <EABCC90DDA1DFD49B6BB896FC372177E@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61488c6e-9bfd-4e80-ebe6-08da7f2dee28
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 02:20:47.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfLdRuCSulwSUNYsR9KL0NQvgeFfnPUvhhVJQWIoShWOp0fpw4jfyl2MIX6MjTxN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1276
X-Proofpoint-GUID: YmJu8jd57A0M0WJx7W2_XCT9qglIrbsr
X-Proofpoint-ORIG-GUID: YmJu8jd57A0M0WJx7W2_XCT9qglIrbsr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 15, 2022, at 7:16 PM, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> >=20
> On 8/16/22 01:37, alexlzhu@fb.com wrote:
>> From: Alexander Zhu <alexlzhu@fb.com>
>>=20
>> This commit fixes typos and grammar errors in
>> Documentation/admin-guide/mm/concepts.rst.
>>=20
>=20
> What's the full subject? The subject (and description) should be=20
> "Improve grammar on MM concepts documentation".
>=20
> --=20
> An old man doll... just what I always wanted! - Clara

Sorry about that. I will send out a v2.=20

Thanks,
Alex

