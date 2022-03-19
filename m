Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFD4DE6AB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 08:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiCSHWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 03:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiCSHWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 03:22:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5427B2A045A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 00:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2BvPi5pmpHuLwTpdt8WNp/qzWWkL0YrWShniXUVaDIYp8p3GRyXORZThVEPZV85lWFL1uyTN8wG2uA26UejK0Nxt/cyGWvfdzDpL7euuLQutEPJ0u6fZV6PshRyApr/JWAjARMLHsfMiqzH15qGmxKPEZABIcZq6h+Zs75Yp6GgrUKxEeCksEnOJbNNANqYR4GjjkmYt0VYBTmljN4ShJI1bt4yobtT2C7VBoOq1D0QNPDCpIAUzh/JjxWzLp6KP+CCMhfQfYMq4OvKO7mTph3Gg6cBpnxXmt3gyyzMpYzVrrV7JGvadg2Q3iOPuFhX6xg3JAByl6S+E85RuQNjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xEhz6ZU6hwHI3c9+CbbMXBGUPZ7Dl6mRP3csSgJ89w=;
 b=QR/Q3vwEBS/UgYnWoHA5D3eW5OlkGF/CY93B6xMp7LCZNOGOApKvhrBPKyShsoAkRmHZ3AwJcHAkG3Yf2ySZeay77aLpbqS0MtPe+KhO9dKCfUhR9Jf+aNmFLN3yJv5Rpr7FU6KPArb2lUuYtemmWyuOgWlIT2bUNBjv/uCTDE3Wio4rFd9RDUFVFuSp1tcVPgEznZ3cYezdPqrOPN5QMtensCAfBGY4wDxV7xwyteHJevWKY4LLWZrzHd4e/379tl4S0t1UP5y8d7AKKcotiuQG7iDWyjh9MsuX0EhurtaQf628Okiyro3XQSANGp8CndNdMTK6vxQRewo7ZFkmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xEhz6ZU6hwHI3c9+CbbMXBGUPZ7Dl6mRP3csSgJ89w=;
 b=nnPfanXdvCdcOh098ylo5HHN/b2CiakaFLn1PfF+PH7l8vgbbVZyEoqBcmTxfEkLPCyTBKfj6mJiscIsVmS0jzlNmD+mToeQq3frrlzyr6revZ911dk4ubOfbl3mmFISF/0sdge3y7+9hWKW4VdKhoPkDodT4mQvH0ucxH7032o=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN7PR05MB4244.namprd05.prod.outlook.com (2603:10b6:406:fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.9; Sat, 19 Mar
 2022 07:20:45 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b%7]) with mapi id 15.20.5102.012; Sat, 19 Mar 2022
 07:20:44 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.cm>,
        kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm/tlb: Revert retpoline avoidance approach
