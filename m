Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEEA55728D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiFWFYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiFWFYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:24:22 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A2D3914B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1655961862; x=1687497862;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=hMoso+/V2818SwupS9cNiewpYWBrlCw0KZ1RZ+8A8H0=;
  b=Sc3baJva41K5Ul9AGVyNKNPxC+jtFlznxoIYidFiJEmpT6G+722bFvGi
   yNPgAhhThlycFUQnqqXpym7CMil6iqBG12kK5/LVAiiuaIfazs9aAWLCl
   l8WssH+jMPmRJXj0FTLCQOjSkkve8vcj403/tAtmS+GCQrRTkGAT91ZKy
   A=;
X-IronPort-AV: E=Sophos;i="5.92,215,1650931200"; 
   d="scan'208";a="231261649"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 23 Jun 2022 05:24:07 +0000
Received: from EX13D12EUC004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com (Postfix) with ESMTPS id 0A77BC08FA;
        Thu, 23 Jun 2022 05:24:04 +0000 (UTC)
Received: from EX13D14EUC001.ant.amazon.com (10.43.164.165) by
 EX13D12EUC004.ant.amazon.com (10.43.164.129) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 23 Jun 2022 05:24:03 +0000
Received: from EX13D14EUC001.ant.amazon.com ([10.43.164.165]) by
 EX13D14EUC001.ant.amazon.com ([10.43.164.165]) with mapi id 15.00.1497.036;
 Thu, 23 Jun 2022 05:24:03 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
        "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH] mm: Split huge PUD on wp_huge_pud fallback
