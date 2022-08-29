Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88315A5573
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiH2UTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiH2UTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:19:34 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1CF9AFBA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:19:31 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TJ5mnr015177
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:19:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=bKQIolRnA+Oe7ck6n47iZ64G254OF1sEmQX5y3olMk4=;
 b=ou2Kj8ZocfAIHSkzhG9F0qbzGTCnJlSjz59Gu26aOAVOVWGuA+yUwXvcn5arpvpGO3Lo
 tOQcxBDwFJ1O+5WoqDBU43zT6yHAYFMx2u3e/KXR4M8vFY0efLn5FWznTQwTZx6crm2l
 CpuhCMjZrGO6S+eVnHUJWuL9YLm4CHerW6E= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7h3uv2dk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7v0CoZOhoZz0FjTxjHH38PvVLivQTgjvUXQf8qKuNzuugdyOQS7l4ZdlVAy4EKgdby3J5elujJfh5/bIL7M8zDCeQQipvJdL3gKacioSqtUL6mvXu7XiV4RKZXx5+T4k4Xq42buMm6gDM0Z77UAdhc78mho6oj5oo+tMiivOfWOyZ2+QFVhzrdFa567L2dYnwVuSuMHhjRaYu6MP6rX+auItZWBZArjbmwxryl48GAjY25ZMgACcTUFZEnj/g430sdMEre7UgUQHEJTGpuSbUbSV0JhnDX7MdI2U0tTT74DC7BMvewtTAHjf+BQ5/KQ6M3t1PVPcGdYs6p5cQc1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKQIolRnA+Oe7ck6n47iZ64G254OF1sEmQX5y3olMk4=;
 b=U8NnxmhiklfgVtVqfdle2QDeFchgdGJbThHXANLo+MHxJKvkLXfSAXInDhBE3bwLBL6szTQe2RT2j7BifSbsWKE/I6gumbkMfqibB9CLmh/bLVJzzH+4PEPB2L5fv69p5Ut6CMEldG2XEK5/1cxIpjrZuSfane3MDsHdbLFiWDIEadEouozRWgZiuLhZaV6mGOpXRWOgUeVoMcOHp1zZ0S8yfsypgKtZVSFOvqrnBhPMAbQx2WIAnfQgrI4vC2pBg6AoM0vCubGYMZVnXJbT2LLvQs1864EEEk4b3EGpuY7xe9D4e8NLnqE3Q6U9xML3463ah96y9b4OEDF7uta6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by BLAPR15MB4001.namprd15.prod.outlook.com (2603:10b6:208:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 20:19:27 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5566.021; Mon, 29 Aug
 2022 20:19:27 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "riel@surriel.com" <riel@surriel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/3] mm: add thp_utilization metrics to debugfs
Thread-Topic: [RFC 1/3] mm: add thp_utilization metrics to debugfs
Thread-Index: AQHYuMfXuirJuznW90qwp5WBrIrXOa3B4Y6AgAR2JwA=
Date:   Mon, 29 Aug 2022 20:19:26 +0000
Message-ID: <4847C6FE-429D-4619-9200-6CE7C84B5386@fb.com>
References: <cover.1661461643.git.alexlzhu@fb.com>
 <b30dedf6393ed9b3ecd4118b97233cc4186b0e62.1661461643.git.alexlzhu@fb.com>
 <CE4E09B8-4CDC-471D-9625-2CED7C95997B@nvidia.com>
