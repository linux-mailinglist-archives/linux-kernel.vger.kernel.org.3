Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2490579529
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiGSIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGSIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:23:00 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB2512AC72
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Bcg5u
        Zu5ki+YAprWv2idWDCZMOwOYaQUQoRry7KMe7E=; b=k2gLTM3crUa5UGLfegq7z
        nx/pyBYt/re7dVSSL40Q5PEHpwkR+rZnpOP/HpJ41X4WvP5YF6ValEwyPnqmBAPm
        V1ug2V+/KIBKJY4N5rRNlaT/9m2669zTk8x9vM4zjoPWM04bcr7p24jzoQnvXRvz
        bzOJpHj0TQnnJQ3fTsVL7M=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Tue, 19 Jul 2022 16:22:40 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Tue, 19 Jul 2022 16:22:40 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] memory: of: Add of_node_put() when breaking out of
 for_each_child_of_node()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <4be14ed4-17de-a90b-e899-536552d6c3c7@linaro.org>
References: <20220716025043.447036-1-windhl@126.com>
 <4be14ed4-17de-a90b-e899-536552d6c3c7@linaro.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5dbca3c0.5353.182158d5797.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowAAnLyfRadZiR9FKAA--.31740W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2h9DF1uwMbmb1gABs+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMDctMTkgMTY6MTg6MzEsICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnPiB3cm90ZToKPk9uIDE2LzA3LzIwMjIgMDQ6NTAsIExpYW5n
IEhlIHdyb3RlOgo+PiBJbiBvZl9nZXRfZGRyX3RpbWluZ3MoKSBhbmQgb2ZfbHBkZHIzX2dldF9k
ZHJfdGltaW5ncygpLCB3ZSBzaG91bGQKPj4gYWRkIHRoZSBvZl9ub2RlX3B1dCgpIHdoZW4gYnJl
YWtpbmcgb3V0IG9mIGZvcl9lYWNoX2NoaWxkX29mX25vZGUoKQo+PiBhcyBpdCB3aWxsIGF1dG9t
YXRpY2FsbHkgaW5jcmVhc2UgYW5kIGRlY3JlYXNlIHRoZSByZWZjb3VudC4KPj4gCj4KPlRoYW5r
IHlvdSBmb3IgeW91ciBwYXRjaC4gVGhlcmUgaXMgc29tZXRoaW5nIHRvIGRpc2N1c3MvaW1wcm92
ZS4KPgo+PiBGaXhlczogOTc2ODk3ZGQ5NmRiICgibWVtb3J5OiBFeHRlbmQgb2ZfbWVtb3J5IHdp
dGggTFBERFIzIHN1cHBvcnQiKQo+PiBGaXhlczogZTZiNDJlYjZhNjZjICgibWVtb3J5OiBlbWlm
OiBhZGQgZGV2aWNlIHRyZWUgc3VwcG9ydCB0byBlbWlmIGRyaXZlciIpCj4KPlBsZWFzZSBzcGxp
dCB0aGUgcGF0Y2hlcyBpbnRvIHR3byBzZXBhcmF0ZSBmaXhlcy4KPgo+PiBTaWduZWQtb2ZmLWJ5
OiBMaWFuZyBIZSA8d2luZGhsQDEyNi5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9tZW1vcnkvb2Zf
bWVtb3J5LmMgfCAyICsrCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj5CZXN0
IHJlZ2FyZHMsCj5Lcnp5c3p0b2YKCkkgd2lsbCBkbyB0aGF0IHNvb24uCgpUaGFua3MsIApMaWFu
Zwo=
