Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1153F9D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiFGJbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiFGJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:31:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62572EA15;
        Tue,  7 Jun 2022 02:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt6TVZYPivNEl82dzoI8XYhNaL83bPGh9LSsQrsim9C+QuAjQZnv90+FcaxIYww0rvrbmrQoHWdSKrOYBHAR1gPsHRT4hrv3hI5PubjXcSE7tju4Qu0DwY7B4tSN6mcTmmWVQsQCVhDI4wQSRN4JnPTaCBVV+xZjMJvNY0d5iwWBUZD4PyEuvNtAxs9/Dif0IDjfu3NcikenOA1G6xOMSVWj7LhFguMXsG2oFaJ2H+axJatyIYztisCy8lk3OK5k/PjBjofB+ggHEMPb6SgWsspDQTJQcuSUemnO/B8DDZ2tWL6StDt9T2vXjPABnMC+jdme7+kbNRGynS/bT2IBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKfhpHRiJ0mGUUhJaogx1MANcnZDZFvWmCvNB8R/c0k=;
 b=KCHcVsMAsocXfaDMiJaAP8nSsd8ueg38wKqCo2KrY8d4y2xgJHwsEHbe9iYPGRT1AlzBySLn7u1zoP8L1gLosD3ETkegJ2ZusdXhrRvaqB/eGFqcTmYTKGgPEZcPjrcdtcsjDxAfIOdbIxyjqM1AlegO00WE1DqltN44t/hEgOvErcWyI9X2jKTdEshxHKKfzioH4xcsO9JwSknOhWZCgqSMwlRqD8M+UDsgY49NhVQUo5Rw4xcsy8ylvVIx+olk8JUgytzoK4t7TfIjTophEJ+d0dRCP1vNKAVM62EwJReG8PnsmvZcU5no/EDEZpmoU7NUJ1V5YCR9BuemThXN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKfhpHRiJ0mGUUhJaogx1MANcnZDZFvWmCvNB8R/c0k=;
 b=SfnFp132U39cb/rh3skQz89jMkLQ+5QXmeYSZO2Ad4xys+C5Z95v0MLKZAd9C/zB/jSFPbYPKf9oVf4T9lXONKquf33gQnbz6NME+lIFAqEvkt1TCIAnccSBve3jfYATb+ohhS9XXO+D8/hVC6zaFHEcUXa5vj5VdTpUjug7CAo=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by HE1PR0401MB2233.eurprd04.prod.outlook.com (2603:10a6:3:1e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 09:31:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 09:31:37 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] media: amphion: delete unnecessary NULL check
