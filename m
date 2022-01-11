Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE65848AD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiAKLyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:54:04 -0500
Received: from mail-vi1eur05on2064.outbound.protection.outlook.com ([40.107.21.64]:44097
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239003AbiAKLyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:54:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPnxiU9lkvr5p+iV+tEB6YChh8WsFxTzt9K4p7RlobL+hurhECc7muqGbC6Tq4htimWiUaKdAinVG0mshlQDYO/0O4Sk6rnXr1lNi0T+WiEy8OdG2pDTyh3ihXKPNSz3u3p5X1xu7EHYq4m9L9PxBKQ802K8Lq6HXo335CpzhoWEViVgYEGr3hmli0Y9JCG67MwR+Yi4d1pux4qNcWz/BrYtyeyW44+rGnIZYjBP0yFcyyKwZ+vgsHTYmZrlwU1BEgb0fxI14qlD1LMtkxi3wLCWvGpOrE1Rd36lRhh+iS2ztDGpKfFuogSQDzO/FcV6u0p8GWiBwAtlULDqrK49iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE454cWD3iKJsZgcs/uPvO+mT3LRVp/PNBaRSdYzDSQ=;
 b=ThpfW/zE91HC3AxtwEVvXdRbIjSPlqIQga5wPHp68Cj+yzlXbQXm3hVJ0swFVERsdgWTn9gbEzPNv5LtnMZEXjGhLjRHtt760Khyr+yqD+3Z/TJsm3UYpNgLTlkubHF5/526LGQw29Hxu4Bl+QT8lAGxlFJToeRgqRU3sANjDVcer1ZIzTcqtU6aS13//wSSkHxrE9c8pA1lG7TEEFiQ6BJRtOdO7a5KP1NQnBDoGZm/vXuP3Lzd1JAYhKA8TDwvX7GSlPkjkpzQELzFkDqNeTJZAvNRhrSvZLNPLny7Z+S0+JKcJ1nnjk0mEvCtx7u7xxPtaDyVTWr0BY+yKr33Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE454cWD3iKJsZgcs/uPvO+mT3LRVp/PNBaRSdYzDSQ=;
 b=GeBIhzlGBOvKw2Bh+ndIvqNZ53w+dWcqW5Xo8qqnH21JdcTt34/q5oHjfOLWdZb4hC5o1SzHWOXvYlE1aCzXiTT6KERkrXuGhwM1ybDMD6DI/pifJpNmIVm2QL5cmb+uqQSzEg5+OEjMBDMEDdmkvkwtZlWKCdJv6ADzR4f9roxQQ/qNEr45CGNGnDZOHHxVU7AUCwuR7LALzjq7YwbTx1V7+DsTsCWOkzm5WH3/cMngxoAyzmqiYN3hKrVYaIb2z7YejOFrv2YcO8jVMWc+bQL1HEe8aP8+vVeMB/L34ywetyla57j+QcmT1AwJTbZD554AbgjdEGijAzqQLv1r9A==
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:200:98::12) by AM8PR10MB4641.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:315::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 11:54:01 +0000
Received: from AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51a5:c110:9da1:c824]) by AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51a5:c110:9da1:c824%10]) with mapi id 15.20.4867.012; Tue, 11 Jan
 2022 11:54:01 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] tty: n_gsm: Fix SW flow control encoding/handling
