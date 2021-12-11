Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C47471150
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 04:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhLKDsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 22:48:21 -0500
Received: from mail-eus2azlp17011014.outbound.protection.outlook.com ([40.93.12.14]:29456
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236273AbhLKDsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:48:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUOz8ADSBpnytgY3Va7s7HpvGMPLVdMG0pCpcCV7+3rKs7xWSDjeYVKRITnZJS9S8DcNEXx/4DSxfqRUgRe3V/BoR+2QOAJOk1t5oXUnn/KjbML0MJbYs1I8AJO5jMJocYPzGRP0i89N8SIUDEQF9eGasfUXdj0E+4gdEIux+ffxlu0tv2b9w60qYqLW5V7SSow3I1/FMpcZAdB8v2SON1hseF8g429Un8hcJt8RDKJGhj8gxnBYFMx6DwLHKHEmoq6knGAm0OCyW0qFQLY+FZEgq8FK16BwkY372L0N+UxR2g4ehSWBrpBuQ+uInJBTm1AMNafxulPZaFJSb1JNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Mr0JoHCELZr8GW633r8qyAsBtKc4AcVwWcKDtzwxVs=;
 b=UUfSmYaSqVzGiwf0umcI6+gxiKIULw8nmBI3t8DngcXgHFBKs+0ZLHX7wsztLqpjF8hNBlIZMx3utYuNhvu+F8aZ6F5mZku0d/TOKbLebEnm+BX9KC8FwjRjQSKrv/R9zxbu+1kA0AILZuyyIQ3bOAobfGCzB09AQ4GkDcvvY5cKUNm9aWM1S7aXsh74LZEjv/scXa9ahU1Od2LGywmsyuNGT4swKlCucQxj6mQ0bIdttUWZZJNTM692ZKvSLJ7b6Ayt7I64BhLgtKDq94tp/XFJQcPGgeNnWF+aUy5Tt+oIn6w7Xaj686JJH82fcB/uGPnzzoak9V7W+Kv1HmoTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Mr0JoHCELZr8GW633r8qyAsBtKc4AcVwWcKDtzwxVs=;
 b=eHhTD8VNbQc6zysltHlvlIf1OtiqNwDFoFb2QMjmIkWcxx2kVe5lkJ6xQV7zP16GpEhrEVmV47SKldr3I4tDUVOwb2AXsKV3sLB4Q76xupC/gd8fMZkzZ10cnrg2T2nCea4XMr58NNvd+rSXGyQhWVWghMzIERDQ67IQAWYU1bM=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by BY5PR21MB1426.namprd21.prod.outlook.com (2603:10b6:a03:232::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.10; Sat, 11 Dec
 2021 03:44:37 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83%4]) with mapi id 15.20.4755.004; Sat, 11 Dec 2021
 03:44:37 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "'ming.lei@redhat.com'" <ming.lei@redhat.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Random high CPU utilization in blk-mq with the none scheduler