In-Reply-To: <CE4E09B8-4CDC-471D-9625-2CED7C95997B@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a17f2f7-9260-4d0c-2d82-08da89fbc58f
x-ms-traffictypediagnostic: BLAPR15MB4001:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00JC6zsmo7LOxgS9ndPVhVHOKzUjgX0zAiz+cWoy2wNzV2TMWEg33tcth5ctEoz1C/E5mE3c+K/2aoaH1iJb64GpC/qjWnSf2jwsqnKb9JzdDdpbRBXBaqGw6bLQyDAFQFzdjYbMqoJd8l6PYf56Q23pOE+DSUxjTeUSO/zd4vYQI2Yj92RMFdBvLMZ2NDjcvyTvn+EjCKMxXTgmRuaq20YD6JXV1Pkh+vgVEkMenwIKfKw9UisrDdXJ1H0hegWeK75I0IeZMvC4aScS1wWoN0yxXqO0FyNEshD3P6ymkWYSA3fRgmJ9VGLHXo4a9owzH3MKVg8zwjnkAbRiHBLyml8zUG2hscqafC0VGmLyseo7Bl2O1Pc+mBf+8onZlMYYs1MZoWWU69tuSinPdus1JFkpJoIh+9VP7qgH1I+xUdWwO3mqxHpiBQ4UvPF2ML7CNNyJePzEHFHNeoeR56/5tx3lD0b6R/sSQGfGeIDY0HawooHUqA7H677oKQ6bsODU4GQMvfPRyFjdT6lA46zCY9hdnhKm1FuEswL0t5rURLri6BTeRkOUf3AIe78P9oGq8FptKSgl6KnSa3K2pahW3Pu0YxJiJyqZ2gDy6zDV9kxz1jJsFe2cURIkBFj8QStRGV4yyHxFVTCUEE/n++bGteW7RMMQPiX2ei2lZK1M8tPwl+5Lh2iXisDQyJ1cwSqJpg/ug0jWZ5m/PL24p2XDZlS5BoZwVHEGMsxcjac+Igj9yKxk6SFkWf3BB3X5Xi9nhUiaQS48Eig9IOYSn6DKolZafec7nSZGo8Eln8V1LB4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(8676002)(33656002)(5660300002)(8936002)(41300700001)(186003)(66574015)(53546011)(2616005)(86362001)(6506007)(6512007)(4744005)(478600001)(64756008)(71200400001)(36756003)(122000001)(316002)(2906002)(6916009)(54906003)(38100700002)(66946007)(38070700005)(4326008)(91956017)(66476007)(66446008)(6486002)(66556008)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2lZY3dUZXhnV0E0TloyTi9yYS9nOGpvNE5nZXoxaVk5UkNobW44WU5CbFpj?=
 =?utf-8?B?N3d0MUgxdWI4UkxwOHgzTlNNcXEvajBxRWZ4czRHWllzNzV6SzRoT2hCTUI3?=
 =?utf-8?B?eXBBMFhEWEdVc3o0SXFlZW12czdja3I3b1JGRFgxaTR4eEpTOVA1aUFIUXpP?=
 =?utf-8?B?SmN0Znc5VmQwT01WZk8xSE5VZ3ZVdVRsdDFNRHZqc0xwMWpPOHlQa0w0SWtN?=
 =?utf-8?B?UXV6Um1NR3FrbE01MGVVZUY1Zm5hQTdaQlFSQllwUEh6enBFeUNlUW5KaUJT?=
 =?utf-8?B?QkFmSFFFYUwvb05PUkEyVHlDNksvOG5tTkt3N0I5U3hzRE1ySDBORlFtTDdS?=
 =?utf-8?B?TlZmQ3l5R2xXM1ZkOU50VDVUdjVSRWlub1hKNm1aTGdRUmNKOWpWNU03M1Qy?=
 =?utf-8?B?MDNoWUJuT1pJSW9xeHd1YW94TkQ5clN1OGxoemlmb0ZtZDBlcmRMWDdXcWNu?=
 =?utf-8?B?a0doL1VLNTByQlF5YlhOcGpTQWo5Qk5SZmFqOW5XdzBiSWhqZnJpT3RGVmZi?=
 =?utf-8?B?MU9jMkdpRndxOGxmREw0cnlDZ0FuK3lhUlozL1ZwWVkvalE1dkRhRmk2cUNl?=
 =?utf-8?B?UWJBeElrd2QvbW5nRllhNi9hbmRudytJblVoZGplSjR2M2dMVWJRVEVTenFG?=
 =?utf-8?B?MUJMcHIrQ1BNQU5oNGZRYk9zSFJxRmJlN2U1cHF5azNSVWJmMkJ5TWFVcm1P?=
 =?utf-8?B?Tlc3U2JpalJ0M1FXdGUvVEh3eWdFQ09QWVlVVmh6YnpCZW9WUTFBcWdtZ1FF?=
 =?utf-8?B?MjVscHNINVpoQXlQZFFZQ3JYMS9GSVFrVGhEQkxOcXhqb04xdWlwbmNRVTgw?=
 =?utf-8?B?Zy9PZnVkVzBXYU9IcGI5WXg5U3ZOOGFZMkpzWUdVb1VweHN1eUg2NEw4cVha?=
 =?utf-8?B?UkNZdVR1QkVHank2QlR4Rk1oa2VEaDluR202a2crd3U5d2haRkxoZHp5clFy?=
 =?utf-8?B?eGVzTDNmM1NRbmNCRHh5aGo4ZmkwNWoyeWRnVmtlMGh5dG1YTDRZSk0wQ1dI?=
 =?utf-8?B?YmhucGJIK042N0pKalM1dXJjeXZMeHVzRi9TeEhWTUlET21JS1Z5dmpsZVB1?=
 =?utf-8?B?anBRdHB4MzVEOTdJa3ZwWGxwQXRHNiszRVNrUzRxUnZhQXIyNkluMjNadW16?=
 =?utf-8?B?bHhnRysyOGdKQmJOZFhoUm56dk9NOHMxc3FhUW1BUVlOdTNlK0RLdkQ5VTJB?=
 =?utf-8?B?OEl1WGNUUUVtSS95UGFJUVQvZEFtNzR4b3R4bjB0aDRDbURjaWJVNmdpVC9w?=
 =?utf-8?B?Q1NSaEN0L2swc2RuOXpmQy8xQWNSeEhzVkUxdVpPSEl3bklrOTlMTm5NTnhO?=
 =?utf-8?B?WmI2MmJxV3JjM0RhUlZNbVA2VENud0s1cmVKaHZIZ1pWRForZDk0SUFWd0Ri?=
 =?utf-8?B?bHZxZEJTVXFpMHhTL09CVThGMTFjYlhCRkVBa1A2MjNpUStRdnIvRHFmaVM2?=
 =?utf-8?B?N2pvY29nMlRRQkNlOVBUQU5YZGw4a0dheXdFUFAxekhMUlFnYWQxTCt3NW9H?=
 =?utf-8?B?YXhHMXg3LzhLQjBYN3V1RUU2dlZKNnIxWGIrT2VpcmRKNHFtNndRYm5DYTRD?=
 =?utf-8?B?YTFxdU9MOUhEekt1NWliREhFSHAzYkF4UVRwNlVPU1ZubGttTnB6WUlTSk5v?=
 =?utf-8?B?K3Vpem1McktibVRxS1FSbGtkZzJYNlJvVGtSazNNcXg4RjZzOHBpQXo2emk3?=
 =?utf-8?B?VEE0R3pDVHhFS3Jud3VMK3dVNXYrMFBqRmNVS0N4VW1HNVBOTk5MTFVXcWha?=
 =?utf-8?B?eVdVYlAwbm5BVVpsaWlDZFl5bVlobHhLcG1YSDgyRFZNL0pCY1FzOWNvdzFB?=
 =?utf-8?B?RGRMOCtkcEg1aG1BcTYzcDdUc1ZlUDRTNDIwck5sZCs2Rzk1d0RUNVE1UnpD?=
 =?utf-8?B?TjRxcHA0OUtkK2loK2p2YllCZE9pRmxSQXRhSkx6SkpMSTNxOVQwalZaZG45?=
 =?utf-8?B?TWFSMXRuV3IzcU54R1pGS3o1K2lSRnQ1RWhJbU9CS01MbXo3Y2Uwc3pyMEJw?=
 =?utf-8?B?RFFDWWNBQUdkZ0VyUDRoRk9WUGI1V3YzMjNjSEpKRHZhSUZPT0NWVS8xakNU?=
 =?utf-8?B?NDJOdGI0SlZrbVJEMmxrVWlibzIvbDJjalVlakdYTmw0amczUU40S0RrYWVG?=
 =?utf-8?B?UisxTmZGNFFJaithcm4zTFZqUEtMSnlkZnFlV0pidGg3S2JHYnVwZTg2bEFa?=
 =?utf-8?Q?BGAPwkQ4lmSPpgJKmD16ar0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4947968FE07B0C4B8F89A69CF2D514FE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a17f2f7-9260-4d0c-2d82-08da89fbc58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 20:19:27.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2S1e3cpAPBuOxRqrLe1PpUIIfrajWbaoWvi/6/BpMGBrJiiF8t6Gj0CbFHPoDQnU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4001
