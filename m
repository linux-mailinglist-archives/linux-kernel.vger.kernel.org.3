Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5754F92C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382751AbiFQO3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382595AbiFQO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:29:46 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFCBF54F99
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=SC/nP
        K4iH9WBD2tA7Pn4U3gtjCZsgXNfpKEqFy5vRXg=; b=qQfoEhcSJwmZ36hVTsR2p
        h+QJKZ5Wya1JL5DIN0f+1pez+BapxHuAaSv1e3IADzeilsuvNdKdQRVeCRVI/VJD
        YY6U8rfp+scg7ZiFWRVgN8M1kbaqO/GTO+OYQA3nwrTM6U/Wo0c3GPmbZbHYwOMq
        Cia1HnYGIDRBnXVh6tPsNg=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Fri, 17 Jun 2022 22:29:01 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 17 Jun 2022 22:29:01 +0800 (CST)
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
Message-ID: <69e7e81b.8204.18172113f39.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowAA3jPCuj6xi57k4AA--.61809W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuA0jF2JVj6h7ygAAsg
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
YXRpb24gb2YgCj50aGUgbG9vcC4KPgo+Cj5NYXliZSBvZl9ub2RlX3B1dChwb3dlcmNhcCkgc2hv
dWxkIGJlIGR1cGxpY2F0ZWQgZXZlcnl3aGVyZSBpdCBpcyAKPnJlbGV2YW50IGFuZCByZW1vdmVk
IGZyb20gdGhlIGVycm9yIGhhbmRsaW5nIHBhdGg/Cj5PciBhbiBhZGRpdGlvbmFsIHJlZmVyZW5j
ZSBzaG91bGQgYmUgdGFrZW4gYmVmb3JlIHRoZSBsb29wPwo+T3IgYWRkaW5nIGEgbmV3IGxhYmVs
IHdpdGggInBvd2VyY2FwID0gTlVMTCIgYW5kIGJyYW5jaGluZyB0aGVyZSB3aGVuIAo+bmVlZGVk
Pwo+Cj5DSgo+Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBIZSA8d2luZGhsQDEyNi5jb20+
Cj4+IC0tLQo+PiAgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vcGFsLXBvd2VyY2Fw
LmMgfCA1ICsrKystCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJu
di9vcGFsLXBvd2VyY2FwLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb3BhbC1w
b3dlcmNhcC5jCj4+IGluZGV4IDY0NTA2YjQ2ZTc3Yi4uYjEwMjQ3N2QzZjk1IDEwMDY0NAo+PiAt
LS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb3BhbC1wb3dlcmNhcC5jCj4+ICsr
KyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vcGFsLXBvd2VyY2FwLmMKPj4gQEAg
LTE1Myw3ICsxNTMsNyBAQCB2b2lkIF9faW5pdCBvcGFsX3Bvd2VyY2FwX2luaXQodm9pZCkKPj4g
ICAJcGNhcHMgPSBrY2FsbG9jKG9mX2dldF9jaGlsZF9jb3VudChwb3dlcmNhcCksIHNpemVvZigq
cGNhcHMpLAo+PiAgIAkJCUdGUF9LRVJORUwpOwo+PiAgIAlpZiAoIXBjYXBzKQo+PiAtCQlyZXR1
cm47Cj4+ICsJCWdvdG8gb3V0X3Bvd2VyY2FwOwo+PiAgIAo+PiAgIAlwb3dlcmNhcF9rb2JqID0g
a29iamVjdF9jcmVhdGVfYW5kX2FkZCgicG93ZXJjYXAiLCBvcGFsX2tvYmopOwo+PiAgIAlpZiAo
IXBvd2VyY2FwX2tvYmopIHsKPj4gQEAgLTIzNiw2ICsyMzYsOSBAQCB2b2lkIF9faW5pdCBvcGFs
X3Bvd2VyY2FwX2luaXQodm9pZCkKPj4gICAJCWtmcmVlKHBjYXBzW2ldLnBnLm5hbWUpOwo+PiAg
IAl9Cj4+ICAgCWtvYmplY3RfcHV0KHBvd2VyY2FwX2tvYmopOwo+PiArCW9mX25vZGVfcHV0KG5v
ZGUpOwo+PiAgIG91dF9wY2FwczoKPj4gICAJa2ZyZWUocGNhcHMpOwo+PiArb3V0X3Bvd2VyY2Fw
Ogo+PiArCW9mX25vZGVfcHV0KHBvd2VyY2FwKTsKPj4gICB9CgpIaSwgQ0ouCgpJIHRoaW5rIG15
IHBhdGNoIGlzIGNvcnJlY3QgYmFzZWQgb24gdGhlIG9sZCBjb21taXQ6IApodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29t
bWl0Lz9oPXY1LjE5LXJjMiZpZD0wOTcwMGM1MDRkOGU2M2ZhZmZkMmEyMjM1MDc0ZThjNWQxMzBj
YjhmCgpCdWdzIGFuZCBmaXggc29sdXRpb25zIGluIHRoaXMgMDk3MDBjNTA0ZDhlNjMtY29tbWl0
IGFyZSB2ZXJ5IHNpbWlsYXIgd2l0aCBtaW5lLgoKQmVzaWRlcywgSSBhbHNvIGZpbmQgc2ltaWxh
ciBuZXcgYnVncyBpbiBvdGhlciB0d28gZmlsZXMgaW4gdGhlIHNhbWUgZGlyZWN0b3J5ICdwb3dl
cm52JywgCnNvIEkgaGF2ZSBtZXJnZWQgYWxsIHRocmVlIGZpbGVzJyBwYXRjaGVzIGludG8gb25l
IGNvbW1pdC4gICdbUEFUQ0ggdjJdIHBvd2VycGM6IHBvd2VybnY6IEZpeCByZWZjb3VudCBsZWFr
IGJ1ZycuCgpUaGFua3MuCgpMaWFuZw==
