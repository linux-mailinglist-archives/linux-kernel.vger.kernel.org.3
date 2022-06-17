Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1748D54F0AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380147AbiFQFnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQFnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:43:09 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE90AE7D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=TKr6r
        aKJl5E/P0OF5/0A91UCikp3C7+zbMfc5Xn5T4g=; b=WPLIrEK61NImzEJSefASx
        Gk3F1Kq84rjW0r4bwhLAomClXg5lHUbhJsSCltdIuJXxG4i3CzejAPUL/wBnC/fk
        741+spaQPW62JDKsmUm+p0u1/KKjKSkYSEs+Q3XVGzqNvONrO0uxo1KkM69qRAfT
        ZhY6O4Y/xMkt84s0GzCCYs=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Fri, 17 Jun 2022 13:42:27 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 17 Jun 2022 13:42:27 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nick.child@ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] powerpc: powernv: Fix refcount leak bug in
 opal-powercap
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <0ca5ee14-a382-0935-66be-820975501f45@wanadoo.fr>
References: <20220617042038.4003704-1-windhl@126.com>
 <0ca5ee14-a382-0935-66be-820975501f45@wanadoo.fr>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6a9bcf7d.3ab8.181702f264d.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADXLPFEFKxil1A4AA--.54616W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhMjF18RPT4pZgACsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0xNyAxMzowMToyNywgIkNocmlzdG9waGUgSkFJTExFVCIgPGNocmlzdG9w
