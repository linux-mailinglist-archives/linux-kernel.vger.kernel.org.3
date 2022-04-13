Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1764FEFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiDMGcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiDMGb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:31:59 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120042.outbound.protection.outlook.com [40.107.12.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C498FBCB5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgcWejkgoiW3uQoQHPn05vdiKY/wm/Z7KeryqgzpUT0Qr9hLr4qX0f/s4vckqPIGFKKcJqT1qT9BtJF7UqT5ot1p/ebMURbBnuknTVm+LQ58qMD5GL1J94dijud66f+aAGLBGLJHqPsndOoYCk91MqphKhBpOCipgdhSrvS3yXzTHWLZN/C8Qc969a0GmcNruEZcFrNpy8bLGOjjbcAB/85DfWGYN7gbuzxRUVxbeBgjlwOHv450ScIPHlWKz3P0IABov8ZAYm+HBjWffMK17m8E8cvp0qeVYJYDKOvULJeOkUfeVz+HWAkHJUffC/6g/WoUXDU7hNxJoRlPJeKGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGvlBe0wyRjzWjjKgHVBF5QyoEwwwurbP4DQ1nlCCx4=;
 b=aE9RdQfvsCgNQrZnKykyFv8S9r1fdtyEKTH+iAj+7F3eRoe/CGroHLIbN60WNQ5KQmmgWoUHiqgSr+bEeKbly3HdYX1QsDskM+TKstluN13Q+ulo0iFGP++oiDpMPdmV4xzgl6QR0e7hLF+yQ9uSkDbD95BkPz6qWeUIwbKTvqXsIhGJwRAgbE49g1vUcR9XLudOXDs43YtNi8utVxW8aFRcP1cLIAkiPYRBrcOVvIvAWvq6J0INS6UZ5HtltxXFxatkYTDUsZ+V/wjAuzDTm950ZrxiAlW6U0BPCfrZ7gapf8tGI06ox2f/CTeOpvmy449Qdyb81kmZuaYbg+FIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2281.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:17::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 13 Apr
 2022 06:29:36 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%8]) with mapi id 15.20.5164.020; Wed, 13 Apr 2022
 06:29:36 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kees Cook <keescook@chromium.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] lkdtm/bugs: Don't expect thread termination without
 CONFIG_UBSAN_TRAP
Thread-Topic: [PATCH v2] lkdtm/bugs: Don't expect thread termination without
 CONFIG_UBSAN_TRAP
Thread-Index: AQHYTdhJWLzdNb2yHk642u53WzvMsKzs6CcAgAB71gA=
Date:   Wed, 13 Apr 2022 06:29:36 +0000
Message-ID: <672572c0-b698-ab5c-b99c-bc78c61db956@csgroup.eu>
References: <363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu>
 <202204121440.FEE123D7@keescook>
