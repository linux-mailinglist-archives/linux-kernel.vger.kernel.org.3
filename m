Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C4D504913
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiDQS4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiDQS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:56:19 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C133881;
        Sun, 17 Apr 2022 11:53:41 -0700 (PDT)
Received: from integral2.. (unknown [36.80.217.41])
        by gnuweeb.org (Postfix) with ESMTPSA id 513C97E3A7;
        Sun, 17 Apr 2022 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1650221620;
        bh=/kPtSWRc0KtmAGf/TJnNPSFjePQzsOaG0qGy1WYQSwc=;
        h=From:To:Cc:Subject:Date:From;
        b=qaUrhiwTaIgdLI/C6BgvvIrlcalrSWzxBnGlKryTRy+8NZnLMICyybwIPK2O51AQC
         3D7+nyyiwIAyuynogmqbBlpNCjCv+n1JN9weRKSgUmZ/mMhf2pi+MJ+SGYL3Z5+0Hf
         tRe9+42p2D8aOQQflhBA4rG7AvQuWFLYcTOi92BtT/e7T1OE9CpTvCM9+f52KJ7Ab8
         r2sm4nDRZ/GcTrCNU5b7VkEj8XYzNrkeW6plFex/8Gfs8zgillgO+v2rRf30l/jwnq
         S3ltzXLTt/96dVaz3nEIQbH/28tR48TVE+Fu5JlGSrKcdHvuLiEeL4v8IhTCYp8Nj6
         OLcqWI0sVjlSw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Trace Devel Mailing List 
        <llinux-trace-devel@vger.kernel.org>
Subject: [PATCH 0/2] Two tracing patches for trace_events_hist.c
Date:   Mon, 18 Apr 2022 01:53:21 +0700
Message-Id: <20220417185323.198034-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Two patches here.

## Patch 1
If `WARN_ON(!glob)` is ever triggered, we will still continue executing
the next lines. This will trigger the more serious problem, a NULL
pointer dereference bug. Just return -EINVAL if @glob is NULL.

## Patch 2
Change `if (strlen(glob))` to `if (glob[0])`. No need to traverse to
the end of string. If the first byte is not a NUL char, it's
guaranteed `if (strlen(glob))` is true.


Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (2):
  tracing: Return -EINVAL if WARN_ON(!glob) triggered in event_hist_trigger_parse()
  tracing: Change `if (strlen(glob))` to `if (glob[0])`

 kernel/trace/trace_events_hist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: a1901b464e7e3e28956ae7423db2847dbbfb5be8
-- 
Ammar Faizi

