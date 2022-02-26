Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDAA4C5827
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 21:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiBZUyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 15:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiBZUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 15:54:16 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8298922BFD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 12:53:39 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru E92D420A5895
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     Stefani Seibold <stefani@seibold.net>,
        <linux-kernel@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] kfifo: make '__n' local variables *unsigned int*
Organization: Open Mobile Platform
Message-ID: <a135a18c-b332-33aa-9d79-da3395502e3f@omp.ru>
Date:   Sat, 26 Feb 2022 23:53:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '__n' local variables in kfifo_{in|out|out_peek}() are declared as
*unsigned long* for some strange reason -- the underlying __kfifo_*()
functions take *unsigned int* for the corresponding 'len' parameters.
Fix those declarations to *unsigned int*...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against Linus Torvalds' 'linux.git' repo.

 include/linux/kfifo.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: usb/include/linux/kfifo.h
===================================================================
--- usb.orig/include/linux/kfifo.h
+++ usb/include/linux/kfifo.h
@@ -520,7 +520,7 @@ __kfifo_uint_must_check_helper( \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
 	typeof(__tmp->ptr_const) __buf = (buf); \
-	unsigned long __n = (n); \
+	unsigned int __n = (n); \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	(__recsize) ?\
@@ -589,7 +589,7 @@ __kfifo_uint_must_check_helper( \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
 	typeof(__tmp->ptr) __buf = (buf); \
-	unsigned long __n = (n); \
+	unsigned int __n = (n); \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	(__recsize) ?\
@@ -819,7 +819,7 @@ __kfifo_uint_must_check_helper( \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
 	typeof(__tmp->ptr) __buf = (buf); \
-	unsigned long __n = (n); \
+	unsigned int __n = (n); \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	(__recsize) ? \
