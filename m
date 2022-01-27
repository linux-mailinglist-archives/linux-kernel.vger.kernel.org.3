Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952C849DC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiA0IC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:02:29 -0500
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:25825
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbiA0IC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:02:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA+WhigqPPBc2fAm8aWf4iOX05l5WM9stp1goP+CscaED0rR8YOHytfai2LNKuCGIzZH826S/ChTuak3+aSZRYrLzIFnN0jQv5nZm+nnlLLfSqJstqlIP9rM5KsCTNRbX9Z0H7Wa8U4M+vyPNXXzKEh+rcs6V9NAQND/auLvB7/CGlwlCc59YmK5WmTqVofGTnQrO3l8w0X4q6IwfivEgVaQWJqwvpQlSgluWmq43J1C7vrFIuiGIAj/MM8yLjD1d/UatPOCB0WfEgoHtkHC+GSgodNPhRuh2OKZLMEnOnI63w/9mV0G4Xw/a8XCPEX0Jpot0vNOd5IleuJt7LcgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P58evo+W/lNASiMvIXHRLdAeO7SXaFV4a3+ZwJY7e+Q=;
 b=kvvGCOJ2pLwisnS9h1DfqwkB1rVoFSnnK1xogc6E4yoTDym+B9jqRJrUUtg+oaEHDZdqPrnUbX1K9zWVgSt7gOQyJSSefA7ro+E1gU8is3uy4OmHJtWovCbuW9O3hkIwi1XOUBpsdjv1DEoyVuT+Cn9qCZoS89qPAYv662rbmRT0P32Z7JPP395O2mDoMFf5kWeIe5D1Kob05snKySQpFpHUiuy+eqT7MmBG1fu4f9nvh75KXuzbIUtjqyRjM67MStkqfh99q6DiIpBc3kNfZM6C1vkEeNqpjKuspQaCjaRuvw3P1tafEErPCjnzjVBshhlMFVQPrMr8f3obQcpx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P58evo+W/lNASiMvIXHRLdAeO7SXaFV4a3+ZwJY7e+Q=;
 b=d7l7WrV3clmkMe/lUSM5rpd0tpuOLAScIkU8UrG4vQOkdoSmuiRSnrnf6ipluA2JRkgVoF94+Ru6PHUXXv/khkRTX+Q6ilZh0QPgZ75G6q7jK38rnORbPKZ8wDgITihOdSddtGWDIfL8dGnoNyR7PmNXp8L9FSiExrzSflNaT1HS5itDEs9NTBjTyyH8EnYDjTIHanW3JVqXZrEY2sBjsoNWI4j3MoowKhKr3QkHRKgPa/AwXl6LWa5WcVWxt7cAro9we40ggu4enFAA5PN4qV8mPc0tTZJgsO+dlyf+bmBWKy4H7vMCaIWK7ehgxpB0yRkQ2j+SfEQaadUJw7VZXg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM6PR12MB3947.namprd12.prod.outlook.com (2603:10b6:5:148::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 08:02:26 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::7948:75c7:913d:cffc]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::7948:75c7:913d:cffc%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 08:02:26 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [v5 PATCH] block: introduce block_rq_error tracepoint
