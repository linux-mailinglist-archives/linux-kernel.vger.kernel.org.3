Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50A58F273
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiHJSgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiHJSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:36:10 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11010011.outbound.protection.outlook.com [52.101.51.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D599B6B66C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgFJWko70q/sAbit8Zzvxia8EN2YeVye+IsQ++Pq0l0fdT1G9kD+ePaCy3B7K7rKB+Uu8gO1/Fu2qjI2Al4XrjsautB4yAKad0uSoSZ1djyO0w8c+1/EdZAl3liVbchzpUsBeBiaUqsB+1Iq+dQBE8GBFoY136GBJAJxQwc6rvGorQK64QNCaJVx+SNk4Zo5+sulxjqkzwn3Ysp6vgCLaPlBVSzXIm5De3r8lqDQfYv8RDMj1YC6B0k5Cm8Pq6pnYhA/dEd+gR8vcZwXIM2xusytBX+xcyDw1YWsAQ1ivHigzrbFJF0XEfeUlWSl1LkF5D9s53HnONPZjr8Qz5Wfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ERByfknKAylvYFTVWp3GGMNhT9OKeL1sYXyDMUYClc=;
 b=J0Pnv+CGHLHmShgq+8Ww+D6LJS2mUo26MmsSU4KSkjnC1GuGBF9rO3pNM0po/yfAvHZwBFPsyCDC74LNh6l1qftGkEW6CYnPfNRK7wlPLXPE4BOWQLLU6z0NT7i6ig3NrN0AqgxdLFvPoM78Mc25jSiyoJGQvcm1D9jiwYdlE2+1A4poGUd/khhpV8BYqj28pOC6oeutMHfGN68X7anwfMgpsNYfYmWwn85yNkkXRNcU0Rp+0JxuGXxJMyOwljIlnC4WJuszyT4kXIJcy151KwLU2ttswFEL2XpCw0kh0QfSu2lSMiS9Vml6lsVYKUXfRAVSJPO65Vg6xwYtw387Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ERByfknKAylvYFTVWp3GGMNhT9OKeL1sYXyDMUYClc=;
 b=JsvAJ6kTBjiZf55MDxcJJdR7uCa61H6pTE41133DfVaFDm2W6G63+nGn+gFxlDs3xrNQBqon70tpknLgQOkPhAFE5SGEYQsCMQeU/Dt2Gwntd2Dj6og38HHtaSn3KTiAQJdfWRhhGJ0o3my6/RN0Dtc3haS0tFHTIM2qHvlX4fU=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SN6PR05MB4429.namprd05.prod.outlook.com (2603:10b6:805:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.9; Wed, 10 Aug
 2022 18:36:03 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%8]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 18:36:02 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Vishnu Dasa <vdasa@vmware.com>
CC:     "Dae R. Jeong" <threeearcat@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Pv-drivers] general protection fault in vmci_host_poll
Thread-Topic: [Pv-drivers] general protection fault in vmci_host_poll
Thread-Index: AQHYlRUw3jUKUNdyf06vNUbt7DhwMa2onBGAgAAJ2IA=
Date:   Wed, 10 Aug 2022 18:36:02 +0000
Message-ID: <4B3A80B8-12F1-4695-90CA-EB6E560833A1@vmware.com>
References: <YswCW3yBdaI7CkOn@archdragon>
 <465D4025-6451-4810-B816-E93D255BE9A8@vmware.com>
