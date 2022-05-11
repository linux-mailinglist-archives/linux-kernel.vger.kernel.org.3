Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEF7522FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiEKJrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiEKJq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:46:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A112B1B9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:46:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g16so1878047lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=WHZoD4vvX9VyNiaR95wWgtu4Xn3fEVjHGLKQ6WEC6Eg=;
        b=g9SsvUoB+GmiIOh0IKTIcEseW9w4TeMEkNh+KjPytdfqUo2MV/bSDsAGbgdGOhBoWU
         Ttu7o4qLG2nkA8A2g7AcZbRkTERO3MZdkv1hhD+mWxK426uKRHv/OkrKUO4gjrdyh8Pm
         XIpBhRXa4Hr8/UYhW3jbR5mIgg6hmtK5l98oDTQJk+auR4D+BwmBkhvT8J9eBaaZHCbM
         bzC7DHTrJM4kZTEMKL3CBeM+zNtVtimCM2TQzCeYNzzIgBcSnRUfPKku9ahhNIPlwFzU
         6KFWklX7985o5S9GmmIu/AB7E3UyGS0FPV1tzNJPCLqaBfp+xu5INiPSxRnYL7fQ0jvg
         K0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=WHZoD4vvX9VyNiaR95wWgtu4Xn3fEVjHGLKQ6WEC6Eg=;
        b=5EEwHl+ULGcc4HwkfDsxZvfFZL8+mOJOnU1rOVEQTZUCFuOsMMKNaTV/UpmyIgY3LA
         VFqI4vMbZiykkGjdnE92150qCO3+obO1mUREp4WxAC6NpWMPw9g/P+Chs4Uln6AT42d8
         pzYz14W0uRb2557QzFQuCLUVnMWg23DpPkxqO8axO1K5AJ16z/p3nAwSNDMYY8V55lMW
         82+TJyfyy9l1S0Sf0gW32V12ck3gWbh7A5SoPFu6ocEbYnnhyQb7Wdbhs+nsGMQ/AM5f
         OJ2EgxBzelUYasqObTDTQjUOkaEskgHemd7IYDHyJQnqlEfsW9uiYFJbE8Ss3k+9wV8J
         Vcqw==
X-Gm-Message-State: AOAM531jTj4tE6Cuq93l6DyCqXZYY4nE3yWgrzFs/jhoNC5yZ+6wViOW
        bodzgy24FmG7FB00lwrnRsswOw==
X-Google-Smtp-Source: ABdhPJwDmbG/i31cIlNcRD643zqDl0e/auWZDPj7LFoRorbOkHNQ7Qq1FedY4a9/lJLQF14gpv7tcg==
X-Received: by 2002:a2e:8e84:0:b0:24f:1d40:ceb0 with SMTP id z4-20020a2e8e84000000b0024f1d40ceb0mr17007899ljk.292.1652262415349;
        Wed, 11 May 2022 02:46:55 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id q6-20020a05651232a600b0047255d210d5sm206379lfe.4.2022.05.11.02.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 02:46:54 -0700 (PDT)
Message-ID: <e85d7ff2-fd10-53f8-c24e-ba0458439c1b@openvz.org>
Date:   Wed, 11 May 2022 12:46:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm] tracing: incorrect isolate_mote_t cast in
 mm_vmscan_lru_isolate
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes following sparse warnings:

  CHECK   mm/vmscan.c
mm/vmscan.c: note: in included file (through
include/trace/trace_events.h, include/trace/define_trace.h,
include/trace/events/vmscan.h):
./include/trace/events/vmscan.h:281:1: sparse: warning:
 cast to restricted isolate_mode_t
./include/trace/events/vmscan.h:281:1: sparse: warning:
 restricted isolate_mode_t degrades to integer

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 include/trace/events/vmscan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 408c86244d64..d2123dd960d5 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -297,7 +297,7 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__field(unsigned long, nr_scanned)
 		__field(unsigned long, nr_skipped)
 		__field(unsigned long, nr_taken)
-		__field(isolate_mode_t, isolate_mode)
+		__field(unsigned int, isolate_mode)
 		__field(int, lru)
 	),
 
@@ -308,7 +308,7 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__entry->nr_scanned = nr_scanned;
 		__entry->nr_skipped = nr_skipped;
 		__entry->nr_taken = nr_taken;
-		__entry->isolate_mode = isolate_mode;
+		__entry->isolate_mode = (__force unsigned int)isolate_mode;
 		__entry->lru = lru;
 	),
 
-- 
2.31.1

