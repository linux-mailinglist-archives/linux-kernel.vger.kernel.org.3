Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F317858CDB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiHHSfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHHSfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:35:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5160018392
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:35:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278HqAum008140
        for <linux-kernel@vger.kernel.org>; Mon, 8 Aug 2022 11:35:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zvsosKCi88KB9yw6owdJJA5kkj+69K0Au6ccLbhNoVI=;
 b=MXtmFVrIQ8AbHCE5476MnVI7t0yWYS4lWan1sCKeY1dpFHiJ2Qo6PYwgtnZDoeuFchTS
 0iVg7utJsdsS2vGFI0fPMwUOVcphx4aEdK3UpRT/peRaIR291TtXpamCTUe+BUr/7RRO
 3kMsNx8WRc0dstADuSOSNj+MH/OsrLERiJw= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3htxr4ksd0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGZuWUrNjnlzdP6YiEGtpRYKRrsum/N5pyap0iqqvFmF2J1UVSHn+RVeZlU8AOQPYhWyjajtKIXdFWc2lPVWoaSa2TUbAIlOL4e6LGLOdmYqcEQVxLnTiDf5UtnjTJaCVyGXd0Aauf4aTSQ0cW3fTXMANy0bcvRznqtrr1BhkD9KFTgsGfOtkbtmU0LXsAetfOcSAaxJ+yFjT4BMvMjMvoPoR5biqA3ZEwz4fScyziFGDUtKTd8kBogtxNH6beHifGzUp9ORTD1P0dnxxfYr6wNdGo4WWjuGW9aMzbTJFNGk3MUBRvpPpWuxIIz/9sEJU07nTgl1+RkpeJ0y0JsaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvsosKCi88KB9yw6owdJJA5kkj+69K0Au6ccLbhNoVI=;
 b=Us3mndK7ItgOYMmgSWy51GrpemteflcaIpe8uEs5Vf7IalR88zJChbTX9ThLV4RTIARwdPq1CCiLyE4K8AfhBs9BeY/RJfuU5u87wFAMI04zLJyX/HydMYIegEvBax5xEGvXSsIwcrZqq/0ApJQI/5zo+Jr11FWvpymdwJa0U1yesz5WE6Q+ZCt1Jgyd2w0157BGlgj6L3TsxkxY8+No+yCXGsTuNOBpXbGe4XNSHVgDVsH2BLyGr95VqwuM4oNWEAqdK+CcHs9DrxBoSVKh9D70hFkIyLVTRAL8l6Ohs6gkKnArfZKElBi8eui1bVVXHqcYlQ72serwC0LHm9GnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5263.namprd15.prod.outlook.com (2603:10b6:510:144::10)
 by BLAPR15MB3876.namprd15.prod.outlook.com (2603:10b6:208:27d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 18:35:07 +0000
Received: from PH0PR15MB5263.namprd15.prod.outlook.com
 ([fe80::81de:e716:a182:4ef6]) by PH0PR15MB5263.namprd15.prod.outlook.com
 ([fe80::81de:e716:a182:4ef6%4]) with mapi id 15.20.5504.018; Mon, 8 Aug 2022
 18:35:06 +0000
From:   Rik van Riel <riel@fb.com>
To:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>
CC:     Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Index: AQHYqPrUsoqGdDLt+U2hECHNyZy0Q62gpnsAgAAD74CAAAWSgIAAB5MAgASWeoCAAAspgA==
Date:   Mon, 8 Aug 2022 18:35:06 +0000
Message-ID: <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
         <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
         <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com>
         <Yu1uabedm+NYnnAj@casper.infradead.org>
         <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com>
         <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
In-Reply-To: <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c5e5546-4cda-4398-25c7-08da796cb776
x-ms-traffictypediagnostic: BLAPR15MB3876:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GDme/zIlMiBCpJtbdiCG0JEW5uBIInvHNDQQ/bgTl3H6UF9Ks2Q3Mu2voiIYSgX44SbnGaarqHnS632m4bfBIzk254UhgRyahL96pV7+VJM7tYOzqCK38aBOEtA5wKHvEC/PB12adfSGmIhOf+HRuYf514Fz3p+wOdJ1cGGVUNmd3l90mLoTuCJKA3xF9bETv+yXOq8BC2YaBwjJxqqM8qznrl1Ufl4qBKT6azqa+8nJuRhuDTXEpSf1IwYzqiVaHo4bfgUzvlxQzZtXCQL0XJjTjfsfrJOI3LEY899yLORkvSBb/dqtwy7/MbsB9unx2hvk7dkyt7HS9oXT0BBBItsODuHoSYktYPD2p2f0/P20X0GGzdNwOPcSTuUrb7Jl227VRKHpeJf1nY7V1XyH1Q+dIDI6YTgrvVKesK1wrKW7/AyjQmVvqlqYOh0AppumVzSxlD3YsmXGKKpcKwkSFnQx4DIPrSQWsOQizOs8W5U6+YBx/IMuvR0CSLupmD4sWFUF8uZyrDPDBjxtfkBwMs8ND69r5+E/y7JGXyl5FspTi3thi0kMpiNB33iBvtp3W6dwpqx9xzQxj9s4uWNIAN+6aoGoeFIYB1XE9bC58vnDHvVZ8xnYDuJxJWIY32G64wMA5+bLOLWC7cZixjLSe0IkHUtATYFJQRdxhcLy6VSm4ijn0yssJfHyBzI5AGRXB2CJ+27EQs/kWwQCOcKoxPqE1i87BQIiu2T2H0aSTppJSyECYCyHdpjNh+eyu3JLNZrnUpeXpyWj997TLsKlMGs4ZtV+RL0TFbmXo4BRuPEYXDMLFPoT6oT2KiWObxEd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5263.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(38070700005)(122000001)(6506007)(83380400001)(53546011)(86362001)(36756003)(186003)(2616005)(6512007)(316002)(54906003)(110136005)(478600001)(71200400001)(41300700001)(6486002)(66556008)(66446008)(64756008)(66476007)(8676002)(5660300002)(2906002)(91956017)(66946007)(4326008)(8936002)(38100700002)(4744005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RndBMXZIMUhyc0ZGUFduVHpEVm5HQUd5Mk9HV3NEaHdJSmdhOEd4MVZQN1FJ?=
 =?utf-8?B?UW1YeFFlaTV3UDdQQ1VPNjF2NnJVc3kvT3NvbzU5SmpKdHcxZjkwTmQ5Vnoy?=
 =?utf-8?B?ZDNhUTJ1L2NLREV1N0tTbjBQRUJjRTFTTFpZdC9EVldJak1SNVJiMmNLTXBu?=
 =?utf-8?B?M3JtcEVoZzV4TXRBNWtIQjdPUVdHMDY2ZzhoUkpWOVFVdXhCbEhJQVpzWk1Q?=
 =?utf-8?B?WEEvaUlWV05XR3RHdXBYZlZDelg1MTZNWVZtL0dPMDZDTzFmeW43N0xIcGtw?=
 =?utf-8?B?aHg1VHFuU21wcUhwVW96ZzNPVmhXMFRNUm9IUm8rMndBMHJ3V1JMTnVaWjFG?=
 =?utf-8?B?R1NWanhYL3hRZFdzT3Q3THowT0lSdTlkU043Z2QwT0hmcWZtaGI1SjVUR2hs?=
 =?utf-8?B?K1djdlNsY3FtTGRuVk1EV1lNblFlVXd2Um9MbkdqT2Z4TklzWjFpR054Skhh?=
 =?utf-8?B?bkZuSllXY2hHVlpPQWpJVkNJajlLRkFzWTdmd3NEYm5MekVyVS9sNGFGL05N?=
 =?utf-8?B?cDVjUzlHYlVUQkw1U1NsSXpyWjJlaXN5OHNiSXBzYnNkNG9YL1MrYlBrUHg1?=
 =?utf-8?B?TEZiUkZHMmt0UkQ2QnloVnlFM251VTh2aDlTdjRiRjNGaXNRczR2aktEVEVB?=
 =?utf-8?B?YnNkNTJtR2p3THJNYjZYVU5UQ2ZNV1B6L3Ftd1I3YXZIRnJuNCthVitzald6?=
 =?utf-8?B?VUtqM1NrZ0dJclFRUjV2bEt6ZnMwcTZoUms0dVpJY1NJdWNCWHA3dHhXQXdI?=
 =?utf-8?B?Q3dvQU95TDlOWGlXcGhNOUhnWHZVOVIwRkJQaDRkMXBWcUV4MmZlVGErVHZ4?=
 =?utf-8?B?b2I4VlhMTTFWRkpkWFhnZ0ZzN2FNUy9VdTF2eFRpZ01KOXczSXIrVmsxampH?=
 =?utf-8?B?TFZKUnh2UkREMWYvOHQyMjh3R3NxTzRxSnlVckNpZnU0ZjJqTzMvQzlaSGd2?=
 =?utf-8?B?djcvWXdnMHFkT1NjSmxQdkUvTWtldWdnWEt0WE9BSFhlb04ybTZUbHRlOVhH?=
 =?utf-8?B?VlRpb0VPU2ROQUJNTVQ4OUd3MUI3c0YvTndIeTQ1TkNaWWZNaUVSTUV3Qy95?=
 =?utf-8?B?K0tDRlJHbWRSY0hDZUVXR0UybSttTnZkcVNaeGlNbWc2V1BQOElDTGJnRlV1?=
 =?utf-8?B?ZlF5TnoxaHNUdzZzdnFVcDBrS0I5NHlFTHlrVEQyOEplSkxkL2xwV3QvMmd4?=
 =?utf-8?B?WkFrOW5RblRtSUpZU2FnTHRLOFJZMHpMRmxRK1poYUNJOTZncVR6R2x3c3RK?=
 =?utf-8?B?UmNsdHFMTXk3VHBvN0tNdGdEYTNUMEZ1aFFNRXR4QmFVcENOWHdDcUUvcWRk?=
 =?utf-8?B?cFNvZmxML2pUSGg4WTBLMGZMMThZMkJHS0QzUXA3VytaSlZmN1pjM3ZIUitX?=
 =?utf-8?B?Qk1mYnByVGxFekNyR0FaU25sN2ZWaWZjVVo2RWN4SVFSTEtoR0VJVHJwaWE1?=
 =?utf-8?B?aEMxOWEwYkFlZEUrTW5Ody9TRUQwdXEva1Z2RWY3L0FmV1dGYllsditJWDhx?=
 =?utf-8?B?RTc1M2t0QzhzaXNqM2pTYnBrb0toMDV3NEZTL0V0TG5EV2NvTVlMNzh1R1U2?=
 =?utf-8?B?YThIcmVnRVk3aVpBbEZrOFN1WjdjUEEvSTNaODVqRlpWY0Vjb2J5ZERVOWlr?=
 =?utf-8?B?YjVxbjQzem4vWi9ic3VSekk5UGxpOG5GcnduNU1DcEV2R0I5ODQrSm9FRkl5?=
 =?utf-8?B?UUEySGJoaEtzOGpxamJsTElFK1FVTEcxZlpNK3RvNjQwVHZzL3k5aHJqcjNn?=
 =?utf-8?B?NnhBRWV5bU1KN1B0WG0xSXpNQyszUFhGWDR6QnZoRzhOMkRvTnhydTE1M05x?=
 =?utf-8?B?ai90cTlJS1V5cHY4UWY2V2xTZ0tVaTJDT1UrdjZTSXRwc08zSWdZU1gxcGsy?=
 =?utf-8?B?bzduMENYVkZrNERRQjcxSGhqYWRvREJHZTdnYitkTkdiLzFrR3V0VFN0UTJx?=
 =?utf-8?B?ZW1zTWVwOXF6M0doNjNkVXYrNjdZaUlWYWZPd1RJMjFoRlRHSjgxNnpaQVVZ?=
 =?utf-8?B?bW5GYlptWGNhZG9oS1poaEpyNnM5dW10OENpQUhMUCszSEs3aWlXVXNSemdp?=
 =?utf-8?B?VU5OSW1USm5aaWNKZTRXcWJxOXVvemdFTVQzanRzb2IzWnZjeEtoUkIzWm1U?=
 =?utf-8?B?ZXF0MXErTUZSejYrcVA3NEROeXFuUDdXK2RhZWtnWUMzMzVKaEMvVnBBd004?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8511A8E04E870E4A9961B6923D419775@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5263.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5e5546-4cda-4398-25c7-08da796cb776
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 18:35:06.7436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gb+LQ+EQWocFB9tzh1WSfLiJsTry68jH6JFUY5ocLwHHjn5aXncvwCz2WDgy1KaW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3876
X-Proofpoint-ORIG-GUID: L1xaPX7tVyGwSVb35hHFZOKPjEQI4zBd
X-Proofpoint-GUID: L1xaPX7tVyGwSVb35hHFZOKPjEQI4zBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_11,2022-08-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTA4IGF0IDEwOjU1IC0wNzAwLCBZYW5nIFNoaSB3cm90ZToNCj4gDQo+
IE9uIEZyaSwgQXVnIDUsIDIwMjIgYXQgMTI6NTIgUE0gQWxleCBaaHUgKEtlcm5lbCkgPGFsZXhs
emh1QGZiLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gU291bmRzIGdvb2QsIEnigJlsbCBtb3Zl
IHRoaXMgdG8gZGVidWdmcyB0aGVuLiBXaWxsIGZvbGxvdyB1cCB3aXRoDQo+ID4gdGhlIHNocmlu
a2VyIGNvZGUNCj4gPiBpbiBhbm90aGVyIHBhdGNoLiBUaGUgc2hyaW5rZXIgcmVsaWVzIG9uIHRo
aXMgc2Nhbm5pbmcgdGhyZWFkIHRvDQo+ID4gZmlndXJlIG91dCB3aGljaA0KPiA+IFRIUHMgdG8g
cmVjbGFpbS4NCj4gDQo+IEknbSB3b25kZXJpbmcgd2hldGhlciB5b3UgY291bGQgcmV1c2UgdGhl
IFRIUCBkZWZlcnJlZCBzcGxpdCBzaHJpbmtlcg0KPiBvciBub3QuIEl0IGlzIGFscmVhZHkgbWVt
Y2cgYXdhcmUuDQo+IA0KSSdtIG5vdCBjb252aW5jZWQgdGhhdCB3aWxsIGJ1eSBtdWNoLCBzaW5j
ZSB0aGVyZSBpcw0KdmVyeSBsaXR0bGUgY29kZSBkdXBsaWNhdGlvbiBiZXR3ZWVuIHRoZSB0d28u
DQoNCk1lcmdpbmcgdGhlIHR3byBtaWdodCBhbHNvIGJyaW5nIGFib3V0IGFub3RoZXIgYml0IG9m
DQpleHRyYSBjb21wbGV4aXR5LCBkdWUgdG8gdGhlIGRlZmVycmVkIHNwbGl0IHNocmlua2VyDQp3
YW50aW5nIHRvIHNocmluayBldmVyeSBzaW5nbGUgVEhQIG9uIGl0cyAidG8gc3BsaXQiDQpsaXN0
LCB3aGlsZSBmb3IgQWxleCdzIHNocmlua2VyIHdlIHByb2JhYmx5IHdhbnQgdG8NCnNwbGl0IGp1
c3Qgb25lIChvciBhIGZldykgVEhQcyBhdCBhIHRpbWUsIGRlcGVuZGluZyBvbg0KbWVtb3J5IHBy
ZXNzdXJlLg0KDQo=
