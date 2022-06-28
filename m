Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE4655D1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbiF1Fwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiF1Fwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:52:53 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 450E82717F;
        Mon, 27 Jun 2022 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=pmUFr
        1yYg2L9fvIyy+5KwX7siU5hFTrw80B5JK7OfS8=; b=SwHUeKzEqj+efZ3HY4zxs
        K9Oiw22rCCUnDsNPcDbaeCz2F9cqfmL4QHSblDQtKf/HswlTUAOSS44Z3wwI3+RY
        LztbJbac2fMpts0KxoxrZMlcXtn77wLpmT+/fXcd04tpe1ULjgO4RlwQWFjS3wTq
        +F45RF7WgDI8PpjFFKJuII=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Tue, 28 Jun 2022 13:51:50 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Tue, 28 Jun 2022 13:51:50 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Tony Lindgren" <tony@atomide.com>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] arm/mach-omap2: Fix refcount leak bug in
 omap_hwmod.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <YrqKKBflkZKRHwXW@atomide.com>
References: <20220618014747.4055279-1-windhl@126.com>
 <YrqKKBflkZKRHwXW@atomide.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4b994fd6.3db9.181a8ddb1e9.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowAAnfPD3lrpiRPI+AA--.18948W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BIuF1pED0WRtAADsF
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTI4IDEyOjU3OjEyLCAiVG9ueSBMaW5kZ3JlbiIgPHRvbnlAYXRvbWlkZS5j
b20+IHdyb3RlOgo+SGksCj4KPiogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPiBbMjIwNjE4IDA0
OjQzXToKPj4gSW4gX2luaXQoKSwgb2ZfZmluZF9ub2RlX2J5X25hbWUoKSB3aWxsIHJldHVybiBh
IG5vZGUgcG9pbnRlciB3aXRoCj4+IHJlZmNvdW50IGluY3JlbWVudGVkLiBXZSBzaG91bGQgdXNl
IG9mX25vZGVfcHV0KCkgaW4gZmFpbCBwYXRoIG9yCj4+IHdoZW4gaXQgaXMgbm90IHVzZWQgYW55
bW9yZS4KPj4gCj4+IE5PVEU6IEFzIHRoZSByZWYgd2lsbCBiZSBwYXNzZWQgZnJvbSAnYnVzJyB0
byAnbnAnIGJ5IHRoZSB4eF9sb29rdXAoKSwKPj4gaW4gbm9ybWFsIGV4aXQgcGF0aCwgd2Ugc2hv
dWxkIGNhbGwgb2Zfbm9kZV9wdXQoKSBhdCB0aGUgZW5kIHVzZSBvZiAnbnAnLAo+PiBub3QgdGhl
IGVuZCB1c2Ugb2YgJ2J1cycuCj4KPkxvb2tzIGNvcnJlY3QgdG8gbWUuIFdoYXQgYWJvdXQgbWlz
c2luZyBvZl9ub2RlX3B1dCgpIGZvcgo+b2ZfZ2V0X25leHRfY2hpbGQoKSBhbHNvIGluIHRoZSBf
aW5pdCgpIGZ1bmN0aW9uPwo+Cj5SZWdhcmRzLAo+Cj5Ub255CgpUaGFua3MsIFRvbnkuCgpJIGhh
dmUgZm91bmQgdGhpcyBidWcgYnV0IG5vdCBzZW5kIHRoZSBwYXRjaCBmb3Igb2ZfZ2V0X25leHRf
Y2hpbGQoKQphcyBJIGFtIGNvbGxlY3Rpbmcgb3RoZXIgT0YgZnVuY3Rpb24gcmVsYXRlZCBidWdz
IGFuZCBJIGhhdmUgYmVlbiB0b2xkIHRoYXQgaXQgaXMgYmV0dGVyIAp0byBjb2xsZWN0IGFsbCBz
aW1pbGFyIGJ1Z3MgaW4gc2FtZSBkaXJlY3RvcnksIHRoZW4gZmluYWxseSByZXBvcnQgdGhlbS4K
ClNvIEkgd2lsbCBzZW5kIGEgbmV3IHBhdGNoIGZvciBib3RoIG9mIHRoZSB0d28gbWlzc2luZyAn
cHV0JyBidWdzIGNhdXNlZCBieQpvZl9maW5kX3h4eCgpIGFuZCBvZl9nZXRfeHh4KCkgaW4gb21h
cF9od21vZC5jCgpUaGFua3MgZ2Fpbi4KCkxpYW5nCgo=
