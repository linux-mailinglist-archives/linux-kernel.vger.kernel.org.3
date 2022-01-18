Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1E49314B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350257AbiARXRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:17:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55330 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350247AbiARXRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:17:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA2F261474
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A45EC340E0;
        Tue, 18 Jan 2022 23:17:11 +0000 (UTC)
Date:   Tue, 18 Jan 2022 18:17:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinan Liu <yinan@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [GIT PULL] tracing/scripts: Fix some initialization problems
Message-ID: <20220118181709.5489df67@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yinan Liu <yinan@linux.alibaba.com>

Linus,

tracing/scripts: Possible uninitialized variable

The 0day bot discovered a possible uninitialized path in the
scripts that sort the mcount sections at build time. Just needed
to initialize that variable.


Please pull the latest trace-v5.17-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.17-2

Tag SHA1: f6512a8d14cbc7d3a9cb63c872fbbabe26399a5a
Head SHA1: 35140d399db2b67153fc53b51a97ddb8ba3b5956


Yinan Liu (1):
      script/sorttable: Fix some initialization problems

----
 scripts/sorttable.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---------------------------
commit 35140d399db2b67153fc53b51a97ddb8ba3b5956
Author: Yinan Liu <yinan@linux.alibaba.com>
Date:   Tue Jan 18 14:52:41 2022 +0800

    script/sorttable: Fix some initialization problems
    
    elf_mcount_loc and mcount_sort_thread definitions are not
    initialized immediately within the function, which can cause
    the judgment logic to use uninitialized values when the
    initialization logic of subsequent code fails.
    
    Link: https://lkml.kernel.org/r/20211212113358.34208-2-yinan@linux.alibaba.com
    Link: https://lkml.kernel.org/r/20220118065241.42364-1-yinan@linux.alibaba.com
    
    Fixes: 72b3942a173c ("scripts: ftrace - move the sort-processing in ftrace_init")
    Tested-by: Nathan Chancellor <nathan@kernel.org>
    Reviewed-by: Nathan Chancellor <nathan@kernel.org>
    Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
    Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 1e8b77928fa4..deb7c1d3e979 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -199,6 +199,8 @@ static int compare_extable(const void *a, const void *b)
 	return 0;
 }
 #ifdef MCOUNT_SORT_ENABLED
+pthread_t mcount_sort_thread;
+
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
 	Elf_Shdr *init_data_sec;
@@ -282,10 +284,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int shnum;
 	unsigned int shstrndx;
 #ifdef MCOUNT_SORT_ENABLED
-	struct elf_mcount_loc mstruct;
+	struct elf_mcount_loc mstruct = {0};
 	uint_t _start_mcount_loc = 0;
 	uint_t _stop_mcount_loc = 0;
-	pthread_t mcount_sort_thread;
 #endif
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 	unsigned int orc_ip_size = 0;