aGUuamFpbGxldEB3YW5hZG9vLmZyPiB3cm90ZToKPkxlIDE3LzA2LzIwMjIgw6AgMDY6MjAsIExp
YW5nIEhlIGEgw6ljcml0wqA6Cj4+IEluIG9wYWxfcG93ZXJjYXBfaW5pdCgpLCBvZl9maW5kX2Nv
bXBhdGlibGVfbm9kZSgpIHdpbGwgcmV0dXJuCj4+IGEgbm9kZSBwb2ludGVyIHdpdGggcmVmY291
bnQgaW5jcmVtZW50ZWQuIFdlIHNob3VsZCB1c2Ugb2Zfbm9kZV9wdXQoKQo+PiBpbiBmYWlsIHBh
dGggb3Igd2hlbiBpdCBpcyBub3QgdXNlZCBhbnltb3JlLgo+PiAKPj4gQmVzaWRlcywgZm9yX2Vh
Y2hfY2hpbGRfb2Zfbm9kZSgpIHdpbGwgYXV0b21hdGljYWxseSAqaW5jKiBhbmQgKmRlYyoKPj4g
cmVmY291bnQgZHVyaW5nIGl0ZXJhdGlvbi4gSG93ZXZlciwgd2Ugc2hvdWxkIGFkZCB0aGUgb2Zf
bm9kZV9wdXQoKQo+PiBpZiB0aGVyZSBpcyBhIGJyZWFrLgo+Cj5IaSwKPgo+SSdtIG5vdCBzdXJl
IHRoYXQgeW91ciBwYXRjaCBpcyByaWdodCBoZXJlLiBCZWNhdXNlIG9mIHRoaXMgKmluYyogYW5k
IAo+KmRlYyogdGhpbmdzLCBkbyB3ZSBzdGlsbCBuZWVkIHRvIG9mX25vZGVfcHV0KHBvd2VyY2Fw
KSBvbmNlIHdlIGhhdmUgCj5lbnRlcmVkIGZvcl9lYWNoX2NoaWxkX29mX25vZGU/Cj4KPkkgdGhp
bmsgdGhhdCB0aGlzIHJlZmVyZW5jZSB3aWxsIGJlIHJlbGVhc2VkIG9uIHRoZSBmaXJzdCBpdGVy
YXRpb24gb2YgCj50aGUgbG9vcC4KPgoKSGksIENKLCAKClRoYW5rcyBmb3IgeW91ciByZXBseSBh
bmQgSSB3YW50IGhhdmUgYSBkaXNjdXNzLgoKQmFzZWQgb24gbXkgcmV2aWV3IG9uIHRoZSBzcmMg
b2YgJ29mX2dldF9uZXh0X2NoaWxkJywgIHRoZXJlIGlzIG9ubHkKKmluYyogZm9yIG5leHQgYW5k
ICpkZWMqIGZvciBwcmUgYXMgZm9sbG93LiAKCih8bm9kZXwgPT0gcG93ZXJjYXApCj09PT09PV9f
b2ZfZ2V0X25leHRfY2hpbGQoIHxub2RlfCwgcHJldik9PT09PT0KICAgICAuLi4KICAgICAgICBu
ZXh0ID0gcHJldj8gcHJldi0+c2libGluZzp8bm9kZXwtPmNoaWxkOwoJb2Zfbm9kZV9nZXQobmV4
dCk7CglvZl9ub2RlX3B1dChwcmV2KTsKICAgICAuLi4KPT09PT09PT09PT09PT09PT09PT09PT09
PQoKSG93ZXZlciwgdGhlcmUgaXMgbm8gYW55IGNvZGUgdG8gcmVsZWFzZSB0aGUgfG5vZGV8IChp
LmUuLCAqcG93ZXJjYXAqKS4KCkFtIEkgcmlnaHQ/ICAgSWYgSSBhbSB3cm9uZywgcGxlYXNlIGNv
cnJlY3QgbWUsIHRoYW5rcy4KCj4KPk1heWJlIG9mX25vZGVfcHV0KHBvd2VyY2FwKSBzaG91bGQg
YmUgZHVwbGljYXRlZCBldmVyeXdoZXJlIGl0IGlzIAo+cmVsZXZhbnQgYW5kIHJlbW92ZWQgZnJv
bSB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aD8KPk9yIGFuIGFkZGl0aW9uYWwgcmVmZXJlbmNlIHNo
b3VsZCBiZSB0YWtlbiBiZWZvcmUgdGhlIGxvb3A/Cj5PciBhZGRpbmcgYSBuZXcgbGFiZWwgd2l0
aCAicG93ZXJjYXAgPSBOVUxMIiBhbmQgYnJhbmNoaW5nIHRoZXJlIHdoZW4gCj5uZWVkZWQ/Cj4K
PkNKCgpJZiBteSB1bmRlcnN0YW5kaW5nIGlzIHJpZ2h0LCBJIHRoaW5rIGN1cnJlbnQgcGF0Y2gg
aXMgcmlnaHQuCgpPdGhlcndpc2UsIEkgd2lsbCBtYWtlIGEgbmV3IHBhdGNoIHRvIGhhbmRsZSB0
aGF0LCBUaGFua3MuCgpMaWFuZyAKCj4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3
aW5kaGxAMTI2LmNvbT4KPj4gLS0tCj4+ICAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52
L29wYWwtcG93ZXJjYXAuYyB8IDUgKysrKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wb3dlcm52L29wYWwtcG93ZXJjYXAuYyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
cG93ZXJudi9vcGFsLXBvd2VyY2FwLmMKPj4gaW5kZXggNjQ1MDZiNDZlNzdiLi5iMTAyNDc3ZDNm
OTUgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vcGFsLXBv
d2VyY2FwLmMKPj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29wYWwtcG93
ZXJjYXAuYwo+PiBAQCAtMTUzLDcgKzE1Myw3IEBAIHZvaWQgX19pbml0IG9wYWxfcG93ZXJjYXBf
aW5pdCh2b2lkKQo+PiAgIAlwY2FwcyA9IGtjYWxsb2Mob2ZfZ2V0X2NoaWxkX2NvdW50KHBvd2Vy
Y2FwKSwgc2l6ZW9mKCpwY2FwcyksCj4+ICAgCQkJR0ZQX0tFUk5FTCk7Cj4+ICAgCWlmICghcGNh
cHMpCj4+IC0JCXJldHVybjsKPj4gKwkJZ290byBvdXRfcG93ZXJjYXA7Cj4+ICAgCj4+ICAgCXBv
d2VyY2FwX2tvYmogPSBrb2JqZWN0X2NyZWF0ZV9hbmRfYWRkKCJwb3dlcmNhcCIsIG9wYWxfa29i
aik7Cj4+ICAgCWlmICghcG93ZXJjYXBfa29iaikgewo+PiBAQCAtMjM2LDYgKzIzNiw5IEBAIHZv
aWQgX19pbml0IG9wYWxfcG93ZXJjYXBfaW5pdCh2b2lkKQo+PiAgIAkJa2ZyZWUocGNhcHNbaV0u
cGcubmFtZSk7Cj4+ICAgCX0KPj4gICAJa29iamVjdF9wdXQocG93ZXJjYXBfa29iaik7Cj4+ICsJ
b2Zfbm9kZV9wdXQobm9kZSk7Cj4+ICAgb3V0X3BjYXBzOgo+PiAgIAlrZnJlZShwY2Fwcyk7Cj4+
ICtvdXRfcG93ZXJjYXA6Cj4+ICsJb2Zfbm9kZV9wdXQocG93ZXJjYXApOwo+PiAgIH0K
