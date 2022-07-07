Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A685756A0D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiGGLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiGGLF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:05:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F072F00D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:05:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j3so6004141pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zTI0bt2hGXniMSOabFtFhfhTaMs/YC0V+EzqH6eZXw=;
        b=LXn5sdpPpDgBpxYruZLrgEgmKOMkrd56ZWQge3eXK4T89PrUHE38kacARLZDn3lzTy
         vgo/a5n4GihYikVq5NHgs5ycps/uX8spRNyTkTdLg4FlTeGrrdhFwo3YldAPmWhfAsVe
         c8O8dUA4XSXFIVbUFuZIPxwLxhzI2ksf4CNW98jKzIw3QHJ4L/OpnOr0rgQZdIXOfEMn
         AhBf8DaqGoLRZJ7eZ816sy68TV3di2ZkgQQsQQQtFgrUE7WZIdYsYoh7KWqm38Gh4bmH
         c0jhNQJqwRMTD79FUtf3PTVuRZ5cXzbmFnrYz321esiWPMrNd4ii/DrrSMuyY4ZSaYSQ
         C1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zTI0bt2hGXniMSOabFtFhfhTaMs/YC0V+EzqH6eZXw=;
        b=2UFa62YnKbnEcuCsIRkR5Out/pvCFPYdNNIIYlsx4TMD5CA+JAz7Y+e8ArHjwGy0y9
         2lxUYCCDkixYgFt7LGbjhZYRJGeZ1uyZigeSepoIuGMbR6Z7ELzW22J9sxO/K9oqaISe
         MLKa+eQOqsGp2jDXnay0FwML67K6ukNevJGrr7tdL0gYGJo+CJ+G9C3TXYrYn15Gntvv
         5QzMszThMjRGwb25mxUe1/yUGldRcO77k68VI7nJJY0HE3z41cNsQ9GED+0hrGsTj0GW
         kKyKxp+tRTK6PEQEXslvthu9uxFOkFYE6eqIIMdeMrQzxBzfuUZej/Z65RCKy6Wwmhub
         QSxA==
X-Gm-Message-State: AJIora+56I8xzvQWajjgmi3FKEhT7W4JAwrOJz9bIqRsFqr0XcJ79V29
        Vw5lioEWAbqQ6k2vRQYSRcgCQA==
X-Google-Smtp-Source: AGRyM1sxN+aNHJVus9UHXFQyxz8R4+HjMydn9pNnpRw3Va5FthFKH7aoBv9YSdrqItmT7/4E9E8gbw==
X-Received: by 2002:a17:902:a388:b0:16b:d52b:a038 with SMTP id x8-20020a170902a38800b0016bd52ba038mr28321674pla.56.1657191956605;
        Thu, 07 Jul 2022 04:05:56 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id 72-20020a62174b000000b005289a50e4c2sm1046403pfx.23.2022.07.07.04.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 04:05:56 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 0/2] arm64: run softirqs on the per-CPU IRQ stack
Date:   Thu,  7 Jul 2022 19:05:09 +0800
Message-Id: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Currently arm64 supports per-CPU IRQ stack, but softirqs are
still handled in the task context.

Since any call to local_bh_enable() at any level in the task's
call stack may trigger a softirq processing run, which could
potentially cause a task stack overflow if the combined stack
footprints exceed the stack's size. And we did encounter this
situation in the real environment:

Call trace:
 dump_backtrace+0x0/0x1cc,
 show_stack+0x14/0x1c,
 dump_stack+0xc4/0xfc,
 panic+0x150/0x2c8,
 panic+0x0/0x2c8,
 handle_bad_stack+0x11c/0x130,
 __bad_stack+0x88/0x8c,
 vsnprintf+0x2c/0x524,
 vscnprintf+0x38/0x7c,
 scnprintf+0x6c/0x90,
 /* ... */
 __do_softirq+0x1e0/0x370,
 do_softirq+0x40/0x50,
 __local_bh_enable_ip+0x8c/0x90,
 _raw_spin_unlock_bh+0x1c/0x24,
 /* ... */
 process_one_work+0x1dc/0x3e4,
 worker_thread+0x260/0x360,
 kthread+0x118/0x128,
 ret_from_fork+0x10/0x18,

So let's run these softirqs on the IRQ stack as well.

This series is based on next-20220705.

Comments and suggestions are welcome.

Thanks,
Qi.

Qi Zheng (2):
  arm64: run softirqs on the per-CPU IRQ stack
  arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK

 arch/arm64/Kconfig                 |  2 ++
 arch/arm64/include/asm/exception.h |  4 +++-
 arch/arm64/kernel/entry-common.c   | 30 ++++++++++++++++++++----------
 arch/arm64/kernel/entry.S          |  6 ++++--
 arch/arm64/kernel/irq.c            | 12 ++++++++++++
 5 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.20.1

