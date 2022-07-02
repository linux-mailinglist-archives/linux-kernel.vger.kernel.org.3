Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04FE563EAF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 07:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiGBFnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 01:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBFnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 01:43:39 -0400
Received: from mail4.tencent.com (mail12.tencent.com [61.241.47.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E936212744
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 22:43:23 -0700 (PDT)
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail4.tencent.com (Postfix) with ESMTP id 76FD064CFB;
        Sat,  2 Jul 2022 13:43:19 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1656740599;
        bh=Qr1/VoldSoDRmeq9sb7whdv1p5Xm3JSDTtVTXlfu2wA=;
        h=From:To:Subject:Date;
        b=dd2DpIaVXjNaEl3ZYK+8DPY+ZOAlwctIM1i99mpAEQI8ml4MIZfBObzMNptK56B/i
         IOajTHVVOM7JIlfpxiGADPUwd/RMAI9geqepMCM0BZG0xf7mM0Qi12LVZStzdb5Dod
         8uUIpaj1kUhxnVj2Lx5IG+EHbIL8MBRAIpjQcGiM=
Received: from EX-SZ007.tencent.com (10.28.6.31) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 2 Jul 2022
 13:43:19 +0800
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ007.tencent.com
 (10.28.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 2 Jul 2022
 13:43:19 +0800
Received: from EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930]) by
 EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930%2]) with mapi id
 15.01.2242.008; Sat, 2 Jul 2022 13:43:19 +0800
From:   =?gb2312?B?aGFpYmluemhhbmco1cW6o7HzKQ==?= <haibinzhang@tencent.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Martin Ma <Martin.Ma@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hewenliang4@huawei.com" <hewenliang4@huawei.com>
Subject: [PATCH V2] arm64: fix oops in concurrently setting insn_emulation
 sysctls 
Thread-Topic: [PATCH V2] arm64: fix oops in concurrently setting
 insn_emulation sysctls 