Thread-Topic: Random high CPU utilization in blk-mq with the none scheduler
Thread-Index: AdftWjJCThl7/4e5TledNcioslhEuwA0I/TAAAIttYAAAhJ/YAAAZxqAAABQgvA=
Date:   Sat, 11 Dec 2021 03:44:37 +0000
Message-ID: <BYAPR21MB127011609EBF6567126EBF83BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <c5c8f95e-f430-6655-bab5-d2a2948ab81d@kernel.dk>
In-Reply-To: <c5c8f95e-f430-6655-bab5-d2a2948ab81d@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d4959bcb-08be-4def-9e92-f74d49f6f55a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-11T03:24:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cd5c7a0-c406-477b-ae38-08d9bc588df1
x-ms-traffictypediagnostic: BY5PR21MB1426:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB142669602628BE9545F7C5F9BF729@BY5PR21MB1426.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ktd3mH1ey2tfoc4vucfpyVCBxDPOE1Fdiwj46JGj8R8luF8HXaEOTYgqsBNnvb9jXMT5g1z4XXodjPCPFvQh6GKDMvSPAqyKziNlcQk8l4i5McKQXJrgxdJzcC8sah3vvLD9G9ChNUWzvSCyXKtNIXHatXf02DOdtgitbRf4TmBGcx1xwmAhuj4u43M5F1K6BQJeJkLKzSCnrw2pjNkPtp86nphobp3faUhYLZ4X+Pt4SvdeLPuFw4NNlDTzz67Qav7m3As67xzcJkfM9mfXfedIwMSpyBlZTdegDV2GxNO84sTpXqOgWEMgRjP/8IzDwhs5WXKbdGjZSGfA4yiMYSQVlauAbz5VwIz2pv+p3gT/SctHdZKCqCuJnd9YccBw7ahSStAKtnaLJfEYGZYEQLv+Zmx1OGsWQa6ekKWExG5tAQA2/6j4/dNjweygmLzMMr0jBxB5H3mxXQQpLcth/zrX1WDLHC8/iUo7eyvw1AbAunszLt5IBJ6Q/NN331DdUqFj19Ye8KHno+251M7x+hIleRRXM+4u9FWd8i30W7wNePTHfgXDxX9+je2lM+y8TzZk2v7OdhvTlQ79GrgFnHo4UtrOROzGa/02cqcecICs+spVNP8oRRYVqBl/q3jFNKJ99BgpxIB449l7vsiZ3oxK6mIayLRzLPdgylxyimGrEmqQfIxZKlydBYFmORyl9nGLecPxlTLAhwhMf0nJqcpTZDRI60yjshUDsO8r+L2UOH+rA35i/GHaWvxalrzUTpDXLLEvLM44NgBEhLjodQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(10290500003)(26005)(38070700005)(508600001)(186003)(8990500004)(4326008)(7696005)(110136005)(82960400001)(52536014)(9686003)(6506007)(82950400001)(33656002)(66946007)(71200400001)(64756008)(86362001)(66476007)(2906002)(122000001)(4744005)(66446008)(66556008)(76116006)(316002)(38100700002)(5660300002)(83380400001)(8676002)(8936002)(54906003)(491001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1V6NFcraGJnTEkrVzlYL2JLNXNZUVBMZ25GMC81TkxRMHZybU1Sc3BUbk0v?=
 =?utf-8?B?cmZaVFpzU1grd3ZMNXdKTkg2WmNBNkFTbmc4T0p2N2JuUEd4MGs1djZWRm1D?=
 =?utf-8?B?UnJMV28ycXREM2hOODMybkZxTkxvTEY2NlpOTHp4MTBzTktVdDM3Kzc0MDBN?=
 =?utf-8?B?Vng3U294WGVtMkZiMlFiVmxlb3BNdmlSMUViSkpmOVpESVllai81eS9pejhz?=
 =?utf-8?B?VzEvUzVLSWNMc00yYVBrQS9sMFV6R1ZkcWEvRlVTU2liRXZ0WmdZWkQxaWNu?=
 =?utf-8?B?M0djTnpsckp6Z1h6QlhvWmg3Q2VpMEh6RU4wbEljR0ZsQlNEakl4bkluT0Vs?=
 =?utf-8?B?a0xTcTJnVE8reEFsTWFCVmpSTlAyc2JIRXNOOFAyMTVUOWxrdG5xakFyN3ox?=
 =?utf-8?B?eS95WlpuRmVVaGNwWDkwWVBUcGZqNXl5Q3J1NWYyb1JwMFBmMWFtYmJ2K0I3?=
 =?utf-8?B?dytyOFNMK0lrYjhVeU45L1hrQW9NaDVrTTBhSjlhbWxLengzNDNXYTl6M0Ey?=
 =?utf-8?B?b1lTYTFteHNBOXhiOHpnQVduUXJzVS9UcmNFd1ViMUlXRmFpbHFLbjhtVUdR?=
 =?utf-8?B?RGlEc1BydGdaNDgwZGpIdGdrSkFjWlhLMkJCYnlFVDBpNXZ4T01IQ2w0ZDly?=
 =?utf-8?B?aXZJeFhrNjYrUHE3a0U1bVVUNDdYcGhkcXNMNUFwOHMzMUFacmJCdWIwSGdB?=
 =?utf-8?B?Z3I0RHlNTjVJMVF3OGszMUo1YUM5UWpiK0dhZ20yUUN5V3Z2NXRXcW9TS3Jl?=
 =?utf-8?B?Ly8xbmg2TWxJbTJHTGhxTWNhRUMzZmJTZm5qdnFySXdCVHBQZTB3OVZ6ZTA5?=
 =?utf-8?B?VUJ2dVlRajJZY0NpL3NpaDJ6UU1zNmZSRjQ4WlNadC92UHUzeUt0ajJaSGlE?=
 =?utf-8?B?RWJNU3QzWjdBSWtOMlhqYlpNVGFlelV3TmlPS2VGdzY0ZG9uTG52NE02RkNq?=
 =?utf-8?B?aTNQS1MyUkJpMHVwK0J6Ynh5ZDFZbFN5MzUvcCs0OVY5YkNwRFRuRHh2NHJz?=
 =?utf-8?B?NUFoUi9aeUo4RUhqenFDOGdyWURLZERFWk9XUzBxSGVUK2cyelZTMTBHditH?=
 =?utf-8?B?OEJ0QjJORmZFTmsvZTJXaUlkcU1YQ1VOSVozV1F2OTRGeEZkckNYQzZueEZa?=
 =?utf-8?B?aUppcFZweDVBbURpVFRhTi9DeFhrMVNyR0hRb2ljYjFxcUZJcDVSY3ZIaC9T?=
 =?utf-8?B?N0U5b0FPbnlTMGlIM1hXMmt1eWo5emJCdGpDSVY5QVp3QU5CNXBlbEt1c0dz?=
 =?utf-8?B?MG1pUGtuT0VmK0ZSamtTV09vSWQ5SGFtVGhxUEt6SXZ2bytRTVpIZXo4bTZT?=
 =?utf-8?B?SnV2K2p2VlpEL0RBUWpLRXJqMjc1Z083QkZ6WHFUdXFvNm5Mb090SDdPQWxV?=
 =?utf-8?B?eXZ1VHFFVkVHRE4wZVJBdnVTTlFZdU5GMy8rRkgwUTNxZ1pkQ3kyeVVKTVVr?=
 =?utf-8?B?N2o1T1RFRUtCK1krVEl6bjZkUEtyWTJNOUlWMDVpeUlzTXlqV1pmR2k0MWNp?=
 =?utf-8?B?VWFpTExaV2cyb1lsdEVweWViMVgzZU9oTmlEdXZwbG1KeU56VXkwb2VpMHF0?=
 =?utf-8?B?ZVZrWEpCM1U0Z3VTanI0dUw0V2tXeXFESmRxRkFvYnNtYXBQMkRRY0xMT3lT?=
 =?utf-8?B?am92UTFoSVZvT3BUK2I0Qk53dnhLMTVUaUJKLzVLNlhZelBqUjZ5OXNFd0gv?=
 =?utf-8?B?OFJ2ZmxBNXBCVDdPMk5xai9ETXUvR1hkSWFRNWZRTmRxT0FyUE5IOFNxN3pm?=
 =?utf-8?B?SnQ4eFZ0WjdvMXh6aHJXZjhlNnFvb1Y2ZEVDTlI0SnFOUW1icjBlRHZKWHBK?=
 =?utf-8?B?T1pQeFJLTjF1UUdJdEQ4YUo3b1lQa0JSeUt1aWI3WTgwbnBFWkpJRitPZzFI?=
 =?utf-8?B?ZDNVSnJKU1FFazRhQUFWN3FuZ05wcTVPVXBRcUpWNHN1bVZYbmh6bmVvQWVt?=
 =?utf-8?B?U2hoV2hyUmRYZmtCTnhTbjlKQ2NqQlZuSGY3cCtqTjVJdjdQTGhTRU45WGln?=
 =?utf-8?B?ajRpdWxyT0dHZDdQUkNtMFppekJweUpEOFh5NTg4OTRuK1pRRUN6QzZuWXZU?=
 =?utf-8?B?eW9SajFVNE1PSytYUnZOd0xBU2RQT3NxamMrdTF2TWhrMEl2disxNE5ieVpo?=
 =?utf-8?B?TGRHbFQ2RE4zcFRmOWEyWVJlcFZRNG0yc05aUnczMGNyVGd6cW1XTVhFdWM2?=
 =?utf-8?Q?6V4OAt/eyc1AOoj9vkouQ7w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd5c7a0-c406-477b-ae38-08d9bc588df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 03:44:37.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tll7LQAvlWLDQZJyldnHgOTGYnvMRUAiEybNOJtjsVGCRpt4D1KOlbyPARzHELUJ9V5gWgCawTylKixDDRsNnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1426
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+IA0KPiBKdXN0IG91dCBvZiBj
dXJpb3NpdHksIGNhbiB5b3UgZG86DQo+IA0KPiAjIHBlcmYgcmVjb3JkIC1hIC1nIC0tIHNsZWVw
IDMNCj4gDQo+IHdoZW4geW91IHNlZSB0aGUgZXhjZXNzaXZlIENQVSB1c2FnZSwgdGhlbiBhdHRh
Y2ggdGhlIG91dHB1dCBvZg0KPiANCj4gIyBwZXJmIHJlcG9ydCAtZw0KPiANCj4gdG8gYSByZXBs
eT8NCg0KSSByYW4gdGhlIGNvbW1hbmRzIGFnYWluc3QgdGhlIDUuMTUuNyBrZXJuZWwgYW5kIGdl
bmVyYXRlZCBhDQo3NzEtTUIgZmlsZS4gQWZ0ZXIgSSByYW4gJ2J6aXAyIC05JywgdGhlIGZpbGUg
c2l6ZSBpcyBzdGlsbCAyMiBNQiwgd2hpY2gNCkkgZ3Vlc3MgaXMgdG9vIGJpZyB0byBiZSBzaGFy
ZWQgdmlhIHRoZSBsaXN0LiBJJ2xsIHRyeSB0byBwdXQgaXQgc29tZXdoZXJlDQphbmQgc2VuZCB5
b3UgYSBsaW5rLg0KIA0KPiBIb3cgY29uZmlkZW50IGFyZSB5b3UgaW4geW91ciBiaXNlY3QgcmVz
dWx0Pw0KPiANCj4gLS0NCj4gSmVucyBBeGJvZQ0KDQpJJ20gcHJldHR5IGNvbmZpZGVudDoNCjEp
IEkgY2FuJ3QgcmVwcm9kdWNlIHRoZSBpc3N1ZSB3aXRoIHY1LjE2LXJjNCBldmVuIGlmIEkgcnVu
IHRoZSB0ZXN0IA0KMTAgdGltZXMuIFR5cGljYWxseSB0aGUgaXNzdWUgcmVwcm9zIGV2ZXJ5IHRp
bWUuDQoNCjIpIElmIEkgcmV2ZXJ0IHRoZSBjb21taXQNCg0KZGM1ZmMzNjFkODkxICgiYmxvY2s6
IGF0dGVtcHQgZGlyZWN0IGlzc3VlIG9mIHBsdWcgbGlzdCIpDQoNCmFuZCB0aGUgcmVsYXRlZCBw
YXRjaGVzDQoNCmZmMTU1MjIzMmIzNiAoImJsay1tcTogZG9uJ3QgaXNzdWUgcmVxdWVzdCBkaXJl
Y3RseSBpbiBjYXNlIHRoYXQgY3VycmVudCBpcyB0byBiZSBibG9ja2VkIikNCmIyMjgwOTA5MmM3
MCAoImJsb2NrOiByZXBsYWNlIGFsd2F5cyBmYWxzZSBhcmd1bWVudCB3aXRoICdmYWxzZSciKQ0K
DQpmcm9tIHY1LjE2LXJjNCwgSSdtIGFibGUgdG8gcmVwcm8gdGhlIGlzc3VlIGltbWVkaWF0ZWx5
Lg0KDQpUaGFua3MsDQpEZXh1YW4NCg==
