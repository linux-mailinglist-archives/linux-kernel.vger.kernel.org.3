Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9D3562936
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiGACfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiGACfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:35:20 -0400
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 19:35:04 PDT
Received: from mail4.tencent.com (mail12.tencent.com [61.241.47.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6104464D71
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:35:04 -0700 (PDT)
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail4.tencent.com (Postfix) with ESMTP id 763EB64D89;
        Fri,  1 Jul 2022 10:27:22 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1656642442;
        bh=hOumafnbFthRKnMSoqvzPmDkJbBf9FyR9c+E6SBh4Nw=;
        h=From:To:Subject:Date;
        b=d2eJ30+W5r5ds+qh4a+YhCVY3j07oJJ6FpeCalr8ZkHErIcLLadeJeuhQ1IvBMcJK
         kN7nn6QituoMFgZS27o31c9C8Av5McmUZbfdYUnJsmx+P+2Fns86wUSPqYhKJVfSJG
         H0dRz2c3a/q4bxdE+Y55W52yLglZeFTvP9KNZkxk=
Received: from EX-SZ002.tencent.com (10.28.6.14) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 1 Jul 2022
 10:27:18 +0800
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ002.tencent.com
 (10.28.6.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 1 Jul 2022
 10:27:17 +0800
Received: from EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930]) by
 EX-SZ006.tencent.com ([fe80::a84e:872e:7c90:2930%2]) with mapi id
 15.01.2242.008; Fri, 1 Jul 2022 10:27:17 +0800
From:   =?gb2312?B?aGFpYmluemhhbmco1cW6o7HzKQ==?= <haibinzhang@tencent.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: fix oops in concurrently setting insn_emulation
 sysctls 
Thread-Topic: [PATCH] arm64: fix oops in concurrently setting insn_emulation
 sysctls 
Thread-Index: AQHYjPIVshOi9CmPrUqeRqqEIT98RQ==
Date:   Fri, 1 Jul 2022 02:27:17 +0000
Message-ID: <6C55A58E-6F30-4EDD-B943-421226DBC4AD@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.17.23]
Content-Type: text/plain; charset="gb2312"
Content-ID: <999E871D873A274F97854FD169000B87@tencent.com>
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
c3VlLCBBZGQgbXV0YWwgZXhjbHVzaW9uIGNvdmVyaW5nIHJlbGF0ZWQgY29kZSBzZWN0aW9uLg0K
DQpTaWduZWQtb2ZmLWJ5OiBIYWliaW4gWmhhbmcgPGhhaWJpbnpoYW5nQHRlbmNlbnQuY29tPg0K
LS0tDQogYXJjaC9hcm02NC9rZXJuZWwvYXJtdjhfZGVwcmVjYXRlZC5jIHwgOSArKysrKysrLS0N
CiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvYXJtdjhfZGVwcmVjYXRlZC5jIGIvYXJjaC9hcm02
NC9rZXJuZWwvYXJtdjhfZGVwcmVjYXRlZC5jDQppbmRleCA2ODc1YTE2Li5jNTE5NzkyIDEwMDY0
NA0KLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvYXJtdjhfZGVwcmVjYXRlZC5jDQorKysgYi9hcmNo
L2FybTY0L2tlcm5lbC9hcm12OF9kZXByZWNhdGVkLmMNCkBAIC0yMDcsOCArMjA3LDEyIEBAIHN0
YXRpYyBpbnQgZW11bGF0aW9uX3Byb2NfaGFuZGxlcihzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwg
aW50IHdyaXRlLA0KIAkJCQkgIGxvZmZfdCAqcHBvcykNCiB7DQogCWludCByZXQgPSAwOw0KLQlz
dHJ1Y3QgaW5zbl9lbXVsYXRpb24gKmluc24gPSAoc3RydWN0IGluc25fZW11bGF0aW9uICopIHRh
YmxlLT5kYXRhOw0KLQllbnVtIGluc25fZW11bGF0aW9uX21vZGUgcHJldl9tb2RlID0gaW5zbi0+
Y3VycmVudF9tb2RlOw0KKwlzdHJ1Y3QgaW5zbl9lbXVsYXRpb24gKmluc247DQorCWVudW0gaW5z
bl9lbXVsYXRpb25fbW9kZSBwcmV2X21vZGU7DQorDQorCXJhd19zcGluX2xvY2soJmluc25fZW11
bGF0aW9uX2xvY2spOw0KKwlpbnNuID0gKHN0cnVjdCBpbnNuX2VtdWxhdGlvbiAqKSB0YWJsZS0+
ZGF0YTsNCisJcHJldl9tb2RlID0gaW5zbi0+Y3VycmVudF9tb2RlOw0KIA0KIAl0YWJsZS0+ZGF0
YSA9ICZpbnNuLT5jdXJyZW50X21vZGU7DQogCXJldCA9IHByb2NfZG9pbnR2ZWNfbWlubWF4KHRh
YmxlLCB3cml0ZSwgYnVmZmVyLCBsZW5wLCBwcG9zKTsNCkBAIC0yMjQsNiArMjI4LDcgQEAgc3Rh
dGljIGludCBlbXVsYXRpb25fcHJvY19oYW5kbGVyKHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlLCBp
bnQgd3JpdGUsDQogCX0NCiByZXQ6DQogCXRhYmxlLT5kYXRhID0gaW5zbjsNCisJcmF3X3NwaW5f
dW5sb2NrKCZpbnNuX2VtdWxhdGlvbl9sb2NrKTsNCiAJcmV0dXJuIHJldDsNCiB9DQogDQotLSAN
CjEuOC4zLjENCg0K
