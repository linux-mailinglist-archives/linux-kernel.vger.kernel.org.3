Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3C52F816
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354462AbiEUDeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbiEUDee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:34:34 -0400
Received: from azure-sdnproxy-2.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E21BD65D3D;
        Fri, 20 May 2022 20:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=lvbwqAeVRRu13wXpsUlhvmu4YHPhWENn0qKV
        xRyax4Y=; b=Vb0wsHYRf6q/yARkC9PoZLAVGgWU991tfAUvijXf9SWV/y5qrqs9
        JxPj7cIscUH0/OkpA0CNnFK8+2x3szzOeRFHo8F6ZTuZD7Q4+87nqjw6EyyEBiEd
        trSzljyGGZdHcuzh/gX6KiaMI+2D8g2z80XGcO9JZFT534h0AZGoLvw=
Received: by ajax-webmail-front01 (Coremail) ; Sat, 21 May 2022 11:34:12
 +0800 (GMT+08:00)
X-Originating-IP: [10.129.37.75]
Date:   Sat, 21 May 2022 11:34:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY5rC45b+X?= <lyz_cs@pku.edu.cn>
To:     agross@kernel.org, bjorn.andersson@linaro.org, jic23@kernel.org,
        lars@metafoo.de, svarbanov@mm-sol.com, iivanov@mm-sol.com,
        jonathan.cameron@huawei.com
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv_netvsc: Fix potential dereference of NULL pointer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-1ea67e80-64e4-49d5-bd9f-3beeae24b9f2-pku.edu.cn
In-Reply-To: <1653103862-36104-1-git-send-email-lyz_cs@pku.edu.cn>
References: <20220520181323.00002892@huawei.com>
 <1653103862-36104-1-git-send-email-lyz_cs@pku.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <254e80a1.30e69.180e4ae082b.Coremail.lyz_cs@pku.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 5oFpogC33SW0XYhin9ulBw--.48328W
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEMBlPy7vKeCwAHsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpJJ20gc29ycnkgdG8gc2VuZCB0aGlzIHRvIGxpbnV4LWlpbyBieSBtaXN0YWtlLiBJIHdpbGwg
Y2F1dGlvdXNseSBzdWJtaXQgcGF0Y2hlcyBsYXRlci4KCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
cy0tLS0tCj4gRnJvbTogIllvbmd6aGkgTGl1IiA8bHl6X2NzQHBrdS5lZHUuY24+Cj4gU2VudCBU
aW1lOiAyMDIyLTA1LTIxIDExOjMxOjAyIChTYXR1cmRheSkKPiBUbzogYWdyb3NzQGtlcm5lbC5v
cmcsIGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnLCBqaWMyM0BrZXJuZWwub3JnLCBsYXJzQG1l
dGFmb28uZGUsIHN2YXJiYW5vdkBtbS1zb2wuY29tLCBpaXZhbm92QG1tLXNvbC5jb20sIGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbQo+IENjOiBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9y
ZywgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZywgZnV5cUBzdHUucGt1LmVkdS5jbiwgIllvbmd6aGkgTGl1IiA8bHl6X2NzQHBrdS5lZHUuY24+
Cj4gU3ViamVjdDogW1BBVENIXSBodl9uZXR2c2M6IEZpeCBwb3RlbnRpYWwgZGVyZWZlcmVuY2Ug
b2YgTlVMTCBwb2ludGVyCj4gCj4gVGhlIHJldHVybiB2YWx1ZSBvZiBuZXR2c2NfZGV2aW5mb19n
ZXQoKQo+IG5lZWRzIHRvIGJlIGNoZWNrZWQgdG8gYXZvaWQgdXNlIG9mIE5VTEwKPiBwb2ludGVy
IGluIGNhc2Ugb2YgYW4gYWxsb2NhdGlvbiBmYWlsdXJlLgo+IAo+IEZpeGVzOiAwZWZlZWE1ZmIg
KCJodl9uZXR2c2M6IEFkZCB0aGUgc3VwcG9ydCBvZiBoaWJlcm5hdGlvbiIpCj4gCj4gU2lnbmVk
LW9mZi1ieTogWW9uZ3poaSBMaXUgPGx5el9jc0Bwa3UuZWR1LmNuPgo+IC0tLQo+ICBkcml2ZXJz
L25ldC9oeXBlcnYvbmV0dnNjX2Rydi5jIHwgNSArKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2h5cGVydi9uZXR2c2NfZHJ2LmMgYi9kcml2ZXJzL25ldC9oeXBlcnYvbmV0dnNjX2Rydi5jCj4g
aW5kZXggZmRlMWM0OS4uYjFkZWNlNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC9oeXBlcnYv
bmV0dnNjX2Rydi5jCj4gKysrIGIvZHJpdmVycy9uZXQvaHlwZXJ2L25ldHZzY19kcnYuYwo+IEBA
IC0yNjcxLDcgKzI2NzEsMTAgQEAgc3RhdGljIGludCBuZXR2c2Nfc3VzcGVuZChzdHJ1Y3QgaHZf
ZGV2aWNlICpkZXYpCj4gIAo+ICAJLyogU2F2ZSB0aGUgY3VycmVudCBjb25maWcgaW5mbyAqLwo+
ICAJbmRldl9jdHgtPnNhdmVkX25ldHZzY19kZXZfaW5mbyA9IG5ldHZzY19kZXZpbmZvX2dldChu
dmRldik7Cj4gLQo+ICsJaWYgKCFuZGV2X2N0eC0+c2F2ZWRfbmV0dnNjX2Rldl9pbmZvKSB7Cj4g
KwkJcmV0ID0gLUVOT01FTTsKPiArCQlnb3RvIG91dDsKPiArCX0KPiAgCXJldCA9IG5ldHZzY19k
ZXRhY2gobmV0LCBudmRldik7Cj4gIG91dDoKPiAgCXJ0bmxfdW5sb2NrKCk7Cj4gLS0gCj4gMi43
LjQK