In-Reply-To: <202204121440.FEE123D7@keescook>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 197e3d85-0883-430a-1305-08da1d16fae9
x-ms-traffictypediagnostic: MRZP264MB2281:EE_
x-microsoft-antispam-prvs: <MRZP264MB22815263AC98F53FD024C209EDEC9@MRZP264MB2281.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6sHflbiKaGkFeEt688I7bkxYzBsdjXUoevJCkXDC/WJA6ozry0wRLJpC/87G71sjfxPxDzoBpPlX+bmNhu5zGht4NkBJug+tRFcU+8MMMIOof4yzlesK/5fPH8Si+67NAfW3mznVI6MXaazqasLfqAOiOqsQRKmQk+XfcZHc8KvrBHMpiGj0+buBL7e6xxSo5k1tLbiSeVNUsIey4P4eY150BqeI/ozzpHapHVgvfcG4/Rwt2nFdubL4AK5birHp4q9ZTWkvtvsnTZua1BYAEfuWU9sQ+JeD1uToIiulKBu4LmxQDv94hCDAoNVDPL8mzlUUmg7Iv8EJ2bfbrZHKcKYYQ4JiE1EF0xZKMHdlr6He8ClwYjkIflOl9f12C1SDkIEPSuX3rqHKqYQvarIJAWmGT4gnThlpJ3XYNkuK+RhMC4wMPgWuj8vBqWa8A/5YOhtYqQLyQXCnD1kUNroNI/L4gbx0z8UkjkFZULxJzskP23KD2Luc32hk3p3qKFl6dFolI7Ld9y4p6lQ4aylxfDChy3bbxF4VR6SCjCx4pCZOTvJtI2ztgkzQHbVCqgAyjehepq5F8oaYz+9T7VnytOTk9qQIdaOa716gUgvql3Iy1AQbEzrTitm+dl6fDGYl9NTe0FVvaWIwUmTMbvpPIiP1Ue+RcDLWmOEJ2dw7+K3FNBYwpVwP014AW9jtao1VnWXFThK9ua3PUqTokAV65VL5lBLI6pzl8Wpyogjb7UxbQ8TiF+vGq6XGTJFnaI4AEJVIcoeYDWicGQaEeBIe4LWrccoUoWVij9Dlo9QBfaGAuMGaM10pvWVEnKLFy03WKK35Yh892GooZjHKxt/Xe+xBo5bJAf7jAWWntfhoDY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(186003)(8676002)(66556008)(64756008)(66476007)(38100700002)(66446008)(66946007)(508600001)(966005)(4326008)(5660300002)(83380400001)(6486002)(122000001)(86362001)(31696002)(6512007)(2616005)(38070700005)(8936002)(44832011)(26005)(6506007)(2906002)(36756003)(31686004)(66574015)(54906003)(91956017)(71200400001)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlhacUZpWU10MWFYdStjQjY0eTN5UUFXWkkxSUpmQXZQdUlLTTlxMy9iU1pR?=
 =?utf-8?B?QnV0TTdFd00rMzRwSitkWm9pL20yUWJ3VFFuVXlaMTlWNjNoUTVrOXVvejlL?=
 =?utf-8?B?M21vZmhBRzJBNE9PZm9GYlJ5R0xZZEptU2lWVlYvTzZOaUNySWtnL3U2QVhn?=
 =?utf-8?B?aUhuM0RZS3RwUGtQeXdKeFRYakg1TVMrY0hSMGV5aHBwN1k3VUdxWGFqcEtH?=
 =?utf-8?B?MktUQ2pBYm9lbnhBN1pIM1NuV3VBTGhFbHNPeFhQMDMwUWM0ZkhoN0ZMWGZQ?=
 =?utf-8?B?a1ZwRjBJN3gvOVplUFhEVkNtV0lTVUZadWVLc0NEa2RvcVVTMmx2M21UZ0lN?=
 =?utf-8?B?S2tMckt0dTl4S00yYXYrbHRXZnZ1MjM3Q3hFZXBNc01PZXhvWTZtN2dsc2VN?=
 =?utf-8?B?Q1RuT0IxUGdLYlJJU0x6aW5CcEIxTUFDMkFHQkpabldNbWFabEdpejlzRmxI?=
 =?utf-8?B?QlBZcXNISnZxYWcrRitQa0wzejRlMlJQQ21kWlR1S2VORE8wY2p6UFVuMER3?=
 =?utf-8?B?c2FSNmoxbDE0aW1jdHRiMEFjbDVSTTZuYSsyOEQ3WHVyWm5EODFSWjRkdnB5?=
 =?utf-8?B?UTdZbTFMdWlLaHdmQ1VGKzYwa3ZiSUxweE41bGQ0VEJpcGIvRGFoanQ0czdR?=
 =?utf-8?B?WFZqNDl6RXgzTDBVWFlZeEtsL3FUSUIzSzBya0dITlBacEo3aFpCRlB3dGdo?=
 =?utf-8?B?TElXSk5QNW51MmxObkE4OHdFV1N1Tll6bkxVTXJPRWF3N2lKUFc4V2pOaDlR?=
 =?utf-8?B?QjlEYzd3Sm1YendSMmNvNzl3UGlIWGVuV2FkNlhRL05VSUh3UVo5MTd2eXND?=
 =?utf-8?B?VkdET2tabnlvQTJ0eFprcTVDZVpuRzdQRHpENjlZcFFJTmt0b1pIcVl2d0s4?=
 =?utf-8?B?OGlHU29GcEdjUmNBbUhNeDZwd3JhU2ZTV2JROW9xakE0a2I4VGlpc1F1a1cz?=
 =?utf-8?B?WXkyYWk0T3hHWlY5TlN3L2ZUa0NVZ01uaVIxYjlvUTJ6WUpmbWFGNEpULzBC?=
 =?utf-8?B?cjgxSklET21xL3g4NFl6RWY3U01KYTl5c0l1b09tZmpHbVJyeW90QU93bkI5?=
 =?utf-8?B?aHlIU0x0Mnh1bjdqUzJ0SSt0WVRlRjl4MWIyTGxTMkhULzFmMUN3MkJ2MUpS?=
 =?utf-8?B?S0Vxcmp3T0RubEVzYW45UVc3VTlqeExyWklUVUFpU2g1ZTZSK3RSSDVhNHpa?=
 =?utf-8?B?eUx6K0hxOVduOS9aQjM3a2trVXpXZndLYXQzNm1VRmdGb3VUM0I1YlFkTkRq?=
 =?utf-8?B?NlMxcmxBVVVmY09lbUtsdSsyNUdaRjVMZ2lFVnk2NWpTQ0dZdzFjNTZXOUpI?=
 =?utf-8?B?dC9iWU1wSHUrZ1dFdmpPa3J6d0xIVithZ2g3VFM2T1RVQU9sWmEzV1BVa25x?=
 =?utf-8?B?OUdoVEtTcmh2Q3p4U0RJZXhvcGdtM1N5MEhyMU16UGltcWMrSnIzUmJva2VI?=
 =?utf-8?B?OTR1MzJsMSsyOHRNVmdjaVVSSTdwczl1bU13UHAxTmFJMi9kTnI2ZkQ2RUN1?=
 =?utf-8?B?TVllZVg2WDNLSUdjbUlFdzRLYmp4b2xGUU04anBlZ1VqZG9DTzBDNm9qSnNv?=
 =?utf-8?B?dVk4TExZalVnaHl3MUJreEdia1Y2WmRGR0d2ODZkOXpwYm5acDU4V2Q4eENN?=
 =?utf-8?B?c0ljOWlaZDM3R0txbmdrSmt5aDVKL1Q3aEJLZjNBRVV2c0dtaVdLTWtDUzNt?=
 =?utf-8?B?T3BpWnJ2b3hLRW04ZE81UlhOQy9QU1RCUytYZk16T2JoMGVicXo5dHA2Qlp0?=
 =?utf-8?B?ak5ibFlYR0g2MXAzdXAzUEFWWHFydm1Pd0cxemQ3Tjc0ZTEwOXMxa1BxcU5L?=
 =?utf-8?B?WWlRQlRpM253WlN5NkEySGx1WVI2WVNDMW8zYUZlMG1DQytlUkxGdTZHU09y?=
 =?utf-8?B?cW5OQ2lQWTBkWmZUaDhLZVB3RUNObS9LVVIrWG9MbWNMcUlmU1pSUDYvTE9V?=
 =?utf-8?B?djBpQmY3ZTVUbjFCdFV1TkU1ZE1JTWhRK2d3dWE5Vk1NL0tkVEFjWXE5elM3?=
 =?utf-8?B?Wk1qdmJzWS9ocVIzUDhvM1JWYWdzL1ViaGVsTWEvZTd1NlhuRUYvSVJtdjBw?=
 =?utf-8?B?RWNBWS9pamNRc3dURkxFREZYZmdwVEdBaGZPM1BZZlk0ekxJNXExZGtvMEhH?=
 =?utf-8?B?Rks4OU1ybXZtd1NTQWovOHJtbXczV3FVY2N0TUxEY2FLQkdBQlBha0tJTEMy?=
 =?utf-8?B?UTFvdkJqUDFEU21Sb2huZ01pa0EydmFWNGpOdEV4elVkNFJvcDVwVG9OZ1NQ?=
 =?utf-8?B?eXhQc01CZjlVK2RTRzNhZzBDNFpCaVRBNWhld1JFbWdGRjJHRzIxSDZNMVA0?=
 =?utf-8?B?ajdwaDUxMlplemYyTXIzSkxUbVZJTEQ0ZjBjZFFvZVR0NHlWbVAzWWpZNkdW?=
 =?utf-8?Q?a0bQVTEM8JqKgwaGHbEOsakflmZA7EFQT9dT0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC1F2940B5457F4A965466C08088C960@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 197e3d85-0883-430a-1305-08da1d16fae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 06:29:36.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGUuVhWy6eZyYBQ/qtbpQkisvlHxS4oFOytNJtedvSSCYUKIqUaw1LuCE6b4SwH+4SuwsW2U1zcOqn+/9K4CNe786zVB/KHb3Rl5BCl/MVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2281
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDEzLzA0LzIwMjIgw6AgMDE6MDYsIEtlZXMgQ29vayBhIMOpY3JpdMKgOg0KPiBPbiBN
b24sIEFwciAxMSwgMjAyMiBhdCAwOToxMzozOVBNICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdy
b3RlOg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJv
eUBjc2dyb3VwLmV1Pg0KPiANCj4gVGhhbmtzISBJIHdpbGwgZmV0Y2ggdGhpcyBpbiBhIG1vbWVu
dCwgdGhvdWdoIEkgdHJpcHBlZCBvdmVyIHRoaXM6DQo+IA0KPiBDaGVja2luZyBmb3IgbmV3ZXIg
cmV2aXNpb25zIG9uIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8NCj4gQW5hbHl6aW5nIDEg
bWVzc2FnZXMgaW4gdGhlIHRocmVhZA0KPiBDaGVja2luZyBhdHRlc3RhdGlvbiBvbiBhbGwgbWVz
c2FnZXMsIG1heSB0YWtlIGEgbW9tZW50Li4uDQo+IC0tLQ0KPiAgICBbUEFUQ0ggdjJdIGxrZHRt
L2J1Z3M6IERvbid0IGV4cGVjdCB0aHJlYWQgdGVybWluYXRpb24gd2l0aG91dCBDT05GSUdfVUJT
QU5fVFJBUA0KPiAgICAgICsgU2lnbmVkLW9mZi1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJv
bWl1bS5vcmc+DQo+ICAgICAgKyBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzM2M2I1
ODY5MGU5MDdjNjc3MjUyNDY3YTk0ZmU0OTQ0NGM4MGVhNzYuMTY0OTcwNDM4MS5naXQuY2hyaXN0
b3BoZS5sZXJveUBjc2dyb3VwLmV1DQo+ICAgIC0tLQ0KPiAgICDinJcgTm8ga2V5OiBlZDI1NTE5
L2NocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldQ0KPiANCj4gSXMgdGhlcmUgc29tZSBwbGFjZSBJ
IGNhbiBmZXRjaCB5b3VyIGtleSBmcm9tIHRoYXQgaGFzIGEgY2hhaW4gb2YgdHJ1c3Q/DQoNCg0K
RXVoIC4uLiBJIGRvbid0IGtub3cuDQoNCkkgc2V0IHVwIHBhdGF0dCBpbiBvY3RvYnJlIHdoZW4g
eW91IGFza2VkLiBJIGd1ZXNzIEkgZ2VuZXJhdGVkIGEga2V5IA0Kd2l0aCBwYXRhdHQga2V5Z2Vu
Lg0KDQpJIGhhdmUgYSBbcGF0YXR0XSBzZWN0aW9uIGluIC5naXRjb25maWcgd2hpY2ggY29udGFp
bnM6DQoJc2lnbmluZ2tleSAgPSBlZDI1NTE5Onh4eHh4eHh4DQoJc2VsZWN0b3IgPSB4eHh4eHh4
eCAodGhlIHNhbWUgdmFsdWUgYXMgYWJvdmUpDQoNCldoYXQgc2hvdWxkIEkgZG8gbm93IGZvciB5
b3UgdG8gZ2V0IHRoZSBrZXkgPyBJIGRvbid0IGV2ZW4ga25vdyB3aGVyZSANCnRoZSBrZXkgaXMg
c3RvcmVkIGluIG15IGNvbXB1dGVyLg0KDQpUaGFua3MNCkNocmlzdG9waGU=