Thread-Index: AQHYjdaixOX+L2cpukiGMcsED+5ecw==
Date:   Sat, 2 Jul 2022 05:43:19 +0000
Message-ID: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.17.209]
Content-Type: text/plain; charset="gb2312"
Content-ID: <8B8ED50DE69E9742AA272A0F4141C2C9@tencent.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SG93IHRvIHJlcHJvZHVjZToNCiAgICBsYXVuY2ggdHdvIHNoZWxsIGV4ZWN1dGlvbnM6DQogICAg
ICAgIyEvYmluL2Jhc2gNCiAgICAgICB3aGlsZSBbIDEgXTsNCiAgICAgICBkbw0KICAgICAgICAg
ICBlY2hvIDEgPiAvcHJvYy9zeXMvYWJpL3N3cA0KICAgICAgIGRvbmUNCg0KT29wcyBpbmZvOg0K
ICAgIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2
aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDAxMA0KICAgIEludGVybmFsIGVycm9yOiBPb3Bz
OiA5NjAwMDAwNiBbIzFdIFNNUA0KICAgIENhbGwgdHJhY2U6DQogICAgdXBkYXRlX2luc25fZW11
bGF0aW9uX21vZGUrMHhjMC8weDE0OA0KICAgIGVtdWxhdGlvbl9wcm9jX2hhbmRsZXIrMHg2NC8w
eGI4DQogICAgcHJvY19zeXNfY2FsbF9oYW5kbGVyKzB4OWMvMHhmOA0KICAgIHByb2Nfc3lzX3dy
aXRlKzB4MTgvMHgyMA0KICAgIF9fdmZzX3dyaXRlKzB4MjAvMHg0OA0KICAgIHZmc193cml0ZSsw
eGU0LzB4MWQwDQogICAga3N5c193cml0ZSsweDcwLzB4ZjgNCiAgICBfX2FybTY0X3N5c193cml0
ZSsweDIwLzB4MjgNCiAgICBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMCsweDdjLzB4MWMwDQog
ICAgZWwwX3N2Y19oYW5kbGVyKzB4MmMvMHhhMA0KICAgIGVsMF9zdmMrMHg4LzB4MjAwDQoNCmVt
dWxhdGlvbl9wcm9jX2hhbmRsZXIgY2hhbmdlcyB0YWJsZS0+ZGF0YSBmb3IgcHJvY19kb2ludHZl
Y19taW5tYXgNCmFuZCBzbyBpdCBpc24ndCBhbGxvd2VkIHRvIHJlZW50ZXIgYmVmb3JlIHJlc3Rv
cmluZyB0YWJsZS0+ZGF0YSwNCndoaWNoIGlzbid0IHJpZ2h0IG5vdy4NClRvIGZpeCB0aGlzIGlz
c3VlLCBrZWVwIHRoZSB0YWJsZS0+ZGF0YSBhcyAmaW5zbi0+Y3VycmVudF9tb2RlIGFuZA0KdXNl
IGNvbnRhaW5lcl9vZigpIHRvIHJldHJpZXZlIHRoZSBpbnNuIHBvaW50ZXIuIEFub3RoZXIgbXV0
ZXggaXMNCnVzZWQgdG8gcHJvdGVjdCBhZ2FpbnN0IHRoZSBjdXJyZW50X21vZGUgdXBkYXRlIGJ1
dCBub3QgZm9yIHJldHJpZXZpbmcNCmluc25fZW11bGF0aW9uIGFzIHRhYmxlLT5kYXRhIGlzIG5v
IGxvbmdlciBjaGFuZ2luZy4NCg0KU2lnbmVkLW9mZi1ieTogaGV3ZW5saWFuZyA8aGV3ZW5saWFu
ZzRAaHVhd2VpLmNvbT4NClNpZ25lZC1vZmYtYnk6IEhhaWJpbiBaaGFuZyA8aGFpYmluemhhbmdA
dGVuY2VudC5jb20+DQotLS0NCiBhcmNoL2FybTY0L2tlcm5lbC9hcm12OF9kZXByZWNhdGVkLmMg
fCA5ICsrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC9hcm12OF9kZXByZWNhdGVk
LmMgYi9hcmNoL2FybTY0L2tlcm5lbC9hcm12OF9kZXByZWNhdGVkLmMNCmluZGV4IDY4NzVhMTZi
MDlkMi4uZmIwZTdjN2IyZTIwIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvYXJtdjhf
ZGVwcmVjYXRlZC5jDQorKysgYi9hcmNoL2FybTY0L2tlcm5lbC9hcm12OF9kZXByZWNhdGVkLmMN
CkBAIC01OSw2ICs1OSw3IEBAIHN0cnVjdCBpbnNuX2VtdWxhdGlvbiB7DQogc3RhdGljIExJU1Rf
SEVBRChpbnNuX2VtdWxhdGlvbik7DQogc3RhdGljIGludCBucl9pbnNuX2VtdWxhdGVkIF9faW5p
dGRhdGE7DQogc3RhdGljIERFRklORV9SQVdfU1BJTkxPQ0soaW5zbl9lbXVsYXRpb25fbG9jayk7
DQorc3RhdGljIERFRklORV9NVVRFWChpbnNuX2VtdWxhdGlvbl9tdXRleCk7DQogDQogc3RhdGlj
IHZvaWQgcmVnaXN0ZXJfZW11bGF0aW9uX2hvb2tzKHN0cnVjdCBpbnNuX2VtdWxhdGlvbl9vcHMg
Km9wcykNCiB7DQpAQCAtMjA3LDEwICsyMDgsMTAgQEAgc3RhdGljIGludCBlbXVsYXRpb25fcHJv
Y19oYW5kbGVyKHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlLCBpbnQgd3JpdGUsDQogCQkJCSAgbG9m
Zl90ICpwcG9zKQ0KIHsNCiAJaW50IHJldCA9IDA7DQotCXN0cnVjdCBpbnNuX2VtdWxhdGlvbiAq
aW5zbiA9IChzdHJ1Y3QgaW5zbl9lbXVsYXRpb24gKikgdGFibGUtPmRhdGE7DQorCXN0cnVjdCBp
bnNuX2VtdWxhdGlvbiAqaW5zbiA9IGNvbnRhaW5lcl9vZih0YWJsZS0+ZGF0YSwgc3RydWN0IGlu
c25fZW11bGF0aW9uLCBjdXJyZW50X21vZGUpOw0KIAllbnVtIGluc25fZW11bGF0aW9uX21vZGUg
cHJldl9tb2RlID0gaW5zbi0+Y3VycmVudF9tb2RlOw0KIA0KLQl0YWJsZS0+ZGF0YSA9ICZpbnNu
LT5jdXJyZW50X21vZGU7DQorCW11dGV4X2xvY2soJmluc25fZW11bGF0aW9uX211dGV4KTsNCiAJ
cmV0ID0gcHJvY19kb2ludHZlY19taW5tYXgodGFibGUsIHdyaXRlLCBidWZmZXIsIGxlbnAsIHBw
b3MpOw0KIA0KIAlpZiAocmV0IHx8ICF3cml0ZSB8fCBwcmV2X21vZGUgPT0gaW5zbi0+Y3VycmVu
dF9tb2RlKQ0KQEAgLTIyMyw3ICsyMjQsNyBAQCBzdGF0aWMgaW50IGVtdWxhdGlvbl9wcm9jX2hh
bmRsZXIoc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSwNCiAJCXVwZGF0ZV9pbnNu
X2VtdWxhdGlvbl9tb2RlKGluc24sIElOU05fVU5ERUYpOw0KIAl9DQogcmV0Og0KLQl0YWJsZS0+
ZGF0YSA9IGluc247DQorCW11dGV4X3VubG9jaygmaW5zbl9lbXVsYXRpb25fbXV0ZXgpOw0KIAly
ZXR1cm4gcmV0Ow0KIH0NCiANCkBAIC0yNDcsNyArMjQ4LDcgQEAgc3RhdGljIHZvaWQgX19pbml0
IHJlZ2lzdGVyX2luc25fZW11bGF0aW9uX3N5c2N0bCh2b2lkKQ0KIAkJc3lzY3RsLT5tYXhsZW4g
PSBzaXplb2YoaW50KTsNCiANCiAJCXN5c2N0bC0+cHJvY25hbWUgPSBpbnNuLT5vcHMtPm5hbWU7
DQotCQlzeXNjdGwtPmRhdGEgPSBpbnNuOw0KKwkJc3lzY3RsLT5kYXRhID0gJmluc24tPmN1cnJl
bnRfbW9kZTsNCiAJCXN5c2N0bC0+ZXh0cmExID0gJmluc24tPm1pbjsNCiAJCXN5c2N0bC0+ZXh0
cmEyID0gJmluc24tPm1heDsNCiAJCXN5c2N0bC0+cHJvY19oYW5kbGVyID0gZW11bGF0aW9uX3By
b2NfaGFuZGxlcjsNCi0tIA0KMi4zNC4xDQoNCg==
