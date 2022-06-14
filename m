Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962F754AD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbiFNJry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiFNJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:47:49 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2117.outbound.protection.outlook.com [40.107.127.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC57A3FD9A;
        Tue, 14 Jun 2022 02:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0O+L9sHKNUMT0MdXARqymI4E2EI8Z471S0F9MVZJcO7HXZPxY/8tAPqOUvgLOuGGb2NE2YL8z07a5cc9TOPLbD7KhAVrQ0azgoQxOj8F745zVD4UZn7IcqofEAx5OFcm0ik7YfnvusyLsE0EaeAmVExT+NTUDDloh4SyVyW30hnm9myGtPwE0JsaiKNaWPoAFX/T2XGRVLms6Tea7UC4ddX+rw82ZqxpgcF2gLBLkn/liCy5cj7jZITs9WW8TMRlue4CzaIjByS/gosCWqj8jNL437gw2aD9sM789UUHOKctXGILLS/5T7fEShG+wf5CK9siCYKP6W+L4ME0RHxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wqmV3kfoo6ssB1TcqbWSLkCepLbtzY93iZgHtdCOmc=;
 b=n9fcPI9Vw8xdcl/dAaS2qZ536/Kldnc2Zc9eY9Y6c02nzB1VmmXRUEILuCKPznhAeXl4Lqj6NYyVj1rW1JCaEt1BpOprty1KSj58AT/OLyUO7S7k6JmpDkJyz1HuQ1/RaybrvIGcFmeZYZvaQaVPtzcEgsl6e7yxCx8gCDXWUIOY45f+epDZktZprXB7PefavJEtbhO23/b9PTcsXRTn1zOUpyrSs/mps36w3ZSfyampVMFlk7fVt79cHSe+wtzOzvalJRZm6p3X1VcbYG4HF4anNqjlGqVgRxfz/pJIzU8t0VjnIXJIBRPLpJ9BDgsysB12ZJMsTm1vG4fWU96PMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wqmV3kfoo6ssB1TcqbWSLkCepLbtzY93iZgHtdCOmc=;
 b=sEeo9cgfhRxKAw/oNPkeLHPgJwybrBMSCWBBjT5GGAcoJq4teEMQPExVeL8PEz31UDe5Z0Vg8Vu6EArhGbvDzlUSYn1ujzqTmfD8WefdBAFg5adrvW0Uq1oA7Hy8QpP7cvAJfT95UsUh0i04i9FnwUfm2oLirDqRvXqJVJ+tvoo=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FRYP281MB0240.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Tue, 14 Jun
 2022 09:47:43 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::84db:ff67:63a4:bd38]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::84db:ff67:63a4:bd38%6]) with mapi id 15.20.5353.013; Tue, 14 Jun 2022
 09:47:43 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: regulator: BD71837 PMIC resume during noirq phase?
Thread-Topic: regulator: BD71837 PMIC resume during noirq phase?
Thread-Index: AQHYf84FTXTME6yl/0+UAaeR8Ky7hq1On8YAgAAIMwA=
Date:   Tue, 14 Jun 2022 09:47:43 +0000
Message-ID: <75d30918-9474-8a35-c5ed-d28a090a64c9@fi.rohmeurope.com>
References: <573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm>
 <YqhSXuHMR6kuFu/A@sirena.org.uk>
