Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A7747B93D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 05:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhLUEwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 23:52:11 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:61751 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLUEwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 23:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1640062330; x=1640667130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xCXBvaUwtCnN6b/WvT1sj9sfTC+Ahk5HThLCc7KP/+A=;
  b=ub+ArIoDGDlalKz8f/LyOI5NOjiXlG3WBkB7s/E9C+bJjKQLIGi52BXz
   Ql65INVAegz8428nZZFsSAfGSop5074QvBHpKCmHvkWHPeEpNrw3bYJWZ
   fwz4+GFR4EisT4L7oMI/6mxR1kMFX7HotR/MB44SZop5kyZ9y3C785OT/
   0=;
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 04:52:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFvxIClWqwa4kIL/1+nujNHkArt66RW3P7TOdOPDzumAdbb3Y2vHfSH6X+EyixsQsPlWIdnwuXZQsvFerjKIOUFALiuYyuOAJaopG5hLGd5VsQGOJIX6V/DMgawUgVSXARz1AjD8f4PKHonCZIZ+37UQ0bGYO0e1POEN4x2KRvYyzTQ1/EJca0jB6SZzsQma8QK90CaYGQmvwgydWu8HerYJqCE1dqnf2A4T0xAlJQwZP/kzkjrWjIYc2S0Rnw5TYvAfPXeKMUhWmRfVd0TgB4fmdi/phjrHQtQ5ryv7mT71/ho8LL9X1xPOCKPf6OYJBmOGfQl1yGnrCFpE2I5y/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCXBvaUwtCnN6b/WvT1sj9sfTC+Ahk5HThLCc7KP/+A=;
 b=GYUO8U7S5SmWRxjUOrDAGel7L+luXG3050g1o1klk/kqykobs3sCLgV0NvAskkqITV4rvpr53Ct/W2JcwLSHL66efKD9i8QAZcuGDYOtfDFsZIu0Vq8S0c5BDmbLnRej68qNCo7QendQI+TbPtx7G7qBcMJaXI+/DSwNA79az032aMjKjS5NDc+unZH+IrQEAOym7UlkXO/iwZE9kumzc7pbRAbeBFskrXwg80eDdziBI6pa7+Hk+HvXv9Bg4f0GYuescubFR2uHhmo/ufVLi4C8CYTdd4gnsvqHNB4Wvjr1Vof6fo05wWazyJ/zp9nTZmWuZgC6EQtm/ZhrXc51kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4094.namprd02.prod.outlook.com (2603:10b6:805:39::15)
 by SN6PR02MB5215.namprd02.prod.outlook.com (2603:10b6:805:67::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 04:52:05 +0000
Received: from SN6PR02MB4094.namprd02.prod.outlook.com
 ([fe80::f549:ce08:f92e:9e5a]) by SN6PR02MB4094.namprd02.prod.outlook.com
 ([fe80::f549:ce08:f92e:9e5a%4]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 04:52:05 +0000
From:   "PANICKER HARISH (Temp) (QUIC)" <quic_pharish@quicinc.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        "PANICKER HARISH (Temp) (QUIC)" <quic_pharish@quicinc.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar <quic_bgodavar@quicinc.com>,
        "rjliao@codeaurora.org" <rjliao@codeaurora.org>,
        "hbandi@codeaurora.org" <hbandi@codeaurora.org>,
        "abhishekpandit@chromium.org" <abhishekpandit@chromium.org>,
        "mcchou@chromium.org" <mcchou@chromium.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
Subject: RE: [PATCH v3] Bluetooth: hci_qca: Stop IBS timer during BT OFF
Thread-Topic: [PATCH v3] Bluetooth: hci_qca: Stop IBS timer during BT OFF
Thread-Index: AQHX8OWxfZM4/+dEiUi2OBSWYDHaRqwyPKAAgAoukoA=
Date:   Tue, 21 Dec 2021 04:52:05 +0000
Message-ID: <SN6PR02MB4094E20A36B022C706929DC18B7C9@SN6PR02MB4094.namprd02.prod.outlook.com>
References: <1639484691-28202-1-git-send-email-quic_pharish@quicinc.com>
 <YbjS5sPkiyfl42np@google.com>
In-Reply-To: <YbjS5sPkiyfl42np@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5689460a-4caf-471e-4635-08d9c43da2f3
x-ms-traffictypediagnostic: SN6PR02MB5215:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB521544C5318CBE0693B94E31F77C9@SN6PR02MB5215.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eIQUDEXGHDUmtVQI8nBMaYH8fzCX9PrACsVz8HK7ls6j9R82vCWMRx48t+q1NmHre+Q/lQNX+xgqbRwe3rL3Ugh85uXI6F91wG0qM3Ssu/dlXi876MbjL/vhNxPdHG+H6JbVoa7+YBavwvamvgpwlNeRXNYcc65dxzcXyj1TdFxHAQtoSK/KU3+cHFytrUfP4wyU8XTOMl+gMTw7nzfZ+keezBrXBN6iHEPcaLVYEp70SWXFAPkrTHd7pd7hiWOJLR/mdynUGNvV+TFGAXshTKqrsLRfnXGH5LFae029/OUptarSWXbZjdRMdLWNv2uhl9SxUGQ3JbU4nk+jnWoS0tJzO8u8N9mLPvwnQcm7uBC8nds88AQmA/zZy2fYxmzZ/RK1b0TflTDLjJ/PP+4dUwX381QagvK3f/r8ybPaSGWeIIyi7+pfQtfz8YcB5QWxx9ZXXok8B7lBcGFydWNABFkEYgGJgvhCP7RqZJorU0MEUet/o2wST99W9RuACMyMK7CZc+mZI6xUSpW3gdAkPLBwQKDwOHYkiAVXCI1qcAsxMcgaGQSPAn99mCxySJDMg54NcWeEAhJvK5WBYKURi3ilG03iISlZv068ZT+KimNnZyStX3YCN8TRVdxO7ZeiJdxuj6EWopD+rvu3bp/2zqOZUu8GBfNgRGKjbYstONvNVINS5E71ayTmkGJMHWZ5YB7KhzEo7UqKcI/35j6qIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4094.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(186003)(26005)(316002)(71200400001)(122000001)(9686003)(2906002)(6506007)(76116006)(53546011)(7416002)(54906003)(107886003)(110136005)(5660300002)(66476007)(66556008)(66946007)(8676002)(7696005)(64756008)(66446008)(38070700005)(33656002)(8936002)(83380400001)(55016003)(4326008)(86362001)(52536014)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzliYjdHb3FZWm5vUXlleHZkNHZDV3NiWi9CWGh4NFJjeHNEeGt3KzMwQ25n?=
 =?utf-8?B?TGtFNnNEVWhwUDFIOEUxUXBJSFRNWWF4a2E5OVdIUnZhNUp1Z0dFZmswVjRy?=
 =?utf-8?B?MWJmWGswUUpEUnl6T0ZtMldzWXJhNHZ5NmZ6WVV1MFRiYmYzaUt5VGM3bTVj?=
 =?utf-8?B?S1grbWJvUXNpbHcwZjVTMmdPaWtSTFhoc09DVmJlNTM0OTd0aEZ2QlRlMnBy?=
 =?utf-8?B?c21qZUFxUEw4cFhTN0ZzMGFZa2lmakhjUlU0amlwWUFHbWlkL0o1TmRPcWg0?=
 =?utf-8?B?RUpRMHBJczlUcC9pVjU3UnprSlJnNVhQU1hCNHZYa3hQWnlXTUxReGZjZ3pw?=
 =?utf-8?B?MU9lL2hJQXhBeTdCVmxNeVUvcVVMT2VIMHU5cXBrMXVlekk3dXlsNzZKOUhF?=
 =?utf-8?B?NWRGcTd0Q2t5eGw5RnNtRy9vQkJzQXlraG1lSDJ4Q1NzcUh6OXpUdmdTZE1M?=
 =?utf-8?B?bnRlRXNwNDl6WUNFbmprU0tHemxqUU5OUkNvdS96THlqcTE1cGdHZjBvc1VF?=
 =?utf-8?B?Q1lWUEl1WWZsS1YwUHZ1d0JSQ3o4YjJ0bW5VMWYrS2E2Z2t1dWIwRHFnWEN1?=
 =?utf-8?B?dHpWNE9RbkJGdnZ3T2lBUncrRjFjUEV6RnpRTWF6V2Y4SDRIL3pUNkR0OFFW?=
 =?utf-8?B?SGZnekRXSmpFVVdWKzNHUFVRUkI4cW5sZlllSGpuVitPMlI5bkY3ajJ2MGJ2?=
 =?utf-8?B?ZEs1ZGRUazAwWVhkVnVocjE2MGU1VkRraTRybHNzdkNPRlBOcEYzYjRrbWp4?=
 =?utf-8?B?R1l1MUgyQUlyQ0tnZWNtOHg3dzY2Qmh1ZlRmSzErZ2dBZVMwdmptU1F5bGtE?=
 =?utf-8?B?ZDBLVFVjaHE4QzFoV3BXMEgxU3NHZExpM3dtOFM0b2NFVE5XZDI3b1kwZFgv?=
 =?utf-8?B?Q1JtMVZiZ2FucmUrYmt3ejJ4em1PQk9aMkd6Q0JDeGRuU25Odk1MajlPUHJH?=
 =?utf-8?B?Si9KTytuRDByVnhMUEx4bkdta0ttckhsbGtPN3hQMTFLVVIrUkVsUmFIMG9G?=
 =?utf-8?B?NzVrR2J2U0Y0dU5qL3N5WHdFT2xodzEyeUE2TWVNSTFmaEg5eVQ5MjQwWHRs?=
 =?utf-8?B?SnZxV1hMOVAydGpvazJLL05od2h3dlBTOHdZWjNEK2ZscTB6RDNqUlo4TE14?=
 =?utf-8?B?MHczMlJRNnJTOTNnSmFmYjVJcEh6S2NySS9UbENOUzJwVHJkRjJqbWFZQXZr?=
 =?utf-8?B?N05jL05XVVo4MWRBc2RQbTF1dXJweXFLQUhRWE9tYUkzLzZzd095RXJ0VHV1?=
 =?utf-8?B?cERWSW96Qjk1VXBSN3JhSnZLSnB4TU9YVWVwOVZxbDhYcFE0dWJwQStJZW5B?=
 =?utf-8?B?WXRLSW9DRXVjWGJ5WDJzM2ZNVUNkWHdMTTN1eUVFbG9IN090R09XR3I3VG1x?=
 =?utf-8?B?b0Y5c0kwQ2laeHV4Vi9VZVZXeHNicFhOZnVSemNwYWJGWXhmNjFPNGZEcmpG?=
 =?utf-8?B?SW80eEIzVkpINHU0QmxCc3Y2bnNrTXRVZG5UN1lYNjBEOS8wSUhxamJRZmcz?=
 =?utf-8?B?dkZWdGJJTDZxcUU2YlJMa1gyV0JIY1FpNERFZ3ZIT25NN1BZQVR4R2lGMUlB?=
 =?utf-8?B?bHBMeUF3R1pYMGE0c1RhQVYyM3F3MUJlellXbUFodlVxSENpZ1loSzZsN2xv?=
 =?utf-8?B?VSt5c0drenVOdFhFc1ZKemV2bEI2UGcya0h1S09IcTJ0ZG51UG1UdS9jZkJU?=
 =?utf-8?B?WFd4RUFWYTFPb0xUUlVVYW1SV092ckZlT2I4VDZqdW5va2FxeEl1cGh2WFFr?=
 =?utf-8?B?dlBncEp4ZWoyZHBOaGJUMlgrank1RkpkN0piU005Tk9QNHFUQlZjWEQwUGJO?=
 =?utf-8?B?UHdzZmhUR0RSQStjMDh1Rnc3cDlsRzlaZDA2OUdYUy95VDdhbWp5VFhEYmRV?=
 =?utf-8?B?U3ZOY21iYTRJemhtTzNldnp4d2V4VkxKM2hNQVhyMGFTN1U1bEtKTjgwcm1L?=
 =?utf-8?B?YmtOazJnZEFFYmdCczZUN291ZmdaaGJldnlIWFVTMyt4bVBCcURPbzBnUyta?=
 =?utf-8?B?bTNkYUVTMDUvdjE0SFIrWUVkbDVINFRYRXo0RHNwWkpqUGZxK251MWx6T0RS?=
 =?utf-8?B?dE8xVTFjYjMyY1VlQWhsV1RmNU1CT1dpVHNRT3lzM3cxaDIwTFYxUnhBRGMr?=
 =?utf-8?B?aUR0K1ZEYkwwcHJudytDSTVwQk5taG40RHVxL2pvR1RBaHhodlp0dmpydFg2?=
 =?utf-8?B?TDcvVWlhVWlxdUwvUERSRXRTNk5uNmoxSzB4T2lrUm5WRUE3MmRDK1hlNTNQ?=
 =?utf-8?B?Nlc2djV6Q3ZlZWlPUHpiM29rQW1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4094.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5689460a-4caf-471e-4635-08d9c43da2f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 04:52:05.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gowtgpAYgTGvGdg9/wfofv3zCKa32HkfWkeadll7ciIF4wNFw1wThJx8pwmWWZh3gnPZPOfLiTdzh0slNtEsJgmRXDkNlo3U1B94lZ8pnB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXR0aGlhcyBLYWVobGNrZSA8
bWthQGNocm9taXVtLm9yZz4gDQpTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxNCwgMjAyMSAxMDo1
MyBQTQ0KVG86IFBBTklDS0VSIEhBUklTSCAoVGVtcCkgKFFVSUMpIDxxdWljX3BoYXJpc2hAcXVp
Y2luYy5jb20+DQpDYzogbWFyY2VsQGhvbHRtYW5uLm9yZzsgam9oYW4uaGVkYmVyZ0BnbWFpbC5j
b207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtl
cm5lbC5vcmc7IEhlbWFudCBHdXB0YSAoUVVJQykgPHF1aWNfaGVtYW50Z0BxdWljaW5jLmNvbT47
IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBxdWljX2Jnb2RhdmFyIDxxdWljX2Jnb2Rh
dmFyQHF1aWNpbmMuY29tPjsgcmpsaWFvQGNvZGVhdXJvcmEub3JnOyBoYmFuZGlAY29kZWF1cm9y
YS5vcmc7IGFiaGlzaGVrcGFuZGl0QGNocm9taXVtLm9yZzsgbWNjaG91QGNocm9taXVtLm9yZzsg
U2FpIFRlamEgQWx1dmFsYSAoVGVtcCkgKFFVSUMpIDxxdWljX3NhbHV2YWxhQHF1aWNpbmMuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSCB2M10gQmx1ZXRvb3RoOiBoY2lfcWNhOiBTdG9wIElCUyB0
aW1lciBkdXJpbmcgQlQgT0ZGDQoNCk9uIFR1ZSwgRGVjIDE0LCAyMDIxIGF0IDA1OjU0OjUxUE0g
KzA1MzAsIFBhbmlja2VyIEhhcmlzaCB3cm90ZToNCj4gVGhlIElCUyB0aW1lcnMgYXJlIG5vdCBz
dG9wcGVkIHByb3Blcmx5IG9uY2UgQlQgT0ZGIGlzIHRyaWdnZXJlZC4NCj4gd2UgY291bGQgc2Vl
IElCUyBjb21tYW5kcyBiZWluZyBzZW50IGFsb25nIHdpdGggdmVyc2lvbiBjb21tYW5kLCBzbyAN
Cj4gc3RvcHBlZCBJQlMgdGltZXJzIHdoaWxlIEJsdWV0b290aCBpcyBvZmYuDQo+IA0KPiBGaXhl
czogM2U0YmU2NWViODJjICgiQmx1ZXRvb3RoOiBoY2lfcWNhOiBBZGQgcG93ZXJvZmYgc3VwcG9y
dCBkdXJpbmcgDQo+IGhjaSBkb3duIGZvciB3Y24zOTkwIikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFBhbmlja2VyIEhhcmlzaCA8cXVpY19waGFyaXNoQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvYmx1ZXRvb3RoL2hjaV9xY2EuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvaGNpX3Fj
YS5jIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX3FjYS5jIA0KPiBpbmRleCBkZDc2OGE4Li42ZjQ0
YjI2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmMNCj4gKysrIGIv
ZHJpdmVycy9ibHVldG9vdGgvaGNpX3FjYS5jDQo+IEBAIC0xOTI4LDYgKzE5MjgsOSBAQCBzdGF0
aWMgaW50IHFjYV9wb3dlcl9vZmYoc3RydWN0IGhjaV9kZXYgKmhkZXYpDQo+ICAJaHUtPmhkZXYt
Pmh3X2Vycm9yID0gTlVMTDsNCj4gIAlodS0+aGRldi0+Y21kX3RpbWVvdXQgPSBOVUxMOw0KPiAg
DQo+ICsJbW9kX3RpbWVyKCZxY2EtPnR4X2lkbGVfdGltZXIsIDApOw0KPiArCW1vZF90aW1lcigm
cWNhLT53YWtlX3JldHJhbnNfdGltZXIsIDApOw0KPiArDQoNCklmIG9uZSBvZiB0aGUgdGltZXJz
IGlzIGFscmVhZHkgcnVubmluZyBpdCB3b3VsZG4ndCBiZSBzdG9wcGVkIGJ5IG1vZF90aW1lcigp
Lg0KSSB0aGluayB5b3Ugd2FudCBhIGRlbF90aW1lcl9zeW5jKCkgaGVyZSB0byBlbnN1cmUgdGhl
IHRpbWVycyBhcmVuJ3QgcnVubmluZyB3aGVuIHRoZSBjaGlwIGlzIHBvd2VyZWQgb2ZmLg0KDQpb
SGFyaXNoXSA6IEkgd2lsbCBjaGVjayBhbmQgdXBkYXRlIGluIG5leHQgcGF0Y2guDQo=
