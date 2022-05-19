Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2F52DAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiESRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbiESRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:10:15 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B59AC9C2EA;
        Thu, 19 May 2022 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=ezFqmnyejiUIENx6HLdVfUcU6CF79HiNQ3RD
        +QDjpNs=; b=hBgePD48RofuFZGgwgFH67A/lQkKIbiSFWYxhNY+PXCIDMFLKsVa
        ljUYLseqrknBnhlgiEFIQcMS5n0uIiXZ1ACi1HQbOXuTiS2G3zFgx/WARCEXMN66
        lU/PXNFf27bVF+gZBaIiOQPtHYcIyjfhkbFzD8Hf+Lx6pj/sFYKa8Fw=
Received: by ajax-webmail-front01 (Coremail) ; Fri, 20 May 2022 01:10:01
 +0800 (GMT+08:00)
X-Originating-IP: [10.129.37.75]
Date:   Fri, 20 May 2022 01:10:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY5rC45b+X?= <lyz_cs@pku.edu.cn>
To:     "greg kh" <gregkh@linuxfoundation.org>
Cc:     pawell@cadence.com, peter.chen@nxp.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn
Subject: Re: Re: [PATCH] usb: cdnsp:  Fix potential dereference of NULL
 pointer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-1ea67e80-64e4-49d5-bd9f-3beeae24b9f2-pku.edu.cn
In-Reply-To: <YoZpKzT6txHJoAxP@kroah.com>
References: <1652891743-110930-1-git-send-email-lyz_cs@pku.edu.cn>
 <YoZpKzT6txHJoAxP@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1f0d2a84.29f34.180dd4c3680.Coremail.lyz_cs@pku.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 5oFpogBnYuXpeYZiAaiEBw--.42304W
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwELBlPy7vKNHQABsj
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiR3JlZyBLSCIgPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPgo+IFNlbnQgVGltZTogMjAyMi0wNS0xOSAyMzo1ODozNSAoVGh1
cnNkYXkpCj4gVG86ICJZb25nemhpIExpdSIgPGx5el9jc0Bwa3UuZWR1LmNuPgo+IENjOiBwYXdl
bGxAY2FkZW5jZS5jb20sIHBldGVyLmNoZW5AbnhwLmNvbSwgbGludXgtdXNiQHZnZXIua2VybmVs
Lm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgZnV5cUBzdHUucGt1LmVkdS5jbgo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogY2Ruc3A6ICBGaXggcG90ZW50aWFsIGRlcmVmZXJl
bmNlIG9mIE5VTEwgcG9pbnRlcgo+IAo+IE9uIFdlZCwgTWF5IDE4LCAyMDIyIGF0IDA5OjM1OjQz
QU0gLTA3MDAsIFlvbmd6aGkgTGl1IHdyb3RlOgo+ID4gVGhlIHJldHVybiB2YWx1ZSBvZiBjZG5z
cF9nZXRfdHJhbnNmZXJfcmluZygpCj4gPiBuZWVkcyB0byBiZSBjaGVja2VkIHRvIGF2b2lkIHVz
ZSBvZiBOVUxMIHBvaW50ZXIKPiA+IGluIGNhc2Ugb2YgYW4gYWNxdWlzaXRpb24gZmFpbHVyZS4K
PiAKPiBQbGVhc2UgdXNlIHRoZSBmdWxsIDcyIGNvbHVtbnMKPiAKPiA+IAo+ID4gRml4ZXM6IDNk
ODI5MDQ1NSAoInVzYjogY2Ruc3A6IGNkbnMzIEFkZCBtYWluIHBhcnQgb2YgQ2FkZW5jZSBVU0JT
U1AgRFJEIERyaXZlciIpCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmd6aGkgTGl1IDxseXpf
Y3NAcGt1LmVkdS5jbj4KPiAKPiBQbGVhc2UgZG8gbm90IHB1dCBhIGJsYW5rIGxpbmUgYmV0d2Vl
biAiRml4ZXM6IiBhbmQgeW91ciBzaWduZWQgb2ZmIGJ5Cj4gbGluZS4KPiAKPiA+IC0tLQo+ID4g
IGRyaXZlcnMvdXNiL2NkbnMzL2NkbnNwLXJpbmcuYyB8IDIgKysKPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5z
My9jZG5zcC1yaW5nLmMgYi9kcml2ZXJzL3VzYi9jZG5zMy9jZG5zcC1yaW5nLmMKPiA+IGluZGV4
IDFiMTQzODQuLjlmMjA2YjkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9jZG5zMy9jZG5z
cC1yaW5nLmMKPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NkbnNwLXJpbmcuYwo+ID4gQEAg
LTY1NSw2ICs2NTUsOCBAQCBzdGF0aWMgaW50IGNkbnNwX2NtZF9zZXRfZGVxKHN0cnVjdCBjZG5z
cF9kZXZpY2UgKnBkZXYsCj4gPiAgCSAqIHRvIHJlZmxlY3QgdGhlIG5ldyBwb3NpdGlvbi4KPiA+
ICAJICovCj4gPiAgCWVwX3JpbmcgPSBjZG5zcF9nZXRfdHJhbnNmZXJfcmluZyhwZGV2LCBwZXAs
IGRlcV9zdGF0ZS0+c3RyZWFtX2lkKTsKPiA+ICsJaWYgKCFlcF9yaW5nKQo+ID4gKwkJcmV0dXJu
IC1FSU5WQUw7Cj4gCj4gSG93IGRpZCB5b3UgdGVzdCB0aGlzPwo+IAo+IERvbid0IHlvdSBuZWVk
IHRvIHByb3Blcmx5IGNsZWFuIHVwIGFuZCBoYW5kbGUgdGhlIGhhcmR3YXJlIGlzc3VlcyBpZgo+
IHlvdSBleGl0IGVhcmx5IGhlcmU/CgpJIGZpbmQgdGhpcyBieSBhIHN0YXRpYyBhbmFseXplciBi
YXNlZCBvbiBmcmVxdWVuY3kgYW5kIHNpbWlsYXJpdHksIHdoaWNoIHJlcG9ydCBtYW55IG51bGwg
cHRyIGRlcmVmIGJ1Z3MuCkluIGNkbnMzL2NkbnNwLXJpbmcuYywgSSBmaW5kIHRoYXQgd2UgdXN1
YWxseSBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIHdoZW4gY2FsbCBmdW5jdGlvbiAndXNiX2dldF9p
bnRmZGF0YScuCklmICdkZXFfc3RhdGUtPnN0cmVhbV9pZCcgaXMgc3BlY2lhbCwgdGhlICdlcF9y
aW5nJyBpcyBhbHNvIG51bGwuIFRoZXJlZm9yZSwgaSB0aGluayB3ZSBzaG91bGQgYWRkIG51bGwg
Y2hlY2tzIGhlcmUuCkkgd2lsbCByZXN1Ym1pdCBhIG5ldyBwYXRjaCBpZiB5b3UgdGhpbmsgdGhl
IGJ1ZyBpcyByZWFsLgpUaGFua3MgZm9yIHlvdXIgcmVwbHkgYW5kIGFkdmljZS4KCj4gCj4gV2l0
aG91dCBnb29kIHRlc3RpbmcsIEkgYW0gbG9hdGggdG8gdGFrZSB0aGlzLgo+IAo+IHRoYW5rcywK
PiAKPiBncmVnIGstaAo=
