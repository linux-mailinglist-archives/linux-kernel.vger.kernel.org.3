Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3A4C9EEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbiCBIJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiCBIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:09:08 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120080.outbound.protection.outlook.com [40.107.12.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB51A6536;
        Wed,  2 Mar 2022 00:08:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFQPAY6iC+jzrZ7dG3TG7OHG55L2xzyQDXgMBs0G2Sgysb99m5j6VEs4SbZyUFrkCom/2M5oiIt6x9YrDwbia3jNbx36DNeymIz0uHhppAJt0cBrJkonYb26qFPAOUhsLKt4oLuA4vW+fTLlPb0ZpoPjJ0fdeeI2HRgMhHArUIGyUF0qbbEcffs6jgM1L+OiuywjcxMxbSBxElv3d5W4mfQrrCBOxa71dLNlcm77Ppb77TE5XYQiqq9QebFIs1iJtWdA/oBxJ+Yw6EXR6oCCzXh0GYcWp/LAv/8bZArrZnq7LYUNoUCIurDxY6wZPz/zbKR2vb+KtIUNsD6QVhTiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFTUbMtz+xRHryi2qDImx3jr/WknsJ5ErnhgOlhXfEU=;
 b=I9ub2d03lbZ7ISZyXf4SgPQivDvS16RSAtRzyOJV68NZWpCKSvBLxnXAv+yH1DbO8AqTNP/qTygdmzpLtRtNDWPsicmmNIyNf30jKRjxlKXDg38/APV5a81Qk6sUVp45H6VpNvIhJAipTPGHoHOSXzEuQwk0fqTYIEAd9eYRKRPQ/g9vZiD7P+fGJ1DNn9r45vKTyOJSWFNZRqYqD1L6oHcVP0VHSGiK4CZ5Hib96glrzN+CXxPqlrt3vu5fpdOxMpJiVfH/5IGa9Ha4KArnVAjXbY0Lrc9bGqRVygBK5W4PciE6bYJSEtPKf+DAJ7YQeo02OL2Ta7YjiaT7a4jmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB0635.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 08:08:22 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 08:08:22 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: Re: [PATCH v9 07/14] module: Move extra signature support out of core
 code
Thread-Topic: [PATCH v9 07/14] module: Move extra signature support out of
 core code
Thread-Index: AQHYLP0GFLJD3Dg8pkOmoPnkw1nPZqyrv2OA
Date:   Wed, 2 Mar 2022 08:08:22 +0000
Message-ID: <c03fa2bb-1b0e-62c7-53fe-33e44d20b564@csgroup.eu>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-8-atomlin@redhat.com>
In-Reply-To: <20220228234322.2073104-8-atomlin@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3f5322f-d761-48c9-192f-08d9fc23d201
x-ms-traffictypediagnostic: PR0P264MB0635:EE_
x-microsoft-antispam-prvs: <PR0P264MB0635D17BCEFDBE8AA06A7A1EED039@PR0P264MB0635.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xtwTCcK9wgG3Bae67Vmx/U54pcIUQV4i5cgW048WZ0Wlp+4pY/F4KH4dI7W7kvcWBsyJLQbkRokkqzu4JdNf2DuveDB82Glo3WHm7bb6EzSMtCpBeKvhzxve3IxzTm5Pk8RgcE489gsBk/P5EfwfBtfWzMvfEohOqelFuLvIRatUZ+oR9dNsfxeTOX3RBZq3yjY6vA90lVxvRutoNAXLExDHpBoCu4LTRXzLTHVZ+HKRwOakDYxY2Rqp0KEdng6ipVSYdo4BQdlhW6DbpSqqf3ZUeUGNrAT7K36eF2dXz26j3LPCgJXMFB72n5cv5+5EjqtMuA6JF0X/90Sl/UejArWz//bM8X/kTMkEJLLwD1CAx4AlkP26lc8EjMbIXS2ShjpAAT8k4dtTU9acaJxeU5Kl8mRp99C9XMCOdhdmyNp3jxVCypXEdfidFgSh1rVdHn+60NcYJ8bFKfSiEMmpZjT/ROtagp3ela9ALgpipE4M7ejJCUUVoqtVoPh+LGiuW7E1sNC5X1K+9xa/LE2ZDpbUJFXPITJYCdIxAhhYJxvAgxNRCoSmInqJ0w5573khQkWn9MAsvpfvILeuKndPAn1qetZJiM5eg4MlIXtMfAwqTiUoAq0w4fwhCXEvConx6io0iu5kiZmf/9xYC6sPTxJ5CNy9Wl55bTrQyqjo9msNdKXdsMIqdW1ilR9sv9qxZD8Bd1lB7vUoKK65q/TOzuFvH5ADcEa2sLgR399xI1eSnJo8fDEJQyzjYZK7wh7fcznMfVYIkVVjM/hCEyGmhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(91956017)(508600001)(44832011)(110136005)(36756003)(6486002)(66946007)(31686004)(66446008)(71200400001)(31696002)(6512007)(26005)(2616005)(86362001)(186003)(6506007)(2906002)(66556008)(66476007)(316002)(54906003)(5660300002)(64756008)(38070700005)(38100700002)(8676002)(66574015)(76116006)(8936002)(4326008)(83380400001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGkxdWVJN2lsNktXSW1RMTBHNkRhcjVualIrQ2p3QkZRcXF4eENETmNkQWtM?=
 =?utf-8?B?SlEwTEo3RExQaFVIMmhMMS9RVU11S2tMNUhPNzRVK2xsUytpQncrYmNzZjht?=
 =?utf-8?B?bENFNXp5RnBGQ0xMU2ZNbStNMmpEdmFVQTUrM2p0bFBKeXdaYjdBKzIzbWhH?=
 =?utf-8?B?c3BhaTBlN0NTL29iOG1Md1VzMi9sekVMRWVLekpkU1BNK1l5L2ZJcC9yUVZs?=
 =?utf-8?B?a3phV1IweFlwa1J0NG1RM3I4SHllKytaS3owNDJWLzc2WXNBeWdiT2pPbHBG?=
 =?utf-8?B?TDNQQko0emdORDJUNWxiV1hhNW8zb2NuYytPUm9ZejJkQnZRQXJ6WWN6V2ZR?=
 =?utf-8?B?cFd3ckxYMGQxMnFGK2EvVllqWWJPd1BodTdPallESDF4a2lDMVptUCtxZHRk?=
 =?utf-8?B?R0w5c0VNU0llL3RaSXlIU3kwMDExL3BnTHRCZmgvRGdTWEF1TktVWWZGRlR4?=
 =?utf-8?B?cTgwZEFrbEJ0SlJnSFJrL2RoZlAvcXRSR0FzL3pCamR5cGpZR3BvK3Y3NFl1?=
 =?utf-8?B?Mm1Ld3Y5VDBQTFVUSVpzYnkxZHc1M0hMZVBvczU4VGNJUXpGS0hNUEppRTcv?=
 =?utf-8?B?TzcrUlFFVmE1UWsrV1lCdEdtMGdUQmRlUU00MFF3QXMvbkV2UWhFSy90WXBG?=
 =?utf-8?B?UjR0YkFyZFFXRFNsUktMTXRydTFzbnlhWU5BcmZRZG5UajFEN2FaZHVMbkRz?=
 =?utf-8?B?V0lDLzRlSEJCS0VON3lmb2dBMTJCT01BdVdrQklpY3ZBc1hjWXJXZXVYa3RK?=
 =?utf-8?B?OU9NNTZpOW9xWTVhbDB0ODVKR0xFSGxlR2o1QVBQR1VXd04xOWRKeTAyVWEv?=
 =?utf-8?B?WC9TWVU3UWt5VWExTDFxRmpYd1l0WXdkdGczRHkzbTNPRXIvMXAvRXNXYkR0?=
 =?utf-8?B?MjN6N2VpTi8zOTBQbWN2bjRQYjhleHRGN2FyMTNxa1pSMkJ5aHc4T1NjSkd5?=
 =?utf-8?B?MkV5bVpvdkNPS3dwc0tmUml0RXk0UC9pVWVnYm5HaXNqdElXNExBT3dZSXNS?=
 =?utf-8?B?WmpPbmg5bWF0emxFV0JTaEZtc0FHV0QwU0U2eUI3SWRMQ2JoTGVsRjI2alNr?=
 =?utf-8?B?YlZlMGFBV2ptSXZ2WHlobjIxT081M2d6Qm5OdzNlOHBpeVlQaVhXcEd6RkU0?=
 =?utf-8?B?ZUNMdS9mRkdNcmhpVXVoVVBmOXlldmQydFI5anB0TnY3aFkwbVhEd3Y0a25G?=
 =?utf-8?B?ek92aHZNbTl1aE5qd3pBeERpbzZYTDRoVldvU2tZck9qRUtZM0pHVHhSOXI1?=
 =?utf-8?B?MUlSTXREQndPZm1QaXZKQyt6UFFUdEFpbjhhVUhXcW15Y1JJVTFORk05eml3?=
 =?utf-8?B?c1RacWd5MENlMU5wcGJFTkpNM1VRYTJ5ZXpVZWw4QUNGRGFZK21YSUVOMlZO?=
 =?utf-8?B?VmVzdG4yV1FUOVY5OTQ5QSthWi9yeWxvQ0hrdHJaTEpWWFpKTzVjalJjZlRs?=
 =?utf-8?B?bWlGdEoyeXhmMGhLdlNWd3QvZ0RJdDBXSktnZkVCMHRBajVIMkZmaThuNFVn?=
 =?utf-8?B?TEFLMEwwZFFoaVcrUlYySEx6WEI1NjErT3JSenNUeU5OQmptM2IxVFFQRVRS?=
 =?utf-8?B?ekk5bE1pT3JCSHMxTzZqTGNhUlpjZEI2em1IdjJBOUZTcHF5dGhPTk56OVB5?=
 =?utf-8?B?RENtSk02WUF5ZTYvZGRFdVBZNkNYc1hMQzN6ZHRLMGxzNmFNZHA5Qi8xSlJy?=
 =?utf-8?B?dEk4QmZDS1phTHhscW9temRmYXV0dXJtMTg5Y1VYRUJNSGpGbHRmcEFGbHNB?=
 =?utf-8?B?RHY1N1QvSG9COC9ncDdwRHdwZXZQQkF3a29SY2l2K0NoeEF5NUtlZFJmbDdT?=
 =?utf-8?B?VE9GeldnZVE5aU1DWWFIRkp0bnp5djQxOUt6dGZBL20wb2x4djVjYkRKTThr?=
 =?utf-8?B?djc1cFd5eDl2L3ZOeHIyOHRseFBweWwwa3Q5ZVJ4QlhXMXpqS0JxdEduUzly?=
 =?utf-8?B?cUFUcmdHQlN5OTRxQS9naExyYnluQjVPUjJTMm5nSUhTZjRxRnl0ck52SHo5?=
 =?utf-8?B?S0xCSEwzZ0ZBaENiSU9RT0JHcE5zellvNlBlS2dkRk5aWHZxZ25RNHV6aGFk?=
 =?utf-8?B?aWdpU2U0ZVN6azFwZDY2MDRvSnVPMFpFZlNyb1pkZWlrM2VNRXp4SW9LazBj?=
 =?utf-8?B?T3BXZjJ4L1hDVkk4VDNKcmEvYWk1VHZzcFVOTTc5czNXNnB6bFJ2cHoxOXNm?=
 =?utf-8?B?c2VsUWY1VklpSm40amlmbFFWam5BZC9tUkZ6N28zUHFXTk5EWmNmZWVuWWsw?=
 =?utf-8?Q?jCFJlMQnXlNZ2cbSAvYOsxolhjeZK7Hiu5u0uweyss=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81320DDD3D022D4580BFC1543721695A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f5322f-d761-48c9-192f-08d9fc23d201
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 08:08:22.3385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPNlHT6RwXOcY23wWxbM1zRFV63MQFOmKmTClmoApkmk08HZ1Rxy/KkikCDPQHYxyeWHWjwJ+WCXnEBUIirVpyLetUlo+vkr8VLpYNfypIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB0635
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAxLzAzLzIwMjIgw6AgMDA6NDMsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBO
byBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFRoaXMgcGF0Y2ggbWlncmF0ZXMgYWRkaXRpb25h
bCBtb2R1bGUgc2lnbmF0dXJlIGNoZWNrDQo+IGNvZGUgZnJvbSBjb3JlIG1vZHVsZSBjb2RlIGlu
dG8ga2VybmVsL21vZHVsZS9zaWduaW5nLmMuDQo+IA0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3Bo
ZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KPiBTaWduZWQtb2ZmLWJ5OiBB
YXJvbiBUb21saW4gPGF0b21saW5AcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAga2VybmVsL21vZHVs
ZS9pbnRlcm5hbC5oIHwgIDkgKysrKysNCj4gICBrZXJuZWwvbW9kdWxlL21haW4uYyAgICAgfCA4
NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAga2VybmVsL21v
ZHVsZS9zaWduaW5nLmMgIHwgNzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gICAzIGZpbGVzIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDg3IGRlbGV0aW9ucygtKQ0K
PiANCg0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS9zaWduaW5nLmMgYi9rZXJuZWwvbW9k
dWxlL3NpZ25pbmcuYw0KPiBpbmRleCA4YWViNmQyZWU5NGIuLjg1Yzg5OTlkZmVjZiAxMDA2NDQN
Cj4gLS0tIGEva2VybmVsL21vZHVsZS9zaWduaW5nLmMNCj4gKysrIGIva2VybmVsL21vZHVsZS9z
aWduaW5nLmMNCj4gQEAgLTExLDkgKzExLDI5IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZV9zaWduYXR1cmUuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+DQo+ICAgI2luY2x1
ZGUgPGxpbnV4L3ZlcmlmaWNhdGlvbi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3NlY3VyaXR5Lmg+
DQo+ICAgI2luY2x1ZGUgPGNyeXB0by9wdWJsaWNfa2V5Lmg+DQo+ICsjaW5jbHVkZSA8dWFwaS9s
aW51eC9tb2R1bGUuaD4NCj4gICAjaW5jbHVkZSAiaW50ZXJuYWwuaCINCj4gICANCj4gK3N0YXRp
YyBib29sIHNpZ19lbmZvcmNlID0gSVNfRU5BQkxFRChDT05GSUdfTU9EVUxFX1NJR19GT1JDRSk7
DQo+ICttb2R1bGVfcGFyYW0oc2lnX2VuZm9yY2UsIGJvb2xfZW5hYmxlX29ubHksIDA2NDQpOw0K
PiArDQo+ICsvKg0KPiArICogRXhwb3J0IHNpZ19lbmZvcmNlIGtlcm5lbCBjbWRsaW5lIHBhcmFt
ZXRlciB0byBhbGxvdyBvdGhlciBzdWJzeXN0ZW1zIHJlbHkNCj4gKyAqIG9uIHRoYXQgaW5zdGVh
ZCBvZiBkaXJlY3RseSB0byBDT05GSUdfTU9EVUxFX1NJR19GT1JDRSBjb25maWcuDQo+ICsgKi8N
Cj4gK2Jvb2wgaXNfbW9kdWxlX3NpZ19lbmZvcmNlZCh2b2lkKQ0KPiArew0KPiArCXJldHVybiBz
aWdfZW5mb3JjZTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0woaXNfbW9kdWxlX3NpZ19lbmZvcmNl
ZCk7DQoNCkFzIHJlcG9ydGVkIGJ5IHRoZSB0ZXN0IHJvYm90LCB0aGF0J3Mgbm90IGVub3VnaC4N
Cg0KV2hlbiBpdCB3YXMgaW4gbWFpbi5jLCBpc19tb2R1bGVfc2lnX2VuZm9yY2VkKCkgd2FzIGJ1
aWxkIGFzIHNvb24gYXMgDQpDT05GSUdfTU9EVUxFUyB3YXMgc2V0Lg0KDQpOb3cgaXQgaXMgb25s
eSBidWlsdCB3aGVuIENPTkZJR19NT0RVTEVfU0lHIGlzIHNlbGVjdGVkLCBzbyB5b3UgaGF2ZSB0
byANCm1vZGlmeSBpbmNsdWRlL2xpbnV4L21vZHVsZXMuaCBhbmQgaGF2ZSB0aGUgc3R1YiANCmlz
X21vZHVsZV9zaWdfZW5mb3JjZWQoKSB3aGVuIENPTkZJR19NT0RVTEVfU0lHIGlzIG5vdCBzZWxl
Y3RlZCBhbmQgbm90IA0Kb25seSB3aGVuIENPTkZJR19NT0RVTEVTIGlzIG5vdCBzZWxlY3RlZC4N
Cg0KDQo+ICsNCj4gK3ZvaWQgc2V0X21vZHVsZV9zaWdfZW5mb3JjZWQodm9pZCkNCj4gK3sNCj4g
KwlzaWdfZW5mb3JjZSA9IHRydWU7DQo+ICt9DQo+ICsNCj4gICAvKg0KPiAgICAqIFZlcmlmeSB0
aGUgc2lnbmF0dXJlIG9uIGEgbW9kdWxlLg0KPiAgICAqLw0KDQpDaHJpc3RvcGhl
