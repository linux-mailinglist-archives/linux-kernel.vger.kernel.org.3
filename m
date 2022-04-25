Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3E50D653
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 02:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiDYAg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 20:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiDYAgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:36:54 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B16222B2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 17:33:51 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23P0XZ9G079265;
        Mon, 25 Apr 2022 09:33:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 25 Apr 2022 09:33:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23P0XZw6079262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Apr 2022 09:33:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
Date:   Mon, 25 Apr 2022 09:33:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] checkpatch: warn about flushing system-wide workqueues
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
 <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/25 8:45, Joe Perches wrote:
> And it's probably more readable using separate lines and it looks as
> if the 3rd test is unnecessary as it could be combined with the 2nd.
> 
> 		if ($line =~ /\bflush_scheduled_work\s*\(/ ||
> 		    $line =~ /\bflush_workqueue\s*\(\s*system(_\w*)?_wq\s*\)/) {

We don't need to worry about possibility like

	flush_workqueue(system_module1_wq);

? Then, we can simplify like you suggested.

From 06a4c861eed2062ba58c3023ec28b1b3020bd1f8 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 25 Apr 2022 09:28:27 +0900
Subject: [PATCH v2] checkpatch: warn about flushing system-wide workqueues

Flushing the system-wide WQ has possibility of deadlock, for the caller
waits for completion of all works in that WQ even if the caller cannot
wait for completion of one of works due to locking dependency. Since
it is difficult to catch such attempts using lockdep, try to catch also
using checkpatch.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Simplify matching, suggested by Joe Perches <joe@perches.com>

 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e02998701..88491cfcfd59 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7226,6 +7226,13 @@ sub process {
 			     "Deprecated use of '$deprecated_api', prefer '$new_api' instead\n" . $herecurr);
 		}
 
+# check for flushing system-wide workqueues
+		if ($line =~ /\bflush_scheduled_work\s*\(/ ||
+		    $line =~ /\bflush_workqueue\s*\(\s*system(_\w*)?_wq\s*\)/) {
+			ERROR("DEPRECATED_API",
+			      "Flushing system-wide workqueues is dangerous and will be forbidden - see https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236\@I-love.SAKURA.ne.jp\n" . $herecurr);
+		}
+
 # check for various structs that are normally const (ops, kgdb, device_tree)
 # and avoid what seem like struct definitions 'struct foo {'
 		if (defined($const_structs) &&
-- 
2.34.1


