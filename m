Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0125634D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiGAOHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGAOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:07:05 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE2C3205B;
        Fri,  1 Jul 2022 07:07:01 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2617HdSF027570;
        Fri, 1 Jul 2022 07:06:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=6wnwx39rbH0SwsF1xezHMqnedgjkG7a8080yOfeAAOk=;
 b=r5meGhlRLY3sze2dOZqXrc6YfoB9QpZU945gztJ/ynbhV/Dv3Kt2ljuxuWEaxH9/69xL
 vwn1h94ro21ZIKpOFGIIpsXzpvvDOwkQKpPgXKRQnJ5+H7nNv7GqjgdhkuoINugkF7kZ
 0Zg4fXruQrcKOlnYT80ZKxMW+LHDoD/KhywfS5XhlEKnldOyEiKmf4DuPClQQkHlrFDl
 ULodLRUFGzvKt1Bs2o5KpK7UQ/lhVst9EuHJt+2d+4h4tE5AvN2qycJsHwmD7EAZyJUX
 WHmFPO4xval+3EI0rt/YAX0rKpbwLyNfOiV75OiaX/Qs13yRFnF2e4n0jfS7Thw6eEf9 OA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1w25tvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 07:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMfE0/DKDKAwjqq59JEs8TSWKjGH3vpPJeTazWWvA5NvsIULSujQNMv/voaQG5cZYBV0IzQgdlzk5KHblw3gEEKSdvOPUN+t6oAGV24sDscVbF7N85ZDTjMit1/S3wlkzpNb9wkGrhPekiYDXdvYbel6lIigYqWlsWKIT/Mot8QRUpiY117nLJAIz68FMYPR3lLzz4Fm0XyJ8T/FXIaycmL0l+kIlui9z6ijYlqT6XfTzNfcDom/R6zo/ZESjLqyGHaGxvJwZTXTHDO9Cwx7XZ6jvR7LHVVrDVAA2dbbOmROPvC+26dxPivmiBqTFOIzOmkD+NTgi1SUZ6fZZwTCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wnwx39rbH0SwsF1xezHMqnedgjkG7a8080yOfeAAOk=;
 b=O9lIaZAw0Xx9t+0Mqlz4Zlnq/kqeBqc63ewtXovJOQTE3l07ownrB16zszxQnblpxIY8gcJMvJWqkIdxlvHu0XdQAZ4Ira/VcyfhwK/skKLe9cQ6VF+f8PE4YFmERMSJNeEFaH/tIVcikOrsjMwreIVjNo59BlFdSrNawtBTCTmbXukGaUiXH44XcrqpX0DpPAi1jC2yGemaXi7tqgZkcOlWAD7kJzhaV9hSz/MkCfZxCO3IyDFQg9sBOn/Upe4og5RbZMmmxdZBv/aDEHP4pjqOAeHsoxxmRuTu8ddgDLhkIETVIKtAYcht1VFQ3/Md8r/6RHGxdvBEIsUCHUrGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by BN6PR02MB3139.namprd02.prod.outlook.com (2603:10b6:405:64::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Fri, 1 Jul
 2022 14:06:50 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::64e5:da2f:e15c:2a6f]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::64e5:da2f:e15c:2a6f%7]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 14:06:50 +0000
From:   Jon Kohler <jon@nutanix.com>
To:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] intel_idle: add CPUIDLE_FLAG_IRQ_ENABLE to SPR C1 and C1E
Thread-Topic: [PATCH] intel_idle: add CPUIDLE_FLAG_IRQ_ENABLE to SPR C1 and
 C1E
Thread-Index: AQHYjLmyfZe8FiABAE6d6qT19cbe9a1pg+iAgAAKQYA=
Date:   Fri, 1 Jul 2022 14:06:50 +0000
Message-ID: <20B0D65B-CB72-4F56-BF8F-7B212D04A7EA@nutanix.com>
References: <20220630194309.40465-1-jon@nutanix.com>
 <b35cf10b03b441a95704648e816ff1acc150f38b.camel@linux.intel.com>