Thread-Topic: [PATCH] mm: Split huge PUD on wp_huge_pud fallback
Thread-Index: AQHYhsFzt/PTU5inYUGKFJ1qIAcfKw==
Date:   Thu, 23 Jun 2022 05:24:03 +0000
Message-ID: <6f48d622eb8bce1ae5dd75327b0b73894a2ec407.camel@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.192]
Content-Type: text/plain; charset="utf-8"
Content-ID: <837474CBF305B649A87CA60126C3ED28@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-15.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q3VycmVudGx5IHRoZSBpbXBsZW1lbnRhdGlvbiB3aWxsIHNwbGl0IHRoZSBQVUQgd2hlbiBhIGZh
bGxiYWNrIGlzIHRha2VuDQppbnNpZGUgdGhlIGNyZWF0ZV9odWdlX3B1ZCBmdW5jdGlvbi4gVGhp
cyBpc24ndCB3aGVyZSBpdCBzaG91bGQgYmUgZG9uZToNCnRoZSBzcGxpdHRpbmcgc2hvdWxkIGJl
IGRvbmUgaW4gd3BfaHVnZV9wdWQsIGp1c3QgbGlrZSBpdCdzIGRvbmUgZm9yDQpQTURzLiBSZWFz
b24gYmVpbmcgdGhhdCBpZiBhIGNhbGxiYWNrIGlzIHRha2VuIGR1cmluZyBjcmVhdGUsIHRoZXJl
IGlzDQpubyBQVUQgeWV0IHNvIG5vdGhpbmcgdG8gc3BsaXQsIHdoZXJlYXMgaWYgYSBmYWxsYmFj
ayBpcyB0YWtlbiB3aGVuDQplbmNvdW50ZXJpbmcgYSB3cml0ZSBwcm90ZWN0aW9uIGZhdWx0IHRo
ZXJlIGlzIHNvbWV0aGluZyB0byBzcGxpdC4NCg0KSXQgbG9va3MgbGlrZSB0aGlzIHdhcyB0aGUg
b3JpZ2luYWwgaW50ZW50aW9uIHdpdGggdGhlIGNvbW1pdCB3aGVyZSB0aGUNCnNwbGl0dGluZyB3
YXMgaW50cm9kdWNlZCwgYnV0IHNvbWVob3cgaXQgZ290IG1vdmVkIHRvIHRoZSB3cm9uZyBwbGFj
ZQ0KYmV0d2VlbiB2MSBhbmQgdjIgb2YgdGhlIHBhdGNoIHNlcmllcy4gUmViYXNlIG1pc3Rha2Ug
cGVyaGFwcy4NCg0KRml4ZXM6IDMyN2U5ZmQ0ODk3MiAoIm1tOiBTcGxpdCBodWdlIHBhZ2VzIG9u
IHdyaXRlLW5vdGlmeSBvciBDT1ciKQ0KDQpDYzogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5o
ZWxsc3Ryb21AbGludXguaW50ZWwuY29tPg0KQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc+DQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPg0KQ2M6IEphbiBILiBTY2jDtm5oZXJyIDxqc2Nob2VuaEBhbWF6b24uZGU+DQpTaWdu
ZWQtb2ZmLWJ5OiBKYW1lcyBHb3dhbnMgPGpnb3dhbnNAYW1hem9uLmNvbT4NCi0tLQ0KIG1tL21l
bW9yeS5jIHwgMzEgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL21t
L21lbW9yeS5jIGIvbW0vbWVtb3J5LmMNCmluZGV4IDdhMDg5MTQ1Y2FkNC4uNGNmN2Q0YjZjOTUw
IDEwMDY0NA0KLS0tIGEvbW0vbWVtb3J5LmMNCisrKyBiL21tL21lbW9yeS5jDQpAQCAtNDgwMiwy
OSArNDgwMiwzMCBAQCBzdGF0aWMgdm1fZmF1bHRfdCBjcmVhdGVfaHVnZV9wdWQoc3RydWN0IHZt
X2ZhdWx0ICp2bWYpDQogCWRlZmluZWQoQ09ORklHX0hBVkVfQVJDSF9UUkFOU1BBUkVOVF9IVUdF
UEFHRV9QVUQpDQogCS8qIE5vIHN1cHBvcnQgZm9yIGFub255bW91cyB0cmFuc3BhcmVudCBQVUQg
cGFnZXMgeWV0ICovDQogCWlmICh2bWFfaXNfYW5vbnltb3VzKHZtZi0+dm1hKSkNCi0JCWdvdG8g
c3BsaXQ7DQotCWlmICh2bWYtPnZtYS0+dm1fb3BzLT5odWdlX2ZhdWx0KSB7DQotCQl2bV9mYXVs
dF90IHJldCA9IHZtZi0+dm1hLT52bV9vcHMtPmh1Z2VfZmF1bHQodm1mLCBQRV9TSVpFX1BVRCk7
DQotDQotCQlpZiAoIShyZXQgJiBWTV9GQVVMVF9GQUxMQkFDSykpDQotCQkJcmV0dXJuIHJldDsN
Ci0JfQ0KLXNwbGl0Og0KLQkvKiBDT1cgb3Igd3JpdGUtbm90aWZ5IG5vdCBoYW5kbGVkIG9uIFBV
RCBsZXZlbDogc3BsaXQgcHVkLiovDQotCV9fc3BsaXRfaHVnZV9wdWQodm1mLT52bWEsIHZtZi0+
cHVkLCB2bWYtPmFkZHJlc3MpOw0KKwkJcmV0dXJuIFZNX0ZBVUxUX0ZBTExCQUNLOw0KKwlpZiAo
dm1mLT52bWEtPnZtX29wcy0+aHVnZV9mYXVsdCkNCisJCXJldHVybiB2bWYtPnZtYS0+dm1fb3Bz
LT5odWdlX2ZhdWx0KHZtZiwgUEVfU0laRV9QVUQpOw0KICNlbmRpZiAvKiBDT05GSUdfVFJBTlNQ
QVJFTlRfSFVHRVBBR0UgKi8NCiAJcmV0dXJuIFZNX0ZBVUxUX0ZBTExCQUNLOw0KIH0NCiANCiBz
dGF0aWMgdm1fZmF1bHRfdCB3cF9odWdlX3B1ZChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgcHVkX3Qg
b3JpZ19wdWQpDQogew0KLSNpZmRlZiBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UNCisjaWYg
ZGVmaW5lZChDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UpICYmCQkJXA0KKwlkZWZpbmVkKENP
TkZJR19IQVZFX0FSQ0hfVFJBTlNQQVJFTlRfSFVHRVBBR0VfUFVEKQ0KIAkvKiBObyBzdXBwb3J0
IGZvciBhbm9ueW1vdXMgdHJhbnNwYXJlbnQgUFVEIHBhZ2VzIHlldCAqLw0KIAlpZiAodm1hX2lz
X2Fub255bW91cyh2bWYtPnZtYSkpDQotCQlyZXR1cm4gVk1fRkFVTFRfRkFMTEJBQ0s7DQotCWlm
ICh2bWYtPnZtYS0+dm1fb3BzLT5odWdlX2ZhdWx0KQ0KLQkJcmV0dXJuIHZtZi0+dm1hLT52bV9v
cHMtPmh1Z2VfZmF1bHQodm1mLCBQRV9TSVpFX1BVRCk7DQotI2VuZGlmIC8qIENPTkZJR19UUkFO
U1BBUkVOVF9IVUdFUEFHRSAqLw0KKwkJZ290byBzcGxpdDsNCisJaWYgKHZtZi0+dm1hLT52bV9v
cHMtPmh1Z2VfZmF1bHQpIHsNCisJCXZtX2ZhdWx0X3QgcmV0ID0gdm1mLT52bWEtPnZtX29wcy0+
aHVnZV9mYXVsdCh2bWYsIFBFX1NJWkVfUFVEKTsNCisNCisJCWlmICghKHJldCAmIFZNX0ZBVUxU
X0ZBTExCQUNLKSkNCisJCQlyZXR1cm4gcmV0Ow0KKwl9DQorc3BsaXQ6DQorCS8qIENPVyBvciB3
cml0ZS1ub3RpZnkgbm90IGhhbmRsZWQgb24gUFVEIGxldmVsOiBzcGxpdCBwdWQuKi8NCisJX19z
cGxpdF9odWdlX3B1ZCh2bWYtPnZtYSwgdm1mLT5wdWQsIHZtZi0+YWRkcmVzcyk7DQorI2VuZGlm
IC8qIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRSAmJiBDT05GSUdfSEFWRV9BUkNIX1RSQU5T
UEFSRU5UX0hVR0VQQUdFX1BVRCAqLw0KIAlyZXR1cm4gVk1fRkFVTFRfRkFMTEJBQ0s7DQogfQ0K
IA0KLS0gDQoyLjI1LjENCg0K
