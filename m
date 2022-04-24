Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7450CE76
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiDXC3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbiDXC3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:29:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B3B2C66D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Me95AGLAQTwHLCRVEhu+kjY/CsDFvqOQco8uhvQZxMsdiMFz7D3OKdTVqO4HYKLqlD+A7OB0Xdn6WVlARpALMDwxWZppg17QPx30IGvMGdMgubXiMSmiTRdEZV42MtNueCshOb0N/obx1dJTqA9ar0Nq5KgZbONst6+78TdzRcvE47xbmAri0PDzRpXkpcRwF0IIuXCF20Jpz6O12aHqC1M78z+cUzeh91V90OP79OkAEiy4wapHHfTHlmLcy+WGh+IldiANuVyjCNqS8lUdFI1DvVxwEdDClCDamJ+kLdh07APAUL/DaOjRjThV7YKbXP0QZbN8/3vIsEGxEdCmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rAUl/RH1OQW2NbFLzWsQHWwZFgr75zoFhQxzCILYVo=;
 b=Nwp0lFQ4nFR7fyPcqlIDAj6XQ7GVnKcHtrwr+7Sj+hXrMudkuovhqf0bfMSb+CeePF3OocQ9U2Q7CYayp9l3aiDo9t2pHpsRwJc0LP96dO2jPre+tbv5m3S6TzxzfxowF1AWIK7RXE2wt4ptFEBrMM3yQI0GyVhhqxsTdZdrRKB8B+3y5FhTYNfVL5vyTbSHTx01NoAe1oBbkHiPpoxnDw2ONg1i0RYb18xqokBOWlgNq3sOwqo834S6FvxcaU66Kjc+nll32m0l16oEx/cEJsTghgyHZV/onTRIudlMGEQmR+lIqYKlXgpRhxyPOWtEQ27X2akSfEeIo5KPwGabxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rAUl/RH1OQW2NbFLzWsQHWwZFgr75zoFhQxzCILYVo=;
 b=H8TsspO+kQcOkyf5XFUEydcB7tmNQh1KTtZVXahbjxHIuAI9f4NhAsHm3nbDPXeweYWVyqBSsy1KKaTvHy5tsy2pndH1mCOv1XAk04P3e53qjYum4ZkvHpKIj1zwnU+/f4N6XJssCydwWphlTH6GSjT0Wm/tIhT79Vx5Qp8Kf5g=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TY2PR06MB2703.apcprd06.prod.outlook.com (2603:1096:404:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sun, 24 Apr
 2022 02:26:01 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.015; Sun, 24 Apr 2022
 02:26:01 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
Subject: [PATCH V2 2/2] arm64: Add complex scheduler level for arm64
Thread-Topic: [PATCH V2 2/2] arm64: Add complex scheduler level for arm64
Thread-Index: AQHYVj9hsSp8iI0ZxUu3/+g1pmBLdKz73TcAgAJ4mPI=
Date:   Sun, 24 Apr 2022 02:26:00 +0000
Message-ID: <SL2PR06MB308212CA8BE5CF49B2860CDEBDF99@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
 <1650628289-67716-3-git-send-email-wangqing@vivo.com>
 <YmKgEmna8PNF9xlG@kroah.com>
In-Reply-To: <YmKgEmna8PNF9xlG@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7f09662-3c8c-44ef-f5e9-08da2599c61f
x-ms-traffictypediagnostic: TY2PR06MB2703:EE_
x-microsoft-antispam-prvs: <TY2PR06MB27032AD6C20F6DE76DB8BC7BBDF99@TY2PR06MB2703.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ik92Jz7J2N4ZzavLQqd6hfqViXAemzslgDCNoeGNCDDyRVsO0WHklBib3s2DHqCf5cYhlLBE8nYPav/u8zfoXOQ5L8kMEmPhRzN7t1it4MFw6DlqYMk2TLxENK5jyCtDIDN7BSBBHwaJjRQE5HNM1E8/4nFO36XNnDH7dKyRlCqLuxjjwCIuT1JOK6xGeC6RzTYENeT7g1MIk2nmN/M2H+vD7o4wvbEAK/T0yet7WAKS98MTfFg79E9jgBcN+5pZnPZtTZbvkxCCPTkkzAw887s6pNp8mkJ+SPjsPEWwJ7Gz8FALbCahk1ibgllD/FdDoE2iN5aJiZQ6We3kQ7Un6/bK7mpsOuqn9LG/uzOOzbBy+MjPwSwvE61VK7h7XrcIZMGk3bm/UQgYlAqQbKo6pJ9njAjTgOqLJ6UV5Tjhuz/x0jnekSmJ5e3rYqRIlsISfeUbLwbxKlOREWm2C/XRnZfsgLmNMkbKgvlm4Ls8hYZXyzeDZXBSfKK8zWDVk14W8saSnv66uj0960eJGB73OKxbYF2f6faO45sXJj7ZOvAQdz4yw3bMBGaxVywSEFhzNaWV7mIWJLAReEZbdDsG/6jhmLinoJCANMC1Yv73gx89IQrY0Xc/1Jgpi7SQQ9TMKhIZ+pXRofpae7ctln2H6dHYyy/CZzWUSBxNzH01i680q/gSdjv9liGOIk0DiXlDT1/Xo+b5wRo3YPeVZA9rPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(26005)(85182001)(122000001)(38100700002)(71200400001)(38070700005)(316002)(33656002)(7696005)(76116006)(52536014)(66946007)(66446008)(8676002)(66556008)(66476007)(64756008)(4326008)(91956017)(8936002)(5660300002)(186003)(55016003)(86362001)(83380400001)(54906003)(6916009)(508600001)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0gyMHpvTEwraFU4T0xRVWdkc3NqWDBHL2dSWnpjZlJlcnIwTlVlb2E1UGJt?=
 =?utf-8?B?SWprWEFXb2R3Y1FaR1R4U2hLYTM3dlN1MExWcHpjOU5GdWU5VS84TTdLSngz?=
 =?utf-8?B?RXdyaFpSSXptczljL0NTeVVxNjZUS3BaZXBUUDJiUGtBdmVDTjcvd3c4RFdk?=
 =?utf-8?B?bFkvN1RsRkUyaUpsR2RFK0Z1dCtYUHdSRGNKQmtCVGtaS1Rja2NWNnJUc0ZX?=
 =?utf-8?B?bm1lMmN1TndrWmxOd1NPZ3ovOVA3aGYvRi8zWjFrMGpsd2RkT3BrSFZJd0sy?=
 =?utf-8?B?Wkt3L2JWZ3NIdjhmNGRFb3NrcFRRU2N4N0prV09adHVDSnhkWWcwWmlMTlI0?=
 =?utf-8?B?L00zc3BEbVBqdkJYVWx4aVpiS1hoZ2NaSDVzTGdESFBaTUx5bmJLK3JXKzhu?=
 =?utf-8?B?cWdDQmd2V2FiSzYzRVM3aHl2TFBSUXVQc2NRVVh1STI2TGMrT0VuYmxlKzNz?=
 =?utf-8?B?SzN5U3NOTHViVURNZkxGQkgwRmk3VzV3ZUJYSHNJV2haR3QvTDBZOThyZldo?=
 =?utf-8?B?eTZQK1NxR3pYRmxBcUhTVnFkSTRQTlNZbG9tUUVYMXJQYnFRc0tFMWZXeUlq?=
 =?utf-8?B?TzkwTFJ6MUtzekhWbmdySkVkUVlZWldHSDJ1anFhdGpmem9idWNXUktIUTlX?=
 =?utf-8?B?dFNOY0RoNjlEZDJHZzhsZlpMcEYya3kraTB4akJId0MweTE4WTlGb1VveS92?=
 =?utf-8?B?VlgzL1lZZ1JUdXdHdm9Zc0NQaXkzWmVpTnp2U2tGWUYyekw0SWlxOGZiWlJz?=
 =?utf-8?B?OGdtTkdQc1NJenJ2M3dwUDIvMnNrY2pVVnhBU1dzL1N1MmxrbjAvV3lxdVB6?=
 =?utf-8?B?YlVDZ0FlUk5ieUJ2dzg1MHNOTlRuWVFhemY1aHVFU0NRSEFYOEZoVUQ3SGZE?=
 =?utf-8?B?L21qeWJaYWJpZjI3ckJyV1dTczcvMTZLekhYazJodmN6bmw2S290SnluQ0Vi?=
 =?utf-8?B?aUhsWVlHUEdtN1g0NUlycUpuNXMreFg4MzR0RElROTluV3pqb212K1ZZRzNx?=
 =?utf-8?B?YjNPMVBvK24zditOZmdFNGNiQzBvUC85WWRHRWk3aXEyTFdEdkpaZXBneUZI?=
 =?utf-8?B?dTRQYUhzeUhhYysvMS9uem82dWwzR1YzNDhnaUZ3VXI5VFpvL3N0NWtyT0Ri?=
 =?utf-8?B?VVhFL090L3MwTTRLMXZkQzNmYjFjVDFXbnlaTWlmbEJGeEpXMXc0NisvVGtO?=
 =?utf-8?B?aWVjLzhGQjd2MEQ3dDZrYk4xTjUxWnJKU1o3ckxiRTlLQ3F5L1N4eXJxejN1?=
 =?utf-8?B?R1FadTJyNHNWTnNvOG5VSjZoZUFldTBNODIva044NVdaK0Jqb0ZoMFdkNmIv?=
 =?utf-8?B?cllVY0plVVh2UTU3QnRpVWtGQldCVURNZGZsY0swWUxkcjlKNW5teWdHYmtr?=
 =?utf-8?B?SmdUYnZaZ3k2Q1ozSFQ4YUpYcGtsaUhtdlNpWWR3ZTRlUEI1ZUxVU2k1K0Rh?=
 =?utf-8?B?N2VXS3NjeHdsMlZtaVBtUWlub2tDSCtXaHRHRng3dUxvM25wQ211YWNDMVha?=
 =?utf-8?B?MGIzSXVwakdaKzh6eDRsc3lsaWt3c2l1eFdMRkNWMzZDWVZIK2Z3T00zbC9G?=
 =?utf-8?B?NmFTTGx3cWdkc0ZaU0x4SStyQ2RlOENvcFFHaU1Kc1lUNXdJQU0xVmlWNWJR?=
 =?utf-8?B?NUtUV29DMzJsT2tHb3ZndS9nbFRndmFkRHZIK2w3WmFBdkxLRklXSFo4bnBM?=
 =?utf-8?B?TWQ3Qkx0YW16VnNZOFdrRkR5emxXWkVMTThJUTNlelIrQlAyelF3emZOazVJ?=
 =?utf-8?B?NUpCdDJ6bjBIYWN1K1BLYW5sVTZkbUFqSmlmMTd5aHNEenFGQWtrR2k2WkRU?=
 =?utf-8?B?cjBKRWI5Uk9MbGc0L3VObkdnTHd2eS9zQjl0cS9Oa2g0MUpGR3c5TlAwaGph?=
 =?utf-8?B?dGE2Z2ZQWXhZbkcyMU1MWG1iQStzdnlpRllGTHQ2MzVRVWEzUFhadnUrc0JV?=
 =?utf-8?B?Uzc4T250ek1iemRIRXVvQXlxcXdNYkZGaGxhS0tXMVdINnVjUWQ3YWhnRkNJ?=
 =?utf-8?B?Rk9pZFhpRXh1MUY0T2Y4ODVwM05ZNThrNlFkb3pKdk4rRlRBNDVDVjlyaXo0?=
 =?utf-8?B?ZTVUWG5Uc1gyR3RGQ3c5TTYyTktnRTEvQnNWTmhkbzZDRHBsblFCblRuWEFu?=
 =?utf-8?B?akQ5R0ZlYkZQVTFLYW5GeFRHQ2M2RkRLaDdDNjZKWUtUNHRYTEdyZmxwZ2la?=
 =?utf-8?B?ZTVhVU5KRmUvVXFBT3V5WFZjWTRpZEFRSml2TGtFV016N1ZCSXhPbnVsaXU4?=
 =?utf-8?B?cThCTi9BaFFuaEowd3RXdEs1YjFFWUx4My8zNWh4QUZWWEU2WDhvSDhreTh3?=
 =?utf-8?Q?jv9DBs9r5yJ8aZ5e6w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f09662-3c8c-44ef-f5e9-08da2599c61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 02:26:00.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pK2iSi21WsWwjYoNpY48JdyNiwXkDf85Z7GjCbQgdAWeFqM3Wyk25CInXowkMO4xiDTHI8+sy7jR5+cioChiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2703
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IEZyb206IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+IAo+PiBUaGUgRFNVLTEx
MCBEeW5hbUlR4oSiIGNsdXN0ZXIgc3VwcG9ydHMgYmxvY2tzIHRoYXQgYXJlIGNhbGxlZCBjb21w
bGV4ZXMKPj4gd2hpY2ggY29udGFpbiB1cCB0byB0d28gY29yZXMgb2YgdGhlIHNhbWUgdHlwZSBh
bmQgc29tZSBzaGFyZWQgbG9naWMuCj4+IFNoYXJpbmcgc29tZSBsb2dpYyBiZXR3ZWVuIHRoZSBj
b3JlcyBjYW4gbWFrZSBhIGNvbXBsZXggYXJlYSBlZmZpY2llbnQuCj4+IAo+PiBUaGlzIHBhdGNo
IGFkZHMgY29tcGxleCBsZXZlbCBmb3IgY29tcGxleHMgYW5kIGF1dG9tYXRpY2FsbHkgZW5hYmxl
cwo+PiB0aGUgbG9hZCBiYWxhbmNlIGFtb25nIGNvbXBsZXhzLiBJdCB3aWxsIGRpcmVjdGx5IGJl
bmVmaXQgYSBsb3Qgb2YKPj4gd29ya2xvYWQgd2hpY2ggbG92ZXMgbW9yZSByZXNvdXJjZXMgc3Vj
aCBhcyBtZW1vcnkgYmFuZHdpZHRoLCBjYWNoZXMuCj4+IAo+PiBUZXN0aW5nIGhhcyBiZWVuIGRv
bmUgd2l0aCBTdHJlYW0gYmVuY2htYXJrOgo+PiA4dGhyZWFkcyBzdHJlYW0gKDIgbGl0dGxlIGNv
cmVzICogMihjb21wbGV4KSArIDMgbWVkaXVtIGNvcmVzICsgMSBiaWcgY29yZSkKPj7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJlYW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdHJlYW0KPj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3L28gcGF0
Y2jCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3LyBwYXRjaAo+PiBNQi9zZWMgY29wecKgwqDC
oMKgIDM3NTc5LjIgKMKgwqAgMC4wMCUpwqDCoMKgIDM5MTI3LjMgKMKgwqAgNC4xMiUpCj4+IE1C
L3NlYyBzY2FsZcKgwqDCoCAzODI2MS4xICjCoMKgIDAuMDAlKcKgwqDCoCAzOTE5NS40ICjCoMKg
IDIuNDQlKQo+PiBNQi9zZWMgYWRkwqDCoMKgwqDCoCAzOTQ5Ny4wICjCoMKgIDAuMDAlKcKgwqDC
oCA0MTEwMS41ICjCoMKgIDQuMDYlKQo+PiBNQi9zZWMgdHJpYWTCoMKgwqAgMzk4ODUuNiAowqDC
oCAwLjAwJSnCoMKgwqAgNDA3NzIuNyAowqDCoCAyLjIyJSkKPj4gCj4+IEFuZCBpbiBvcmRlciB0
byBzdXBwb3J0IHRoaXMgZmVhdHVyZXMsIHdlIGRlZmluZWQgYXJtNjRfdG9wb2xvZ3kuCj4+IAo+
PiBWMjoKPj4gZml4IGNvbW1pdCBsb2cgYW5kIGxvb3AgbW9yZQo+PiAKPj4gU2lnbmVkLW9mZi1i
eTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4KPj4gLS0tCj4+wqAgYXJjaC9hcm02NC9L
Y29uZmlnwqDCoMKgwqDCoCB8IDEzICsrKysrKysrKysrCj4+wqAgYXJjaC9hcm02NC9rZXJuZWwv
c21wLmMgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+PsKg
IDIgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+PiAKPj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZyBiL2FyY2gvYXJtNjQvS2NvbmZpZwo+PiBp
bmRleCBlZGJlMDM1Y2IwZTMuLjQwNjNkZThjNjE1MyAxMDA2NDQKPj4gLS0tIGEvYXJjaC9hcm02
NC9LY29uZmlnCj4+ICsrKyBiL2FyY2gvYXJtNjQvS2NvbmZpZwo+PiBAQCAtMTIwNyw2ICsxMjA3
LDE5IEBAIGNvbmZpZyBTQ0hFRF9DTFVTVEVSCj4+wqDCoMKgwqDCoMKgwqDCoMKgIGJ5IHNoYXJp
bmcgbWlkLWxldmVsIGNhY2hlcywgbGFzdC1sZXZlbCBjYWNoZSB0YWdzIG9yIGludGVybmFsCj4+
wqDCoMKgwqDCoMKgwqDCoMKgIGJ1c3Nlcy4KPj7CoCAKPj4gK2NvbmZpZyBTQ0hFRF9DT01QTEVY
Cj4+ICvCoMKgwqDCoCBib29sICJDb21wbGV4IHNjaGVkdWxlciBzdXBwb3J0Igo+PiArwqDCoMKg
wqAgaGVscAo+PiArwqDCoMKgwqDCoMKgIERTVSBzdXBwb3J0cyBibG9ja3MgdGhhdCBhcmUgY2Fs
bGVkIGNvbXBsZXhlcyB3aGljaCBjb250YWluIHVwIHRvCj4+ICvCoMKgwqDCoMKgwqAgdHdvIGNv
cmVzIG9mIHRoZSBzYW1lIHR5cGUgYW5kIHNvbWUgc2hhcmVkIGxvZ2ljLiBTaGFyaW5nIHNvbWUg
bG9naWMKPj4gK8KgwqDCoMKgwqDCoCBiZXR3ZWVuIHRoZSBjb3JlcyBjYW4gbWFrZSBhIGNvbXBs
ZXggYXJlYSBlZmZpY2llbnQuCj4+ICsKPj4gK8KgwqDCoMKgwqDCoCBDb21wbGV4IGFsc28gY2Fu
IGJlIGNvbnNpZGVyZWQgYXMgYSBzaGFyZWQgY2FjaGUgZ3JvdXAgc21hbGxlcgo+PiArwqDCoMKg
wqDCoMKgIHRoYW4gY2x1c3Rlci4KPj4gKwo+PiArwqDCoMKgwqDCoMKgIENvbXBsZXggc2NoZWR1
bGVyIHN1cHBvcnQgaW1wcm92ZXMgdGhlIENQVSBzY2hlZHVsZXIncyBkZWNpc2lvbgo+PiArwqDC
oMKgwqDCoMKgIG1ha2luZyB3aGVuIGRlYWxpbmcgd2l0aCBtYWNoaW5lcyB0aGF0IGhhdmUgY29t
cGxleHMgb2YgQ1BVcy4KPj4gKwo+PsKgIGNvbmZpZyBTQ0hFRF9TTVQKPj7CoMKgwqDCoMKgwqDC
oCBib29sICJTTVQgc2NoZWR1bGVyIHN1cHBvcnQiCj4+wqDCoMKgwqDCoMKgwqAgaGVscAo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvc21wLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9z
bXAuYwo+PiBpbmRleCAzYjQ2MDQxZjJiOTcuLjUyNjc2NTExMjE0NiAxMDA2NDQKPj4gLS0tIGEv
YXJjaC9hcm02NC9rZXJuZWwvc21wLmMKPj4gKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvc21wLmMK
Pj4gQEAgLTE0LDYgKzE0LDcgQEAKPj7CoCAjaW5jbHVkZSA8bGludXgvc2NoZWQvbW0uaD4KPj7C
oCAjaW5jbHVkZSA8bGludXgvc2NoZWQvaG90cGx1Zy5oPgo+PsKgICNpbmNsdWRlIDxsaW51eC9z
Y2hlZC90YXNrX3N0YWNrLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvc2NoZWQvdG9wb2xvZ3kuaD4K
Pj7CoCAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Cj4+wqAgI2luY2x1ZGUgPGxpbnV4L2Nh
Y2hlLmg+Cj4+wqAgI2luY2x1ZGUgPGxpbnV4L3Byb2ZpbGUuaD4KPj4gQEAgLTU3LDYgKzU4LDEw
IEBACj4+wqAgREVGSU5FX1BFUl9DUFVfUkVBRF9NT1NUTFkoaW50LCBjcHVfbnVtYmVyKTsKPj7C
oCBFWFBPUlRfUEVSX0NQVV9TWU1CT0woY3B1X251bWJlcik7Cj4+wqAgCj4+ICsjaWZkZWYgU0NI
RURfQ09NUExFWAo+PiArREVGSU5FX1BFUl9DUFVfUkVBRF9NT1NUTFkoY3B1bWFza190LCBjcHVf
Y29tcGxleF9tYXApOwo+PiArI2VuZGlmCj4KPmlmZGVmcyBzaG91bGQgbm90IGJlIGluIC5jIGZp
bGVzLgoKQnV0IEkgc2VlIGEgbG90IG9mIGlmZGVmcyBpbiAuYyBmaWxlcywgY2hhbmdlIHRvIElz
RW5hYmxlZCgpIGluc3RlYWQ/CkknbSBqdXN0IGZvbGxvdyB0aGUgeDg2X3RvcG9sb2d5IGFuZCBk
ZWZhdWx0X3RvcG9sb2d5IGRvZXMuCgpUaGFua3MsClFpbmcKCj4KPgo+PiArCj4+wqAgLyoKPj7C
oMKgICogYXMgZnJvbSAyLjUsIGtlcm5lbHMgbm8gbG9uZ2VyIGhhdmUgYW4gaW5pdF90YXNrcyBz
dHJ1Y3R1cmUKPj7CoMKgICogc28gd2UgbmVlZCBzb21lIG90aGVyIHdheSBvZiB0ZWxsaW5nIGEg
bmV3IHNlY29uZGFyeSBjb3JlCj4+IEBAIC03MTUsNiArNzIwLDQ3IEBAIHZvaWQgX19pbml0IHNt
cF9pbml0X2NwdXModm9pZCkKPj7CoMKgwqDCoMKgwqDCoCB9Cj4+wqAgfQo+PsKgIAo+PiArI2lm
ZGVmIFNDSEVEX0NPTVBMRVgKPgo+c2FtZSBoZXJlLgo+Cj4+ICtzdGF0aWMgaW50IGFybTY0X2Nv
bXBsZXhfZmxhZ3Modm9pZCkKPj4gK3sKPj4gK8KgwqDCoMKgIHJldHVybiBTRF9TSEFSRV9QS0df
UkVTT1VSQ0VTOwo+PiArfQo+PiArCj4+ICtjb25zdCBzdHJ1Y3QgY3B1bWFzayAqYXJtNjRfY29t
cGxleF9tYXNrKGludCBjcHUpCj4+ICt7Cj4+ICvCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgY3B1bWFz
ayAqY29yZV9tYXNrID0gY3B1X2NwdV9tYXNrKGNwdSk7Cj4+ICsKPj4gK8KgwqDCoMKgIC8qIEZp
bmQgdGhlIHNtYWxsZXIgc2hhcmVkIGNhY2hlIGxldmVsIHRoYW4gY2x1c3Rlcmdyb3VwIGFuZCBj
b3JlZ3JvdXAqLwo+PiArI2lmZGVmIENPTkZJR19TQ0hFRF9NQwo+PiArwqDCoMKgwqAgY29yZV9t
YXNrID0gY3B1X2NvcmVncm91cF9tYXNrKGNwdSk7Cj4+ICsjZW5kaWYKPj4gKyNpZmRlZiBDT05G
SUdfU0NIRURfQ0xVU1RFUgo+PiArwqDCoMKgwqAgY29yZV9tYXNrID0gY3B1X2NsdXN0ZXJncm91
cF9tYXNrKGNwdSk7Cj4+ICsjZW5kaWYKPgo+U2VlLCBzYW1lIGhlcmUuwqAgVGhpcyBpcyBhIG1l
c3MgYW5kIHVubWFpbnRhaW5hYmxlLgo+Cj50aGFua3MsCj4KPmdyZWcgay1o
