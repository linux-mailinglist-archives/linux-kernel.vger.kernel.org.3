Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B24DC244
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiCQJEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCQJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:04:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8FF13D36;
        Thu, 17 Mar 2022 02:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQlDX1NIlvyqJwUjEkzQ2KmZmoMpwo25MayJznBgYAbqvZLrRP0cqgFyHhTTNOV4VQFM5qr6Iu6Ax+yt4+Fh4YvB9///itX8x5LGkfUgKNSRwMt9ZuDi1wH1woUQ8G0kLvgcqazOnmp8Iybt+LZlKG4afYVmOpQVVEaK3W5bvi+jWjXJ8JZ2ze+KEdW0ARW83l40y253oatJ1w6dLwo15MPbFt2dlTMNkoqLobfXhFHmxFgjyhFD1OQPuijyQ94qnW7hUv4i2pwdIy/8lc5EuHTnFcWhXwsFw62zARkSGu7Bdq8gJx4AnxQfQj7eZXGMWX0xp+i1+yoSCoq48D6kKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKiEZPvp9+ipZWpaNB8rLBFs7foeOvoQ5TNLyyf5tEs=;
 b=HswElMTVPl0JhSrXlzPpn77dKZiiXXR9GMqZMwhxat3WhDQA+upRCyviTh9yI9eodoZxZHU0vs8vQpSQcbr8RSxP6k2/n1OAxFBrYMYeHNQyagKSxfITR0m0DkwJviJP57/lkaWv1SeBUNShBpF0L56QJozb8xzlfueVxMmor1lBoIXZS3DgAQ63qmVvPlLuJAqwEhY8/Aqq0QY8+nO/K4vGqOBCWXbLiYTz+qCewmWLLbq6ic0b2xYtsDAAuhvPld7ElulxzhSKeY//n/ZsM6O2sCZVh7gKc/Qg1m9JnTfXAATSKpyEhRrDnWsVqxp/zTZ/UWfUBpSUdBL2bSUxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKiEZPvp9+ipZWpaNB8rLBFs7foeOvoQ5TNLyyf5tEs=;
 b=SlRf7OHrQ6GN6XGc55uFyi0fxEEhSeH6r25Pp++YEJixkcBb2p7W/uCB4zi6C7+/LNx3B4NkMvugnSyuhn3RMWh18BnnmvNQ7+KCyVu8dBItn4io6WEhV4wxf909SkZJ20MemsgUI5j0pq2fqPVvVk9QQWf+bQQsOvMpYgHt/pIN5tjTc6+ZOKP4qJefJJbVQSp+pjsWVp84EVZfWVQ2NkgGpzJbK/SDdg7Q8qIjQ2n91g2tfF6zm6X35C5fw3T8YQSJXEhVae6eRjrCEpfF2FOYzBe7MZHnAOmIKgYepDhLIUaMnFKU2f4rJkx9xKfExLLduTez2GpbhwPgGEMgYg==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Thu, 17 Mar 2022 09:03:13 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::801f:6a57:dcf6:6229]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::801f:6a57:dcf6:6229%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 09:03:13 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Ashish Singhal <ashishsingha@nvidia.com>
CC:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] spi: dt-bindings: Add wait state polling flag
Thread-Topic: [PATCH 3/3] spi: dt-bindings: Add wait state polling flag
Thread-Index: AQHYOZ0335dSkaF50UiXBmcW67nUEKzDQsiAgAAFe6A=
Date:   Thu, 17 Mar 2022 09:03:13 +0000
Message-ID: <DM4PR12MB57693FA8342B9A55D787A87DC3129@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
 <20220317012006.15080-4-kyarlagadda@nvidia.com>
 <8dff97ca-6de5-fa52-bdb8-49b11beddc16@kapsi.fi>