In-Reply-To: <YqhSXuHMR6kuFu/A@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0513a7f2-1039-4938-fadc-08da4deaedce
x-ms-traffictypediagnostic: FRYP281MB0240:EE_
x-microsoft-antispam-prvs: <FRYP281MB0240B792EA1FEB63B232318CADAA9@FRYP281MB0240.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJfM/1QM6moPoQcNiUT3OzXmJLnYxq/gZedQFygpWJckbUCLUG0LGyUsWUzKWNtbOag8wxUYZe288aVcxFSGXlk4M7fmmYVCEmYz1VaK1E+NSUP2neFWRHmtEgmGWqV9IUUKwU6NDa2Jl9vtcnddVln3vxR5p+iyt+a/XBRQmsNnAgY+NiH/fBuwBPA2CfyWJ7BtEfO5U8ENIk4eUd23VtWFG89rGwDT0qdlpmnT4CM8ST/HuN30FTpj/eoLcX9Xr0PanDkFWPiFFL/BDBpftdmaFgQYnr4/coBgSmW9tNPBQNVP5sIRFCtfrwSY4OiXp+uO2wNmDP8cde8LP0wLEV6H4IaSEPkADYSO6cOJ82euAfYu3IuYV3+MOG1knyxwyDxk2PDmF9HUSV0CsQvejmJV+spXaFeAtDi5CKh8d62bNWtGdEaIg8D2/Hhr6ldTfHVDTCQos6CIm9+K2xBgkGcEtYa15of49WYpcyHBWnOzoSp03+FaRZ5cczy0Z6xpkbXXQgQ7QlNSBJ1yZcVjizp6by72NEI/XwIzD+iLwoNXVe0UVkXTxPFQsqX3NlFd4WA3lqbZNg4hrcKvRHY4+9gSpSzX3IlOOiSLVnqfPSx74eanojquRKTfjRJ5mbg4BYvircb04xmZo427EhKZPgrvzYInqtrbTdcAk/S+KvMtfp3VINSEdoXkYWBXPiDkgPmaaHOvAbhWWKlYTkbFOPYUP/Ghvw6x+tTMtVgcPnsZ2YMqR3iGl++Usbu2BrPUfi9qFVxFwCVyqoBvGhvvvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6486002)(76116006)(2906002)(64756008)(38070700005)(66476007)(122000001)(66556008)(6506007)(53546011)(71200400001)(8676002)(8936002)(66446008)(91956017)(5660300002)(4326008)(508600001)(66946007)(316002)(31686004)(38100700002)(186003)(54906003)(110136005)(2616005)(6512007)(86362001)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW90ZkRqYi82QzlTM0lSL2QvN0FsbW55cCs4SjB2NVVaZkhkVzhoZ09vNHdj?=
 =?utf-8?B?ZndHZzhiMExBZXRRQThha3VBL2ZGd3piQXVFV3BTK091RDNzNTZsOXJjZWwy?=
 =?utf-8?B?aUI1QXVUVDFzMlF3bDBjSXFncE1HYzhtWTl4WitUenNJUktNUGJpdnc5WE04?=
 =?utf-8?B?b29TUTg1U0ZYRDhUTjdkRlpBWmxjV2xtbThnZEJKVWRmMS92L09veVhUdnRT?=
 =?utf-8?B?MENjZ1BzNEx3QjUxdTFMa2pZRVFTN1QvTVdpQ1lKaHluMFdCOHVTSEd4TXhZ?=
 =?utf-8?B?VlBuaVBpbkRxSFc3TjBOSHRZMFMyQjIyZUVVNG9zanpqbE9BcVZkNnpDNHVH?=
 =?utf-8?B?NlNvVzdXcUpjY2JUbU5IVXFVRXp1NUdFbHFHaG9jSFhUdFE4b2UwUStQSUk3?=
 =?utf-8?B?NDdQdVRncmIvK3JiWjZuamFsTTF3WUs0M0ZBMGs4dFptd3RFR29zVnV2UlZo?=
 =?utf-8?B?a3Q0QldIRi94bXpMMVRyNDlFOGIxdFM4OHoxYituVk84VUMzK0JtZk5LQ1U5?=
 =?utf-8?B?aWdOeGdqWkl1QTlWVWZ3aHk5d3ZYVFBocXd6cW5qbXhsWlpQTXdlRjBxYlM4?=
 =?utf-8?B?L3RkQjNBT09XTjF6TFJTUURWb1BNdWZDb2xXeDcyV2VPS1VHMmlwZHRPZzVa?=
 =?utf-8?B?M1BvMjZCODVMQjFFc3lBazY0emtYak5URHB3UUs1ZWxwbzROeWpZY3JRTThV?=
 =?utf-8?B?c1diVEZ1YlZsb2xaSkFzZUlyaHZZaEpkME9sTHUvenMyM1ZlREthNldyUDQ2?=
 =?utf-8?B?cG9kTFlMdUtEbUtJTFhQOGp3aE80bXBBVVdqSk4xK2tEQVNrU3YreVlMQUNj?=
 =?utf-8?B?U2JuQSsyTFplc1NjTjU5MVVDOFNXMmdmNEVBRXNxUVRyL2Iwdy8wOFZiSjZN?=
 =?utf-8?B?M25SU2dlUjRMK1NyUURERVM5d3hucXFrRk8xT3VtSDVicHRDMGlieUlEdS9w?=
 =?utf-8?B?RVlySWlITGhndSs2NjRLdU1ubTAvOGwvb3ZzNmc4MlhRVVlQZ2cwM2UrUlc3?=
 =?utf-8?B?WmpMYU9qdFc1NjFqL1ZVZ3AxaFNybjNLZHlxVDlxQzh5Wno2ZnltUFJBQ09r?=
 =?utf-8?B?UGhQWWdPRGJJaHNtVklGQkJvYmx6T2NmSUJQMEJ5WERON3IrT1p2RHVOV21u?=
 =?utf-8?B?YXRuMkdOZnVXeVBlSnhKMDFyOEphM3Q2VjNmREtNMGs3RGdGbSttRnJ1MmNu?=
 =?utf-8?B?ZlpTWEx3a1RDUUxPdU5iTDVaVkM2YmlIZUZ2YUk4K1FZWDV0TGlpVjR2LzN1?=
 =?utf-8?B?d0NVQmtHbHIyUE1OQXI4a3c0cXIyYzJtWjFhUURrVjBMR1UwalpMUzZzaXBM?=
 =?utf-8?B?VTVCNVU5U2M0SEpiOHJRNEw4em5KV2s3NmgxcjZQZVppRmx6NFRiUFdpMmhI?=
 =?utf-8?B?UDNab3QzS2N5VWZLNzNxYTZRMmZlMnAvR0ZmOEJ4b3BQTmZvN01IdGZYcWJ2?=
 =?utf-8?B?M0VmTEh5QmFRdWxzaEpqNHFSYVFHd3k0M3dmRmdKMlp0cWl6Sm1QUHR6WVhu?=
 =?utf-8?B?N2FMeTBERUJLRkhCYjh4NnZkR1ZrNmZiYXFOVkkvbis5d0Y2dXpsN2VwR3gv?=
 =?utf-8?B?RC95N3h4a3doM3l2KzF0azRJY1hkeUc5WU5Yang5VlYvSjBBQTNFRU1TL1VV?=
 =?utf-8?B?NEMrblRhOStlTXp6a0Q2Mk9SNGZLYkhoeFRlRTN6aG1FQ3ptRWtScUc1Q0Ev?=
 =?utf-8?B?clVrbk5NUzU3ajYzNDBkUGdjNzJIK0RVMnpvZXZ0RjJCQzRhVWQyVlZQM3BN?=
 =?utf-8?B?clJvNlpSS3dTRHpBVDFLYnp3ekJkVDk1aGtYekpiaUhBamR3OGx5S1YycHNv?=
 =?utf-8?B?N3BlbVlIVmVEOHo0RzY1ZGpKQ2F2d0xpZ3VPU2dSZzAwb011ZmtPaSt0RGUx?=
 =?utf-8?B?bnpoMS81TXVWa3ZockRlTkw0ek11NUF5RVo3dmp5UnM1NWZHaG83TWFhQkZj?=
 =?utf-8?B?YS9OaFh6a0pkcWg0RGhRNUdRZTVlMDhjNTlqLzV4R3QzanhMTnkzRDdjTXMy?=
 =?utf-8?B?WCtTVk82SE00NkE4THhxKzN0MklWSCszTlpJc2Rjdlk4SXdXU2JCM0ZObXpv?=
 =?utf-8?B?cTh1bEFGOStNWkFpc1QrTWVEVEVpSUxVVHI1Z2FOQ2FPdnJkWGprczAyK3d4?=
 =?utf-8?B?a0djR3RXTWl0SDFERzExT2VFK3V5STVnTHZKemNZQjIzUXFVeWZ4K09zUXdy?=
 =?utf-8?B?M2l1TzV6RGpHbU9wNklDSVc3OHRqS3Q1Q0ZiQityZExWWEhUdTBaSXUxaVNR?=
 =?utf-8?B?VlA0bkNacGpCQ0g0djJaOG13U0NtWjdXMzhLT2kvRjdxV3ArMjFzMk1wejBn?=
 =?utf-8?B?TUZZZFFrS0VKK2NGcS8xUTJhK243MjlqeW1uSmF2dm9OdkpWdzlqNnRNbnRy?=
 =?utf-8?Q?EBIpxYiwLH/JeOpZoPDD4rcwXXcqDsRHcxlbL8HtUwryl?=
