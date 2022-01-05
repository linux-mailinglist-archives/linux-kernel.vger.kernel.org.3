Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123FE484FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiAEJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:07:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63842 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiAEJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641373636; x=1672909636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yKoBgYzHqhDlkV4mpPbaogMBE8U2qIdbg9nJRTjzhwc=;
  b=FooiZ2432TbzUMMIQaBSjcxexgf+7eRYMSrBn2YYP5tMPW1SWtwmQNhQ
   2CW1hJ3/ylbZHYL2CNULkZ/Q4E8P8/aqhtjnhfSxKOyQHs0CMb5WN0s7F
   ZKiUFB7hr8SGw4PxndchjxDnUBYbBQrFh80LLuiLQGhhBRwidlJwd2QOR
   Nr7vj1y0OI23ESSinlNKudezvmU8bAJz9JjvCqa5MuW4V8ebU3BnW9SJ2
   PywA35Ra8Wcxxq50fvAnq4n0izssyiHKatENWIXU3LneKZ8+nUw7Ivoeh
   4wvzLiwunq5FPbVj5tuSA0U5m0BNJcFnfZp+ag/FQnQLA0XviV6Lcs5PB
   A==;
X-IronPort-AV: E=Sophos;i="5.88,263,1635177600"; 
   d="scan'208";a="293777346"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2022 17:07:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9u6w/M6Nx30vNpSzqmPzX2u+UFoBNoXgSytzqQRCI+1MMOrENH1mmIWTB2I+RESDAk9wRlIU9isNcaVum+Gtf2eueJmGODVNbb77YG8FUuN108kElmPSOT/iX0+D5FSOSIEdXlZGikItJ/b/0Rr7NO21pu0S1tJJWuN7cu14p6/hwlUPkoqMeIx2MkKsQ99BIhkNj/vkgJbCBdDezYuQflb9ofswPvRl5sJTP94/nhKMh2UkdjG4rrqi42qQsKlYdr879SoY49S4HvkFFbsE+nZehsHorcyHQs3N04DvzOl7lvkwGaOqDJMM33NfYhsUGUIC5p56BZ8BECqZGwxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKoBgYzHqhDlkV4mpPbaogMBE8U2qIdbg9nJRTjzhwc=;
 b=nbrwAnB0tsT2UmTEJ4u0QgPFHCqrtOZWtu5CnDBBNyNgf5acXgnDA+VR5GTcIs9y+MchmJqWvU1hVlIYpRXflwPrpZspUUi5X0kECqGKBhXVFiciA8dKZ7ipQgyzITc5LuwDn17lHMLqorPobYT7UtBUnVxQAZLrvoKksVVhXOK5Ly+tN4+6rtpJgC9MZ4PwxcxMmsNxxLr9a/9ZQJF913OaAxk7uFQJo9rHj2aH121f5mLhuusZEqvO1/mkyGN5s1L/nxQmx4OV6IaxVas8xZyiqAHnMS1RQg7NkVqfxe5KxeWMQ54U2BQt/drmMuKsSIGJg8CVjdkvue1ZZDANcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKoBgYzHqhDlkV4mpPbaogMBE8U2qIdbg9nJRTjzhwc=;
 b=Ze8Fo0cGzKNx+y1W4ASvshrIRs17mkf7cZwZYgYFhaaFJ+cB/APGWV8yrLqYhNAhKsh5YFNBMpxRiATBI3efW8KiYvMWehR3XGsriFb2vOLgkmO97T/gp75o4VV53iW3vzTKvu5fvW+1eJ1DNF09wwgsVzs+oASRiKmvBYafY7g=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB1180.namprd04.prod.outlook.com (2603:10b6:3:a8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Wed, 5 Jan 2022 09:07:13 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e58a:8ae5:2f73:35ea]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e58a:8ae5:2f73:35ea%9]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 09:07:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "haowenchao@huawei.com" <haowenchao@huawei.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
CC:     "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH v2] ata: libata-scsi: Make __ata_scsi_queuecmd()
 parameters check more clearly
Thread-Topic: [PATCH v2] ata: libata-scsi: Make __ata_scsi_queuecmd()
 parameters check more clearly
