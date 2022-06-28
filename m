Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49D855C625
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbiF1FxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiF1FxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:53:07 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A6EEFF3;
        Mon, 27 Jun 2022 22:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=BzQjt
        GGE+XK5zIt6YFBt3VAbazb6iNZuycDB1eB0QlA=; b=nL7+0nLCjn4wIkPBWQtoE
        Nce376O50kX3NojsxsH8/H3YrzfOpUon5NrISdApic45n7LO9xeYGNqhn13KTB6m
        q+bZIVl9wz1fK8SWQ99fQ86WM4Se+toMXbJBrq8dw/YzjqAJEg5SqXv+E9aH48zC
        mqGNPPysCMZ+ro8WBcqTQM=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Tue, 28 Jun 2022 13:52:53 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Tue, 28 Jun 2022 13:52:53 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Tony Lindgren" <tony@atomide.com>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] arm: mach-omap2: omap4-common: Fix refcount leak bug
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <YrqF2bXbxcYFsUy6@atomide.com>
References: <20220617035548.4003393-1-windhl@126.com>
 <YrqF2bXbxcYFsUy6@atomide.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <39ad3f64.3de2.181a8dea7a0.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADHHPE1l7piefI+AA--.21879W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BIuF1pED0WRtAAEsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0yOCAxMjozODo0OSwgIlRvbnkgTGluZGdyZW4iIDx0b255QGF0b21pZGUu
Y29tPiB3cm90ZToKPiogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPiBbMjIwNjE3IDA2OjUxXToK
Pj4gSW4gb21hcDRfc3JhbV9pbml0KCksIG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKCkgd2lsbCBy
ZXR1cm4gYSBub2RlCj4+IHBvaW50ZXIgd2l0aCByZWZjb3VudCBpbmNyZW1lbnRlZC4gV2Ugc2hv
dWxkIHVzZSBvZl9ub2RlX3B1dCgpIHdoZW4KPj4gaXQgaXMgbm90IHVzZWQgYW55bW9yZS4KPj4g
Cj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5kaGxAMTI2LmNvbT4KPj4gLS0tCj4+ICBh
cmNoL2FybS9tYWNoLW9tYXAyL29tYXA0LWNvbW1vbi5jIHwgMSArCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKPj4gCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAy
L29tYXA0LWNvbW1vbi5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwNC1jb21tb24uYwo+PiBp
bmRleCA2ZDFlYjRlZWZlZmUuLmU5ODFiZjU3ZTY0ZiAxMDA2NDQKPj4gLS0tIGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9vbWFwNC1jb21tb24uYwo+PiArKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29t
YXA0LWNvbW1vbi5jCj4+IEBAIC0xMzUsNiArMTM1LDcgQEAgc3RhdGljIGludCBfX2luaXQgb21h
cDRfc3JhbV9pbml0KHZvaWQpCj4+ICAJCXByX3dhcm4oIiVzOlVuYWJsZSB0byBhbGxvY2F0ZSBz
cmFtIG5lZWRlZCB0byBoYW5kbGUgZXJyYXRhIEk2ODhcbiIsCj4+ICAJCQlfX2Z1bmNfXyk7Cj4+
ICAJc3JhbV9wb29sID0gb2ZfZ2VuX3Bvb2xfZ2V0KG5wLCAic3JhbSIsIDApOwo+PiArCW9mX25v
ZGVfcHV0KG5wKTsKPj4gIAlpZiAoIXNyYW1fcG9vbCkKPj4gIAkJcHJfd2FybigiJXM6VW5hYmxl
IHRvIGdldCBzcmFtIHBvb2wgbmVlZGVkIHRvIGhhbmRsZSBlcnJhdGEgSTY4OFxuIiwKPj4gIAkJ
CV9fZnVuY19fKTsKPgo+SGVyZSB0b28gc3JhbV9wb29sIGlzIHVzZWQgYWZ0Z2VyIG9mX25vZGVf
cHV0KCkuCj4KPlJlZ2FyZHMsCj4KPlRvbnkKClRoYW5rcywgVG9ueS4KCkkgd2lsbCBzZW5kIGEg
bmV3IHBhdGNoIHRvIGZpeCB0aGUgb3JkZXIgcHJvYmxlbS4KCkxpYW5nCgo=