In-Reply-To: <b35cf10b03b441a95704648e816ff1acc150f38b.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cecbc47a-0501-4c49-b9c2-08da5b6af175
x-ms-traffictypediagnostic: BN6PR02MB3139:EE_
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JRwVXEaTiAw5JfeRtzFqnY1xnactO4Ky072tboKuXaOml5STCJCeIvamZeR0S05KpLK8IA0je7sQ5QuS5jw0P7vHoDX1ciUhtR58XQVx5nK47T7hmsfPa/QMJAaO0YceyLqTgklL+a6goWkMCdqwXjRyD3e4VsZnOuKkF8Jy2sohBB9bOZIsezEJsw2ZPiXtEKPLEvJ0leu7N1lKMe532GVCM9Xq+dJp4kmKrEk5FZWqFx0VrBoLF5WSDigSzNwnEzgjhBbsqf/vEGly6FDZxuONUCjJGInMic+LzxAYtxJYPWOah8p6jzZ+qpMolidZu3hPwafEc7u3hEuaMnP+U8hrddFwtKGGIh3itHmirA3EI9Ss6E5UT/ON+x8Iswgtw6l9jB69fLSIS3eiiJtuhfnSQm7PEfDFjh9rYUnhoXF1drvHxY+80Hn3ziwnib3OMG9yzBDG5GMMCAE75X+vQxWe78fEZZ31aDuLqDXbVRh6crny41S4vktrYE79O7pWRM/ETBAns/dlIGfX+TUwEduRvsJ+ZRRPCxVhIVOr2X0tCZlQkbKrbrYEo4SBaQO9I7tyBkwZuoxQgjnrenJ3sX3O3EuVQuTUHKmQrXqP1ZcYvOmBEtdXtOUQoYlTr+UvfiAwP4n5o74xpN1BB498XHQ6OunK3UzLxnIOqURBlip1YmGtsht/llvRHpc8hgIFQKu5bJeesv82H2bfw97i8SpVjEM5E7uoXm7QH8w6VTaAnmVEOuJBWAV++36u55ZGX3PEgoMtl2m8xh45lX7/Dl5jhfvbh/AZaWM3WTkQSO2aZH5tE9SjPEwNT0JzucWEtqYlWaE0ysEtTN+u5OwZPFBDEL8IiADV5mYmfpyjsM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4579.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(33656002)(316002)(122000001)(53546011)(4326008)(71200400001)(64756008)(66476007)(66946007)(86362001)(66446008)(66556008)(76116006)(8676002)(6506007)(6512007)(186003)(41300700001)(478600001)(2906002)(36756003)(6486002)(54906003)(38070700005)(5660300002)(6916009)(38100700002)(83380400001)(8936002)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVY0RDhzZ2VUKzVEcFF1RytEUVFIeXgrTkFQRlJTWDlxcHhaMGJFNEtMNmR1?=
 =?utf-8?B?ZXFjOXR3UFdhaFhXOEs2RkhNMm1meFVseUZiSTM0M056RXg1TzNNbTVIdzRZ?=
 =?utf-8?B?UHp5Y3JNMDAxeWhQaDRwbmc3eEVpWVU4YWU4ZE8wbWlKTTRsbVpvT1VtcFI4?=
 =?utf-8?B?ZDdoek90WXVaMUZFY0dNZlBJSmhsdGRVMVlCNVJYU2ZmU2xBVnFaNm9oREZD?=
 =?utf-8?B?N0JueWhZYndGdlI2aVVmdE5TeGlNbUVtWmJNQm5aV3Z5S21TQkljSWhIQjNP?=
 =?utf-8?B?YTdPdnYvY2duOWdRN0tTazd6RVNmR09wZ29lV3huVzJSemM5YTNDZUZTcVVt?=
 =?utf-8?B?UUNETEJRU2FsSnhMdlU2eU5VNzJjNVJYZVpGRHJiUC9QSXZhWWJUVEhYVG5X?=
 =?utf-8?B?MEF4NG1FbjhjU0NQYnZucmtlKzNYM1ZudHBwWE1WbkZIcHAzbXhZVEpsRUl2?=
 =?utf-8?B?RFRJVlFVS0EwcDUxTjJabGZuZGtsV2tqd1orUmhJSjA2NmIzVFdJajY4a3c2?=
 =?utf-8?B?Wk83cnFVcUVUYWI4ZC9raDhobzhtM1UrYWY0ejcydHJObUNLVlVsUTlIak42?=
 =?utf-8?B?K29uVHR2UkpXNHFzMjEyK2dCZ0hhdGc2d054dVE2NmtNL2JXQ0MwcW8vTjcz?=
 =?utf-8?B?NXQzN2VucDVvV3J1OGpGUGcvb0dZZHJOeHNXNy8yOUY3MG5xM01sL1B2YTVR?=
 =?utf-8?B?T09wL2NqTk9QZGtqS3JWWlpJOVZnTmJuTStRU21URDN5NVNSSndTYTgyUDVH?=
 =?utf-8?B?NzVvNkNVNXpxN052UjZxb0Y4YUh6YUc3NWRvbVVPaHBtYjk2eDRVNm1CVzlG?=
 =?utf-8?B?V1NnQWRRNGNuMi9RQ0tIbWU4Vm9GRHBpbHFNRDVZV1c4UTY2NFpIZm1UNXU2?=
 =?utf-8?B?TUtSVnlVNEdKdWh0TEUxblZBMmlreURPTHkxQW9uMWljaGdUODVhMzV4RXg1?=
 =?utf-8?B?bHNjZzE3Ti9zcDN4UVYrNnBkbnB1SWMxS1JqVEdYZXdmSEVRakUxSytVaHdn?=
 =?utf-8?B?dnFIOGZFblVIRUhrejZPUDh1bERhNUg3VFhNU0o3SzJjZE84YjJXT2ZadGFH?=
 =?utf-8?B?eFRvcVEyYm0wTjRGaVA4dmo0SHppeWx2ODl1OW1GZTdiWmtlVmJvU09vWFdv?=
 =?utf-8?B?QmQvdFZydVBFZ3MrbEtCTFVRYk5UTG9NTWtwbkZPRFl2STNHd3QyZXJuNnYr?=
 =?utf-8?B?TE92ZmFaRmRZVHdvTnpiOXJlcUZOZm5YZ2pWYkpTbUNYd1F4cmRwQU51TW51?=
 =?utf-8?B?aUR3SnltRGNCRkZFT0dlSXRmUEpyRjNib0w0SlVFK0dvd0JNaUh2MXpEemdU?=
 =?utf-8?B?b3gzYVJ5RGw0VjNkWXRJY1hQc2lTb2tyZGFHTysvMitMNk9JM3BJaW4rVUxW?=
 =?utf-8?B?d3IwRHJPbkRDSDl5SjhGYUowQVM0MUxUVkc4NDF3eE5TYWNHZlp4YVVSdmZW?=
 =?utf-8?B?UGlZTWtqVDN4ell1ZFVaQmJBcUMrc3FwNzJzOE9JRkVzNW10TjVTdUVkdDBN?=
 =?utf-8?B?N3drRmxvT05LY3krN1M5OWNmMDFDdW52Zko1RUxQTDNtWmJOSnVjNFd5UGNl?=
 =?utf-8?B?cFBDNmcxWDVEbTFVNFMrUHdFMDNjcFMxbWp4QTlDQW9oaDByelhZZkYra2g5?=
 =?utf-8?B?azdwemhwRDZZaHcrcjhMYnF0N3h6MlIzNXh0UFV4YisxM1FnOUhOZHBZd2NU?=
 =?utf-8?B?ajJ5a3p3Q0p6ZU1DRVdCSlUydlNsTUVXT3BmRGg1aHBNajdza0lFZ3lIbVZI?=
 =?utf-8?B?N0RsbFNyZHZtWjRzOHY0V0xYOVowZzV6N2EzZ25CQllFajJncUExelNIdlE5?=
 =?utf-8?B?UXdCenB1TzR6UjBkanVUU1JhSUlpL2Y5WE9BU2VTb0pDOURVQ2xjWngxWC9Z?=
 =?utf-8?B?MGFVYitPSEtFbHNiLzdWMDBMN1ptZGpMbDBNUE53SmVXOGdoekFtcGNOMW90?=
 =?utf-8?B?a2MzMjFrM293d29rKzBOWEVQZVVqYit1dDFGbnRNNkZ5ZGhRS0crWURIdThZ?=
 =?utf-8?B?U1h6NXFIT2lIeTBhWGJtaEJxMUYwWmcrcUNqWk5WT040bGdhYnhJa0VtbndQ?=
 =?utf-8?B?RDhDc2ozVEl2YVVXS29yaXdURVlRaHJNdVFGdXJWdysxQ21saER2ZzZZM21X?=
 =?utf-8?B?eENOVTQ2cDdqWjZ3dFl2MTVkNHJxcmJLMWU1R0ZHczNFdlNVckI1MnlrT2s3?=
 =?utf-8?B?aDVzQkZPRGs0aVAwZERISk84NlU1SVFNbDRRNTlwMm1Ha3drY2licHo2c1lG?=
 =?utf-8?Q?WER0VNC6UyK7Gx3hgnKI5fVXaYyB9QMrpw68aWC6Z0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1CB56245B4B2641B4692EB1A4C03025@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecbc47a-0501-4c49-b9c2-08da5b6af175
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 14:06:50.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOpmxaKd9SDzHWUyWH4FTnQVUcbeOwgBjfRcyly3lAvUK2UH6R2XWp/2t7ngHaGhsiA7PZBuzfQ5xqIt0RFIVqQr6Sle6P6po/NJRw9f6LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3139
X-Proofpoint-ORIG-GUID: _kM68Pu_EhzMyNeP6O1MXcaTR5mdsAYd
X-Proofpoint-GUID: _kM68Pu_EhzMyNeP6O1MXcaTR5mdsAYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDEsIDIwMjIsIGF0IDk6MzAgQU0sIEFydGVtIEJpdHl1dHNraXkgPGFydGVt
LmJpdHl1dHNraXlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IEhpIEpvbiwNCj4gDQo+
IE9uIFRodSwgMjAyMi0wNi0zMCBhdCAxNTo0MyAtMDQwMCwgSm9uIEtvaGxlciB3cm90ZToNCj4+
IEFkZCBDUFVJRExFX0ZMQUdfSVJRX0VOQUJMRSB0byBzcHJfY3N0YXRlcyBDMSBhbmQgQzFFLCB3
aGljaCB3aWxsDQo+PiBhbGxvdyBsb2NhbCBJUlFzIHRvIGJlIGVuYWJsZWQgZHVyaW5nIGZhc3Qg
aWRsZSB0cmFuc2l0aW9ucyBvbiBTUFIuDQo+IA0KPiBEaWQgeW91IGhhdmUgYSBjaGFuY2UgdG8g
bWVhc3VyZSB0aGlzPyBXaGVuIEkgd2FzIGRvaW5nIHRoaXMgZm9yIElDWCBhbmQgQ0xYLCBJDQo+
IHdhcyB1c2luZyBjeWNsaWN0ZXN0IGFuZCB3dWx0IGZvciBtZWFzdXJpbmcgSVJRIGxhdGVuY3ku
DQo+IA0KPiBJIHdhcyBwbGFubmluZyB0byBkbyB0aGlzIGZvciBTUFIgYXMgd2VsbC4NCg0KV2Ug
aGF2ZSB0aGUg4oCYYmVmb3Jl4oCZIGJhc2VsaW5lIGZyb20gd3VsdCwgYW5kIHJlYWxpemVkIGFm
dGVyIGRvaW5nIGl0IHRoYXQNCklSUV9FTkFCTEUgY29uZmlnIHdhc27igJl0IHNldC4gSeKAmXZl
IHByb3ZpZGVkIHRoaXMgcGF0Y2ggdG8gb3VyIGludGVybmFsDQp0ZWFtIHdvcmtpbmcgb24gU1BS
IGVuYWJsZW1lbnQgdG8gZ2V0IGFub3RoZXIgd3VsdCBydW4gaW4gbmV4dCB3ZWVrLg0KDQpUaGF0
IHNhaWQsIGlmIHlvdeKAmXZlIGdvdCBhY2Nlc3MgdG8gYW4gU1BSIHN5c3RlbSBzZXR1cCBhcyB3
ZWxsLCB3ZeKAmWQNCmNlcnRhaW5seSBhcHByZWNpYXRlIGEgc2Vjb25kIHNldCBvZiBleWVzLiBU
aGlzIGlzIHRoZSBmaXJzdCBnZW5lcmF0aW9uDQpvZiBlbmFibGVtZW50IGZvciBhIG5ldyBwbGF0
Zm9ybSB0aGF0IHdl4oCZdmUgZG9uZSB3aGVyZSB3dWx0IGhhcyBiZWVuDQpvbiB0aGUg4oCYY2hl
Y2tsaXN04oCZIHNvIHRvIHNwZWFrLCBzbyB3ZSBkb27igJl0IGhhdmUgYXMgbXVjaCDigJlzdGlj
ayB0aW1l4oCZDQpvbiBpdCBhcyBzb21lb25lIGxpa2UgeW91cnNlbGYgd291bGQgOikgDQoNCj4g
DQo+PiBOb3RlOiBFbmFibGluZyB0aGlzIGZvciBib3RoIEMxIGFuZCBDMUUgaXMgc2xpZ2h0bHkg
ZGlmZmVyZW50IHRoYW4NCj4+IHRoZSBhcHByb2FjaCBmb3IgU0tYL0lDWCwgd2hlcmUgQ1BVSURM
RV9GTEFHX0lSUV9FTkFCTEUgaXMgb25seQ0KPj4gZW5hYmxlZCBvbiBDMTsgaG93ZXZlciwgZ2l2
ZW4gdGhhdCBTUFIgdGFyZ2V0L2V4aXQgbGF0ZW5jeSBpcyAxLzENCj4+IGZvciBjMSBhbmQgMi80
IGZvciBDMUUsIHJlc3BlY3RpdmVseSwgd2hpY2ggaXMgc2xvd2VyIHRoYW4gQzENCj4+IGZvciBT
S1gsIGl0IHNlZW1zIHBydWRlbnQgdG8gbm93IGVuYWJsZSBpdCBvbiBib3RoIHN0YXRlcy4NCj4g
DQo+IEkgd2FzIGFsc28gZ29pbmcgdG8gbWVhc3VyZSB0aGlzIGZvciBDMUUuDQo+IA0KPiBDb3Vs
ZCB3ZSBwbGVhc2UgaG9sZCBvbiB0aGlzIGEgYml0IC0gSSdkIGxpa2UgdG8gbWVhc3VyZSB0aGlz
IGJlZm9yZSB3ZSBtZXJnZQ0KPiBpdC4NCg0KWWVhIG5vIHByb2JsZW0sIGhhcHB5IHRvIGdldCBo
ZWxwIGFuZCBhIHNlY29uZCBzZXQgb2YgZXllcyBvbiB0aGlzLg0KDQpUaGFua3MgLSBKb24NCg0K
PiANCj4gQXJ0ZW0uDQo+IA0KDQo=
