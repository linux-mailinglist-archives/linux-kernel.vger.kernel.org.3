Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519755CB29
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbiF0QXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiF0QXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:23:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094AA44A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2UhSIqVgAWVizMmzlRXVJ5cC1K12zlmH/ZgziilACrqOnCbWsOF/sVq7M26/YENkRJMxTD2Kl88w514+6EPfbC6z9bCYgYvawjIHc38Y12VsIvGcunA+A5a8yVsLmYVXyYTm6of2W//ZeELBtBXukVkzmmWFn+YYlX5U/iGtdAeFZPVVFFBAaJvyxud6Yw+pEmTlyMRJSxfkuB4FuFwRcb9Pf6EodtSok4Gj1QDt1zOy6RUvuG7NLCu1L9BGWiBtpzpxW25PR9hYzcPtJOSttmR2bS7u+jVGPsqvctIxWXHL3YlK3HknTbNL113JoKrPtFP9Bkd/TN+VnUqiBsabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6HIsa9VXgCtSrsX8db8WUxJNKTxvHcEv0u6Ho0f7xc=;
 b=UUJyVajBIn8CXOhQj4uJTqeJMpHGaqRvFxa07OVUrHoJs7TS2cqYKFlHjXWrLrTGj1KYeuG+TGIs7o5Vcbl9CFGmiv+mxIaLcLYPA1aWVKfxPLzkIFWwjLN+TUWa3GtekOoTit5UwuFowuWHGAs9e8wGKKDZqMsT7U/3kGRoe+TgPKY7JYKCkvfqUOehkSs3TVY0cxfE/tDdsfo2H5Ak49Mx5fwMXVnNYEtz0NBjA+s8gFeF1DMgua3jjdmU3YqSMVjG/8jc7e7QYTs2F9RjpnXxbQ4rFGwR5V415KlaOXhZq1Ih/9vjNXIw9x0iPtepX04GxRu8MPFRioTrC0xECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6HIsa9VXgCtSrsX8db8WUxJNKTxvHcEv0u6Ho0f7xc=;
 b=Hhywf3ap1W/aA08g2Ke/9Q06e+HKtzVGIifRcMyyUeeNBXfPA+7ZnBJHAnGh5AJge/P2QZfw9AuPiQA747F6DmVSTHnOVlKYvcviT5BNmGcLGtm7PMGwWcrWmCaHK3B9BBNvYTynHpgKcLcxfvBAXEdYbwwgSIiMi/McRsTxlrs=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 16:23:10 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::30c4:f356:a806:509a]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::30c4:f356:a806:509a%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 16:23:10 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
CC:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] mtd: rawnand: arasan: Update NAND bus clock
 instead of system clock
Thread-Topic: [PATCH v2 1/2] mtd: rawnand: arasan: Update NAND bus clock
 instead of system clock
Thread-Index: AQHYhUyfBAllq+BbXU+3bAWI6powiK1e6nyAgASOXKA=
Date:   Mon, 27 Jun 2022 16:23:10 +0000
Message-ID: <BN7PR12MB28020605AA6E17BFA68BDF93DCB99@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20220621085500.1005-1-amit.kumar-mahapatra@xilinx.com>
        <20220621085500.1005-2-amit.kumar-mahapatra@xilinx.com>
 <20220624204515.6b003ef9@xps-13>
