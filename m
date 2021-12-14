Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F1D474194
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhLNLiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:38:21 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:28567
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231282AbhLNLiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:38:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIUkyxs6DS1rMjNGV2RX8g/NO0+ejgKxTOApsT20YO50takU/hs9kOqsju/yEar2w/qBQvb+vfC05ICfATwzOOvR6Eh+EQlbX0k0YUZEDGc2JbnbHr7Iyx6xxGJ5G3xURpB1mKSODBaFRXd7qFwbsY/DsHonyV1c+gSPRV7LdwSPozrY5HQ91PKvmpdnGQNk36t/J8UjIMo/22XyiOqHYBMFrAVscT/KD5YRc/1z/DxsiYCKonksiqyABwfzgFCXceqVZu+bvUXVnECjYNp7wRfDNQKpJbUGo5IQitAzqVp8pV0i4z8INemitK6Lt9is/wH0W/0WHJYiMr/jrdYhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pkF2FEpV2w4SK1vUfLP3Y+iXYvoAuPWbx0eF8/EY/8=;
 b=DCSAKrliOchMuqAcKKyBUseOT/joTr5F6pWOYIzZQ5RLrBza9AzpH+j3+94P/h/XK3fEYkF83hJpCWTelibCJPQXnfMDZ9hxubcbVCqyAaCX7HmDx9yZLut9Vh7zXPCKxQSve+QlCMUE05mtAXH4nt8rwbZnppIHkAa7ROQ+VEujh2jLihYXlRG40bgUR4FPaWeTfZv8UyQf99Zf+PVyLBPHuhkeA4XnajJLbGXgUymmepiMLPOthbhfH25LBMmhPt1t1HGn3XlqpiKVwhaTZyFRSSd47zlqiuCQSlxjusWFgAwNifW0GKw024H+3Y1As0GME30H+QAVWXO8/6toUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pkF2FEpV2w4SK1vUfLP3Y+iXYvoAuPWbx0eF8/EY/8=;
 b=Vi+rBuyT1Af3BUA+ovrfPIgmCTxggh4IQhb+v34HPU+1oGRoUab9/lpLjFHDTRbKl4AS6DC7kaYxrAaKZxYj/yvioonJDGC5N0fayhfmbLDbjC+9LormCAHnfsM031GphZ30eqwImkKdtf5fty/5DCNGprDqqKTAlTXrh3YUKy2cPBVZA+Qw9PGf7aZOPm+JhwC7OzCSNsJ+16o1uXEr1S5NYFTAX61rIw3/JccwwBQFONcAn+ROG8jwgRuKSVIVEUdWVQTYSHh6eEErMvOpmMGa3VUXv+N+4ZIUt7hZ3YXa1c9vNWATalAPOu8leiEbRXGtpyu9PRIEOcyhqNSiVw==
Received: from DM5PR12MB2406.namprd12.prod.outlook.com (2603:10b6:4:b7::23) by
 DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Tue, 14 Dec 2021 11:38:17 +0000
Received: from DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::4170:bcdf:1cd3:9a5d]) by DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::4170:bcdf:1cd3:9a5d%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 11:38:17 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>
Subject: RE: [PATCH v3] mmc: sdhci-tegra: Fix switch to HS400ES mode
Thread-Topic: [PATCH v3] mmc: sdhci-tegra: Fix switch to HS400ES mode
Thread-Index: AQHX6qpj1qJAzk4nfkSiqEJ0t6qgK6wxircAgABTAPA=
Date:   Tue, 14 Dec 2021 11:38:17 +0000
Message-ID: <DM5PR12MB2406640012E5B70A17B5F6D0B7759@DM5PR12MB2406.namprd12.prod.outlook.com>
References: <bf629e1b-c61d-37e7-8802-b6d778f89c21@intel.com>
 <20211206140541.17148-1-pshete@nvidia.com>
 <3dd2473a-00ca-4c62-e17f-9392cf74cda4@intel.com>
