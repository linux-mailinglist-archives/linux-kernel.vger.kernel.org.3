Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858FF55C4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiF0PPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiF0PPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:15:21 -0400
Received: from m151.mail.126.com (m151.mail.126.com [220.181.15.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA17118394
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=kiY6j
        a1pu1wuCCmgcZHLtkEHdUXZwqvsJiUaD6bui2g=; b=CeCzIHeuJ01eR2jaeoVSy
        N84az+W1NMaGuqFFnOxWNWADucq93BjqkZdJ6APt3yVYzeuZhwKq6fd8k3wLW29m
        9Gq1YBBOIyhM4ZW0DLur+riK1l+jCa76M8zf+CndBFrBV3qtm20xhX7Z+lVg71A8
        HZ+ZmGOmBd9MuwkIoqy7l4=
Received: from windhl$126.com ( [123.112.70.164] ) by ajax-webmail-wmsvr1
 (Coremail) ; Mon, 27 Jun 2022 23:14:50 +0800 (CST)
X-Originating-IP: [123.112.70.164]
Date:   Mon, 27 Jun 2022 23:14:50 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     broonie@kernel.org, ckeepax@opensource.cirrus.com,
        michal.simek@xilinx.com, abhyuday.godhasara@xilinx.com,
        simont@opensource.cirrus.com, ronak.jain@xilinx.com,
        peng.fan@nxp.com, linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] firmware: Hold a reference for
 of_find_compatible_node()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <YrnG3ymy0dg/VPQs@kroah.com>
References: <20220621032625.4078445-1-windhl@126.com>
 <Yrm6JztPuqYmKlKF@kroah.com>
 <578840ee.438c.181a5a58c00.Coremail.windhl@126.com>
 <YrnG3ymy0dg/VPQs@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <1bed06e5.43da.181a5bac7e5.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AcqowADX6LBqybliYcYcAA--.17528W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAEtF2JVkEwkYQABss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTI3IDIzOjAzOjU5LCAiR3JlZyBLSCIgPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPiB3cm90ZToKPk9uIE1vbiwgSnVuIDI3LCAyMDIyIGF0IDEwOjUxOjM4UE0gKzA4MDAs
IExpYW5nIEhlIHdyb3RlOgo+PiAKPj4gCj4+IEF0IDIwMjItMDYtMjcgMjI6MDk6NDMsICJHcmVn
IEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+PiA+T24gVHVlLCBKdW4g
MjEsIDIwMjIgYXQgMTE6MjY6MjVBTSArMDgwMCwgTGlhbmcgSGUgd3JvdGU6Cj4+ID4+IEluIG9m
X3JlZ2lzdGVyX3RydXN0ZWRfZm91bmRhdGlvbnMoKSwgd2UgbmVlZCB0byBob2xkIHRoZSByZWZl
cmVuY2UKPj4gPj4gcmV0dXJuZWQgYnkgb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoKSBhbmQgdGhl
biB1c2UgaXQgdG8gY2FsbAo+PiA+PiBvZl9ub2RlX3B1dCgpIGZvciByZWZjb3VudCBiYWxhbmNl
Lgo+PiA+PiAKPj4gPj4gU2lnbmVkLW9mZi1ieTogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPgo+
PiA+PiAtLS0KPj4gPj4gIGluY2x1ZGUvbGludXgvZmlybXdhcmUvdHJ1c3RlZF9mb3VuZGF0aW9u
cy5oIHwgOCArKysrKystLQo+PiA+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPj4gPj4gCj4+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zp
cm13YXJlL3RydXN0ZWRfZm91bmRhdGlvbnMuaCBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvdHJ1
c3RlZF9mb3VuZGF0aW9ucy5oCj4+ID4+IGluZGV4IGJlNTk4NGJkYTU5Mi4uMzk5NDcxYzJmMWM3
IDEwMDY0NAo+PiA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3RydXN0ZWRfZm91bmRh
dGlvbnMuaAo+PiA+PiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3RydXN0ZWRfZm91bmRh
dGlvbnMuaAo+PiA+PiBAQCAtNzEsMTIgKzcxLDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCByZWdp
c3Rlcl90cnVzdGVkX2ZvdW5kYXRpb25zKAo+PiA+PiAgCj4+ID4+ICBzdGF0aWMgaW5saW5lIHZv
aWQgb2ZfcmVnaXN0ZXJfdHJ1c3RlZF9mb3VuZGF0aW9ucyh2b2lkKQo+PiA+PiAgewo+PiA+PiAr
CXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBO
VUxMLCAidGxtLHRydXN0ZWQtZm91bmRhdGlvbnMiKTsKPj4gPj4gKwo+PiA+PiArCW9mX25vZGVf
cHV0KG5wKTsKPj4gPj4gKwlpZiAoIW5wKQo+PiA+Cj4+ID5XaGlsZSB0aGlzIGlzIHRlY2huaWNh
bGx5IGNvcnJlY3QsIHlvdSBhcmUgbm93IGNoZWNraW5nIHRvIHNlZSBpZiB0aGlzCj4+ID5wb2lu
dHMgdG8gYSBtZW1vcnkgbG9jYXRpb24gdGhhdCB5b3Ugbm8gbG9uZ2VyIGtub3cgd2hhdCBpdCBy
ZWFsbHkKPj4gPmJlbG9uZ3MgdG8uICBDIHdpbGwgbGV0IHlvdSBkbyB0aGlzLCBidXQgaXQgbWln
aHQgYmUgbmljZXIgdG8gZml4IGl0IHVwCj4+ID5wcm9wZXJseSBzbyBpdCBkb2Vzbid0IGxvb2sg
bGlrZSB0aGlzLgo+PiA+Cj4+ID50aGFua3MsCj4+ID4KPj4gPmdyZWcgay1oCj4+IAo+PiBIaaOs
R3JlZyBLSKOsCj4+IAo+PiBUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGVmZm9ydCB0byByZXZp
ZXcgbXkgcGF0Y2guCj4+IAo+PiBJbiBmYWN0LCBJIGhhdmUgcmVwb3J0ZWQgYSBjb21taXQgZm9y
IHRoaXMga2luZCBvZiAnY2hlY2stYWZ0ZXItcHV0JyBjb2Rpbmcgc3R5bGU6Cj4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDYxNzExMjYzNi40MDQxNjcxLTEtd2luZGhsQDEyNi5j
b20vCj4+IAo+PiBCdXQgSSBoYXZlIGJlZW4gdG9sZCB0byBrZWVwIHN1Y2ggc3R5bGUgYW5kIEkg
dGhpbmsgdGhlIGV4cGxhbmF0aW9uIGlzIGFsc28gcmVhc29uYWJsZS4KPgo+SXQncyBub3QgdmVy
eSByZWFzb25hYmxlIGlmIHlvdSB0YWxrIHRvIEMgY29tcGlsZXIgYXV0aG9ycy4gIFRoZXkgY2Fu
IGRvCj5jcmF6eSB0aGluZ3Mgd2l0aCBkZXJlZmVyZW5jZWQgbWVtb3J5IGxvY2F0aW9ucywgaW5j
bHVkaW5nIG9wdGltaXppbmcKPnRoZW0gYXdheSBlbnRpcmVseSBhcyB0aGV5IG5vdyAia25vdyIg
dGhhdCB0aGlzIGRvZXMgbm90IHBvaW50IHRvIGFueQo+dmFsaWQgbWVtb3J5IHNvIGl0J3MgYW4g
dW5kZWZpbmVkIHRoaW5nIHRoYXQgdGhlIGNvbXBpbGVyIGlzIGJlaW5nIGFza2VkCj50byBkby4K
Pgo+PiBTbyB3aGVuIEkgbWFrZSB0aGlzIHBhdGNoLCBJIGFtIGluZGVlZCBjb25mdXNlZCB3aGF0
IEkgc2hvdWxkIHdyaXRlLgo+PiAKPj4gRmluYWxseSwgSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8g
YmUgY29uc2lzdGVudCB3aXRoIGN1cnJlbnQgY29kaW5nIHN0eWxlIHNvCj4+IEkgY2hvc2UgdGhp
cyAnY2hlY2stYWZ0ZXItcHV0JyBzdHlsZS4KPj4gCj4+IEJ1dCBpZiB5b3UgdGhpbmsgaXQgaXMg
YmV0dGVyIHRvIHVzZSBhIG5vcm1hbCBvcmRlciwgaS5lLiwgY2hlY2stdGhlbi1wdXQsCj4+IEkg
YW0sIG9mIGNhdXNlLCB2ZXJ5IGhhcHB5IHRvIHNlbmQgYSBuZXcgcGF0Y2ggZm9yIHRoaXMgYnVn
IGFuZCBJIHdpbGwKPj4gYWxzbyBrZWVwIHRvIHVzZSB0aGlzIGNvZGluZyBzdHlsZSBpbiBmdXR1
cmUuCj4KPmNoZWNrIGFuZCB0aGVuIHB1dCBwbGVhc2UuICBUaGF0IHByZXZlbnRzIHlvdSBmcm9t
IGhhdmluZyB0byBmaXggdXAgdGhpcwo+dHlwZSBvZiB0aGluZyBpbiBhIGZldyB5ZWFycyB3aGVu
IHRoZSBjb21waWxlcnMgYWxsIHN0YXJ0IHRvIGJsb3cgdXAgb24KPml0Lgo+Cj50aGFua3MsCj4K
PmdyZWcgay1oCgpPS6OsIEdyZWcgS0ijrAoKSSBhbSB2ZXJ5IGhhcHB5IHRvIGhlYXIgdGhpcyBh
bmQgSSB3aWxsIHNlbmQgJ2NoZWNrLWFuZC1wdXQnIHBhdGNoIHRvbW9ycm93LgoKVGhhbmtzIHZl
cnkgbXVjaC4KCkxpYW5nCg==
