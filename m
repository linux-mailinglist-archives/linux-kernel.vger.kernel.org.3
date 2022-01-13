Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D68A48D2B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiAMHS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:18:59 -0500
Received: from mail-am6eur05on2063.outbound.protection.outlook.com ([40.107.22.63]:56454
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229670AbiAMHS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:18:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MncOAD626fb8CZhBO8/6qNxhX+cMvUQi3uP3QdDuj2f3C/ggfOgz+UdU9NA+tiQBf7CWDlbbLhjDlIE4FsRLWCLLOf7SlKVUT2lniUJy2WwVjCWmYjhsG49chvVFjXcKNHsdQYkRDyWQH2rBL342w+iGD0f9Cs8gRjPZpvh1yvD45sH7gumc9E/cMD4E7xJJJDA0HRs5xOcSsyP3ZcV9jiU8hM9yTFnEXNzDbAFSyWdcZPPCLPbp4Wyhnvhe7CaqCwy4RPNAivMMtwwqgBJet/0v7oC/1sTZ4SskRRp0FsQ1CZ6MLNiLMEJj/CZhJP7qoLlNnC71GIGXvK2ufXDmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2192vmRJnjRjIFYsiqRwIDkN9b57PfMzo0jYMjkNOmo=;
 b=KJwFvGHKkTyqmp4+MA3lKpEB9CI64U9OWjRR+PFiplmeIN0AhLtoxMtZIisbv1wUmhBA1Ww7LgxAAAe+uNr33/25catmPjAufJLeVBD7GB3S7hY/328wHaabE3yqM7gdW5OwF6D0cRWzlQDMDL9bP1zWoEDNH2GNWJr66oC226pMMBVnOtLA6Muq8RLj9pN7Zs09sfPY6DdHkBjo2W68GIDfh/RNfrYHuulM8Lx0z9efYuCsgmWqmkQY9Dwksfn+XtYPKmj1JyvoxWUCa6hOB5Z6CPHZsY/7g7l7DdlTF1T9CmvkkKvIpeADuPV3B0hJOmkr5ofg4LyJGllncX9AOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2192vmRJnjRjIFYsiqRwIDkN9b57PfMzo0jYMjkNOmo=;
 b=k5ycw876kSMcqRPuIggXKY36Qx8fBSRhpsusoEoYwVr5PA99vfrYAA6i1lDKCPrTm17MjLVlp+NuklUWJ5VId9D2gYghtPwt5GzaFsFmYED3wK2nu+Pc/6JeX2FroeVPASkLdKOpZiikcjKeJARKXoau6eqifGI5zdLokg4gjnk=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR0401MB2296.eurprd04.prod.outlook.com (2603:10a6:4:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 07:18:55 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::b9f1:7371:3484:95b2]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::b9f1:7371:3484:95b2%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 07:18:55 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v8 04/15] media:Add v4l2 event codec_error and
 skip
Thread-Topic: [EXT] Re: [PATCH v8 04/15] media:Add v4l2 event codec_error and
 skip
Thread-Index: AQHXo8VyxkIDwZIBZEaUlREH9JiPHauaJHAAgADXIoCAASXVAIDFLAwg
Date:   Thu, 13 Jan 2022 07:18:55 +0000
Message-ID: <AM6PR04MB63417E126287421BCA133514E7539@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1631002447.git.ming.qian@nxp.com>
         <647f84c1e7c2a48d6492d38fa4f06586235500b8.1631002447.git.ming.qian@nxp.com>
         <fffd24d3374ecb2fbfafa9b85fa0ef8012fc7efa.camel@ndufresne.ca>
         <AM6PR04MB634124118288EC775F05AFC3E7D59@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <8984f8a3c0dfd3a5f83fb5cc7b0357dca4787274.camel@ndufresne.ca>
