Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6B4C7E70
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiB1Xd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiB1Xd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:33:57 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A659E12AC7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:33:16 -0800 (PST)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 54E5F23934;
        Mon, 28 Feb 2022 23:33:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 834E918;
        Mon, 28 Feb 2022 23:32:51 +0000 (UTC)
Message-ID: <036f47fa1f929813cc2c7672654c7be9329b1fd9.camel@perches.com>
Subject: Re: [PATCH v4] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
From:   Joe Perches <joe@perches.com>
To:     Maninder Singh <maninder1.s@samsung.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Vaneet Narang <v.narang@samsung.com>
Date:   Mon, 28 Feb 2022 15:33:13 -0800
In-Reply-To: <20220228073708.1610603-1-maninder1.s@samsung.com>
References: <CGME20220228073715epcas5p1b3166e6b673d3c8b610f7e2f5745562b@epcas5p1.samsung.com>
         <20220228073708.1610603-1-maninder1.s@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 834E918
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: gr1kiibkcpjee4zsgjfdcuaag51c7ke4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18/6iHaBC6gQjGlhppikTqU+koLqy9l+BU=
X-HE-Tag: 1646091171-49918
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-28 at 13:07 +0530, Maninder Singh wrote:
> with commit 98e35f5894cf ("printk: git rid of [sched_delayed] message for
> printk_deferred") printk_deferred and printk_deferred_once requires
> LOGLEVEL in argument, but checkpatch.pl was not fixed and still reports
> it as warning:
> 
> WARNING: Possible unnecessary KERN_ALERT
> printk_deferred(KERN_ALERT "checking deferred\n");

I don't care for this patch at all.

There are many existing uses of printk_deferred both with and without a
specific KERN_<LEVEL>.

printk_deferred currently always emits at LOGLEVEL_SCHED/KERN_DEFAULT.

I think it's be better to modify vprintk_emit when LOGLEVEL_SCHED
is used and if a KERN_<LEVEL> exists in the format, use it.

Perhaps instead:
---
 kernel/printk/printk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1ce242f34d2be..6b5baf14f6d56 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2247,7 +2247,13 @@ asmlinkage int vprintk_emit(int facility, int level,
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-		level = LOGLEVEL_DEFAULT;
+		level = printk_get_level(fmt);
+		if (level) {
+			level -= '0';
+			fmt = printk_skip_level(fmt);
+		} else {
+			level = LOGLEVEL_DEFAULT;
+		}
 		in_sched = true;
 	}
 