In-Reply-To: <20220624204515.6b003ef9@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab3ef44e-c601-4bc4-8a4d-08da58595366
x-ms-traffictypediagnostic: DM5PR12MB2359:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iWFHA8Wdiz3oE+2JsQ4Zh1gluXSL5yu/z4jsu7jbYmk9B+8JTQTXsF/fkgYc6LKwfrLtx9MJ3HzQYYHr8vqZQTy2jDLk+ULLXMPBy7Ar2y45YoxN5+aVmhcj8u4Jps1uxWJEEVBEg1C7qhryjUDzgFOBjKYpPqcBggASylgXZYXGorY5RdzFoXfl955XsOnsxsdVSFSjcjfIZmLpZgDwnG+iL+buoCE0BHK6P8bhp+5EcacUNZjaD4Og0O/vad6S0CbPP7YMbraGLc8TxAi+YxP3MMqo+DyV9PPF0fb20GfHjG+lPFPdLaQso8K7WfgUuR/7/Znqmh/NUWOAwHxfisoVSpSx5sy7Cqyt4vgvvzRw/rGTvnW64kM3u+do8gptrlMTohUnsJfC82rQosuao8yLhV03nHU2OSEF6Y6k7lHmohZHy07rcx2+KjThgRLVBWa4Pe9P+1Bvdy03v+6dNptM3j8yM4TwQ2MU1T0jrr+Nhw1kCI1TAjlhqNRWuH+Xf9chHAeFwEIztPqznWJDLSXfb6bKb0l3FSarn2mMQ+jDiNwNmIxBqZYYNP2qCVhCMd9+Yyf+Xue2MZwGUFgs8asTWBjsrz23h5jTbuw4K2kUhI4PZc9riGzR4jpHcFkol1ctckBedsvgaW3W84n2VBkdLRUB0Whw3IHG9gq7zhUm/0noHQmCcryEJhkVVc3HHE0PwsATbpJ9viqrAiKr71V95+JT6C11z6Tng9CSzE2QFgu21Mbm5WS+RrZ22vOTVcm6DUrk2MO3ghnqDdCSMKWeD7pjamjtuQCyTe28oxY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(66574015)(5660300002)(186003)(8676002)(76116006)(122000001)(41300700001)(52536014)(4326008)(66556008)(66946007)(64756008)(66476007)(66446008)(2906002)(8936002)(86362001)(55016003)(6506007)(53546011)(7696005)(33656002)(316002)(15650500001)(54906003)(83380400001)(110136005)(9686003)(26005)(38100700002)(38070700005)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnNZMnJ2cEFSY2kranhRZEtYMnhCaTltNmRCeEdsWWhVNjNKaHpHVnR5Z3NX?=
 =?utf-8?B?WkVoSU1GeXdnMGVZQmhjYWpHUEtla2ZrQXdBZlVLWnh5MXFUK2dCZXFxa1d5?=
 =?utf-8?B?MU5ubWZ2U2FBQjRRclc2UkV0UGN4d1V2N3FvTmhJb0J5OEFlV0tYYndxL0t5?=
 =?utf-8?B?Sys3alhORFFkb004azZ2YWhmOFNoeXBSMWl1cWRvOWMrUGZEVlhSYnUxWnNq?=
 =?utf-8?B?VVljWjRPeDRURnhtK0dtcFpyRGVaY0g1WEFxcm1iRzFxcmhrL2NDd1RyZ1RR?=
 =?utf-8?B?TjBueXRRdzZzclA3ZG1xNnl2TFhLSWdUcXZjWW5NL0xYVlpiS3NZNjRnaVNj?=
 =?utf-8?B?VS90TTM3bi9jdmxsbTBTQk9TbFdmalRTN1djYm5VV1VlMi9jNGQyR01GbEI5?=
 =?utf-8?B?NFN5Ty9VVXpjN09TYXF6cHQrbDUyWVhUVHBsR2prVVN4ZmpKNWdDTjhDSy9M?=
 =?utf-8?B?a3NZM0hRMUhYOGxaeDNvQWh0R3BPQkpETFlRWGo1WU9FdWlaZ1hFbTNJbTY3?=
 =?utf-8?B?M09jU2VSMkthQkgyemVHSGVVOFNDaXRpUGVHY2Mxb2NBeGtoL2U2YXJsMEU3?=
 =?utf-8?B?ajIxUzh5b1VpenJBRHRKUXI0cVFzL3hKb0tGU1ByMHpoOUNMdFQ0R0JMVk9w?=
 =?utf-8?B?NndLWWtyZWQ2aGxzUEtrTzg5bjU0bjBGR3Q4Z0o1dFhlWHZhdG4zNGZndzdR?=
 =?utf-8?B?a3VVZ0VUOWRmSjluNkxYbjFRc3NpcSttQnRjNnhHZmc2VlAxZmU5TklUYkFq?=
 =?utf-8?B?TXdNek1SVi9GNFFFOEJOVW1uaGc4TXNvYWFpKzJhSVpPbks4aG9TU0JtMytl?=
 =?utf-8?B?Q2pwOFI2eEdWVjl3dHkyN2ZXYU50NmczUmE2cGs2ck41WnVlNHRpcFBFbTJi?=
 =?utf-8?B?SWEzc0ZGK3R1ZGZHSGdzY09GaFpXVVo2Y3Z5OGtKYnNqb3piN0c4N3MzdFlS?=
 =?utf-8?B?RmZBUyt1TVpMU0s3SERveVNzNEV4aHNUQXZPTDJ5M25BL21kdFJrUHNNcFFx?=
 =?utf-8?B?VVlPanE5ZEY0UEZDOWMrTE9Yenh4eCt2Z0ZmMk1TbThZbjBwOHV4d2JJdUpz?=
 =?utf-8?B?TnplRktHU0hLYmNCVStBZnNOK1gyMnYyVzZGck1vNlFZUmszbDRFYmx2dUlU?=
 =?utf-8?B?dVB4MGlFalpOZ1N3ZXczeVBmVy9OZTAyZG9nYk1KTXltaGlFczN0RlRPamF2?=
 =?utf-8?B?THJ6RWEwdWYySFFDUDd0UlNTcHdkUm5kekREMjlXa3ZjZGNUYVIrZ2dKV1Fp?=
 =?utf-8?B?RnM5T2NEcXFZWmFGa2Q0RmVJcmllQUV1WDZLM0JnYk0xQkJHaXBSNnNsMTI3?=
 =?utf-8?B?a3IwanBtY0tUMUFmTzRZenRxVTcvNEVOMGlGM1NTWWNINUlmUDZkdno5R0d1?=
 =?utf-8?B?cU0zeWZnZmtuQUVSc3VEaHRHR0J2S0FxVU5xcVAvb2dWSEFFblRCZHF3cjc0?=
 =?utf-8?B?OVJrdlJldkhmREVLMHY0YWo2eEM0ckpNRngxOHkzT2Nnc3hlRVd6c1d0Q2R3?=
 =?utf-8?B?b2ZQMXVJTnVRR0FoNnhJTkRtRXpiWjhUdUlBeDNsL3FtQWt0YmdlZGpwZDVX?=
 =?utf-8?B?YndMclV3MTZkeUVyZFBUMXBOakRTU2UzNzZrRXNlUG9YLytTQWg0SUQ1Ums5?=
 =?utf-8?B?NXVERlkvS3pzRElNaHFJVWdzeFV6eHhrbmJJWi9MNnBJVStSTHF1ZXhnUjlH?=
 =?utf-8?B?Ly9Wc3l2WGVsZ2lpaVdhTTArQzZKNGpBdXFNSTc1UXRXaG41a2NjdmtmRVNB?=
 =?utf-8?B?RTZkWGdNc05qQTRnbEhZM0FRbWNONlBGeS9sVCtMUXNiWkgxcFpEQ2lyNXJW?=
 =?utf-8?B?eGJoR0Y0Tm54Z3dDdzhDVG9VeUQ2Q0FDZEdSNUF3WXkxbXVoTDJxd1pBWUZ0?=
 =?utf-8?B?dnZoTWJGMmgrbm1iKzcrOE5YcUl0V09jNkNUTGIvcXlYTUx0YWhMdGhsdVBw?=
 =?utf-8?B?STg3NHk4L3doZ2NBckZmNVFScjVJUW5EeGhjZWpER0Y5RVhEUkZoN2xDSHFH?=
 =?utf-8?B?YzNMMDhxZUxlV2tzc0lSUGZ6RjZMVE9pR2JOR2Y0R0h3aVIwWjhrYmNEQUth?=
 =?utf-8?B?dGhld3dsS0lCVTRTUUFMaHhNNVh1VjdPSzg0bFBQdFlwV3crODkycEI3YTYy?=
 =?utf-8?Q?QSJ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3ef44e-c601-4bc4-8a4d-08da58595366
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 16:23:10.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXx3TIHMpMPtnVoIpSO9PToUvmBhN72JUvEjtPRfaBugBBRLqENweLcmdSpFIGXtYnjxmyzd9EiYhJqme6bOWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1p
cXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5
LCBKdW5lIDI1LCAyMDIyIDEyOjE1IEFNDQo+IFRvOiBBbWl0IEt1bWFyIE1haGFwYXRyYSA8YW1p
dC5rdW1hci1tYWhhcGF0cmFAeGlsaW54LmNvbT4NCj4gQ2M6IHZpZ25lc2hyQHRpLmNvbTsgZ2l0
IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+Ow0KPiBib3Jpcy5icmV6aWxsb25AY29sbGFib3Jh
LmNvbTsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBNYWhhcGF0cmEsIEFtaXQgS3VtYXIgPGFtaXQua3VtYXItDQo+IG1haGFw
YXRyYUBhbWQuY29tPjsgTWFoYXBhdHJhLCBBbWl0IEt1bWFyIDxhbWl0Lmt1bWFyLQ0KPiBtYWhh
cGF0cmFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIG10ZDogcmF3bmFu
ZDogYXJhc2FuOiBVcGRhdGUgTkFORCBidXMgY2xvY2sNCj4gaW5zdGVhZCBvZiBzeXN0ZW0gY2xv
Y2sNCj4gDQo+IEhpIEFtaXQsDQo+IA0KPiBhbWl0Lmt1bWFyLW1haGFwYXRyYUB4aWxpbnguY29t
IHdyb3RlIG9uIFR1ZSwgMjEgSnVuIDIwMjIgMTQ6MjQ6NTkNCj4gKzA1MzA6DQo+IA0KPiA+IElu
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gdGhlIEFyYXNhbiBOQU5EIGRyaXZlciBpcyB1cGRhdGlu
ZyB0aGUNCj4gPiBzeXN0ZW0gY2xvY2soaS5lLiwgYW5hbmQtPmNsaykgaW4gYWNjb3JkYW5jZSB0
byB0aGUgdGltaW5nIG1vZGVzDQo+ID4gKGkuZS4sIFNEUiBvciBOVkREUikuIEJ1dCBhcyBwZXIg
dGhlIEFyYXNhbiBOQU5EIGNvbnRyb2xsZXIgc3BlYyB0aGUNCj4gPiBmbGFzaCBjbG9jayBvciB0
aGUgTkFORCBidXMgY2xvY2soaS5lLiwgbmZjLT5idXNfY2xrKSwgbmVlZCB0byBiZQ0KPiA+IHVw
ZGF0ZWQgaW5zdGVhZC4gVGhpcyBwYXRjaCBrZWVwcyB0aGUgc3lzdGVtIGNsb2NrIHVuY2hhbmdl
ZCBhbmQNCj4gPiB1cGRhdGVzIHRoZSBOQU5EIGJ1cyBjbG9jayBhcyBwZXIgdGhlIHRpbWluZyBt
b2Rlcy4NCj4gDQo+IFRoaXMgaXMgbm90IHdoYXQgeW91IGRvIGJlbG93LiBJZiB0aGUgY2xvY2sg
dGhhdCBpcyBjaGFuZ2VkIGlzIHRoZSB3cm9uZyBvbmUsDQo+IHRoZW4ganVzdCBjaGFuZ2UgdGhl
IGNsb2NrIHVzZWQgaW4gdGhlIGNsa19zZXRfcmF0ZSBjYWxsIGluc3RlYWQgb2YgY2FsbGluZw0K
PiBjbGtfc2V0X3JhdGUgdHdpY2UgYXQgdGhlIHdyb25nIGxvY2F0aW9uLg0KPiAtPnNldF9pbnRl
cmZhY2UgaXMgZG9uZSBvbmNlIHBlciBjaGlwLCBpZiB5b3UgaGF2ZSB0d28gZGlmZmVyZW50IGNo
aXBzDQo+IG9uIHRoZSBzYW1lIHN5c3RlbSB5b3UgbXVzdCBjaGFuZ2UgdGhlIGNsb2NrIHdoZW4g
eW91IHN3aXRjaCBmcm9tIG9uZQ0KPiBjaGlwIHRvIHRoZSBvdGhlci4gWW91ciBjdXJyZW50IGlt
cGxlbWVudGF0aW9uIGRpc3Jlc3BlY3RzIHRoYXQsDQo+IHVuZm9ydHVuYXRlbHkuDQoNCg0KIFdp
bGwgbWFrZSB0aGUgY2hhbmdlcyBpbiB0aGUgbmV4dCBpdGVyYXRpb24uDQo+IA0KPiA+DQo+ID4g
Rml4ZXM6IDE5N2I4OGZlY2M1MCAoIm10ZDogcmF3bmFuZDogYXJhc2FuOiBBZGQgbmV3IEFyYXNh
biBOQU5EDQo+ID4gY29udHJvbGxlciIpDQo+IA0KPiBSZXF1aXJlcyBhIENjOiBzdGFibGUgdGFn
DQoNCldpbGwgdGhpcyBpbiB0aGUgbmV4dCBpdGVyYXRpb24uDQoNClJlZ2FyZHMsDQpBbWl0DQo+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXQgS3VtYXIgTWFoYXBhdHJhIDxhbWl0Lmt1bWFyLQ0K
PiBtYWhhcGF0cmFAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tdGQvbmFuZC9y
YXcvYXJhc2FuLW5hbmQtY29udHJvbGxlci5jIHwgMTYgKysrKysrKysrKysrKy0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hcmFzYW4tbmFuZC1jb250cm9sbGVy
LmMNCj4gPiBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L2FyYXNhbi1uYW5kLWNvbnRyb2xsZXIuYw0K
PiA+IGluZGV4IDUzYmQxMDczODQxOC4uNGY2ZGE4MmRkMmIxIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbXRkL25hbmQvcmF3L2FyYXNhbi1uYW5kLWNvbnRyb2xsZXIuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvbXRkL25hbmQvcmF3L2FyYXNhbi1uYW5kLWNvbnRyb2xsZXIuYw0KPiA+IEBAIC05Njgs
NiArOTY4LDcgQEAgc3RhdGljIGludCBhbmZjX3NldHVwX2ludGVyZmFjZShzdHJ1Y3QgbmFuZF9j
aGlwDQo+ICpjaGlwLCBpbnQgdGFyZ2V0LA0KPiA+ICAJY29uc3Qgc3RydWN0IG5hbmRfc2RyX3Rp
bWluZ3MgKnNkcjsNCj4gPiAgCWNvbnN0IHN0cnVjdCBuYW5kX252ZGRyX3RpbWluZ3MgKm52ZGRy
Ow0KPiA+ICAJdW5zaWduZWQgaW50IHRjY3NfbWluLCBkcXNfbW9kZSwgZmFzdF90Y2FkOw0KPiA+
ICsJaW50IHJldDsNCj4gPg0KPiA+ICAJaWYgKG5hbmRfaW50ZXJmYWNlX2lzX252ZGRyKGNvbmYp
KSB7DQo+ID4gIAkJbnZkZHIgPSBuYW5kX2dldF9udmRkcl90aW1pbmdzKGNvbmYpOyBAQCAtMTA0
Myw3DQo+ICsxMDQ0LDExIEBAIHN0YXRpYw0KPiA+IGludCBhbmZjX3NldHVwX2ludGVyZmFjZShz
dHJ1Y3QgbmFuZF9jaGlwICpjaGlwLCBpbnQgdGFyZ2V0LA0KPiA+ICAJCQkJIERRU19CVUZGX1NF
TF9PVVQoZHFzX21vZGUpOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlhbmFuZC0+Y2xrID0gQU5GQ19Y
TE5YX1NEUl9ERkxUX0NPUkVfQ0xLOw0KPiA+ICsJcmV0ID0gY2xrX3NldF9yYXRlKG5mYy0+YnVz
X2NsaywgQU5GQ19YTE5YX1NEUl9ERkxUX0NPUkVfQ0xLKTsNCj4gPiArCWlmIChyZXQpIHsNCj4g
PiArCQlkZXZfZXJyKG5mYy0+ZGV2LCAiRmFpbGVkIHRvIGNoYW5nZSBidXMgY2xvY2sgcmF0ZVxu
Iik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPg0KPiA+ICAJLyoNCj4gPiAgCSAq
IER1ZSB0byBhIGhhcmR3YXJlIGJ1ZyBpbiB0aGUgWnlucU1QIFNvQywgU0RSIHRpbWluZyBtb2Rl
cyAwLTENCj4gPiB3b3JrIEBAIC0xMDUyLDggKzEwNTcsMTMgQEAgc3RhdGljIGludCBhbmZjX3Nl
dHVwX2ludGVyZmFjZShzdHJ1Y3QNCj4gbmFuZF9jaGlwICpjaGlwLCBpbnQgdGFyZ2V0LA0KPiA+
ICAJICogODBNSHogd2hlbiB1c2luZyBTRFIgbW9kZXMgMi01IHdpdGggdGhpcyBTb0MuDQo+ID4g
IAkgKi8NCj4gPiAgCWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgInhsbngsenlucW1w
LW5hbmQtY29udHJvbGxlciIpICYmDQo+ID4gLQkgICAgbmFuZF9pbnRlcmZhY2VfaXNfc2RyKGNv
bmYpICYmIGNvbmYtPnRpbWluZ3MubW9kZSA+PSAyKQ0KPiA+IC0JCWFuYW5kLT5jbGsgPSBBTkZD
X1hMTlhfU0RSX0hTX0NPUkVfQ0xLOw0KPiA+ICsJICAgIG5hbmRfaW50ZXJmYWNlX2lzX3Nkcihj
b25mKSAmJiBjb25mLT50aW1pbmdzLm1vZGUgPj0gMikgew0KPiA+ICsJCXJldCA9IGNsa19zZXRf
cmF0ZShuZmMtPmJ1c19jbGssDQo+IEFORkNfWExOWF9TRFJfSFNfQ09SRV9DTEspOw0KPiA+ICsJ
CWlmIChyZXQpIHsNCj4gPiArCQkJZGV2X2VycihuZmMtPmRldiwgIkZhaWxlZCB0byBjaGFuZ2Ug
YnVzIGNsb2NrDQo+IHJhdGVcbiIpOw0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCX0NCj4g
PiArCX0NCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gDQo+IA0KPiBUaGFua3MsDQo+
IE1pcXXDqGwNCg==