x-ms-exchange-antispam-messagedata-1: 7adA76S9zfd02A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <696C0E7EA4197043B615ED71E9D37CC3@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0513a7f2-1039-4938-fadc-08da4deaedce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 09:47:43.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVSYZIHGq7HEz4WP6YLcyiPM+lzw+nGWYLdWjYQc4IBVKqFsMwLQhbzxA3Wb3yXHn4+XroVDyxu/RfqLflebudK8H2d2w9c5yZk+DvgTzdqKaSlLpBW+G4PFfpsWO0ZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0240
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xNC8yMiAxMjoxOCwgTWFyayBCcm93biB3cm90ZToNCj4gT24gVHVlLCBKdW4gMTQsIDIw
MjIgYXQgMTE6MDY6MDZBTSArMDIwMCwgTWFydGluIEtlcHBsaW5nZXIgd3JvdGU6DQo+IA0KPj4g
YW5kIHJlZ3VsYXRvcl9lbmFibGUoKSBpbiBpbXgtcGdjIGlzIGNhbGxlZCBmcm9tIGdlbnBkX3Jl
c3VtZV9ub2lycSgpLg0KPj4NCj4+IEF0IHRoaXMgcG9pbnQsIGRvZXMgYW55IHdvcmthcm91bmQg
b3IgZml4IGNvbWUgdG8geW91ciBtaW5kIEkgY291bGQNCj4+IHRlc3Q/IEkgZ3Vlc3MgaTJjIG5l
ZWRzIHRvIGJlIHJlc3VtZWQgdG9vLi4uDQo+Pg0KPj4gV2h5IGRvZXMgcG93ZXIgZG9tYWluIG9u
bHkgaW1wbGVtZW50IHJlc3VtZV9ub2lycT8gSG93IGNvdWxkIEkgdW50YW5nbGUNCj4+IHRoaXM/
DQo+IA0KPiBJbmRlZWQgLSBpZiBhIHBvd2VyIGRvbWFpbiBpcyBjb250cm9sbGluZyByZWd1bGF0
b3JzIHRoZW4gSSdkIG5vdCBleHBlY3QNCj4gdGhpbmdzIHRvIGdvIHdlbGwgaWYgaXQgdHJpZXMg
dG8gcmVzdW1lIHdpdGhvdXQgaW50ZXJydXB0cywgdGhlcmUgd2lsbA0KPiBiZSBzb21lIHRoaW5n
cyB0aGF0IGNhbiBiZSBkb25lIHB1cmVseSB3aXRoIEdQSU9zIGJ1dCB0aGF0J3MgZGVwZW5kaW5n
DQo+IG9uIHRoZSBoYXJkd2FyZSBoYXZpbmcgd2lyZWQgdGhpbmdzIHVwIHRoYXQgd2F5IGFuZCB0
aGUgb3BlcmF0aW9ucw0KPiBuZWVkZWQgYnkgdGhlIHBvd2VyIGRvbWFpbiBtYXBwaW5nIHdlbGwg
b250byB3aGF0IGNhbiBiZSBkb25lIHdpdGgNCj4gR1BJT3MuDQoNCkluIGNhc2Ugb2YgQkQ3MTgz
NyBvbmx5IHRoZSBQTUlDICdzdGF0ZSBjaGFuZ2VzJyBjb3VsZCBiZSBpbml0aWF0ZWQgYnkgDQpH
UElPLiBBbmQgaWYgdGhlIHN0YXRlIGlzIG5vdCAnUlVOJyB0aGUgcmVndWxhdG9yIGVuYWJsZS9k
aXNhYmxlIHN0YXRlIA0KY2FuIG5vdCBiZSBjb250cm9sbGVkIGJ5IHRoZSBMaW51eCBkcml2ZXIg
KG9yIC0gYXMgZmFyIGFzIEkgcmVtZW1iZXIgdGhlIA0KZHJpdmVyIEkndmUgYXV0aG9yZWQgZG9l
cyBub3Qgc3VwcG9ydCB0aGF0LiBJdCBfbWF5XyBiZSB0aGVyZSB3ZXJlIA0KZW5hYmxlL2Rpc2Fi
bGUgcmVnaXN0ZXIgZm9yIElETEUvU1VTUEVORCBzdGF0ZXMgZm9yIF9zb21lXyBvZiB0aGUgDQpC
RDcxODM3IHJlZ3VsYXRvcnMuIFNvbWUgcHJvYmFibHkgaGFkIGZpeGVkIHN0YXRlcy4gSW4gYW55
IGNhc2UsIEkgZG9uJ3QgDQp0aGluayB0aGUgZHJpdmVyIHRvdWNoZWQgdGhlbSBhZnRlciBpbml0
aWFsIHNldHVwKS4NCg0KQmVzdCBSZWdhcmRzDQotLSBNYXR0aQ0KDQoNCi0tIA0KVGhlIExpbnV4
IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExp
bnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktp
dmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlz
IHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