In-Reply-To: <8984f8a3c0dfd3a5f83fb5cc7b0357dca4787274.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e995441-c38c-443f-9fcc-08d9d664f5a0
x-ms-traffictypediagnostic: DB6PR0401MB2296:EE_
x-microsoft-antispam-prvs: <DB6PR0401MB2296759C72EAD65B463D2616E7539@DB6PR0401MB2296.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +7rTcmaLu62j1tB2WW2cEr65BhzSdZc5ErRY2U8M4YncGdQo0X5wtzeiF+ayf7rnlRRVT8VJsK4gBBo3K1DAxD924/APStWFfswsFTXM6cE9kmreGbhJymXOJp47xFnvGoYv/G4ELmBJQhlTlkaaqnxNgQu9dQOiEoYXQZSIi7nmejLWjOjcDdB6cwH1INwY9ecKT3aYNvi52DFUVcUJNN1p5klx9us81WISIcG7RAihFelKHaUvYfqxPTC4lNNC6daTGR2IhoICq9FwqpFl/zPRRDhz6/GATMINiyg9vqDK6y22uFL0NmWBnOstzHAS4fgO9fvr+xIANtREG8+rsWdSehofE7GGXlszATaepPW8w/DCIStPcnuSYv42XzquZUk1NTEk99o9aCDkLedpPXGDCvmd1FcZXL9n1eGTRMwQ9fgrSl5tb7fMvSG2Gs7hh3UMwERj3yC05lSt3+s/7OIyb5XcOpJXFUhC0w3uxxmBP6Lk3QQYJyqjqhmE5a6sHUyYhRbEr9Hjvia8GE5nVK6+GGe1v70p8AwZl/gAuZsiSGuYQBna0MnA5K4V2t2jOApHpZ5ZTwX0w9YZD9PmbORtsnW9dQheCCdrg8SXDUkAkQ5rrNILiYmK8rQZxoIjo19zhpFVcTpXmJdgva+9j3Op0MBUQ3aAfji/1wqvRPurSM/I5Q08o7VDd7BEyRfw/rQDuqzh3i3u06vG2jBD7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(86362001)(83380400001)(8676002)(110136005)(5660300002)(2906002)(33656002)(76116006)(186003)(26005)(6506007)(8936002)(4326008)(66476007)(66946007)(38070700005)(66446008)(52536014)(66556008)(316002)(7416002)(64756008)(9686003)(55016003)(38100700002)(508600001)(44832011)(122000001)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnNWWHVtSFRLb1RnNUE5ckRvaWx5Vnc1TzhnZ2xlYmtrMDZqbjdaclFBSHgv?=
 =?utf-8?B?d0hLRXFFakF2bjV6QUVRTHNvWFdiMzVqL2NvUDFIM3pyWWJZNyt4UU5VT0lt?=
 =?utf-8?B?L1AwcmhJYTNhckpUbEhRcVladXhPUGlIaDlRNkc4R0UrNWxKajhqS1U4aDdq?=
 =?utf-8?B?RnB3VTNGejQ2aC9jdE01WFBEVUJjbjQwcUlrSlJYYUxzSzhlalVqVWVhODlN?=
 =?utf-8?B?R1JRQVdpK1F1UCtsRlJQUlhNTFNPbFV0MzVvWFg5elZRMXVMb3ZTaVgwbHZQ?=
 =?utf-8?B?TG9PYkU1MjdkVGpGL2phTVJXNVFlSVd4dmN2V0Z2akNaczhaWHBCWDFKbWtK?=
 =?utf-8?B?dXZiTW54S1NUZE1haHNDZ2draWI3NEIzQllrYWZtNFREVC9ENkYyT2RWbjRY?=
 =?utf-8?B?dXZTUGZtOTU4OFIrb2l6ZHIyU3VSbHh5YTQxeU5RbFVqT2JLalNWaGtOOHhG?=
 =?utf-8?B?YXBIaHBMOGplOVhLaWNSdkI1WHZZVWY1a3lzckFBb0JtS2JqVnJhQ2NaajdN?=
 =?utf-8?B?c2RKaWxVb2F1RHF0YVNYSHRWSDVqRGd4TnVWVDU4QS85SENVWm9nRUlnZkYx?=
 =?utf-8?B?Z3hiV1p4aDc4Ulh0VUxCMmR6am1selZxVk1XNjdUZ2U1aDlCanZoYWhIY2JE?=
 =?utf-8?B?SjlrZEtEbUl4a2F2aW1hZjFRMnV1MSt5OS80d3JPME54cnBwbTFOSWhMWDFZ?=
 =?utf-8?B?SDVZUmdzdERWTjBCYWdCWWhHWGdFQjNyWFMrS2wwN2FPOXNNVk5pemNGQ21q?=
 =?utf-8?B?YjBOUlhmU1ovdjJyN2ZYc0RpQlZaRlA0OS8zZUF2WStPN3Y3NWlHckRQS0tS?=
 =?utf-8?B?YWVvTEY5RWgrcFVYRHdqMVRrWDJWSTlzWG84NG0rYmhLSExHeThTU2UrcDVH?=
 =?utf-8?B?ZHVNcXV4MDRxUXFLaSt3MXNEeUZCcjJyNFZrS0NQOXRYck02VlU0dWViVlZh?=
 =?utf-8?B?MzRjV0J0RW1rOENaakNwMXBXUDRCbUtDYWxnNHlGRjVOUDhaRjI1d29sY3Fa?=
 =?utf-8?B?b2VGR2tXREFLWHRpZzFydDVJNlpjYUVxKzRRaXQydjI2T2IwSG9GajdpLzZx?=
 =?utf-8?B?eDBYOU43cXFRc3N5WmU4ZDhmRnAvRFQrU1htcjZwcDZCQjI0U2lpVktSRCtU?=
 =?utf-8?B?aGt3UTVxblBaakFTb01YVm5jalh4blpLbHJjckorSG1tS0NRR2NOSVd6NXNj?=
 =?utf-8?B?UVYrWmxGTEZpK3pBZjFHaHRWS09WaDdQbTdDOVhsTm1NTytlc1UwdlhWeS95?=
 =?utf-8?B?ZzduLzhpWm1Fa3V3c3VvRUxzTUppb2w0NzQ3WVgyVXFUcmU4c2g3bXhzZ09N?=
 =?utf-8?B?Q29HMTB6VjBWcnllRWhNZHlNNlkrWFFWa2s5MWg4clBTU2NIS0VhZHd6R0tq?=
 =?utf-8?B?YTJ5UVk1akhQc2JQTWwxZDU3TzNiRG9BRzlkblpydnhWVGdxcGhRejVkc2cv?=
 =?utf-8?B?YnNITmcrd25tMGpaK0dpc2NQSnBxbFBCQUkyMTNFYXNjVWFIdTA4V2Nqbit5?=
 =?utf-8?B?OU0rdlJYQjg0VEpac1RwNldBRDUyYlovK2lwMGtVazVXdVluTUZjQ0RMOURO?=
 =?utf-8?B?N2hSUm9xVnBYWXZscll1VDVoNTVvRnJuZ1BsTUo4U0hRSjZJWUZUM2lpUEFp?=
 =?utf-8?B?aGN6b1pYeHBiOGhnUXZHejdsaTEwN3lpY0RQODdMY3dSL0MwZmVvUDhrcTAy?=
 =?utf-8?B?TTV6TjBCalFQMms4VTMxaElMTDRvMzZBMXIrclVRTUsxcmg3RmdDOWI4SFNu?=
 =?utf-8?B?eVhxWnozdWJ1VzBVZVR4S2lRcDRqb1F5NDNacW54ZlR3UC96TmRITW9BVHNq?=
 =?utf-8?B?QVN0QmpEYjEvQWp3bjZrKy9OZzE3WWFlVXhaK3BLT3ljUTBBWHRvMThuR1Er?=
 =?utf-8?B?MlpjaWlmeE5qSlg2VnI1bXcvYy9nYnJFK3NrUkZmbEN3WjBVSDFvWmRmQUtT?=
 =?utf-8?B?VTB4bW1hYnpuMEtqdGNFRVE4M0czd1R6aVJpYndWZThNc09TTkxJWGVCRUZl?=
 =?utf-8?B?QURXV0dZaUE0andlR1ExdXM0SFhkQ0c1ZUVjZ3B6blpBb2lySHYrV1BtL3k2?=
 =?utf-8?B?YkV4aFcxYUFPZ3BJT21wbjNOL2xDdHU2SVloV1F3MU4ySHVNVlBUcmpDVnZS?=
 =?utf-8?B?d2wySVczRm9XRUc5ZE5VK2pYNE0zbEwwYkcwaFNQaXk1YXR2V0lXV1pEY2RP?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e995441-c38c-443f-9fcc-08d9d664f5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 07:18:55.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYoKKGPpSSg8H01p60y6ycNmnF/AAxi+kaaacSZMQsoJhVbj1eTsyzfi6uqBeR9FA7XwjzKznV8Qg7XOg6Ya5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2296
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KICAgSSBoYXZlIHF1ZXN0aW9uIGFib3V0IHNraXAgZXZlbnQgb3Igc2lt
aWxhciBjb25jZXB0cy4NCklmIHRoZSBjbGllbnQgY29udHJvbCB0aGUgaW5wdXQgZnJhbWUgY291
bnQsIGFuZCBpdCB3b24ndCBxdWV1ZSBhbnkgbW9yZSBmcmFtZXMgdW5sZXNzIHNvbWUgZnJhbWUg
aXMgZGVjb2RlZC4NCkJ1dCBhZnRlciBzZWVrLCBUaGVyZSBpcyBubyByZXF1aXJlbWVudCB0byBi
ZWdpbiBxdWV1aW5nIGNvZGVkIGRhdGEgc3RhcnRpbmcgZXhhY3RseSBmcm9tIGEgcmVzdW1lIHBv
aW50IChlLmcuIFNQUyBvciBhIGtleWZyYW1lKS4gQW55IHF1ZXVlZCBPVVRQVVQgYnVmZmVycyB3
aWxsIGJlIHByb2Nlc3NlZCBhbmQgcmV0dXJuZWQgdG8gdGhlIGNsaWVudCB1bnRpbCBhIHN1aXRh
YmxlIHJlc3VtZSBwb2ludCBpcyBmb3VuZC4gV2hpbGUgbG9va2luZyBmb3IgYSByZXN1bWUgcG9p
bnQsIHRoZSBkZWNvZGVyIHNob3VsZCBub3QgcHJvZHVjZSBhbnkgZGVjb2RlZCBmcmFtZXMgaW50
byBDQVBUVVJFIGJ1ZmZlcnMuDQoNClNvIGNsaWVudCBtYXkgaGF2ZSBxdWV1ZWQgc29tZSBmcmFt
ZXMgYnV0IHdpdGhvdXQgYW55IHJlc3VtZSBwb2ludCwgaW4gdGhpcyBjYXNlIHRoZSBkZWNvZGVy
IHdvbid0IHByb2R1Y2UgYW55IGRlY29kZWQgZnJhbWVzIGludG8gQ0FQVFVSRSBidWZmZXJzLCBh
bmQgdGhlIGNsaWVudCB3b24ndCBxdWV1ZSBmcmFtZXMgaW50byBvdXRwdXQgYnVmZmVycy4gVGhp
cyBjcmVhdGVzIHNvbWUga2luZCBvZiBkZWFkbG9jay4NCg0KSW4gb3VyIHByZXZpb3VzIHNvbHV0
aW9uLCB3ZSBzZW5kIHNraXAgZXZlbnQgdG8gY2xpZW50IHRvIHRlbGwgaXQgdGhhdCBzb21lIGZy
YW1lIGlzIHNraXBwZWQgaW5zdGVhZCBvZiBkZWNvZGVkLCB0aGVuIHRoZSBjbGllbnQgY2FuIGNv
bnRpbnVlIHRvIHF1ZXVlIGZyYW1lcy4NCkJ1dCB0aGUgc2tpcCBldmVudCBpcyBmbGF3ZWQsIHNv
IHdlIG5lZWQgc29tZSBzb2x1dGlvbiB0byByZXNvbHZlIGl0Lg0KMS4gZGVjb2RlciBjYW4gcHJv
ZHVjZSBhbiBlbXB0eSBidWZmZXIgd2l0aCBWNEwyX0JVRl9GTEFHX1NLSVBQRUQgKG9yIFY0TDJf
QlVGX0ZMQUdfRVJST1IpIGFzIHlvdSBhZHZpc2VkLCBidXQgdGhpcyBzZWVtcyB0byBjb25mbGlj
dCB3aXRoIHRoZSBhYm92ZSBkZXNjcmlwdGlvbiBpbiBzcGVjaWZpY2F0aW9uLg0KMi4gRGVmaW5l
IGEgbm90aWZpY2F0aW9uIG1lY2hhbmlzbSB0byBub3RpZnkgdGhlIGNsaWVudA0KDQpDYW4geW91
IGdpdmUgc29tZSBhZHZpY2U/ICBUaGlzIGNvbnN0cmFpbnQgb2YgZnJhbWUgZGVwdGggaXMgY29t
bW9uIG9uIGFuZHJvaWQNCg0KTWluZw0KDQo+ID4gPiA+ICsgICAgKiAtIGBgVjRMMl9FVkVOVF9T
S0lQYGANCj4gPiA+ID4gKyAgICAgIC0gOA0KPiA+ID4gPiArICAgICAgLSBUaGlzIGV2ZW50IGlz
IHRyaWdnZXJlZCB3aGVuIG9uZSBmcmFtZSBpcyBkZWNvZGVkLCBidXQgaXQNCj4gPiA+ID4gKyB3
b24ndA0KPiA+ID4gPiBiZQ0KPiA+ID4gb3V0cHV0ZWQNCj4gPiA+ID4gKyAgICAgdG8gdGhlIGRp
c3BsYXkuIFNvIHRoZSBhcHBsaWNhdGlvbiBjYW4ndCBnZXQgdGhpcyBmcmFtZSwgYW5kDQo+ID4g
PiA+ICsgdGhlDQo+ID4gPiA+IGlucHV0DQo+ID4gPiBmcmFtZSBjb3VudA0KPiA+ID4gPiArICAg
ICBpcyBkaXNtYXRjaCB3aXRoIHRoZSBvdXRwdXQgZnJhbWUgY291bnQuIEFuZCB0aGlzIGV2ZXZ0
IGlzDQo+ID4gPiA+ICsgdGVsbGluZw0KPiA+ID4gPiB0aGUNCj4gPiA+IGNsaWVudCB0bw0KPiA+
ID4gPiArICAgICBoYW5kbGUgdGhpcyBjYXNlLg0KPiA+ID4NCj4gPiA+IFNpbWlsYXIgdG8gbXkg
cHJldmlvdXMgY29tbWVudCwgdGhpcyBldmVudCBpcyBmbGF3ZWQsIHNpbmNlDQo+ID4gPiB1c2Vy
c3BhY2UgY2Fubm90IGtub3cgd2VyZSB0aGUgc2tpcCBpcyBsb2NhdGVkIGluIHRoZSBxdWV1ZWQN
Cj4gPiA+IGJ1ZmZlcnMuIEN1cnJlbnRseSwgYWxsIGRlY29kZXJzIGFyZSBtYW5kYXRlZCB0byBz
dXBwb3J0DQo+ID4gPiBWNEwyX0JVRl9GTEFHX1RJTUVTVEFNUF9DT1BZLiBUaGUgdGltZXN0YW1w
IG11c3QgTk9UIGJlDQo+IGludGVycHJldGVkDQo+ID4gPiBieSB0aGUgZHJpdmVyIGFuZCBtdXN0
IGJlIHJlcHJvZHVjZSBhcy1pcyBpbiB0aGUgYXNzb2NpYXRlZCBDQVBUVVJFDQo+ID4gPiBidWZm
ZXIuIEl0IGlzIHBvc3NpYmxlIHRvICJnYXJiYWdlIiBjb2xsZWN0IHNraXBwZWQgZnJhbWVzIHdp
dGggdGhpcw0KPiA+ID4gbWV0aG9kLCB0aG91Z2ggdGVkaW91cy4NCj4gPiA+DQo+ID4gPiBBbiBh
bHRlcm5hdGl2ZSwgYW5kIEkgdGhpbmsgaXQgd291bGQgYmUgbXVjaCBuaWNlciB0aGVuIHRoaXMs
IHdvdWxkDQo+ID4gPiBiZSB0byB1c2UgdGhlIHY0bDJfYnVmZmVyLnNlcXVlbmNlIGNvdW50ZXIs
IGFuZCBqdXN0IG1ha2UgaXQgc2tpcCAxDQo+ID4gPiBvbiBza2lwcy4gVGhvdWdoLCB0aGUgZG93
biBzaWRlIGlzIHRoYXQgdXNlcnNwYWNlIG11c3QgYWxzbyBrbm93IGhvdw0KPiA+ID4gdG8gcmVv
cmRlciBmcmFtZXMgKGEgZHJpdmVyIGpvYiBmb3Igc3RhdGVsZXNzIGNvZGVjcykgaW4gb3JkZXIg
dG8NCj4gPiA+IGlkZW50aWZ5IHdoaWNoIGZyYW1lIHdhcyBza2lwcGVkLiBTbyB0aGlzIGlzIHBl
cmhhcHMgbm90IHRoYXQNCj4gPiA+IHVzZWZ1bCwgb3RoZXIgdGhlbiBrbm93aW5nIHNvbWV0aGlu
ZyB3YXMgc2tpcHBlZCBpbiB0aGUgcGFzdC4NCj4gPiA+DQo+ID4gPiBBIHRoaXJkIG9wdGlvbiB3
b3VsZCBiZSB0byBpbnRyb2R1Y2UgVjRMMl9CVUZfRkxBR19TS0lQUEVELiBUaGlzIHdheQ0KPiA+
ID4gdGhlIGRyaXZlciBjb3VsZCByZXR1cm4gYW4gZW1wdHkgcGF5bG9hZCAoYnl0ZXN1c2VkID0g
MCkgYnVmZmVyIHdpdGgNCj4gPiA+IHRoaXMgZmxhZyBzZXQsIGFuZCB0aGUgcHJvcGVyIHRpbWVz
dGFtcCBwcm9wZXJseSBjb3BpZWQuIFRoaXMgd291bGQNCj4gPiA+IGxldCB0aGUgZHJpdmVyIGNv
bW11bmljYXRlIHNraXBwZWQgZnJhbWVzIGluIHJlYWwtdGltZS4gTm90ZSB0aGF0DQo+ID4gPiB0
aGlzIGNvdWxkIGJyZWFrIHdpdGggZXhpc3RpbmcgdXNlcnNwYWNlLCBzbyBpdCB3b3VsZCBuZWVk
IHRvIGJlDQo+ID4gPiBvcHRlZC1pbiBzb21laG93IChhIGNvbnRyb2wgb3Igc29tZSBmbGFncyku
DQo+ID4NCj4gPiBIaSBOaWNvbGFzLA0KPiA+ICAgIFRoZSBwcm9ibGVtIHdlIG1lZXQgaXMgdGhh
dCB1c2Vyc3BhY2UgZG9lc24ndCBjYXJlIHdoaWNoIGZyYW1lIGlzDQo+ID4gc2tpcHBlZCwgaXQg
anVzdCBuZWVkIHRvIGtub3cgdGhhdCB0aGVyZSBhcmUgYSBmcmFtZSBpcyBza2lwcGVkLCB0aGUN
Cj4gPiBkcml2ZXIgc2hvdWxkIHByb21pc2UgdGhlIGlucHV0IGZyYW1lIGNvdW50IGlzIGVxdWFs
cyB0byB0aGUgb3V0cHV0IGZyYW1lDQo+IGNvdW50Lg0KPiA+ICAgICBZb3VyIGZpcnN0IG1ldGhv
ZCBpcyBwb3NzaWJsZSBpbiB0aGVvcnksIGJ1dCB3ZSBmaW5kIHRoZSB0aW1lc3RhbXANCj4gPiBt
YXkgYmUgdW5yZWxpYWJsZSwgd2UgbWVldCBtYW55IHRpbWVzdGFtcCBpc3N1ZXMgdGhhdCB1c2Vy
c3BhY2UgbWF5DQo+ID4gZW5xdWV1ZSBpbnZhbGlkIHRpbWVzdGFtcCBvciByZXBlYXRlZCB0aW1l
c3RhbXAgYW5kIHNvIG9uLCBzbyB3ZSBjYW4ndA0KPiBhY2NlcHQgdGhpcyBzb2x1dGlvbi4NCj4g
DQo+IFRoZSBkcml2ZXIgc2hvdWxkIG5vdCBpbnRlcnByZXQgdGhlIHByb3ZpZGVkIHRpbWVzdGFt
cCwgc28gaXQgc2hvdWxkIG5vdCBiZQ0KPiBhYmxlIHRvIHNheSBpZiB0aGUgdGltZXN0YW1wIGlz
IHZhbGlkIG9yIG5vdCwgdGhpcyBpcyBub3QgdGhlIGRyaXZlcidzIHRhc2suDQo+IA0KPiBUaGUg
ZHJpdmVyIHRhc2sgaXMgdG8gbWF0Y2ggdGhlIHRpbWVzdGFtcCB0byB0aGUgQ0FQVFVSRSBidWZm
ZXIgKGlmIHRoYXQgYnVmZmVyDQo+IHdhcyBwcm9kdWNlZCksIGFuZCByZXByb2R1Y2UgaXQgZXhh
Y3RseS4NCj4gDQo+ID4gICAgIEkgdGhpbmsgeW91ciBzZWNvbmQgb3B0aW9uIGlzIGJldHRlci4g
QW5kIHRoZXJlIGFyZSBvbmx5IDENCj4gPiBxdWVzdGlvbiwgd2UgZmluZCBzb21lIGFwcGxpY2F0
aW9uIHByZWZlciB0byB1c2UgdGhlIFY0TDJfRVZFTlRfRU9TIHRvDQo+ID4gY2hlY2sgdGhlIGVv
cywgbm90IGNoZWNraW5nIHRoZSBlbXB0eSBidWZmZXIsIGlmIHdlIHVzZSB0aGlzIG1ldGhvZCB0
bw0KPiA+IGNoZWNrIHNraXBwZWQgZnJhbWUsIHRoZQ0KPiANCj4gQ2hlY2tpbmcgdGhlIGVtcHR5
IGJ1ZmZlciBpcyBhIGxlZ2FjeSBtZXRob2QsIG9ubHkgYXZhaWxhYmxlIGluIFNhbXN1bmcgTUZD
DQo+IGRyaXZlci4gVGhlIHNwZWMgc2F5cyB0aGF0IHRoZSBsYXN0IGJ1ZmZlciBzaG91bGQgYmUg
ZmxhZ2dlZCB3aXRoIF9MQVNULCBhbmQgYW55DQo+IGZ1cnRoZXIgYXR0ZW1wdCB0byBwb2xsIHNo
b3VsZCB1bmJsb2NrIGFuZCBEUUJVRiByZXR1cm4gRVBJUEUuDQo+IA0KPiA+IGFwcGxpY2F0aW9u
IHNob3VsZCBjaGVjayBlbXB0eSBidWZmZXIgaW5zdGVhZCBvZiBWNEwyX0VWRU5UX0VPUywNCj4g
PiBvdGhlcndpc2UgaWYgdGhlIGxhc3QgZnJhbWUgaXMgc2tpcHBlZCwgdGhlIGFwcGxpY2F0aW9u
IHdpbGwgbWlzcyBpdC4NCj4gPiBPZiBjb3Vyc2UgdGhpcyBpcyBub3QgYSBwcm9ibGVtLCBpdCBq
dXN0IGluY3JlYXNlcyB0aGUgY29tcGxleGl0eSBvZg0KPiA+IHRoZSB1c2Vyc3BhY2UgaW1wbGVt
ZW50YXRpb24NCj4gDQo+IFRoZSBFUElQRSBtZWNoYW5pc20gY292ZXJzIHRoaXMgaXNzdWUsIHdo
aWNoIHdlIGluaXRpYWxseSBoYWQgd2l0aCB0aGUgTEFTVA0KPiBmbGFnLg0KPiANCj4gPiAgICAg
SSBkb24ndCB0aGluayB5b3VyIHRoaXJkIG1ldGhvZCBpcyBmZWFzaWJsZSwgdGhlIHJlYXNvbnMg
YXJlIGFzIGJlbG93DQo+ID4gICAgICAgICAgICAgICAxLiB1c3VhbGx5IHRoZSBlbXB0eSBwYXls
b2FkIG1lYW5zIGVvcywgYW5kIGFzIHlvdSBzYXksDQo+ID4gaXQgbWF5IGludHJvZHVjZSBjb25m
dXNpb24uDQo+ID4gICAgICAgMi4gVGhlIGRyaXZlciBtYXkgbm90IGhhdmUgdGhlIG9wcG9ydHVu
aXR5IHRvIHJldHVybiBhbiBlbXB0eQ0KPiA+IHBheWxvYWQgZHVyaW5nIGRlY29kaW5nLCBpbiBv
dXIgZHJpdmVyLCBkcml2ZXIgd2lsbCBwYXNzIHRoZSBjYXB0dXJlDQo+ID4gYnVmZmVyIHRvIGZp
cm13YXJlLCBhbmQgd2hlbiBzb21lIGZyYW1lIGlzIHNraXBwZWQsIHRoZSBmaXJtd2FyZSB3b24n
dA0KPiA+IHJldHVybiB0aGUgYnVmZmVyLCBkcml2ZXIgbWF5IG5vdCBmaW5kIGFuIGF2YWlsYWJs
ZSBjYXB0dXJlIGJ1ZmZlciB0bw0KPiA+IHJldHVybiB0byB1c2Vyc3BhY2UuDQo+ID4NCj4gPiAg
ICBUaGUgcmVxdWlyZW1lbnQgaXMgdGhhdCB1c2Vyc3BhY2UgbmVlZCB0byBtYXRjaCB0aGUgaW5w
dXQgZnJhbWUNCj4gPiBjb3VudCBhbmQgb3V0cHV0IGZyYW1lIGNvdW50LiBJdCBkb2Vzbid0IGNh
cmUgd2hpY2ggZnJhbWUgaXMgc2tpcHBlZCwNCj4gPiBzbyB0aGUgVjRMMl9FVkVOVF9TS0lQIGlz
IHRoZSBlYXNpZXN0IHdheSBmb3IgZHJpdmVyIGFuZCB1c2Vyc3BhY2UuDQo+ID4gICAgSWYgeW91
IHRoaW5rIHRoaXMgZXZlbnQgaXMgcmVhbGx5IGluYXBwcm9wcmlhdGUsIEkgcHJlZmVyIHRvIGFk
b3B0DQo+ID4geW91ciBzZWNvbmQgb3B0aW9uDQo+IA0KPiBQbGVhc2UsIGRyb3AgU0tJUCBmcm9t
IHlvdSBkcml2ZXIgYW5kIHRoaXMgcGF0Y2hzZXQgYW5kIGZpeCB5b3VyIGRyYWluaW5nDQo+IHBy
b2Nlc3MgaGFuZGxpbmcgdG8gZm9sbG93IHRoZSBzcGVjLiBUaGUgU2Ftc3VuZyBPTVggY29tcG9u
ZW50IGlzDQo+IGlycmVsZXZhbnQgdG8gbWFpbmxpbmUgc3VibWlzc2lvbiwgdGhlIE9NWCBjb2Rl
IHNob3VsZCBiZSB1cGRhdGVkIHRvIGZvbGxvdw0KPiB0aGUgc3BlYy4NCj4gDQo+ID4NCg==
