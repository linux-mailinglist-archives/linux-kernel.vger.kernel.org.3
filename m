Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036734CD0E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiCDJOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiCDJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:14:15 -0500
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6A120EA6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646385204;
        bh=MFtNbgIXbDVYsyzREIkAA943SlaomrM4H8gjb3zCarY=;
        h=From:To:Cc:Subject:Date;
        b=YD6xkKqiFRjFLY04Ywe+GvPWb7hfRPTKwmuGan/Bxp3FHmO9tZiFJ2M4JzBNntFNm
         nvSE7ud0LJeYMXB6oMZrBVYQgU4mvPOXnaGLtw1gDGhmeBLiFjxF/CRXLtSak3fmRs
         fvmhxnjARIuOHhVWnrvL7VG0c5XtL7Empr55Ef/s=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id 35411C58; Fri, 04 Mar 2022 17:13:20 +0800
X-QQ-mid: xmsmtpt1646385200tv9kqwm1e
Message-ID: <tencent_D44A49FFB420EDCCBFB9221C8D14DFE12908@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXyzmHxf9zmL9Onu1wMWH1/HEiW8k8MSqzddz/IqZsCKIA5qpo+8F
         0n/Ho17vhLCvXrrDR/zRjg3R1YQbXsklAvqNqaOmCHVrU3zX+x0m0sZxcCpWSFgTUWtPA5srcym3
         9IH5CiBUpkMzwxd02+cDmYufHAKFibztn8Uk4iLi8E2eo77kcQH7EzPeFTVBh7pSj4RhZvECIb9b
         +x/zQN7R3vzVUpCJh0nGAdeEwRUjhaHhF0Y1N3txGBPWrduJJOOFGQT/5kXp8evhulBrHXtkGhNz
         ELQzFQeh1TgNoYDQf8JDwztpOJp131M1FlfIWxmOwgEqWSMbyaecyRLySo+h+qDS821dgoBTyZfQ
         +yGAvhr7CJGGhfo1S5Cai+PW2V1ZlOn5n+1fp6v14nk141xs+d3PziH0Z6HWMYjRFrnuZz0zqJHR
         vei84zyzCdRj9+vIByTvBCBmj/b98EYnUNs0ogAc/1kvxsIC2zKavHFs3PnZQHgvw2p93f9RF4uW
         82lnbwaWcGxyYWueQsOywu3LYp7zEs62Lw35Q0N3sV6lDvmdIIdEhUpymHuL8YvB/4nYzpj5aHDI
         qCYLcTTx8Jgyz4cX59LuNmnm1ytZx7hpr0x4JsPZpDi+aWJIOx4HagVlBc9H/SNMujegilF4/kkg
         H/jyzJefXR1LI5DTNsWGXN5dWvhTcHtpxee/gXC+oj06QmhCgNrNJEztxHufRi0tTS2LeIsxQ+OZ
         5AnP3KWaHfxEvBX3IkeEMoLxgw7r9iVgV2WugeP4mbIXbxoQkBWC6u40RPQTBMBR/GQaTRTDCp2L
         SPBgYMn3PiA6VkyXs1cWiBzu+/9BsC1Gb/0QmFN2MngUq6TFr4tBF2E8wwYDMv2MwqeJjREHiWlL
         VD3vfzjmXHNZQKbF779gFd20nQ6+DuhOv4noq0qHSGk9rqDHo67qqw1vIQFMnNDgdntkejZ/BO
From:   xkernel.wang@foxmail.com
To:     glider@google.com, akpm@linux-foundation.org
Cc:     andreyknvl@gmail.com, elver@google.com, dvyukov@google.com,
        ryabinin.a.a@gmail.com, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] lib/test_meminit: add checks for the allocation functions
Date:   Fri,  4 Mar 2022 17:12:15 +0800
X-OQ-MSGID: <20220304091215.5063-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

alloc_pages(), kmalloc() and vmalloc() are all memory allocation
functions which can return NULL when some internal memory failures
happen. So it is better to check the return of them to catch the failure
in time for better test them.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 lib/test_meminit.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index e4f706a..2f4c4bc 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -67,17 +67,24 @@ static int __init do_alloc_pages_order(int order, int *total_failures)
 	size_t size = PAGE_SIZE << order;
 
 	page = alloc_pages(GFP_KERNEL, order);
+	if (!page)
+		goto err;
 	buf = page_address(page);
 	fill_with_garbage(buf, size);
 	__free_pages(page, order);
 
 	page = alloc_pages(GFP_KERNEL, order);
+	if (!page)
+		goto err;
 	buf = page_address(page);
 	if (count_nonzero_bytes(buf, size))
 		(*total_failures)++;
 	fill_with_garbage(buf, size);
 	__free_pages(page, order);
 	return 1;
+err:
+	(*total_failures)++;
+	return 1;
 }
 
 /* Test the page allocator by calling alloc_pages with different orders. */
@@ -100,15 +107,22 @@ static int __init do_kmalloc_size(size_t size, int *total_failures)
 	void *buf;
 
 	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		goto err;
 	fill_with_garbage(buf, size);
 	kfree(buf);
 
 	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		goto err;
 	if (count_nonzero_bytes(buf, size))
 		(*total_failures)++;
 	fill_with_garbage(buf, size);
 	kfree(buf);
 	return 1;
+err:
+	(*total_failures)++;
+	return 1;
 }
 
 /* Test vmalloc() with given parameters. */
@@ -117,15 +131,22 @@ static int __init do_vmalloc_size(size_t size, int *total_failures)
 	void *buf;
 
 	buf = vmalloc(size);
+	if (!buf)
+		goto err;
 	fill_with_garbage(buf, size);
 	vfree(buf);
 
 	buf = vmalloc(size);
+	if (!buf)
+		goto err;
 	if (count_nonzero_bytes(buf, size))
 		(*total_failures)++;
 	fill_with_garbage(buf, size);
 	vfree(buf);
 	return 1;
+err:
+	(*total_failures)++;
+	return 1;
 }
 
 /* Test kmalloc()/vmalloc() by allocating objects of different sizes. */
-- 
