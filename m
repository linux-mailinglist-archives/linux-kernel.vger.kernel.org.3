Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4164AB2AE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 23:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiBFWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 17:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiBFWi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 17:38:58 -0500
X-Greylist: delayed 2036 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 14:38:58 PST
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A98C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 14:38:57 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 216Bsl5Q015485
        for <linux-kernel@vger.kernel.org>; Sun, 6 Feb 2022 14:05:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0gVUrYP2sRqcMSTXj4HGgmGFq8+1ahpelKvIBan7DLY=;
 b=IPBNHwA4sFy8JYltGbeu+46ZnMazz4xJaQMDKH2O6kfoBhLv4LaT3f0+9rLV4jimHZCq
 nYOpM8snEclVVxnldfGZGBfg2FgFybU8fBhdF29wHYSrLgSSKGIhLv/Wr7UqPWrf2PEA
 LTGzweCk6vsa+K6B9aOQ/Fa2vYSiV3rijHo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e1se7d6fj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 14:05:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Feb 2022 14:04:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PczAee4XRXQvGllYW7Ecek21G8FhkDZhL0pSup7JepaHrQ+Bz8zBWQQAduMDLwdeCEYwqdVQYJYYI/ulzB4+UK7v0Dh3/dHB3AecSdd1ZRcJ/4ma3Z2QmwsCdxvXNXN3Y6yb7GAIIHUPw6ZKAUiOKM0GBHwwU+Fdvny7JJfMUOLTjg7DbJX1JeExpCgrvLDdhX1DwIuFHOggUquMn2IFVShH/VWI+sb9oeVgK4MLgh/e9gEKNs4croR/VUSC6hMQLtQdWtWZ4LKcVza4rEnzeYsBXoV6VeO993pJRCt9Hbh3/yAKXaMmAsauP69qN9ioAE2iNW3QNp+221LhhAEU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gVUrYP2sRqcMSTXj4HGgmGFq8+1ahpelKvIBan7DLY=;
 b=P4DNkDtEDWSGxzgCEP8EXzWMWlSaeLA+mCM8WLOgchp76VRbFlXSBY1obx7Y/bjFM3A+eCySOTHePFV6ZOeu8luGb+4uFvt/kSkhftD3szJP3Q98dMdx+vfpsB9kFz34ZYjYYzeCC9pCMNXAjB4AD4/LXZ/bJCY8syODAZyAlJEhsts8Kd4hnP2mfvx9Gjoyf3gT67hBUQKH/aFWxxoqfmrKrB5b19c9tktm/WCmgHIOt6MwBaijhebTDQDjMqz/MRc1b2XF6D71XvD/8DeCwS7snE5WlHrhgUhJP+rLEmQBCx0p5mFpzRq9NKq8t6QblWGKbB7YYmpMfRd4sFWoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BYAPR15MB3206.namprd15.prod.outlook.com (2603:10b6:a03:10d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Sun, 6 Feb
 2022 22:04:56 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::cd7f:351f:8939:596e]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::cd7f:351f:8939:596e%5]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 22:04:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, "Yonghong Song" <yhs@fb.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] perf: fix GPF in perf_cgroup_switch()
Thread-Topic: [PATCH] perf: fix GPF in perf_cgroup_switch()
Thread-Index: AQHYGV/+OF7rUXYl4UW/1cOzpArxg6yHD8CAgAAIphk=
Date:   Sun, 6 Feb 2022 22:04:56 +0000
Message-ID: <A36518F4-C5D3-4B09-A1A1-DF2EDB8DB317@fb.com>
References: <20220204004057.2961252-1-song@kernel.org>
 <YgA+x1CtlkqH2XcC@hirez.programming.kicks-ass.net>
