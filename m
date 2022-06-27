Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1A55DF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiF0Ox6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbiF0OxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:53:02 -0400
Received: from m151.mail.126.com (m151.mail.126.com [220.181.15.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07763140FE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=lO5E1
        iVju2S4FFAAYHenXYqOGz9bc9aUBgCSHMh99PY=; b=OvutJ4gGnxODPgZb2jn13
        98rgBV+mscbe6Y+aNES7S1PFVKO8NDgfUGAm2q0pOa/zia0h0LCTupPFzagDo1KY
        pqHEaP/ssNlVV083CZB5snUGBC4QVDzpR6N+dbCkB1qRMmwlmjrsydUpzWPr+TJb
        cXt4evHZG4dTYDeuMACDuA=
Received: from windhl$126.com ( [123.112.70.164] ) by ajax-webmail-wmsvr1
 (Coremail) ; Mon, 27 Jun 2022 22:51:38 +0800 (CST)
X-Originating-IP: [123.112.70.164]
Date:   Mon, 27 Jun 2022 22:51:38 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     broonie@kernel.org, ckeepax@opensource.cirrus.com,
        michal.simek@xilinx.com, abhyuday.godhasara@xilinx.com,
        simont@opensource.cirrus.com, ronak.jain@xilinx.com,
        peng.fan@nxp.com, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] firmware: Hold a reference for
 of_find_compatible_node()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <Yrm6JztPuqYmKlKF@kroah.com>
References: <20220621032625.4078445-1-windhl@126.com>
 <Yrm6JztPuqYmKlKF@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <578840ee.438c.181a5a58c00.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AcqowABXWbH7w7li8cUcAA--.20186W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BstF1pED0GQJQAAsY
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTI3IDIyOjA5OjQzLCAiR3JlZyBLSCIgPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPiB3cm90ZToKPk9uIFR1ZSwgSnVuIDIxLCAyMDIyIGF0IDExOjI2OjI1QU0gKzA4MDAs
IExpYW5nIEhlIHdyb3RlOgo+PiBJbiBvZl9yZWdpc3Rlcl90cnVzdGVkX2ZvdW5kYXRpb25zKCks
IHdlIG5lZWQgdG8gaG9sZCB0aGUgcmVmZXJlbmNlCj4+IHJldHVybmVkIGJ5IG9mX2ZpbmRfY29t
cGF0aWJsZV9ub2RlKCkgYW5kIHRoZW4gdXNlIGl0IHRvIGNhbGwKPj4gb2Zfbm9kZV9wdXQoKSBm
b3IgcmVmY291bnQgYmFsYW5jZS4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5k
aGxAMTI2LmNvbT4KPj4gLS0tCj4+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3RydXN0ZWRfZm91
bmRhdGlvbnMuaCB8IDggKysrKysrLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maXJt
d2FyZS90cnVzdGVkX2ZvdW5kYXRpb25zLmggYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3RydXN0
ZWRfZm91bmRhdGlvbnMuaAo+PiBpbmRleCBiZTU5ODRiZGE1OTIuLjM5OTQ3MWMyZjFjNyAxMDA2
NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS90cnVzdGVkX2ZvdW5kYXRpb25zLmgK
Pj4gKysrIGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS90cnVzdGVkX2ZvdW5kYXRpb25zLmgKPj4g
QEAgLTcxLDEyICs3MSwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcmVnaXN0ZXJfdHJ1c3RlZF9m
b3VuZGF0aW9ucygKPj4gIAo+PiAgc3RhdGljIGlubGluZSB2b2lkIG9mX3JlZ2lzdGVyX3RydXN0
ZWRfZm91bmRhdGlvbnModm9pZCkKPj4gIHsKPj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0g
b2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgInRsbSx0cnVzdGVkLWZvdW5kYXRp
b25zIik7Cj4+ICsKPj4gKwlvZl9ub2RlX3B1dChucCk7Cj4+ICsJaWYgKCFucCkKPgo+V2hpbGUg
dGhpcyBpcyB0ZWNobmljYWxseSBjb3JyZWN0LCB5b3UgYXJlIG5vdyBjaGVja2luZyB0byBzZWUg
aWYgdGhpcwo+cG9pbnRzIHRvIGEgbWVtb3J5IGxvY2F0aW9uIHRoYXQgeW91IG5vIGxvbmdlciBr
bm93IHdoYXQgaXQgcmVhbGx5Cj5iZWxvbmdzIHRvLiAgQyB3aWxsIGxldCB5b3UgZG8gdGhpcywg
YnV0IGl0IG1pZ2h0IGJlIG5pY2VyIHRvIGZpeCBpdCB1cAo+cHJvcGVybHkgc28gaXQgZG9lc24n
dCBsb29rIGxpa2UgdGhpcy4KPgo+dGhhbmtzLAo+Cj5ncmVnIGstaAoKSGmjrEdyZWcgS0ijrAoK
VGhhbmtzIHZlcnkgbXVjaCBmb3IgeW91ciBlZmZvcnQgdG8gcmV2aWV3IG15IHBhdGNoLgoKSW4g
ZmFjdCwgSSBoYXZlIHJlcG9ydGVkIGEgY29tbWl0IGZvciB0aGlzIGtpbmQgb2YgJ2NoZWNrLWFm
dGVyLXB1dCcgY29kaW5nIHN0eWxlOgpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA2
MTcxMTI2MzYuNDA0MTY3MS0xLXdpbmRobEAxMjYuY29tLwoKQnV0IEkgaGF2ZSBiZWVuIHRvbGQg
dG8ga2VlcCBzdWNoIHN0eWxlIGFuZCBJIHRoaW5rIHRoZSBleHBsYW5hdGlvbiBpcyBhbHNvIHJl
YXNvbmFibGUuClNvIHdoZW4gSSBtYWtlIHRoaXMgcGF0Y2gsIEkgYW0gaW5kZWVkIGNvbmZ1c2Vk
IHdoYXQgSSBzaG91bGQgd3JpdGUuCgpGaW5hbGx5LCBJIHRoaW5rIGl0IGlzIGJldHRlciB0byBi
ZSBjb25zaXN0ZW50IHdpdGggY3VycmVudCBjb2Rpbmcgc3R5bGUgc28KSSBjaG9zZSB0aGlzICdj
aGVjay1hZnRlci1wdXQnIHN0eWxlLgoKQnV0IGlmIHlvdSB0aGluayBpdCBpcyBiZXR0ZXIgdG8g
dXNlIGEgbm9ybWFsIG9yZGVyLCBpLmUuLCBjaGVjay10aGVuLXB1dCwKSSBhbSwgb2YgY2F1c2Us
IHZlcnkgaGFwcHkgdG8gc2VuZCBhIG5ldyBwYXRjaCBmb3IgdGhpcyBidWcgYW5kIEkgd2lsbAph
bHNvIGtlZXAgdG8gdXNlIHRoaXMgY29kaW5nIHN0eWxlIGluIGZ1dHVyZS4KClRoYW5rcyBhZ2Fp
bi4KCkxpYW5nIAoK
