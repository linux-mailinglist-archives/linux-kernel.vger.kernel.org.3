Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149FE4EB1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbiC2Qlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiC2Qld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:41:33 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718F0D0A93
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:39:50 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l129so6788385pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7X/SW5dIcuJorsyWOPkH3Xc7Hk0RJcObO8ZrXId3WA=;
        b=NH1roOSch+YoOEXaWKIzmOxBveJHFdm8/dml59eyNfbL9DmO41sZnWUHuxHOgdx1RA
         u0lG04RD6VNEBhhdLiXas/UJeZUiOkWXVGysAzNhgarG+UvvHKo+wON6vz9m51NEbVqo
         FdZTPuTeyi3GesCkEV83IM5GKgRl6Q5gh4z6o6GaJYzS4EvljEO6B7Wb7QKR0xD50xnm
         L2sF2cyyC3gd3klBTzq657dbwAILZuf7IeeMmqzGYYgwWEdNDbIU8JMOhymR0AKX/Aqj
         CdWiL/tkZzoynmszcdTdG0A8TTh/wUVYyI2mNuX8vlP4wTRW8e8bpNYEUD3yFbeAdJMC
         rubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7X/SW5dIcuJorsyWOPkH3Xc7Hk0RJcObO8ZrXId3WA=;
        b=LrLZvlvP8d4qA+mUzL2kLLgx1Sa+KjEmwV/2mSc4t8qc1GOAQviBOTEhc/VdddMFHj
         cUsjqLRhyCOQr7fR4/sb3ti3GZTY7rkvQXPQBDUDqH2LwQpiEpdOlXaNwxsDju1FZMGM
         zIQGJZpZXOXeHog4W8lIxY7S3Phi/aT8T5CUwBtwYpZGREDZLU8diMursOyfdesCCXqQ
         5CVOFFSSMPCTqig5lGso+h28HGeDeRdd+7utPsZ2C159V+qHesXRPqXEgLExRzfMGwGG
         GDXtPKBZY++qycZXUEznjGseWvBIXQshcaYNQbFdQafiWnPMx8PFgS+/DXbuhSSyzlkH
         LHOg==
X-Gm-Message-State: AOAM530HZV+RfpvF0yOOHOTjLBZjsL7FdHb+LMorg9Ourx00rThbiwHf
        C/CqEGgF39ZbtmzDCznQtII=
X-Google-Smtp-Source: ABdhPJzMGlZcJFn1ySAiNV9AlQxwM0Xt0xfmAn2dGlv33qUTU+6q7vCn6/uO48y1A2pLgypzpr8IMw==
X-Received: by 2002:a62:e213:0:b0:4fa:6b13:3a9a with SMTP id a19-20020a62e213000000b004fa6b133a9amr29012514pfi.18.1648571990008;
        Tue, 29 Mar 2022 09:39:50 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a178700b001c97d3614e5sm3382093pja.33.2022.03.29.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:39:48 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH 0/3] tracing: make tp_printk work on syscall tracepoints
Date:   Wed, 30 Mar 2022 00:39:28 +0800
Message-Id: <20220329163931.710555-1-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the tp_printk option has no effect on syscall tracepoint.
When adding the kernel option parameter tp_printk, then:

echo 1 > /sys/kernel/debug/tracing/events/syscalls/enable

When running any application, no trace information is printed on the
terminal.

Now added printk for syscall tracepoints.

Jeff Xie (3):
  tracing: make tracepoint_iter_lock public
  tracing: make tracepoint_printk_key public
  tracing: make tp_printk work on syscall tracepoints

 kernel/trace/trace.c          |  4 ++--
 kernel/trace/trace.h          |  2 ++
 kernel/trace/trace_syscalls.c | 25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.25.1