In-Reply-To: <YgA+x1CtlkqH2XcC@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35f30ce2-1e56-410a-0626-08d9e9bcb5ff
x-ms-traffictypediagnostic: BYAPR15MB3206:EE_
x-microsoft-antispam-prvs: <BYAPR15MB3206D03FFE45EA032EC35E22B32B9@BYAPR15MB3206.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtP9mQgkgzlS9wr5jrcSvsyouD5Yf0NTZ4RXlqf/37D0O3gkXhZQaHKDl8JzwHo/MpYL0DWGTZoA394uKjADqlMTBxJ/iLqOa4sturhgvkpFRgk4J2n+ywKMElNM1RNAdqxRAZnU+Xju74Ac4WQ5qHcEAAGzlwCgDajVvOuWMrEXn0eRw1RgtKOhoyZY9vqoX6i0jtL07Jn0OgpVQAaaNUtc8kVwlXkQD+oNMiZiWUzGDH6P9Trca09Gs4b2uzkPtozIewVt0tmyy5qUkBfuUo09ES4lTVOJjq100o1Eziv/uN68wwO8v2IwFoGY3CR/wQSIlSx/V56+qDag+No0FUR7rkPnYgwZPgerf0PzkkzjBHKWPc0FeYBvuYG1MjLnftZP30QKL+ga5dcScuf2FGI4sv3+aI5wcFDVgEmWhUUU7QsRaaaA+p0LHVxw/7ystNznXBhOlsbE4GxwQejwYybp/83MZsUw6HYBm6d0f6pk7Zj3Q93GFEucOA/oyFr2LGXvwWrr57ML7usWijMmR+sXUkfYRkn/DCe7d3L/ZmRevpmFYwlutJxR53VM6Dp5u4s6WOpjEBBY94KW2WrOvhwD1zK0k35bC62dOU1v28jAwQi9w16AFYYtYZgzRGnjln9VrF1NPMhRsfpe4BgvRlvEOd2uMO7ihgQAH74SuoURU7HAUzd0kpf3/yFhwS0sDBXvHYA/P0m6SVx/amlOE9hNdXtzk5ckWf4MnNgTi5MiHT2+TI1LFUAaW1D1IxcEfpdA3GjLCtFStgmx4yf0EnhDbJgD1Ik3oubi86CfLpkdgHaHF4HuzTKqhl/eRFQZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6512007)(122000001)(6506007)(38100700002)(86362001)(53546011)(38070700005)(316002)(54906003)(2906002)(186003)(71200400001)(6916009)(76116006)(66946007)(83380400001)(91956017)(64756008)(66476007)(66446008)(4326008)(66556008)(8936002)(2616005)(8676002)(26005)(6486002)(966005)(36756003)(33656002)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1QvTFlaVG00bFJTaHNXSUM4bWRLeTFld3hzem9wZXMrend3R05Wdm5kT3hT?=
 =?utf-8?B?YVI1dU9ETzl2VTBOcXNaVUN3OWtJQmJSQVRpZmdpaGRIWEJNWjdYZmVjb1Yw?=
 =?utf-8?B?eDF2QWVmZEVoenRGNmUvWHBtczFWd2FMNnF6WnJPNTdWcjlqVXVVOGFHeS9o?=
 =?utf-8?B?REVJRHVoTFk4ekg0RGRSOTcvK0dFY1EyOU1jS1pSSnBFVG1aK2toL3VMaDJ4?=
 =?utf-8?B?TE1pYmlsdmtLUmp3QzJKZHBSWjB5ZVhzTWFqYSsrL2hXSllzY1ZHb2NnbnUw?=
 =?utf-8?B?VzNaUVlBMVBpTnFFbDNMdEtKZnQyY2c1ZW5abk1CQzJrbForc3QyeEY4c0Rh?=
 =?utf-8?B?ai91Tm1iOHpyTElTbEJ1UkNwRytUT3ExN285Y2lFT0FwdmtET1M5U3M4djJI?=
 =?utf-8?B?aXFLNjJmT05mQjFwZ0p0dHRXc1JlWWlqem15d2JPdXp3emJvVGQ2Ri9pVkNK?=
 =?utf-8?B?aHlZUnU5a0NHRWZWYWhsenNhVHhDMGpiVGpOalZ2WXh2YitzeXFEVXhlWkFE?=
 =?utf-8?B?Zlk4cGtBK1RIc3hTd1hxTklqdXBlWWdoNnZOVzFLSER6T01ZanRhdnZUSGJL?=
 =?utf-8?B?dlVlVXF0eFFkS1FBWFhpMkZxM2ZKU1JPRnVYNFphVFNScEl0NTBpdkhieU00?=
 =?utf-8?B?QVI5M2RBSkpyVDFjL0thZjVJOU11Y1QzbDhLN2F2a1JkTWVGeHFRY3YwRWdB?=
 =?utf-8?B?MEljVnVMbFJIeHVaTGhyVzJKS205cDdmdTVNQnNkbXNtVWM0RWFJV2RQdHRT?=
 =?utf-8?B?UzIwa2xpK0ljQWRjcGErcHpxUzBGUW8zVTh6MkFBQ2NBbDZ6bE13L2xNRHVz?=
 =?utf-8?B?QlE2Q2ZHZjhaZkJXckdpL29jMXh4cnI4WWIvSzgrVVVJckExb2hHV1R2QStL?=
 =?utf-8?B?VHp1bGFhNHA0ZzR0M2VBNVpFcEhWaWVhMXBpd1JqL01UajFhR2p0anFFNitB?=
 =?utf-8?B?UjJXcHJVSFRwcnhKd2ZqMmFsV3VETVd3Q2gvU2NGczBzbkFSRjZaMjlDajFV?=
 =?utf-8?B?ZlNKZ01RTHl6YUYyY3Vibk9jUytSUFhCU1BJSmQ0N0kzWUFJd2oxbVJVTUd1?=
 =?utf-8?B?ZDNoYUU1a2dSUUxTNzVsaFdTcEgzSTJIRTJQbytySkl2MTRBN0dGb2gyLzZn?=
 =?utf-8?B?THdmcEJma05Oekw2UEZVYnEyUjlJVlUvY0gwQlZGSW15THZPLzE3THc0cGo5?=
 =?utf-8?B?OGdEZ0VLZFFkWlhXSlRNR0hXbFV0K1Zac2NYNHM1dUJOeld0S2dGak1DamxN?=
 =?utf-8?B?WFd6K1hDVktYZjdqYU1CUU9mMW05SmJxTkw5QlBMVTVnckk3NmI0b0xXNmdL?=
 =?utf-8?B?Z1ZtM1FCdkNuZitaUy93cWFHNUpNa2ljcUlKUFZJc3h0YTNidG1pRTVMZm5Q?=
 =?utf-8?B?RWFPWVhMNzZNUXNsSmMxSElvNlAwNyt4V1ZRQ004bFdvMWRkc3hrYTZoM0pn?=
 =?utf-8?B?Rkw3ZWlHYWM1SDdkT1c1Rm9WazNxSkZFS1dnQXJZV256VFJZY0ZqVmNMWHcy?=
 =?utf-8?B?QWRlUmpnZWFVWWxlb1dZUlFBWHJBN2RuN0cwYmN5RFMrUDFxZ3hnU1hINVp5?=
 =?utf-8?B?S0lvSzQvbzgrWUk4MHpJWWdCR1BpYTZHNFd3THorOHQwVm45QzlQQTg5TVNz?=
 =?utf-8?B?ZnFKMGdySFhLbkxNelpUUzlxMHdjNEJyZCtJeTAyaHBFVXFjYVBDd3Fmc2s0?=
 =?utf-8?B?Y2hnMnJQeHFHdHdrdTVuVmVuaDR5cS9XOGNCVUx4dHFFVDJjbFhmeGFRTzRT?=
 =?utf-8?B?OTY3dG54ckIyY0pPQVprcWNaV2pjUWtRRXBMc3MrQU1OU0t4YjJtR3pNYmxm?=
 =?utf-8?B?b1FEaytIWVljMmUrK0Jhek1TYmRVOG5hMFBIM1RrZThJVGdVa0FGaVd4UTR5?=
 =?utf-8?B?QjFVdU5ROWpyWWtJdjZSRThHS0IwTFFFYlpmeCtNbDkvTkdQR0NaYi9YeWNX?=
 =?utf-8?B?UWpudGNRNHRORzgvQ1QwSGpBaHg0YUVIVnE4WjMySHRSNlhKRVRPeTBWb0Rl?=
 =?utf-8?B?VEZRTXE0dUVXM1FRckQvc1VsS0ZGdHc1dUY3WTJuUXNCejFWRGtyZEdhd2l6?=
 =?utf-8?B?SWlZNkR4ZGVRMnc3d2pQL085VUZLY3NNd1d6alZuOVVLR3ZrOFdFcVc0Smpu?=
 =?utf-8?B?U2N5dHZ2TEh3bHAwbTF6anFhZ1R0L2JXUkw0amtwMWQyTEdzcTZUNC81cDZG?=
 =?utf-8?Q?0eoWf0WiDkUjtn2u8+01DUw=3D?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f30ce2-1e56-410a-0626-08d9e9bcb5ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 22:04:56.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMQGBSSNbE5MzpFeUWNNLk7NEoYeckjMhkQ0B3QDOoYZVXB0Ea+Upz9V3uH17CEiZXXWhavpD+l8i1bDzcFf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3206
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: JLvq6xhmsmmnkr_djBONyB_XjlRpHhPW
X-Proofpoint-GUID: JLvq6xhmsmmnkr_djBONyB_XjlRpHhPW
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-06_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202060158
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEZlYiA2LCAyMDIyLCBhdCAxOjM0IFBNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gVGh1LCBGZWIgMDMsIDIwMjIgYXQgMDQ6
NDA6NTdQTSAtMDgwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBHUEYgaXMgb2JzZXJ2ZWQgaW4gcGVy
Zl9jZ3JvdXBfc3dpdGNoKCk6DQo+PiANCj4+IFsgMjY4My4yMzI0NzddIGdlbmVyYWwgcHJvdGVj
dGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmljYWwgYWRkcmVzcyAweGRlYWNmZmZm
ZmZmZmZmOTA6IDAwMDAgWyMxXSBTTVANCj4+IFsgMjY4My4yNTE4MDJdIENQVTogMzAgUElEOiAw
IENvbW06IHN3YXBwZXIvMzAgS2R1bXA6IGxvYWRlZCBUYWludGVkOiBHIFMNCj4+IFsgMjY4My4y
NzM3MjZdIEhhcmR3YXJlIG5hbWU6IFF1YW50YSBUd2luIExha2VzIE1QL1R3aW4gTGFrZXMgUGFz
c2l2ZSBNUCwNCj4+IFsgMjY4My4yOTExMjldIFJJUDogMDAxMDpwZXJmX2Nncm91cF9zd2l0Y2gr
MHhjMC8weDE3MA0KPj4gWyAyNjgzLjMwMDg4OV0gQ29kZTogODUgZmYgZmYgNDggOGIgODMgMDAg
MDEgMDAgMDAgNDggODUgYzAgNzQgMDQgYzYgNDAgMDggXA0KPj4gICAgICAgICAwMCBjNiA0MyAw
OCAwMCA0OCA4YiA4MyA3MCAwMSAwMCAwMCA0OCA4ZCA5OCA5MCBmZSBmZiBmZiA0OCAzOSBjNSBc
DQo+PiAgICAgICAgIDc0IDdkIDw4Yj4gODMgZTQgMDAgMDAgMDAgODUgYzAgMGYgODQgODkgMDAg
MDAgMDAgNGMgOGIgYmIgMDAgMDEgMDAgMDAgNDgNCj4+IFsgMjY4My4zMzg0NTVdIFJTUDogMDAx
ODpmZmZmYzkwMDAwMjFmZGIwIEVGTEFHUzogMDAwMTAwMDINCj4+IFsgMjY4My4zNDg5MDRdIFJB
WDogZGVhZDAwMDAwMDAwMDEwMCBSQlg6IGRlYWNmZmZmZmZmZmZmOTAgUkNYOiAwMDAwMDAwMDAw
MDAwMzhmDQo+PiBbIDI2ODMuMzYzMTc2XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDcgUlNJOiAwMDAw
MDAwMDAwMDAwNDAwIFJESTogMDAwMDAwMDAwMDAwMDAwMA0KPj4gWyAyNjgzLjM3NzQ0N10gUkJQ
OiBmZmZmODg5MDNmZmE3N2IwIFIwODogMDAwMDAwMDMwMDAwMDAwMyBSMDk6IDAwMDAwMDAwMDAw
MDAwMDQNCj4+IFsgMjY4My4zOTE3MThdIFIxMDogMDAwMDAwMDAwMDAwMDAwMyBSMTE6IDAwMDAw
MDAwMDAwMDAwMDEgUjEyOiAwMDAwMDAwMDAwMDAwMDAyDQo+PiBbIDI2ODMuNDA1OTg5XSBSMTM6
IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiBmZmZmODg4MTAxM2ZkYzAwIFIxNTogMDAwMDAwMDAwMDAw
MDAwMA0KPj4gWyAyNjgzLjQyMDI2MV0gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZm
ZmY4ODkwM2ZmODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPj4gWyAyNjgzLjQz
NjQ0Nl0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0K
Pj4gWyAyNjgzLjQ0NzkzN10gQ1IyOiAwMDAwN2ZmYWZiOTU2MDIwIENSMzogMDAwMDAwMDE0MWNk
NzAwNSBDUjQ6IDAwMDAwMDAwMDA3NzA2ZTANCj4+IFsgMjY4My40NjIyMDldIERSMDogMDAwMDAw
MDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQo+
PiBbIDI2ODMuNDc2NDgxXSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUw
ZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPj4gWyAyNjgzLjQ5MDc1Ml0gUEtSVTogNTU1NTU1
NTQNCj4+IFsgMjY4My40OTYxNjBdIENhbGwgVHJhY2U6DQo+PiBbIDI2ODMuNTAxMDQ4XSAgX19w
ZXJmX2V2ZW50X3Rhc2tfc2NoZWRfaW4rMHhiMy8weDIwMA0KPj4gWyAyNjgzLjUxMDYzMl0gIGZp
bmlzaF90YXNrX3N3aXRjaCsweDE4Ni8weDI3MA0KPj4gWyAyNjgzLjUxODk5OV0gIF9fc2NoZWR1
bGUrMHgzYjEvMHg4NTANCj4+IFsgMjY4My41MjU5NzNdICA/IGNwdWlkbGVfZW50ZXJfc3RhdGUr
MHhhNy8weDM0MA0KPj4gWyAyNjgzLjUzNDY4N10gID8gdXBkYXRlX3RzX3RpbWVfc3RhdHMrMHg1
MS8weDcwDQo+PiBbIDI2ODMuNTQzMzk5XSAgc2NoZWR1bGVfaWRsZSsweDFlLzB4NDANCj4+IFsg
MjY4My41NTA1NDhdICBkb19pZGxlKzB4MTQ4LzB4MjAwDQo+PiBbIDI2ODMuNTU3MDAxXSAgY3B1
X3N0YXJ0dXBfZW50cnkrMHgxOS8weDIwDQo+PiBbIDI2ODMuNTY0ODQzXSAgc3RhcnRfc2Vjb25k
YXJ5KzB4MTA0LzB4MTQwDQo+PiBbIDI2ODMuNTcyNjg4XSAgc2Vjb25kYXJ5X3N0YXJ0dXBfNjRf
bm9fdmVyaWZ5KzB4YjAvMHhiYg0KPiANCj4gUGxlYXNlLCBkb24ndCBwdXQgc3BsYXRzIGluIGNo
YW5nZWxvZ3MgbGlrZSB0aGlzLCBzaW1wbHkgcHV0IHRoZQ0KPiByZWxldmFudCBpbmZvcm1hdGlv
biBpbi4gV2hpY2ggeW91J3ZlIGFscmVhZHkgZG9uZSBiZWxvdywgc28gdGhlIGFib3ZlDQo+IGlz
IGNvbXBsZXRlbHkgcmVkdW5kYW50Lg0KPiANCj4+IA0KPj4gd2hpY2ggaW5kaWNhdGVzIGxpc3Qg
Y29ycnVwdGlvbiBvbiBjZ3JwX2NwdWN0eF9saXN0LiBUaGlzIGhhcHBlbnMgb24gdGhlDQo+PiBm
b2xsb3dpbmcgcGF0aDoNCj4+IA0KPj4gIHBlcmZfY2dyb3VwX3N3aXRjaDogbGlzdF9mb3JfZWFj
aF9lbnRyeShjZ3JwX2NwdWN0eF9saXN0KQ0KPj4gICAgICBjcHVfY3R4X3NjaGVkX2luDQo+PiAg
ICAgICAgIGN0eF9zY2hlZF9pbg0KPj4gICAgICAgICAgICBjdHhfcGlubmVkX3NjaGVkX2luDQo+
PiAgICAgICAgICAgICAgbWVyZ2Vfc2NoZWRfaW4NCj4+ICAgICAgICAgICAgICAgICAgcGVyZl9j
Z3JvdXBfZXZlbnRfZGlzYWJsZTogcmVtb3ZlIHRoZSBldmVudCBmcm9tIHRoZSBsaXN0DQo+PiAN
Cj4+IFRvIHJlcHJvIHRoaXMgb24gSW50ZWwgQ1BVczoNCj4+IA0KPj4gIC8qIG9jY3VweSBhbGwg
Y291bnRlcnMgd2l0aCBwaW5uZWQgZXZlbnRzICh3YXRjaGRvZyB1c2VzIGFub3RoZXIpICovDQo+
PiAgcGVyZiBzdGF0IC1lIGN5Y2xlczpELGN5Y2xlczpELGN5Y2xlczpELGN5Y2xlczpELGN5Y2xl
czpEIC1hICYNCj4+ICAvKiBhZGQgYSBwaW5uZWQgY2dyb3VwIGV2ZW50ICovDQo+PiAgcGVyZiBz
dGF0IC1lIGN5Y2xlczpEIC1HIG15LWNncm91cA0KPj4gIC8qIEdQRiBpbW1lZGlhdGVseSAqLw0K
PiANCj4gTHVja2lseSB0aGlzIHJlcXVpcmVzIHJvb3QsIGJ1dCBwbGVhc2UgZG9uJ3QgaGFuZCBy
ZXByb2R1Y2VycyBsaWtlIHRoaXMNCj4gdG8gdGhlIGtpZGRpZXMgOi8NCj4gDQo+PiBGaXggdGhp
cyB3aXRoIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpLg0KPiANCj4gKnNpZ2gqDQo+IA0KPiBZ
b3UgZm9yZ290IEZpeGVzLCBJJ20gdGhpbmtpbmcgdGhpcyBpcyBkdWUgdG8gY29tbWl0OiAwNThm
ZTFjMDQ0MGU2Lg0KPiANCj4gV2l0aCBhbGwgdGhhdCwgSSBzZWVtIHRvIGVuZCB1cCB3aXRoIHRo
ZSBiZWxvdy4NCj4gDQo+IC0tLQ0KPiBTdWJqZWN0OiBwZXJmOiBGaXggbGlzdCBjb3JydXB0aW9u
IGluIHBlcmZfY2dyb3VwX3N3aXRjaCgpDQo+IEZyb206IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5v
cmc+DQo+IERhdGU6IFRodSwgMyBGZWIgMjAyMiAxNjo0MDo1NyAtMDgwMA0KPiANCj4gRnJvbTog
U29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4NCj4gDQo+IFRoZXJlJ3MgbGlzdCBjb3JydXB0aW9u
IG9uIGNncnBfY3B1Y3R4X2xpc3QuIFRoaXMgaGFwcGVucyBvbiB0aGUNCj4gZm9sbG93aW5nIHBh
dGg6DQo+IA0KPiAgcGVyZl9jZ3JvdXBfc3dpdGNoOiBsaXN0X2Zvcl9lYWNoX2VudHJ5KGNncnBf
Y3B1Y3R4X2xpc3QpDQo+ICAgICAgY3B1X2N0eF9zY2hlZF9pbg0KPiAgICAgICAgIGN0eF9zY2hl
ZF9pbg0KPiAgICAgICAgICAgIGN0eF9waW5uZWRfc2NoZWRfaW4NCj4gICAgICAgICAgICAgIG1l
cmdlX3NjaGVkX2luDQo+ICAgICAgICAgICAgICAgICAgcGVyZl9jZ3JvdXBfZXZlbnRfZGlzYWJs
ZTogcmVtb3ZlIHRoZSBldmVudCBmcm9tIHRoZSBsaXN0DQo+IA0KPiBVc2UgbGlzdF9mb3JfZWFj
aF9lbnRyeV9zYWZlKCkgdG8gYWxsb3cgcmVtb3ZpbmcgYW4gZW50cnkgZHVyaW5nDQo+IGl0ZXJh
dGlvbi4NCj4gDQo+IEZpeGVzOiAwNThmZTFjMDQ0MGUgKCJwZXJmL2NvcmU6IE1ha2UgY2dyb3Vw
IHN3aXRjaCB2aXNpdCBvbmx5IGNwdWN0eHMgd2l0aCBjZ3JvdXAgZXZlbnRzIikNCj4gU2lnbmVk
LW9mZi1ieTogU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IFJpayB2
YW4gUmllbCA8cmllbEBzdXJyaWVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0
cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IExpbms6IGh0dHBzOi8vbGttbC5r
ZXJuZWwub3JnL3IvMjAyMjAyMDQwMDQwNTcuMjk2MTI1Mi0xLXNvbmdAa2VybmVsLm9yZw0KPiAt
LS0NCj4gDQo+IGRvZXMgdGhhdCB3b3JrIGZvciB5b3U/DQoNClllcywgdGhpcyB3b3JrcyEgVGhh
bmtzIGZvciBmaXhpbmcgdXAgdGhpbmdzLiANCg0KU29uZw==
