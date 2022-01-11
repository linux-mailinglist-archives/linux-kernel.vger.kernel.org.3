Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4348A9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348917AbiAKIqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:46:04 -0500
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:32295
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235048AbiAKIqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:46:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Inq/djYRzFQpKFOZcvuqVzEpeRCH6D9OO6FWJJSwH8xPpVtivw3PTU7+GV78b5pw5DriA+ZkDMFjeLK2bPlIh/WbhMt/noanF6aV7jA9D1m9BYq7a02ZMQPAz5w5s9CAy4WejKPErf7tZ0X+2kqZH4IVh/ixYzADAhazo7Mxhu+7T933gaOnuMPssYXf9eaI+Gpw+c9x+0sQgVE9LjhzM4CBLHDDUUf7HFwU7qlWhEgW1oopBq5S8VzKtU5/+Xg9xK/UnF1fbsj7fv21TfjdCyEcvVJjYqELSlmvZwHuqa87ijlbWyQdOK7oeqIebDx6F2xJNrebD1RLu42bd44M1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkRnu4ds9mDPiaZk93QbeXKxvXJg2LFUb0msWFzRQE0=;
 b=b5JXZuC7uFICJSl4uIVHTZ0CvTIeIXD/Ofk55yyOMj27cOiiai9zo0WxcBenpJf/EAmPOCOqI3+DxOsyMHWzUic17ij1aZxk9HDBR8/XnaxKO6SYL+YwQ7nDhnufqAP81Hk/NDlMa3ChVeW2PLgc7bbteHX6/Cf1QNqt7BAbXBCpzdHz1ArFdejrM8sM8CWU5h1wNtUoDjH6OKX2/2+Gs0kC5fBur/rXJ4fPTyeIdPext7MkfGoW57epOn19dLkG//cyvYuJn0+EmssZmuuINF9llSkUOubf3hBUP4YEAn9uzJLxzIA2m7/nywt3ajG+eup0BAQVlGsYV5SWBtDFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkRnu4ds9mDPiaZk93QbeXKxvXJg2LFUb0msWFzRQE0=;
 b=s4YWC2NtAcITWx0559JCoNR0n3j9YdzaPxWHJ2ijO5ZPdZJ587Bmq2MutZUkjCNnoS5nOKSZOvvSKxIsbu/3NgqWAN0gRq4+3i6E2WiPF3MaV+F10OGmfVvcnTxqRYTT9j2o6y11BGM0FWksGYoyD+QUzVx5M61YDooewmlLxtc=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB4392.eurprd04.prod.outlook.com (2603:10a6:20b:1c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 08:46:00 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:46:00 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] tty: serial: fsl_lpuart: count tty buffer overruns
Thread-Topic: [PATCH V2] tty: serial: fsl_lpuart: count tty buffer overruns
Thread-Index: AQHYBsSMQY6dBdyKWEalMDjTyLOVCaxdfRKAgAADLOA=
Date:   Tue, 11 Jan 2022 08:46:00 +0000
Message-ID: <AS8PR04MB840417D1AEB9A75D9B4149AB92519@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220111082229.5117-1-sherry.sun@nxp.com>
 <7b6faabc-bbf9-2d93-274a-93df725e4aca@kernel.org>
