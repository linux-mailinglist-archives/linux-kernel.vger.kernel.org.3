Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3368E58B02A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbiHETEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiHETEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:04:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214EF7B783
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:04:35 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275HHHJu025111
        for <linux-kernel@vger.kernel.org>; Fri, 5 Aug 2022 12:04:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I+TpUrL2m2zcOkJPEoKNy3V1UV2wgO8ssqGBt0htFQA=;
 b=i1lEnoW6IhAoz7tp4LttNK6njG1n5MHad9z9V3DaJCqeOERT9vwrRk16ZDd3135HyjhE
 3r13XBt1ixXNnCHWhgk2NdUdwPuhi407WO85Tc/awUhU8F7darCijIggV7EB9gUP8vEy
 XNOMEgohXZj1pxGS83eUR9iyBEyXuZ9K0C4= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hryy23dx1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 12:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eODw6rT2GznjmlGk0R/DjzVdzs/Su5D3iqkgdZ9I305TVYHz10E7Yhk+MN6ZxAYjZcpKVFmfaN0lVR2SpC0SQHAUq9cPQTshSCLdcmmmtQgb+n90iGllHGUyw59D4PEkHoGeOw8dEgI5a5HiFgd911syBFsHYV9opMi9fShOP8DwCDn/WCIIOOJjPCr8KpojsIRO0rmY8jtPapdEwIrXI0rEJbUr1F+FJBKp0FnX27ndqdSmEf6OxJT5Scr6lsEU/24ZcBFimXVFLVlsmxsBjWXxKVYdaNWW1WFvHWUzPduKwHMoDPmkz75gwR1T0XLNXRVHXgjzo71tFrvojjMFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+TpUrL2m2zcOkJPEoKNy3V1UV2wgO8ssqGBt0htFQA=;
 b=da3PJ/j2PDnERvofIkCpvS+tczugsTgX2qfNYcxszofV7KPhl6tF1KIEe3st3nXV4x44iA7wbQ+U7PF/t0n6GGVueWpUTleLIJLX8xP0pmsUhjrWdFCHlVSnF0SUAJA5NPyo8/aO8Xrjrdd10uI0Dtcl8ekF4br6Fu4DMlPXt2JZFAsk/D1SIcKyw2MTYloT2UFZW/6sqbMZ6u2jNEbWHYhRSBsVJf613ooZph9EzF+Yiqcx1xULL95RfF5rD9HhyEfr8WmYocSw0CoXe0whPDE/oc2YuHbFc5DRJGExZ7mqiXoqGPd8te5KrpYiQjYXgVZAKNIly0GZV2YSUPZG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5263.namprd15.prod.outlook.com (2603:10b6:510:144::10)
 by SN6PR1501MB2143.namprd15.prod.outlook.com (2603:10b6:805:11::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 19:04:31 +0000
Received: from PH0PR15MB5263.namprd15.prod.outlook.com
 ([fe80::81de:e716:a182:4ef6]) by PH0PR15MB5263.namprd15.prod.outlook.com
 ([fe80::81de:e716:a182:4ef6%4]) with mapi id 15.20.5504.014; Fri, 5 Aug 2022
 19:04:30 +0000
From:   Rik van Riel <riel@fb.com>
To:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>,
        "willy@infradead.org" <willy@infradead.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Index: AQHYqPrUsoqGdDLt+U2hECHNyZy0Q62gpnsAgAAD74A=
Date:   Fri, 5 Aug 2022 19:04:30 +0000
Message-ID: <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
         <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
In-Reply-To: <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59be5119-d5a0-4656-cf0e-08da77155365
x-ms-traffictypediagnostic: SN6PR1501MB2143:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lSBKLE2L5zbm5J7ltfDD5EiPo5R/H+MKqk6P8ytMg33f+F5WagWApebJx4bgO3gMydJfwIU9ZiuWRcGJFYbR66m6rTAI8DcauHpSh+/fg39/KTV3eGsZ6kNRUyn08wnpWZacAlz+uiLUE4CbLgEM9RmIp7XrDOHfHQQK8uJ7+1CFIYuEfa/qIBiAFzkJgXguX4UqtXFQg6RCKtVH7qk+Lb6GQxdjncxS9iVmzFRb84rUG/YkKqRyIyo+HEOxoXAOPXQwU+XMXoZyF5fnxgYR/WADaKXwkWM3iOY2+MP2twx6J/hv2Sf8jfXowWK3g7Wgda4iqaCTzp4Gpl3Sb+JvB7eFXCz+QoUM7i55NsNlV2HkkIiBcgaGNxzIF6DIQoFpbAEqP0AaMCVrZxswDQbTfzSMogC/anE8kKsjyi8Fv65nZ/95au+jkDpOs/5F2kWuw+Zrc22BGdTBsEyZh5sjSb3emEYQFrD2BtdcXU9DQTZeWQlzzWkZXHs6YAn73nggF1322E9N0HVmqX3W4a3yTcbD2ABFxpEzwhHElR3dNRYDc0D3Mexbc0+YSU7tt2PiIfS4UgMBy0nZXZw5vk/0W5rd5/gu0UaxdJ/wc1TIWyHzlBz5NtW8MJmo7LgjZqDetMng3WEuEfPWKWwkoAJ7wMIOOftMDUIV9Y/m72cnBDllpQ4VJSKsodrVdQWKIs1QfWEAOSt0+CRnrxXBHT+F3LOx6Q12rgiLfmZf4u/khNjBbFSSwwuFn29PXvFjzNHF+lNC+ybra8IPtfw+kUnhEVzRDK9ON2lbmTIr0vOn1tw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5263.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(6486002)(71200400001)(110136005)(478600001)(41300700001)(86362001)(38070700005)(6506007)(36756003)(6512007)(2616005)(316002)(54906003)(186003)(83380400001)(8676002)(4326008)(5660300002)(64756008)(66476007)(66556008)(8936002)(91956017)(76116006)(66446008)(66946007)(38100700002)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3AvSUhVRjE1K3AzVko1aTY4OVh2Q3IwM0g5a2lWaWREL3RDSlBQNVhQMmxL?=
 =?utf-8?B?dTdnSURQNWtIMFlzNGUvbGpxM2JpUnpZbWoyTVcxMUpsbXh6YThUQXhpMXl0?=
 =?utf-8?B?MWVHeDJDbldMWXR6VFFpTjB0ZnhKL2UvaU55NERQOStXcklxTlJIUUZHTTQ0?=
 =?utf-8?B?Y3ZhZXdQeWFzSnRWOGdJaXFVSnFRQmtkMWorQ0tsNmRyZ3oxUEsrTWhkY3lp?=
 =?utf-8?B?OTJxa1U5ak1DMUtKRWEvQkZ2Q3g5dFdRQ0lONkFiVkkvemQ4SFpsQW14WUlF?=
 =?utf-8?B?SThiUXlNUGhrNkRRMzFjVVZlY0IzVTJtaTJDTXZKSlpxZjdzSmlZd0RXbmpp?=
 =?utf-8?B?WlVDdkJESDFQZm5tM2lEeWpsYU1Lc1o4bVBHZVNrbzB5ZFptQmd6Q1JncHdK?=
 =?utf-8?B?SU5wS1I0MzY3YjJLWXJONUNSaWlXRzQycnUxNTJEWlRZOU80WVp1RW96L2dR?=
 =?utf-8?B?Z1lHYmhndGpmUEliTVVXbGx5d3hRLzN3TkpsL0MxaXZrajUrV2lyVVBKR0Ju?=
 =?utf-8?B?ZHlCVGdNRDZOaEZYZk9wNW42aEE3MkRyQ2xxWjFYRjBCZWQrVG05ajJtbDJa?=
 =?utf-8?B?bzVRdW03NjFBQThSYkhmMjZjZGU1ZDJzaGhXUnJFT1BqN20vV2JHMGRUcG1k?=
 =?utf-8?B?dlgyY05FZUdwR1c4Wm1UUVJtRG1SZm9tN2g5YkFYL0FJUnYyc1U4TzVlOWZQ?=
 =?utf-8?B?Wi9GM1BFN1lOQkhpT2lLOWtTaWd0dzloZGlXQVg5cXJrc1pjR3JZOTJZR0lM?=
 =?utf-8?B?V25JcDZzSm9TOXdlaS82T1lPTUJBbWpEZXo1ektnS2FPcGEzaXRKTDJ2UDh3?=
 =?utf-8?B?cDh4bTlFZXBoL1FXTU1waEZWYkFncG9DakV2ZllaTTJGS0UxMGthU29xdEVx?=
 =?utf-8?B?VklHTjZFMHJqdUNFdTNGdXhPN3hvYjU5QWEvUmpOVmlsMWlCZTBzQ3RQYit4?=
 =?utf-8?B?MklYU05CaHBldnczUjNiYVRFZ2lHb2xJYjBTMFVGUE9mSVNwTjhHNSsvMHli?=
 =?utf-8?B?RTdnT1RoM014NnVGeGZnaVNKZG8wVkg2QU53b3A4amw0Nm9wTzhVbWpXSlhL?=
 =?utf-8?B?QmYwYmd2T1NLTXVBV3UyLzBKTTJiaE52SmtnZkc1WFlnVllzT1pBZG4zR0JS?=
 =?utf-8?B?R01rSUIxaWFrSFhkdlpmRTcrWTlUdFJrVE9NbGRPaWVhaUtwV1liaGxadE9M?=
 =?utf-8?B?MjlTeFJUdFZzS2hjYWU3RGVHRTU0MUU5OU9nT1ByN3RsOFg1V2pVU29adWpw?=
 =?utf-8?B?RUdPSDJ6a083VkdHd0E5aFl5UHBsdFZwc0lFOG1CSkhkRGo2OGFrZ0N3NjBw?=
 =?utf-8?B?MnRXNjRyUzI2elNGd1UvZmM3NEhQU0gxaE5tRGg1di9zUkViSVlyQ0lUTmtI?=
 =?utf-8?B?K1lqekhhaVpNekloMWViblN2UXVRUTNCOEJobHNmZFM5TlNJTVBKZERDVUdH?=
 =?utf-8?B?bEplclpGKzZVV1gySnI0OGZqM2YrTC9XZmRNRTZXbzBnZHRCYmRYYm5Gbzkz?=
 =?utf-8?B?MDd3aEdTMFJKS2c5VER2Q3R5aTFsSG80SGFHc2FmalhlbHpFak9RcDd4ZmY1?=
 =?utf-8?B?L0xnR0pjdzZCTVAyeWdJVUlPOHF6NVUrV3MrZ2lkNEpFTFBkb3ZaV0FRcHpX?=
 =?utf-8?B?Z2dSOXZ2cExEeU9JYmdqM29vRkJ3U1V6TzgrZUVZTmI1eFUyelViRENmRk5o?=
 =?utf-8?B?YVFZVmlqMWRpQnlWNmJpT2grQmJySmcyTFpwdXBhalk5b050U04wQWFkc3FK?=
 =?utf-8?B?YklhbjRGbnJBRytjMC81M01acW5NNXdsbS9LY3pEbUpveGprZkQ0M2NOTzhN?=
 =?utf-8?B?eDFzUkdxQjduYzVZUW9FcmxIU2ZhMDk0c1BrOHd0R00xaEY4UENvVWN3YWZE?=
 =?utf-8?B?VlBCNEw2WDA1dVpIajBHWG1kN3pmK2g1d25rTi9FK0RUdWZBRWNBeU04OHdO?=
 =?utf-8?B?bVdjL3NIZnNsTTU1dlRvVzhha3ZLYXBKWUtGMUNicTErcDdUY0xpNnN4Nng4?=
 =?utf-8?B?SnozcmlyZGl6VlBTblc5V2luZDFhY21NcmNnNjkzc2ZVZUV2b0J1KzVPQ3d6?=
 =?utf-8?B?MHFFeUxIbEk5Y2IrcTllWjVaenJrNkZzVUw0WVlEUGtlaWZGT0h6bkdka2pQ?=
 =?utf-8?B?eTJyL3RiT1NrNWl3TXA1WldSTXliZWRDTzYrR0N3ZmJ0TWZTMW0vbHhKMzQ4?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73350C8CF5BBE745AC33454DD39B7895@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5263.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59be5119-d5a0-4656-cf0e-08da77155365
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 19:04:30.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ys5dNFXg6AoGps2n19670GTXH9p4h0pGNDd7KKXvP+HksVVuVP+i6hXn9I+oPeZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2143
X-Proofpoint-ORIG-GUID: LStrfYGcJxCTHg8nLoVq33vf-jAHDIyD
X-Proofpoint-GUID: LStrfYGcJxCTHg8nLoVq33vf-jAHDIyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_09,2022-08-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTA1IGF0IDE5OjUwICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gPiANCj4gPiBUaGlzIGNoYW5nZSBpbnRyb2R1Y2VzIGEgdG9vbCB0aGF0IHNjYW5zIHRocm91
Z2ggYWxsIG9mIHBoeXNpY2FsDQo+ID4gbWVtb3J5IGZvciBhbm9ueW1vdXMgVEhQcyBhbmQgZ3Jv
dXBzIHRoZW0gaW50byBidWNrZXRzIGJhc2VkDQo+ID4gb24gdXRpbGl6YXRpb24uIEl0IGFsc28g
aW5jbHVkZXMgYW4gaW50ZXJmYWNlIHVuZGVyDQo+ID4gL3Byb2MvdGhwX3V0aWxpemF0aW9uLg0K
PiANCj4gT0ssIHNvIEkgdW5kZXJzdGFuZCB3aHkgd2Ugd2FudCB0byBkbyB0aGUgc2Nhbm5pbmcs
IGJ1dCB3aHkgZG8gd2UNCj4gd2FudCB0bw0KPiByZXBvcnQgaXQgdG8gdXNlcnNwYWNlIGF0IGFs
bD/CoCBBbmQgaWYgd2UgZG8sIHdoeSBkbyB3ZSB3YW50IHRvIGRvIGl0DQo+IGluDQo+IHRoaXMg
Zm9ybWF0P8KgIEFGQUlLLCB0aGVyZSdzIG5vdGhpbmcgdXNlcnNwYWNlIGNhbiBkbyB3aXRoIHRo
ZQ0KPiBpbmZvcm1hdGlvbg0KPiAiOTMlIG9mIHlvdXIgVEhQcyBhcmUgdW5kZXJ1dGlsaXNlZCIu
wqAgSWYgdGhlcmUgd2FzIHNvbWV0aGluZw0KPiB1c2Vyc3BhY2UNCj4gY291bGQgZG8gYWJvdXQg
aXQsIHdvdWxkbid0IGl0IG5lZWQgdG8ga25vdyB3aGljaCBvbmVzPw0KPiANCj4gSXNuJ3QgdGhl
IHJlYWwgc29sdXRpb24gaGVyZSBlbnRpcmVseSBpbi1rZXJuZWw/wqAgVGhpcyBzY2FubmluZw0K
PiB0aHJlYWQNCj4geW91J3ZlIGNyZWF0ZWQgc2hvdWxkIGJlIHRoZSBvbmUgc3BsaXR0aW5nIHRo
ZSBUSFBzLsKgIEFuZCBhbnl3YXksDQo+IGlzbid0DQo+IHRoaXMgZXhhY3RseSB0aGUga2luZCBv
ZiB0aGluZyB0aGF0IERBTU9OIHdhcyBpbnZlbnRlZCBmb3I/DQoNCkFsZXggZG9lcyBoYXZlIGFu
IChpbiBrZXJuZWwpIHNocmlua2VyIHRoYXQgY2FuIHJlY2xhaW0NCnVuZGVydXRpbGl6ZWQgVEhQ
cyBpbiBvcmRlciB0byBmcmVlIG1lbW9yeS4NCg0KVGhpcyBpcyBhIHJlZ3VsYXIgc2hyaW5rZXIg
Y2FsbGVkIGZyb20ga3N3YXBkLiBJIGFtIG5vdA0Kc3VyZSBhIHNocmlua2VyIGdvaW5nIHRocm91
Z2ggdGhlIERBTU9OIGluZnJhc3RydWN0dXJlDQp3b3VsZCBiZSBhbnkgc21hbGxlciwgZmFzdGVy
LCBvciBiZXR0ZXIuIE9UT0gsIERBTU9ODQpkb2VzIGFsbG93IGZvciBtb3JlIGZsZXhpYmxlIHBv
bGljeS4uLg0KDQpHZXR0aW5nIHNvbWUgaW5mbyBvbiB0aGUgZWZmZWN0aXZlbmVzcyBvZiB0aGUg
c2hyaW5rZXINCnNlZW1zIHVzZWZ1bCwgdGhvdWdoLiBDb3VsZCBkZWJ1Z2ZzIGJlIGEgYmV0dGVy
IHBsYWNlPw0KU2hvdWxkIHRoaXMgYmUgcmVzdWJtaXR0ZWQgdG9nZXRoZXIgd2l0aCB0aGUgc2hy
aW5rZXINCmNvZGUgdGhhdCBtYWtlcyB0aGlzIG1vcmUgdXNlZnVsPw0K