In-Reply-To: <465D4025-6451-4810-B816-E93D255BE9A8@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83c7ac08-e30b-48bb-30bc-08da7aff2db8
x-ms-traffictypediagnostic: SN6PR05MB4429:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uUsNlVjxmMCSMGasaW4DNfCjc9Um61wgt0iu3P6oOIiDtsYvGq7pCKBt5/YmKL7SPKM5pW7R6y4mgqMXeKSkARHEcfk1yBJCry0UvQDSFLt0Lg9i4nWpubYIbdJP6CyB0LoQA1zNFT9KwOw00A+z1iqior/cQNy/t8zyT8z4wBoszH3GsJqM4TmtgEK8pXo5YO7jqqm4cmR/VWDM9mgOocE6Cqbyp71I5T6d0wyYCqyX4x9Njz4t9tGPo/q+m5Q8mg+ZfP8YY5YeccSbuJpE8kEEeSNoSxOW+gcdoyv8wklWQ2HE0tIG0kX3wuNIXEudVSqs22brICjK/cTNbdvgi2wsaS/K371kr4TWEzi3Cu/wJKVebjtaKxg01huhKfWDS9de5FFxDr0zVTNfOlFDU+vIymvJLU/MRJmWU3C+1PpqKVHBENTu8sKYLxfeQ8/fIwaivFalQmqZVX/X+DTmyJwaOIbfIVU1OQpOAv5Cn/hg0r+ASEqeJHXJ9thziwJWDMMV7Iao4J0CbfZCZDFKJU84iUAVo5Iaca+h/7x6HayfbpY49HD67pgUZplRFMWTPgNivSRSW/245tdjiPxTwa+ZA7QYKk8swgFtw5hUjEQ6QEsZQTLQ1rfTYOCDnqrhW1REeZ4b8ujc0XO7mUaOYYlG791sDvhOZqClfFGeeWlnUgwtj5YwRU5MbpbL/h8EHu+kmlVk1LFyI49S1S0S/rIpwRA3y/x2s/A/z6FKTRN9FIIZjvQ5L5bNJWXYTy+8FEzdr84n5n6f7M3Lvf7qoCFRNiRoYcn17KK1JtQKRhjs4N561f/JTrE3NofUcZ8hoTFfjjgDP5MpRlN5kmFag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(6506007)(33656002)(41300700001)(122000001)(6512007)(71200400001)(83380400001)(6862004)(26005)(86362001)(2616005)(8936002)(478600001)(53546011)(8676002)(76116006)(6486002)(66556008)(66476007)(66446008)(64756008)(316002)(6636002)(37006003)(186003)(54906003)(38070700005)(66946007)(5660300002)(4326008)(36756003)(38100700002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWYwWnNZOW1yZVJKbWVrMTBNMVRWcHVRRFFTdVFEOUhGaDBubzdLZFF6R1JG?=
 =?utf-8?B?ZDNxdDR6TGV2SXdtdXJnR0N4TXRYVk10NGdqOVJBTml1ZVpXYUJJenNZK2VX?=
 =?utf-8?B?V0VXbS9kc25RZTlkZXNLek1ieHVNV3hrNWgzdmlpZktZMFcvT2tCYVNxdmNk?=
 =?utf-8?B?cHFqeEIwekh0MkU3RzlmbGtpUzVMeHNpaS9ZWndsdXNKeTVmUUJhOW10SXU0?=
 =?utf-8?B?bjBOSWVIa2hnZjhsY0tWTlN5MDhMOVVxUkhCd1hxZ1hoTGRuOFYyZHczUnFT?=
 =?utf-8?B?Vi9HbzEwR1YxeWI1aEp5Y3NTaGJaUU4yMzQ3WnlWZHhxWkVVTm1oeEVtbEJN?=
 =?utf-8?B?Z3JyMVduQjM3TjRhU01OVDRzdE93U1MyK3lGVWdjelJXWFA2QU14ZVkwWjh5?=
 =?utf-8?B?d3NTc014QjNIOENiU2RKK3pDL25mOFhBZmZsRkp0aW1kblBhMWVZVlR1K3cv?=
 =?utf-8?B?VmRaYVROb2JZWElqWnJpQ1JwY1ZFWU9PaStEQ1NnUytnUndvVEdsUDdqT3gx?=
 =?utf-8?B?TUNrQWw1azJsMWZmdUlFNTd4VDMzZHhmUFJITjhpZHBSeittTHMvTVBtdzdJ?=
 =?utf-8?B?UHFFQVN4Y3Y2c3YrQ3NaajNOK0U2VjF3a0lXRzRsRjVKRXlNQVliallua09t?=
 =?utf-8?B?WEJEOUJ1ZHNKSTI1a29KVGdZOEN1TGxNdWFNSHdDeGtxUklUTzYrdUhoN1Rm?=
 =?utf-8?B?aTdpWVRnNE52OVJYRHM2ZTdYc28yOHJNdG1HNlZqU0ZCYlBMazVmWjVITHJv?=
 =?utf-8?B?N3E1SHhlejBxN3NOLzh4VlVHaEY4aVB4NWN2aE1ia1dCc2lRd1pReG9MOC83?=
 =?utf-8?B?bWZGTkl1bEc2akdvd1NmTDk4bjhWdVJOMlh5RTFpRU15ZWdKb3pJMUVINi83?=
 =?utf-8?B?VS9wWnBFd1libjNoamxIclMydzNzSEUwT0NKa1BkSHFpSkdVcTJPdlJIS3Y0?=
 =?utf-8?B?L3NWOFZhVXVkZmxoV2h3czk5cS9CY3R0MSszSnVnTVlKck43eHo2dTZ2WFJE?=
 =?utf-8?B?bWdLVUx5MGExU0xGSEpMOHQzblQrZmlzekd4MzhCMVRlQ1hzZENBVDlZRE1K?=
 =?utf-8?B?SXNtelFic3BIN1I2VmNTdkUyYlFRbytTM1ZWM3BCZjhHYUFNdmJsbndFUkRN?=
 =?utf-8?B?aEUyaHA4N2h1L3dHL2JlVmw5UE5TdzllWHBQNVB0akVEUFIvNHBjMStxd0Fm?=
 =?utf-8?B?R0FjeWxXc3NSdHJXQVdOU1Y0U2RQSlJpYzhXai93b0paMUFlU3hTU1ZKZHpC?=
 =?utf-8?B?NHN3azJoUGlQZ3pkTzZRMGZ3RjM3RFZTTmZCaXdWVkEwRTdnNkRxMS9EdTJZ?=
 =?utf-8?B?Wk4vaDFYRkN3MlRFZ0g0NmdkUW1UUGdzRExlYTVDM0ZmNllsMkswREgzeXAr?=
 =?utf-8?B?WjRYZlFIcHdtaXNPK04wKzltQ0x0bUhSb1hIQU9HZzM4VzlXSG5mSXJSajdt?=
 =?utf-8?B?YkUzK28zVUdZMVNXRlY2UzduT1M2WUIya1ovTENCbXV5UW9RR1o4eTk2ZmJk?=
 =?utf-8?B?MWQyMlFBaVZqY1hIRGpqb1BXaUNib3pZSk0xT1RqaTVWOFREaVZGZm8rYXFE?=
 =?utf-8?B?Y1NYczZyRGl1RXkzakJBNlRjRzQ1dHlXUkxpdVcwQTVFK0JBUXp5TjUyYkVz?=
 =?utf-8?B?TWhwWGtZcmVXU2U4b05VMXpYUkhnM3Z3VDNYaThCbWRkWStpdFFDZjBZVFQ2?=
 =?utf-8?B?NWkzZWd5b2xxN09WVVMvZWhwdTYzdWh5bXNhRnNHREE4dERhUGhyVldQRHNR?=
 =?utf-8?B?MElBL2pPMWErYXpmcDFCN3JVZTVLTlZDVjVPMEZ3UW1ndXE1ZTRBMENOTFlG?=
 =?utf-8?B?L3puY3VDQ0llZmdDdGFWOVIyTU5Gc2lIVTU3aFMrUmlJRDFSVzlXVFlkbWVT?=
 =?utf-8?B?K3Vxb1h4S0VVYkVUcjE4amRXNmZlMGNESVNBUXQ3d3NZNlJaTW14cUlFbnBk?=
 =?utf-8?B?Ykx1dU1yWW1Dc2FjVG52TXVnOGtlYVZkWEhxWTZpRHBzUUdWdE9veEJ6S2FV?=
 =?utf-8?B?dVY0R1BrWHh5V0FCMXN3SFVXQzhna25EUFNjV1crUHBvQktjRTJZQVRHMzBo?=
 =?utf-8?B?eG84TU5YNjRZOFArYTFZZFFodVRyVkttWU5RV3BkVDBrK09nNm1xanNvUW50?=
 =?utf-8?Q?dv9GBVl7mJ4f+QiFMSazwzSwj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E607D8131785394BBB2950C0C6E8A6AF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c7ac08-e30b-48bb-30bc-08da7aff2db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 18:36:02.8329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/Dg1jd2f1HRvYHTUbzQ0BuKEl++NfRehQf6j0d9vZ+VoRmMEkC7+RqoQxK6uNnKgMRghvLN6J1rbZv8a7Ybww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4429
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQXVnIDEwLCAyMDIyLCBhdCAxMTowMCBBTSwgVmlzaG51IERhc2EgPHZkYXNhQHZtd2FyZS5j
b20+IHdyb3RlOg0KDQo+IFRoYW5rIHlvdSBmb3IgcmVwb3J0aW5nIHRoaXMuICBXZSBoYXZlIGZp
bGVkIGFuIGludGVybmFsIGJ1ZyBhbmQgd2lsbCBsb29rIGludG8gaXQuDQo+IA0KPiBSZWdhcmRz
LA0KPiBWaXNobnUNCj4gDQo+PiBPbiBKdWwgMTEsIDIwMjIsIGF0IDM6NTggQU0sIERhZSBSLiBK
ZW9uZyA8dGhyZWVlYXJjYXRAZ21haWwuY29tPiB3cm90ZToNCj4+IA0KPj4g4pqgIEV4dGVybmFs
IEVtYWlsDQo+PiANCj4+IEhlbGxvLA0KPj4gDQo+PiBXZSBvYnNlcnZlZCBhIGNyYXNoICJnZW5l
cmFsIHByb3RlY3Rpb24gZmF1bHQgaW4gdm1jaV9ob3N0X3BvbGwiDQo+PiBkdXJpbmcgZnV6emlu
Zy4NCj4+IA0KPj4gVW5mb3J0dW5hdGVseSwgd2UgaGF2ZSBub3QgZm91bmQgYSByZXByb2R1Y2Vy
IGZvciB0aGUgY3Jhc2ggeWV0LiBXZQ0KPj4gd2lsbCBpbmZvcm0geW91IGlmIHdlIGhhdmUgYW55
IHVwZGF0ZSBvbiB0aGlzIGNyYXNoLg0KPj4gDQo+PiBEZXRhaWxlZCBjcmFzaCBpbmZvcm1hdGlv
biBpcyBhdHRhY2hlZCBhdCB0aGUgZW5kIG9mIHRoaXMgZW1haWwuDQo+PiANCj4+IA0KPj4gQmVz
dCByZWdhcmRzLA0KPj4gRGFlIFIuIEplb25nDQo+PiAtLS0tLS0NCj4+IA0KPj4gLSBLZXJuZWwg
Y29tbWl0Og0KPj4gOTJmMjBmZjcyMDY2ZA0KPj4gDQo+PiAtIENyYXNoIHJlcG9ydDoNCj4+IGdl
bmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmljYWwgYWRkcmVz
cyAweGRmZmZmYzAwMDAwMDAwMGI6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBLQVNBTg0KPj4gS0FT
QU46IG51bGwtcHRyLWRlcmVmIGluIHJhbmdlIFsweDAwMDAwMDAwMDAwMDAwNTgtMHgwMDAwMDAw
MDAwMDAwMDVmXQ0KPj4gQ1BVOiAyIFBJRDogMTAzMzcgQ29tbTogc3l6LWV4ZWN1dG9yLjAgTm90
IHRhaW50ZWQgNS4xOS4wLXJjMy0zMjI4OC1nMGYzYjA4Mjk5NDk0ICMxNQ0KPj4gSGFyZHdhcmUg
bmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVsLTEu
MTQuMC0wLWcxNTU4MjFhMTk5MGItcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNA0KPj4gUklQ
OiAwMDEwOl9fbG9ja19hY3F1aXJlKzB4ZjMvMHg1ZTAwIGtlcm5lbC9sb2NraW5nL2xvY2tkZXAu
Yzo0OTI2DQo+PiBDb2RlOiA4OSBiYyAyNCA4OCAwMCAwMCAwMCAwZiA4NSAwMiAyNyAwMCAwMCA4
MyAzZCAxYiAxNiA2NiAxMCAwMCAwZiA4NCA5NyA0MyAwMCAwMCA4MyAzZCBkNiBlYSBmOSAwZSAw
MCA3NCAzMSA0OCA4OSBmOCA0OCBjMSBlOCAwMyA8NDI+IDgwIDNjIDAwIDAwIDc0IDE3IGU4IDgx
IDYzIDg2IDAwIDQ4IDhiIGJjIDI0IDg4IDAwIDAwIDAwIDQ5IGI4DQo+PiBSU1A6IDAwMTg6ZmZm
ZmM5MDAwMzcyNzMyMCBFRkxBR1M6IDAwMDEwMDAyDQo+PiBSQVg6IDAwMDAwMDAwMDAwMDAwMGIg
UkJYOiAwMDAwMDAwMDAwMDAwMDAxIFJDWDogMWZmZmY5MjAwMDZlNGU4NA0KPj4gUkRYOiAwMDAw
MDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IDAwMDAwMDAwMDAwMDAwNTgN
Cj4+IFJCUDogZmZmZmM5MDAwMzcyNzZiMCBSMDg6IGRmZmZmYzAwMDAwMDAwMDAgUjA5OiAwMDAw
MDAwMDAwMDAwMDAwDQo+PiBSMTA6IGZmZmZmYmZmZjIzOTRkNWUgUjExOiAwMDAwMDAwMDAwMDAw
MDAwIFIxMjogMDAwMDAwMDAwMDAwMDAwMA0KPj4gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDog
MDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDANCj4+IEZTOiAgMDAwMDdmYzIx
YjExYTcwMCgwMDAwKSBHUzpmZmZmODg4MGI5MzAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAw
MDAwMDANCj4+IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAw
MzMNCj4+IENSMjogMDAwMDU1YjhjZmFmZDdkMCBDUjM6IDAwMDAwMDAwMWM0YWEwMDAgQ1I0OiAw
MDAwMDAwMDAwMzUwNmUwDQo+PiBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAw
MDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMA0KPj4gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERS
NjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANCj4+IENhbGwgVHJhY2U6
DQo+PiA8VEFTSz4NCj4+IGxvY2tfYWNxdWlyZSsweDFhNC8weDRhMCBrZXJuZWwvbG9ja2luZy9s
b2NrZGVwLmM6NTY3Mg0KPj4gX19yYXdfc3Bpbl9sb2NrIGluY2x1ZGUvbGludXgvc3BpbmxvY2tf
YXBpX3NtcC5oOjEzMyBbaW5saW5lXQ0KPj4gX3Jhd19zcGluX2xvY2srMHgyYS8weDQwIGtlcm5l
bC9sb2NraW5nL3NwaW5sb2NrLmM6MTU0DQo+PiBzcGluX2xvY2sgaW5jbHVkZS9saW51eC9zcGlu
bG9jay5oOjM0OSBbaW5saW5lXQ0KPj4gdm1jaV9ob3N0X3BvbGwrMHgxNmIvMHgyYjAgZHJpdmVy
cy9taXNjL3Ztd192bWNpL3ZtY2lfaG9zdC5jOjE3Nw0KPj4gdmZzX3BvbGwgaW5jbHVkZS9saW51
eC9wb2xsLmg6ODggW2lubGluZV0NCj4+IGRvX3BvbGxmZCBmcy9zZWxlY3QuYzo4NzMgW2lubGlu
ZV0NCj4+IGRvX3BvbGwgZnMvc2VsZWN0LmM6OTIxIFtpbmxpbmVdDQo+PiBkb19zeXNfcG9sbCsw
eGM3Yy8weDFhYTAgZnMvc2VsZWN0LmM6MTAxNQ0KPj4gX19kb19zeXNfcHBvbGwgZnMvc2VsZWN0
LmM6MTEyMSBbaW5saW5lXQ0KPj4gX19zZV9zeXNfcHBvbGwrMHgyY2MvMHgzMzAgZnMvc2VsZWN0
LmM6MTEwMQ0KPj4gZG9fc3lzY2FsbF94NjQgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NTEgW2lu
bGluZV0NCj4+IGRvX3N5c2NhbGxfNjQrMHg0ZS8weGEwIGFyY2gveDg2L2VudHJ5L2NvbW1vbi5j
OjgyDQo+PiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0Ni8weGIwDQo+PiBSSVA6
IDAwMzM6MHg0NzhkYzkNCg0KTm90IG15IG1vZHVsZSwgc28ganVzdCBzaGFyaW5nIG15IDIgY2Vu
dHM6DQoNCkl0IHNlZW1zIHRoYXQgdGhpcyBpcyBhIGJ1ZyB0aGF0IGlzIHJlbGF0ZWQgdG8gaW50
ZXJhY3Rpb24gYmV0d2VlbiBkaWZmZXJlbnQNCmRlYnVnZ2luZyBmZWF0dXJlcywgYW5kIGl0IG1p
Z2h0IG5vdCBiZSByZWxhdGVkIHRvIFZNQ0kuIElJVUMsIEtBU0FOIGlzDQp5ZWxsaW5nIGF0IGxv
Y2stZGVwZW5kZW5jeSBjaGVja2VyLg0KDQpUaGUgY29kZSB0aGF0IHRoZSBmYWlsdXJlIHBvaW50
cyB0byBpcyB0aGUgZW50cnkgdG8gdGhlIGxvY2tfcmVsZWFzZSgpLA0Kd2hpY2ggcmFpc2VzIHRo
ZSBxdWVzdGlvbiB3aGV0aGVyIGFkZGl0aW9uYWwgZGVidWcgZmVhdHVyZXMgd2VyZSBlbmFibGVk
DQpkdXJpbmcgdGhlIGZhaWx1cmUsIHNwZWNpZmljYWxseSBmdHJhY2UgZnVuY3Rpb24gdHJhY2Vy
IG9yIGtwcm9iZXMuDQoNCg==