Thread-Index: AQHYAgR/hoAs4ZCHBku2P6cyw6EIKaxUCrgAgAATRICAAAU5gA==
Date:   Wed, 5 Jan 2022 09:07:13 +0000
Message-ID: <580d2b82f50c4e1c2cc00a04e7c8bd8a2abba7a8.camel@wdc.com>
References: <20220105202747.1963919-1-haowenchao@huawei.com>
         <ff55e8d2037fa1f11812329fb8da39e746abe878.camel@wdc.com>
         <bbe9581c-1d8e-a1b2-dd5d-60027946941b@huawei.com>
In-Reply-To: <bbe9581c-1d8e-a1b2-dd5d-60027946941b@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2 (3.42.2-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 284b6173-5663-4733-66ee-08d9d02ac37c
x-ms-traffictypediagnostic: DM5PR04MB1180:EE_
x-microsoft-antispam-prvs: <DM5PR04MB1180E634EACB749F11CAE58FE74B9@DM5PR04MB1180.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TxSI47PHsHfYvDPWi1tQqkfdSIrVneLrMzBCN8gHirXv4sHZAXxw774ceR/HqPzGB4ALmJYbhNFgqIBOWly5K4o062UVAJ8/NJRnTnHuq+a+otls8u65ZJ/Qfs09DwgMmRKVvhIcEzr4//yTPRh9I5SN18VoglS9/9UZr5YczYIPI1yUjx0y99iHiYagK1sjGyWI1duwAayaY4Esqa+y8B+WE7SwuYiK9P3EGo89DMj088SJl0Gcg0+JOdBRxvXFiMfPDHdW3DAROOT++UWVp1Y2VuVctEOA/R6HnpXZchUpeHx/rUdfztImMFhyw51R8ES5gz59WvWmRhqWJNPfcLDCwe5g6yg6xmALMjyvIaVypeq3SShvbyX57p9p5xPsmEnC2PNn10LpV5LFmbbYvTi6RNXN208khu2QYDzL1flxwV/QJYEFPLfjlvX3SbfrnobdXDqq2pDzzw4DcJCv8XVwnfYKIRp5rqwJRf/apwjTUEdIKs8nWL0G4JdBVI8Vq42tVioLWD+P8xlz7I4ioEy5Lq1kATg41FYh4R+U7WvjVfqog8dQ+mwxNHIUXdjO02ssm3warnVOzKDISid5SIAVLUrFNCU6zFucRgJK9KD6hcTtino/Abh4MWdqhRaZI1Oy5rLa6FQPsDoUIb0qL9SFjKtYusrPFGf6LrKksmq/Ib4wQJjkFm75C7WFSMj/XqzUzhtQu1JvBbLqELWA+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(316002)(36756003)(91956017)(508600001)(66446008)(64756008)(76116006)(66556008)(66476007)(38100700002)(2616005)(71200400001)(66946007)(82960400001)(2906002)(4326008)(8676002)(6512007)(186003)(8936002)(110136005)(5660300002)(38070700005)(122000001)(6506007)(26005)(53546011)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azhnd0lwUUhVYkJQek9PNHg2d1M1SWhKOXFwNGxza21JNjhwaVB0a3pjVGla?=
 =?utf-8?B?K1RaaHUwRWJXeFliUjJ5RFdMN1d5MGtOSy9tS0d1ZWRVald6VGlvbVVuR2dK?=
 =?utf-8?B?aWl4dndCVGFxL2kwc2ZiQnR0SmlkSWVGMkhMOWRIVytyUWFmVWRjbGZuYThN?=
 =?utf-8?B?OFNrNWxCbE5xMGlWNWl3Szl4b0UydnFTOWJKVHJoY28wUGdubFRObldWN1Q1?=
 =?utf-8?B?RUxnVVo0M2cvSVI5U1JtaGNlSHczQXQzQi9HQzViMzM5S2VQemJweVpLOXk5?=
 =?utf-8?B?VDQwN1MrK0ZMM3Q4OTBMN09HcE5vbFZLLzg4VTZqdTRlNG1JcUgyRXIxT0ZK?=
 =?utf-8?B?RE5MYThDMTZMRk04TS9VTFJvY21rMmNCK0t6K2piQzJsWklhZnVYVUhpQnZ3?=
 =?utf-8?B?cE5WeFBhRHd0L2pEVXB4Q3ZWRHliMnhmSnpxcDQvZnVrSnNPUkljYk5SNGhJ?=
 =?utf-8?B?UytaYXpHVisvR0NHWDFiNU9NZGxhVklpRjFRZkxNL3Zub0gybzFMUE9POVF3?=
 =?utf-8?B?VTNBangyNWxXZU5FMFM1MFhDamFhTDZKVWcxejhtcjdqS3I2U0RYMjZRYlVK?=
 =?utf-8?B?cDBTWW42NzhGQmxjSnE2VExEaVVOR0FaSng0eU5YdE1NVGtuOEd0L1c0VFBN?=
 =?utf-8?B?cmFCSVZpYnNxclB2WlFKVGZVc25wTzJiVkxsaU1leklMekdNWXI1L2VjbDJV?=
 =?utf-8?B?MnJmblowRC91RnlaMXVJK01CWitrREFBRjJXY0M2NE5LWHJkeGo5SzdoSkVH?=
 =?utf-8?B?ZVJVZzBhT2psd2NzOWg1ck1USUFQMHhPSXh3Z09qOWNremQxQmhqOFd4czZL?=
 =?utf-8?B?a3EzR3R4V29ZTHRXUTBvaWRibFJ1cDZKdE9ZSHhZL3EyWUprTDFqcERHb0hk?=
 =?utf-8?B?ejY4MVdPbGFWWVBUNDg1bkx0UG5OOGFRQitudjZYbWdRV3RjMWNEcHNxMk1Y?=
 =?utf-8?B?MVd2bitmMmVMVDVjbUpGOUo2N1pIdTdpUHlTNWp3bkNxdEVkQ0dVUUZpWjRs?=
 =?utf-8?B?MlBmU2lxZEdxeW5jNUljdlRhNGFWVE9IVzAvM3FDQkl3b0NzYTVwN0tUUi9u?=
 =?utf-8?B?c2RpNUVXVmJIbXF0Q0lIeU9pRk5rMlAvb3dZY3lHOHdBUWk2UVNkVG5sM2Rj?=
 =?utf-8?B?bHFVZ3E0M3VQRzNqN1l5TUVDajJNRkJ3cm0yVUY2bnNNejZVWE5ZN0J6Tmo5?=
 =?utf-8?B?V0NaTmRFQm9ZZDZTWHF6WVRrTll5eEZDSndlZUt6azdNSVcxQjMvR2tnVHl2?=
 =?utf-8?B?KzNvRHNCN3ZXL0JEVVB0QWJ0RG1VaDI5SnRSbmx5TkRpQkpuQ2MzaEh4c3NI?=
 =?utf-8?B?ei9SVmJjMmpSUnFRSUQ2S090NWNhc09vMStzRm5iZDR0OWNRYjFYZUQzc2RX?=
 =?utf-8?B?S09iNVpVUzJ4S0hvbGRUZlpKMXpTc0IyQzFNcHQ3K0Y3TWZMaWE1RnY4Z3o1?=
 =?utf-8?B?OFhhNnpiSTQzS2VMbGRFWjM0eFB4L095NDJPQjFhWTh6NkVsakdNVEtDZ1FE?=
 =?utf-8?B?RzFabWw4QkxMUCtDNVRyTDZLelR3bWZNUEU1R1dnc3JSZXFYSEtFZ2tvQ1Vz?=
 =?utf-8?B?ZzY0dG55WXJOallYbzlXV2RMREZBRUNad1RXZFRGWDFiTzNleXdOMUozcHNl?=
 =?utf-8?B?TXZlWkk3TUh1K29uVzIvRzZuQkxSVzI1eXQ5eGxjSEc3b3VPRXd6NU5WSUFN?=
 =?utf-8?B?Skx3MzdQNWVSZVpzeWl4WFdwV2IvVHZlTEVPSGwwaFp2WVNobzZvOWY2NHhS?=
 =?utf-8?B?NkhabW5aY0pjLzdKbFJSekU5TTZ1cmsxR1lBcyt1WmdGM2VFQklZS1lwWlVG?=
 =?utf-8?B?VEd1dTBucnJrY2ZsUklQenV4SkdiSE9XdkpjcDMvNm41aENPYmJwZEptdHl1?=
 =?utf-8?B?U0hSU1VtVjF3MDRMVkpVdWVwVzhUcDBVZnZ0SUtMWE9EemZZc1hUVk5NbXRi?=
 =?utf-8?B?dGNrWDJoYUkzcGRoV2trdTRPMWFnZ3B2SkZ6T2NoVEdTR2kyb3pNV3hkTTZj?=
 =?utf-8?B?ZnF0amRIZ2VXeWFLUzFQcC85RTNEN3VocWdOV3d3K3kwSHdNRFhHeENNT2NL?=
 =?utf-8?B?NGM5NTBoS3dhSXlpV0tUY1VaeVU3bVpUWHBnUnFGV096SlU0djQ1akNqWmln?=
 =?utf-8?B?TG9iM1hSdk9lVkJnT0xHRHZSNmlwTmZ4UG5FT0JCUVdTZ3JQWjR2T2R4N3hF?=
 =?utf-8?Q?eZ4fhupMwXw3hPZgt9xjTg8yFdUjs0AMwNfhsc12FQVR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44D094E3DF7C37449390B800A6EA40CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284b6173-5663-4733-66ee-08d9d02ac37c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 09:07:13.5143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVfRXeMq/gS74mlgJ3hMHNodHML39X1m5Hkgx6hlN+u01m7lh8k1ADoRF+69fqpyC++vBXGvoW6d9oZULdXbfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTA1IGF0IDE2OjQ4ICswODAwLCBXZW5jaGFvIEhhbyB3cm90ZToNCj4g
T24gMjAyMi8xLzUgMTU6MzksIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAy
Mi0wMS0wNSBhdCAxNToyNyAtMDUwMCwgV2VuY2hhbyBIYW8gd3JvdGU6DQo+ID4gPiBUaGlzIGlz
IGp1c3QgYSBjbGVhbiBjb2RlLiBTaW5jZSBlYWNoIGJyYW5jaCBvZiAiaWYiIHN0YXRlIHdvdWxk
IGNoZWNrDQo+ID4gPiBzY21kLT5jbWRfbGVuLCBzbyBtb3ZlIHRoZSBjaGVjayBvZiBzY21kLT5j
bWRfbGVuIG91dCBvZiAiaWYiIHN0YXRlIHRvDQo+ID4gPiBzaW1wbGlmeSBpbnB1dCBwYXJhbWV0
ZXJzIGNoZWNrLg0KPiA+ID4gDQo+ID4gPiBBbmQgcmVtb3ZlIHJlZHVuZGFudCBpbml0IG9mIHhs
YXRfZnVuYyBhdCBoYW5kDQo+ID4gPiANCj4gPiA+IFRoZSBwYXRjaCBkbyBub3QgY2hhbmdlIG9y
aWdpbiBmdW5jdGlvbiBsb2dpYy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogV2VuY2hh
byBIYW8gPGhhb3dlbmNoYW9AaHVhd2VpLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJz
L2F0YS9saWJhdGEtc2NzaS5jIHwgOSArKysrLS0tLS0NCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYXRhL2xpYmF0YS1zY3NpLmMgYi9kcml2ZXJzL2F0YS9saWJhdGEtc2NzaS5j
DQo+ID4gPiBpbmRleCAzMTNlOTQ3NTUwN2IuLmFiOGEyODMzZGZlYyAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvYXRhL2xpYmF0YS1zY3NpLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvYXRhL2xp
YmF0YS1zY3NpLmMNCj4gPiA+IEBAIC00MDIzLDE2ICs0MDIzLDE1IEBAIGludCBfX2F0YV9zY3Np
X3F1ZXVlY21kKHN0cnVjdCBzY3NpX2NtbmQgKnNjbWQsIHN0cnVjdCBhdGFfZGV2aWNlICpkZXYp
DQo+ID4gPiAgIAlhdGFfeGxhdF9mdW5jX3QgeGxhdF9mdW5jOw0KPiA+ID4gICAJaW50IHJjID0g
MDsNCj4gPiA+ICAgDQo+ID4gPiArCWlmICh1bmxpa2VseSghc2NtZC0+Y21kX2xlbikpDQo+ID4g
PiArCQlnb3RvIGJhZF9jZGJfbGVuOw0KPiA+ID4gKw0KPiA+ID4gICAJaWYgKGRldi0+Y2xhc3Mg
PT0gQVRBX0RFVl9BVEEgfHwgZGV2LT5jbGFzcyA9PSBBVEFfREVWX1pBQykgew0KPiA+ID4gLQkJ
aWYgKHVubGlrZWx5KCFzY21kLT5jbWRfbGVuIHx8IHNjbWQtPmNtZF9sZW4gPiBkZXYtPmNkYl9s
ZW4pKQ0KPiA+ID4gKwkJaWYgKHVubGlrZWx5KHNjbWQtPmNtZF9sZW4gPiBkZXYtPmNkYl9sZW4p
KQ0KPiA+ID4gICAJCQlnb3RvIGJhZF9jZGJfbGVuOw0KPiA+ID4gICANCj4gPiA+ICAgCQl4bGF0
X2Z1bmMgPSBhdGFfZ2V0X3hsYXRfZnVuYyhkZXYsIHNjc2lfb3ApOw0KPiA+ID4gICAJfSBlbHNl
IHsNCj4gPiA+IC0JCWlmICh1bmxpa2VseSghc2NtZC0+Y21kX2xlbikpDQo+ID4gPiAtCQkJZ290
byBiYWRfY2RiX2xlbjsNCj4gPiA+IC0NCj4gPiA+IC0JCXhsYXRfZnVuYyA9IE5VTEw7DQo+ID4g
PiAgIAkJaWYgKGxpa2VseSgoc2NzaV9vcCAhPSBBVEFfMTYpIHx8ICFhdGFwaV9wYXNzdGhydTE2
KSkgew0KPiA+ID4gICAJCQkvKiByZWxheSBTQ1NJIGNvbW1hbmQgdG8gQVRBUEkgZGV2aWNlICov
DQo+ID4gPiAgIAkJCWludCBsZW4gPSBDT01NQU5EX1NJWkUoc2NzaV9vcCk7DQo+ID4gDQo+ID4g
RGlkIHlvdSBtaXNzIG15IHJlcGx5ID8NCj4gPiBUaGlzIGNoYW5nZSBpcyBPSywgYnV0IHdoaWxl
IGF0IGl0LCBsZXQncyBjbGVhbnVwIHRoaXMgZnVuY3Rpb24gZnVydGhlci4NCj4gPiBJIHN1Z2dl
c3RlZCBzb21ldGhpbmcgbGlrZSB0aGlzLCB3aGljaCBpbmNsdWRlcyB5b3VyIGNoYW5nZXMuDQo+
ID4gDQo+IA0KPiBNYXliZSBJIG1pc3VuZGVyc3Rvb2QgeW91ciBwcmV2aW91cyByZXBseS4gSSB0
aGluayB5b3UgYXNrIG1lIHRvIGNoYW5nZSANCj4gcHJlZml4Lg0KDQpZZXMsIEkgYXNrZWQgdGhh
dCB0b28uIEl0IGlzIE9LIG5vdy4NCg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEv
bGliYXRhLXNjc2kuYyBiL2RyaXZlcnMvYXRhL2xpYmF0YS1zY3NpLmMNCj4gPiBpbmRleCBhMTZl
ZjAwMzA2NjcuLmVkOGJlNTg1YTk4ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2F0YS9saWJh
dGEtc2NzaS5jDQo+ID4gKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLXNjc2kuYw0KPiA+IEBAIC0z
OTU4LDQyICszOTU4LDM5IEBAIGludCBfX2F0YV9zY3NpX3F1ZXVlY21kKHN0cnVjdCBzY3NpX2Nt
bmQgKnNjbWQsDQo+ID4gc3RydWN0IGF0YV9kZXZpY2UgKmRldikNCj4gPiAgIHsNCj4gPiAgIAl1
OCBzY3NpX29wID0gc2NtZC0+Y21uZFswXTsNCj4gPiAgIAlhdGFfeGxhdF9mdW5jX3QgeGxhdF9m
dW5jOw0KPiA+IC0JaW50IHJjID0gMDsNCj4gPiArDQo+ID4gKwlpZiAodW5saWtlbHkoIXNjbWQt
PmNtZF9sZW4pKQ0KPiA+ICsJCWdvdG8gYmFkX2NkYl9sZW47DQo+ID4gDQo+ID4gICAJaWYgKGRl
di0+Y2xhc3MgPT0gQVRBX0RFVl9BVEEgfHwgZGV2LT5jbGFzcyA9PSBBVEFfREVWX1pBQykgew0K
PiA+IC0JCWlmICh1bmxpa2VseSghc2NtZC0+Y21kX2xlbiB8fCBzY21kLT5jbWRfbGVuID4gZGV2
LT5jZGJfbGVuKSkNCj4gPiArCQlpZiAodW5saWtlbHkoc2NtZC0+Y21kX2xlbiA+IGRldi0+Y2Ri
X2xlbikpDQo+ID4gICAJCQlnb3RvIGJhZF9jZGJfbGVuOw0KPiA+IA0KPiA+ICAgCQl4bGF0X2Z1
bmMgPSBhdGFfZ2V0X3hsYXRfZnVuYyhkZXYsIHNjc2lfb3ApOw0KPiA+IC0JfSBlbHNlIHsNCj4g
PiAtCQlpZiAodW5saWtlbHkoIXNjbWQtPmNtZF9sZW4pKQ0KPiA+IC0JCQlnb3RvIGJhZF9jZGJf
bGVuOw0KPiA+ICsJfSBlbHNlIGlmIChzY3NpX29wICE9IEFUQV8xNiB8fCAhYXRhcGlfcGFzc3Ro
cnUxNikgew0KPiA+ICsJCS8qIHJlbGF5IFNDU0kgY29tbWFuZCB0byBBVEFQSSBkZXZpY2UgKi8N
Cj4gPiArCQlpbnQgbGVuID0gQ09NTUFORF9TSVpFKHNjc2lfb3ApOw0KPiA+IA0KPiA+IC0JCXhs
YXRfZnVuYyA9IE5VTEw7DQo+ID4gLQkJaWYgKGxpa2VseSgoc2NzaV9vcCAhPSBBVEFfMTYpIHx8
ICFhdGFwaV9wYXNzdGhydTE2KSkgew0KPiA+IC0JCQkvKiByZWxheSBTQ1NJIGNvbW1hbmQgdG8g
QVRBUEkgZGV2aWNlICovDQo+ID4gLQkJCWludCBsZW4gPSBDT01NQU5EX1NJWkUoc2NzaV9vcCk7
DQo+ID4gLQkJCWlmICh1bmxpa2VseShsZW4gPiBzY21kLT5jbWRfbGVuIHx8DQo+ID4gLQkJCQkg
ICAgIGxlbiA+IGRldi0+Y2RiX2xlbiB8fA0KPiA+IC0JCQkJICAgICBzY21kLT5jbWRfbGVuID4g
QVRBUElfQ0RCX0xFTikpDQo+ID4gLQkJCQlnb3RvIGJhZF9jZGJfbGVuOw0KPiA+ICsJCWlmICh1
bmxpa2VseShsZW4gPiBzY21kLT5jbWRfbGVuIHx8DQo+ID4gKwkJCSAgICAgbGVuID4gZGV2LT5j
ZGJfbGVuIHx8DQo+ID4gKwkJCSAgICAgc2NtZC0+Y21kX2xlbiA+IEFUQVBJX0NEQl9MRU4pKQ0K
PiA+ICsJCQlnb3RvIGJhZF9jZGJfbGVuOw0KPiA+IA0KPiA+IC0JCQl4bGF0X2Z1bmMgPSBhdGFw
aV94bGF0Ow0KPiA+IC0JCX0gZWxzZSB7DQo+ID4gLQkJCS8qIEFUQV8xNiBwYXNzdGhydSwgdHJl
YXQgYXMgYW4gQVRBIGNvbW1hbmQgKi8NCj4gPiAtCQkJaWYgKHVubGlrZWx5KHNjbWQtPmNtZF9s
ZW4gPiAxNikpDQo+ID4gLQkJCQlnb3RvIGJhZF9jZGJfbGVuOw0KPiA+ICsJCXhsYXRfZnVuYyA9
IGF0YXBpX3hsYXQ7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCS8qIEFUQV8xNiBwYXNzdGhydSwg
dHJlYXQgYXMgYW4gQVRBIGNvbW1hbmQgKi8NCj4gPiArCQlpZiAodW5saWtlbHkoc2NtZC0+Y21k
X2xlbiA+IDE2KSkNCj4gPiArCQkJZ290byBiYWRfY2RiX2xlbjsNCj4gPiANCj4gPiAtCQkJeGxh
dF9mdW5jID0gYXRhX2dldF94bGF0X2Z1bmMoZGV2LCBzY3NpX29wKTsNCj4gPiAtCQl9DQo+ID4g
KwkJeGxhdF9mdW5jID0gYXRhX2dldF94bGF0X2Z1bmMoZGV2LCBzY3NpX29wKTsNCj4gPiAgIAl9
DQo+ID4gDQo+ID4gICAJaWYgKHhsYXRfZnVuYykNCj4gPiAtCQlyYyA9IGF0YV9zY3NpX3RyYW5z
bGF0ZShkZXYsIHNjbWQsIHhsYXRfZnVuYyk7DQo+ID4gLQllbHNlDQo+ID4gLQkJYXRhX3Njc2lf
c2ltdWxhdGUoZGV2LCBzY21kKTsNCj4gPiArCQlyZXR1cm4gYXRhX3Njc2lfdHJhbnNsYXRlKGRl
diwgc2NtZCwgeGxhdF9mdW5jKTsNCj4gPiANCj4gPiAtCXJldHVybiByYzsNCj4gPiArCWF0YV9z
Y3NpX3NpbXVsYXRlKGRldiwgc2NtZCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gDQo+
ID4gICAgYmFkX2NkYl9sZW46DQo+ID4gICAJc2NtZC0+cmVzdWx0ID0gRElEX0VSUk9SIDw8IDE2
Ow0KPiA+IA0KPiA+IERvIHlvdSBzZWUgYW55IHByb2JsZW0gd2l0aCB0aGlzIGNoYW5nZSA/DQo+
ID4gDQo+IA0KPiBUaGlzIGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLiBTaG91bGQgSSBpbmNsdWRl
IHRoaXMgY2hhbmdlIGluIG5leHQgDQo+IHBhdGNoPyBPciB5b3Ugd291bGQgZG8gdGhpcyBieSB5
b3VzZWxmPw0KDQpKdXN0IGluY2x1ZGUgdGhlIGNoYW5nZSBpbiB5b3VyIHYzLCB0aGF0J3MgZmlu
ZS4gQnV0IHRlc3QgcGxlYXNlLiBJIGRpZCB0ZXN0DQp3aGF0IEkgcHJvcG9zZWQgYW5kIGl0IHdv
cmtlZCBmaW5lIGJ1dCBJIHByZWZlciBtb3JlIHRlc3RzLg0KDQpBbmQgZ2l2ZW4gdGhhdCB0aGUg
cGF0Y2ggZG9lcyBtb3JlIHRoYXQganVzdCBjaGFuZ2luZyB0aGUgY29tbWFuZCBjaGVja3MsIG1h
eWJlDQpjaGFuZ2UgdGhlIHBhdGNoIHRpdGxlIHRvIHNvbWV0aGluZyBsaWtlOg0KDQphdGE6IGxp
YmF0YS1zY3NpOiBzaW1wbGlmeSBfX2F0YV9zY3NpX3F1ZXVlY21kKCkNCg0KLS0gDQpEYW1pZW4g
TGUgTW9hbA0KV2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoDQoNCg==
