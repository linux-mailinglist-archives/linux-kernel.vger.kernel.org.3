Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738F8530C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiEWIDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiEWIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:03:44 -0400
Received: from azure-sdnproxy-3.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4B28C2494F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:03:37 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 23 May 2022 16:03:32
 +0800 (GMT+08:00)
X-Originating-IP: [124.236.130.193]
Date:   Mon, 23 May 2022 16:03:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mwifiex: fix sleep in atomic context bugs caused by
 dev_coredumpv
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6d8c70c0.2b1f1.180eff156be.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDH3EDUP4tird6fAA--.15170W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgkTAVZdtZ1ANAAPsB
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

SGVsbG8sCgpPbiBNb24sIDIzIE1heSAyMDIyIDA4OjMxOjQ2ICswMjAwIEdyZWcgS0ggd3JvdGU6
Cgo+ID4gVGhlcmUgYXJlIHNsZWVwIGluIGF0b21pYyBjb250ZXh0IGJ1Z3Mgd2hlbiB1cGxvYWRp
bmcgZGV2aWNlIGR1bXAKPiA+IGRhdGEgaW4gbXdpZmlleC4gVGhlIHJvb3QgY2F1c2UgaXMgdGhh
dCBkZXZfY29yZWR1bXB2IGNvdWxkIG5vdAo+ID4gYmUgdXNlZCBpbiBhdG9taWMgY29udGV4dHMs
IGJlY2F1c2UgaXQgY2FsbHMgZGV2X3NldF9uYW1lIHdoaWNoCj4gPiBpbmNsdWRlIG9wZXJhdGlv
bnMgdGhhdCBtYXkgc2xlZXAuIFRoZSBjYWxsIHRyZWUgc2hvd3MgZXhlY3V0aW9uCj4gPiBwYXRo
cyB0aGF0IGNvdWxkIGxlYWQgdG8gYnVnczoKPiA+IAo+ID4gICAgKEludGVycnVwdCBjb250ZXh0
KQo+ID4gZndfZHVtcF90aW1lcl9mbgo+ID4gICBtd2lmaWV4X3VwbG9hZF9kZXZpY2VfZHVtcAo+
ID4gICAgIGRldl9jb3JlZHVtcHYoLi4uLCBHRlBfS0VSTkVMKQo+ID4gICAgICAgZGV2X2NvcmVk
dW1wbSgpCj4gPiAgICAgICAgIGt6YWxsb2Moc2l6ZW9mKCpkZXZjZCksIGdmcCk7IC8vbWF5IHNs
ZWVwCj4gPiAgICAgICAgIGRldl9zZXRfbmFtZQo+ID4gICAgICAgICAgIGtvYmplY3Rfc2V0X25h
bWVfdmFyZ3MKPiA+ICAgICAgICAgICAgIGt2YXNwcmludGZfY29uc3QoR0ZQX0tFUk5FTCwgLi4u
KTsgLy9tYXkgc2xlZXAKPiA+ICAgICAgICAgICAgIGtzdHJkdXAocywgR0ZQX0tFUk5FTCk7IC8v
bWF5IHNsZWVwCj4gPiAKPiA+IEluIG9yZGVyIHRvIGxldCBkZXZfY29yZWR1bXB2IHN1cHBvcnQg
YXRvbWljIGNvbnRleHRzLCB0aGlzIHBhdGNoCj4gPiBjaGFuZ2VzIHRoZSBnZnBfdCBwYXJhbWV0
ZXIgb2Yga3Zhc3ByaW50Zl9jb25zdCBhbmQga3N0cmR1cCBpbgo+ID4ga29iamVjdF9zZXRfbmFt
ZV92YXJncyBmcm9tIEdGUF9LRVJORUwgdG8gR0ZQX0FUT01JQy4gV2hhdCdzIG1vcmUsCj4gPiBJ
biBvcmRlciB0byBtaXRpZ2F0ZSBidWcsIHRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgZ2ZwX3QgcGFy
YW1ldGVyCj4gPiBvZiBkZXZfY29yZWR1bXB2IGZyb20gR0ZQX0tFUk5FTCB0byBHRlBfQVRPTUlD
Lgo+ID4gCj4gPiBGaXhlczogNTc2NzBlZTg4MmQ0ICgibXdpZmlleDogZGV2aWNlIGR1bXAgc3Vw
cG9ydCB2aWEgZGV2Y29yZWR1bXAgZnJhbWV3b3JrIikKPiA+IFNpZ25lZC1vZmYtYnk6IER1b21p
bmcgWmhvdSA8ZHVvbWluZ0B6anUuZWR1LmNuPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIHYzOgo+
ID4gICAtIExldCBkZXZfY29yZWR1bXB2IHN1cHBvcnQgYXRvbWljIGNvbnRleHRzLgo+ID4gCj4g
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4uYyB8IDIgKy0KPiA+
ICBsaWIva29iamVjdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNCArKy0tCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gPiAK
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvbWFp
bi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4uYwo+ID4gaW5k
ZXggYWNlNzM3MWM0NzcuLjI1ODkwNjkyMGEyIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4uYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4uYwo+ID4gQEAgLTExMTYsNyArMTExNiw3IEBAIHZv
aWQgbXdpZmlleF91cGxvYWRfZGV2aWNlX2R1bXAoc3RydWN0IG13aWZpZXhfYWRhcHRlciAqYWRh
cHRlcikKPiA+ICAJbXdpZmlleF9kYmcoYWRhcHRlciwgTVNHLAo+ID4gIAkJICAgICI9PSBtd2lm
aWV4IGR1bXAgaW5mb3JtYXRpb24gdG8gL3N5cy9jbGFzcy9kZXZjb3JlZHVtcCBzdGFydFxuIik7
Cj4gPiAgCWRldl9jb3JlZHVtcHYoYWRhcHRlci0+ZGV2LCBhZGFwdGVyLT5kZXZkdW1wX2RhdGEs
IGFkYXB0ZXItPmRldmR1bXBfbGVuLAo+ID4gLQkJICAgICAgR0ZQX0tFUk5FTCk7Cj4gPiArCQkg
ICAgICBHRlBfQVRPTUlDKTsKPiA+ICAJbXdpZmlleF9kYmcoYWRhcHRlciwgTVNHLAo+ID4gIAkJ
ICAgICI9PSBtd2lmaWV4IGR1bXAgaW5mb3JtYXRpb24gdG8gL3N5cy9jbGFzcy9kZXZjb3JlZHVt
cCBlbmRcbiIpOwo+ID4gIAo+ID4gZGlmZiAtLWdpdCBhL2xpYi9rb2JqZWN0LmMgYi9saWIva29i
amVjdC5jCj4gPiBpbmRleCA1ZjBlNzFhYjI5Mi4uNzY3MmM1NDk0NGMgMTAwNjQ0Cj4gPiAtLS0g
YS9saWIva29iamVjdC5jCj4gPiArKysgYi9saWIva29iamVjdC5jCj4gPiBAQCAtMjU0LDcgKzI1
NCw3IEBAIGludCBrb2JqZWN0X3NldF9uYW1lX3ZhcmdzKHN0cnVjdCBrb2JqZWN0ICprb2JqLCBj
b25zdCBjaGFyICpmbXQsCj4gPiAgCWlmIChrb2JqLT5uYW1lICYmICFmbXQpCj4gPiAgCQlyZXR1
cm4gMDsKPiA+ICAKPiA+IC0JcyA9IGt2YXNwcmludGZfY29uc3QoR0ZQX0tFUk5FTCwgZm10LCB2
YXJncyk7Cj4gPiArCXMgPSBrdmFzcHJpbnRmX2NvbnN0KEdGUF9BVE9NSUMsIGZtdCwgdmFyZ3Mp
Owo+ID4gIAlpZiAoIXMpCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsKPiA+ICAKPiA+IEBAIC0yNjcs
NyArMjY3LDcgQEAgaW50IGtvYmplY3Rfc2V0X25hbWVfdmFyZ3Moc3RydWN0IGtvYmplY3QgKmtv
YmosIGNvbnN0IGNoYXIgKmZtdCwKPiA+ICAJaWYgKHN0cmNocihzLCAnLycpKSB7Cj4gPiAgCQlj
aGFyICp0Owo+ID4gIAo+ID4gLQkJdCA9IGtzdHJkdXAocywgR0ZQX0tFUk5FTCk7Cj4gPiArCQl0
ID0ga3N0cmR1cChzLCBHRlBfQVRPTUlDKTsKPiA+ICAJCWtmcmVlX2NvbnN0KHMpOwo+ID4gIAkJ
aWYgKCF0KQo+ID4gIAkJCXJldHVybiAtRU5PTUVNOwo+IAo+IFBsZWFzZSBubywgeW91IGFyZSBo
dXJ0aW5nIHRoZSB3aG9sZSBrZXJuZWwgYmVjYXVzZSBvZiBvbmUgb2RkIHVzZXIuCj4gUGxlYXNl
IGRvIG5vdCBtYWtlIHRoZXNlIGNhbGxzIHVuZGVyIGF0b21pYyBjb250ZXh0LgoKVGhhbmtzIGZv
ciB5b3VyIHRpbWUgYW5kIHN1Z2dlc3Rpb25zLiBJIHdpbGwgcmVtb3ZlIHRoZSBnZnBfdCBwYXJh
bWV0ZXIgb2YgZGV2X2NvcmVkdW1wdgppbiBvcmRlciB0byBzaG93IGl0IGNvdWxkIG5vdCBiZSB1
c2VkIGluIGF0b21pYyBjb250ZXh0LgoKQmVzdCBSZWdhcmRzLApEdW9taW5nIFpob3U=