Thread-Topic: [v5 PATCH] block: introduce block_rq_error tracepoint
Thread-Index: AQHYEuXPvoXm9IP25kGhfA28vBLh66x2gqSA
Date:   Thu, 27 Jan 2022 08:02:26 +0000
Message-ID: <8de293cb-168b-5a52-3791-dba36ef4217d@nvidia.com>
References: <20220126185153.417948-1-shy828301@gmail.com>
In-Reply-To: <20220126185153.417948-1-shy828301@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de4881a3-9066-4815-bef3-08d9e16b5b78
x-ms-traffictypediagnostic: DM6PR12MB3947:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3947CB9042C5503A67E5B829A3219@DM6PR12MB3947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tEMhscuuOFhshhJvC9DMB98IKLwVIwNVMlPVqKBJrIkQRwq4Ju4Jb8r3NHswGKj8JUiFocSn8z6ataYPeH5YS7CEujFPFLlxjKai26Uw/eocmy5Md1EkXlIUd/vg2DsH6Ge13zX2eVNQXhPFm6TSbtFygTCpAZ4UdiqX5RHrTAHWyPVvvwKhUMtdqqI25mjnCh3tRIbz8vHgwopGjwnIWEoX8b2SI0D3MVp356BtRqCN0XgiZhAhBIDynCPw0+nLj/BOmeWQcI+DSexcWvV199lfYAeSYvQtVJnt0W+YfjFoj12kaE20Gzba85RRYkcUPHTar9F5JSut53Ct4hB8E3mavpmKBASZQFy68jG2uh2CPh2KaDFpEnYKcv3mNyi6wlQSbge3hb32PyE4juKeLZgnkZNhNBmwdyc1iMmoCDyOd++2R1GJK9W1TQl7uqLZ7Ui13cdB0APwCIlaadEK7OlCqavRtuidsKyTAxcpYnjdMnzpQQItvihZTYOenRFi4u5Y95j+6HKwKu2M+OaW4TKzKTpUwkyI4PVauOqbJ0v2HeYB9a2JRGNAhINed4lyFuuVsd0K3chM/+uOMAckq3DcdIBWED4/H1Yjsgsy0EaLYbOiHlRNF8PxNuhTp7E/TR4dBkO/FWtI3oqMKLzO/npUT49L63wXYnS/Nb7Q7swBjV810oi9nCfbaJEZ2P+Twp8U3VC94VQ4C7VAfKLe1Jn36WpLyi3sxorJkQnHs400cZmyKAaDRQRn3KofGGQzTga6FBBU045QxCcdvobAWoi6T+5yaj1o0kfnQwVOTmqGKhdMiCFmNaq+9Tlo2eNx70lk8TdVKOkJHLey1Lx3EhE9/+6ZDu45DdteaHv13zc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2616005)(86362001)(38100700002)(6506007)(110136005)(54906003)(508600001)(5660300002)(31696002)(316002)(2906002)(31686004)(186003)(83380400001)(6512007)(966005)(66446008)(91956017)(66476007)(66556008)(76116006)(4326008)(8676002)(8936002)(66946007)(64756008)(122000001)(53546011)(71200400001)(6486002)(38070700005)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDhMZDV3VmhzMUs5dzBneFVWKzJ0TFZ0aEhyNmNGWDArcDRCKzQybXphdHEw?=
 =?utf-8?B?ZWdpaW45VHNmVWdmcGs1QmVjbllITCtZcHNGQWJ3dmVlU3V3Y3Jpc0tneHlR?=
 =?utf-8?B?cU1iSmxiSnBNM0pobXZJSzg2bUxRODNMM3UxTzJycC9DbndBb25aUllUZGMw?=
 =?utf-8?B?YzV0VVpXbTNqSno3SkEyZWIybmxLTGxUTjJkTXFuM2ptVVJHY1ZYdlR0RU5W?=
 =?utf-8?B?MndIOE5EQ0hkVzluWjVYTW9neDZLTnl4SkJzZEhCd2c1OXMvQUlOcUY0alhX?=
 =?utf-8?B?c24yclJMQWlmSFIvR3RHZGMyN0YzRmp0SzhaZjY3QVp5K1hMbXRFaFpaOVgx?=
 =?utf-8?B?QzNvREdjVHBYVUZTZE44YzRuZThxU2lPeTdLamZOSGhNQmRjQStiT3JZZzBa?=
 =?utf-8?B?Rndad29GYXVURTF4clc1bjhlVnhPZk8zdVYxMVhZRkVRcnYwZnF0dnpWZEFm?=
 =?utf-8?B?RWk5MVV2d3o2ZTIzMVo4NkRiMkJET0E0MnlBTmc3NnBpR0g4Rmpkbzh5VXNV?=
 =?utf-8?B?MENYVmR2WG9IK1NiTnU5OWtrajc4SVRtZ2dHTVViYlE3WGx3eVNuTVUwWW9x?=
 =?utf-8?B?RVQwY3daOG1EMmZ4QlFNRURWZDVPZGhmWmZUUTYvWUdrVEhtZkFIeDF6SEU1?=
 =?utf-8?B?Rlp3anp3U1FQRWZCK241RmF2anM0RlFSQnAxVXRBeDVxeXBQYTZtVTExU0Nw?=
 =?utf-8?B?Y25sMFZSMGFsZ2p5ekUrcTdzSUtjc2Z6T3FXTXpoZWNxdk12eFRpOEU3dU9B?=
 =?utf-8?B?RS9OYS85UnpBckVpUS9NcDFxdmQwODZtZmRBK2NGS1Fsalp3Z0UrVDNyeDQ1?=
 =?utf-8?B?SG45cGtpRVlHMy9XR2hRMS9QbmE4YlBVcHRyTmVXb3RIU2U5K1ROSHI4M0RM?=
 =?utf-8?B?MDVvVW9ud2UrSmQrY1liaUdWUTBIUVVudDNibkRrbmt3NXhkUGk4NTJYRjNm?=
 =?utf-8?B?azA3VVRBcHArb0paVndSaW5nV2xtVE84TUtVNU5jSitHeUpzL3llMnVRRm9Q?=
 =?utf-8?B?end3YjVIb0VKazAzT1dRdFBzUGU2TjhnOWU0QVhtTit3NHZIZ2J4VGxKUDhP?=
 =?utf-8?B?T1NCWnNsTnVlVEkwZmcvZkJqdjVoL2dnM0VBV09HdE5xT3VpRHZiUkFvUVFP?=
 =?utf-8?B?QmlyVWN2MnFUanV2eUlLWG5vbVlWcThIOFJmSjVsRW42WEs3cnpheTRZTjFX?=
 =?utf-8?B?R3AyM2l0NWtQb0h4bFhmWVkyUWIrZWtoWEtnWnMvd2VBU1VLRzh5YlRadlVR?=
 =?utf-8?B?SkxBZnh6UzhoUUNxNnpwckdwTk1TTmxnMmxkMGlNdTJuVGxtYjBQTHVib0dk?=
 =?utf-8?B?azdRSlRJR0xibUQzSGh2bkZvNnhIdlNxSzBkakJTWFRHT2dPN1pxbFdSaWJq?=
 =?utf-8?B?dExtS3ZxUXFqUVVtWDZFcldvN0dnalN6c20zTDVKN3dTbVlGZyt3WUkzNFFj?=
 =?utf-8?B?OEJZOEJQQTcxZDBXZi94RWhEdE5BQkJOeHBFSTBQcml1OTNzZTFQYXg5S0Nx?=
 =?utf-8?B?WGduZ3lWMmMvazUwOXZ0czRodkoxQ1JHR2tsSGo5QjB4S3dlbU13bTZJNkNt?=
 =?utf-8?B?QmpvS1pIMzhUM1VCRGloempnUkk2aHhEVGVsQ2NhRnVXTzN0aUN0TXFaUmI0?=
 =?utf-8?B?c2ZrOFlFV2FRUTc1SnY5RmFKbjBIQ0lUSis1aHppdFQ1ak1VZkt4K3RkNmRW?=
 =?utf-8?B?bXhnYlQzOEhveitiZlgreGxuL3l6U3dSVWp5TVh5aTVPZ1AvMllYbjcrMExs?=
 =?utf-8?B?WWZiT2RDc2ZCTW5sVkxmeTExOWh3bUkvWGQyd3BsN01pSWhpd091Wjk1SVlG?=
 =?utf-8?B?YWFtNjdMMytvUWRnRlFabThrUXVXUkpXRlcvS0xrY0VGSktNRTlKMGFCOExX?=
 =?utf-8?B?VnNWVnNnTFp0cGVkMVdFRVcrQjdVdHhMTURvWEFjR2NUdWl3bjRYK2s3S1J5?=
 =?utf-8?B?Vk92OExTcEJnbWlIWHozUi9wZzdSbHBSbVl2SzNtd3JTeGduQTdYQ0dRUjhZ?=
 =?utf-8?B?U2ptaFR0ZTdFMDhUSHJJV1FadVg0RUZnUW9OUWQ0SzZBQWRSQ3FhZGZCZzd5?=
 =?utf-8?B?R2k1OElaenFpMEpZbU9VQ0hEVzhibExralZOZGIzN0MrQWRKVStyTzg5a2VK?=
 =?utf-8?B?dXVVKzZYNG1jN3lPakQ2Y2E4Y3ZHaXN3Q09lbU8yMGY1cGFHdllyb0ZiQ3JX?=
 =?utf-8?Q?2iaInxfIdV+QtOcP79DnkVN0ONHPYLU008BnfGmXKp8P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4997EB8CDFDEF34E9A6D7D3D58DA9D80@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4881a3-9066-4815-bef3-08d9e16b5b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 08:02:26.1244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veQWMd4s7e4NwVnnNjPGJobQ+BX1sFoJWiVQ1nCWgki/tEMe7wPELqn54Bd8TeORlxNVwbN5N/EsyCNuqnZqIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNi8yMiAxMDo1MSBBTSwgWWFuZyBTaGkgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gQ3VycmVu
