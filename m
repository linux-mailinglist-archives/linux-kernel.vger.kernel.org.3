Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CAF5849EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiG2CvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiG2CvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:51:05 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A249F13D32
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659063062;
        bh=CFRXsQSgGZPmMci7VZMi7Cg1t1nxFRUf8fi3wwhGew4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l2YFMuq9czxdVPVJi0ZRftHO46JsNcw+r7r76pcOeoufSm2nYjS61J5W1bRMf2WNK
         5xDvtLs5GKzX1CoaOgvseSis2lL58mK76K6kPQ+JlbE46Y9LRaqtpCww3+MMSgp71r
         5l3mupB/g/IRXM4/Rnv1coEFkVUV+aJX4S/WBTKg=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id CC86F65938;
        Thu, 28 Jul 2022 22:51:00 -0400 (EDT)
Message-ID: <54026014a1894a3f1eb0056dbc61a8ce31f4d2da.camel@xry111.site>
Subject: Re: [PATCH v3 3/4] LoongArch: Remove -fplt and -Wa,-mla-* from
 CFLAGS
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev, Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Fri, 29 Jul 2022 10:50:59 +0800
In-Reply-To: <4da7ce6a6e5b6d609c37ebf6815caacc3b3b8297.camel@xry111.site>
References: <bb7824d39a694b13069718c2b8193379f79229b4.camel@xry111.site>
         <4da7ce6a6e5b6d609c37ebf6815caacc3b3b8297.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTI5IGF0IDEwOjA5ICswODAwLCBYaSBSdW95YW8gd3JvdGU6Cj4gLWZw
