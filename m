Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F8654EEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379372AbiFQBXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379241AbiFQBXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:23:07 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19FAE13F24
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Cq+ut
        oE+mzqgQ3KbNKOTWVc1zRuzyYEd9yXx+hs2Kq4=; b=QG88Z9PAD2tEhsPlrBTqn
        rzuMe8lMtyjZ5HwYh4darp5KrKjLIRcPcTP7f8hb+i1umKZUroSmY1wLL0zQ0fdT
        MKXe1Gh2cjVhqIFjDqKBujQqWFJosiO4KoEL3FUeRhbJoGDRxg/1OmOXqA24cLTn
        NrbmhP50tdn1v9z4nKYaOk=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Fri, 17 Jun 2022 09:22:52 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 17 Jun 2022 09:22:52 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>
Cc:     "Neil Armstrong" <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] soc: amlogic: Fix refcount leak in
 meson-secure-pwrc.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <CAFBinCB-WZmnMtvG1P=sWASQZCg9F9d-Hg0OzVNUsEutUFX0Cg@mail.gmail.com>
References: <20220616144915.3988071-1-windhl@126.com>
 <CAFBinCB-WZmnMtvG1P=sWASQZCg9F9d-Hg0OzVNUsEutUFX0Cg@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <12f4df52.f06.1816f417fcf.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADHHPFs16ti+Q44AA--.53959W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgYiF1-HZUGFPAADsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0xNyAwNDoxNzoxOSwgIk1hcnRpbiBCbHVtZW5zdGluZ2wiIDxtYXJ0aW4u
Ymx1bWVuc3RpbmdsQGdvb2dsZW1haWwuY29tPiB3cm90ZToKPkhlbGxvLAo+Cj5PbiBUaHUsIEp1
biAxNiwgMjAyMiBhdCA0OjUwIFBNIExpYW5nIEhlIDx3aW5kaGxAMTI2LmNvbT4gd3JvdGU6Cj4+
Cj4+IEluIG1lc29uX3NlY3VyZV9wd3JjX3Byb2JlKCksIHRoZXJlIGlzIGEgcmVmY291bnQgbGVh
ayBpbiBvbmUgZmFpbAo+PiBwYXRoLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBIZSA8d2lu
ZGhsQDEyNi5jb20+Cj5BY2tlZC1ieTogTWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJsdW1l
bnN0aW5nbEBnb29nbGVtYWlsLmNvbT4KPgo+Wy4uLl0KPj4gICAgICAgICBwd3JjID0gZGV2bV9r
emFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqcHdyYyksIEdGUF9LRVJORUwpOwo+PiAtICAgICAg
IGlmICghcHdyYykKPj4gKyAgICAgICBpZiAoIXB3cmMpIHsKPj4gKyAgICAgICAgICAgICAgIG9m
X25vZGVfcHV0KHNtX25wKTsKPj4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+PiAr
ICAgICAgIH0KPkFub3RoZXIgYXBwcm9hY2ggd291bGQgYmUgdG8ganVzdCBtb3ZlIGRldm1fa3ph
bGxvYygpIGEgZmV3IGxpbmVzCj5mdXJ0aGVyIHVwIChhYm92ZSBvZl9maW5kX2NvbXBhdGlibGVf
bm9kZSgpKS4KPlRoYXQgd291bGQgY2F0Y2ggc2ltaWxhciBpc3N1ZXMgaW4gZnV0dXJlIHdoZW4g
c29tZW9uZSB3YW50cyB0byBhZGQKPm1vcmUgY29kZSByaWdodCBhZnRlciBkZXZtX2t6YWxsb2Mo
KS4gVGhhdCBzYWlkLCBJIGRvbid0IHRoaW5rIHRoYXQKPnRoaXMgaXMgYSBsaWtlbHkgc2NlbmFy
aW8gc28gdGhlIHBhdGNoIGlzIGZpbmUgZm9yIG1lIGFzLWlzLgo+Cj5UaGFua3MgYSBsb3QgZm9y
IHN1Ym1pdHRpbmcgdGhpcyEKPgo+Cj5CZXN0IHJlZ2FyZHMsCj5NYXJ0aW4KClRoYW5rcyBmb3Ig
eW91ciBjb25maXJtLgoKTGlhbmcK