In-Reply-To: <8dff97ca-6de5-fa52-bdb8-49b11beddc16@kapsi.fi>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff2b0d4a-0cae-45e7-8164-08da07f4f7ed
x-ms-traffictypediagnostic: DM6PR12MB3852:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3852251F5249D5369020DB67C3129@DM6PR12MB3852.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJCyjcr0EjGFIJa7BXocEoyPik78ac1Vc0xDHdBX2pGbjAENkqChK2kzYlgYNkQsH4I4XC3HZHz5Eq8/Sqn4zOEkr7NuIkCHIa3uUq1u8tfEy6z9ZzM69fyF6cu6JwossIX1NYrsDC7vn0FJ66EW0MN5yGyA2LzzSgNruWSsYQxD2ypYQ3fLlSehs61rZunkM8jPseE8tM4WcO0jCSK5aJKQX3E/gCIMc4bb1zg6lFfBCuE8hCCe6ltXWGBgzAxFl5NbLLd1oVvQU8KVMXqMG44tUp92aeFcmPdJw1mqn930XVulWENTcUmhWuNp+/SexRmN5Z89mNTqnhHCglErwtBvAROSDG1H+5ZoJgu52z6Cc1/nVFhuYAMmNORv8vTSKnxUFD4xgR/wnqN8iPYzxRjlmmrDlLZD6RK0KrQllQm/i1+E8SDwW3/ZZGfdNVd6mYCCG+m/ojpvcZ+YxzEHZ79A7/czefgV+soydUU8GKecacVAjCayHD1ePciczW13a7xECS/8ANzBpD5sttBEcxXbKMPHYLn1JbWPk3h4bzasqngqnpapkgw7swcLYsHSeXPV3ZrMo/OCRiio46ivaD8yoR4ZoydznkH0nxVqsrWd3t/sxoCmEYjoHXKz/4AeLX5BSLsTnMqD1wAl7Ch+QVR4YlY7Z7sSaIWpuQCd58n6oq911i48l5tPFR0x7QdRRhZvMxXSqubfZPDy4aRTTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(2906002)(508600001)(8676002)(66946007)(4326008)(55016003)(110136005)(71200400001)(64756008)(66446008)(66476007)(66556008)(86362001)(33656002)(6506007)(7696005)(55236004)(53546011)(9686003)(6636002)(316002)(186003)(83380400001)(122000001)(38100700002)(26005)(38070700005)(8936002)(54906003)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2liR0xsRkdFOGlCckh2YlZkUEp0aXZjZWJycHFOUVoxRm04ekRBTFNweGU2?=
 =?utf-8?B?SzdMMHpmOU5mQVljZDlSS1FLa3dJZS9VSE9FbVROeUovWW1rZDN4TDJFVyti?=
 =?utf-8?B?U3BYOGo0aHhMdkVaTndNYlQ1RzR3MldJdjhRTXkrcUR2aS9GZHhXYWNLUExM?=
 =?utf-8?B?K0VVRVZ5V2lrZkxHMU1wOVFiUHdjTityOTlwZnVZbjBXOHZIWVhRZSt4aUZw?=
 =?utf-8?B?UTZhY3o4V3BzdTFzajlQalROSEtLWFk2aVJNdDdPd3ZmK0IzVkpVaFlXOFNK?=
 =?utf-8?B?OThSeTJOZFhrUU12aUQzVlBwUm1VSUg0OVdsRDdSNlJjR3RtSy8vUEpsQUs2?=
 =?utf-8?B?RmFOVXN1RTdlSlREbUxjWWtTRDdjbFFYRDd0T3BLRTc5U1ExL2p1TXpoWG11?=
 =?utf-8?B?eE8xOVZHTzYzV0RzOEI3bE9uRVhScUdkS0N3cXFpdDYyOHord0xiTGdIT3Zp?=
 =?utf-8?B?QzRCa2pDTHFKQXozVExPbzl3bVV2ZnU1NXFQWGpaNjRiSTcrWVZsczA4Slh1?=
 =?utf-8?B?WUVHbXBSNkR1b0M2dkRHQWhrTGtwaXoyY3ViQjhaNm1La1FrUm8wMDh4YVB1?=
 =?utf-8?B?YnB1TGE4cFVZeG52b21kR1AvaFY5VE9jYTZ0UEtRdHh0UU9SOTBjdDAwM1VT?=
 =?utf-8?B?NGZGMGNpS2N1Zlh6enZFWWtwQndUUUxnQTVuQlowRmxMUXlKK1hodzEydFBU?=
 =?utf-8?B?SzF1U2I5VFZNMnNPU1RPQ0NQUWh4MGFmTXphTWZDNDdJaEFyRWMyRkhPYmIz?=
 =?utf-8?B?MHU0T0tnWnFjZmk1T1gyYlNMQTFoRWRlTUd2WWNUUmNnakdDcWdJSHY4N1hX?=
 =?utf-8?B?YzM2dUNNc2kreW5vdVcvaVJaY2trUGpsb3RHR21vWGRTbXBXTWVCZ0EvYWp6?=
 =?utf-8?B?VSt0UVVRTWVMcWs4OFJocUtCTERNVUNGbFRXbnZySEdzeDdEUmcrenBuTFNP?=
 =?utf-8?B?Y1pKR1l2eUw5SW0vZk5TVEpIRTNhMEtPV0JPeEdFb2RpbmRPK1BsUFRSb1Rr?=
 =?utf-8?B?OHVyOVhqUGE1WGRhaFQ5ZTRPaUNjQTUxVDlibnFiYzhYem5TWWhycDVZMWsv?=
 =?utf-8?B?QU85dHZmN3hiL0VHRHM4cEI1Sit3Q3ZsWFhzalRweHpJdHpwdHZTaVVPbERh?=
 =?utf-8?B?TDQ2Y2hSUmVCRjc3YlRTdFRZN2tzR2p2VFRVLzZiU1FpZmxnKyt6cmdUbXdG?=
 =?utf-8?B?a0dUTVlIS0EwbXY4eit2VXVxazlVY1ZaM0RsdFNDaUN1M2s4eEhCYVhPdG1F?=
 =?utf-8?B?SGt5TG1lZGUwQzJiTnZyL0tia0JNa29IOWp0a0cwSUFVL3R4NGswZ1BIV01y?=
 =?utf-8?B?dVJzZ3I5bHJRcVUyTTNCNE9OQlVFQnlJSnd0Tmovd2J2L29ZZ1BFVk51RkMz?=
 =?utf-8?B?N3FxNUlkV0tESDk3eWJ3ODBIcUNZTWtPdXlEdEw3bElrbWxQSUhrb2hVS081?=
 =?utf-8?B?eGJKUjF2SG1lT0pEZ1lyZU9rMDg5UllOcFlYb1ptem5yQzhXWDlrZUZwYytl?=
 =?utf-8?B?STZ4WE0rWkhFNXpCSjE5S2dBc1F2aFJuNCs0VWxHNUNCbzhwNThVSVN5ajhj?=
 =?utf-8?B?OFRJUEY2ZTRBajR4RTdSdFp6eHpocjdFTVNydjU4KzdaSStnZDRqdnBRWWNO?=
 =?utf-8?B?cXNzWVVSdXdib3g3Wi9XNVlTTDEyVjBZWUxtT0MxNkd1SzdYUWttT2NuQ3Np?=
 =?utf-8?B?QkRIeFFWYnRRSFl2TzJaV1JzekpKRVpjNDJoaUlzSGpscnRTWGNDbk42aTNu?=
 =?utf-8?B?Mk4xRmd1S1N5QUV0MzdzNzVBZDJnS20rN3BWbUo1a2RmMzFla3BJbXBZYStm?=
 =?utf-8?B?Y2YyN2pvQnBCSlFKbmNIRmYwdkc1VnVmdWpPdUNiQWlOV24xbExvaHNRZ0VI?=
 =?utf-8?B?eUtXazRIcXVhL3RsYjQ5TVN0UUpyME5WcGhxTDVOQmZQZ0NDYjN3cHFUakhu?=
 =?utf-8?Q?4UMIY8U87qLz6zgXw+2qJWgGJRJCXJam?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2b0d4a-0cae-45e7-8164-08da07f4f7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 09:03:13.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6Ouj5JWemII2/q0nA0hwd+DUfmzi0unUkrgYMG+P5Pc2e9SbxHURsBeSErGEqoak/xcJXLGUaHBWaYD5V2ljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWtrbyBQZXJ0dHVuZW4gPGN5
