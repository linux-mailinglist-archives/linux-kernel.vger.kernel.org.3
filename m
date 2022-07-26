Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF995808DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiGZA6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:58:53 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF052255BA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=aUJcO
        SgrP6VjZXkDhOlDqKQYGvO8kUGmx5Y3EFQVfZ8=; b=d2l7aSU1v/25jFnF/PSO0
        I5Ntq2cH2fyvSCb8X4dydxcLoPvxI7+Sq9pNaPPLkXjS3XgtldhWf6co9GVMRGad
        TQvkddPvKlQmtDne27wa6rO8dLaa7bC2YU5CFGBxUPf8IVfdZoyAOF//gqxST/Ih
        4gOtSdV1fkEwkH28TcNJrk=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Tue, 26 Jul 2022 08:58:13 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Tue, 26 Jul 2022 08:58:13 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>
Cc:     "Neil Armstrong" <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, inux-amlogic@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] soc: amlogic: meson-pwrc: Hold reference returned by
 of_get_parent()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <CAFBinCC1x-655H2LbbUhiVGmgXL+tdSRnCPV0a-NJcZKOFJZuw@mail.gmail.com>
References: <20220705022032.281665-1-windhl@126.com>
 <CAFBinCC1x-655H2LbbUhiVGmgXL+tdSRnCPV0a-NJcZKOFJZuw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <48085de5.7dd.1823802f2c1.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowACXpiYmPN9ig19OAA--.39639W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBxJF2JVkiE4RgABsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMDctMjYgMDM6NDY6MzAsICJNYXJ0aW4gQmx1bWVuc3RpbmdsIiA8bWFydGluLmJs
dW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4gd3JvdGU6Cj5IZWxsbywKPgo+dGhhbmsgeW91IGZv
ciB5b3VyIHBhdGNoIQo+Cj5PbiBUdWUsIEp1bCA1LCAyMDIyIGF0IDQ6MjAgQU0gTGlhbmcgSGUg
PHdpbmRobEAxMjYuY29tPiB3cm90ZToKPlsuLi5dCj4+ICsgICAgICAgc3RydWN0IGRldmljZV9u
b2RlICpucDsKPj4KPj4gICAgICAgICBpbnQgaSwgcmV0Owo+Pgo+PiAgICAgICAgIG1hdGNoID0g
b2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOwo+PiBAQCAtNDk1LDcgKzQ5Niw5
IEBAIHN0YXRpYyBpbnQgbWVzb25fZWVfcHdyY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQo+Pgo+PiAgICAgICAgIHB3cmMtPnhsYXRlLm51bV9kb21haW5zID0gbWF0Y2gtPmNv
dW50Owo+Pgo+PiAtICAgICAgIHJlZ21hcF9oaGkgPSBzeXNjb25fbm9kZV90b19yZWdtYXAob2Zf
Z2V0X3BhcmVudChwZGV2LT5kZXYub2Zfbm9kZSkpOwo+PiArICAgICAgIG5wID0gb2ZfZ2V0X3Bh
cmVudChwZGV2LT5kZXYub2Zfbm9kZSk7Cj4+ICsgICAgICAgcmVnbWFwX2hoaSA9IHN5c2Nvbl9u
b2RlX3RvX3JlZ21hcChucCk7Cj5UaGlzIHdvcmtzIGJ1dCBJIGhhZCB0byByZWFkIHRoZSBjb2Rl
IHR3aWNlIGJlY2F1c2UgSSB0aG91Z2h0IHRoZQo+d3Jvbmcgc3RydWN0IGRldmljZV9ub2RlIHdh
cyB1c2VkLgo+T3RoZXIgZHJpdmVycyB0eXBpY2FsbHkgdXNlICJucCIgZm9yIHdoYXRldmVyIHRo
ZSBjb2RlIHNlY3Rpb24KPmN1cnJlbnRseSByZWZlcnMgdG8uIEluIHRoaXMgY2FzZSB0aGUgY29k
ZSBzZWN0aW9uIGlzIGFib3V0IHRoZSBwb3dlcgo+Y29udHJvbGxlciwgc28gSSB0aG91Z2h0IHRo
YXQgIm5wIiB3YXMgdGhlIHNhbWUgYXMKPiJwZGV2LT5kZXYub2Zfbm9kZSIuCj4KPkkgdGhpbmsg
dGhlIGNvZGUgd291bGQgYmUgZWFzaWVyIHRvIHVuZGVyc3RhbmQgYW5kIHRoZSBsaWtlbGlob29k
IG9mCj5zb21lb25lIG1ha2luZyB0aGUgc2FtZSBtaXN0YWtlIGFzIEkgZGlkIGlmIHlvdSBjb3Vs
ZCByZW5hbWUgIm5wIiB0bwo+InBhcmVudF9ucCIgKGp1c3QgbGlrZSB5b3UgaGF2ZSBkb25lIGlu
IHlvdXIgb3RoZXIgcGF0Y2hlcykuCj4KPlsuLi5dCj4+ICsgICAgICAgc3RydWN0IGRldmljZV9u
b2RlICpucDsKPnNhbWUgYXMgYWJvdmUsIEkgc3VnZ2VzdCByZW5hbWluZyB0aGlzIHRvIHBhcmVu
dF9ucC4KClRoYW5rcywgSSB3aWxsIHNlbmQgYSBuZXcgdmVyaXNvbiBzb29uLgoKTGlhbmcK
