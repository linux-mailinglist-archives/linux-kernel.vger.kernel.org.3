Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B156B608
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiGHJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbiGHJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:50:19 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8783F07
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:50:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s206so21940976pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vdi/B2mPTnCMyO8HGcEgE0ipigaIaniIRr1AKwKskEA=;
        b=BWLI9FKAbTKydGoq1piX23lQ9ZpccEkEkE2A6rJmGmxGtChFUxhjRdQNw/rKHxLDK1
         TrM9pd+l9h9AzZCgUC3hR2gg9gEXPP/RzbR0gfg5o3zdA7EzXHbLYos+sjX0nItakXd/
         2OUR0tx93irPrRZt69XIPqj2ewMDkftngms5vLJ05fmNTb7WfKx68hnnNT+nBOhPcE7M
         TMkEBrMAjz9GAJTHEFr3rf0S7pPL1cY68qOgMngdLsYZOMibOO4kenk0kzyPa0ZcKV9/
         QdHLP8ZF+QGqLJBccYGVEoUInwLTXcOiHKt/ZOtvDsCBWml2TEn7UyMF097VN5VZrdu9
         dmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vdi/B2mPTnCMyO8HGcEgE0ipigaIaniIRr1AKwKskEA=;
        b=G0rsz4BEu6wAABUYLrO7oK1H55zSvqtgIM6ZOn4HW7zdpD7yb+tXPOsbdCG9IqF8ox
         fUE5DW9V5MDQqpzgcjTAuDfEh/jjyXeCbD/iCRbnHyGOkDC0Ms/b1rubEfuBLPP/W2QN
         YtdDtwQy6uUKJzI2YT7kBcVpFhROqDCT6UCPHI17YX9jJQ8h68vdLQ9g93hb2bkH0bZh
         hIl8P78D17dNQ8n9c1zAH+CeynBVRshQk4ysFa3V0KfOsliRdl7vu/HtuxLHjbdnudMi
         dJV9U86fboKD21hAFP2Ie1SLXbaduWHdN37VfunMIWFttqH6tQF+W52DPocU1PH3ocgJ
         5jhQ==
X-Gm-Message-State: AJIora9fCofTu/iGq9kzuRDrvix5Pc2lgY9lVk2vHh5//HXCfGus9x0V
        mQOaIoLgub7IK092+sFRaxsNUg==
X-Google-Smtp-Source: AGRyM1vF+zH4lZrtoJ7jB7vsYOWYxkq1zWz7B1qlwvoC3q+R6Fujt0ziY4BVzrI6ISDr2dbYcCdlpQ==
X-Received: by 2002:aa7:9985:0:b0:528:d798:1de2 with SMTP id k5-20020aa79985000000b00528d7981de2mr2877131pfh.84.1657273813593;
        Fri, 08 Jul 2022 02:50:13 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id c18-20020a621c12000000b0051bbd79fc9csm28551035pfc.57.2022.07.08.02.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 02:50:12 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 0/2] arm64: run softirqs on the per-CPU IRQ stack
Date:   Fri,  8 Jul 2022 17:49:48 +0800
Message-Id: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
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

This series is based on next-20220707.

Comments and suggestions are welcome.

Thanks,
Qi

RFC: https://lore.kernel.org/lkml/20220707110511.52129-1-zhengqi.arch@bytedance.com/

Changelog in RFC -> v1:
 - fix conflicts with commit f2c5092190f2 ("arch/*: Disable softirq stacks on PREEMPT_RT.")

Qi Zheng (2):
  arm64: run softirqs on the per-CPU IRQ stack
  arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK

 arch/arm64/Kconfig                 |  2 ++
 arch/arm64/include/asm/exception.h |  4 +++-
 arch/arm64/kernel/entry-common.c   | 30 ++++++++++++++++++++----------
 arch/arm64/kernel/entry.S          |  6 ++++--
 arch/arm64/kernel/irq.c            | 14 ++++++++++++++
 5 files changed, 43 insertions(+), 13 deletions(-)

-- 
2.20.1

