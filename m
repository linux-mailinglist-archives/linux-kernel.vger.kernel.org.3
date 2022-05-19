Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F552DA5D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbiESQgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbiESQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:36:02 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 11D402CC86
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=fF518Hc8uEuEf9r8ke5GEOjm5Z2WXlFO1tYv
        q8jSjcQ=; b=PFvkBAqPoDxwCJmm6z1Khpz/B48C4ZkPVwCay8bZY1DVKyOxzMf0
        UcZ9z7NYGvgVFQ28k4u2iIeQLOd6y84/G0ZzybxzcUPyCJPgdezQ3kirvK7Sm4DS
        p9a5eKaFhWxY6CvEONL5sSVGzH0cf2lCvsfUJEpXQtRYIUtkca6jS6M=
Received: by ajax-webmail-front02 (Coremail) ; Fri, 20 May 2022 00:35:35
 +0800 (GMT+08:00)
X-Originating-IP: [10.129.37.75]
Date:   Fri, 20 May 2022 00:35:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY5rC45b+X?= <lyz_cs@pku.edu.cn>
To:     "kalle valo" <kvalo@kernel.org>
Cc:     amitkarwar@gmail.com, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, arend.vanspriel@broadcom.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: vadc: Fix potential dereference of NULL pointer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-1ea67e80-64e4-49d5-bd9f-3beeae24b9f2-pku.edu.cn
In-Reply-To: <87v8u11qvo.fsf@kernel.org>
References: <1652957674-127802-1-git-send-email-lyz_cs@pku.edu.cn>
 <87v8u11qvo.fsf@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7e12c127.2a22e.180dd2cb2a3.Coremail.lyz_cs@pku.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 54FpogBXJOTXcYZifHmeBg--.18762W
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwELBlPy7vKMbgAAsQ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiS2FsbGUgVmFsbyIgPGt2
YWxvQGtlcm5lbC5vcmc+Cj4gU2VudCBUaW1lOiAyMDIyLTA1LTE5IDIzOjMwOjUxIChUaHVyc2Rh
eSkKPiBUbzogIllvbmd6aGkgTGl1IiA8bHl6X2NzQHBrdS5lZHUuY24+Cj4gQ2M6IGFtaXRrYXJ3
YXJAZ21haWwuY29tLCBnYW5hcGF0aGkwMTdAZ21haWwuY29tLCBzaGFydmFyaS5oYXJpc2FuZ2Ft
QG54cC5jb20sIGh1eGlubWluZzgyMEBnbWFpbC5jb20sIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVk
dW1hemV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcGFiZW5pQHJlZGhhdC5jb20sIGFy
ZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20sIGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9y
ZywgbmV0ZGV2QHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywg
ZnV5cUBzdHUucGt1LmVkdS5jbgo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGlpbzogdmFkYzog
Rml4IHBvdGVudGlhbCBkZXJlZmVyZW5jZSBvZiBOVUxMIHBvaW50ZXIKPiAKPiBZb25nemhpIExp
dSA8bHl6X2NzQHBrdS5lZHUuY24+IHdyaXRlczoKPiAKPiA+IFRoZSByZXR1cm4gdmFsdWUgb2Yg
dmFkY19nZXRfY2hhbm5lbCgpIG5lZWRzIHRvIGJlIGNoZWNrZWQKPiA+IHRvIGF2b2lkIHVzZSBv
ZiBOVUxMIHBvaW50ZXIuIEZpeCB0aGlzIGJ5IGFkZGluZyB0aGUgbnVsbAo+ID4gcG9pbnRlciBj
aGVjayBvbiBwcm9wLgo+ID4KPiA+IEZpeGVzOiAwOTE3ZGU5NGMgKCJpaW86IHZhZGM6IFF1YWxj
b21tIFNQTUkgUE1JQyB2b2x0YWdlIEFEQyBkcml2ZXIiKQo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6
IFlvbmd6aGkgTGl1IDxseXpfY3NAcGt1LmVkdS5jbj4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvaWlv
L2FkYy9xY29tLXNwbWktdmFkYy5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKy0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAoKSSdtIHNv
cnJ5IHRvIHNlbmQgdGhpcyB0byBsaW51eC13aXJlbGVzcyBieSBtaXN0YWtlLiBJIHdpbGwgY2F1
dGlvdXNseSBzdWJtaXQgcGF0Y2hlcyBsYXRlci4KCj4gRGlkIHlvdSBzZW50IHRoaXMgdG8gbGlu
dXgtd2lyZWxlc3MgYnkgbWlzdGFrZT8KPiAKPiAtLSAKPiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvbGlzdC8KPiAKPiBodHRwczovL3dpcmVsZXNz
Lndpa2kua2VybmVsLm9yZy9lbi9kZXZlbG9wZXJzL2RvY3VtZW50YXRpb24vc3VibWl0dGluZ3Bh
dGNoZXMK
