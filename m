Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73594504918
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiDQS7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiDQS7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:59:34 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6D35872;
        Sun, 17 Apr 2022 11:56:58 -0700 (PDT)
Received: from integral2.. (unknown [36.80.217.41])
        by gnuweeb.org (Postfix) with ESMTPSA id 541C97E3A7;
        Sun, 17 Apr 2022 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1650221817;
        bh=7LFtGbhJbighgt3Hy6I4fjCFUJTyU1XHUYCcmQ99z5k=;
        h=From:To:Cc:Subject:Date:From;
        b=CS1UwVGqQaSu3kT/Hx6P0TMbc++/EvzQykt2eiqjRW68QxPkbWS6ss9mz+uQLigGN
         dVuRvhzg3OLZRlpdVMjQM5wBdPpWqAuR2XYdDYEbTArq6xMSBvgGsB0EjYzdWmPxBA
         nLUMNJlbfVPWvANFK3wFQ5A91zIeVHkFlDThgRzRl0CKrM1b6HKoenWP+YpOw6hZ++
         zHmYtHN4S/c6ZFSSoBKctvpeKF+8fNoHrO3Ccs9ObfbgkJswBkkggT38OynouDfcBR
         y+9zCNGpUf7cSeXBSeYPDKw5b0slyoKMsavR1TW6u41/yYnm8g3MFI7q0STptkjA4l
         nr0j61AYsF9PQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Trace Devel Mailing List 
        <linux-trace-devel@vger.kernel.org>
Subject: [RESEND PATCH 0/2] Two tracing patches for trace_events_hist.c
Date:   Mon, 18 Apr 2022 01:56:28 +0700
Message-Id: <20220417185630.199062-1-ammarfaizi2@gnuweeb.org>
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

[ Sorry, this is a resend, I sent it to the wrong address of trace devel list. ]

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

