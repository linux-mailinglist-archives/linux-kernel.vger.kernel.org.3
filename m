Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850CB563D99
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 03:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiGBBrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 21:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGBBrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 21:47:18 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72E453981A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 18:47:16 -0700 (PDT)
Received: by ajax-webmail-mail-app3 (Coremail) ; Sat, 2 Jul 2022 09:47:02
 +0800 (GMT+08:00)
X-Originating-IP: [10.190.66.20]
Date:   Sat, 2 Jul 2022 09:47:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     linux-kernel@vger.kernel.org
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        edumazet@google.com
Subject: Re: [PATCH] timers: fix synchronization rules in comments of
 del_timer_sync
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20220701085535.17018-1-duoming@zju.edu.cn>
References: <20220701085535.17018-1-duoming@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <64ac5e50.24399.181bc9704ed.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgAn+MiWo79ikAtTAQ--.26342W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgMTAVZdtafvDQAAso
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

SGVsbG8gbWFpbnRhaW5lcnMsCgpJbiBvcmRlciB0byBmdXJ0aGVyIHByb3ZlIHRoZSBkZWxfdGlt
ZXJfc3luYygpIGNvdWxkIHN0b3AgdGhlIHRpbWVyIHRoYXQKcmVzdGFydCBpdHNlbGYgaW4gaXRz
IHRpbWVyIGhhbmRsZXIsIEkgd3JvdGUgdGhlIGZvbGxvd2luZyBrZXJuZWwgbW9kdWxlCndob2Vz
IHBhcnQgb2YgY29kZSBpcyBzaG93biBiZWxvdzoKCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpzdHJ1Y3QgdGltZXJfbGlz
dCBteV90aW1lcjsKc3RhdGljIHZvaWQgbXlfdGltZXJfY2FsbGJhY2soc3RydWN0IHRpbWVyX2xp
c3QgKnRpbWVyKTsKc3RhdGljIHZvaWQgc3RhcnRfdGltZXIodm9pZCk7CgpzdGF0aWMgdm9pZCBz
dGFydF90aW1lcih2b2lkKXsKICAgIGRlbF90aW1lcigmbXlfdGltZXIpOwogICAgbXlfdGltZXIu
ZXhwaXJlcyA9IGppZmZpZXMrSFo7CiAgICBteV90aW1lci5mdW5jdGlvbiA9IG15X3RpbWVyX2Nh
bGxiYWNrOwogICAgYWRkX3RpbWVyKCZteV90aW1lcik7Cn0KCnN0YXRpYyB2b2lkIG15X3RpbWVy
X2NhbGxiYWNrKHN0cnVjdCB0aW1lcl9saXN0ICp0aW1lcil7CiAgICBwcmludGsoIkluIG15X3Rp
bWVyX2Z1bmN0aW9uIik7CiAgICBwcmludGsoInRoZSBqaWZmaWVzIGlzICVsZFxuIixqaWZmaWVz
KTsKICAgIHN0YXJ0X3RpbWVyKCk7Cn0KCnN0YXRpYyBpbnQgX19pbml0IGRlbF90aW1lcl9zeW5j
X2luaXQodm9pZCkKewogICAgaW50IHJlc3VsdDsKICAgIHByaW50aygibXlfdGltZXIgd2lsbCBi
ZSBjcmVhdGUuXG4iKTsKICAgIHByaW50aygidGhlIGppZmZpZXMgaXMgOiVsZFxuIiwgamlmZmll
cyk7CiAgICB0aW1lcl9zZXR1cCgmbXlfdGltZXIsbXlfdGltZXJfY2FsbGJhY2ssMCk7CiAgICBy
ZXN1bHQgPSBtb2RfdGltZXIoJm15X3RpbWVyLGppZmZpZXMgKyBTSVhQX1RYREVMQVkpOwogICAg
cHJpbnRrKCJ0aGUgbW9kX3RpbWVyIGlzIDolZFxuXG4iLHJlc3VsdCk7CiAgICByZXR1cm4gMDsK
fQoKc3RhdGljIHZvaWQgX19leGl0IGRlbF90aW1lcl9zeW5jX2V4aXQodm9pZCkKewogICAgaW50
IHJlc3VsdD1kZWxfdGltZXJfc3luYygmbXlfdGltZXIpOwogICAgcHJpbnRrKCJ0aGUgZGVsX3Rp
bWVyX3N5bmMgaXMgOiVkXG5cbiIsIHJlc3VsdCk7Cn0KCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpUaGUgdGltZXIgaGFu
ZGxlciBpcyBydW5uaW5nIGZyb20gaW50ZXJydXB0cyBhbmQgZGVsX3RpbWVyX3N5bmMoKSBjb3Vs
ZCBzdG9wCnRoZSB0aW1lciB0aGF0IHJld2luZCBpdHNlbGYgaW4gaXRzIHRpbWVyIGhhbmRsZXIs
IHRoZSByZXN1bHQgaXMgc2hvd24gYmVsb3c6CgojIGluc21vZCBkZWxfdGltZXJfc3luYy5rbyAK
WyAgMTAzLjUwNTg1N10gbXlfdGltZXIgd2lsbCBiZSBjcmVhdGUuClsgIDEwMy41MDU5MjJdIHRo
ZSBqaWZmaWVzIGlzIDo0Mjk0NzcwODMyClsgIDEwMy41MDY4NDVdIHRoZSBtb2RfdGltZXIgaXMg
OjAKWyAgMTAzLjUwNjg0NV0gCiMgWyAgMTAzLjUzMjM4OV0gSW4gbXlfdGltZXJfZnVuY3Rpb24K
WyAgMTAzLjUzMjQ1Ml0gdGhlIGppZmZpZXMgaXMgNDI5NDc3MDg1OQpbICAxMDQuNTc2NzY4XSBJ
biBteV90aW1lcl9mdW5jdGlvbgpbICAxMDQuNTc3MDk2XSB0aGUgamlmZmllcyBpcyA0Mjk0Nzcx
OTA0ClsgIDEwNS42MDA5NDFdIEluIG15X3RpbWVyX2Z1bmN0aW9uClsgIDEwNS42MDEwNzJdIHRo
ZSBqaWZmaWVzIGlzIDQyOTQ3NzI5MjgKWyAgMTA2LjYyNTM5N10gSW4gbXlfdGltZXJfZnVuY3Rp
b24KWyAgMTA2LjYyNTU3M10gdGhlIGppZmZpZXMgaXMgNDI5NDc3Mzk1MgpbICAxMDcuNjQ4OTk1
XSBJbiBteV90aW1lcl9mdW5jdGlvbgpbICAxMDcuNjQ5MjEyXSB0aGUgamlmZmllcyBpcyA0Mjk0
Nzc0OTc2ClsgIDEwOC42NzMwMzddIEluIG15X3RpbWVyX2Z1bmN0aW9uClsgIDEwOC42NzM3ODdd
IHRoZSBqaWZmaWVzIGlzIDQyOTQ3NzYwMDEKcm1tb2QgZGVsX3RpbWVyX3N5bmMua28KWyAgMTA5
LjY0OTQ4Ml0gdGhlIGRlbF90aW1lcl9zeW5jIGlzIDoxClsgIDEwOS42NDk0ODJdIAojIAoKVGhl
IHJvb3QgY2F1c2UgaXMgc2hvd24gYmVsb3c6CgoJZG8gewoJCXJldCA9IHRyeV90b19kZWxfdGlt
ZXJfc3luYyh0aW1lcik7CgoJCWlmICh1bmxpa2VseShyZXQgPCAwKSkgewoJCQlkZWxfdGltZXJf
d2FpdF9ydW5uaW5nKHRpbWVyKTsKCQkJY3B1X3JlbGF4KCk7CgkJfQoJfSB3aGlsZSAocmV0IDwg
MCk7CgpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2tlcm5l
bC90aW1lL3RpbWVyLmMjTDEzODEKCklmIHdlIGNhbGwgYW5vdGhlciB0aHJlYWQgc3VjaCBhcyBh
IHdvcmtfcXVldWUgb3IgdGhlIGNvZGUgaW4gb3RoZXIgcGxhY2VzCnRvIHJlc3RhcnQgdGhlIHRp
bWVyIGluc3RlYWQgb2YgaW4gaXRzIHRpbWVyIGhhbmRsZXIsIHRoZSBkZWxfdGltZXJfc3luYygp
CmNvdWxkIG5vdCBzdG9wIGl0LiBTbywgSSB0aGluayB0aGUgY29tbWVudHMgc2hvdWxkIGJlIGNo
YW5nZWQgdG8gIkNhbGxlcnMKbXVzdCBwcmV2ZW50IHJlc3RhcnRpbmcgb2YgdGhlIHRpbWVyIGlu
IG90aGVyIHBsYWNlcyBleGNlcHQgZm9yIHRoZSB0aW1lcidzCmhhbmRsZXIiLgoKQmVzdCByZWdh
cmRzLApEdW9taW5nIFpob3U=