X-Proofpoint-ORIG-GUID: JLuiIW0I6l_uOco6np8s9ikPJsbiWekJ
X-Proofpoint-GUID: JLuiIW0I6l_uOco6np8s9ikPJsbiWekJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDI2LCAyMDIyLCBhdCA1OjExIFBNLCBaaSBZYW4gPHppeUBudmlkaWEuY29t
PiB3cm90ZToNCj4gDQo+IE9uIDI1IEF1ZyAyMDIyLCBhdCAxNzozMCwgYWxleGx6aHVAZmIuY29t
IHdyb3RlOg0KPiANCj4gSG93IGxhcmdlIGlzIHRoZSBtZW1vcnk/IEp1c3Qgd29uZGVyIHRoZSBz
Y2FubmluZyBzcGVlZC4NCj4gQWxzbywgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIGV4cGxpY2l0bHkg
YWRkIHRoZSB0aW1lIHVuaXQsIHNlY29uZCwNCj4gaW4gdGhlIG91dHB1dC4NCg0KVGhlIHNpemUg
b2YgbWVtb3J5IHdhcyA2NUdCIG9uIHRoZSB0ZXN0IG1hY2hpbmUgSSBvYnRhaW5lZCB0aGVzZSAN
Cm51bWJlcnMgb24uIEnigJlsbCB0YWtlIG5vdGUgb2YgYWRkaW5nIHRoZSB0aW1lIHVuaXQuIFRo
YW5rcyENCg0KDQo+IElzIGl0IHBvc3NpYmxlIHRvIHVzZSBjYWNoZS1ieXBhc3NpbmcgcmVhZCB0
byBhdm9pZCBjYWNoZQ0KPiBwb2xsdXRpb24/IFlvdSBhcmUgc2Nhbm5pbmcgZm9yIDI1NioyTSBh
dCBhIHRpbWUuIFdvdWxkbuKAmXQgdGhhdA0KPiB3aXBlIG91dCBhbGwgdGhlIHVzZWZ1bCBkYXRh
IGluIHRoZSBjYWNoZT8NCg0KSSBoYXZlIG9ubHkgZm91bmQgbm9uLXRlbXBvcmFsIHdyaXRlcyBp
biBhcmNoL3g4Ni8sIG5vdCBub24tdGVtcG9yYWwgcmVhZHMgKHdpdGggTU9WTlREUUEpLiBJIHN1
cHBvc2Ugd2Ugc2hvdWxkIGZpZ3VyZSBvdXQgd2h5IG5vYm9keSBldmVyIGJvdGhlcmVkIHVzaW5n
IG5vbi10ZW1wb3JhbCByZWFkcyBvbiB4ODYgYmVmb3JlIHRyeWluZyB0byBtYWtlIHRoaXMgY29k
ZSB1c2UgdGhlbS4NCg0KQSBxdWljayBzZWFyY2ggb2YgdGhlIGludGVybmV0IHN1Z2dlc3RzIHRo
ZXkgbm9uLXRlbXBvcmFsIHJlYWRzIGFyZSBub3QgYmVpbmcgdXNlZCBvbiB4ODYgYmVjYXVzZSBw
ZW9wbGUgY291bGQgbm90IHNob3cgYSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudCBieSB1c2luZyB0
aGVtLCBidXQgbWF5YmUgc29tZWJvZHkgaGVyZSBoYXMgbW9yZSBpbnNpZ2h0Pw0KDQo=
