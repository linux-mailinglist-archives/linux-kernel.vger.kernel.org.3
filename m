Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1652C9BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiESCSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiESCSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:18:03 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2067.outbound.protection.outlook.com [40.107.114.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00BAC5E6E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9+Acbua/8ZKyJ9SvT9E9tntO/SFTzB84DyLh+NpN/WgjZ9bP5PXUiwU4hG/GanpmrYBc15F1xx7W9BEn/0LVJVtE5oNqUfsxjDpX7GrYd9CzLdvf5zSNPZ8VO41CO6saWs97+lT90DCP6ZCx0VBHHIueuvBhG4pCOXNAEFXUMpDbzzTWQQjcN8RjmozjZYgmSkO61GFvIAf4TOtSwgSoDrhAXZfa6blQkQXjqNBCV7OJz9kjQosQnq2RjVdFAJfFS+iQHTw4xvmECOmunBCgxAOCjYcaG0UaUJh5CN5rW8oXD6ZQwSfGC+RMOVD+Ryhsas98uKTylFFKzApcnuB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuVDQOTaF3JOeER3PzX/bp+Wu/1HXMswP+sWjD7udZ4=;
 b=Gi8hhYCHbRXBQpcjHP9N9BZqe4bb+OMoeg9rvfrnmyzb8sjdjPLqzc4AlVv2aI7nWa0fKA93wOkBzkhX+K567zqQOta3mg9f5zqtjxP7U588XG+VGyUIgQjMQ5c5s1D+IpcNPxZaDXUtStOstZfNSPIg5ohZgwqeDmag5rIhAITI/XEwKSq6T1Xb+PNGxh6PN6AX8o9PjZHjHSize/nk4CtDMr2X4jEjqAgz/a45obhfQWtYXb5wESdhoqvfjJvacR5lZtkHB8qjTKnZpvfnMg9eLT3J7WVLrQ9JlTi1kiZXz9d3xyXCMy4Rn5De7sabrcrqTgAl5kam20N6p2rNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuVDQOTaF3JOeER3PzX/bp+Wu/1HXMswP+sWjD7udZ4=;
 b=l8JWJOgYcMsKG/FK/NrfR33pxVr8ayXkQD6YIMQMhnjKjYjSmnXWcqM9L0ubITYgf9MJnrtT0Un7vOCqEKpKA0sLOoT/x/M64eAGj/2iwj3yN0ttX1OwWU6oS5h6P1GWU7zBNfRBVj90lpnHAe3dsoYpFiIVLBLo3iXMF5SXcDs=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB2076.jpnprd01.prod.outlook.com (2603:1096:404:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 19 May
 2022 02:17:58 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 02:17:58 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Liu Shixin <liushixin2@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about hwpoison handling of 1GB hugepage
Thread-Topic: Question about hwpoison handling of 1GB hugepage
Thread-Index: AQHYRO39spkM6Er2D0SYmGhvNd4geaze3zIAgERjEICAAoEwgA==
Date:   Thu, 19 May 2022 02:17:58 +0000
Message-ID: <20220519021757.GA520829@hori.linux.bs1.fc.nec.co.jp>
References: <0af88a11-4dfe-9a4e-7b94-08f12caafcf3@huawei.com>
 <20220403234250.GA2217943@hori.linux.bs1.fc.nec.co.jp>
 <eae3ec5d-51ce-db2d-cc0b-f8e1d4310679@huawei.com>
In-Reply-To: <eae3ec5d-51ce-db2d-cc0b-f8e1d4310679@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b9c6b5c-9ecb-4dba-9926-08da393dcab9
x-ms-traffictypediagnostic: TY2PR01MB2076:EE_
x-microsoft-antispam-prvs: <TY2PR01MB20767FF1B2B62B7E2D6AB067E7D09@TY2PR01MB2076.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+TWOG8EUsJ7jPLF/UTDq6MryqR4uLjDYosOuNy9Oupj7ALepgtdnuR0EolvrgDl1Adt/qrnHeH4fbdj5gQ2FlwFj4smSrMd6xhk84my3HTlm25aEN4gdVGNus/NHsEriNKEEgzvgR2Hw/WkfkGKBqDlymrXn4OnLDXm+jedKNp751A+Jh5nzCw461WnlwFjnIpMq+/k9d17Chu6Lav05+3LORnYvneTH50eYP838ioPbvnjSOPAbM2iVJHAx6bM8ngVhG3D8ThNir8sdAmQzQpICsnVQLk+0CkNs/ldBp81sgwGsOhnKVBlWTgzXSCZrA61uxVsuuy9dlrYW6QhHPh9WSjbOC2eaIV3kR73vGBz9taRkXd+f018hutL+o1SiAsec2czy8z9hb8ATGWhSlPMZeTBgQQXL+STUyxeaGaSAx6dU99VYUJK1fiwSHzlVoL/nxsmZTsvR5+z4ss0XcER99cOL8p5I8oefLwdB7fkSx4TTduSFd29NPSILMu0B/JHfVOhnFFHdIMP62s+oR5HcxjPUZ2AmhcNnELvS/LUlpJm7xS9RQgzsi6tbeNjBJ6/LnAj7Ijr5+1PpwfJsjgLB/6SNzofuViEMGeiuHqu0yRR+bjb+gcroAFs3h/S51oJuCPqEpmhBaYaV8vviZ4+1FyCAaysrzz6bWXrp4/dNnT2uO3wTfvuxopZ6p1Xt8st9gm7dhEXttrHAYOc6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(316002)(54906003)(6506007)(6916009)(71200400001)(53546011)(26005)(55236004)(33656002)(85182001)(86362001)(186003)(1076003)(6486002)(2906002)(122000001)(8936002)(508600001)(66446008)(64756008)(9686003)(38070700005)(38100700002)(82960400001)(5660300002)(66556008)(8676002)(4326008)(66946007)(76116006)(6512007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGRQcFRCRitvRHhPSitTUU8vT0dJWkczYXpBbmdTeXNYMEg4eXZRdGtBUkw4?=
 =?utf-8?B?Zm1SM0dReFVlYXFaMnRmZENvUVdTKzdpcHdaU2lrblRqYlk1b1VlT04wV3R5?=
 =?utf-8?B?MTA1ZEZHYkxUVmorMXRRMlFtcy9PL3JVWHR1b3NXSVU4dmJjZUxVMmpZTk1y?=
 =?utf-8?B?aXR5Y2M3UkE5SzB6SU5qNWZlaml5S3FmZE9LZzR5RGNMWEdiZlk4TFZTTk85?=
 =?utf-8?B?WVNmL0djMGF3UmZtU0JhRHZYU3lpZEhGQ2h5VFRzUjF6SFU1ZFFSemxxcEtZ?=
 =?utf-8?B?Qmp5RFUydWRTa0ZQcnhRNk04bnQydEJScXZ1Z1BtdDRNOVhsNXRPeisxU2pN?=
 =?utf-8?B?Z09zcEdYSlFhMXYyQUlrUThiVkVYTGsyWGhUc3Jxb1NLVU1qUHk2MVEvWVFs?=
 =?utf-8?B?Z1pwTFk0ZDJUUmFJQ2xuN0gya0tQcG9adEY4NUMyb3ZGb3NFcjV5bkZXdzh4?=
 =?utf-8?B?NXJ4UTNYV0xsOGZuS0U1Mmt1b1d6VWNoY3p6bC9SeFFTTWFtSzdkYVRIYzJI?=
 =?utf-8?B?cWtFSkJpU0tZbW9tZk16d1pVMThBSzdUKzgxaHA1emN5clYvRTFiR3Z2Sy9q?=
 =?utf-8?B?eTJNd3VQTmVOY1B6VVZhT3NEcWxpNWJJdGhsWGNROTN5Rm05ZzVibTVhTnlz?=
 =?utf-8?B?bSt4bFpTS2Y0MDFxU2c5SDZoMXNDNy9kSzZiS3ZBYUU5OEVWZVRDOEMwc3dK?=
 =?utf-8?B?QmFWOVIxUytEbFo4M2V0WTQyS0xoY0UzbUNHNzhNbllNbFFwU2JEL1lWc0Jm?=
 =?utf-8?B?SmZ5VldKVTNpZWhVMTgxU3J5aXFRbzBwWjFXZmQza3l1TzNZUHhzYmJhUS91?=
 =?utf-8?B?bUVOY0J5d281UEQ5cFVHSVpIWWo0V242RUVndFlnSDJSQXFjeHZMZE5adnpj?=
 =?utf-8?B?WGdQZFBGa0JFMm5NdDgyTWNrT2RPU2tsUmVzU0FWN0VsdEhqdWRxOUFnZnpC?=
 =?utf-8?B?am5ncGlwM1N5czFyVGZhK3dkR1B4RUs2Y203OFlFWjNXMmhGckIyVHZWV0VE?=
 =?utf-8?B?MjcxYkwzVS9qdnpNR2VuTVZaalJMU3Rkdi95Um51YnA3ZHF5V2tWMjhzeTlx?=
 =?utf-8?B?WnA0Z2prYWdPZGw0L2FFazVwOXliVkl0eFU4QW91QlJxM1FGMVFVbkxjOXdh?=
 =?utf-8?B?R3ErT012WWpMQW5WVVlocURsc1JieDJPTENScVBTM1pRSS8vT2NhUGk2a2dE?=
 =?utf-8?B?NGoyZjlRbWpHN0VNcW5wNjN1ckpYbVArYnk4Rms5WUx6QzFRTnRpbC9PU09O?=
 =?utf-8?B?SE5YMmMzTGdUMkNkNHJ1THRYNEk2ajJYWTY0TUFjTS9xTzBSOWxEVGhlbUdE?=
 =?utf-8?B?UUVvZkVxY1FQS3BnaDJmT3lvSEtMZEFlVnlyZ2FUSko0dWZCa3dDUGhHVWk4?=
 =?utf-8?B?OTFabXJzSlJBdE00RXNHTkpvNjJrTU5qZGtrWFY3SVdIdzJDM3lMZVduOUlK?=
 =?utf-8?B?eVhNYlBUTnA2RENpeVA2WlViQ0ZWNmsyVVFneUk3M1Z2TFlseU5hdFQ5Z294?=
 =?utf-8?B?bnV1TTNTUnVVZGdWWU5tczRxQk9rclhvbGs2R2gzcjJkQ3FyZFhJeDlyTkxU?=
 =?utf-8?B?TUZFRldmMFpVeHZJcjlMUzh4UTdFbGcxcUVwajdKTHdvcjNCNG4wUC9yZzFC?=
 =?utf-8?B?SmtQYkU4NWMxcnh0UjNpUVhYZzN6Wk9BckIrUFV5ajJnZzR2THdCTE55aERE?=
 =?utf-8?B?Z2VaWWp4MDROcnAzVlBNKzNibzZqcFoxMmxIMmxQRko5aGNSSHVyZFNhWlJY?=
 =?utf-8?B?QkpWSGQ5Mmk4TEoyQndMajBFU2h5aUZCNFRJYkw5VXlBS3h3SVZXL0E0MkhD?=
 =?utf-8?B?TkRLbGliY01DcUw5aVByMG1PWXBlRWJoMVpEajlROTZVL1VrRVh5T3p4b283?=
 =?utf-8?B?QmltamptRnpBZlpHM0J4cEpIa2pzbFFLYWU5RkFwZ0tGT3BzZmZXUzNzdzF6?=
 =?utf-8?B?RHNSRzdSWVErNFcrTS9BeGV2UlcrK1lWMTdkOTVHVjRhdzY0c3hvVUlhb0tn?=
 =?utf-8?B?RmxaaW5uY0pmYnJ6dkxtQ21ZZktLSXhVb3phbytLdm12TkdMeDlyZUxxVkFR?=
 =?utf-8?B?VkVuT0orS0JKME1aM0ZQSkFZcUQxYlFDU2paRkZuOTA1U2s1anN5RUlJcFln?=
 =?utf-8?B?LzRHYnFXeHFza0hoa1JjVTJITS9Zd0ZkaDVKVTRWWVpNV0FDczBlMWFNaXFD?=
 =?utf-8?B?QU5iNzFDbzBaNHduV3pDTjFpSVJBL1pQb28ySUVSSEp1UzFPZ01mSFh0aFM1?=
 =?utf-8?B?T05UOXY1aUdweVRtbVU5VExhbGYwZjRvcjJhVWJHQ0FXNUFJM2hMQnlLU1Bq?=
 =?utf-8?B?RlNFR2NZYXBNMjduRDRKOHZ6eXM2dmJLRXBreTBYZVVRUHVCQVpTNlBEVDF3?=
 =?utf-8?Q?QM2TKlHGgq8eCxkg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <377915C08588504DA43A02EE802E3A0F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9c6b5c-9ecb-4dba-9926-08da393dcab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 02:17:58.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCCspZm7k8gWECAsr7doTUAYHXZyt15cbLIIdaq1+UoWq3f64bX4J2/HEvMhd5najlc3I0Krd/ofIiyUFAG4SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXkgMTcsIDIwMjIgYXQgMDg6MDM6MDNQTSArMDgwMCwgTGl1IFNoaXhpbiB3cm90
ZToNCj4gSGVsbG8gTmFveWEsDQo+IA0KPiBJcyB0aGVyZSBhbnkgcHJvZ3Jlc3Mgb24gbWVtb3J5
IGVycm9yIGhhbmRsaW5nIG9uIDFHQiBodWdlcGFnZSA6ICkNCg0KSGkgU2hpeGluLA0KDQpJIGhh
dmUgYSBsaXR0bGUgLi4uLCBJIGZvdW5kIHRoYXQgZXJyb3IgaGFuZGxpbmcgZmFpbHMgZm9yIGFu
b255bW91cyAxR0INCmh1Z2VwYWdlIGJlY2F1c2UgX19wYWdlX2hhbmRsZV9wb2lzb24oKSBmYWls
cy4gIEkgZG9uJ3QgcGlucG9pbnQgdGhlIGlzc3VlDQpwcmVjaXNlbHkgeWV0LCBidXQgSSBmZWVs
IHRoYXQgdGhlcmUncyBzb21lIGlzc3VlIGluIGZyZWVfZ2lnYW50aWNfcGFnZSgpDQp0aGF0IGZh
aWxzIHRvIHNlbmQgdGhlIHZpY3RpbSByYXcgcGFnZSB0byBidWRkeS4gIEkgZG9uJ3QgdGhpbmsg
dGhhdCB0aGlzIGlzDQphbiBjcml0aWNhbCBpc3N1ZSBiZWNhdXNlIHRoZSBlcnJvciBwYWdlIHNo
b3VsZCBub3QgYmUgcmV1c2VkIChpdCdzIGlzb2xhdGVkDQpidXQgbm90IGluIGNvbnRyb2xsZWQg
bWFubmVyKS4gIFRoaXMgcHJldmVudHMgdW5wb2lzb25pbmcgYW5kIG1ha2UgdGVzdGluZw0KaW5l
ZmZpY2llbnQsIHNvIEknZCBsaWtlIHRvIGZpeC4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
DQoNCj4gDQo+IFRoYW5rcywNCj4gTGl1IFNoaXhpbg0KPiANCj4gT24gMjAyMi80LzQgNzo0Miwg
SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nykgd3JvdGU6DQo+ID4gT24gVGh1LCBNYXIg
MzEsIDIwMjIgYXQgMDY6NTY6MjVQTSArMDgwMCwgTGl1IFNoaXhpbiB3cm90ZToNCj4gPj4gSGks
DQo+ID4+DQo+ID4+IFJlY2VudGx5LCBJIGZvdW5kIGEgcHJvYmxlbSB3aXRoIGh3cG9pc29uIDFH
QiBodWdlcGFnZS4NCj4gPj4gSSBjcmVhdGVkIGEgcHJvY2VzcyBhbmQgbWFwcGVkIDFHQiBodWdl
cGFnZS4gVGhpcyBwcm9jZXNzIHdpbGwgdGhlbiBmb3JrIGENCj4gPj4gY2hpbGQgcHJvY2VzcyBh
bmQgd3JpdGUvcmVhZCB0aGlzIDFHQiBodWdlcGFnZS4gVGhlbiBJIGluamVjdCBod3BvaXNvbiBp
bnRvDQo+ID4+IHRoaXMgMUdCIGh1Z2VwYWdlLiBUaGUgY2hpbGQgcHJvY2VzcyB0cmlnZ2VycyB0
aGUgbWVtb3J5IGZhaWx1cmUgYW5kIGlzDQo+ID4+IGJlaW5nIGtpbGxlZCBhcyBleHBlY3RlZC4g
QWZ0ZXIgdGhpcywgdGhlIHBhcmVudCBwcm9jZXNzIHdpbGwgdHJ5IHRvIGZvcmsgYQ0KPiA+PiBu
ZXcgY2hpbGQgcHJvY2VzcyBhbmQgZG8gdGhlIHNhbWUgdGhpbmcuIEl0IGlzIGtpbGxlZCBhZ2Fp
biBhbmQgZmluYWxseSBpdA0KPiA+PiBnb2VzIGludG8gc3VjaCBhbiBpbmZpbml0ZSBsb29wLiBJ
IGZvdW5kIHRoaXMgd2FzIGNhdXNlZCBieQ0KPiA+PiBjb21taXQgMzEyODZhODQ4NGE4ICgibW06
IGh3cG9pc29uOiBkaXNhYmxlIG1lbW9yeSBlcnJvciBoYW5kbGluZyBvbiAxR0IgaHVnZXBhZ2Ui
KQ0KPiA+IEhlbGxvIFNoaXhpbiwNCj4gPg0KPiA+IEl0J3MgbGl0dGxlIHVuY2xlYXIgdG8gbWUg
YWJvdXQgd2hhdCBiZWhhdmlvciB5b3UgYXJlIGV4cGVjdGluZyBhbmQNCj4gPiB3aGF0IHRoZSBp
bmZpbml0ZSBsb29wIHJlcGVhdHMsIGNvdWxkIHlvdSBleHBsYWluIGxpdHRsZSBtb3JlIGFib3V0
IHRoZW0/DQo+ID4gKEkgYnJpZWZseSB0cmllZCB0byByZXByb2R1Y2UgaXQsIGJ1dCBkaWRuJ3Qg
bWFrZSBpdC4uLikNCj4gPg0KPiA+PiBJdCBsb29rcyBsaWtlIHRoZXJlIGlzIGEgYnVnIGZvciBo
d3BvaXNvbiAxR0IgaHVnZXBhZ2Ugc28gSSB0cnkgdG8gcmVwcm9kdWNlDQo+ID4+IHRoZSBidWcg
ZGVzY3JpYmVkLiBBZnRlciB0cnlpbmcgdG8gcmV2ZXJ0IHRoZSBwYXRjaCBpbiBhbiBlYXJsaWVy
IHZlcnNpb24gb2YNCj4gPj4gdGhlIGtlcm5lbCwgSSByZXByb2R1Y2UgdGhlIGJ1ZyBkZXNjcmli
ZWQuIFRoZW4gSSB0cnkgdG8gcmV2ZXJ0IHRoZSBwYXRjaCBpbg0KPiA+PiBsYXRlc3QgdmVyc2lv
biwgYW5kIGZpbmQgdGhlIGJ1ZyBpcyBubyBsb25nZXIgcmVwcm9kdWNlZC4NCj4gPj4NCj4gPj4g
SSBjb21wYXJlIHRoZSBjb2RlIHBhdGhzIG9mIDEgR0IgaHVnZXBhZ2UgYW5kIDIgTUIgaHVnZXBh
Z2UgZm9yIHNlY29uZCBtYWR2aXNlKE1BRFZfSFdQT0lTT04pLA0KPiA+PiBhbmQgZmluZCB0aGF0
IHRoZSBwcm9ibGVtIGlzIGNhdXNlZCBiZWNhdXNlIGluIGd1cF9wdWRfcmFuZ2UoKSwgcHVkX25v
bmUoKSBhbmQNCj4gPj4gcHVkX2h1Z2UoKSBib3RoIHJldHVybiBmYWxzZSBhbmQgdGhlbiB0cmln
Z2VyIHRoZSBidWcuIEJ1dCBpbiBndXBfcG1kX3JhbmdlKCksDQo+ID4+IHRoZSBwbWRfbm9uZSgp
IGlzIG1vZGlmaWVkIHRvIHBtZF9wcmVzZW50KCkgd2hpY2ggd2lsbCBtYWtlIGNvZGUgcmV0dXJu
IGRpcmVjdGx5Lg0KPiA+PiBUaGUgSSBmaW5kIHRoYXQgaXQgaXMgY29tbWl0IDE1NDk0NTIwYjc3
NiAoIm1tOiBmaXggZ3VwX3B1ZF9yYW5nZSIpIHdoaWNoDQo+ID4+IGNhdXNlIGxhdGVzdCB2ZXJz
aW9uIG5vdCByZXByb2R1Y2VkLiBJIGJhY2twb3J0IGNvbW1pdCAxNTQ5NDUyMGI3NzYgaW4NCj4g
Pj4gZWFybGllciB2ZXJzaW9uIGFuZCBmaW5kIHRoZSBidWcgaXMgbm8gbG9uZ2VyIHJlcHJvZHVj
ZWQgZWl0aGVyLg0KPiA+IFRoYW5rIHlvdSBmb3IgdGhlIGFuYWx5c2lzLg0KPiA+IFNvIHRoaXMg
cGF0Y2ggbWlnaHQgbWFrZSAzMTI4NmE4NDg0YTggdW5uZWNlc3NhcnksIHRoYXQncyBhIGdvb2Qg
bmV3cy4NCj4gPg0KPiA+PiBTbyBJJ2QgbGlrZSB0byBjb25zdWx0IHRoYXQgaXMgaXQgdGhlIHRp
bWUgdG8gcmV2ZXJ0IGNvbW1pdCAzMTI4NmE4NDg0YTg/DQo+ID4+IE9yIGlmIHdlIG1vZGlmeSBw
dWRfaHVnZSB0byBiZSBzaW1pbGFyIHdpdGggcG1kX2h1Z2UsIGlzIGl0IHN1ZmZpY2llbnQ/DQo+
ID4+DQo+ID4+IEkgYWxzbyBub3RpY2VkIHRoZXJlIGlzIGEgVE9ETyBjb21tZW50IGluIG1lbW9y
eV9mYWlsdXJlX2h1Z2V0bGIoKToNCj4gPj4gICAgIC0gY29udmVyc2lvbiBvZiBhIHB1ZCB0aGF0
IG1hcHMgYW4gZXJyb3IgaHVnZXRsYiBpbnRvIGh3cG9pc29uDQo+ID4+ICAgICAgIGVudHJ5IHBy
b3Blcmx5IHdvcmtzLCBhbmQNCj4gPj4gICAgIC0gb3RoZXIgbW0gY29kZSB3YWxraW5nIG92ZXIg
cGFnZSB0YWJsZSBpcyBhd2FyZSBvZiBwdWQtYWxpZ25lZA0KPiA+PiAgICAgICBod3BvaXNvbiBl
bnRyaWVzLiANCj4gPiBUaGVzZSBhcmUgc2ltcGx5IG1pbmltdW0gcmVxdWlyZW1lbnRzLCBidXQg
bWlnaHQgbm90IGJlIHN1ZmZpY2llbnQuDQo+ID4gV2UgbmVlZCB0ZXN0aW5nICh3aXRoIHJlbW92
aW5nIDMxMjg2YTg0ODRhOCkgdG8gbWFrZSBzdXJlIHRoYXQNCj4gPiB0aGVyZSdzIG5vIGlzc3Vl
cyBvbiBzb21lIGNvcm5lciBjYXNlcy4NCj4gPiAoSSBzdGFydCB0byBleHRlbmQgZXhpc3Rpbmcg
aHVnZXRsYi1yZWxhdGVkIHRlc3RjYXNlcyB0byAxR0Igb25lcy4pDQo+ID4NCj4gPiBUaGFua3Ms
DQo+ID4gTmFveWEgSG9yaWd1Y2hpDQo+ID4NCj4gPj4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgdGhl
IGFib3ZlIGZpeCBhcmUgc3VmZmljaWVudCwgc28gaXMgdGhlcmUgYW55dGhpbmcgZWxzZSBuZWVk
DQo+ID4+IHRvIGFuYWx5c2lzIHRoYXQgSSBoYXZlbid0IGNvbnNpZGVyZWQ/
