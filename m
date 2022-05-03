Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7361517F10
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiECHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiECHmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:42:36 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB436E00
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:39:04 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id oz9-20020a1709077d8900b006f3d9488090so6592013ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kkO/dWNNM89/72XXalUPVAWHtnC41R6OkxWseT3mGWc=;
        b=WL2UUkfwdO4ryCSUjlBASSUUnvZKapCEcsX+VvrGnegVID9LMxsVuW9BOvNZPNWkDk
         FDwPjNWGyvEXEXJPZzWNC7c7hm2J0Vx3TqzLM4mGqbrh9V8nuwEgwzcYbmSFHKF3YPJb
         h5ptQYmYzK6nTNWIl0RPfcaPrFXnkK9klxhTYl+9xDIA5WTHLwzVDg108qPEMRyeGtnY
         69YQcozUbZzyHxvW3/4nC0zS1cHfLUXMpflberIk7dO6m/SuK1AbADuej0beiO/1fOmH
         7AN0GchogfSjBBFm8KGf9ELvmtVCm8iu/xmsRcxCBqQT9ZvsWuz44Gs0hQ0DKQDAE7wG
         bPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kkO/dWNNM89/72XXalUPVAWHtnC41R6OkxWseT3mGWc=;
        b=D2GHlLahd2Ah9y+TqP/DPArNTHhS9GcfP/UEwmgJzZuscDILMDB4jIStCB/JmfodRS
         bHsphRqZCxDnDzAbxqjxjlY0cdx6NJCNzefEIsqOJNFlBegfhzeSgB+/xgmNJ527v/fS
         4+7ewYb6IcAKspdKMXiwfEsu6cSBe0DbfmABt0uZqtkiIJtb2dTuTJ7JUlKc1KiA6qkd
         7PxqieHQ1xLH1cGKpc2C5jBmS8LUEFUS+KyQZ011chWLd5LxENG+b007Eeil3VZvRDO4
         o9ZupSuYeRGT+D8WHhKEIfSjVhSL2/rbUCmtjB3AxgDMR7XPwa4Lsj/39l500sXL9Xkz
         1KsQ==
X-Gm-Message-State: AOAM532x15+m3r2LbrhDk7gU0xWu3xRqrLN8wAYzfNc+RaAKztCRaiW6
        Xq0xDHBh4cJSviIlH0P++QlK2wvcxQ==
X-Google-Smtp-Source: ABdhPJxeO1zyPodRfmBHxGs6rYL5rBGDNvjmJEK8vxYLBT6/K84BO/kGdkC4+Y8EJ44e5r/dCB29jHmNlw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:bdb8:d8d3:6904:292f])
 (user=elver job=sendgmr) by 2002:a17:906:c0e:b0:6f0:2b1e:9077 with SMTP id
 s14-20020a1709060c0e00b006f02b1e9077mr14448413ejf.411.1651563542771; Tue, 03
 May 2022 00:39:02 -0700 (PDT)
Date:   Tue,  3 May 2022 09:38:44 +0200
Message-Id: <20220503073844.4148944-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH -printk] printk, tracing: fix console tracepoint
From:   Marco Elver <elver@google.com>
To:     elver@google.com, John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original intent of the 'console' tracepoint per 95100358491a
("printk/tracing: Add console output tracing") had been to "[...] record
any printk messages into the trace, regardless of the current console
loglevel. This can help correlate (existing) printk debugging with other
tracing."

Petr points out [1] that calling trace_console_rcuidle() in
call_console_driver() had been the wrong thing for a while, because
"printk() always used console_trylock() and the message was flushed to
the console only when the trylock succeeded. And it was always deferred
in NMI or when printed via printk_deferred()."

With 09c5ba0aa2fc ("printk: add kthread console printers"), things only
got worse, and calls to call_console_driver() no longer happen with
typical printk() calls but always appear deferred [2].

As such, the tracepoint can no longer serve its purpose to clearly
correlate printk() calls and other tracing, as well as breaks usecases
that expect every printk() call to result in a callback of the console
tracepoint. Notably, the KFENCE and KCSAN test suites, which want to
capture console output and assume a printk() immediately gives us a
callback to the console tracepoint.

Fix the console tracepoint by moving it into printk_sprint() [3].

One notable difference is that by moving tracing into printk_sprint(),
the 'text' will no longer include the "header" (loglevel and timestamp),
but only the raw message. Arguably this is less of a problem now that
the console tracepoint happens on the printk() call and isn't delayed.

Link: https://lore.kernel.org/all/Ym+WqKStCg%2FEHfh3@alley/ [1]
Link: https://lore.kernel.org/all/CA+G9fYu2kS0wR4WqMRsj2rePKV9XLgOU1PiXnMvpT+Z=c2ucHA@mail.gmail.com/ [2]
Link: https://lore.kernel.org/all/87fslup9dx.fsf@jogness.linutronix.de/ [3]
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Marco Elver <elver@google.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f66d6e72a642..a3e1035929b0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2064,8 +2064,6 @@ static void call_console_driver(struct console *con, const char *text, size_t le
 {
 	size_t dropped_len;
 
-	trace_console_rcuidle(text, len);
-
 	if (con->dropped && dropped_text) {
 		dropped_len = snprintf(dropped_text, DROPPED_TEXT_MAX,
 				       "** %lu printk messages dropped **\n",
@@ -2240,6 +2238,8 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 		}
 	}
 
+	trace_console_rcuidle(text, text_len);
+
 	return text_len;
 }
 
-- 
2.36.0.464.gb9c8b46e94-goog

