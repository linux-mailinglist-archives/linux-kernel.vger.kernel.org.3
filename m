Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE6502373
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbiDOFJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350463AbiDOFEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:04:00 -0400
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 21:56:05 PDT
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D34E1BAB9C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:56:05 -0700 (PDT)
Received: by ajax-webmail-APP-09 (Coremail) ; Fri, 15 Apr 2022 12:47:22
 +0800 (GMT+08:00)
X-Originating-IP: [124.16.96.42]
Date:   Fri, 15 Apr 2022 12:47:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5r2Y5bqG6ZyW?= <panqinglin2020@iscas.ac.cn>
To:     "Anup Patel" <apatel@ventanamicro.com>
Cc:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Alexandre Ghiti" <alexandre.ghiti@canonical.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Alistair Francis" <Alistair.Francis@wdc.com>,
        "Anup Patel" <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Mayuresh Chitale" <mchitale@ventanamicro.com>
Subject: Re: [PATCH] RISC-V: mm: Fix set_satp_mode() for platform not having
 Sv57
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn cnic.cn
In-Reply-To: <20220412033335.1384230-1-apatel@ventanamicro.com>
References: <20220412033335.1384230-1-apatel@ventanamicro.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4c4c7a.17284.1802b8c14cc.Coremail.panqinglin2020@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowADX38_b+FhiWqMBAA--.17675W
X-CM-SenderInfo: 5sdq1xpqjox0asqsiq5lvft2wodfhubq/1tbiCQoRDF02bFOQ6AAA
        sy
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW51cCwKCiZndDsgCiZndDsgV2hlbiBTdjU3IGlzIG5vdCBhdmFpbGFibGUgdGhlIHNhdHAu
TU9ERSB0ZXN0IGluIHNldF9zYXRwX21vZGUoKSB3aWxsCiZndDsgZmFpbCBhbmQgbGVhZCB0byBw
Z2RpciByZS1wcm9ncmFtbWluZyBmb3IgU3Y0OC4gVGhlIHBnZGlyIHJlLXByb2dyYW1taW5nCiZn
dDsgd2lsbCBmYWlsIGFzIHdlbGwgZHVlIHRvIHByZS1leGlzdGluZyBwZ2RpciBlbnRyeSB1c2Vk
IGZvciBTdjU3IGFuZCBhcwomZ3Q7IGEgcmVzdWx0IGtlcm5lbCBmYWlscyB0byBib290IG9uIFJJ
U0MtViBwbGF0Zm9ybSBub3QgaGF2aW5nIFN2NTcuCiZndDsgCiZndDsgVG8gZml4IGFib3ZlIGlz
c3VlLCB3ZSBzaG91bGQgY2xlYXIgdGhlIHBnZGlyIG1lbW9yeSBpbiBzZXRfc2F0cF9tb2RlKCkK
Jmd0OyBiZWZvcmUgcmUtcHJvZ3JhbW1pbmcuCiZndDsgCiZndDsgRml4ZXM6IDAxMWYwOWQxMjA1
MiAoInJpc2N2OiBtbTogU2V0IHN2NTcgb24gZGVmYXVsdGx5IikKJmd0OyBSZXBvcnRlZC1ieTog
TWF5dXJlc2ggQ2hpdGFsZSA8bWNoaXRhbGVAdmVudGFuYW1pY3JvLmNvbT4KJmd0OyBTaWduZWQt
b2ZmLWJ5OiBBbnVwIFBhdGVsIDxhcGF0ZWxAdmVudGFuYW1pY3JvLmNvbT4KJmd0OyAtLS0KJmd0
OyAgYXJjaC9yaXNjdi9tbS9pbml0LmMgfCAxICsKJmd0OyAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCiZndDsgCiZndDsgZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvbW0vaW5pdC5jIGIv
YXJjaC9yaXNjdi9tbS9pbml0LmMKJmd0OyBpbmRleCA5NTM1YmVhODY4OGMuLmIwNzkzZGMwYzI5
MSAxMDA2NDQKJmd0OyAtLS0gYS9hcmNoL3Jpc2N2L21tL2luaXQuYwomZ3Q7ICsrKyBiL2FyY2gv
cmlzY3YvbW0vaW5pdC5jCiZndDsgQEAgLTcxOCw2ICs3MTgsNyBAQCBzdGF0aWMgX19pbml0IHZv
aWQgc2V0X3NhdHBfbW9kZSh2b2lkKQomZ3Q7ICAJCWlmICghY2hlY2tfbDQpIHsKJmd0OyAgCQkJ
ZGlzYWJsZV9wZ3RhYmxlX2w1KCk7CiZndDsgIAkJCWNoZWNrX2w0ID0gdHJ1ZTsKJmd0OyArCQkJ
bWVtc2V0KGVhcmx5X3BnX2RpciwgMCwgUEFHRV9TSVpFKTsKJmd0OyAgCQkJZ290byByZXRyeTsK
Jmd0OyAgCQl9CiZndDsgIAkJZGlzYWJsZV9wZ3RhYmxlX2w0KCk7CiZndDsgLS0gCgoKSSBmaW5k
IGl0IHRoYXQgdGhlIHNldF9zYXRwX21vZGUgZnVuY3Rpb24gaXMgaW4gLmluaXQudGV4dCBzZWN0
aW9uIHdoaWNoIGJlZ2lucyBhdCAweDgwODAwMDAwLgpBbmQgaXRzIHBnZF9pbmRleCBpbiBib3Ro
IFN2NDggYW5kIFN2NTcgd2lsbCBiZSAwLiBTbyBpdCBtYXkgbm90IGJlIG5lY2Vzc2FyeSB0byBj
bGVhciB0aGUgCmVhcmx5X3BnX2RpciB3aGVuIHRoZSBrZXJuZWwgZmluZCBTdjU3IGlzIG5vdCBz
dXBwb3J0ZWQ/IEFuZCBtYXkgSSBnZXQgdGhlIHN0ZXBzIG9mIHJlcHJvZHVjdGlvbgpmcm9tIHlv
dT8KIApZb3VycywKUWluZ2xpbgo8L2FwYXRlbEB2ZW50YW5hbWljcm8uY29tPjwvbWNoaXRhbGVA
dmVudGFuYW1pY3JvLmNvbT4=
