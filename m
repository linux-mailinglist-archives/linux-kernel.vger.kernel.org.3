Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA5052DAFF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbiESRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbiESRPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:15:21 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3C05442A25;
        Thu, 19 May 2022 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=0F58Lq5d1lNVx8JamauTGm05Ut3UmzF74cM/
        5hgS8AE=; b=o5j+7Emzi4DhHiFqMkCQWTCur6lzKhbY+WfU1romSwpX8tFI/EgI
        hUA7pSI4MP4sezAm8xNVpJ+S/Fjlece9hFPR/Fq6GLCKKLL2bFqKOOUFsfIZRIGD
        i4kqJLE0Clpc9nq0O8ML+T5ULgPKoxQWYxtl4JpOLcAWr0iWLw5xalU=
Received: by ajax-webmail-front02 (Coremail) ; Fri, 20 May 2022 01:15:07
 +0800 (GMT+08:00)
X-Originating-IP: [10.129.37.75]
Date:   Fri, 20 May 2022 01:15:07 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY5rC45b+X?= <lyz_cs@pku.edu.cn>
To:     "greg kh" <gregkh@linuxfoundation.org>
Cc:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, felipe.balbi@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuyq@stu.pku.edu.cn
Subject: Re: Re: [PATCH] usb: cdns3:  Fix potential dereference of NULL
 pointer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-1ea67e80-64e4-49d5-bd9f-3beeae24b9f2-pku.edu.cn
In-Reply-To: <YoZrNRf5W4hLdy9N@kroah.com>
References: <1652861570-102489-1-git-send-email-lyz_cs@pku.edu.cn>
 <YoZrNRf5W4hLdy9N@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <465461c9.2a3c6.180dd50e22b.Coremail.lyz_cs@pku.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 54FpogC3N+cbe4Zi+T2fBg--.33161W
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwELBlPy7vKNNgACsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiR3JlZyBLSCIgPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPgo+IFNlbnQgVGltZTogMjAyMi0wNS0yMCAwMDowNzoxNyAo
RnJpZGF5KQo+IFRvOiAiWW9uZ3poaSBMaXUiIDxseXpfY3NAcGt1LmVkdS5jbj4KPiBDYzogcGV0
ZXIuY2hlbkBrZXJuZWwub3JnLCBwYXdlbGxAY2FkZW5jZS5jb20sIHJvZ2VycUBrZXJuZWwub3Jn
LCBhLWdvdmluZHJhanVAdGkuY29tLCBmZWxpcGUuYmFsYmlAbGludXguaW50ZWwuY29tLCBsaW51
eC11c2JAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBmdXlx
QHN0dS5wa3UuZWR1LmNuCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBjZG5zMzogIEZpeCBw
b3RlbnRpYWwgZGVyZWZlcmVuY2Ugb2YgTlVMTCBwb2ludGVyCj4gCj4gT24gV2VkLCBNYXkgMTgs
IDIwMjIgYXQgMDE6MTI6NTBBTSAtMDcwMCwgWW9uZ3poaSBMaXUgd3JvdGU6Cj4gPiBUaGUgcmV0
dXJuIHZhbHVlIG9mIGNkbnMzX2dhZGdldF9lcF9hbGxvY19yZXF1ZXN0KCkKPiA+IG5lZWRzIHRv
IGJlIGNoZWNrZWQgdG8gYXZvaWQgdXNlIG9mIE5VTEwgcG9pbnRlcgo+ID4gaW4gY2FzZSBvZiBh
biBhbGxvY2F0aW9uIGZhaWx1cmUuCj4gPiAKPiA+IEZpeGVzOiA3NzMzZjZjMzJlMzZmICgidXNi
OiBjZG5zMzogQWRkIENhZGVuY2UgVVNCMyBEUkQgRHJpdmVyIikKPiA+IAo+ID4gU2lnbmVkLW9m
Zi1ieTogWW9uZ3poaSBMaXUgPGx5el9jc0Bwa3UuZWR1LmNuPgo+IAo+IEFnYWluLCBubyBibGFu
ayBsaW5lIGFuZCB1c2UgdGhlIGZ1bGwgd2lkdGggZm9yIHlvdXIgdGV4dC4KPiAKPiA+IC0tLQo+
ID4gIGRyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLWdhZGdldC5jIHwgNiArKysrKy0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9jZG5zMy1nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2Nk
bnMzL2NkbnMzLWdhZGdldC5jCj4gPiBpbmRleCA1ZDhjOTgyLi43YmUzMjhlIDEwMDY0NAo+ID4g
LS0tIGEvZHJpdmVycy91c2IvY2RuczMvY2RuczMtZ2FkZ2V0LmMKPiA+ICsrKyBiL2RyaXZlcnMv
dXNiL2NkbnMzL2NkbnMzLWdhZGdldC5jCj4gPiBAQCAtMjU2OCw2ICsyNTY4LDEwIEBAIHN0YXRp
YyBpbnQgY2RuczNfZ2FkZ2V0X2VwX3F1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNi
X3JlcXVlc3QgKnJlcXVlc3QsCj4gPiAgCQlzdHJ1Y3QgY2RuczNfcmVxdWVzdCAqcHJpdl9yZXE7
Cj4gPiAgCj4gPiAgCQl6bHBfcmVxdWVzdCA9IGNkbnMzX2dhZGdldF9lcF9hbGxvY19yZXF1ZXN0
KGVwLCBHRlBfQVRPTUlDKTsKPiA+ICsJCWlmICghemxwX3JlcXVlc3QpIHsKPiA+ICsJCQlyZXQg
PSAtRU5PTUVNOwo+ID4gKwkJCWdvdG8gZXJyOwo+ID4gKwkJfQo+IAo+IEhvdyBkaWQgeW91IHRl
c3QgdGhpcyB0aGF0IHRoZSBpZiB0aGUgYWxsb2NhdGlvbiBmYWlscyB0aGlzIHdpbGwgY2xlYW4K
PiB1cCBwcm9wZXJseT8KPiAKCkkgZmluZCB0aGlzIGJ5IGEgc3RhdGljIGFuYWx5emVyIGJhc2Vk
IG9uIGZyZXF1ZW5jeSBhbmQgc2ltaWxhcml0eSwgd2hpY2ggcmVwb3J0IG1hbnkgbnVsbCBwdHIg
ZGVyZWYgYnVncy4KSW4gY2RuczMvY2RuczMtZ2FkZ2V0LmMsIEkgZmluZCB0aGF0IHdlIHVzdWFs
bHkgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSB3aGVuIGNhbGwgZnVuY3Rpb24gJ2NkbnMzX2dhZGdl
dF9lcF9hbGxvY19yZXF1ZXN0Jy4KSWYgJ3pjYWxsb2MnIGluICdjZG5zM19nYWRnZXRfZXBfYWxs
b2NfcmVxdWVzdCcgZmFpbGVkLCB0aGUgYWxsb2NhdGlvbiB3aWxsIHJldHVybiBudWxsLiBUaGVy
ZWZvcmUsIGkgdGhpbmsgd2Ugc2hvdWxkIGFkZCBudWxsIGNoZWNrcyBoZXJlLgpJIHdpbGwgcmVz
dWJtaXQgYSBuZXcgcGF0Y2ggaWYgeW91IHRoaW5rIHRoZSBidWcgaXMgcmVhbC4KVGhhbmtzIGZv
ciB5b3VyIHJlcGx5IGFuZCBhZHZpY2UuCgo+IHRoYW5rcywKPiAKPiBncmVnIGstaAo=