bHQgaXMgdGhlIGRlZmF1bHQgb2YgYWxsIHN1cHBvcnRlZCBjb21waWxlcnMgKEdDQywgYW5kIG1h
eWJlIENsYW5nIGluCj4gdGhlIGZ1dHVyZSksIHNvIGl0IG5lZWRzIG5vdCB0byBiZSBleHBsaWNp
dGx5IHNwZWNpZmllZC4KPiAKPiAtV2EsLW1sYS0qIG9wdGlvbnMgd2VyZSB1c2VkIHRvIHByZXZl
bnQgdGhlIGFzc2VtYmxlciBmcm9tIGdlbmVyYXRpbmcKPiBHT1QgYWNjZXNzZXMgZm9yICJsYS5s
b2NhbCIgYW5kICJsYS5nbG9iYWwiIG1hY3Jvcy7CoCBCdXQgR0NDID49IDEzIHdpbGwKPiBnZW5l
cmF0ZSBHT1QgYWNjZXNzIGV4cGxpY2l0bHkgd2l0aG91dCB1c2Ugb2YgdGhlc2UgbWFjcm9zCgpX
aWxsIGFkZCAiYnkgZGVmYXVsdCB3aXRoIGFuIGFzc2VtYmxlciBzdXBwb3J0aW5nIGV4cGxpY2l0
IHJlbG9jYXRpb25zLAphbmQgaXQncyBub3QgcmVjb21tZW5kZWQgdG8gb3ZlcnJpZGUgdGhlIGRl
ZmF1bHQiIGhlcmUgaW4gVjQuCgo+IG9wdGlvbnMgYXJlIGluZWZmZWN0aXZlIGZvciBzeW1ib2wg
YWRkcmVzc2luZyBpbiBDIGNvZGUgd2l0aCBHQ0MgPj0gMTMuCj4gTm93IHdlIGNhbiBoYW5kbGUg
R09UIGFuZCBHT1QtYmFzZWQgcmVsb2NhdGlvbnMgcHJvcGVybHksIHNvIHdlIGNhbgo+IHJlbW92
ZSB0aGVzZSBvcHRpb25zIGFuZCB1c2UgR09UIGFjY2VzcyBmb3IgYm90aCBHQ0MgMTIgYW5kIDEz
Cj4gKG9yIG5ld2VyKS4KPiAKPiBHQVMgPD0gMi4zOSBkb2VzIG5vdCBzdXBwb3J0ICJsYS5nb3Qg
W3JlZ10sIFtzeW1dICsgW29mZnNldF0iIHdpdGggYQo+IG5vbi16ZXJvIG9mZnNldC7CoCBTbyBp
biB0aGUgYXNzZW1ibHkgY29kZSB3ZSBleHBsaWNpdGx5IHVzZSAibGEucGNyZWwiCj4gaW5zdGVh
ZCBvZiAibGEiIChub3cgZGVmYXVsdGVkIHRvICJsYS5nb3QiKSB3aGVyZSBhIFBDLXJlbGF0aXZl
Cj4gYWRkcmVzc2luZyBpcyBzdWl0YWJsZSwgaW4gb3JkZXIgdG8gd29yayBhcm91bmQgdGhpcyBs
aW1pdGF0aW9uIGFuZCBrZWVwCj4gdGhlIGNvbXBhdGliaWxpdHkgd2l0aCBvbGQgdG9vbGNoYWlu
cy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBYaSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0ZT4KPiAt
LS0KPiDCoGFyY2gvbG9vbmdhcmNoL01ha2VmaWxlwqDCoMKgwqDCoCB8wqAgNCAtLS0tCj4gwqBh
cmNoL2xvb25nYXJjaC9rZXJuZWwvaGVhZC5TIHwgMTAgKysrKystLS0tLQo+IMKgMiBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2FyY2gvbG9vbmdhcmNoL01ha2VmaWxlIGIvYXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUKPiBpbmRl
eCAwMzlkY2M0ZmUxZjMuLjgwMDM0OWVhOTMxMCAxMDA2NDQKPiAtLS0gYS9hcmNoL2xvb25nYXJj
aC9NYWtlZmlsZQo+ICsrKyBiL2FyY2gvbG9vbmdhcmNoL01ha2VmaWxlCj4gQEAgLTQwLDEwICs0
MCw2IEBAIGVuZGlmCj4gwqAKPiDCoGNmbGFncy15wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCs9IC1HMCAtcGlwZSAtbXNvZnQtZmxvYXQKPiDCoExERkxBR1Nf
dm1saW51eMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCs9
IC1HMCAtc3RhdGljIC1uIC1ub3N0ZGxpYgo+IC1LQlVJTERfQUZMQUdTX0tFUk5FTMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqArPSAtV2EsLW1sYS1nbG9iYWwtd2l0aC1wY3JlbAo+IC1LQlVJTERfQ0ZM
QUdTX0tFUk5FTMKgwqDCoMKgwqDCoMKgwqDCoMKgwqArPSAtV2EsLW1sYS1nbG9iYWwtd2l0aC1w
Y3JlbAo+IC1LQlVJTERfQUZMQUdTX01PRFVMRcKgwqDCoMKgwqDCoMKgwqDCoMKgwqArPSAtV2Es
LW1sYS1nbG9iYWwtd2l0aC1hYnMKPiAtS0JVSUxEX0NGTEFHU19NT0RVTEXCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgKz0gLWZwbHQgLVdhLC1tbGEtZ2xvYmFsLXdpdGgtYWJzLC1tbGEtbG9jYWwtd2l0
aC1hYnMKPiDCoAo+IMKgY2ZsYWdzLXkgKz0gLWZmcmVlc3RhbmRpbmcKPiDCoGNmbGFncy15ICs9
ICQoY2FsbCBjYy1vcHRpb24sIC1tbm8tY2hlY2stemVyby1kaXZpc2lvbikKPiBkaWZmIC0tZ2l0
IGEvYXJjaC9sb29uZ2FyY2gva2VybmVsL2hlYWQuUyBiL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC9o
ZWFkLlMKPiBpbmRleCA3NGVhN2JmNmM4ZDYuLjE5MzMyOWVkNmU4YyAxMDA2NDQKPiAtLS0gYS9h
cmNoL2xvb25nYXJjaC9rZXJuZWwvaGVhZC5TCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gva2VybmVs
L2hlYWQuUwo+IEBAIC02MCwxNyArNjAsMTcgQEAgU1lNX0NPREVfU1RBUlQoa2VybmVsX2VudHJ5
KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCMga2VybmVs
IGVudHJ5IHBvaW50Cj4gwqDCoMKgwqDCoMKgwqDCoGxhLmFic8KgwqDCoMKgwqDCoMKgwqDCoMKg
dDAsIDBmCj4gwqDCoMKgwqDCoMKgwqDCoGppcmzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB6ZXJv
LCB0MCwgMAo+IMKgMDoKPiAtwqDCoMKgwqDCoMKgwqBsYcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB0MCwgX19ic3Nfc3RhcnTCoMKgwqDCoMKgwqDCoMKgwqAjIGNsZWFyIC5ic3MKPiArwqDC
oMKgwqDCoMKgwqBsYS5wY3JlbMKgwqDCoMKgwqDCoMKgwqB0MCwgX19ic3Nfc3RhcnTCoMKgwqDC
oMKgwqDCoMKgwqAjIGNsZWFyIC5ic3MKPiDCoMKgwqDCoMKgwqDCoMKgc3QuZMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHplcm8sIHQwLCAwCj4gLcKgwqDCoMKgwqDCoMKgbGHCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgdDEsIF9fYnNzX3N0b3AgLSBMT05HU0laRQo+ICvCoMKgwqDCoMKgwqDC
oGxhLnBjcmVswqDCoMKgwqDCoMKgwqDCoHQxLCBfX2Jzc19zdG9wIC0gTE9OR1NJWkUKPiDCoDE6
Cj4gwqDCoMKgwqDCoMKgwqDCoGFkZGkuZMKgwqDCoMKgwqDCoMKgwqDCoMKgdDAsIHQwLCBMT05H
U0laRQo+IMKgwqDCoMKgwqDCoMKgwqBzdC5kwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgemVybywg
dDAsIDAKPiDCoMKgwqDCoMKgwqDCoMKgYm5lwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0MCwg
dDEsIDFiCj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBsYcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB0MCwgZndfYXJnMAo+ICvCoMKgwqDCoMKgwqDCoGxhLnBjcmVswqDCoMKgwqDCoMKgwqDCoHQw
LCBmd19hcmcwCj4gwqDCoMKgwqDCoMKgwqDCoHN0LmTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBh
MCwgdDAsIDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjIGZpcm13YXJlIGFyZ3VtZW50
cwo+IC3CoMKgwqDCoMKgwqDCoGxhwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHQwLCBmd19h
cmcxCj4gK8KgwqDCoMKgwqDCoMKgbGEucGNyZWzCoMKgwqDCoMKgwqDCoMKgdDAsIGZ3X2FyZzEK
PiDCoMKgwqDCoMKgwqDCoMKgc3QuZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGExLCB0MCwgMAo+
IMKgCj4gwqDCoMKgwqDCoMKgwqDCoC8qIEtTYXZlMyB1c2VkIGZvciBwZXJjcHUgYmFzZSwgaW5p
dGlhbGl6ZWQgYXMgMCAqLwo+IEBAIC03OCw3ICs3OCw3IEBAIFNZTV9DT0RFX1NUQVJUKGtlcm5l
bF9lbnRyeSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjIGtlcm5lbCBlbnRy
eSBwb2ludAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBHUFIyMSB1c2VkIGZvciBwZXJjcHUgYmFzZSAo
cnVudGltZSksIGluaXRpYWxpemVkIGFzIDAgKi8KPiDCoMKgwqDCoMKgwqDCoMKgb3LCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgdTAsIHplcm8sIHplcm8KPiDCoAo+IC3CoMKgwqDCoMKgwqDC
oGxhwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRwLCBpbml0X3RocmVhZF91bmlvbgo+ICvC
oMKgwqDCoMKgwqDCoGxhLnBjcmVswqDCoMKgwqDCoMKgwqDCoHRwLCBpbml0X3RocmVhZF91bmlv
bgo+IMKgwqDCoMKgwqDCoMKgwqAvKiBTZXQgdGhlIFNQIGFmdGVyIGFuIGVtcHR5IHB0X3JlZ3Mu
wqAgKi8KPiDCoMKgwqDCoMKgwqDCoMKgUFRSX0xJwqDCoMKgwqDCoMKgwqDCoMKgwqBzcCwgKF9U
SFJFQURfU0laRSAtIDMyIC0gUFRfU0laRSkKPiDCoMKgwqDCoMKgwqDCoMKgUFRSX0FERMKgwqDC
oMKgwqDCoMKgwqDCoHNwLCBzcCwgdHAKCi0tIApYaSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0
ZT4KU2Nob29sIG9mIEFlcm9zcGFjZSBTY2llbmNlIGFuZCBUZWNobm9sb2d5LCBYaWRpYW4gVW5p
dmVyc2l0eQo=

