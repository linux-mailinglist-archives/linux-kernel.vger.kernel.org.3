Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C04C6E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiB1Nir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiB1Nio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:38:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F628E07
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:38:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38A8CB8112D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD50C340E7;
        Mon, 28 Feb 2022 13:38:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gh3Ek2K7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646055481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jp0tzar9XDCt4OwMcSl74uoHMR8VXI+dpMIexJoOH+Y=;
        b=Gh3Ek2K7j2tFgs3PkOadZubvr2UgwwCsxyr53Sn/Cy24dwbXC7eS7YSLay9TMIGP9eSApI
        XSJ3UDmU9THx09JmjkKJpuHGT9EpnyPIp9gvC0TSW374StU8WrXEznvO6dBpptHLYRx1Wy
        NLjdD2dNCsmDwVdTL2wZy4FPeowJaiI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c2640e39 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Feb 2022 13:38:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/2] random: don't let 644 read-only sysctls be written to
Date:   Mon, 28 Feb 2022 14:37:43 +0100
Message-Id: <20220228133743.2243-2-Jason@zx2c4.com>
In-Reply-To: <20220228133743.2243-1-Jason@zx2c4.com>
References: <20220228133743.2243-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We leave around these old sysctls for compatibility, and we keep them
"writable" for compatibility, but even after writing, we should keep
reporting the same value. This is consistent with how userspaces tend to
use sysctl_random_write_wakeup_bits, writing to it, and then later
reading from it and using the value.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 116ebf50d791..06c6e15b5f3d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1669,6 +1669,13 @@ static int proc_do_uuid(struct ctl_table *table, int write, void *buffer,
 	return proc_dostring(&fake_table, 0, buffer, lenp, ppos);
 }
 
+/* The same as proc_dointvec, but writes don't change anything. */
+static int proc_do_rointvec(struct ctl_table *table, int write, void *buffer,
+			    size_t *lenp, loff_t *ppos)
+{
+	return write ? 0 : proc_dointvec(table, write, buffer, lenp, ppos);
+}
+
 static struct ctl_table random_table[] = {
 	{
 		.procname	= "poolsize",
@@ -1689,14 +1696,14 @@ static struct ctl_table random_table[] = {
 		.data		= &sysctl_random_write_wakeup_bits,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_do_rointvec,
 	},
 	{
 		.procname	= "urandom_min_reseed_secs",
 		.data		= &sysctl_random_min_urandom_seed,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_do_rointvec,
 	},
 	{
 		.procname	= "boot_id",
-- 
2.35.1

