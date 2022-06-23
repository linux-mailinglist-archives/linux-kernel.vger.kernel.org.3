Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6155750F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiFWILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiFWILP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:11:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE447ACB;
        Thu, 23 Jun 2022 01:11:14 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N0wceo005143;
        Thu, 23 Jun 2022 01:11:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=n4/auodOh+q3ZWvhQeh1y5fVLijBkvjncAa96rEwYP0=;
 b=hoVQIVNDLVKi4k0nFMudhTW3hBewgC60vgWcYBkIYx4OFZHAsvI3RCe3lGoczz434CAN
 SYYmVAyYb0/HGyteYByAT3HqhwaHdky69xTAmRKkvug0oXMCAS4sgF6WiYTcBql6+IaH
 4UfUUYlGrn+NU91XCniv79sg1b70u5l4ctY= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gv51n5n0q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 01:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQL+gnnG/+6kdYH7IO5cQSP5JvD1Mjy/8Ch9rh1Hj8HDXV+onJ/92xGTey6CmY7lMxB+3sW5jUKrH6jmIL0MYjniBr7Fdrfkc8H6h5Ta+Bu53xpfBwCdLnIkzK/lFQ4lveRQqY7jDmHqNOG5WhB+0nWZnUD6OvXtv612v0gFJaCJQnUflYiCpkhaQle/tNXNssLrfmKdOAQ+ZctPCRTh1CAw0Es70tDxC5UIHqv4fGpnxjoBmSOcxEpMHkndIArgpxfb7tcsYm+yxBECydDwwFZCLsREd/LlDVYtahSHkzNSfcwyv7zba6U7Dilq2G0Beq4u4JfPt8bBLdDh1pN0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4/auodOh+q3ZWvhQeh1y5fVLijBkvjncAa96rEwYP0=;
 b=KBqOR7QIXrVee5tB1HntPI3XV7cAtFZJBr78iwX1t341N5/kdmgxiC1xwLRosLA1BJLg2/SLhL9M6cGKy6Yn6Ai+IJ2p4s7U3rRWWTIgWX4wJhSetVpR1vGPZMAwyFVqpuItcloEAtlEASCd5zD3bmFBU9Lqlz7cR4I3xELHkwrCI2iW6El2DnQmuZXYKXo0Hy8zJLdOjWICrESiIAM/zT83uBtEP6H45wNKJqAn2Okhyrlm/cQo1itrXTKKGCD7jYouevprUx/TN+kvYPJSSfTHC/aq1SirFXAsMIIlCv0f1Aa4byWiFXR2L9bL+7u+iZfFa/ejLkO5rrQTVh+Seg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4854.namprd15.prod.outlook.com (2603:10b6:806:1e1::19)
 by SJ0PR15MB4550.namprd15.prod.outlook.com (2603:10b6:a03:377::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 08:11:11 +0000
Received: from SA1PR15MB4854.namprd15.prod.outlook.com
 ([fe80::f0a8:296c:754f:2369]) by SA1PR15MB4854.namprd15.prod.outlook.com
 ([fe80::f0a8:296c:754f:2369%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 08:11:10 +0000
From:   Dylan Yudaken <dylany@fb.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Thread-Topic: linux-next: Fixes tag needs some work in the block tree
Thread-Index: AQHYho7eXwzDjzZtZUanpQimpadw2q1cFvqAgACNfoA=
Date:   Thu, 23 Jun 2022 08:11:10 +0000
Message-ID: <587b0d70ac117e7eb2b6b1f2e0f6996c9f960c53.camel@fb.com>
References: <20220623092143.2b9d2e7e@canb.auug.org.au>
         <fb6f3d33-2d56-cf3b-25e8-85c24dcbb3d8@kernel.dk>
In-Reply-To: <fb6f3d33-2d56-cf3b-25e8-85c24dcbb3d8@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81b8de8d-f716-4d59-989c-08da54efeee5
x-ms-traffictypediagnostic: SJ0PR15MB4550:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4550E7F3331398D49E9316C7B6B59@SJ0PR15MB4550.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVIcmUILX3kwXHo3+9UekSjqqqOlKqBvg7zml1cb0yGGh1Ws2zMX5LUgpRAMKrmW87bdICyRJE/VSJrv/hpenKgu2YDX5rOEj55lpeqN9QO5Fvu1nGQjXOTMirvN539IG4QdLO5KJYaie85pTVwct61+Lm2K35f4PCcmVjwiFBjaRBsxtYMo+ZDPfobTtSoqkxgTAVcqR29Mi89LJZJEEZJIgdBjiqtUmXj70RQlqwdcsQ3PHfr5dYSZuC63gsHQUwHGY4FMWYO+uVsF9GP6zMACVNP3S+z9fkV8ij8uxKFNkIbyksX332KJT7tXe32X083bSgG6pp5rS8g+bHm005Kocc28NRLxl55TKHG5H1jYd4oTeq2oQvsoT7yozrbiAuurJOj6xoF4hjMDP6E5KC0GbbME2w5+9WNLBQ/IybKCk+LnEBu7CaI0fJBxHU3y4c+HRYIKWQxf0koIYsWXiNkcE9jafuSpc845mIkiCfWYmeuQIT4eWmti5nHO8VeQXBv9jw6iuAooDE+qZ3eJw3t78AJeu3XmN/gq5++cRtX0rSl68nZ0P17YhqGRZ/b1D+JHyTGiCxDXCUHCmUlOXJlZX8u4zLBoDNZSEBPzKOYbwMNl6JL8duPd8HrIMJeI1eQufzIAKIMwEgSWQDMNRXPBhjvvVne9+e/F7SjMJ1BFoxFnwVn/rQbCVjxhF7tAz19bRj8RiLoSzdhH7jA2Qg+TNvBa6+8ElyTufNnisyufMd5YX/WTkx/r/bsBtzymSVlvckPeZsX0/BCjLyHfng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4854.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(71200400001)(8676002)(41300700001)(53546011)(91956017)(4326008)(122000001)(478600001)(64756008)(38070700005)(6506007)(66476007)(2906002)(6486002)(86362001)(8936002)(4744005)(66446008)(5660300002)(6512007)(54906003)(110136005)(2616005)(36756003)(66946007)(38100700002)(76116006)(186003)(316002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHJSN0hvaks3QndRYmJnaVE3MjlHUUI0NUc3aXpSVGdPaUpjMmQ5SHREdU9C?=
 =?utf-8?B?aU1xTTA1bFgreUZobFgvaEZrNzVRM3V2blBVRk9xTVNxcnZCMDlxM29GWUZq?=
 =?utf-8?B?K0hIK0t1N0N4Mm9sWEY0Y01SNjd0bjkwVGZFRmVHQW5zVGVMTk1EcmVCWEJZ?=
 =?utf-8?B?NWxIUCs4R3h5L3VSeWZFSThOcnFrUFFDR2Fzb0tOaU1kTzB0b01DYVNnQnVO?=
 =?utf-8?B?UXV3OElKWGtEMUpKWnhTc0haeENBMDU4WjVYb3JMM0tLRjR6Z0FCVHNIbGxm?=
 =?utf-8?B?UldMeW5DSjRLbDcrdi9LTy90dlZSV0QwMWVCNURDbGZ3OURTUXhOVWpZNk02?=
 =?utf-8?B?Z0ZWei9aRXZid1ZwMG9hVzZtL1AwdkIvOGxBcW02MjhtalpVMnc0SFlIeU1r?=
 =?utf-8?B?TlAwaGUzMUNwMzljbmFwYkk5Z2dsRW1mMEpYYmZDUTcwd1RJUEVSMjdxN1RX?=
 =?utf-8?B?MDBEYkpPb25Pby9QdjNORkoxNXZ2NGpueS83U0wzbkJ6OEt1d0JEcnRoaEM3?=
 =?utf-8?B?YlM1aThyQW1STWdSQ3lsMzNNZU90ZGlSMmloWTViQmR0Y3M5TTBaY3VkejBl?=
 =?utf-8?B?RmJsWFNHb1lkcUN2Tkl4TGlFbXhWRkdaTWRKWk1tSEF4Q2hpR0p0aHBYQXdk?=
 =?utf-8?B?VUxCR1VvSjhWYm03ME9OS0d0anh3VmhjaXdvcVp3V2k3aDJjZENYVXF3V1pQ?=
 =?utf-8?B?Mlp3cWtVckozS1dKK3ZIZUlCd2tZODYxT0J1QUR3dGhRVUVjNS9SMVpLV1Vt?=
 =?utf-8?B?TmNGbmVJS0ZEd1hOS1dsTmpzY3QyL1prUXlMK0J3VXJCR2h1NzNXVjFpTHlY?=
 =?utf-8?B?M3FBS3YvYThLelg2KzJDN21nUDF6M3lXckJUcVVtamZTREFETG8raFMvdmtT?=
 =?utf-8?B?N2NETnBreHo1UDlzQTJTb3ZzVGVoVUZ5eGlZbVBqRmNwWEtUaVBsTkZ1YnFm?=
 =?utf-8?B?TlJBS0JadE1ncXg5NmJIVDU1U24vZlJEMUZLYUk1ZWNBR3lxbVFFRnk5UzIz?=
 =?utf-8?B?T0pYYjBuRzM3UXlMOXJFb2YrcGtDbWxsTEZnSXlvQXNZTXhNUnVmODg4c3Nl?=
 =?utf-8?B?a1dpMnV2Mjl0SVRZcmlrcGtaMGMyQVh5ZElDS2o0WXNCWElrSUtiWFM5K3RE?=
 =?utf-8?B?N2xhQnJ2MEtBczZhRVorR3h6WDh1YXVTTGd2SmRaTFdoVlZTWVhFbXBoV2xi?=
 =?utf-8?B?VGFla2tBNmw2a0NuNjdxQUlEVDg3cHNqbnZZR3hEVnc2OUpkcXRlZE53UW80?=
 =?utf-8?B?ZGxuR29NeGdBNDlqdnY4MmViSkU0eEFuVXFpcmxXS3pTM2VJZ2RtcklRTkpJ?=
 =?utf-8?B?RnRINjNtRENRaFovZFJGNm1qRTNMZTBOQStaRkxIU0Z5VDNOL29jQmltRXo1?=
 =?utf-8?B?cms2T2xoMGNtTW9HZGdmYkZROVBtZXN4eVpsK3Y0djJCdDViMjBJNSs1RTlH?=
 =?utf-8?B?QllJSmlWQmh0YjN6YTdjVWZhc29DYXBLMEZwL0RGQ2JFajdlbEtIcEJGYkxH?=
 =?utf-8?B?WDgxWVJ2dEJycEpDbGtTcDhpdk1XdXFGWmg5eG03b0Z0cm53S3FtUkZKZG82?=
 =?utf-8?B?TlZoVEZGL2xmVC8xTXFMM1JERU0wT3ZSbndqLzdlczRRbVZCQkIyZFF3RXJN?=
 =?utf-8?B?QU9Ib3FxUDd4ejlYa1dUYVBuWlNXY0J3OHJyVTZocEVKa3VPSnlTRlUrTEFa?=
 =?utf-8?B?WmFzYVBpNENBYVlxUDBVT0t6aGcreWtmeFBNNnRhRWpCSkRwSkh4NjJIRlVY?=
 =?utf-8?B?TndxSjg1c1AxSEM0d0ROL3ZoMFhTeDhsS1AwV0tFdFdVU0l6UEpPOHUzVFh1?=
 =?utf-8?B?T2NpQnhvY1lTbUU4dEtMb1hsMFlMS2ZLNmxxK1hXN0JITjNyRzM3QnhjTGV6?=
 =?utf-8?B?SGFhNWdBQzV0QzJYQnJtSDRuZW82SjNGVVE1MXZydmJDN0oxL3FjUEd0SHVo?=
 =?utf-8?B?TlJwL3pOY3ZISDhhaStmeE1Fcy9OSm9rOXhFY21sdElZRTRkaWtRSlB2Mk9q?=
 =?utf-8?B?RnFjY2Y5aGhoR0ZDWkRCRnJCZnRUandmRGRFdDNTZzhyelpoblFOK2JSZVM5?=
 =?utf-8?B?TDd5YXlKZUwrbTVNK2RtUVhCK1lCcDE1VVVSeHRjYVJ2UjgxWXM1WC83clVX?=
 =?utf-8?B?WU96bFJWdEJwa3dEQ2xqeG5ZeElSRWlFSlMxV2JPdEgrQ2hIOHJxWFlHMzZQ?=
 =?utf-8?B?MUtjVEdxZVNiMCtmclhqdi9ENVowR1hDajZnWlJMMi9XL0pycDhGdmNyckEw?=
 =?utf-8?B?WTNaVFJSOE1hdUFQM1lXMzMraWs4ZUlOWkN2dm5ZWUExUkVpVXZnY2w3KzZJ?=
 =?utf-8?B?d0RwTmsvQllPYVhFRjNqTGpXWUsrMm5YWEU3VTJOZnI1SGlNaC9tYW1PUEpK?=
 =?utf-8?Q?uSqi7LByXI5ccBWM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81CB354EAB18594396536EE2B8C2D705@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4854.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b8de8d-f716-4d59-989c-08da54efeee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 08:11:10.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3S2g2sttL08EADqeo33nW4OpNdaKMnCT1SKwTCUt9qT1WazeBIXER9INuT5JaRc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4550
X-Proofpoint-GUID: k1J7rN7hqkSV_ki-bM6BdlYPun7ZpL4F
X-Proofpoint-ORIG-GUID: k1J7rN7hqkSV_ki-bM6BdlYPun7ZpL4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_03,2022-06-22_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA2LTIyIGF0IDE3OjQ0IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biA2LzIyLzIyIDU6MjEgUE0sIFN0ZXBoZW4gUm90aHdlbGwgd3JvdGU6DQo+ID4gSGkgYWxsLA0K
PiA+IA0KPiA+IEluIGNvbW1pdA0KPiA+IA0KPiA+IMKgIDFkYTZiYWE0ZTRjMiAoImlvX3VyaW5n
OiBtb3ZlIGlvX3VyaW5nX2dldF9vcGNvZGUgb3V0IG9mDQo+ID4gVFBfcHJpbnRrIikNCj4gPiAN
Cj4gPiBGaXhlcyB0YWcNCj4gPiANCj4gPiDCoCBGaXhlczogMDMzYjg3ZDIgKCJpb191cmluZzog
dXNlIHRoZSB0ZXh0IHJlcHJlc2VudGF0aW9uIG9mIG9wcyBpbg0KPiA+IHRyYWNlIikNCj4gPiAN
Cj4gPiBoYXMgdGhlc2UgcHJvYmxlbShzKToNCj4gPiANCj4gPiDCoCAtIFNIQTEgc2hvdWxkIGJl
IGF0IGxlYXN0IDEyIGRpZ2l0cyBsb25nDQo+ID4gwqDCoMKgIFRoaXMgY2FuIGJlIGZpeGVkIGZv
ciB0aGUgZnV0dXJlIGJ5IHNldHRpbmcgY29yZS5hYmJyZXYgdG8gMTINCj4gPiAob3INCj4gPiDC
oMKgwqAgbW9yZSkgb3IgKGZvciBnaXQgdjIuMTEgb3IgbGF0ZXIpIGp1c3QgbWFraW5nIHN1cmUg
aXQgaXMgbm90DQo+ID4gc2V0DQo+ID4gwqDCoMKgIChvciBzZXQgdG8gImF1dG8iKS4NCj4gDQo+
IEknbGwgcmViYXNlIG9uIC1yYzQgYW55d2F5LCBJJ2xsIGZpeCB0aGllIG9uZSB1cC4NCj4gDQo+
IER5bGFuLCBoZXJlJ3Mgd2hhdCBJIHVzZSBmb3IgYWRkaW5nIEZpeGVzIHRhZ3M6DQo+IA0KPiBb
cHJldHR5XQ0KPiDCoMKgwqDCoMKgwqDCoCBmaXhlcyA9IEZpeGVzOiAlaCAoXCIlc1wiKQ0KPiAN
Cj4gYW5kIHRoZW4gSSBqdXN0IGRvOg0KPiANCj4gZ2l0IGZpeGVzIDAzM2I4N2QyDQo+IEZpeGVz
OiAwMzNiODdkMjRmNzIgKCJpb191cmluZzogdXNlIHRoZSB0ZXh0IHJlcHJlc2VudGF0aW9uIG9m
IG9wcyBpbg0KPiB0cmFjZSIpDQo+IA0KPiB0byBnZW5lcmF0ZSBpdC4NCj4gDQoNClRoYW5rcyEg
SSdsbCBhdXRvbWF0ZSBpdCBuZXh0IHRpbWUgYXMgb2J2aW91c2x5IGJ5IGhhbmQgaXMgbnV0cw0K
DQpEeWxhbg0KDQo=
