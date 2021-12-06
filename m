Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EC9468FB9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhLFDhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:37:37 -0500
Received: from mail-sgaapc01on2093.outbound.protection.outlook.com ([40.107.215.93]:33633
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236194AbhLFDhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:37:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7f3nmgDy8vBC8eDUsO4MQBmmyL+pBsC1Jq1ZuxBzwQNSCVNwqcx2q2sPhY1SM+05+KtRMkxvvrSgV9EKkwIGVfjZOdZDH9ZyszDxbeoVOK4V6htwATZzqU0VFPZMyJdcADYckURDDby1uMq84icibJwS5m9ITimbH4NwWLKux6i7rIkqmlCD13QgM1hUFHStfMLHb52qD1cIOm/aarkVCN4WOND2m7Mb8LDEN4GBWQ+951gP8R3rGSMQ+O+w78BJ1qJYQiN69OD396KpC5Awp6wYC0DutgbnO0HQF3bn9IcGm5nqqU7fgMyvkgYL8917d9j9m3JyVvWlfd/ABLKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FvNcCU+hrhsbvuLIimmGQtEGPlfquaBLo62lh2hPZI=;
 b=kSiRaKXkpMHkqIdk+dCbO+uSaDFjEUCxKJIPbmCLhLj8CKQHmuhkB/EuHJCusnvdtDSaCRXhjJCuF5frKw9oH6km6L6inivg9fr4ubZhoRrbPda3ycfIlhaBF5v0C0FPrX0lGBU9ieuI4HRDPHJnd/sSIZSQVo9zdHgYcewd4zOp4P/Kj7bk6EWBX22cD46/xdaYuY+smdFXmY88SL5Z+WfRdz0SlgZ8We0qQ8F+14HU3a5QXKKwz0mnikdDBVcS7zmHusOKsGEnaehoGQ6y9cg6IVtiRL1iHZ3TheBWeHqaZtvmNNaxCiAUqFuR5cP9dEnw5QfSosTopUcxDpI9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FvNcCU+hrhsbvuLIimmGQtEGPlfquaBLo62lh2hPZI=;
 b=VSxYblOsp3jw+R3+0Wy6hpNbRhQc4VB1b1JbYLxqfdtHCQqTZHdi30q/hAaWmdYwymSLKycI5q+L7A8urWyuWbvVv3YRWV5tpTf/Nz1LzD1yFEHHiG5GuMO/RIONUtSctDTeehNNqVnVGw3VHqEzzyyxqrqW/sI4OF6aHmrYV3A=
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by PS1PR06MB2711.apcprd06.prod.outlook.com (2603:1096:803:4c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 6 Dec
 2021 03:34:04 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 03:34:04 +0000
From:   =?utf-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHNlY3VyaXR5L3NlbGludXg6IGZpeCBwb3RlbnRp?=
 =?utf-8?Q?al_memleak_in_error_branch?=
Thread-Topic: [PATCH] security/selinux: fix potential memleak in error branch
Thread-Index: AQHX5ypqv7rsdJXbLkWF7AGkgoc2OKwk0soAgAABhTA=
Date:   Mon, 6 Dec 2021 03:34:04 +0000
Message-ID: <PSAPR06MB402140ACDA39DC45C71880C1DF6D9@PSAPR06MB4021.apcprd06.prod.outlook.com>
References: <20211202031209.253228-1-bernard@vivo.com>
 <AI*AZgDuE3c1hmFv16p8r4qS.9.1638760990602.Hmail.bernard@vivo.com.@PENBSEM5VmhUNXRzMkF4K1BRMGhWNDhHek4teHBob2dmWk5Td0U5N0szLXRVWlM2MEJMd0BtYWlsLmdtYWlsLmNvbT4=>
In-Reply-To: <AI*AZgDuE3c1hmFv16p8r4qS.9.1638760990602.Hmail.bernard@vivo.com.@PENBSEM5VmhUNXRzMkF4K1BRMGhWNDhHek4teHBob2dmWk5Td0U5N0szLXRVWlM2MEJMd0BtYWlsLmdtYWlsLmNvbT4=>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2e7a847-8a68-47f6-6abd-08d9b869408d
x-ms-traffictypediagnostic: PS1PR06MB2711:
x-microsoft-antispam-prvs: <PS1PR06MB2711B6E5C06BEA809947B364DF6D9@PS1PR06MB2711.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFf03W6/CPr95zsdlGpY65lUBtrHmydWC1LBjE6QXw82gNPqtWBDHAUDg0WmIJqo9qAONXeIz7o90IzGXqOu7by6DXJEbP7kQNUK7wtfNKd4rAmBQ8w9N4tzCSJW5qQVH+qVIklJTdURhtb+iJTASqKB3X7QrUEE5jPsswmwFtewNR30VVp+nPh0counwJFUurZ0OqeyXocf/fl4/YVkC5xLSwmMBf0hOp15jDlBQ/9Gr5X5Z9khFHPl7XII7P/HRyqbrcPLaFx/TxdwZRko4Fj7VRVEgqpMgyP3lxbGztQo9L9WaLFd0xHAhdJrVjrzHPUR4aCn2fDkJTm/HEkn6ldfp0y5Oep9+2eD29zWn1eRXSvmfTYk1izIvTOdUEWdCg2donoq2A/3eWI91MrLmR/WBBIlJFDJiWyjQpa485jl0+0OYpcwhtxW9SjeJgVfMUCwisQHMnB5ZjwNUfqz0awWcmsbgf63yk8j9c6eaSLl6FupC4Tp7dfeP//Z+6Hen1qxyFdztpVn+u1eljKtrbRbXL6rFkCNzq0CAaEZbFi+nEMlPXiIorO5VX1PTDJHHUKIcFtIt7a4wvECH0U5RuThMCx0TBtFpByLD5eB3RIswg5cx/bBpWlGxQG3Q2RI58xtIPw3BRthBq0mjL/XTezzj1cTtpVyvj6ZYMdcObdvt3IFZWZZsyiqMgrhUnyzxyDibjpv7qH3c/d7O3BRzFFYOMdZKYKYvQtRWd3F8Adv7IsAjVDvfER7JJO1CtzmNsmc1CEENRKakNWUGSd6vPoZ5MYvnGLlOdf79ybnrSUlkeNuY/oBtKTWgUQ58unI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(38070700005)(55016003)(85182001)(83380400001)(9686003)(508600001)(186003)(6506007)(53546011)(5660300002)(26005)(6916009)(15650500001)(66556008)(66476007)(66446008)(52536014)(15974865002)(4326008)(86362001)(64756008)(76116006)(66946007)(33656002)(8936002)(7696005)(71200400001)(224303003)(2906002)(38100700002)(316002)(122000001)(18886075002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW9xRyswc0NlK2M1VHpnZDFtYWhUaEcvcUtYbVpzcXN6dmJXVkdhdUJhZ1NZ?=
 =?utf-8?B?ZHFsL3BlQVladC9WZkMzMEttQUdoVjRCb2RMdzFzbkNQbjFkVHRKY21nMXJD?=
 =?utf-8?B?Mkx4dmt6SnFHS0dkU0R2dWtzZExYZUVHanVYTVM4YmhZQXEyUHdhTG5zaUts?=
 =?utf-8?B?RDFNbjJFd1J4TFM4YTdKNnRRL2cxa2pKMjZjaHRSaHU1b2k4VDduMlpYUjlo?=
 =?utf-8?B?RUgrS1BSNkJnLzJMS2p4a0dPTEgvRFlSWVNxVmluWkpRQiswU0hrRUtNa01X?=
 =?utf-8?B?SklFcDkwNXM0NG8xS3lLTllHdC8wWDR6T1hqQmRURlkxTFAwdXI0by9Rb0VE?=
 =?utf-8?B?enFKd3l4NVA1ejd4UVZVUmJ1QmdWNDBIdCtaV29XMStKTU96M0RBdkRmRXlp?=
 =?utf-8?B?ZmIyN042MkRyZ1RIUHlYZkRleW5ZTnlSMjRiVHpxZHFNcUY5MnBJdnFYa0wx?=
 =?utf-8?B?L2xHNUMzK3ZHNFB1UTJvL0hoYU44d01kSkFIMi9sZUt5V00vMmMwMlVrU0Rp?=
 =?utf-8?B?d01zUlFRMEd6Zks4WFdzME43L0xRNStIL1NRZVdqVkxuWDVQMlhkZjRnOHVh?=
 =?utf-8?B?VmNoQWZpaHM1a041dFFWZlpLWEhvMVoweHQwZ3p4d2lrSHlscS8zMlZzMk1r?=
 =?utf-8?B?K0VQZTBieTZPRVkvNWI3QVFIOW0vcjhwNytIOGRHSUVvV3BkcExXNlduNFRZ?=
 =?utf-8?B?RDFHYllNVWhQT2VqblFDeWFJOGZHNysxNFBiZ01NME8yS08wd0NDd3RUWjdr?=
 =?utf-8?B?RVJEMVJNb09ad2V0eWpqbU9CSitnWU9GUUV3WGpnaXFCOStEa0JqTW1JTTFp?=
 =?utf-8?B?VWw1bWFkVWM2VWdJejJvTmhRN3lLR0ppZVk0V0lJYVJUWHpJQnJldU5XYkt6?=
 =?utf-8?B?Y3pUdm02RkZWRDVJNDFacld0elFKZnI3VXlLdHVpV3JWTC9RdWdTQ1NqVDcx?=
 =?utf-8?B?SW1Ualh0a0dQell2OWRvbUZvVitWNlIxL1FFT1o4ZGptU0NqdGduVlRKM1Fh?=
 =?utf-8?B?VXdJdCtXbGlQdzRwT0pROEFUdExEOVpZRWNsSkpYMGN2bTNteVNoUXgyTldR?=
 =?utf-8?B?WmcwMkQ4Snl3djVDR0ZiU2EyY1V6ZVkzaVArUEdCS2NJbDZJM2VLUjZCVGl6?=
 =?utf-8?B?VllUVXRxbWRtcHQ2cDBMSnNscVkreERYbEp0TzhlQzhoMjMwVS9PMFMyc2or?=
 =?utf-8?B?cVM3SWpMR1A1TFBHVEtIdkxKS1l2YVRnNDB5Q05rTXIvUC9OaWtLOENzRGMr?=
 =?utf-8?B?eGphVHZhNTJjWXVmbkx6UGpUVVZJN1ZxbDJIc1NDSGszc2dwLzRlOTdvRmd1?=
 =?utf-8?B?YnQ3cmo0SXVnMndua3pmWlN3S1NWVDgzT2xVR1lCc2NOc1RQb2U5S2JpWHVx?=
 =?utf-8?B?UE41QnZ3U1QydFZ5aDcwTHY4UDlFL2ZPM0ZSaFg0NUUrcDRHWUtKdk50MG5K?=
 =?utf-8?B?WFczWDhjWDF3M1JWMkN4L1JFQ3dQRE9OUnNNVUVnOTRVZkRSa3N6QTIxWDhZ?=
 =?utf-8?B?Q213VHFuL1M1eEdtaVpKUTI4QlljdnhXamtyQ3F3L2R0VWw2dy9DM1VMbDkz?=
 =?utf-8?B?bkdSR2J2TndmOGQwZXdqSXlFaGt3NmZDNW1ET2FUam5rM3p1WU9TQlEvSGJ5?=
 =?utf-8?B?WktuVHZMMERSSk8zWkFmRmpwV2F3RTRJVEZLaVk1RlBnbjFVSUsrUGk2c1Mr?=
 =?utf-8?B?a2M4SVpPVDNVeklGQnA5cnlpcDZUbjhsd2t3VjUvcFNTU0JoWW4xTG9CU25j?=
 =?utf-8?B?VEl1TzZJVFFTYVpYQ05EMU0vQVIvWXRWU3pqVnRGK29ERHQyL3daNC9icVJk?=
 =?utf-8?B?ZlNGRUx3V1FHWld4cWtDK2RVK3M5aUhGWnBMKzN4Z0VJeS96ODkzTmVnMUJ1?=
 =?utf-8?B?MXg0UFNnckpDU216a093R2kybVZKVUM4WDlnMStlTmhhTWlsYUdoV05TNllM?=
 =?utf-8?B?U1UycnhEYlkvVUtocDYwNmhZRTlqbVVFWmk5Nno4UENSUjM0L0ZFM0Jham5x?=
 =?utf-8?B?N0xuUURieFh3bG5SV0IySUx6aHJEeWNlaWJNWVJydFF6MVg5VlJMcHpGTnNG?=
 =?utf-8?B?NDdWNXhxSWxETThDdTNnQ0JlVVBVdU5sTlB5a1NrSGxSSk1RZWlqNFRseDFG?=
 =?utf-8?B?Nlpoc1lMSUVXNUNBWVNteWRocWhNWnZNWHhYR2tuK0tMY1VXNDdsakZJNmhn?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e7a847-8a68-47f6-6abd-08d9b869408d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 03:34:04.0598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+qii8luvSrBbRgo5k+b9AxA8XsaehBrNjlcolOLbdHQF5j2+Np8gLq/PkZebDLq6vojmvItcHB92nvbQLgeKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB2711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBiZXJuYXJkQHZpdm8uY29tIDxiZXJu
YXJkQHZpdm8uY29tPiDku6PooaggUGF1bCBNb29yZQ0K5Y+R6YCB5pe26Ze0OiAyMDIx5bm0MTLm
nIg25pelIDExOjIzDQrmlLbku7bkuro6IOi1teWGm+WljiA8YmVybmFyZEB2aXZvLmNvbT4NCuaK
hOmAgTogU3RlcGhlbiBTbWFsbGV5IDxzdGVwaGVuLnNtYWxsZXkud29ya0BnbWFpbC5jb20+OyBF
cmljIFBhcmlzIDxlcGFyaXNAcGFyaXNwbGFjZS5vcmc+OyBzZWxpbnV4QHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K5Li76aKYOiBSZTogW1BBVENIXSBzZWN1
cml0eS9zZWxpbnV4OiBmaXggcG90ZW50aWFsIG1lbWxlYWsgaW4gZXJyb3IgYnJhbmNoDQoNCk9u
IFdlZCwgRGVjIDEsIDIwMjEgYXQgMTA6MTIgUE0gQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8u
Y29tPiB3cm90ZToNCj4NCj4gVGhpcyBwYXRjaCB0cnkgdG8gZml4IHBvdGVudGlhbCBtZW1sZWFr
IGluIGVycm9yIGJyYW5jaC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQmVybmFyZCBaaGFvIDxiZXJu
YXJkQHZpdm8uY29tPg0KPiAtLS0NCj4gIHNlY3VyaXR5L3NlbGludXgvaG9va3MuYyB8IDkgKysr
KysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMgYi9zZWN1cml0eS9z
ZWxpbnV4L2hvb2tzLmMgaW5kZXggDQo+IDYyZDMwYzBhMzBjMi4uMTA3MDA3MjBiYjc0IDEwMDY0
NA0KPiAtLS0gYS9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMNCj4gKysrIGIvc2VjdXJpdHkvc2Vs
aW51eC9ob29rcy5jDQo+IEBAIC05ODMsNiArOTgzLDcgQEAgc3RhdGljIGludCBzZWxpbnV4X3Ni
X2Nsb25lX21udF9vcHRzKGNvbnN0IHN0cnVjdCANCj4gc3VwZXJfYmxvY2sgKm9sZHNiLCAgc3Rh
dGljIGludCBzZWxpbnV4X2FkZF9vcHQoaW50IHRva2VuLCBjb25zdCBjaGFyIA0KPiAqcywgdm9p
ZCAqKm1udF9vcHRzKSAgew0KPiAgICAgICAgIHN0cnVjdCBzZWxpbnV4X21udF9vcHRzICpvcHRz
ID0gKm1udF9vcHRzOw0KPiArICAgICAgIGJvb2wgaXNfYWxsb2Nfb3B0cyA9IGZhbHNlOw0KPg0K
PiAgICAgICAgIGlmICh0b2tlbiA9PSBPcHRfc2VjbGFiZWwpICAgICAgLyogZWF0ZW4gYW5kIGNv
bXBsZXRlbHkgaWdub3JlZCAqLw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IEBAIC05
OTIsOSArOTkzLDEzIEBAIHN0YXRpYyBpbnQgc2VsaW51eF9hZGRfb3B0KGludCB0b2tlbiwgY29u
c3QgY2hhciAqcywgdm9pZCAqKm1udF9vcHRzKQ0KPiAgICAgICAgICAgICAgICAgaWYgKCFvcHRz
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gICAgICAgICAg
ICAgICAgICptbnRfb3B0cyA9IG9wdHM7DQo+ICsgICAgICAgICAgICAgICBpc19hbGxvY19vcHRz
ID0gdHJ1ZTsNCj4gICAgICAgICB9DQo+IC0gICAgICAgaWYgKCFzKQ0KPiArICAgICAgIGlmICgh
cykgew0KPiArICAgICAgICAgICAgICAgaWYgKGlzX2FsbG9jX29wdHMpDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGtmcmVlKG9wdHMpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9N
RU07DQo+ICsgICAgICAgfQ0KDQo+VGhhbmtzIGZvciBjYXRjaGluZyB0aGlzIGFuZCBzdWJtaXR0
aW5nIGEgcGF0Y2gsIGJ1dCB3b3VsZCBpdCBiZSBzaW1wbGVyIHRvIGRvIHRoZSAiKCFzKSIgY2hl
Y2sgYmVmb3JlIHRoZSAiKCFvcHRzKSIgY2hlY2s/DQoNCkhpIHBhdWwgbW9vcmXvvJoNCg0KVGhp
cyBzZWVtcyB0byBiZSBhIGdvb2QgaWRlYSwgdGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KSSB3
aWxsIG1vZGlmeSB0aGlzIGFuZCByZXN1Ym1pdCBhIHZlcnNpb24gb2YgdGhpcyBwYXRjaCENClRo
YW5rcyENCg0KQlIvL0Jlcm5hcmQNCg0KPiAgICAgICAgIHN3aXRjaCAodG9rZW4pIHsNCj4gICAg
ICAgICBjYXNlIE9wdF9jb250ZXh0Og0KPiAgICAgICAgICAgICAgICAgaWYgKG9wdHMtPmNvbnRl
eHQgfHwgb3B0cy0+ZGVmY29udGV4dCkgQEAgLTEwMjAsNiANCj4gKzEwMjUsOCBAQCBzdGF0aWMg
aW50IHNlbGludXhfYWRkX29wdChpbnQgdG9rZW4sIGNvbnN0IGNoYXIgKnMsIHZvaWQgKiptbnRf
b3B0cykNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIEVpbnZhbDoNCj4gICAgICAgICBwcl93YXJu
KFNFTF9NT1VOVF9GQUlMX01TRyk7DQo+ICsgICAgICAgaWYgKGlzX2FsbG9jX29wdHMpDQo+ICsg
ICAgICAgICAgICAgICBrZnJlZShvcHRzKTsNCj4gICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4g
IH0NCj4NCj4gLS0NCj4gMi4zMy4xDQoNCi0tDQpwYXVsIG1vb3JlDQp3d3cucGF1bC1tb29yZS5j
b20NCg==
