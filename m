Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCF05AEFE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiIFQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiIFQGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:06:02 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EB1627DC7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=uKNIl0VCi9tiAEi3aw
        ARGiYJ39SyrDAmIGjdTHmuGxc=; b=ZVaIRjKuI5vaP4nlk36nuS+cRUUYvyDdil
        4GnxM/D5z7Iz2rqNv6KTqwPC4FB/0ODkcwM0SvXyRdfzTiQ0vwYP1ZPSqodsyfWc
        5EyIaWODNVAbCL/8HRVPrcr1cz991mdFsmz4qHJnbi9RJhe9ByKiZjpEr8Uc2NXi
        cuHSdFUeo=
Received: from localhost.localdomain (unknown [153.37.203.188])
        by smtp3 (Coremail) with SMTP id G9xpCgBnjaHlZhdj1ECrbQ--.24181S4;
        Tue, 06 Sep 2022 23:28:57 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     peterz@infradead.org, tglx@linutronix.de, hdegoede@redhat.com,
        tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, lizhe <sensor1010@163.com>
Subject: [PATCH v1] kernel/stop_matche.c : remove redundant global variable initialization
Date:   Tue,  6 Sep 2022 08:27:32 -0700
Message-Id: <20220906152732.5179-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: G9xpCgBnjaHlZhdj1ECrbQ--.24181S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUGF1fGr47tF47JFW7twb_yoWxuFg_uF
        10qw18Wr1Y9rW0gw12qw4rXFyDKw4Fva1IkrWxKFWUAa1kG3Z8Cw1qgr9IqF4fWrnIvF98
        AwnI9Fn8tw1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtqXHJUUUUU==
X-Originating-IP: [153.37.203.188]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBdBp0q1gi3zK2-gAAsu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	the global variable stop_machine_initialized has a default
	value of false, no need to initialize it fo false

Signed-off-by: lizhe <sensor1010@163.com>
---
 kernel/stop_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..d1ea5233a45e 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -47,7 +47,7 @@ struct cpu_stopper {
 };
 
 static DEFINE_PER_CPU(struct cpu_stopper, cpu_stopper);
-static bool stop_machine_initialized = false;
+static bool stop_machine_initialized;
 
 void print_stop_info(const char *log_lvl, struct task_struct *task)
 {
-- 
2.17.1