In-Reply-To: <3dd2473a-00ca-4c62-e17f-9392cf74cda4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7815f685-fab7-40ff-4092-08d9bef63906
x-ms-traffictypediagnostic: DM6PR12MB4861:EE_
x-microsoft-antispam-prvs: <DM6PR12MB48612863D127A1BCF6EBB927B7759@DM6PR12MB4861.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hXR/dnA5uFSm/MzyHR2yamlDgUyXGGOc5VUfS52D5exxlaROWNfXGDtOIhephEwktG0qkjyikA+1F2PxJE5e0+G56EfVf55OKR5Vut2FY/fTbH320OPSZQ3IpJWnyuDK/VhdoiAGU7AWTzAKRKP0+p7ZvMy/7cWC+GgpllsQ/twNKxOPAvhrIg7UKzN87t6Y51cLsixyRPYh6B1h0Yb9sxOoNuEdHxqCZ+0cjPUOsY2p/Fna2huqYClI3yCUC90V2UCJxkvW2nYTuAxm56GMZzaCUFKiO83Mc02F4pLw73adHSwmG0XQkVS1Qu+KI6ImVfenjgPcvUYJERKiFJJzWjd8R0voxAP7XdJPXEzAp4rgsMTlHlxQfaIAbIn/YXr9Rqite3LIq9XBB6SBzMJG3y0SsrFskYLT3qQ2OITzd5jhfMHq0N4qc+jBxtjfGhpkSW68piHYG1q1cVg4CK81R2BwLUTGPR5pYUSHZ+YLbjoIdGJ+Sv1Z6Nnu7RdcHnvFlpCqveHZBBzTFXzECwpYmP4mOKa7fOEYVRE1xvoeijTg+LHe0820XWSxRjsxVIr6JUiwpj6VDmtTjeSoZXKg7WGuG6QENeCEPilSk1KV48ZFDht70icogISb6yhzsbO6B6xfLA3lTmHxh60LnVfx4yl1c089i/W8srnoZSvuK10M2Z/BMUNqeN52h21XyOwo78dSO68elgvLG2+q9lm3sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2406.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(55016003)(5660300002)(66946007)(8676002)(66476007)(66556008)(64756008)(66446008)(38100700002)(122000001)(107886003)(8936002)(83380400001)(38070700005)(9686003)(71200400001)(26005)(508600001)(186003)(53546011)(6506007)(7696005)(52536014)(316002)(110136005)(76116006)(33656002)(86362001)(2906002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUwxTStqR3p6WnQvMWMrT245TGllRTZBb1UrSWgrR3dJV1NsMjFlNlNMdHBw?=
 =?utf-8?B?Q3VFa1M1VWRiOWo1R3B5UlR6U2h3WkZERVlVM0tWMEJZNnRUcjdQdDJLMWlm?=
 =?utf-8?B?MkZoVDhoYjNvdjZNanExMG15bi9tTC9WY3pHQUZrYVd0M0RFWitZRm92U1Bx?=
 =?utf-8?B?ZVlXVUphVTZrOXZtM08vT2V2WEhkV2JTbDduNmZzY0kvQ3Y0ejBTaEdYdDMr?=
 =?utf-8?B?a1dueTRMenQ2eWdkT0JmMitXdE5RVGh6NjFoSjViSG1rbjRrWFYwS0k3THd1?=
 =?utf-8?B?SEV6M2FPUkozNm1mMDRuTG12dk96YkhHQWwxYndLYnZmV01hZ3U5eXQ3Z2JY?=
 =?utf-8?B?Y3h2SGFGcHNRQmIzSzV1ZHVpL2VyMmdlSUF1WDZlcHdrMjNaZVAyeXFsQ0Ex?=
 =?utf-8?B?NUZ4a2psdllwQW41SEJRenhFMHMwQWhvRHMxdTdOMjBTWW9OUjNkSHJoRm40?=
 =?utf-8?B?NVVlVC9mZW9LN0pTWmR1RWY2NWpVU2Y0aEkwVEp4ZzM3bERyQ3ZXQUJuL0Rq?=
 =?utf-8?B?ZDE3VGxoRzFJbVJ2WDV0bkJjNE9uSHNISXJZUlNlMFdtQSs0eHJQTEphaTRx?=
 =?utf-8?B?Y2xoczlNNk14cXlETStKajNOZjhrSzhJU3YxVGE0UjJNQnZVNVpZVUJWYW5Q?=
 =?utf-8?B?TlJvanZLb1hCQnpaMHBqQlFqODBNWjNpQVZnWGJwenVUWHdhTmxpTUlqeUFy?=
 =?utf-8?B?T2VLc05xVThZLzZJNWNkMXVENmRGelJobFNVVVBodVdpdU9KN3RmTGlnTjFK?=
 =?utf-8?B?clRwTGRIazNlREhGYTNlOXM1MmNNSWswUkpFUjZxWjl6MnZNcUJvR3VzeGU4?=
 =?utf-8?B?b1NMcXpQR2VUSUVqbXVMUG8vQnBpVHVreEdBWk1Jc1Z5eGk1VGl1cE51ajk3?=
 =?utf-8?B?RDAwcnVWR0tHUmtudkRlZU9sazlUaFJEWDVoWGtRMHN6OHczM0pydUpEMWh5?=
 =?utf-8?B?a2ZhZ0dEUmJ3amo4SmxIT3dkZGZ6NEN2cGdMMVhGeHBCLzVlODkvZmRvTVN2?=
 =?utf-8?B?VnV3a3FGcDlGa3YzbzErQ25RcDlmdWdwL1dmNVZ3VnlxR3VkR0N2TzBuOFRW?=
 =?utf-8?B?TklBUEVvWGZjbHlqU25WamRsOVJpT1c0eE1aaW00ZFVKTGhGQ2JYMHpyZ0Zl?=
 =?utf-8?B?eXQ5SFV0N2FUcEFLcnBoZHVwSkozcXdUdTMxdGlEY3FpSytva3E4M2FkU3Ux?=
 =?utf-8?B?b1lrcWxPdWYvOW93Sm5SMWNCdjBHeGJvV0dFak9aY08vWkJtTTNYT3FWNkha?=
 =?utf-8?B?dGpuSGhXSC9mL25FM1BtR1FVNFAycVUwYk10Y0YrNm1LdTdVR2ltYnV2K1dD?=
 =?utf-8?B?bUMwS3J6S1c5Nnp2d3NJaFJpQm9rRHhUdXBlSnYzTFM1R1ZpMExhTWV0UFgz?=
 =?utf-8?B?cDJuanE5Ync3SlBrV1QraUpBZURENHBaWS9WTDRoTjZmYmpacXA2MVg2Ymty?=
 =?utf-8?B?enNSMTdBeUlYTWltMnRIMk9XUXRIWGZqS25qYmNhM0N4WkpCWGtkZjRCL0FC?=
 =?utf-8?B?ME5tNVVBWndsNWIxUm95dENUZTdNcHdrdldoenlINUZ6WjMxN2htdFhSM3Ri?=
 =?utf-8?B?MjdTTk0wSHdrMVRjOFlJdWlxamlFTHdJOHJ4aHZ4dXo0Z1ZUUFJORlZpOFU0?=
 =?utf-8?B?MjN5MXArWjFDZFV4blk4R0ZORHByVERNK3k0cTBlUUt2ckZaOStOa1psZkNF?=
 =?utf-8?B?U3BCWEhFZnZETzdrNjJUVlVBOFp0OTFxamFzU1pTbmNnczd1V1V6RkdyU1dU?=
 =?utf-8?B?Q1JxdTlORFZuR2N0REI1dktqRGR0K3puOTNqSDQ3aHIzZ2wzYU9EM3ZMVDhs?=
 =?utf-8?B?OU43OThTODJlRnZCMEhLa212dDNlUHRJc29nUXFaREJmTHZnUWdxQTRzNzZH?=
 =?utf-8?B?ZjZaVE8zb2tRa09uUE0vMlNlTjZseDZGSU9JQmNZaHdnWWxtYzZEVllNMEdn?=
 =?utf-8?B?OVhrWVkzYlN2eWRKTk9JNkhJSGFTcDZXZDJydkMxZFFvN1ViQ2IxOEd0SEps?=
 =?utf-8?B?RTJRWWg2UEY0T2I1bU85ZVlTcWR5WXFmREUwL2dmK0JLYUdlOG1jZm1jNlVX?=
 =?utf-8?B?dkxaQVNQZ2VTdHNlT3J5L1lrYk9YZ0ZIK2ZId0tDNmpGTnRYNGdmL3Z4OGg2?=
 =?utf-8?B?YWk4Wlc0K21QcFgzUG5EUTVZS1c3cnhEVlVtc3c2V05RMEhCZU11MTFqTzda?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7815f685-fab7-40ff-4092-08d9bef63906
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 11:38:17.6797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcP+LRpRcNVcugaY6JMh9Ts6j3OyK3qVr318c8ybo9t2J8l2/diK1XhzuLjJsuWcgKOIYQebhYoV3eL8GgUzIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBhY2tub3dsZWRnaW5nIHRoZSBjaGFuZ2UuDQpVcGRhdGVkIGFuZCBwdXNoZWQg
dmVyc2lvbiB2NCB0byBmaXggdGhlIGluZGVudGF0aW9uLg0KDQpUaGFua3MNClByYXRoYW1lc2gu
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDE0LCAy
MDIxIDExOjMxIEFNDQo+IFRvOiBQcmF0aGFtZXNoIFNoZXRlIDxwc2hldGVAbnZpZGlhLmNvbT47
IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7DQo+IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsgSm9u
YXRoYW4gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT47DQo+IHAuemFiZWxAcGVuZ3V0cm9u
aXguZGU7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB0ZWdyYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFuaXJ1ZGRoYSBU
dnMgUmFvIDxhbnJhb0BudmlkaWEuY29tPjsgU3VyZXNoIE1hbmdpcHVkaQ0KPiA8c21hbmdpcHVk
aUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBtbWM6IHNkaGNpLXRlZ3Jh
OiBGaXggc3dpdGNoIHRvIEhTNDAwRVMgbW9kZQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBj
YXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAwNi8xMi8y
MDIxIDE2OjA1LCBQcmF0aGFtZXNoIFNoZXRlIHdyb3RlOg0KPiA+IFdoZW4gQ01EMTMgaXMgc2Vu
dCBhZnRlciBzd2l0Y2hpbmcgdG8gSFM0MDBFUyBtb2RlLCB0aGUgYnVzIGlzDQo+ID4gb3BlcmF0
aW5nIGF0IGVpdGhlciBNTUNfSElHSF8yNl9NQVhfRFRSIG9yIE1NQ19ISUdIXzUyX01BWF9EVFIu
DQo+ID4gVG8gbWVldCBUZWdyYSBTREhDSSByZXF1aXJlbWVudCBhdCBIUzQwMEVTIG1vZGUsIGZv
cmNlIFNESENJIGludGVyZmFjZQ0KPiA+IGNsb2NrIHRvIE1NQ19IUzIwMF9NQVhfRFRSICgyMDAg
TUh6KSBzbyB0aGF0IGhvc3QgY29udHJvbGxlciBDQVIgY2xvY2sNCj4gPiBhbmQgdGhlIGludGVy
ZmFjZSBjbG9jayBhcmUgcmF0ZSBtYXRjaGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJh
dGhhbWVzaCBTaGV0ZSA8cHNoZXRlQG52aWRpYS5jb20+DQo+IA0KPiBPbmUgbWlub3IgY29tbWVu
dCBiZWxvdyBvdGhlcndpc2U6DQo+IA0KPiBBY2tlZC1ieTogQWRyaWFuIEh1bnRlciA8YWRyaWFu
Lmh1bnRlckBpbnRlbC5jb20+DQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLXRlZ3JhLmMgfCA0Mw0KPiA+ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYw0KPiA+
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jIGluZGV4IDM4N2NlOWNkYmQ3Yy4uZGRh
YTNkOTAwMGY2DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10
ZWdyYS5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jDQo+ID4gQEAg
LTM1NCwyMyArMzU0LDYgQEAgc3RhdGljIHZvaWQgdGVncmFfc2RoY2lfc2V0X3RhcChzdHJ1Y3Qg
c2RoY2lfaG9zdA0KPiAqaG9zdCwgdW5zaWduZWQgaW50IHRhcCkNCj4gPiAgICAgICB9DQo+ID4g
IH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCB0ZWdyYV9zZGhjaV9oczQwMF9lbmhhbmNlZF9zdHJv
YmUoc3RydWN0IG1tY19ob3N0ICptbWMsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgbW1jX2lvcyAqaW9zKQ0KPiA+IC17DQo+ID4gLSAgICAg
c3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBtbWNfcHJpdihtbWMpOw0KPiA+IC0gICAgIHUzMiB2
YWw7DQo+ID4gLQ0KPiA+IC0gICAgIHZhbCA9IHNkaGNpX3JlYWRsKGhvc3QsIFNESENJX1RFR1JB
X1ZFTkRPUl9TWVNfU1dfQ1RSTCk7DQo+ID4gLQ0KPiA+IC0gICAgIGlmIChpb3MtPmVuaGFuY2Vk
X3N0cm9iZSkNCj4gPiAtICAgICAgICAgICAgIHZhbCB8PSBTREhDSV9URUdSQV9TWVNfU1dfQ1RS
TF9FTkhBTkNFRF9TVFJPQkU7DQo+ID4gLSAgICAgZWxzZQ0KPiA+IC0gICAgICAgICAgICAgdmFs
ICY9IH5TREhDSV9URUdSQV9TWVNfU1dfQ1RSTF9FTkhBTkNFRF9TVFJPQkU7DQo+ID4gLQ0KPiA+
IC0gICAgIHNkaGNpX3dyaXRlbChob3N0LCB2YWwsIFNESENJX1RFR1JBX1ZFTkRPUl9TWVNfU1df
Q1RSTCk7DQo+ID4gLQ0KPiA+IC19DQo+ID4gLQ0KPiA+ICBzdGF0aWMgdm9pZCB0ZWdyYV9zZGhj
aV9yZXNldChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTggbWFzaykgIHsNCj4gPiAgICAgICBz
dHJ1Y3Qgc2RoY2lfcGx0Zm1faG9zdCAqcGx0Zm1faG9zdCA9IHNkaGNpX3ByaXYoaG9zdCk7IEBA
DQo+ID4gLTc5MSw2ICs3NzQsMzIgQEAgc3RhdGljIHZvaWQgdGVncmFfc2RoY2lfc2V0X2Nsb2Nr
KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LA0KPiB1bnNpZ25lZCBpbnQgY2xvY2spDQo+ID4gICAg
ICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgdGVncmFfc2RoY2lfaHM0MDBfZW5o
YW5jZWRfc3Ryb2JlKHN0cnVjdCBtbWNfaG9zdCAqbW1jLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG1tY19pb3MgKmlvcykgew0KPiA+ICsg
ICAgIHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gPiArICAgICB1
MzIgdmFsOw0KPiA+ICsNCj4gPiArICAgICB2YWwgPSBzZGhjaV9yZWFkbChob3N0LCBTREhDSV9U
RUdSQV9WRU5ET1JfU1lTX1NXX0NUUkwpOw0KPiA+ICsNCj4gPiArICAgICBpZiAoaW9zLT5lbmhh
bmNlZF9zdHJvYmUpIHsNCj4gPiArICAgICAgICAgICAgIHZhbCB8PSBTREhDSV9URUdSQV9TWVNf
U1dfQ1RSTF9FTkhBTkNFRF9TVFJPQkU7DQo+ID4gKyAgICAgLyoNCj4gPiArICAgICAgKiBXaGVu
IENNRDEzIGlzIHNlbnQgZnJvbSBtbWNfc2VsZWN0X2hzNDAwZXMoKSBhZnRlcg0KPiA+ICsgICAg
ICAqIHN3aXRjaGluZyB0byBIUzQwMEVTIG1vZGUsIHRoZSBidXMgaXMgb3BlcmF0aW5nIGF0DQo+
ID4gKyAgICAgICogZWl0aGVyIE1NQ19ISUdIXzI2X01BWF9EVFIgb3IgTU1DX0hJR0hfNTJfTUFY
X0RUUi4NCj4gPiArICAgICAgKiBUbyBtZWV0IFRlZ3JhIFNESENJIHJlcXVpcmVtZW50IGF0IEhT
NDAwRVMgbW9kZSwgZm9yY2UgU0RIQ0kNCj4gPiArICAgICAgKiBpbnRlcmZhY2UgY2xvY2sgdG8g
TU1DX0hTMjAwX01BWF9EVFIgKDIwMCBNSHopIHNvIHRoYXQgaG9zdA0KPiA+ICsgICAgICAqIGNv
bnRyb2xsZXIgQ0FSIGNsb2NrIGFuZCB0aGUgaW50ZXJmYWNlIGNsb2NrIGFyZSByYXRlIG1hdGNo
ZWQuDQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAgdGVncmFfc2RoY2lfc2V0X2Nsb2NrKGhvc3Qs
IE1NQ19IUzIwMF9NQVhfRFRSKTsNCj4gDQo+IENvbW1lbnQgYW5kIGxpbmUgYWJvdmUgbmVlZCBp
bmRlbnRpbmcNCj4gDQo+ID4gKyAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgIHZhbCAm
PSB+U0RIQ0lfVEVHUkFfU1lTX1NXX0NUUkxfRU5IQU5DRURfU1RST0JFOw0KPiA+ICsgICAgIH0N
Cj4gPiArDQo+ID4gKyAgICAgc2RoY2lfd3JpdGVsKGhvc3QsIHZhbCwgU0RIQ0lfVEVHUkFfVkVO
RE9SX1NZU19TV19DVFJMKTsgfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHVuc2lnbmVkIGludCB0ZWdy
YV9zZGhjaV9nZXRfbWF4X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0DQo+ID4gKmhvc3QpICB7DQo+
ID4gICAgICAgc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hvc3QgPSBzZGhjaV9wcml2
KGhvc3QpOw0KPiA+DQoNCg==
