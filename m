Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E614EB1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiC2QnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239748AbiC2QnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:43:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6F2498B5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:41:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZEuB-0005gu-6Z; Tue, 29 Mar 2022 18:41:15 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZEu5-003pAm-UL; Tue, 29 Mar 2022 18:41:12 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZEu7-000Ak7-W4; Tue, 29 Mar 2022 18:41:12 +0200
Message-ID: <f8babd522487dd8e9955019a4141ce78ffca2087.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: imx-ldb: Check for null pointer after calling
 kmemdup
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 29 Mar 2022 18:41:11 +0200
In-Reply-To: <20220105074729.2363657-1-jiasheng@iscas.ac.cn>
References: <20220105074729.2363657-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWksIDIwMjItMDEtMDUgYXQgMTU6NDcgKzA4MDAsIEppYXNoZW5nIEppYW5nIHdyb3RlOgo+
IEFzIHRoZSBwb3NzaWJsZSBmYWlsdXJlIG9mIHRoZSBhbGxvY2F0aW9uLCBrbWVtZHVwKCkgbWF5
IHJldHVybiBOVUxMCj4gcG9pbnRlci4KPiBUaGVyZWZvcmUsIGl0IHNob3VsZCBiZSBiZXR0ZXIg
dG8gY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBvZiBrbWVtZHVwKCkKPiBhbmQgcmV0dXJuIGVycm9y
IGlmIGZhaWxzLgo+IAo+IEZpeGVzOiBkYzgwZDcwMzg4ODMgKCJkcm0vaW14LWxkYjogQWRkIHN1
cHBvcnQgdG8gZHJtLWJyaWRnZSIpCj4gU2lnbmVkLW9mZi1ieTogSmlhc2hlbmcgSmlhbmcgPGpp
YXNoZW5nQGlzY2FzLmFjLmNuPgo+IC0tLQo+IMKgZHJpdmVycy9ncHUvZHJtL2lteC9pbXgtbGRi
LmMgfCAyICsrCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbXgvaW14LWxkYi5jIGIvZHJpdmVycy9ncHUvZHJtL2lt
eC9pbXgtCj4gbGRiLmMKPiBpbmRleCA1MzEzMmRkZjk1ODcuLmY5ODgwYTc3OTY3OCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW14L2lteC1sZGIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9pbXgvaW14LWxkYi5jCj4gQEAgLTU3NCw2ICs1NzQsOCBAQCBzdGF0aWMgaW50IGlteF9s
ZGJfcGFuZWxfZGRjKHN0cnVjdCBkZXZpY2UgKmRldiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGVkaWRwID0gb2ZfZ2V0X3Byb3BlcnR5KGNoaWxkLCAiZWRpZCIsICZlZGlkX2xl
bik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZWRpZHApIHsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjaGFubmVsLT5lZGlk
ID0ga21lbWR1cChlZGlkcCwgZWRpZF9sZW4sCj4gR0ZQX0tFUk5FTCk7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWNoYW5uZWwtPmVkaWQpCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIC1FTk9NRU07Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9
IGVsc2UgaWYgKCFjaGFubmVsLT5wYW5lbCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIGZhbGxiYWNrIHRvIGRpc3BsYXktdGltaW5ncyBub2Rl
ICovCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
ID0gb2ZfZ2V0X2RybV9kaXNwbGF5X21vZGUoY2hpbGQsCgpUaGFuayB5b3UsIGFwcGxpZWQgdG8g
aW14LWRybS9maXhlcy4KCnJlZ2FyZHMKUGhpbGlwcAo=

