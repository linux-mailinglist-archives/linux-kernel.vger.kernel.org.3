Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F89D576289
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiGONI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGONI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:08:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5683D599;
        Fri, 15 Jul 2022 06:08:25 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26ENcYnl009422;
        Fri, 15 Jul 2022 06:08:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=VWmpzi7wuF/63Ad0VGJsvqi31KghVM59jTpV/rPbNSk=;
 b=nliQjY3pvAvCTPUMR+FyGNpoqoSY9b7xvkafNY0KoSk1BagsI436394AI12o3Rwu0RUX
 9+FZQQsc0y53jYIOM5A6+qT369eoX/SOMXFGIKCOvHuPGy5H2g8nRzDZ/JnjFNmMALLX
 usoZunMu/x8ZurMmsoYvd+rutNuMwqAtAS8= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hamy3png0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 06:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfFrjdZQFpo01RBbAARXNlxpl2g9oJ/TjQq/tteskL1Rb5Z9D19JvVio9kJjgvDAw3/sN7Yq+M/Q6JNmkYOPjRD8FXGTyNfVrTBXl0806sMBcvZjMgpA6JoqHwGu5FWu3sfK8PttLX0cWD+rUIDdfDwXZ9BAlu6OgnvJi1OEvHhXzFlw+hL1DGcO/SwW2VGzOkNg7z3xtAOJsOdt/Z8ZRW7LO3ee9plkfVsgROmBYJg4QXik6yRCLZagA6Zd2yz/1/Bj7uAOU1ZkPl7tJGV15qh5wv6X67rUw9sWc77/Wrqz+JJSLE2pcSA2mwEE13GLokEuROkDoZDRdDrX2FGAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWmpzi7wuF/63Ad0VGJsvqi31KghVM59jTpV/rPbNSk=;
 b=THNuKVQa+MEtkJhcCWhpksQ9lrGe3x7SkMP4B3tmdeZbl8qhyzsA5y5gzd6NqTqyNGJy+7zs9Uwp9O8fzdf58Fmvu4sxYWa4gnznBkzHoTR52HKMX9ddZM8tVdHMMcVLQ1reuQL8fuxZZb6sZMT+YIAc3JuisHRw9BTJuCZxrLE7MVuei7ehZCFvakH9fTNMmk4YBLgGHfsAs4imIgRgU3YrybcW1OzIDadtjFMqPkkx1HpeXFRvaGwRBS0Rd7kfdHSlTH90vvqAcNI21hNwyKurmzaZlF6THwz2OMaBsahthjvtoCTcAIhSP4Ye+d1T28W7PLK/4s8fDwo8btTe1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4854.namprd15.prod.outlook.com (2603:10b6:806:1e1::19)
 by SN7PR15MB4192.namprd15.prod.outlook.com (2603:10b6:806:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 13:08:23 +0000
Received: from SA1PR15MB4854.namprd15.prod.outlook.com
 ([fe80::15b5:7935:b8c2:4504]) by SA1PR15MB4854.namprd15.prod.outlook.com
 ([fe80::15b5:7935:b8c2:4504%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 13:08:23 +0000
From:   Dylan Yudaken <dylany@fb.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the block tree
Thread-Topic: linux-next: build warning after merge of the block tree
Thread-Index: AQHYl/5VDsDVtIP6JECvL+p2k6udHK1/XkmAgAAJpQA=
Date:   Fri, 15 Jul 2022 13:08:22 +0000
Message-ID: <9a60cc4f23f698075aff1e9d75393b31f3f58516.camel@fb.com>
References: <20220715135232.74b81bec@canb.auug.org.au>
         <20220715223351.2e8c856e@canb.auug.org.au>
In-Reply-To: <20220715223351.2e8c856e@canb.auug.org.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50eb9ec3-00de-4111-2b80-08da666318c3
x-ms-traffictypediagnostic: SN7PR15MB4192:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xD+BDSRXNc0Zcr2eCtXXzSBOVkQXq1zlLehK4oEsgYW8PzFIsX5E8PgSRhG8SKLKm3Tm9A0vQe3LaGDIgljMSbFt8ru4W1KXWk5kDQyFq63NcOzBX/hcfdtFmbUiGXBi3vJRKVfDJTRlFRnccA/vSPu944+d1V0mtVMHVSFLgMC8cIu3XRr2yJ8B05jWNqI/bzv5pSVEm5X+oNidArOC0OgSf8UE2U7HEC7QiauGsH/ThcSN3XW4GkeeTyH5RjMDM5teHQ+ludDctc/939nC0hPvmyns/G7Hhw6SVqfI+CiHneAM+9AjyaDUq4BsLbH4QJNo7ruuH8MxDn1QP89kxGh6I0OeesKtV1l37dwdsX+wap1JtfWO3HaASnoQo8op+ojWGB0mHBHf3+4CcJiP/MLFrrfsbxfvEvwgX3M2BkqxWR1O5SHVk8kPoe3W5LKJIb5ypJOpsrOuDy8vXe2b6Zz576FcGzxRVyqceZCRZxjLRJf86F8bB2QuWMX/jYlYFmb1ec63EYdvApqNeq/UGLoLTP59gjPtQMf9gfTwrE4KqDYQ/olCpthyFvYTx30b+vNs9/+bDIdQS6ZIWCeHLVWMJbmGIEz385MHNeJFiTszcRcp5ZPTOoeaqFOy4VzMVo+vlgkyXmLSwFBVXHxnY6/o/swr5KQIzSTj04uVOK1vijzx65uLfU99l9onZFLU80fYgsY0adMOKdXStS8gp7lhCeyfU2apoL7w2xFFPbm1O4sdiweuy8a6nz5zM/KrPfPFRYrk3JUP24HCFpA2LgqjJ945vFyGPiWwhEfd19f1lxhmnw9fqZXbyaskt/Fp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4854.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(41300700001)(53546011)(6506007)(6486002)(186003)(478600001)(38070700005)(122000001)(6512007)(38100700002)(2616005)(83380400001)(2906002)(71200400001)(5660300002)(8936002)(36756003)(66446008)(110136005)(66946007)(76116006)(316002)(64756008)(66556008)(54906003)(86362001)(66476007)(91956017)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c09aVTIrNW40UHZTak9GVDZIcWJVRFNhS2FkNFdoTWRCejBZbktYU3NwMm5n?=
 =?utf-8?B?b1FadFdsaEljMFgwVE1KcUNzbURFOUwyUjhQditDNFkvVnhNRk16LzNaeGdN?=
 =?utf-8?B?QzNORmk5ZVN4aU1sUU9YaWFrcUlOUTM2RVBWRWRFbWEzNGFpVW83OHNrb3FQ?=
 =?utf-8?B?VUQwcGwzSjliRlJ4bStqbDFIUjErK1lYZzhNOUhwQkh2RXZWb1g4d1ZueUNw?=
 =?utf-8?B?R0FEUHU1Rm9BajNuVzROV0Z2VWsybXlBWE1MTG8rVnhod1lZWFNJVWVRc0Yr?=
 =?utf-8?B?U3c2YjN6L3UxSjNlbmlnTUFzcHJEbmx5Z1R1KzVueWJBWVpxUUpJVy9wYnFN?=
 =?utf-8?B?NWRKRVNlczRWTGN3c2JGNjlhTHV2NDA5U1FWVXRrazFpTkFOY0NoSkZyN2Nm?=
 =?utf-8?B?Wnd2bXFiRUdFcnZXTFNETUFURTExNFhpV3VDYTMrRHhFMGk0M0VDOEcvRnMy?=
 =?utf-8?B?QUdkZTRtd1REdHlYTDhFQjNmVkJlczg5YnR3dmk3YlBCNlVta2RqZWh4U3gy?=
 =?utf-8?B?S3lUVko0N01uUnFQTDBjNnVJL3RZY29RT29nV1l1S0kzZXJDcW9OaC9USzFH?=
 =?utf-8?B?VStCSUdKWm92R0VKNXFnUGJpSTBtWVlLbHpvWUlIc2JoQnRWM1hjQkhBL3FU?=
 =?utf-8?B?S3ZXVDJYY0ZabHVBTmE5LzM2Q1FXYm5BdHJHTkl1ZXlrWHV0UlVJT0gxN2Nt?=
 =?utf-8?B?NitHRGkyckMxSGtXZ0crblhCMjdlZ1F1R096WWNkV1JsdVJBSE0wZCtZTllQ?=
 =?utf-8?B?ZFBkNndzemxGeVhxTEdkY01ZeEppaFJBaWdSOWJreXRLd05rN3pkeVlmckdk?=
 =?utf-8?B?Nml5Z2NkcytnWUhSSTUvUnUzSW5vSm5xNmJxLzFsMFJ6a3VJOEVVMjNGakJ0?=
 =?utf-8?B?Z2NMblZqQUFCUGJHTFdwZ2RINnlhQXlLRXhUbUZGSUwyZDlwZ2tqaGFTZXF4?=
 =?utf-8?B?TUtxNW84KzBTdW9PVzgzbzBqZXllKzc4ZXo2aWMxR0FyRVVmRFhzajB6ZGxV?=
 =?utf-8?B?RFhvSkZRYzluWURoaGlPTndXejV1akQzWGNYdEdqVmlVejhwREJScS9ybjkw?=
 =?utf-8?B?VC94TU9BbTRGWC9ubm8yTnAzS3luZTdxVHhoYmFWU2VhYnBETURKZ2wyejNX?=
 =?utf-8?B?L0V5Z1VERGJ5U0VyQW9CMVRZVHFiRTJZQk45K2JmVzJqaVN2L1lpK2U1R3pp?=
 =?utf-8?B?NXI5aEUwVERJSVF1UDBNK0dGTzF5b3RvTklRNjV2bXAwZ1N3bFRCNm1TVXZk?=
 =?utf-8?B?d1h6WTJUM2lsT2VJdG9vWTNJalIxc2tTcmpzb0VmU2o1UDRXY1ZWTkV5S1dH?=
 =?utf-8?B?TS9RZkYzL3ROMDdqZ2RwMFdTUnJZNURWQXB5dGdpK1lHSG1JMnhDYU5oRlNa?=
 =?utf-8?B?M2o4YjhDZm9aeHIvVUlxTkg5ZExiUTZ5dnhEZzZxUzN0cFoxcWR2Y3huMmpM?=
 =?utf-8?B?S0M4T3VGb2tSTnZid2Y3UDhOTWdvZmF3S2J2dXgwbzNKYm9OZWR3M3hMczFk?=
 =?utf-8?B?Smp3U2pwdzRkYk5ncEw5V205UTE5eWVoRjZicXNBMWJvSHBqQlREQS9TYnZI?=
 =?utf-8?B?L2R3eTNCcVRCR2JKUVNoak9MYXJHUkppMXZTQk11R3BFeUhibm1RWWdpc0l2?=
 =?utf-8?B?RzRrQy9pRjBkM3c1T09Cc2dLbEZMQ3VCMjNia0FtM1hTSG13bytPTUF0Szdw?=
 =?utf-8?B?Z3hsVUNCa3h2dHpqYUJhUUFpUXVZNUR3VmlzNk5RQ2lDY0F4K0F4TkhQalV1?=
 =?utf-8?B?T2N3TzArVzNZYjJGQ21sME5IZUoxZDZJVGF4TmhJWHRmdGh1alVkZUpuQXlv?=
 =?utf-8?B?bGpENlhtbTI3Tk9oTk1TNTNoc3lVM0dGSnNYREFpOXNYSGJpU05nWUQ0a2o5?=
 =?utf-8?B?UUlNdXhDeUZmZmhOU3VVWjhoWDNpT2ZqYkRCcXAxNlFPam5Cc3p2UDQycXcw?=
 =?utf-8?B?MW1XWkZHOTBhWDF4bFRZR0F1NHVqdTJqM2ROd1NmL2o3Q3pxaXNnT2xGZGxr?=
 =?utf-8?B?THoxV3hMSDhKVkg5MFNzaXlYTnJRL09hdkNZd1k4MzFSdmtvSHR0WEtVVUxw?=
 =?utf-8?B?YjhjT3RnUjBYOWl6OTdNR3N5T1RKck90bW9xWDlKV3ZyRW9YaVV2RzZGWmdJ?=
 =?utf-8?B?ejQwL3dqNDZhSWErRUMrY0RPd3hVV3A3MHFRc29pVi8xMzZQWmx1ZDM3OTRE?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BBD4C52441BEC489FD2EDECFA953B23@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4854.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50eb9ec3-00de-4111-2b80-08da666318c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 13:08:22.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0suDmq51ygUVb00YTxUobmxXnbzFzgpU8DXiwpxUM3c71RN90vGmVDxnamg7Wr2G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4192
X-Proofpoint-GUID: fc1UkKrNCMK-7J9ZCMO8jQOc5ORFJLro
X-Proofpoint-ORIG-GUID: fc1UkKrNCMK-7J9ZCMO8jQOc5ORFJLro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_05,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTE1IGF0IDIyOjMzICsxMDAwLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3Rl
Og0KPiBIaSBhbGwsDQo+IA0KPiBPbiBGcmksIDE1IEp1bCAyMDIyIDEzOjUyOjMyICsxMDAwIFN0
ZXBoZW4gUm90aHdlbGwNCj4gPHNmckBjYW5iLmF1dWcub3JnLmF1PiB3cm90ZToNCj4gPiANCj4g
PiBBZnRlciBtZXJnaW5nIHRoZSBibG9jayB0cmVlLCB0b2RheSdzIGxpbnV4LW5leHQgYnVpbGQg
KGFybQ0KPiA+IG11bHRpX3Y3X2RlZmNvbmZpZykgcHJvZHVjZWQgdGhpcyB3YXJuaW5nOg0KPiA+
IA0KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRlL2xpbnV4L3NsYWIuaDoxNiwNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIGlvX3VyaW5nL25ldC5jOjU6
DQo+ID4gaW9fdXJpbmcvbmV0LmM6IEluIGZ1bmN0aW9uICdpb19yZWN2bXNnX211bHRpc2hvdF9v
dmVyZmxvdyc6DQo+ID4gaW5jbHVkZS9saW51eC9vdmVyZmxvdy5oOjY3OjIyOiB3YXJuaW5nOiBj
b21wYXJpc29uIG9mIGRpc3RpbmN0DQo+ID4gcG9pbnRlciB0eXBlcyBsYWNrcyBhIGNhc3QNCj4g
PiDCoMKgIDY3IHzCoMKgwqDCoMKgwqDCoMKgICh2b2lkKSAoJl9fYSA9PSAmX19iKTvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4gPiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn4NCj4gPiBpb191cmluZy9uZXQuYzoz
MzI6MTM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybw0KPiA+ICdjaGVja19hZGRfb3ZlcmZs
b3cnDQo+ID4gwqAgMzMyIHzCoMKgwqDCoMKgwqDCoMKgIGlmIChjaGVja19hZGRfb3ZlcmZsb3co
c2l6ZW9mKHN0cnVjdA0KPiA+IGlvX3VyaW5nX3JlY3Ztc2dfb3V0KSwNCj4gPiDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4gaW5jbHVk
ZS9saW51eC9vdmVyZmxvdy5oOjY4OjIyOiB3YXJuaW5nOiBjb21wYXJpc29uIG9mIGRpc3RpbmN0
DQo+ID4gcG9pbnRlciB0eXBlcyBsYWNrcyBhIGNhc3QNCj4gPiDCoMKgIDY4IHzCoMKgwqDCoMKg
wqDCoMKgICh2b2lkKSAoJl9fYSA9PSBfX2QpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcDQo+ID4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIF5+DQo+ID4gaW9fdXJpbmcvbmV0LmM6MzMyOjEzOiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8NCj4gPiAnY2hlY2tfYWRkX292ZXJmbG93Jw0KPiA+IMKgIDMzMiB8wqDC
oMKgwqDCoMKgwqDCoCBpZiAoY2hlY2tfYWRkX292ZXJmbG93KHNpemVvZihzdHJ1Y3QNCj4gPiBp
b191cmluZ19yZWN2bXNnX291dCksDQo+ID4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IGluY2x1ZGUvbGludXgvb3ZlcmZsb3cuaDo2
NzoyMjogd2FybmluZzogY29tcGFyaXNvbiBvZiBkaXN0aW5jdA0KPiA+IHBvaW50ZXIgdHlwZXMg
bGFja3MgYSBjYXN0DQo+ID4gwqDCoCA2NyB8wqDCoMKgwqDCoMKgwqDCoCAodm9pZCkgKCZfX2Eg
PT0gJl9fYik7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+ID4gwqDCoMKg
wqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+DQo+ID4g
aW9fdXJpbmcvbmV0LmM6MzM1OjEzOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8NCj4gPiAn
Y2hlY2tfYWRkX292ZXJmbG93Jw0KPiA+IMKgIDMzNSB8wqDCoMKgwqDCoMKgwqDCoCBpZiAoY2hl
Y2tfYWRkX292ZXJmbG93KGhkciwgaW9tc2ctPmNvbnRyb2xsZW4sDQo+ID4gJmhkcikpDQo+ID4g
wqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fn5+fg0K
PiA+IA0KPiA+IEludHJvZHVjZWQgYnkgY29tbWl0DQo+ID4gDQo+ID4gwqAgYThiMzhjNGNlNzI0
ICgiaW9fdXJpbmc6IHN1cHBvcnQgbXVsdGlzaG90IGluIHJlY3Ztc2ciKQ0KPiANCj4gVGhpcyBi
ZWNhbWUgYSBidWlsZCBmYWlsdXJlIGluIG15IGkzODYgZGVmY29uZmlnIGJ1aWxkLsKgIFNvIEkg
aGF2ZQ0KPiBhcHBsaWVkIHRoZSBmb2xsb3dpbmcgKHByb2JhYmx5IG5vdCBjb3JyZWN0KSBwYXRj
aCB0aGF0IG1ha2VzIGl0DQo+IGJ1aWxkLg0KPiANCg0KVGhhbmtzIGZvciB0aGlzLiBZb3VyIHBh
dGNoIHdpbGwgcHJvYmFibHkgbm90IGNhdXNlIG11Y2ggZGFtYWdlLA0KaG93ZXZlciBJIGhhdmUg
c3VnZ2VzdGVkIHRoZSBiZWxvdyBwYXRjaCB0byBpb191cmluZyBzaW5jZSBJIG5vdGljZWQNCnRo
YXQgdGhlIGN1cnJlbnQgbG9naWMgd2FzIGEgYml0IG9mZg0KDQpEeWxhbg0KDQoNCkZyb206IER5
bGFuIFl1ZGFrZW4gPGR5bGFueUBmYi5jb20+DQpEYXRlOiBGcmksIDE1IEp1bCAyMDIyIDA1OjU1
OjAyIC0wNzAwDQpTdWJqZWN0OiBbUEFUQ0ggZm9yLW5leHRdIGlvX3VyaW5nOiBmaXggdHlwZXMg
aW4NCmlvX3JlY3Ztc2dfbXVsdGlzaG90X292ZXJmbG93DQoNCmlvX3JlY3Ztc2dfbXVsdGlzaG90
X292ZXJmbG93IGhhZCBpbmNvcnJlY3QgdHlwZXMgb24gbm9uIHg2NCBzeXN0ZW0uDQpCdXQgYWxz
byBpdCBoYWQgYW4gdW5uZWNlc3NhcnkgSU5UX01BWCBjaGVjaywgd2hpY2ggY291bGQganVzdCBi
ZSBkb25lDQpieSBjaGFuZ2luZyB0aGUgdHlwZSBvZiB0aGUgYWNjdW11bGF0b3IgdG8gaW50IChh
bHNvIHNpbXBsaWZ5aW5nIHRoZQ0KY2FzdHMpLg0KDQpSZXBvcnRlZC1ieTogU3RlcGhlbiBSb3Ro
d2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQpGaXhlczogYThiMzhjNGNlNzI0ICgiaW9fdXJp
bmc6IHN1cHBvcnQgbXVsdGlzaG90IGluIHJlY3Ztc2ciKQ0KU2lnbmVkLW9mZi1ieTogRHlsYW4g
WXVkYWtlbiA8ZHlsYW55QGZiLmNvbT4NCi0tLQ0KIGlvX3VyaW5nL25ldC5jIHwgMTAgKysrKyst
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9pb191cmluZy9uZXQuYyBiL2lvX3VyaW5nL25ldC5jDQppbmRleCA2MTZk
NWYwNGNjNzQuLjZiN2Q1ZjMzZTY0MiAxMDA2NDQNCi0tLSBhL2lvX3VyaW5nL25ldC5jDQorKysg
Yi9pb191cmluZy9uZXQuYw0KQEAgLTMyNywxNCArMzI3LDE0IEBAIGludCBpb19zZW5kKHN0cnVj
dCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQNCmlzc3VlX2ZsYWdzKQ0KIA0KIHN0YXRpYyBi
b29sIGlvX3JlY3Ztc2dfbXVsdGlzaG90X292ZXJmbG93KHN0cnVjdCBpb19hc3luY19tc2doZHIN
Cippb21zZykNCiB7DQotCXVuc2lnbmVkIGxvbmcgaGRyOw0KKwlpbnQgaGRyOw0KIA0KLQlpZiAo
Y2hlY2tfYWRkX292ZXJmbG93KHNpemVvZihzdHJ1Y3QgaW9fdXJpbmdfcmVjdm1zZ19vdXQpLA0K
LQkJCSAgICAgICAodW5zaWduZWQgbG9uZylpb21zZy0+bmFtZWxlbiwgJmhkcikpDQorCWlmIChp
b21zZy0+bmFtZWxlbiA8IDApDQogCQlyZXR1cm4gdHJ1ZTsNCi0JaWYgKGNoZWNrX2FkZF9vdmVy
ZmxvdyhoZHIsIGlvbXNnLT5jb250cm9sbGVuLCAmaGRyKSkNCisJaWYgKGNoZWNrX2FkZF9vdmVy
ZmxvdygoaW50KXNpemVvZihzdHJ1Y3QNCmlvX3VyaW5nX3JlY3Ztc2dfb3V0KSwNCisJCQkgICAg
ICAgaW9tc2ctPm5hbWVsZW4sICZoZHIpKQ0KIAkJcmV0dXJuIHRydWU7DQotCWlmIChoZHIgPiBJ
TlRfTUFYKQ0KKwlpZiAoY2hlY2tfYWRkX292ZXJmbG93KGhkciwgKGludClpb21zZy0+Y29udHJv
bGxlbiwgJmhkcikpDQogCQlyZXR1cm4gdHJ1ZTsNCiANCiAJcmV0dXJuIGZhbHNlOw0KDQpiYXNl
LWNvbW1pdDogYThiMzhjNGNlNzI0MGQ4NjljODIwZDQ1N2JjZDUxZTQ1MjE0OTUxMA0KLS0gDQoy
LjMwLjINCg0KDQoNCg==