In-Reply-To: <7b6faabc-bbf9-2d93-274a-93df725e4aca@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02fc4460-a538-4cec-846d-08d9d4decaf9
x-ms-traffictypediagnostic: AM6PR04MB4392:EE_
x-microsoft-antispam-prvs: <AM6PR04MB439255AE62A64962B1E1D88092519@AM6PR04MB4392.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGMLiSPz/YTxILVQBAs5EFoVv3fn7SA7k7zga+WCwUIEldfxOEqLZjuH5wJp46cnd8AWQExXJY6blJ9Xym7GixyoriTqhqvhi+VPQyIm0sFGVHoNVir8uDKpOUIw/UbAqO0edSYv01DLVce/O4nCZxRQQuArUf7H0qEZVCWPkgL74GFw5G59JlcXregXJvGvLey2Q18UYoVb+Q6jcJQOIHQ262XOYagqp4gv4O33asIRmqnhqW44YSzIYklfnLY98kgubcgxv+hz9QD+YB6eG/wJTOaiPKBqF6upGGrD7NeIF9iUNYBEcyWZoq4RT2LDiUbZxox4KLa9seTGe8bID3YPe2rjr2kfTWYYbSUoGqEt9Jisom2haDyCnkoEVIEfYcxaXhl/f+Y2THTvmW7YPwYzUCByUJkYWYIBAZArZN2/rWJ0rzCNKnj/rpDLPO9T2PCHRHnzoPD2cTO+nnucRQZBIHM9Em/E0V4Q6LjiGrZHa53uptEVfYEcyA6aU1ANsgxLHsBOOWQdpYo8lsKcyzpPjFHy6hX795oxujDqLb8p7hcR7BtX3cFGO9XRe7fwlS+QMCkwk1KwDiZfmFeuLloLIGlK4ZmIwpej4SVjhMa4LBOPI+4TScjZcHiQNLCAl+gmD8n6bIwNfzkLloKBZtUgQFNsxSrg8QORx6r8ndPlV1iXaMHR1JY9AehJRYjrdlmBxu5Fsbdk2WmIAH1Kig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(5660300002)(8676002)(55016003)(33656002)(316002)(52536014)(7696005)(83380400001)(26005)(54906003)(38070700005)(4326008)(110136005)(8936002)(86362001)(186003)(44832011)(38100700002)(122000001)(9686003)(64756008)(66946007)(66476007)(66446008)(2906002)(76116006)(508600001)(66556008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkh2R0I4UWJoRkl6bnNZN2Vubi82L1AwN2xZV3UxbFdMdW85SFBMaktORCt4?=
 =?utf-8?B?MFFRTHJWT1R4UHFGcGVWUDRDYVpVbGtmak02cHFkMWJ5VlY3M1hQZnlXSUZB?=
 =?utf-8?B?aVVYbkJ0dlpOSVVQWU1rdDlYYWw3UTFnck9Pc3o0T0ZadHppcXQxWjh1QVZV?=
 =?utf-8?B?MUxabHFXSmJvMWkyVEl3S211NlBnbTJkQk9lMXhSa2prWUJDZlFmUVBhTFVZ?=
 =?utf-8?B?Y21QMTU4ZnNKNXY5Sk1HZmdGTkFJNVcwOUdDS3dzaUtOWlRpQll3WG9KZlhO?=
 =?utf-8?B?NFc3dFpvY3ViUllVMGx6L3RQOFlqNDVqZ1BNbDRrY1Y3OTQrMmJVOFR4V1NF?=
 =?utf-8?B?SldNN3Fna2MzNXNzVU9SOExtY1ZhT3E2MGNxZ0ZlRGhtOTJqYTFLRzZYRzNl?=
 =?utf-8?B?OGlBZUs4UHlnM2FSY1pNQm0vZVV1eDVabXBVL1d3aFFFVCtEYWtjVkNScTdw?=
 =?utf-8?B?bkY4TkkxNEQyQS9jaVMrUzk3MEtUSEVYSTluT1RGZzNNNCt3djUxQlRMWith?=
 =?utf-8?B?cDV6L3VkNENNNFRrRjdkK2hJaC83T1pLcFZ6RWdOeVB2aUNRa0tSM1hhdk9E?=
 =?utf-8?B?WjRQbWU1QzR4d3lFMjdSdTR5U3hHRTkvSkw3Yk4wWkZhSXVpZ0FuU3JOODIz?=
 =?utf-8?B?OGo1RXhtQnREbk5NcDJGS2d1d09hdU9mdEpkWmsxRVlpamJCMjNlNGNHVVpo?=
 =?utf-8?B?UUZkaDh5Sjh3Nzd5SVVwclB3ZzB6dnZUZVRDdU9RUjRvQ1VJMDVlNG1nN29E?=
 =?utf-8?B?S1hrNGxIcDYwVVE2SHV0QVBCWnVJOSsxekhEenRqRW5LY0J1NWhwQ2dDbXV1?=
 =?utf-8?B?eTVJSktuRStxMXN3YjJkckFYbWMzOFVYU3FpMzc2WGlLOTFaZ1REaStJaFo5?=
 =?utf-8?B?VENLTUdMU2hzbG01MmtqUkdzNUhrQTVpS0xyY2swUnh2ZG1oejVtcmNGWnVj?=
 =?utf-8?B?SUl5SWtXem5ZcHc3U1VuT25GaGlhMlZQaERoa3htOE8ydDdoMi96NlNzMVhR?=
 =?utf-8?B?d21IckE1SWI2WEppWDRSa0hoVXVRWHNHN1p2eWpKYWkzWjJ6Nk1kbU5Ec2FI?=
 =?utf-8?B?Q3hhNUJnaUljblU1elFtOUluaS9RWS9Kem9ybHhqZVZvdzhpSGFCTGpWODYv?=
 =?utf-8?B?N1puQ3pUc0lOV08rVzJXYVVIQUNnTVdqY3hsVlkrTVd5TTcrbTNmb0JBRjh2?=
 =?utf-8?B?MGtBTFErUnJobXdxZGRsQWNWZWlqaDQxNDNPUzMzOVpERVA0bSs3UkhsWmpz?=
 =?utf-8?B?SDR0eU5pM3hZR3lOOUFkU01EeGxFNmJFVFg4M0ZMTXgxbHlSNDZYek5TdkVm?=
 =?utf-8?B?UEFkdFFkZEZRbUNobTFaTjlodFJHQktzdVU1NkkvZWJITkF4M2VtcFVhcmdY?=
 =?utf-8?B?bkhGWDBhRGdnY3VCWWM0NDVkbkUwSXVtbjBYOG8rRnBQaU1tNTZnanNIR05O?=
 =?utf-8?B?MG1wSW83TUJjYnNaMUxzTDR2NjNvRXUvcUFZNWdMdXQrbkNKakR4T0RMb2hW?=
 =?utf-8?B?NlUzVGgwcmZ3TUFEUUQ2Y2NuazQ3VlZBd1Z3Z1l1UFI0aTVqWmQwNGtpUGpQ?=
 =?utf-8?B?SUU4R0N0K2FDTEIvYjU3TFJyTmFPbVNxTlRCK2RtbEZBbDcvbTNocW50R0k0?=
 =?utf-8?B?R3dNTXJIV1hseTRPM2lla1JSWjh6TnovS2czSi9rakllRVJoZjh2STlYYldF?=
 =?utf-8?B?bG5mSHJVdmMvbklyTHdBQ3h5ajdvZXJEZDJ1UlBkcUxWeGRvbm9zdVpSUzlC?=
 =?utf-8?B?UkljVlc1TExMcGFYQVdWOFUxVmJoMTlkeisrNVpQRW44RUxveWV5dlJtS2g3?=
 =?utf-8?B?dEhBckJHQSs1N3p0aFVWZGVXRmFGdlpwMTBKcmdPNUhKT1VJeEVSOFFaTHFB?=
 =?utf-8?B?NVdmTVlaNjNiUHhpdk1DNS9pMGY3VjFVVnJzVXNIa2JSNWo1TTBjalpFZm9B?=
 =?utf-8?B?SERHakN2OGtIT2ZneVFzckFYWXFmNjl6d0JaOUVmc3hYaGVLVlJ2REdyMUNC?=
 =?utf-8?B?aFdiejBQVkR2NC9hRHJQeTB2QnBrMGJuZDdFRjFJUkdKSlUxZjF0czl5Qkdr?=
 =?utf-8?B?bld3UldKdjdQZGxrMGZ6SThNZFhic2JmVVkwbXZWWGxrVWY5RjBLOUd0ODNK?=
 =?utf-8?B?YlIyYXVwMDAycmYrUk51TE40TTBGZWgvMGNmQjkzbXB0OE05ZHk0Q3NwWjA4?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fc4460-a538-4cec-846d-08d9d4decaf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 08:46:00.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCguc7Mo+UQCg3Rx0212cl+ASwj8CtysQrayRUgbQgAy349XL3Lso8d05ehZCLRm4FqyEEsnhN1FizVhxwFs4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4392
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlyaSwNCg0KPiA+IEFkZGVkIHN1cHBvcnQgZm9yIGNvdW50aW5nIHRoZSB0dHkgYnVmZmVy
IG92ZXJydW5zIGluIGZzbF9scHVhcnQNCj4gPiBkcml2ZXIgbGlrZSBvdGhlciB1YXJ0IGRyaXZl
cnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5j
b20+DQo+ID4NCj4gPiAtLS0NCj4gPiBjaGFuZ2VzIGluIFYyDQo+ID4gMS4gQ2hhbmdlIHRoZSBj
b3BpZWQgdHlwZSB0byBpbnQgdG8gYXZvaWQgaW1wbGljaXQgY29udmVyc2lvbiwgYXMgdGhlDQo+
ID4gdHR5X2luc2VydF9mbGlwX3N0cmluZyByZXR1cm4gdHlwZSBpcyBpbnQuDQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIHwgMjAgKysrKysrKysrKysrKy0t
LS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0
LmMNCj4gPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgaW5kZXggY2UzZTI2MTQ0
Njg5Li44MmExYTI4MTc3NTANCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJp
YWwvZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQu
Yw0KPiAuLi4NCj4gPiBAQCAtMTExNiw3ICsxMTE4LDcgQEAgc3RhdGljIHZvaWQgbHB1YXJ0X2Nv
cHlfcnhfdG9fdHR5KHN0cnVjdA0KPiBscHVhcnRfcG9ydCAqc3BvcnQpDQo+ID4gICAJc3RydWN0
IGRtYV9jaGFuICpjaGFuID0gc3BvcnQtPmRtYV9yeF9jaGFuOw0KPiA+ICAgCXN0cnVjdCBjaXJj
X2J1ZiAqcmluZyA9ICZzcG9ydC0+cnhfcmluZzsNCj4gPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPiA+IC0JaW50IGNvdW50ID0gMDsNCj4gPiArCWludCBjb3VudCA9IDAsIGNvcGllZCA9IDA7
DQo+IA0KPiBXaHkgaXMgaXQgbmVjZXNzYXJ5IHRvIGluaXRpYWxpemUgY29waWVkPw0KPiANCj4g
QWN0dWFsbHkgbmVpdGhlciBjb3VudCBuZWVkcyB0byBiZSBpbml0aWFsaXplZCBBRkFJQ1QuIENh
cmUgdG8gZml4IHRoYXQgdG9vIChpbiBhDQo+IHNlcGFyYXRlIHBhdGNoKS4NCj4gDQpZb3UgYXJl
IHJpZ2h0LCBhY3R1YWxseSBoZXJlIHRoZSBpbml0aWFsaXphdGlvbiBmb3IgY29waWVkIGlzIG5v
dCBuZWNlc3NhcnkuIEkgd2lsbCByZW1vdmUgaXQgaW4gVjMuDQpGb3IgdGhlIGluaXRpYWxpemF0
aW9uIGZvciBjb3VudCwgSSBjYW4gc2VuZCBhbm90aGVyIHBhdGNoIHRvIHJlbW92ZSBpdC4NCg0K
QmVzdCByZWdhcmRzDQpTaGVycnkNCg==