bmRpc0BrYXBzaS5maT4NCj4gU2VudDogMTcgTWFyY2ggMjAyMiAxNDoxMw0KPiBUbzogS3Jpc2hu
YSBZYXJsYWdhZGRhIDxreWFybGFnYWRkYUBudmlkaWEuY29tPjsgYnJvb25pZUBrZXJuZWwub3Jn
OyB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IEpvbmF0aGFuIEh1bnRlcg0KPiA8am9uYXRoYW5o
QG52aWRpYS5jb20+OyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC10ZWdyYUB2Z2Vy
Lmtlcm5lbC5vcmc7IEFzaGlzaCBTaW5naGFsIDxhc2hpc2hzaW5naGFAbnZpZGlhLmNvbT4NCj4g
Q2M6IFNvd2phbnlhIEtvbWF0aW5lbmkgPHNrb21hdGluZW5pQG52aWRpYS5jb20+OyBMYXhtYW4g
RGV3YW5nYW4gPGxkZXdhbmdhbkBudmlkaWEuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gc3BpOiBkdC1iaW5kaW5nczogQWRkIHdhaXQgc3Rh
dGUgcG9sbGluZyBmbGFnDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3Blbmlu
ZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDMvMTcvMjIgMDM6MjAsIEtyaXNo
bmEgWWFybGFnYWRkYSB3cm90ZToNCj4gPiBBZGQgZmxhZyB0byBlbmFibGUgdHBtIHdhaXQgc3Rh
dGUgcG9sbGluZyBhbmQgVGVncmEgR3JhY2UgYmluZGluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEtyaXNobmEgWWFybGFnYWRkYSA8a3lhcmxhZ2FkZGFAbnZpZGlhLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9udmlkaWEsdGVncmEyMTAtcXVhZC55
YW1sICAgICAgIHwgNiArKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc3BpL252aWRpYSx0ZWdyYTIxMC1xdWFkLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc3BpL252aWRpYSx0ZWdyYTIxMC1xdWFkLnlhbWwNCj4gPiBpbmRleCAw
Mjk2ZWRkMWRlMjIuLjg4YjAwZmNhZDIxMCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL252aWRpYSx0ZWdyYTIxMC1xdWFkLnlhbWwNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL252aWRpYSx0ZWdyYTIx
MC1xdWFkLnlhbWwNCj4gPiBAQCAtMjAsNiArMjAsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAg
ICAgLSBudmlkaWEsdGVncmExODYtcXNwaQ0KPiA+ICAgICAgICAgLSBudmlkaWEsdGVncmExOTQt
cXNwaQ0KPiA+ICAgICAgICAgLSBudmlkaWEsdGVncmEyMzQtcXNwaQ0KPiA+ICsgICAgICAtIG52
aWRpYSx0ZWdyYS1ncmFjZS1xc3BpDQo+IA0KPiBudmlkaWEsdGVncmEyNDEtcXNwaS4gU2ltaWxh
cmx5IGluIG90aGVyIHBsYWNlcyB0aGF0IHJlZmVyIHRvIHRoZSBjaGlwIG5hbWUuDQpBZ3JlZS4g
V2lsbCBjaGFuZ2UgaXQgdG8gYmUgY29uc2lzdGVudCB3aXRoIHJlc3Qgb2YgdGhlIGNoaXAgcGF0
Y2hlcy4NCj4gDQo+IE1pa2tvDQo+IA0KPiA+DQo+ID4gICAgIHJlZzoNCj4gPiAgICAgICBtYXhJ
dGVtczogMQ0KPiA+IEBAIC01Nyw2ICs1OCwxMSBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiAg
ICAgICAgIHNwaS10eC1idXMtd2lkdGg6DQo+ID4gICAgICAgICAgIGVudW06IFsxLCAyLCA0XQ0K
PiA+DQo+ID4gKyAgICAgIG52aWRpYSx3YWl0LXBvbGxpbmc6DQo+ID4gKyAgICAgICAgZGVzY3Jp
cHRpb246DQo+ID4gKyAgICAgICAgICBFbmFibGUgVFBNIHdhaXQgc3RhdGUgcG9sbGluZyBvbiBz
dXBwb3J0ZWQgY2hpcHMuDQo+ID4gKyAgICAgdHlwZTogYm9vbGVhbg0KPiA+ICsNCj4gPiAgICAg
ICAgIG52aWRpYSx0eC1jbGstdGFwLWRlbGF5Og0KPiA+ICAgICAgICAgICBkZXNjcmlwdGlvbjoN
Cj4gPiAgICAgICAgICAgICBEZWxheXMgdGhlIGNsb2NrIGdvaW5nIG91dCB0byBkZXZpY2Ugd2l0
aCB0aGlzIHRhcCB2YWx1ZS4NCg0K
