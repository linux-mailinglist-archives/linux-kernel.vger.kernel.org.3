Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD504CEF44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 02:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiCGB5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 20:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCGB5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:57:06 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9792B13DF8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 17:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/F/6cpXixf6Tfwg8E3BngdsBZWqfkeaGtzWtoKazSytsjNFQtOj9S4X+hT4S9dRjWZE+mQkAHi/TsfOSC59/HwINxmsaDHZZG4ciY6/c43tccYxn/Iea0Xq4OTtHsQPjtB1Lq85UeW/rgDwkMP2DstH8RHRD6vE5rspBHeh3myvMsI8cRxVMkKogAOdYAaQXqgPsu0VU9DIssbmnx5VZIXOIf/YHS0y9+ErPtS1RSc3zYAM/Zel3FiMbjFlZZPNs39wpbOaMqRRud8C1PvtdG5mlzx/B7LIEhxRtxa61L6iPhzaxGiSPgQKQ6UJ74zpUjMNohC/VxkwAjUg7Lf82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLAbSTXCZ4G4uO33vWHTTuTS6IcU43ldoqvuqw4tt5Q=;
 b=eIVzmsNOnp3ajOr1wr6XNVx8Gahzf/PCJj0vbNktdSoFstWIUFNTgc67AAvtDQQUjVWJF+htS20g1Q/mW3tyUNeERjXXh5i3fOSy4AHt0kXh7ujYLEBJQ4IHab5TYdYWFaE6gshhkUWaI1v+d6rzd9QVTcYR5dOEpekiu8kkOHF5Dt4ai+lOBgHGGSEYqjOo34zbZnmM5TjjtVs6GAe2N8h/sOkyFPGib0EdXPfpVDqbFacskgaZyyEemsXz+J/n1c8/fnjfKrpGBvd7C+duZrAX6H+lfuebnIFYbDSpJR+720/JdfuxprmZdm4FJ3yPPwHvo1r+wu8xH0x2HPDWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLAbSTXCZ4G4uO33vWHTTuTS6IcU43ldoqvuqw4tt5Q=;
 b=oevYILY6CU77i/eJ/bFe9X/ueQeP3yz/U62bBRXYt7hnuhUc8RjIlbh274eKVf8p/PlnmZbX305N/fK08qrURI48UOQ+HmgRWFTni+LPQHMz1eesTa1Z8qSnFgdgxOVszbSlH8bEqz46gq24qAkStAubovC65f73ws3pXyX69+8=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TY2PR06MB2941.apcprd06.prod.outlook.com (2603:1096:404:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 01:56:09 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 01:56:08 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Martin Kaiser <lists@kaiser.cx>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHI4MTg4ZXU6IGNvcmU6IHVzZSB0aW1lX2lzX2Fm?=
 =?utf-8?B?dGVyX2VxX2ppZmZpZXMoKSBpbnN0ZWFkIG9mIG9wZW4gY29kaW5nIGl0?=
Thread-Topic: [PATCH] r8188eu: core: use time_is_after_eq_jiffies() instead of
 open coding it
Thread-Index: AQHYLFFdMmeLSkuwgUSuTZ5tzdW9KaywpwcAgAKLVM4=
Date:   Mon, 7 Mar 2022 01:56:08 +0000
Message-ID: <SL2PR06MB30829C82386B3278C2E4A17ABD089@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1646018092-61367-1-git-send-email-wangqing@vivo.com>
 <YiNCJFFLPcD+aGnr@martin-debian-1.paytec.ch>
In-Reply-To: <YiNCJFFLPcD+aGnr@martin-debian-1.paytec.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 482af9a9-805c-b3eb-204a-3d927d9287c9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad47149c-5a6e-4c4c-9734-08d9ffdda622
x-ms-traffictypediagnostic: TY2PR06MB2941:EE_
x-microsoft-antispam-prvs: <TY2PR06MB294157D374674B9E4A49A7B2BD089@TY2PR06MB2941.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cv0mh62N6tFD6aVW48xUInQdJjNcZJ3svmZ+vPlGZj5RuMGn/jlF79/lM96Ch58mWvtc9KxncXhaPGQcDplHaLUoHk0RkKw6OGfJqBORpRFdQ92qzUvhCTnnTvQq3D1TXbdHg5ssZoxz1gYZyurUP160aCxcJrHrGoeLpcKkhzTU/42KAdSKamwZhPxxlHr+LOWkq788sW3dLxpnS0/b0DYfxtMuyQ8fMnMVb/x0nZNseCunLOqmg+I23rpY++2GudIDqdnG/eNUa8J3Cu5mN9CTda4PcofTvhgYPICHudaXeJzNnZWQsGPDK7rYeqGLnUgEpLLYTqtmxEALq2VhrvaKC2PyWE/om/4TixOmBbmuCjKxJPWx2cJyzVM8XzLaHrv6ga18fmVZLfcfOZPs5+3h8jveJW5pEZjEGMHJ1nA+qOIHIow81P1BBTqyyRa8DT1SCmtlRsLkAD+er4JQrA66IcvkEli93aYhgrpr/M7Hgg/R0s0ay7i2BcUgpEQnRFj0UdLz8VaAOuNXXEwYAyodTnyQ/9iyaIhOfHebUASzYF7MJK6XQxmRjyhK2wxVqEBG0C4uW90Vh8rEOl1duB1nv9yMuBKO6v5cNJmF09XQbxcaGCK/j0HKAOxO32ouejGZ4AQKFeKbC6HQKaxVBQImg17BeUvWych3kc/oOx1hlsL7CJ9rhMV9YBWyntMXCeh0ngOnos+39M3+yX3+Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66476007)(55016003)(66556008)(4326008)(66946007)(83380400001)(66446008)(85182001)(76116006)(8936002)(508600001)(54906003)(52536014)(316002)(38070700005)(6916009)(71200400001)(224303003)(7696005)(6506007)(38100700002)(86362001)(186003)(91956017)(9686003)(26005)(2906002)(122000001)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUVmYlZnVGxXQ3FmMUY5K3dSSlZzbUVubTE4ci8yeFdINEszZHhjb2huRy83?=
 =?utf-8?B?SFFnQTJ4NWhaamxrbDB3eUdQNU9yNGVEMjNKMm42MS9vanVScjRiZUtYZ04w?=
 =?utf-8?B?MG51M3ZMbCtqZUxSMldxRjR5Y2lYVmdXWEplVmNDNGpuMmlEQWs0enV6bzdJ?=
 =?utf-8?B?VzdUUUd5RnNCeTV5NzVlekxVVitGTkIyT09HYXl1YWF3a1FNYTV0ei85NkJZ?=
 =?utf-8?B?ZVpySUpkYzB2ZG9HMEVYT28zNzFadXdTWHhRMTNhdE9BL281bklhblhrOHM5?=
 =?utf-8?B?ZmxSSmdZMFF3M01pNitNSGduc3A0UzcwNVoyM3ZUWE1tMHJNcDJETG5scGFo?=
 =?utf-8?B?bXlBRUtQa3FpRlM1anNHcU5JMHRRNGNHcnVYWWlHNTgxNTVwaTRBM05OWHRs?=
 =?utf-8?B?ZHZUY0cwS3hiQTRHWHAvazJSZTF0VDFnenVUcm9WZjFHUFJxS0xvNENkSVFw?=
 =?utf-8?B?RVNtbTJxN2JZQ0hxQlJTanV5dkRLR1NoeXV2b0NpMDcyKzBIMEFxM2VPeVhD?=
 =?utf-8?B?YzRVQ2xEQzZqZTBUdEIvUk5VUzEyak5XblUxWTFvVGhyUVc5VGNhVTBDcVNn?=
 =?utf-8?B?RTAxYk9vM21YdFgrbHpGSlZhanRBekpvQUV4TEV3c3pKUWU0eERZV1lCUUcx?=
 =?utf-8?B?SjFRSi93WllWUEc1dVZxbXVsaXNkdFA2bGxGY3k4WmlEM1hsVWZRMFl4OVlv?=
 =?utf-8?B?eVZwdUUza1ZFenpzWDZVdTNrRW5MRDlYaXhNRGU3UjA4SFFQdlVXM1phR1Nj?=
 =?utf-8?B?bGMrVHk4VjdHUVd2ekhicWJva3Bab2xVQU44Q3ExMjNSSWh3THJ5VmpXc1c3?=
 =?utf-8?B?bENZWU1JU2FIZ0w4dklxL1NNSTJVcTV5QURDbzJhajRybUhWVjNVaWhjN1g4?=
 =?utf-8?B?bm01dTZqNFg0akplY0VCWFFvU3UyRi9peklvYm9VaDc4YjR2SVRscDBYcjZW?=
 =?utf-8?B?L1JXU0U2ZlN5RkFwZ3JsRFJrOENFTWRkMzZGZzdqQUN4OTRyTUUzVDVDaWhj?=
 =?utf-8?B?SFRNazFGTEdGb2lsQ2NwZDlYU21BUXJBcjhXNWw4aE1XZTJGMmRVbW1KV3Zk?=
 =?utf-8?B?YndtZjF2d21CMWRsbERHUXFLTkZOdmxGbVgzYmNRY2g4T1hyOEV1dGdQYVZy?=
 =?utf-8?B?blRPMllTenJjMlhLVHlaZHk5S2tzMXVLRkF0NjJaTTJ4d2JqbUlOT3lGbHlE?=
 =?utf-8?B?RmRMSWk5WjVPL2k2UnNSOCtrT2VXTTBzUlZrTFVuV2NwY3pLcm9iZ1NLTGEz?=
 =?utf-8?B?Q2RXVENnaVMzUm9jV1ZzSS9iSktPbnlNTEh2a0Nua2dVcUdSRFVKckpUTUNO?=
 =?utf-8?B?eUFuYzJ2ZlFpM1JMSzNxOUVwdG11SkRybXBoSkQ1L01MNG5mSk1OK1FKcFhI?=
 =?utf-8?B?UDh5S1IrVTBjeXRxQThpNUxFcTdnM2R6WlY3M0hlQ2FlWHNPQjF4aFYzSkgz?=
 =?utf-8?B?VGxNRDBVVFhWTDFHS0xjRXV2dVV5VnROblFqR3BheFVtOXNVNHJXTFphZnQ3?=
 =?utf-8?B?bk4wWHBBMzg4cXQ0UmUzcUd4UWQxL1lmaHpTTUppMzFsK0NuY0Z2OTlnSTJn?=
 =?utf-8?B?WThPb3ZESzVnQlk4Ynp2cHBiakZaeXI5K1pzK3ZUbFBKOFVKZkZJbGNGd3li?=
 =?utf-8?B?QjVkY2RkUEtRdzFTK3VqRjJpczZMbW5uSHEwd3owdFp3NW8wK0x3RCt6anNV?=
 =?utf-8?B?MitrRksvakJsQ1d3Y1VGOFQ1L0FhbTY1VGlvd21PcTcrZG1VOXVhb0xqTUtX?=
 =?utf-8?B?dytEYzRtK0FJWnVSeXNjTHJjRHFUeTZkY2hqQTlRR0Q2VnFaZXlHV1ZRYkoy?=
 =?utf-8?B?cnBxKzUvSGExYkpzZkVyZnoyRG1WNG1xR0JZckgvUFpzYy9rcmtCbWpzZUxC?=
 =?utf-8?B?VmRLcGJ6b0ZIZzZEWFc4S3lpNWdMWk9mQ2NwRm9MaElSY3VReUJnWExibDMv?=
 =?utf-8?B?TGZORzNNMWNENkZITzVaQWRWQjNuaHZqUU10aUtva0swcStGeU91VmhqTVUw?=
 =?utf-8?B?Z0NJTjljYjg4dTBZUVV1T3JPQVB4TFNCR1dRMzZWd3cyTFlWKzcyQUl5TzI3?=
 =?utf-8?B?UExFQ0owV0FNQVhiNXJUdjQveHVwbHlBMFZseFVwVDFyWjRwVklXLzdpNEE1?=
 =?utf-8?B?Y1FodHV0eDF3SXArb2hFNklZQmE1dHorbTdlZDFDTW1MeG1yR1hYZHlPMXhW?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad47149c-5a6e-4c4c-9734-08d9ffdda622
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 01:56:08.6807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AFKcarHDMRhXMJUJhgsgJh+ephfTsiVzqpVELFPYB1FQ1p4cmFXW5SGqdZTZg3gEtIUNgSUvia33Y16a/Xwcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2941
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5IaSwKPgo+VGh1cyB3cm90ZSBRaW5nIFdhbmcgKHdhbmdxaW5nQHZpdm8uY29tKToKPgo+PiBG
cm9tOiBXYW5nIFFpbmcgPHdhbmdxaW5nQHZpdm8uY29tPgo+Cj4+IFVzZSB0aGUgaGVscGVyIGZ1
bmN0aW9uIHRpbWVfaXNfe2JlZm9yZSxhZnRlcn1famlmZmllcygpIHRvIGltcHJvdmUKPj4gY29k
ZSByZWFkYWJpbGl0eS4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFFpbmcgPHdhbmdxaW5nQHZp
dm8uY29tPgo+PiAtLS0KPj7CoCBkcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0d19wd3Jj
dHJsLmMgfCAyICstCj4+wqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9yODE4OGV1L2NvcmUvcnR3
X3B3cmN0cmwuYyBiL2RyaXZlcnMvc3RhZ2luZy9yODE4OGV1L2NvcmUvcnR3X3B3cmN0cmwuYwo+
PiBpbmRleCA0NmU0NGFlLi45ODk0YWJiCj4+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9yODE4OGV1
L2NvcmUvcnR3X3B3cmN0cmwuYwo+PiArKysgYi9kcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3Jl
L3J0d19wd3JjdHJsLmMKPj4gQEAgLTEwMiw3ICsxMDIsNyBAQCBzdGF0aWMgYm9vbCBydHdfcHdy
X3VuYXNzb2NpYXRlZF9pZGxlKHN0cnVjdCBhZGFwdGVyICphZGFwdGVyKQo+PsKgwqDCoMKgwqDC
oMKgIHN0cnVjdCB3aWZpZGlyZWN0X2luZm/CoCAqcHdkaW5mbyA9ICZhZGFwdGVyLT53ZGluZm87
Cj4+wqDCoMKgwqDCoMKgwqAgYm9vbCByZXQgPSBmYWxzZTsKPgo+PiAtwqDCoMKgwqAgaWYgKGFk
YXB0ZXItPnB3cmN0cmxwcml2Lmlwc19kZW55X3RpbWUgPj0gamlmZmllcykKPj4gK8KgwqDCoMKg
IGlmICh0aW1lX2lzX2FmdGVyX2VxX2ppZmZpZXMoYWRhcHRlci0+cHdyY3RybHByaXYuaXBzX2Rl
bnlfdGltZSkpCj4+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXhpdDsKPgo+
PsKgwqDCoMKgwqDCoMKgIGlmIChjaGVja19md3N0YXRlKHBtbG1lcHJpdiwgV0lGSV9BU09DX1NU
QVRFIHwgV0lGSV9TSVRFX01PTklUT1IpIHx8Cj4+IC0tIAo+PiAyLjcuNAo+Cj4KPlRoaXMgZG9l
c24ndCBjb21waWxlIG9uIG15IHN5c3RlbToKPgo+wqAgQ0MgW01dwqAgZHJpdmVycy9zdGFnaW5n
L3I4MTg4ZXUvY29yZS9ydHdfcDJwLm8KPkluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUv
bGludXgvaXJxZmxhZ3MuaDoxNSwKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZy
b20gLi9hcmNoL2FybS9pbmNsdWRlL2FzbS9hdG9taWMuaDoxNCwKPsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2F0b21pYy5oOjcsCj7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC4vaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5o
OjI1LAo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAuL2luY2x1ZGUvbGlu
dXgvcmN1bGlzdC5oOjExLAo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAu
L2luY2x1ZGUvbGludXgvc2NoZWQvc2lnbmFsLmg6NSwKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZyb20gZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS8uLi9pbmNsdWRlL29z
ZGVwX3NlcnZpY2UuaDo3LAo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gZHJp
dmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfcHdyY3RybC5jOjY6Cj5kcml2ZXJzL3N0YWdp
bmcvcjgxODhldS9jb3JlL3J0d19wd3JjdHJsLmM6IEluIGZ1bmN0aW9uIOKAmHJ0d19wd3JfdW5h
c3NvY2lhdGVkX2lkbGXigJk6Cj4uL2luY2x1ZGUvbGludXgvdHlwZWNoZWNrLmg6MTI6MjU6IHdh
cm5pbmc6IGNvbXBhcmlzb24gb2YgZGlzdGluY3QgcG9pbnRlciB0eXBlcyBsYWNrcyBhIGNhc3QK
PsKgwqAgMTIgfMKgwqDCoMKgwqDCoMKgwqAgKHZvaWQpKCZfX2R1bW15ID09ICZfX2R1bW15Mik7
IFwKPsKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBefgo+Li9pbmNsdWRlL2xpbnV4L2ppZmZpZXMuaDoxMTE6MTA6IG5vdGU6IGluIGV4
cGFuc2lvbiBvZiBtYWNybyDigJh0eXBlY2hlY2vigJkKPsKgIDExMSB8wqDCoMKgwqDCoMKgwqDC
oCAodHlwZWNoZWNrKHVuc2lnbmVkIGxvbmcsIGEpICYmIFwKPsKgwqDCoMKgwqAgfMKgwqDCoMKg
wqDCoMKgwqDCoCBefn5+fn5+fn4KPi4vaW5jbHVkZS9saW51eC9qaWZmaWVzLmg6MTE0OjMzOiBu
b3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYdGltZV9hZnRlcl9lceKAmQo+wqAgMTE0IHwg
I2RlZmluZSB0aW1lX2JlZm9yZV9lcShhLGIpwqDCoMKgwqAgdGltZV9hZnRlcl9lcShiLGEpCj7C
oMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn4KLi9pbmNsdWRlL2xpbnV4L2ppZmZpZXMu
aDoxNjY6Mzc6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJh0aW1lX2JlZm9yZV9lceKA
mQo+wqAgMTY2IHwgI2RlZmluZSB0aW1lX2lzX2FmdGVyX2VxX2ppZmZpZXMoYSkgdGltZV9iZWZv
cmVfZXEoamlmZmllcywgYSkKPsKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+
fn5+fgo+ZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfcHdyY3RybC5jOjkyOjEzOiBu
b3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYdGltZV9pc19hZnRlcl9lcV9qaWZmaWVz4oCZ
Cj7CoMKgIDkyIHzCoMKgwqDCoMKgwqDCoMKgIGlmICh0aW1lX2lzX2FmdGVyX2VxX2ppZmZpZXMo
YWRhcHRlci0+cHdyY3RybHByaXYuaXBzX2RlbnlfdGltZSkpCj7CoMKgwqDCoMKgIHzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4KPgo+Cj50aW1lX2lz
X2FmdGVyX2VxX2ppZmZpZXMgY2hlY2tzIGF0IGNvbXBpbGUgdGltZSB0aGF0IGl0cyBhcmd1bWVu
dCBpcwo+dW5zaWduZWQgbG9uZyBidXQgaXBzX2RlbnlfdGltZSBpcyB1MzIgaW4gdGhlIHI4MTg4
ZXUgZHJpdmVyLgo+Cj5XZSBzaG91bGQgY2hhbmdlIGlwc19kZW55X3RpbWUgdG8gdW5zaWduZWQg
bG9uZywgdGhlIHJ0bDg3MjNicyBkcml2ZXIgZGlkCj50aGlzIGFzIHdlbGwuIGlwc19kZW55X3Rp
bWUgaXMgdXNlZCBpbiB0aGVzZSBwbGFjZXMKPgo+wqAgMTHCoMKgwqDCoCA5MsKgIGRyaXZlcnMv
c3RhZ2luZy9yODE4OGV1L2NvcmUvcnR3X3B3cmN0cmwuYyA8PHJ0d19wd3JfdW5hc3NvY2lhdGVk
X2lkbGU+Pgo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhZGFwdGVyLT5wd3JjdHJscHJp
di5pcHNfZGVueV90aW1lID49IGppZmZpZXMpCj7CoCAxMsKgwqDCoCAzNjPCoCBkcml2ZXJzL3N0
YWdpbmcvcjgxODhldS9jb3JlL3J0d19wd3JjdHJsLmMgPDxfcnR3X3B3cl93YWtldXA+Pgo+wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChwd3Jwcml2LT5pcHNfZGVueV90aW1lIDwgamlmZmll
cyArIHJ0d19tc190b19zeXN0aW1lKGlwc19kZWZmZXJfbXMpKQo+wqAgMTPCoMKgwqAgMzY0wqAg
ZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfcHdyY3RybC5jIDw8X3J0d19wd3Jfd2Fr
ZXVwPj4KPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwd3Jwcml2LT5pcHNfZGVueV90aW1lID0g
amlmZmllcyArIHJ0d19tc190b19zeXN0aW1lKGlwc19kZWZmZXJfbXMpOwo+wqAgMTTCoMKgwqAg
Mzk5wqAgZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfcHdyY3RybC5jIDw8X3J0d19w
d3Jfd2FrZXVwPj4KPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocHdycHJpdi0+aXBzX2Rl
bnlfdGltZSA8IGppZmZpZXMgKyBydHdfbXNfdG9fc3lzdGltZShpcHNfZGVmZmVyX21zKSkKPsKg
IDE1wqDCoMKgIDQwMMKgIGRyaXZlcnMvc3RhZ2luZy9yODE4OGV1L2NvcmUvcnR3X3B3cmN0cmwu
YyA8PF9ydHdfcHdyX3dha2V1cD4+Cj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHdycHJpdi0+
aXBzX2RlbnlfdGltZSA9IGppZmZpZXMgKyBydHdfbXNfdG9fc3lzdGltZShpcHNfZGVmZmVyX21z
KTsKPgo+cnR3X21zX3RvX3N5c3RpbWUgY29udmVydHMgbWlsbGlzZWNvbmRzIHRvIGppZmZpZXMg
YW5kIHJldHVybnMgdTMyLiBXZQo+c2hvdWxkIHVzZSBtc2Vjc190b19qaWZmaWVzIGluc3RlYWQs
IHRoaXMgZnVuY3Rpb25zIHJldHVybnMgdW5zaWduZWQgbG9uZy4KPgo+RG8geW91IHdhbnQgdG8g
aGF2ZSBhIGdvIGF0IHRoaXM/Cj4KPkJlc3QgcmVnYXJkcywKPgo+wqDCoCBNYXJ0aW4KCkkgc2Vl
IHJ0bDg3MjNicy9pbmNsdWRlL3J0d19wd3JjdHJsLmggYWxzbyBoYXMgYSBkZWZpbml0aW9uIG9m
IHN0cnVjdCBwd3JjdHJsX3ByaXYgb24gaXQsIAp3aGljaCBpcyB1bnNpZ25lZCBsb25nIGlwc19k
ZW55X3RpbWUuCklzIHRoZXJlIGFueSBkaWZmZXJlbmNlLCBvciBzaG91bGQgaXQgYmUgY2hhbmdl
ZCB0byB1bnNpZ25lZCBsb25nPwoKVGhhbmtzLApXYW5n
