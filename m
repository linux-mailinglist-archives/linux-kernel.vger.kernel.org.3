Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBBC58F37C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiHJUZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiHJUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:25:15 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1621116A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:25:14 -0700 (PDT)
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
        by cmsmtp with ESMTP
        id Lqa5od8EbSp39LsGPoa259; Wed, 10 Aug 2022 20:25:13 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
        by cmsmtp with ESMTP
        id LsGOoKDrSGRNlLsGPo8HiK; Wed, 10 Aug 2022 20:25:13 +0000
X-Authority-Analysis: v=2.4 cv=Sfrky9du c=1 sm=1 tr=0 ts=62f41429
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=biHskzXt2R4A:10 a=M51BFTxLslgA:10 a=nlC_4_pT8q9DhB4Ho9EA:9 a=3I1X_3ewAAAA:8
 a=9lfKK0KZlbk0EP5mL7EA:9 a=QEXdDO2ut3YA:10 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.17.1/8.17.1) with ESMTPSA id 27AKPBNa022034
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Aug 2022 14:25:12 -0600
Date:   Wed, 10 Aug 2022 14:25:11 -0600 (MDT)
From:   =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: Export log_buf_len to userland
Message-ID: <a41b5ad3-d052-49b8-e038-b020c1dc6788@tuyoix.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463807856-429329311-1660163112=:22026"
X-CMAE-Envelope: MS4xfJAK+c9sGH2jNbMStzcxe4DZyP3YbVRI1CLh9/6u1uXOXChY607zVA8mPc/wYUeK0m4H3PWgMlgXHKrf3CfYn3RBqLNLQGxHc6H16Ry8Od71AmpqGuQj
 BU8vziVSTt9FwpWRRNNVI2svmVmvYPbORcIzhva4wXX/BWzhPz1M7C8AM9bvGiupBtv59VHyNxfBN5GViYabjs8EUFgw+SW0xP9KhuMAhkrUruyUN5vj8vo9
 B9g1+ln+ZgAJiqocMlHhltvYUnvbr9Ybrx5mcaTRLno=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463807856-429329311-1660163112=:22026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Make the kernel log's buffer size available to userland so it can be used with
`dmesg -s`.

This change is not eligible for stable@.

Please Reply-To-All.

Thanks and have a great day.

Marc.

Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>

diff -aNpRruz -X /etc/diff.excludes linux-5.17.1/include/linux/printk.h devel-5.17.1/include/linux/printk.h
--- linux-5.17.1/include/linux/printk.h	2022-03-28 02:03:22.000000000 -0600
+++ devel-5.17.1/include/linux/printk.h	2022-03-28 07:14:10.803008293 -0600
@@ -318,6 +337,7 @@ extern void __printk_cpu_unlock(void);
 #endif /* CONFIG_SMP */

 extern int kptr_restrict;
+extern u32 log_buf_len;

 /**
  * pr_fmt - used by the pr_*() macros to generate the printk format string
diff -aNpRruz -X /etc/diff.excludes linux-5.17.1/kernel/printk/printk.c devel-5.17.1/kernel/printk/printk.c
--- linux-5.17.1/kernel/printk/printk.c	2022-03-28 02:03:22.000000000 -0600
+++ devel-5.17.1/kernel/printk/printk.c	2022-03-28 07:14:10.803008293 -0600
@@ -404,7 +404,7 @@ static struct latched_seq clear_seq = {
 #define LOG_BUF_LEN_MAX (u32)(1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
-static u32 log_buf_len = __LOG_BUF_LEN;
+u32 log_buf_len = __LOG_BUF_LEN;

 /*
  * Define the average message size. This only affects the number of
diff -aNpRruz -X /etc/diff.excludes linux-5.17.1/kernel/printk/sysctl.c devel-5.17.1/kernel/printk/sysctl.c
--- linux-5.17.1/kernel/printk/sysctl.c	2022-03-28 02:03:22.000000000 -0600
+++ devel-5.17.1/kernel/printk/sysctl.c	2022-03-28 07:14:10.803008293 -0600
@@ -22,6 +22,13 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,

 static struct ctl_table printk_sysctls[] = {
 	{
+		.procname	= "log_buf_len",
+		.data		= &log_buf_len,
+		.maxlen		= sizeof(u32),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+	{
 		.procname	= "printk",
 		.data		= &console_loglevel,
 		.maxlen		= 4*sizeof(int),
---1463807856-429329311-1660163112=:22026--
