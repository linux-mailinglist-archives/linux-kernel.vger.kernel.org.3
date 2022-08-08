Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668F558CC10
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244003AbiHHQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiHHQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:23:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5515BBF62
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:23:47 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id EF841210924F;
        Mon,  8 Aug 2022 09:23:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF841210924F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659975827;
        bh=SF6aPu9dkDVpepcAP0mki+P9vIrc/IIl+YlIOR6FPFs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ThqZMds3nvK/j0W05v/Siu6vhl/sV37+C/rXDwypQj5XLch6q+vH8Qb6v1YYpMrji
         CZKvf/p7ag+/KvZLPZAQF+GEDf2OTKRyDE1DJhy9vtEC764H7bRuGA3/FAZRKveNkP
         khaC07fSqQPVZTppKo3t+ysnxokAZPoju6JoG+jg=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, mikelley@microsoft.com,
        sander@svanheule.net, linux-kernel@vger.kernel.org
Subject: [RFC] issue with cpumask for UniProcessor
Date:   Mon,  8 Aug 2022 09:23:41 -0700
Message-Id: <1659975821-30762-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <e78c55ecb98172356248a7a89da501479ead6ae0.1659077534.git.sander@svanheule.net>
References: <e78c55ecb98172356248a7a89da501479ead6ae0.1659077534.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am working on a UniProcessor system with latest linux-next kernel (20220803).
I observed two files "shared_cpu_map” and “shared_cpu_list” are missing
for L3 cache (/sys/devices/system/cpu/cpu0/cache/index3). This causes lscpu
version 2.34 to segfault. On further digging I figured below is the commit
which introduced this problem.

https://lore.kernel.org/lkml/e78c55ecb98172356248a7a89da501479ead6ae0.1659077534.git.sander@svanheule.net/


I am not 100% certain what the proper fix for it is, but below changes fix
this issue. I understand above patch is already confirmed for linux kernel
6.0, please suggest if we need fixing this in 6.0.

Regards,
Saurabh



diff --git a/lib/cpumask.c b/lib/cpumask.c
index b9728513a4d4..81fc2e35b5b1 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -16,10 +16,14 @@
  */
 unsigned int cpumask_next(int n, const struct cpumask *srcp)
 {
+#if NR_CPUS == 1
+       return n+1;
+#else
        /* -1 is a legal arg here. */
        if (n != -1)
                cpumask_check(n);
        return find_next_bit(cpumask_bits(srcp), nr_cpumask_bits, n + 1);
+#endif
 }
 EXPORT_SYMBOL(cpumask_next);