Thread-Topic: [PATCH] x86/mm/tlb: Revert retpoline avoidance approach
Thread-Index: AQHYOuXrigMuAXPe5kGi5Og255v/tqzGTeSA
Date:   Sat, 19 Mar 2022 07:20:44 +0000
Message-ID: <D2017D89-2DE1-4DEB-BF5C-9A124D5C7905@vmware.com>
References: <20220318163304.2128897-1-dave.hansen@linux.intel.com>
In-Reply-To: <20220318163304.2128897-1-dave.hansen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3af2aa80-1c97-488d-7ccd-08da0978fb84
x-ms-traffictypediagnostic: BN7PR05MB4244:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BN7PR05MB4244E9BD6FE6E26144144AA7D0149@BN7PR05MB4244.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TmZ0bMttKkXfzQ0yVHlXPzGIwM7F4pI/WH3FHFz58YHS9tgC7fCXaQ9UEVLS6db6SrIqc0wo51B94kyG8zfkndRqQsxrHt682yRlE1bY4kFszMWNX2W4dd6Vo2zPCUg5h5ElS0xjajNJ8t6MYPexlKC0V1VEQUL45TERVLnaCpCt55dZ1su0NUk2w/ofrxUahAxoRLvnPKRjVERtseHG/tOvVzT4COZR36dR6UxTElB6p6NE7xPrRxPq9fQ/0wYK2x2pkVy8uAxvS+tl72ZwJBbQH5gD7zffi0bQgFXYAnlw0NBj3mhD9ZnbC0Vdn5DNhJjr6Va0eyMVpsin4cGzGQAjbT/iUEQFso/3OytEQ+0hP9w4ihn4u2Sjr1bMkpy/wqb9F0IIuCIILymxKuE3TjP5cSclCsxloajHqj8hU11de0Fnr1FqouU5sRsEjPebKK2DNlcA8fdYppuKFw5ddbIsYhLtWEZSqq24OKo2E85H3cYdz7X8gkKvjgjxaqG7ormBXpQJ2NhN3Iq3PHj/qnO/ENhAtPdcTpUNZyteDhQ7a/a+g5MrF+YaGwFKlxH5sHWPc7Sol8OJhYb6WDxWPp26eGywN1fSHTbY9Bka4poRIsT6r423Carod0cki4R325jJJ+LkmgWwc/dvwdExlrsgJP7KWTorS8L2k3Gx6ZNMZm03Qga1zXBCm3D6jeL5rSt/z8ZtNAh42CbnfP/Xdqr90MibjFZwelT1lzII1qZ8kNHWzpLZ9HW0X+G/QeMklFvIV/C96KIpZBNz9N4DhkKVlX6GFqWRYQPQmOURN+T4DmACAzz1K2ilLYS1orShjlTl0nG2cQCjve+zoESE1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(2616005)(508600001)(71200400001)(966005)(38100700002)(6486002)(33656002)(36756003)(83380400001)(122000001)(54906003)(8676002)(6512007)(6506007)(8936002)(2906002)(53546011)(66556008)(66476007)(66446008)(6916009)(316002)(64756008)(66946007)(45080400002)(5660300002)(86362001)(4326008)(76116006)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0JHL3JhWnRNazVPRkZZVTlPdHNOY0FxUU9Ta25CRENIMGVCa0VMQ0YyYlQy?=
 =?utf-8?B?VDA0bXljUC9HZjByWUJyVldZV2VnQVlqUTgyYmRRejNKUnl4bXI4RG1tNGNo?=
 =?utf-8?B?czNSSkZWbUdiNGVEQ1NiVk1ET0RJalo1SFQwWFBORjAvWlBGcFV3T3h4SE5O?=
 =?utf-8?B?bDlCYy9YSE4rNEtSdllSVUhhUDRjL0ZaMEJyOHoyWTdzc0tUanVoamU4QnBw?=
 =?utf-8?B?NE8yM3BEeWt2VGc4S05SK3hwT1VCNmt5a3BlWVFDRnlPQWxqZkViSkpzc2dY?=
 =?utf-8?B?ejFwNmpDTXovRmsrNmsvYmhFYzg1bXZQazhEVjkyYW9tYUVHWFM2WjVJSW15?=
 =?utf-8?B?WWw1YmxwOEUvdnpaMlJsRWRvRC9IQjNZcU9ZRzRNVDY4cXpuRkh5T1B5Q05E?=
 =?utf-8?B?SWViYm0zZnhuN2tNVVMza0xtSi9DRUlkVWs3VlcrS0huWlJxREhUZ2lKY01v?=
 =?utf-8?B?aG9MWFRLMitNZDY1bm9ZbEZwdjliNW51alZwZ01xMkNCNnlCRUZIQk1CUzFn?=
 =?utf-8?B?ZkJGemYyTTBxRWFlWnZwZmR2K0JFUFhoYnNESk5UcHVYYVc2dG44dk1ndHBx?=
 =?utf-8?B?aWxCUlkxUXJWa01UWjhHZm43Z09rYXY1dHR0ZkxwVk5PazliNUU1MWt4bzFr?=
 =?utf-8?B?UUVYUjRUdWhKNXhwbVh4K2E3aDhZajR3MTdNZFhpY2Z4dHlIbzlNTS9MU1Yr?=
 =?utf-8?B?Ry9HM0dVd2JpWVRRQzV1MksrTVA1b2FlNkw0bWdzTElwTllLd0t4M1A5Kzdy?=
 =?utf-8?B?QzZVZWF5VjZaZUFUSTBDZ1N1UmEvRVVUWHd4MmhKR0FpNFY5RmZIaVljUTV5?=
 =?utf-8?B?aWs2ekNIN0Z2MUgvL3hBcFBzOWt1MzB5WXhoTWtTbGVqV0hkTXc2aDZVbnFT?=
 =?utf-8?B?V05Qa2JWZWdVblNBMnBxVnFtNE4zRktXMW9rbnJsRmgrMkgzM094VHNpTUIw?=
 =?utf-8?B?OHpxdlBkYzlaS0RMUk5aTVVsUjRRVVg0eE80Y3JpRnJqdUlDcUJPYjhzSWNz?=
 =?utf-8?B?ZFcrNit4ODFIWG1RTUxlcnVSRzZnZEU4ZHpwdkxRK3MrTlVOb3ByNHhJUkwv?=
 =?utf-8?B?Mk1SdUxTeG5QWG8vYzJsd3I4NXJHQVZQNVorakZacytRcm53TUk5TFZTWEpX?=
 =?utf-8?B?TUJla2ErNTI5ZFROU2tqc2RtVGVISE50RnhzemQ2dk1tdUxKRzZ3d2ptUVUz?=
 =?utf-8?B?QmFuRDdIRFhqZVBpZ252U1hXTWh0eUlTZzdJT3BvN3FadGFtbFBwZ1VVRmQz?=
 =?utf-8?B?eEx0Q2ZRY2RHL1gyNUZ2cEpoaDU2MVR4NEhGdWkwRnp2WGlJMm9JcXQ1OXFs?=
 =?utf-8?B?VzVCWG1WREpFa2FhUXdnWlFmMnJySk9sSEtZaEJIdmFQaThTaFZFZTZjL1RQ?=
 =?utf-8?B?QktTM1ViN1lYKzROOVgyM25IV014bTNRTnVqVTdBWUZvOVc2aG1FblhPTXY4?=
 =?utf-8?B?ZEY1aUFCYzhQWklpZzBIU2pPcHRDdmY1SDNqMVpsY3FoYkZtdjNtMmtncFFG?=
 =?utf-8?B?UnRqMHNkWkx5OEdsdTEwemt3eVh3d0xaNVgwd3pUR2tIZVBGckNEdWludFp3?=
 =?utf-8?B?dWszSktOelhpckFjc29CdWdHcmZ0cGlZL0lWTEZ6Mm5oSjg2NnFRcUFOVjBG?=
 =?utf-8?B?RUxUQk9yWjYxRnFoRFJvNFMwVURjT0wwNnplK1l2UzNRd3B4N25Cb3hwY1VU?=
 =?utf-8?B?cm9odURRRWlZL1JkaEgxMXlkNndzdzZyWnVGUkxlTTc1TFcvbEtQOFI0WnFs?=
 =?utf-8?B?SkNaNHQwN3U2VHV2ZjFTWDdaTUcvRDU2MkNhUXMxTWRjU3M4NU9Kd0hnYk9l?=
 =?utf-8?B?enVBQ1B5ODJjTFlCTFY5MGFwRFNpcUZQQnhaV2NVMDV2bnNUWkxNQkRmWTBs?=
 =?utf-8?B?dmg1WHhqTFpvSlZWTStwTlVsRlc3b2hmZEFPbzhhM3ZLZU5tSUFCQ2NPTW5X?=
 =?utf-8?Q?SY3q/C7gs9nvh7lau1ytSccOBxCZSWbZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0F70132227B3746ACFAEA7F0C9E9608@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af2aa80-1c97-488d-7ccd-08da0978fb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2022 07:20:44.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltQwR3B52ESTVRnZuyGNErQx1EvImgQgstLn93SnVzwW2zSiY5/1SXdgBqIqKY4B8Qr6VXOHPkj0X6p+oGONmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4244
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1hciAxOCwgMjAyMiwgYXQgOTozMyBBTSwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2Vu
QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiDimqAgRXh0ZXJuYWwgRW1haWw6IFRoaXMg
ZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhl
IHNlbmRlci4NCj4gDQo+IDBkYXkgcmVwb3J0ZWQgYSByZWdyZXNzaW9uIG9uIGEgbWljcm9iZW5j
aG1hcmsgd2hpY2ggaXMgaW50ZW5kZWQgdG8NCj4gc3RyZXNzIHRoZSBUTEIgZmx1c2hpbmcgcGF0
aDoNCj4gDQo+ICAgICAgICBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZhbGwlMkYyMDIyMDMx
NzA5MDQxNS5HRTczNSU0MHhzYW5nLU9wdGlQbGV4LTkwMjAlMkYmYW1wO2RhdGE9MDQlN0MwMSU3
Q25hbWl0JTQwdm13YXJlLmNvbSU3QzRhMmMzODJiNWVmNDQxMDU0NzQzMDhkYTA4ZmQwYzdmJTdD
YjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNzgzMjE4MDE3ODc1
MTQ5NyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1U
QTBpQVRRQ25mRGpJWjFsRzNZZGhqTVpqZWxYclZhdEJqQkU4SHozQWZFJTNEJmFtcDtyZXNlcnZl
ZD0wDQo+IA0KPiBJdCBwb2ludGVkIGF0IGEgY29tbWl0IGZyb20gTmFkYXYgd2hpY2ggaW50ZW5k
ZWQgdG8gcmVtb3ZlIHJldHBvbGluZQ0KPiBvdmVyaGVhZCBpbiB0aGUgVExCIGZsdXNoaW5nIHBh
dGggYnkgdGFraW5nIHRoZSAnY29uZCctaXRpb24gaW4NCj4gb25fZWFjaF9jcHVfY29uZF9tYXNr
KCksIHByZS1jYWxjdWxhdGluZyBpdCwgYW5kIGluY29ycG9yYXRpbmcgaXQgaW50bw0KPiAnY3B1
bWFzaycuICBUaGF0IGFsbG93ZWQgdGhlIGNvZGUgdG8gdXNlIGEgYnVuY2ggb2YgZWFybGllciBk
aXJlY3QNCj4gY2FsbHMgaW5zdGVhZCBvZiBsYXRlciBpbmRpcmVjdCBjYWxscyB0aGF0IG5lZWQg
YSByZXRwb2xpbmUuDQo+IA0KPiBCdXQsIGluIHByYWN0aWNlLCB0aHJlYWRzIGNhbiBnbyBpZGxl
IChhbmQgaW50byBsYXp5IFRMQiBtb2RlIHdoZXJlDQo+IHRoZXkgZG9uJ3QgbmVlZCB0byBmbHVz
aCB0aGVpciBUTEIpIGJldHdlZW4gdGhlIGVhcmx5IGFuZCBsYXRlIGNhbGxzLg0KPiBJdCB3b3Jr
cyBpbiB0aGlzIGRpcmVjdGlvbiBhbmQgbm90IGluIHRoZSBvdGhlciBiZWNhdXNlIFRMQi1mbHVz
aGluZw0KPiB0aHJlYWRzIHRlbmQgdG8gaG9sZCBtbWFwX2xvY2sgZm9yIHdyaXRlLiAgQ29udGVu
dGlvbiBvbiB0aGF0IGxvY2sNCj4gY2F1c2VzIHRocmVhZHMgdG8gX2dvXyBpZGxlIHJpZ2h0IGlu
IHRoaXMgZWFybHkvbGF0ZSB3aW5kb3cuDQo+IA0KDQpBY2tlZC1ieTogTmFkYXYgQW1pdCA8bmFt
aXRAdm13YXJlLmNvbT4NCg0K
