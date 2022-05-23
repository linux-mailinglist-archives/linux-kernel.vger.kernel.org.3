Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6199F5312DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiEWOEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiEWOER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:04:17 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D1357B38
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1653314657;
  x=1684850657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jmA5B4dvI7xazBJLNO/gm5LrfVmN7fBAWkoDxCERPj0=;
  b=nFfhcKRuauPGR709FMVVvQrz6iRxxuYZq352HpQ6+s6C6M6FnklSOu6m
   MATn6LKJyBxMYj7qGlAohBALa1nDNQG5XzMx2Y40axkocXPll/U2HoOyR
   s5Lg5t4akJaYrv9jICwmt/jK57JkwSd6/IsxHin6N87zKkyOaCBTjeXdg
   WtHIxv6SUXU8q9jLxi0DFoSlrdhwzcAHNfNNWRp5Extm1tRgAptS145ix
   JKJtTpyAaSDACM3sC1P6CD0Ecrg+Ec8v2Fmx4AgQvciQl0ryShGNDxz0J
   jJiqaopA4jI9wjAJs5IAxyWqiyZcwUmJ4Zd0ryntygJcl4xbMkvIp0nRS
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
        <johannes@sipsolutions.net>
CC:     <kernel@axis.com>, <x86@kernel.org>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] um: Fix out-of-bounds read in LDT setup
Date:   Mon, 23 May 2022 16:04:03 +0200
Message-ID: <20220523140403.2361040-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_stub_data() expects the data_count parameter to be the number of
longs, not bytes.

 ==================================================================
 BUG: KASAN: stack-out-of-bounds in syscall_stub_data+0x70/0xe0
 Read of size 128 at addr 000000006411f6f0 by task swapper/1

 CPU: 0 PID: 1 Comm: swapper Not tainted 5.18.0+ #18
 Call Trace:
  show_stack.cold+0x166/0x2a7
  __dump_stack+0x3a/0x43
  dump_stack_lvl+0x1f/0x27
  print_report.cold+0xdb/0xf81
  kasan_report+0x119/0x1f0
  kasan_check_range+0x3a3/0x440
  memcpy+0x52/0x140
  syscall_stub_data+0x70/0xe0
  write_ldt_entry+0xac/0x190
  init_new_ldt+0x515/0x960
  init_new_context+0x2c4/0x4d0
  mm_init.constprop.0+0x5ed/0x760
  mm_alloc+0x118/0x170
  0x60033f48
  do_one_initcall+0x1d7/0x860
  0x60003e7b
  kernel_init+0x6e/0x3d4
  new_thread_handler+0x1e7/0x2c0

 The buggy address belongs to stack of task swapper/1
  and is located at offset 64 in frame:
  init_new_ldt+0x0/0x960

 This frame has 2 objects:
  [32, 40) 'addr'
  [64, 80) 'desc'
 ==================================================================

Fixes: 858259cf7d1c443c83 ("uml: maintain own LDT entries")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/x86/um/ldt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 3ee234b6234d..255a44dd415a 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -23,9 +23,11 @@ static long write_ldt_entry(struct mm_id *mm_idp, int func,
 {
 	long res;
 	void *stub_addr;
+
+	BUILD_BUG_ON(sizeof(*desc) % sizeof(long));
+
 	res = syscall_stub_data(mm_idp, (unsigned long *)desc,
-				(sizeof(*desc) + sizeof(long) - 1) &
-				    ~(sizeof(long) - 1),
+				sizeof(*desc) / sizeof(long),
 				addr, &stub_addr);
 	if (!res) {
 		unsigned long args[] = { func,
-- 
2.34.1

