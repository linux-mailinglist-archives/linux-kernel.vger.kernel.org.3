Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9F50D674
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiDYBL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiDYBLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:11:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2062.outbound.protection.outlook.com [40.107.114.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1677561A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE2N8Y3WXHkvu3dRnX+YNdi2Z+69qChsDAC1xOSE3zG9wO6Wx2cFI/4UzOJISfqYW9xV9FfoynryPLY7jI1Z3dTlXjb3+ax/lV3cuQSZ5ND7SRbvY7KPEaBuBLCQ51/jBu8LAOEZ7InHroDJ+4vxSNLsUlTOVEJk+LnEtUTAtwN8wQuYeQbIG0PPvVQXkYPcFW+gBbGcVFbCuVKAemjBzj7CpJmnBrRsZy8oNaspD7blwHoiuB//H2Gbya+aasgtQ74ekpdZ+qvgSMZXHCDjf9XR8YrNwdFBnhoCTRmrY+uryw2Rahw0I2j9B6o0ioP93eLJEaJo/Q8bgyPwGC8nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+ZL3V34n2mST8kZRTIF2Q2QsMXAQF6PLh4JzywNVKE=;
 b=bj8oGvgdxp/Aop4rEVnBGzx6I8gi4FeQSIWr6kWe6pLHQyYYPlOvC2oVpPxKnspXuE72dmY2wnadveYHT/roSJ2UozG7KSUdCsBwElQJ7IsHemVPSnLyvr0yYQXI4ajO7vS5MqU5Y89v+aLp1uvaBaBaeO9u5E7dlAzOpFKQCeZ5jO952uFo2V7SOXZt+hWFu9RpjRu6PO+Yg8K8kor+pdmK10zv94YVegRY2RC6ddkjLQscn/QgK20WleYmQGpYl5UMwu09LoLLQenzgH+n9d7Q+6lbGYjXIgYR18yfC29CFEzXPpCa/Ru9FuPBBTVaE1nXBbDSZUK+T2eD6Wgk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+ZL3V34n2mST8kZRTIF2Q2QsMXAQF6PLh4JzywNVKE=;
 b=k6M08rqLOTAGMDoJS+ff41ZvKSGVZ2zDLzGwZJct3sFsI9QOghE4l0ZFxXCJJZysSSmVj5m7bloKfUXLn58ItBs8nHMNoAgR38BfVCvOVfH9D6R2GmIcpumK8ZSBt7RPYZJ0cTKe1O2SWGZP58YI+y8BbCNwkht9FNCymXXr5/w=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB8680.jpnprd01.prod.outlook.com (2603:1096:400:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 01:08:06 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 01:08:06 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "surenb@google.com" <surenb@google.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if swap
 read fails
Thread-Topic: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if
 swap read fails
Thread-Index: AQHYV7s04sjKvB31sE2FEmou2La8+6z/0l4A
Date:   Mon, 25 Apr 2022 01:08:06 +0000
Message-ID: <20220425010804.GA3746096@hori.linux.bs1.fc.nec.co.jp>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-2-linmiaohe@huawei.com>
In-Reply-To: <20220424091105.48374-2-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fa070e3-2c6d-4a02-ce0c-08da26580e66
x-ms-traffictypediagnostic: TYCPR01MB8680:EE_
x-microsoft-antispam-prvs: <TYCPR01MB868016E4FCE22C224B4923ADE7F89@TYCPR01MB8680.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9biTSQNlIEeCOg5Q7ILUJewKSvi8oII75HlaWj5RqVvq6ulKffGuw4ZHhAKnKiMkfh85v8Du0a9TBaFlSOcYsCNFVJNzWmnP0/XKulrFaw6BtawL0ig4lb1Yd5BbCVfYHsKIAeX1aZmDzRcBOV0V2zG9OWuq3dUtrDnJ3Q96Tg88ZIlJcR4iXhCUtqJJAfWp+mzuTzeUw9TL2j2wf9TSoQ9t6E1OU3DUBu3f4n1q4YI2FW9s3e/VJIc6doceZ4+98NIJemUX2ZkDO9PJlBMOHKZOV2KD/Spklgxfyj6mqkx0NmjGH6TJSxfP3ZluJBTCYHMMGoXoVO5JLH+IDvyAMbCY4q9SeRbr665g+GsCtpJH9dBvM7ruz9u3kEhrDbZltrrOClAwjOcbcNdLI2tAcj2+ev94iuXyDthwuTpC5YrGOqM2h/Uh/2PXFjfb2VkHyd0KqxcQORWgVSoz3I1blE4yfnVvHMLm12zkYv1vgna2gj3GvM8WBh5lLWEVLHejw5iSRH58HSx58KxvB1nwmCjOFVBK/6da6PHvjSDVu/nhKbAYfGIVf5aAWUrXTe5Z7YMRKPo1W1GJT06+nFpx622BGwTOzNJ6bPAme5mbuADyeI075RRhWKejac5b+mywAnprQxr/GwEd86UM2oKKRIIF10a3Mboifwp4h30R2aOGThedDQz69katiqPiNoWnu+p4FBtCuzQVMPDXkBZTpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(38100700002)(38070700005)(83380400001)(86362001)(82960400001)(1076003)(186003)(2906002)(85182001)(5660300002)(7416002)(8936002)(4744005)(33656002)(6916009)(55236004)(54906003)(6506007)(64756008)(4326008)(26005)(66446008)(66476007)(6512007)(9686003)(66946007)(8676002)(76116006)(66556008)(508600001)(316002)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2djend4ZGtyaVNPRFp0cmEwdkttQW1wam9nbkljc3RhYVJQN2JSc3lFUERC?=
 =?utf-8?B?RzRIWkdqVzR4YWtzZTFGWGRQeWRNd1J4ait1cnd4V0NvWERoODdUbkE4dEd2?=
 =?utf-8?B?ZHV6NFE2cWpwb2ZIQUN6NUd5QVF2UVJudHpWaGMwSU1MaFF3Yms4R0pPSjE0?=
 =?utf-8?B?WkJ6WUhndXBlMi9Iczl6cWl3dDNaa3d6NG1TODVTS0JQd1lRV2x0QkpkalFT?=
 =?utf-8?B?YTF3NjNwMDBEK1NHQU8rc2dmNFRyV0dqU291VXUrY3pWK3ZvZjlRQ3NkNWtJ?=
 =?utf-8?B?RUpiaUdnOW9zaUJ2Tm9pZ3ZkL1BHMnUxMGtDK2RFYlV4Qk1sbTlTRU43b1Fz?=
 =?utf-8?B?ckNPelZteXJJRlB4USsrbWRLcENkWEpyaUVaMjRDVUxRYmdKWTVjOE5JOHFX?=
 =?utf-8?B?U1BQYW1Dd2l0Tks3U1VJZ2poNmFlNVYxWEdLSE9GUHRKczh5TjIwNUQxdjJr?=
 =?utf-8?B?cUVBUE5QUERKU3R1UG1TN3ZYVXBPWXkyaUxlT0M1MXlVdkE5NVc4N3U4YkZ2?=
 =?utf-8?B?cUJBZmdvQ2xBMUErSkpaOXpYTW90cVgxbzJZOGp2NjhGOFltd3RUemFGMXVJ?=
 =?utf-8?B?cGtXTFJZaUhtMG9sa29tUCtvditUYmxsbzUrVVJzY3dzREJpZnJiSEgzWThB?=
 =?utf-8?B?WDFlZHNxNmMrQkRSSXViK3BXMnVLNzhRN0o0dDJCVnBtdXNPeWM1RTlZRUxx?=
 =?utf-8?B?dEZQdFhHaDRUYk1Lb0Z1bW1nOThyaTFESW13ZmFFbVFzU0oyV05RbU9lVWd4?=
 =?utf-8?B?clRhbXZGNUozSk1OWlVRYjhvay9lKzIxL3lXVmprcTRqcTA3UEFPa1VYVVI1?=
 =?utf-8?B?RGJ5aGJQakJwL3VBNmowbXJ5dFJidGFwY29BY2FQVFVtL0RoU2tCU000VE8w?=
 =?utf-8?B?YkMxS3lYQ2pCdWVmVFpQc0xISTA0THp1WFRxMmpNVTcwSitwQ3RQZGphVWR4?=
 =?utf-8?B?YjJIeDBDQ2hpMjV5dUVUeTZNbWlKTllDMHRSa2lnTnhsZWxWSkpWV21obGo0?=
 =?utf-8?B?SFRkQ3lqMDdCSWZFMGE2OUZmMDVjRXo4YnJjZ283Uk9MZGZMdEFwcFIxby9J?=
 =?utf-8?B?OWdDekRmbmZsWkF5bWk0cXppREFWTllqMmZMNnpSWmxKVjFJZTJLTkUzR2VC?=
 =?utf-8?B?ekJiYU9VOHYvRGZlZlE1aldoZVRWbk1wUFU3TGRLN3hJVHovSFE0dWlBamdR?=
 =?utf-8?B?bW1QbWI1QjhFdGdkcW9nODlpOXBhUk4wV0lPM0d2dEZaQlVMQTdzMHEyVlBO?=
 =?utf-8?B?b2NRVGVhU1JDdjh3RjRyU01KNUtIZmZXY0duakFub0k0d3FPM3htdkg1VkE4?=
 =?utf-8?B?V2hkVytqejRzR2JwbFg4cWo2anhUY01JUFZOY2pmTkV6NlpQSWNVeko2dkRS?=
 =?utf-8?B?MVRGMVRGaTFsVXFGUWh6ek5yVzRtcjFqNzdDaWN5bTVHUnRuMFFPYms2RnYv?=
 =?utf-8?B?WWhjY3gxbWhxMlJNOVFVQk01RVJDTFVxandYOUo5WkFOWlBPR1pkS1RJK090?=
 =?utf-8?B?VG1HMlQzaVNSdVh0RUkvNVp4eFNIMWlkdmloV09pSnlPRHZycUZWOVVNdUJX?=
 =?utf-8?B?R0ZqZlZ0MnNyTmtDNWZYQXpBN0NMT0ZJN1lJNHAweTl5eUQzMWhPNFdHMGFn?=
 =?utf-8?B?NmVNaW03K2xtYTFQQVd4VVY5dHhaYWJaTUprck4zVHBYZTJGbDZUbHZIN1NR?=
 =?utf-8?B?YkYzaVpuUWhhcFdGbCtSV2NESWZFL1ZUQ2wyVTVoMmQvaS8wazlZN2dvd21I?=
 =?utf-8?B?ZXFOdm5lQWpqQVhOQmU0ZW9xa0ZCWlU3U3dXS1UrUEE5S3BqTEZ3NTVkY3RZ?=
 =?utf-8?B?dHpwV1gxcVV5RW1CSmdKdC9nVDd4QXZaYW4vcjAvd0tOZi9uay9uTCtIQ2d0?=
 =?utf-8?B?V0pqNFExNnhvU1pNZ21yT0lQUzVtTEE5QU4xOHVQd2JZSEQ5VUx4aXlISTlT?=
 =?utf-8?B?bUlIZnAxalk1MFZOQlFOSkNJU1Q2SmNGeG43VmF0REZSZDF0WWl3bkt0UU00?=
 =?utf-8?B?U3hSTi9seUY5R0w2cm9ZdUpCMitCQnVuNXhITlhFY2pQcE1EbXZQeHJxbVNn?=
 =?utf-8?B?dGlTcmlYeGFvWnIvVmV5TXhvMmhDOXZuOWkveTdqSy8yQzF2UEZpNVVoblhk?=
 =?utf-8?B?c3lWcnJIR1JHTXA1anZrY3VjRnpkbGQ0MFJZWEFkT2FHV1ZQcmJiTjlzbUZF?=
 =?utf-8?B?L2Y1MWJBSXlOS0VsRUdGZUdqbkFDbjh1eHhIamJVeFRqNFpsM2l2ZGd6YUlq?=
 =?utf-8?B?eklkSHBsNlQweFBkMDRibHdVQXM1djc4TGZsdEEvZDBnKzNwYVlYSjFxZlE2?=
 =?utf-8?B?WVRFdXRZbjNWVEEydkRhWFNaWmNOdDNvUlRnakRHZDY4OE50VmdvR1RPRmZp?=
 =?utf-8?Q?fVxzgedGuppIVYjs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <115A35FFAB58DE42ADFC3A2A9900F287@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa070e3-2c6d-4a02-ce0c-08da26580e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 01:08:06.6629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jn2t9aCK2T88VAen2H6Ak9gtqV6DPJVSps63EEEEW+M+lg03pbwFCTfQJwTVXvBAZuGB3OR58X5RGy4UrmNjHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8680
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBBcHIgMjQsIDIwMjIgYXQgMDU6MTE6MDNQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVGhlcmUgaXMgYSBidWcgaW4gdW51c2VfcHRlKCk6IHdoZW4gc3dhcCBwYWdlIGhhcHBl
bnMgdG8gYmUgdW5yZWFkYWJsZSwNCj4gcGFnZSBmaWxsZWQgd2l0aCByYW5kb20gZGF0YSBpcyBt
YXBwZWQgaW50byB1c2VyIGFkZHJlc3Mgc3BhY2UuICBJbiBjYXNlDQo+IG9mIGVycm9yLCBhIHNw
ZWNpYWwgc3dhcCBlbnRyeSBpbmRpY2F0aW5nIHN3YXAgcmVhZCBmYWlscyBpcyBzZXQgdG8gdGhl
DQo+IHBhZ2UgdGFibGUuICBTbyB0aGUgc3dhcGNhY2hlIHBhZ2UgY2FuIGJlIGZyZWVkIGFuZCB0
aGUgdXNlciB3b24ndCBlbmQgdXANCj4gd2l0aCBhIHBlcm1hbmVudGx5IG1vdW50ZWQgc3dhcCBi
ZWNhdXNlIGEgc2VjdG9yIGlzIGJhZC4gIEFuZCBpZiB0aGUgcGFnZQ0KPiBpcyBhY2Nlc3NlZCBs
YXRlciwgdGhlIHVzZXIgcHJvY2VzcyB3aWxsIGJlIGtpbGxlZCBzbyB0aGF0IGNvcnJ1cHRlZCBk
YXRhDQo+IGlzIG5ldmVyIGNvbnN1bWVkLiAgT24gdGhlIG90aGVyIGhhbmQsIGlmIHRoZSBwYWdl
IGlzIG5ldmVyIGFjY2Vzc2VkLCB0aGUNCj4gdXNlciB3b24ndCBldmVuIG5vdGljZSBpdC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPiBB
Y2tlZC1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQoNCkhpIE1pYW9o
ZSwNCg0KVGhpcyBidWcgc291bmRzIHJlbGF0aXZlbHkgc2VyaW91cyB0byBtZSwgYW5kIGl0IHNl
ZW1zIG9sZCwgc28gaXMgaXQgd29ydGgNCnNlbmRpbmcgdG8gLXN0YWJsZT8NCg0KVGhhbmtzLA0K
TmFveWEgSG9yaWd1Y2hp
