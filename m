Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894D6558D40
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiFXCf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiFXCf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:35:57 -0400
X-Greylist: delayed 915 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Jun 2022 19:35:55 PDT
Received: from m13111.mail.163.com (m13111.mail.163.com [220.181.13.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7345C51E5A;
        Thu, 23 Jun 2022 19:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=o9J+p
        ZBtqnGDTrCmXSeP0lYYcW0DNpeCNkrGVu9xKKU=; b=g+1HTF+ArET0P9cR1mxhO
        278o4PURNhDsGVAzQin9LWQ7pzvJAf07oSizb/Yff9+lddaQiB3itkx/eDYAqWGP
        Fg1pilxJvAkzEt+doA0L0EfeoZJdVbVbLHoviWEhmafl6X+5VWOIneyUoTGsj7Xc
        M1RnthJFTpD5r3XMLqzCMY=
Received: from 15815827059$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr111 (Coremail) ; Fri, 24 Jun 2022 10:20:29 +0800 (CST)
X-Originating-IP: [116.128.244.169]
Date:   Fri, 24 Jun 2022 10:20:29 +0800 (CST)
From:   huhai <15815827059@163.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Len Brown" <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        huhai <huhai@kylinos.cn>
Subject: Re:Re: [PATCH] ACPI: LPSS: Fix missing check in
 register_device_clock
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <CAJZ5v0jC+B7K0uuE=wLi1hk+WATn5B8sSu6abSO00rYJ4ofRFw@mail.gmail.com>
References: <20220623132127.1248462-1-15815827059@163.com>
 <CAJZ5v0jC+B7K0uuE=wLi1hk+WATn5B8sSu6abSO00rYJ4ofRFw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <18367cc4.16aa.1819382c273.Coremail.15815827059@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: b8GowACnr9ttH7VicrIgAA--.27406W
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/1tbiwAcqhVXlvsh9FAABsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMDYtMjMgMjE6MjU6NTUsICJSYWZhZWwgSi4gV3lzb2NraSIgPHJhZmFlbEBrZXJu
ZWwub3JnPiB3cm90ZToKPk9uIFRodSwgSnVuIDIzLCAyMDIyIGF0IDM6MjEgUE0gaHVoYWkgPDE1
ODE1ODI3MDU5QDE2My5jb20+IHdyb3RlOgo+Pgo+PiBGcm9tOiBodWhhaSA8aHVoYWlAa3lsaW5v
cy5jbj4KPj4KPj4gcmVnaXN0ZXJfZGV2aWNlX2Nsb2NrKCkgbWlzc2VzIGEgY2hlY2sgZm9yIHBs
YXRmb3JtX2RldmljZV9yZWdpc3Rlcl9zaW1wbGUoKS4KPj4gQWRkIGEgY2hlY2sgdG8gZml4IGl0
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBodWhhaSA8aHVoYWlAa3lsaW5vcy5jbj4KPj4gLS0tCj4+
ICBkcml2ZXJzL2FjcGkvYWNwaV9scHNzLmMgfCAzICsrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfbHBzcy5j
IGIvZHJpdmVycy9hY3BpL2FjcGlfbHBzcy5jCj4+IGluZGV4IGZiZTA3NTYyNTljNS4uYzRkNGQy
MTM5MWQ3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2FjcGkvYWNwaV9scHNzLmMKPj4gKysrIGIv
ZHJpdmVycy9hY3BpL2FjcGlfbHBzcy5jCj4+IEBAIC00MjIsNiArNDIyLDkgQEAgc3RhdGljIGlu
dCByZWdpc3Rlcl9kZXZpY2VfY2xvY2soc3RydWN0IGFjcGlfZGV2aWNlICphZGV2LAo+PiAgICAg
ICAgIGlmICghbHBzc19jbGtfZGV2KQo+PiAgICAgICAgICAgICAgICAgbHB0X3JlZ2lzdGVyX2Ns
b2NrX2RldmljZSgpOwo+Pgo+PiArICAgICAgIGlmIChJU19FUlIobHBzc19jbGtfZGV2KSkKPj4g
KyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGxwc3NfY2xrX2Rldik7Cj4+ICsKPgo+V2h5
IG5vdCB1c2UgSVNfRVJSX09SX05VTEwoKSBpbnN0ZWFkPwoKcGxhdGZvcm1fZGV2aWNlX3JlZ2lz
dGVyX3NpbXBsZSgpIG5ldmVyIHJldHVybnMgTlVMTCBhcyBpdCBkZWNsYXJlZCBiZWxsb3dpbmej
rApzbyB1c2UgSVNfRVJSKCkgdG8gdmFsaWRhdGUgdGhlIHJldHVybiB2YWx1ZSBzaG91bGQgYmUg
ZW5vdWdoLgoKLyoqCiAqIHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9zaW1wbGUgLSBhZGQgYSBw
bGF0Zm9ybS1sZXZlbCBkZXZpY2UgYW5kIGl0cyByZXNvdXJjZXMKICogLi4uCiAqIFJldHVybnMg
JnN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgcG9pbnRlciBvbiBzdWNjZXNzLCBvciBFUlJfUFRSKCkg
b24gZXJyb3IuCiAqLwoKVGhhbmtzLgoKPgo+PiAgICAgICAgIGNsa19kYXRhID0gcGxhdGZvcm1f
Z2V0X2RydmRhdGEobHBzc19jbGtfZGV2KTsKPj4gICAgICAgICBpZiAoIWNsa19kYXRhKQo+PiAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7Cj4+IC0tCj4+IDIuMjcuMAo+Pgo+Pgo+PiBO
byB2aXJ1cyBmb3VuZAo+PiAgICAgICAgICAgICAgICAgQ2hlY2tlZCBieSBIaWxsc3RvbmUgTmV0
d29yayBBbnRpVmlydXMKPj4K