dGx5LCByYXNkYWVtb24gdXNlcyB0aGUgZXhpc3RpbmcgdHJhY2Vwb2ludCBibG9ja19ycV9jb21w
bGV0ZQ0KPiBhbmQgZmlsdGVycyBvdXQgbm9uLWVycm9yIGNhc2VzIGluIG9yZGVyIHRvIGNhcHR1
cmUgYmxvY2sgZGlzayBlcnJvcnMuDQo+IA0KPiBCdXQgdGhlcmUgYXJlIGEgZmV3IHByb2JsZW1z
IHdpdGggdGhpcyBhcHByb2FjaDoNCj4gDQo+IDEuIEV2ZW4ga2VybmVsIHRyYWNlIGZpbHRlciBj
b3VsZCBkbyB0aGUgZmlsdGVyaW5nIHdvcmssIHRoZXJlIGlzDQo+ICAgICBzdGlsbCBzb21lIG92
ZXJoZWFkIGFmdGVyIHdlIGVuYWJsZSB0aGlzIHRyYWNlcG9pbnQuDQo+IA0KPiAyLiBUaGUgZmls
dGVyIGlzIG1lcmVseSBiYXNlZCBvbiBlcnJubywgd2hpY2ggZG9lcyBub3QgYWxpZ24gd2l0aCBr
ZXJuZWwNCj4gICAgIGxvZ2ljIHRvIGNoZWNrIHRoZSBlcnJvcnMgZm9yIHByaW50X3JlcV9lcnJv
cigpLg0KPiANCj4gMy4gYmxvY2tfcnFfY29tcGxldGUgb25seSBwcm92aWRlcyBkZXYgbWFqb3Ig
YW5kIG1pbm9yIHRvIGlkZW50aWZ5DQo+ICAgICB0aGUgYmxvY2sgZGV2aWNlLCBpdCBpcyBub3Qg
Y29udmVuaWVudCB0byB1c2UgaW4gdXNlci1zcGFjZS4NCj4gDQo+IFNvIGludHJvZHVjZSBhIG5l
dyB0cmFjZXBvaW50IGJsb2NrX3JxX2Vycm9yIGp1c3QgZm9yIHRoZSBlcnJvciBjYXNlDQo+IGFu
ZCBwcm92aWRlcyB0aGUgZGV2aWNlIG5hbWUgZm9yIGNvbnZlbmllbmNlIHRvby4gV2l0aCB0aGlz
IHBhdGNoLA0KPiByYXNkYWVtb24gY291bGQgc3dpdGNoIHRvIGJsb2NrX3JxX2Vycm9yLg0KPiAN
Cj4gQ2M6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gQ2M6IENocmlzdG9waCBIZWxs
d2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IFN0ZXZlbiBSb3N0ZWR0IDxy
b3N0ZWR0QGdvb2RtaXMub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBDb25nIFdhbmcgPHhpeW91Lndh
bmdjb25nQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBTaGkgPHNoeTgyODMwMUBn
bWFpbC5jb20+DQo+IC0tLQ0KPiBUaGUgdjMgcGF0Y2ggd2FzIHN1Ym1pdHRlZCBpbiBGZWIgMjAy
MCwgYW5kIFN0ZXZlbiByZXZpZXdlZCB0aGUgcGF0Y2gsIGJ1dA0KPiBpdCB3YXMgbm90IG1lcmdl
ZCB0byB1cHN0cmVhbS4gU2VlDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDAy
MDMwNTM2NTAuODkyMy0xLXhpeW91Lndhbmdjb25nQGdtYWlsLmNvbS8uDQo+IA0KPiBUaGUgcHJv
YmxlbXMgZml4ZWQgYnkgdGhhdCBwYXRjaCBzdGlsbCBleGlzdCBhbmQgd2UgZG8gbmVlZCBpdCB0
byBtYWtlDQo+IGRpc2sgZXJyb3IgaGFuZGxpbmcgaW4gcmFzZGFlbW9uIGVhc2llci4gU28gdGhp
cyByZXN1cnJlY3RlZCBpdCBhbmQNCj4gY29udGludWVkIHRoZSB2ZXJzaW9uIG51bWJlci4NCj4g
DQo+IHY0IC0tPiB2NToNCj4gICAqIFJlcG9ydCB0aGUgYWN0dWFsIGJsb2NrIGxheWVyIHN0YXR1
cyBjb2RlIGluc3RlYWQgb2YgdGhlIGVycm5vIHBlcg0KPiAgICAgQ2hyaXN0b3BoIEhlbGx3aWcu
DQo+IHYzIC0tPiB2NDoNCj4gICAqIFJlYmFzZWQgdG8gdjUuMTctcmMxLg0KPiAgICogQ29sbGVj
dGVkIHJldmlld2VkLWJ5IHRhZyBmcm9tIFN0ZXZlbi4NCj4gDQo+ICAgYmxvY2svYmxrLW1xLmMg
ICAgICAgICAgICAgICB8ICA0ICsrKy0NCj4gICBpbmNsdWRlL3RyYWNlL2V2ZW50cy9ibG9jay5o
IHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYw0KPiBpbmRleCBmM2JmMzM1OGEzYmIu
LjRjYTcyZWE5MTdkNCAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmxrLW1xLmMNCj4gKysrIGIvYmxv
Y2svYmxrLW1xLmMNCj4gQEAgLTc4OSw4ICs3ODksMTAgQEAgYm9vbCBibGtfdXBkYXRlX3JlcXVl
c3Qoc3RydWN0IHJlcXVlc3QgKnJlcSwgYmxrX3N0YXR1c190IGVycm9yLA0KPiAgICNlbmRpZg0K
PiANCj4gICAgICAgICAgaWYgKHVubGlrZWx5KGVycm9yICYmICFibGtfcnFfaXNfcGFzc3Rocm91
Z2gocmVxKSAmJg0KPiAtICAgICAgICAgICAgICAgICAgICAhKHJlcS0+cnFfZmxhZ3MgJiBSUUZf
UVVJRVQpKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgIShyZXEtPnJxX2ZsYWdzICYgUlFGX1FV
SUVUKSkpIHsNCj4gKyAgICAgICAgICAgICAgIHRyYWNlX2Jsb2NrX3JxX2Vycm9yKHJlcSwgZXJy
b3IsIG5yX2J5dGVzKTsNCj4gICAgICAgICAgICAgICAgICBibGtfcHJpbnRfcmVxX2Vycm9yKHJl
cSwgZXJyb3IpOw0KPiArICAgICAgIH0NCj4gDQo+ICAgICAgICAgIGJsa19hY2NvdW50X2lvX2Nv
bXBsZXRpb24ocmVxLCBucl9ieXRlcyk7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90cmFj
ZS9ldmVudHMvYmxvY2suaCBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL2Jsb2NrLmgNCj4gaW5kZXgg
MjcxNzBlNDBlOGM5Li45MThiMTkwNzE4ZDUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvdHJhY2Uv
ZXZlbnRzL2Jsb2NrLmgNCj4gKysrIGIvaW5jbHVkZS90cmFjZS9ldmVudHMvYmxvY2suaA0KPiBA
QCAtMTQ0LDYgKzE0NCw0NyBAQCBUUkFDRV9FVkVOVChibG9ja19ycV9jb21wbGV0ZSwNCj4gICAg
ICAgICAgICAgICAgICAgIF9fZW50cnktPm5yX3NlY3RvciwgX19lbnRyeS0+ZXJyb3IpDQo+ICAg
KTsNCj4gDQo+ICsvKioNCj4gKyAqIGJsb2NrX3JxX2Vycm9yIC0gYmxvY2sgSU8gb3BlcmF0aW9u
IGVycm9yIHJlcG9ydGVkIGJ5IGRldmljZSBkcml2ZXINCj4gKyAqIEBycTogYmxvY2sgb3BlcmF0
aW9ucyByZXF1ZXN0DQo+ICsgKiBAZXJyb3I6IHN0YXR1cyBjb2RlDQo+ICsgKiBAbnJfYnl0ZXM6
IG51bWJlciBvZiBjb21wbGV0ZWQgYnl0ZXMNCj4gKyAqDQo+ICsgKiBUaGUgYmxvY2tfcnFfZXJy
b3IgdHJhY2Vwb2ludCBldmVudCBpbmRpY2F0ZXMgdGhhdCBzb21lIHBvcnRpb24NCj4gKyAqIG9m
IG9wZXJhdGlvbiByZXF1ZXN0IGhhcyBmYWlsZWQgYXMgcmVwb3J0ZWQgYnkgdGhlIGRldmljZSBk
cml2ZXIuDQo+ICsgKi8NCj4gK1RSQUNFX0VWRU5UKGJsb2NrX3JxX2Vycm9yLA0KPiArDQo+ICsg
ICAgICAgVFBfUFJPVE8oc3RydWN0IHJlcXVlc3QgKnJxLCBibGtfc3RhdHVzX3QgZXJyb3IsIHVu
c2lnbmVkIGludCBucl9ieXRlcyksDQo+ICsNCj4gKyAgICAgICBUUF9BUkdTKHJxLCBlcnJvciwg
bnJfYnl0ZXMpLA0KPiArDQo+ICsgICAgICAgVFBfU1RSVUNUX19lbnRyeSgNCj4gKyAgICAgICAg
ICAgICAgIF9fZmllbGQoICBkZXZfdCwgICAgICAgIGRldiAgICAgICAgICAgICAgICAgICAgICkN
Cj4gKyAgICAgICAgICAgICAgIF9fc3RyaW5nKCBuYW1lLCAgICAgICAgIHJxLT5xLT5kaXNrID8g
cnEtPnEtPmRpc2stPmRpc2tfbmFtZSA6ICI/IikNCj4gKyAgICAgICAgICAgICAgIF9fZmllbGQo
ICBzZWN0b3JfdCwgICAgIHNlY3RvciAgICAgICAgICAgICAgICAgICkNCj4gKyAgICAgICAgICAg
ICAgIF9fZmllbGQoICB1bnNpZ25lZCBpbnQsIG5yX3NlY3RvciAgICAgICAgICAgICAgICkNCj4g
KyAgICAgICAgICAgICAgIF9fZmllbGQoICBpbnQsICAgICAgICAgIGVycm9yICAgICAgICAgICAg
ICAgICAgICkNCj4gKyAgICAgICAgICAgICAgIF9fYXJyYXkoICBjaGFyLCAgICAgICAgIHJ3YnMs
ICAgUldCU19MRU4gICAgICAgICkNCj4gKyAgICAgICApLA0KPiArDQo+ICsgICAgICAgVFBfZmFz
dF9hc3NpZ24oDQo+ICsgICAgICAgICAgICAgICBfX2VudHJ5LT5kZXYgICAgICAgPSBycS0+cS0+
ZGlzayA/IGRpc2tfZGV2dChycS0+cS0+ZGlzaykgOiAwOw0KPiArICAgICAgICAgICAgICAgX19h
c3NpZ25fc3RyKG5hbWUsICAgcnEtPnEtPmRpc2sgPyBycS0+cS0+ZGlzay0+ZGlza19uYW1lIDog
Ij8iKTsNCg0KRGlkIHlvdSB2ZXJpZnkgdGhhdCBycS0+cS0+ZGlzayBOVUxMIGNoZWNrcyBhcmUg
bXVzdCBpbiB0aGlzIGNoZWNrb3V0DQpmb3IgYmxrX3VwZGF0ZV9yZXF1ZXN0KCkgPw0KDQo+ICsg
ICAgICAgICAgICAgICBfX2VudHJ5LT5zZWN0b3IgICAgPSBibGtfcnFfcG9zKHJxKTsNCj4gKyAg
ICAgICAgICAgICAgIF9fZW50cnktPm5yX3NlY3RvciA9IG5yX2J5dGVzID4+IDk7DQo+ICsgICAg
ICAgICAgICAgICBfX2VudHJ5LT5lcnJvciAgICAgPSBibGtfc3RhdHVzX3RvX2Vycm5vKGVycm9y
KTsNCj4gKw0KPiArICAgICAgICAgICAgICAgYmxrX2ZpbGxfcndicyhfX2VudHJ5LT5yd2JzLCBy
cS0+Y21kX2ZsYWdzKTsNCj4gKyAgICAgICApLA0KPiArDQo+ICsgICAgICAgVFBfcHJpbnRrKCIl
ZCwlZCAlcyAlcyAlbGx1ICsgJXUgWyVkXSIsDQo+ICsgICAgICAgICAgICAgICAgIE1BSk9SKF9f
ZW50cnktPmRldiksIE1JTk9SKF9fZW50cnktPmRldiksDQo+ICsgICAgICAgICAgICAgICAgIF9f
Z2V0X3N0cihuYW1lKSwgX19lbnRyeS0+cndicywNCg0KU2luY2UgcHJpbnRpbmcgbWFqb3IgbnVt
YmVyIGFuZCBtaW5vciBudW1iZXIgaXMgc3VmZmljaWVudCB0byBpZGVudGlmeQ0KdGhlIGJsb2Nr
IGRldmljZS4gV2UgZG9uJ3QgaGF2ZSBhIG5vdGlvbiBvZiBwcmludGluZyBkaXNrX25hbWUgZm9y
IHRoZQ0KYmxvY2sgdHJhY2Vwb2ludHMgd2hhdCBtYWtlcyB0aGlzIHRyYWNlcG9pbnQgc3BlY2lh
bCA/DQoNCj4gKyAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcgbG9uZylfX2VudHJ5LT5z
ZWN0b3IsDQo+ICsgICAgICAgICAgICAgICAgIF9fZW50cnktPm5yX3NlY3RvciwgX19lbnRyeS0+
ZXJyb3IpDQo+ICspOw0KPiArDQo+ICAgREVDTEFSRV9FVkVOVF9DTEFTUyhibG9ja19ycSwNCj4g
DQo+ICAgICAgICAgIFRQX1BST1RPKHN0cnVjdCByZXF1ZXN0ICpycSksDQo+IC0tDQo+IDIuMjYu
Mw0KPiANCg0K