Thread-Topic: [PATCH] media: amphion: delete unnecessary NULL check
Thread-Index: AQHYeaRmH2qnoR+or0mY2ZNcvsikBK1Dr2NA
Date:   Tue, 7 Jun 2022 09:31:37 +0000
Message-ID: <AM6PR04MB6341FF676A8F2761423AB59FE7A59@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220606131042.4052393-1-william.xuanziyang@huawei.com>
In-Reply-To: <20220606131042.4052393-1-william.xuanziyang@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100baa90-c788-44e5-1aeb-08da4868852a
x-ms-traffictypediagnostic: HE1PR0401MB2233:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB2233ACC67D848DBAC06B8642E7A59@HE1PR0401MB2233.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHDbIFJx1ejYwurrV/FDTYA6woQO73GZKX/lCgQKWQ8k7+BwT/4GQ/w5oxUzwWsbp0EMTl53AufVJa9CZvVnsBvcWz0PvnuJE1eewAoRMdN/WfONGTJzg/Zd2lzLfFU/Q5Q6KzsRsN2ANS+Ue8+KhmUHMMM9dcd7xTAwiEJ71Jcj7iRk1vwrlKuKPMv/ztw5kWW7hKv0vyIZlZD8oROXSRqOKrWISH1MEo+NxMHh019f7gfE/KZFwk2/TKiJpfjmLyX92RBPi837Bi0JBMvQCFkgpDZG/hFEEeqBzPbkIYV2HMv0WByXHBQXX+6r1ESdnkGKNWSMl4Khe4E2JPrxaROdgsD/6BwoDvAr/TW1uIbk9Fl4q9K69FgSgRDxWBZtG+FXT79ZnaNI4115aeFhttIdc57uLYZPZ0yTx1q3ViFPEnsYz4pOSGpq5uq/C+ISqAanLswjmcGk0F5nABgBNy14zNhS+ZA4V7siae5N6+O9Jog4Ha3rwhqenoF5kQSrUHsmGvDgcH7c6+HUDa16Qx5OfU0A6/wqWczJoc/pPa5TX8ucaaar/fck8bF2RNK66SxyNrHFfJWT6/ajU9NJn/o/pCYnJTyIUx+D2liLjbx+sf+UQNJ5h2jYvfggvD4epT+nftNHqwXlKX7vh7vULQ6LADuffdMLfEpQ6JhGHNrcOjqFINJOhYOgKtkM7jKBE61VclmNyMhjv3iyfI/Tjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(83380400001)(316002)(7696005)(6506007)(53546011)(86362001)(2906002)(66446008)(38100700002)(66476007)(64756008)(66556008)(76116006)(66946007)(55016003)(508600001)(52536014)(33656002)(186003)(5660300002)(8936002)(110136005)(38070700005)(44832011)(26005)(71200400001)(9686003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dlN0U3pPdjh5Y1ExWWREc3NheXlvdUJubjlSUkh0T2duTDBTZk1RQkx1WUx3?=
 =?gb2312?B?a0VseFcrdVdpTWw1T3pmdkFGankyQmJHMmYvdFlBTnNmUGRHSk5INlRyR3NU?=
 =?gb2312?B?bitOVCt1RG1HZ09tSjlFOXZhOGR2Mkx3NUp4QTFqMU9wb0FlV0JNNkh6ZkxN?=
 =?gb2312?B?OEl3bm4yYnpXK0dUNytzeXpmNEFhbjhlYm1GUkpaNzRsR29GdlM2Tm01UnVQ?=
 =?gb2312?B?OEREbUZFWUw5TmVBeVZhTmpFSFA2bFdTRXNnZHNZbXUxZDV5MEtudkFmRk1p?=
 =?gb2312?B?THgwR3dETFRxTDZZOG82L0VGV0hiMWVVbjFHbFp6cFVEOVFNeTFGYXA1YWt5?=
 =?gb2312?B?cnMwRno3Myt2SGFtODZ2aWI5STRSbkdkQVdObG1pUE1wNjlaWnkyK3pPNjlP?=
 =?gb2312?B?c0VJdERRaGtLZXRoclliRnJURDBOMG9wNWhhVEVCSEE1VEpWVkl1S2xSdVRk?=
 =?gb2312?B?Njhyc3NqVVlabFVGcHhYbmEzQUpoQnUraURiR2pKSUxobkE5VVRKNHRLZnJN?=
 =?gb2312?B?U2JLRjRVbUpRN3VFa2lxTy8rMUZNei8zUE8yd3FNK2QxV2FRQUdPVFptY3dB?=
 =?gb2312?B?TnpIQUZXTUpGWWRJaWtUNTNhdnI1N2k2NjdMNVRJekJTVXZNR1ZOVXZqeGpv?=
 =?gb2312?B?SFRPRkNjTEpmNjhnL2FoSTIxQWUrK3I1aHpwUG9LMDhaR1JhSFpmODc4aU9h?=
 =?gb2312?B?Ni95SHVoeGhOUDd0alJYdmxReHdFV0hYa201LzFqcHlxT2ZtUmxSckx0NTFl?=
 =?gb2312?B?MURYTVdYZ0NZb3U0V3RrRXVhSGRsNnpKS04yUnZDZklNbndqQlhxeWl5SlpP?=
 =?gb2312?B?amFjSlgrTGxXM294aFFuUDJwVVV2MlRtNklBR2tQZXB2UWlSOHUyV1ROK0Q2?=
 =?gb2312?B?Y08xN0Q0UkY5STZrUFZDa2lGRjllZnRCTWNOL3F4bW1rTHA3R29sUlEzS3NU?=
 =?gb2312?B?bStDK3FWQnNJR1pZcUhkNmU2Rkx3Q0RUZTRwaTdBL3p6cUNlWkRKek94UEtN?=
 =?gb2312?B?Ukd4dXEzYTViVHlPaXdEWUR4bU1udzEvbCtFVFAzV290OWZka2hienRPd3do?=
 =?gb2312?B?Y0JrZ054ZEQzbWNiRGxzazNWRWlwc2cxUTBRdHZBU1dMeEdXc2c2Ny9ud0F4?=
 =?gb2312?B?WVpKYUluZ1pNc1R6WEtGVTBtRjd0STZmbzE4M3kwdWd3RUptR1c0TUM3alVT?=
 =?gb2312?B?ZUx1SHpkTkN0WDJSL0VkUjZxSFdHWDR4Y3JFSU1VR2EvK2hraXBaZnljSUdB?=
 =?gb2312?B?RWNBejVSZ1VYeXVDcVhaRFBEbStOOXV6Q2JXMWpxdXJ2ZHVTSHUvNTRuQTJr?=
 =?gb2312?B?Q0hTaWFhTXNweVBnejlKVlB5bytpYWxCN0FWTmtIS1NQVzR3eWVINFdFS1VY?=
 =?gb2312?B?eGVpbUljajBwWnliVVVEcXNjSTF5QlpnVm5Ua0pxeUR6YTdhc0Z4ai93amEy?=
 =?gb2312?B?ZzFZREJRZ1Q0WVFmNXpBNjFwV0ppby9aNERUWXJTQStqWE9aNHF3QzA4dUYw?=
 =?gb2312?B?NnlmMFBJajVmR0F3K2lXMWlEV1JtYS9Hc3luKzNtWll4NkFwWGRFb3RpdEp3?=
 =?gb2312?B?NDFtYS9IOStuZiszYkp3MFBvaWYvV2JBdzN3TlNJYjY4S0JTdDdNN29pdEt1?=
 =?gb2312?B?enBNQXFCWld4cEU2cWRPemtkekhIdVpsZzlnemNwYjBicm1LdUk5NnJkMnlT?=
 =?gb2312?B?R0FFc3RDKzQ0UWpKa3RkSHQzMS9aVkg3Wk5DUGQ3ZjBmUGpHVysyd2tXejJ6?=
 =?gb2312?B?eGsxd3dXSXNQbEdlbzQ5SERoWnFsS0xYMHI2dW5LcDMveTBXNU0yeGZtQkVm?=
 =?gb2312?B?UTBKMUZmUHFQYW03bDRBQjV0bU1ub2hqcGN1NWJ4U0pLNUhlWXdxL1VsNndL?=
 =?gb2312?B?eXh4dTA4Q2N6Mi9iTlZiZkoyUmduZVlETEtISWNsc2UvdHJKMU5wajQyN205?=
 =?gb2312?B?UWptL0JCYkVLUWpnZGorOFdid21zOTF3UXBCUFVYNFJ1YTZDclpqUjhXcmJ1?=
 =?gb2312?B?QmZkM3NES2xmYWJyQStvMHBGa1pQTHB3QWlBT244MEFxcGxTT2lsdXpDOVhw?=
 =?gb2312?B?U3JZRHFSTnlzMDdjaURETEZwWDYvS1owcEhyRHlldGl0NWp6NG5jU0tuT1lz?=
 =?gb2312?B?Q2VKYy9qVkFjSHlpVGNXdldYaHcxVkxRTnVZZ2hWdk9mem9MUlhOcXA1U1gw?=
 =?gb2312?B?N1RiWXFxb2xpdHlMQ25xbzRhaktWcEpSaURoN21pYkwvak9VeldWdENnSThZ?=
 =?gb2312?B?ZlBkblUzTTBHTG9CNmF1VFExakYxL1RiZDJtTkdNbk5icmVBMGg3RkdVd2lF?=
 =?gb2312?B?SVYyTnlJdWRkMVRqS1pGTjhwQWRMK3Axbm9tMTRQNmFTaXpBNEJkdz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100baa90-c788-44e5-1aeb-08da4868852a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 09:31:37.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22TS7FRHKlKtnqTXUZE1hFCI6QAJawgY9hybmeUL9ME6ypIIFeXn2/hKpr6jSW9kHqU3U38ExML1tVwMy4fZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBaaXlhbmcgWHVhbiA8d2lsbGlhbS54dWFueml5YW5nQGh1YXdlaS5jb20+DQo+IFNl
bnQ6IDIwMjLE6jbUwjbI1SAyMToxMQ0KPiBUbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNv
bT47IFNoaWppZSBRaW4gPHNoaWppZS5xaW5AbnhwLmNvbT47IEVhZ2xlDQo+IFpob3UgPGVhZ2xl
Lnpob3VAbnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gbGludXgtbWVkaWFAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiB3aWxsaWFtLnh1
YW56aXlhbmdAaHVhd2VpLmNvbQ0KPiBTdWJqZWN0OiBbUEFUQ0hdIG1lZGlhOiBhbXBoaW9uOiBk
ZWxldGUgdW5uZWNlc3NhcnkgTlVMTCBjaGVjaw0KPiANCj4gdmZyZWUoTlVMTCkgaXMgc2FmZS4g
TlVMTCBjaGVjayBiZWZvcmUgdmZyZWUoKSBpcyBub3QgbmVlZGVkLg0KPiBEZWxldGUgdGhlbSB0
byBzaW1wbGlmeSB0aGUgY29kZS4NCj4gDQo+IEdlbmVyYXRlZCBieSBjb2NjaW5lbGxlIHNjcmlw
dDoNCj4gCXNjcmlwdHMvY29jY2luZWxsZS9mcmVlL2lmbnVsbGZyZWUuY29jY2kNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFppeWFuZyBYdWFuIDx3aWxsaWFtLnh1YW56aXlhbmdAaHVhd2VpLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IG1pbmdfcWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jICAgICB8IDMgKy0tDQo+ICBk
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmVuYy5jICAgICB8IDMgKy0tDQo+ICBkcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2NtZHMuYyB8IDMgKy0tDQo+ICAzIGZpbGVz
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+IGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZkZWMuYw0KPiBpbmRleCAzYzAyYWEyYTU0YWEuLjA5ZDRm
Mjc5NzBlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3Zk
ZWMuYw0KPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+IEBA
IC0xMzY5LDggKzEzNjksNyBAQCBzdGF0aWMgdm9pZCB2ZGVjX2NsZWFudXAoc3RydWN0IHZwdV9p
bnN0ICppbnN0KQ0KPiAgCQlyZXR1cm47DQo+IA0KPiAgCXZkZWMgPSBpbnN0LT5wcml2Ow0KPiAt
CWlmICh2ZGVjKQ0KPiAtCQl2ZnJlZSh2ZGVjKTsNCj4gKwl2ZnJlZSh2ZGVjKTsNCj4gIAlpbnN0
LT5wcml2ID0gTlVMTDsNCj4gIAl2ZnJlZShpbnN0KTsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZW5jLmMNCj4gYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2FtcGhpb24vdmVuYy5jDQo+IGluZGV4IDQzZDYxZDgyZjU4Yy4uNDYxNTI0ZGQxZTQ0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmVuYy5jDQo+
ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZW5jLmMNCj4gQEAgLTkxOSw4
ICs5MTksNyBAQCBzdGF0aWMgdm9pZCB2ZW5jX2NsZWFudXAoc3RydWN0IHZwdV9pbnN0ICppbnN0
KQ0KPiAgCQlyZXR1cm47DQo+IA0KPiAgCXZlbmMgPSBpbnN0LT5wcml2Ow0KPiAtCWlmICh2ZW5j
KQ0KPiAtCQl2ZnJlZSh2ZW5jKTsNCj4gKwl2ZnJlZSh2ZW5jKTsNCj4gIAlpbnN0LT5wcml2ID0g
TlVMTDsNCj4gIAl2ZnJlZShpbnN0KTsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vYW1waGlvbi92cHVfY21kcy5jDQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9hbXBoaW9uL3ZwdV9jbWRzLmMNCj4gaW5kZXggOWIzOWQ3N2ExNzhkLi5mNGQ3Y2E3OGE2MjEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfY21kcy5j
DQo+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfY21kcy5jDQo+IEBA
IC0xMTcsOCArMTE3LDcgQEAgc3RhdGljIHZvaWQgdnB1X2ZyZWVfY21kKHN0cnVjdCB2cHVfY21k
X3QgKmNtZCkgIHsNCj4gIAlpZiAoIWNtZCkNCj4gIAkJcmV0dXJuOw0KPiAtCWlmIChjbWQtPnBr
dCkNCj4gLQkJdmZyZWUoY21kLT5wa3QpOw0KPiArCXZmcmVlKGNtZC0+cGt0KTsNCj4gIAl2ZnJl
ZShjbWQpOw0KPiAgfQ0KPiANCj4gLS0NCj4gMi4yNS4xDQoNCg==