Thread-Topic: [PATCH 1/1] tty: n_gsm: Fix SW flow control encoding/handling
Thread-Index: AdgG4Y/k/H3PWF3gSBi1uYuhjqk8kg==
Date:   Tue, 11 Jan 2022 11:54:01 +0000
Message-ID: <AM4PR1001MB137808D63F6C99698FA02DFFE0519@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-01-11T11:53:59Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=d9483d67-b427-4600-950c-92adec72aaca;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cda8ed0-41c8-4c06-0bf1-08d9d4f90f18
x-ms-traffictypediagnostic: AM8PR10MB4641:EE_
x-microsoft-antispam-prvs: <AM8PR10MB46413C67A26A2F57EB75A112E0519@AM8PR10MB4641.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nnVPCmVe+hpcPTcUDYUoX6Nh6aQvNjkFt/Od3TrlpY/AVOmVchl7lU92S1djueJsqqLywav6cUEjMhsB0869tjdzI86T7wHTYO66MMMqGgulml9RkXm0vFIAGlqvCG1ezdf091CbN5H95lX1Aa0dzRn5ciddvo5lMM4NrIPLy83vnrb4i/mtE9ADsOQMAkVaVu7IVFhapNVbbTv1qN0p4BUxDHou0JqaaWjKfrZhS1G4QhajAlgulKs8XtPDh9YF+qHGSY6yJ6qM031eZd2JEbFzQQi6kvlnrOFoG/OMaBEjEmeB/Ql+NWdoZ29nJRHWxNntAtqB0DUnuUdnlpo253u513XT7KD6pp60/OTmLMD6VwZiwt97p9dsNUzuPIBfUkAq12LMdmHcNxlyf0wVVEimBkDmbqCsMGWgfQK68YvLxjuOa1apalKjj9kJersE5o4t1wW2sTOmLLy2rjp/PjJKy1xyckGHpMsG4gQyBfy1XAup8ZDawtGBxKGDeiUc7pJ+YhoRIyj9Cj/usXH11PSB63QKB498fGbHV7GfOpbIlx/jdIo6InrJOQeoACp6d3ae5UXsLgxrBy6U6h2AMezKyRaznjBC8VLcD4+37AS6Tz0HTFxEh8WvylskTKfdva5BBnvYrMyg78SuEV4aAqx8miamLXIl3bJQSMdSgSXlhHPx/5cwUFGsWK7TFGfbo3tuQNdpby79MiXhdoPaAJFaEe2C8Fgx6zADeS4pQgHSssITXoZwmlx0NLomsuV9UzvXFwQyCIwwy1+dwsS/rVIkEp0OlVFBE9+Fhcb8N80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(54906003)(7696005)(66476007)(52536014)(6916009)(508600001)(5660300002)(66556008)(316002)(66446008)(64756008)(38070700005)(86362001)(4326008)(76116006)(38100700002)(71200400001)(8936002)(966005)(26005)(122000001)(8676002)(33656002)(55016003)(66946007)(83380400001)(9686003)(82960400001)(6506007)(186003)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2hYRHdQV3B4a0pNZkZjaTlJcXFKUzhGUW1OSzEwQ3Jybkk3Ry9ZWDFPRnk1?=
 =?utf-8?B?UGI4SWcyajNQVmxpbUhQdytjcEN0UGFacTFHNngxQnJpVDRhc2ZWRkkyOTcz?=
 =?utf-8?B?a21XbDRka05taStZT2c0dm1JaWZRVjcwbHk4UWdDd3VYUUVBbmF1RnEvZDBl?=
 =?utf-8?B?eVgxOERybVRFTHZmSEcxZWttSWhzb004OURNWDN6MG5tSEk1dndwV05wRDlC?=
 =?utf-8?B?bHFpVytaaGhmQXMrQU5IZlI4M0h0UW83dFBSRzlZaWhUR0xmZFlzWkZZaDdH?=
 =?utf-8?B?RTFkcFhPcTM5TGNMcGZPdmRaKzZqMnBSQVVOa0NLMElMZThSc2ZnODRwR255?=
 =?utf-8?B?L0g1dTYxMDNWS2g0M0ROVWVuQUo3N1B0bnVDZjZ0Y0dOaCtOcytKTjUxSHRS?=
 =?utf-8?B?NWpSWXpDWWVUZThnQ2I5QUppYTh2R3FhWHNZa3Y0TFZab2cwSk9Xb016akV6?=
 =?utf-8?B?N3ZRQVRYQW84a0IxdWZ0QU5McS81NEpqTTVZVmJwQ1gxOUdLcHdoQzhVNnFY?=
 =?utf-8?B?Nko5a09lajlKcjR6em9VS09yZ3h4aWlJd2hpNllFVGtFWVpVMjd0TjBJR21R?=
 =?utf-8?B?K3N1VTJ0Zkthc1YrQ0paeTR3SEVBUnR1Ymp2UHQxcVg4cHFxNE10S2t1b2Zt?=
 =?utf-8?B?S3dqVDhDOWhSeEJ0VmVSZ2FiWldYVmdjSE1qY1EyWFFEUEdmb1diVUNJM3lN?=
 =?utf-8?B?eWZod2R3eVZrd21FOHBqRWxBRUNwOFc4bjN3Z0R5OEJPWHhHK3pDY3JzUTc3?=
 =?utf-8?B?SkNLK21mVnQrS3BHSnJWWklHU2xZbFZwQXNWcXoxUFVtL1R5dkdUTUx5TmxH?=
 =?utf-8?B?TTdLYXdtaHY2dEJ6eUFwRzFBcisrdUJEbkRpOVFBc2lHTStjMXRWWFZzay9Q?=
 =?utf-8?B?OGNjdlh4S3pEYWh6cEhhdHNtQ3ZKUXQ4OWtNN1d4djlwdm1GVXFwUjNZbFhp?=
 =?utf-8?B?dTdCYXZrZDdrRmhINmkzV0JNSis5aHlZMkZOWCsvMk1YcDdMYi9PcWpSSFkr?=
 =?utf-8?B?N0xTbzZPV0FzcTdXa0p2OTY4blpTZVMxeG5tZEpmTVpKcEdRQVJsalNwZGlN?=
 =?utf-8?B?SnhOalo5a0JnUW1TZUNrUjBPSmRjbHdEOE9xMW81TXZCdHhwRjhqcE8yWDlX?=
 =?utf-8?B?WnVCUG9lNnpjZUJVcWtFUHR0M0lBTW4wZTdyTVh3SkNoYlZCNlBuNUJUai9U?=
 =?utf-8?B?K2N4aFpGekd2eUg4ckRyZC9pdVVPK0lmelowZUhhUDJhT2d4QUlFUE1vRzA2?=
 =?utf-8?B?N0x5UGJLWG5TTmlFeHM3WDFlV25mKzliZklKOGFnem1RTEJqR1BWYklqYURw?=
 =?utf-8?B?UjdQTEpURnhudk5MTEQ5SkVueUFNcEFnVERXVXk1a2ljN2VPSEdGVlA0Ukd4?=
 =?utf-8?B?YWljajg3VmZ4dTQ4cHBZUEJKZm1SQi96anFMVzFnTThacVM1Ly9sV3FseXJR?=
 =?utf-8?B?bWxBbjZQdURUNmF5ejlqL21mZU1UVC9PWlRPTjV0L3ZYREZucEtKZEN4MEp1?=
 =?utf-8?B?MUNEb1VWRm1xamZ4Mkp0RlNmZXFHWFhkN214bkZxelBwRHIvZmdSYkVXaUN1?=
 =?utf-8?B?d2VBL20wZWlBSnVEQ01ob3dPeSthOExmd0c2djl3ZHFVQXpXMGl4Uis1QVdH?=
 =?utf-8?B?OWl4Ukh5TnRGWE8ySk45ZDArR0J2bjJjSGt5Smx1TmM5K0VxSkJVczlmMnJK?=
 =?utf-8?B?a05DT0tjREt3THdSZENPRVpnK2JiY3ZvNExQclVFTTJNT1NZR0IwUkpra041?=
 =?utf-8?B?RFZGVnFHWXB4NkFqZTFuaDAwVUp4MGQ2dC92VFdUN0UwNWtoMHNkSEkvK3Uy?=
 =?utf-8?B?MWo5M2IzV0xHc1BuZmxwemgvY2crU29vN2xGSVFiTUNnRlZ1UVlFa2gvY3VF?=
 =?utf-8?B?WUx5YW9hTFpWRXVzV2ZPNWlMMG93NlMyYmRxWThtZDluZFhwaFhXN3pQQm9k?=
 =?utf-8?B?Umpjc1paWXhWa3RpbHFrNEg5eE54Y0JIdTJ6M3lyTUxHNWN3N1RESU5nblhk?=
 =?utf-8?B?RkF1em94bjFXbHJYeTl3U09aRkMvSjJJazVCYjZjdEhkNGlJN2RWdGozaElT?=
 =?utf-8?B?U3FVWkp2bStwTjhwNWNCNnN4bFhqZXRQcjZ0bUdEUnpEL3VyaGFDYm01RU52?=
 =?utf-8?B?eElYN0ZtNEQxQ2F5YmgrK0tuOE0ycDZKVkIrblNxNndEWkNqSGdJUFpCTmc4?=
 =?utf-8?B?eW13ZW80WG8ycEkreGhwT3dNL2ltd3J4RlVTT0VMVkVXakdrVDVVRVoxYVFC?=
 =?utf-8?B?czNzb2VoazNLaFJPb3orWUJjOXNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cda8ed0-41c8-4c06-0bf1-08d9d4f90f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 11:54:01.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAfZPX1Zouw5VCQQ5k0o7UVDyrXm2F62HUYpJlBEhY54V3oh4OQWcH+Z+VrcAXGTSTIYIXq4yPy4e6tZ4K9B9dXpcFM/w5dTjml2LC8kZKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4641
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEFjY29yZGluZyB0byAzR1BQIDI3LjAxMCBjaGFwdGVyIDUuMi43LjMgREMxIGFuZCBEQzMg
KFNXIGZsb3cgY29udHJvbCkNCj4gDQo+IFdoYXQgaXMgYWxsIG9mIHRoYXQ/ICBEbyB5b3UgaGF2
ZSBhIGxpbmsgdG8gdGhlIGRvY3VtZW50IHRoYXQgdGhpcyBpcyBhbmQgd2hlcmUgaXQgc2F5cyB0
aGlzPw0KDQpuX2dzbSBpcyBiYXNlZCBvbiB0aGUgM0dQUCAwNy4wMTAgYW5kIGl0cyBuZXdlciB2
ZXJzaW9uIGlzIHRoZSAzR1BQIDI3LjAxMC4NClNlZSBodHRwczovL3BvcnRhbC4zZ3BwLm9yZy9k
ZXNrdG9wbW9kdWxlcy9TcGVjaWZpY2F0aW9ucy9TcGVjaWZpY2F0aW9uRGV0YWlscy5hc3B4P3Nw
ZWNpZmljYXRpb25JZD0xNTE2DQpUaGUgY2hhbmdlcyBmcm9tIDA3LjAxMCB0byAyNy4wMTAgYXJl
IG5vbi1mdW5jdGlvbmFsLiBUaGVyZWZvcmUsIEkgcmVmZXIgdG8NCnRoZSBuZXdlciAyNy4wMTAg
aGVyZS4gQ2hhcHRlciA1LjIuNy4zIHN0YXRlcyB0aGF0IERDMSBhbmQgREMzIGRhdGEgYnl0ZXMN
CnNoYWxsIGJlIHF1b3RlZCB0byBlbnN1cmUgdHJhbnNwYXJlbnQgdHJhbnNtaXNzaW9uIG9mIHRo
ZXNlIGJ5dGVzIHdpdGhvdXQNCnNldHRpbmcgc29mdHdhcmUgZmxvdyBjb250cm9sLiBUaGlzIGlz
IHBhcnRseSBhbHJlYWR5IHRoZSBjYXNlIGluIHRoZQ0KY3VycmVudCBuX2dzbSBpbXBsZW1lbnRh
dGlvbi4gVGhpcyBjaGFwdGVyIHJlZmVycyBhbHNvIHRvIElTTy9JRUMgNjQ2DQpyZWdhcmRpbmcg
dGhlIGVuY29kaW5nIG9mIERDMSBhbmQgREMzLg0KDQo+ID4gYXJlIHRvDQo+ID4gYmUgdHJlYXRl
ZCBhY2NvcmRpbmcgdG8gSVNPL0lFQyA2NDYuDQo+IA0KPiBXaGF0IGlzICJJU08vSUVDIDY0NiI/
DQoNCklTTy9JRUMgNjQ2IHJlZmVycyB0byB0aGUgc2V0IG9mIElTTyBzdGFuZGFyZHMgZGVzY3Jp
YmVkIGFzIHRoZSBJU08gNy1iaXQNCmNvZGVkIGNoYXJhY3RlciBzZXQgZm9yIGluZm9ybWF0aW9u
IGludGVyY2hhbmdlLiBJdHMgZmluYWwgdmVyc2lvbiBpcyBhbHNvDQprbm93biBhcyBJVFUgVC41
MC4gU2VlIGh0dHBzOi8vd3d3Lml0dS5pbnQvcmVjL1QtUkVDLVQuNTAtMTk5MjA5LUkvZW4NCg0K
PiA+IFRoYXQgbWVhbnMgdGhlIE1TQiBzaGFsbCBiZSBpZ25vcmVkLg0KPiANCj4gIk1TQiI/ICBQ
bGVhc2Ugc3BlbGwgaXQgb3V0LCB5b3UgaGF2ZSBwbGVudHkgb2Ygcm9vbSBoZXJlLg0KDQpNU0Ig
c3RhbmRzIGZvciAibW9zdCBzaWduaWZpY2FudCBiaXQiIGluIHRoaXMgY29udGV4dC4NCg0KPiA+
IFRoaXMgcGF0Y2ggYXBwbGllcyB0aGUgbmVlZGVkIGNoYW5nZXMgdG8gaGFuZGxlIHRoaXMgY29y
cmVjdGx5Lg0KPiANCj4gV2hhdCBjaGFuZ2VzIGFyZSBuZWVkZWQ/ICBQbGVhc2UgdGFsayBhYm91
dCB3aGF0IHlvdSBhcmUgZG9pbmcsIGFzIHRoZSBkb2N1bWVudGF0aW9uIGFza3MgeW91IHRvIHNv
IGRvLg0KDQpUbyBhYmlkZSB0aGUgc3RhbmRhcmQgaXQgaXMgbmVlZGVkIHRvIHF1b3RlIERDMSBh
bmQgREMzIGNvcnJlY3RseSBpZiB0aGVzZQ0KYXJlIHNlZW4gYXMgZGF0YSBieXRlcyBhbmQgbm90
IGFzIGNvbnRyb2wgY2hhcmFjdGVycy4gVGhlIGN1cnJlbnQgY29kZQ0KYWxyZWFkeSB0cmllcyB0
byBlbmZvcmNlcyB0aGlzIGJ1dCBmYWlscyB0byBjYXRjaCBhbGwgZGVmaW5lZCBjYXNlcy4NCjNH
UFAgMjcuMDEwIGNoYXB0ZXIgNS4yLjcuMyBjbGVhcmx5IHN0YXRlcyB0aGF0IHRoZSBtb3N0IHNp
Z25pZmljYW50IGJpdA0Kc2hhbGwgYmUgaWdub3JlZCBmb3IgREMxIGFuZCBEQzMgaGFuZGxpbmcu
IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uDQpoYW5kbGVzIG9ubHkgdGhlIGNhc2Ugd2l0aCB0
aGUgbW9zdCBzaWduaWZpY2FudCBiaXQgd2FzIHNldCAwLiBDYXNlcyBpbg0Kd2hpY2ggREMxIGFu
ZCBEQzMgaGF2ZSB0aGUgbW9zdCBzaWduaWZpY2FudCBiaXQgc2V0IDEgYXJlIGxlZnQgdW5oYW5k
bGVkLg0KVGhpcyBwYXRjaCBmaXhlcyB0aGlzIGJ5IG1hc2tpbmcgdGhlIGRhdGEgYnl0ZXMgd2l0
aCBBU0NJSV9NQVNLIChvbmx5IHRoZQ0KNyBsZWFzdCBzaWduaWZpY2FudCBiaXRzIHNldCAxKSBi
ZWZvcmUgY29tcGFyaW5nIHRoZW0gd2l0aCBYT04gKGEuay5hLiBEQzEpDQphbmQgWE9GRiAoYS5r
LmEuIERDMykuDQoNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgU3RhcmtlIDxkYW5p
ZWwuc3RhcmtlQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9uX2dzbS5j
IHwgNiArKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvbl9nc20uYyBiL2Ry
aXZlcnMvdHR5L25fZ3NtLmMgaW5kZXggDQo+ID4gMGI5NmIxNGJiZmUxLi45ZWUwNjQzZmM5ZTIg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90dHkvbl9nc20uYw0KPiA+ICsrKyBiL2RyaXZlcnMv
dHR5L25fZ3NtLmMNCj4gPiBAQCAtMzIyLDYgKzMyMiw3IEBAIHN0YXRpYyBpbnQgYWRkcl9jbnQ7
DQo+ID4gICNkZWZpbmUgR1NNMV9FU0NBUEVfQklUUwkweDIwDQo+ID4gICNkZWZpbmUgWE9OCQkJ
MHgxMQ0KPiA+ICAjZGVmaW5lIFhPRkYJCQkweDEzDQo+ID4gKyNkZWZpbmUgQVNDSUlfTUFTSwkJ
MHg3Rg0KPiANCj4gV2hlcmUgZGlkICJBU0NJSSIgY29tZSBmcm9tPyAgWW91IGRpZG4ndCBzYXkg
YW55dGhpbmcgYWJvdXQgdGhhdCBpbiB0aGUgY2hhbmdlbG9nLg0KDQpUaGUgb3JpZ2luYWwgdmVy
c2lvbiAoSVNPIDY0NiBJUlYpIGRpZmZlcmVkIGZyb20gQVNDSUkgb25seSBpbiB0aGUgY29kZQ0K
cG9pbnQgZm9yIHRoZSBjdXJyZW5jeSBzeW1ib2wuIFRoZXJlZm9yZSwgSSB1c2VkIEFTQ0lJX01B
U0sgaGVyZSB0byBkZWZpbmUNCnRoZSBtYXNrIGZvciB0aGUgc2lnbmlmaWNhbnQgYml0cy4gSSBi
ZWxpZXZlIHRoYXQgdGhpcyBpcyBlYXNpZXIgdG8NCnVuZGVyc3RhbmQgdGhhbiBJU09fSUVDXzY0
Nl9NQVNLIGZvciBleGFtcGxlLg0KDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdHR5X3BvcnRf
b3BlcmF0aW9ucyBnc21fcG9ydF9vcHM7DQo+ID4gIA0KPiA+IEBAIC01MjEsNyArNTIyLDcgQEAg
c3RhdGljIHZvaWQgZ3NtX3ByaW50X3BhY2tldChjb25zdCBjaGFyICpoZHIsIGludCBhZGRyLCBp
bnQgY3IsDQo+ID4gICAqCUBvdXRwdXQ6IG91dHB1dCBidWZmZXINCj4gPiAgICoJQGxlbjogbGVu
Z3RoIG9mIGlucHV0DQo+ID4gICAqDQo+ID4gLSAqCUV4cGFuZCBhIGJ1ZmZlciBieSBieXRlc3R1
ZmZpbmcgaXQuIFRoZSB3b3JzdCBjYXNlIHNpemUgY2hhbmdlDQo+ID4gKyAqCUV4cGFuZCBhIGJ1
ZmZlciBieSBieXRlIHN0dWZmaW5nIGl0LiBUaGUgd29yc3QgY2FzZSBzaXplIGNoYW5nZQ0KPiAN
Cj4gVGhpcyBjaGFuZ2UgaXMgbm90IGRlc2NyaWJlZCBhYm92ZSwgYW5kIGlzIHRvdGFsbHkgZGlm
ZmVyZW50IGFuZCBiZWxvbmdzIGluIGEgZGlmZmVyZW50IGNoYW5nZS4NCg0KWW91IGFyZSBhYnNv
bHV0ZWx5IHJpZ2h0LiBTaGFsbCBJIGNyZWF0ZSBhIG5ldyBwYXRjaD8NCg0KPiA+ICAgKglpcyBk
b3VibGluZyBhbmQgdGhlIGNhbGxlciBpcyByZXNwb25zaWJsZSBmb3IgaGFuZGluZyBvdXQNCj4g
PiAgICoJc3VpdGFibGUgc2l6ZWQgYnVmZmVycy4NCj4gPiAgICovDQo+ID4gQEAgLTUzMSw3ICs1
MzIsOCBAQCBzdGF0aWMgaW50IGdzbV9zdHVmZl9mcmFtZShjb25zdCB1OCAqaW5wdXQsIHU4ICpv
dXRwdXQsIGludCBsZW4pDQo+ID4gIAlpbnQgb2xlbiA9IDA7DQo+ID4gIAl3aGlsZSAobGVuLS0p
IHsNCj4gPiAgCQlpZiAoKmlucHV0ID09IEdTTTFfU09GIHx8ICppbnB1dCA9PSBHU00xX0VTQ0FQ
RQ0KPiA+IC0JCSAgICB8fCAqaW5wdXQgPT0gWE9OIHx8ICppbnB1dCA9PSBYT0ZGKSB7DQo+ID4g
KwkJICAgIHx8ICgqaW5wdXQgJiBBU0NJSV9NQVNLKSA9PSBYT04NCj4gPiArCQkgICAgfHwgKCpp
bnB1dCAmIEFTQ0lJX01BU0spID09IFhPRkYpIHsNCj4gPiAgCQkJKm91dHB1dCsrID0gR1NNMV9F
U0NBUEU7DQo+ID4gIAkJCSpvdXRwdXQrKyA9ICppbnB1dCsrIF4gR1NNMV9FU0NBUEVfQklUUzsN
Cj4gPiAgCQkJb2xlbisrOw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4gDQo+IA0KPiBXaGF0IGNv
bW1pdCBkb2VzIHRoaXMgZml4Pw0KDQpJdCBmaXhlcyB0aGUgaW5pdGlhbCBjb21taXQgZm9yIHRo
ZSBuX2dzbToNCkNvbW1pdCBlMWVhZWE0NmJiNDAgKHR0eTogbl9nc20gbGluZSBkaXNjaXBsaW5l
LCAyMDEwLTAzLTI2KQ0KSG93ZXZlciwgdGhpcyBwYXRjaCBpcyBiYXNlZCBvbiB0aGUgbWFpbiBi
cmFuY2ggZnJvbSB0aGUgVFRZL1NlcmlhbCBkcml2ZXINCmRldmVsb3BtZW50IHRyZWUuDQoNCldp
dGggYmVzdCByZWdhcmRzLA0KRGFuaWVsIFN0YXJrZQ0K
