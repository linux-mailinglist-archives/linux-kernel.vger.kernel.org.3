Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3855A888
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiFYJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiFYJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:21:28 -0400
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net (zg8tmtyylji0my4xnjqunzqa.icoremail.net [162.243.164.74])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 922C62F649
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:21:24 -0700 (PDT)
Received: by ajax-webmail-mail-app3 (Coremail) ; Sat, 25 Jun 2022 17:21:06
 +0800 (GMT+08:00)
X-Originating-IP: [221.192.178.113]
Date:   Sat, 25 Jun 2022 17:21:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, davem@davemloft.net,
        alexander.deucher@amd.com, kuba@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: Fix sleep in atomic context bug
 in dm_fsync_timer_callback
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <1ddff589.e0f1.181944e6c1a.Coremail.duoming@zju.edu.cn>
References: <20220623055912.84138-1-duoming@zju.edu.cn>
 <YrQ2gXtX2FOkyNgu@kroah.com>
 <1ddff589.e0f1.181944e6c1a.Coremail.duoming@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <482a0dc6.10f76.1819a2a3546.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgAny_CC07Zi68fcAA--.20158W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgQMAVZdtaZRqQABsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgo+ID4gT24gVGh1LCBKdW4gMjMsIDIwMjIgYXQgMDE6NTk6MTJQTSArMDgwMCwgRHVv
bWluZyBaaG91IHdyb3RlOgo+ID4gPiBUaGVyZSBhcmUgc2xlZXAgaW4gYXRvbWljIGNvbnRleHQg
YnVncyB3aGVuIGRtX2ZzeW5jX3RpbWVyX2NhbGxiYWNrIGlzCj4gPiA+IGV4ZWN1dGluZy4gVGhl
IHJvb3QgY2F1c2UgaXMgdGhhdCB0aGUgbWVtb3J5IGFsbG9jYXRpb24gZnVuY3Rpb25zIHdpdGgK
PiA+ID4gR0ZQX0tFUk5FTCBvciBHRlBfTk9JTyBwYXJhbWV0ZXJzIGFyZSBjYWxsZWQgaW4gZG1f
ZnN5bmNfdGltZXJfY2FsbGJhY2sKPiA+ID4gd2hpY2ggaXMgYSB0aW1lciBoYW5kbGVyLiBUaGUg
Y2FsbCBwYXRocyB0aGF0IGNvdWxkIHRyaWdnZXIgYnVncyBhcmUKPiA+ID4gc2hvd24gYmVsb3c6
Cj4gPiA+IAo+ID4gPiAgICAgKGludGVycnVwdCBjb250ZXh0KQo+ID4gPiBkbV9mc3luY190aW1l
cl9jYWxsYmFjawo+ID4gPiAgIHdyaXRlX25pY19ieXRlCj4gPiA+ICAgICBremFsbG9jKHNpemVv
ZihkYXRhKSwgR0ZQX0tFUk5FTCk7IC8vbWF5IHNsZWVwCj4gPiA+ICAgICB1c2JfY29udHJvbF9t
c2cKPiA+ID4gICAgICAga21hbGxvYyguLiwgR0ZQX05PSU8pOyAvL21heSBzbGVlcAo+ID4gPiAg
IHdyaXRlX25pY19kd29yZAo+ID4gPiAgICAga3phbGxvYyhzaXplb2YoZGF0YSksIEdGUF9LRVJO
RUwpOyAvL21heSBzbGVlcAo+ID4gPiAgICAgdXNiX2NvbnRyb2xfbXNnCj4gPiA+ICAgICAgIGtt
YWxsb2MoLi4sIEdGUF9OT0lPKTsgLy9tYXkgc2xlZXAKPiA+ID4gCj4gPiA+IFRoaXMgcGF0Y2gg
dXNlcyBkZWxheWVkIHdvcmsgdG8gcmVwbGFjZSB0aW1lciBhbmQgbW92ZXMgdGhlIG9wZXJhdGlv
bnMKPiA+ID4gdGhhdCBtYXkgc2xlZXAgaW50byB0aGUgZGVsYXllZCB3b3JrIGluIG9yZGVyIHRv
IG1pdGlnYXRlIGJ1Z3MuCj4gPiA+IAo+ID4gPiBGaXhlczogOGZjODU5OGU2MWY2ICgiU3RhZ2lu
ZzogQWRkZWQgUmVhbHRlayBydGw4MTkydSBkcml2ZXIgdG8gc3RhZ2luZyIpCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IER1b21pbmcgWmhvdSA8ZHVvbWluZ0B6anUuZWR1LmNuPgo+ID4gPiAtLS0KPiA+
ID4gQ2hhbmdlcyBpbiB2MjoKPiA+ID4gICAtIFVzZSBkZWxheWVkIHdvcmsgdG8gcmVwbGFjZSB0
aW1lci4KPiA+IAo+ID4gRGlkIHlvdSB0ZXN0IHRoaXMgd2l0aCByZWFsIGhhcmR3YXJlIHRvIHZl
cmlmeSBpdCBzdGlsbCB3b3Jrcz8KPiAKPiBJIGFtIHRlc3RpbmcgdGhpcyBhbmQgSSB3aWxsIGdp
dmUgeW91IGZlZWRiYWNrIHdpdGhpbiBvbmUgb3IgdHdvIGRheXMuCgpEbyB5b3Uga25vdyB3aGF0
IHZlbmRvciBpZCBhbmQgZGV2aWNlIGlkIHVzZSB0aGUgcjgxOTJ1X3VzYiBkcml2ZXI/CkkgdHJ5
IG1hbnkgaGFyZHdhcmVzLCB0aGV5IGNvdWxkIG5vdCB0cmlnZ2VyIHRoaXMgY29kZS4KClRoYW5r
IHlvdSEKCkJlc3QgcmVnYXJkcywKRHVvbWluZyBaaG91Cg==
