Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4CB51ACCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376933AbiEDScx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376823AbiEDScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:32:39 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D915A163
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:08:42 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r1so1974666oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+H552I4GIPi5L5ZDmVgN+SQqrGNNUqdTynrkxAEOZ0E=;
        b=cxf6O0u8k7lflkwx23uuKJ05bXK92eRzLDF7Puf2ZoxNvdK+t4XDXH+ajQDF5mt2hH
         KpnsKpQrNoSp37QgP6ZT3jOkCi7ZtMDbJ4Isx4e8F4WJGaCfIfuibfTyiuI9HTnoHVwi
         uCr1JAnKtg2qP11jSTkrgXVLSMQwsZijPPbWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+H552I4GIPi5L5ZDmVgN+SQqrGNNUqdTynrkxAEOZ0E=;
        b=WYjzJptJTezIG2mstzGJtrwMUhHFsU8lZFmdKM7zTjKRIYOKbLboljLn9/DcOdR4tY
         4u5boptew418/NedQMht53INXD8fEeVGBK5rdN+hO7sandRS/1ff9cS9+0zhApiJM2Gq
         WJe1mLLH0QzM7/RFsWx3LwMrY4dV/SCNEPDhuprMJnLWDfqcPF6ssbJ9Rx3PmFUo5Yjw
         W9ZJRw0PSLgWDV+3VnN6+uM0t/4xdtihVSzZRhoEnqDMdklwJ2Bqa8Qq8wAMzNP/gNwx
         9B8TmKgF1SxsZC5a9aGIjwgbs68pjacSVKRv0Lu+sPYNwJ7+bLII8vg/GvQfNt9Jiq8t
         MouQ==
X-Gm-Message-State: AOAM531UuSwR6rVtjrYbHTY7ZAUb4dpyEYpZPJU+aBCzEyCVcAx0PqAG
        W8URyoq3FMnXLWmX76m4fiCu+g==
X-Google-Smtp-Source: ABdhPJxJY1BcSSKsOcZVuE9EpZNIp3RAdg7UXIrlPjSqfxaibA4ryPHEEJzmAuyY80pqd+hpwrMw7Q==
X-Received: by 2002:a05:6808:1385:b0:325:efe5:b340 with SMTP id c5-20020a056808138500b00325efe5b340mr320442oiw.249.1651687721511;
        Wed, 04 May 2022 11:08:41 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:373b:a889:93d6:e756])
        by smtp.gmail.com with ESMTPSA id g2-20020a056870a70200b000e686d1389esm8061243oam.56.2022.05.04.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 11:08:41 -0700 (PDT)
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, kvm@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] entry/kvm: Exit to user mode when TIF_NOTIFY_SIGNAL is set
Date:   Wed,  4 May 2022 13:08:40 -0500
Message-Id: <20220504180840.2907296-1-sforshee@digitalocean.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A livepatch transition may stall indefinitely when a kvm vCPU is heavily
loaded. To the host, the vCPU task is a user thread which is spending a
very long time in the ioctl(KVM_RUN) syscall. During livepatch
transition, set_notify_signal() will be called on such tasks to
interrupt the syscall so that the task can be transitioned. This
interrupts guest execution, but when xfer_to_guest_mode_work() sees that
TIF_NOTIFY_SIGNAL is set but not TIF_SIGPENDING it concludes that an
exit to user mode is unnecessary, and guest execution is resumed without
transitioning the task for the livepatch.

This handling of TIF_NOTIFY_SIGNAL is incorrect, as set_notify_signal()
is expected to break tasks out of interruptible kernel loops and cause
them to return to userspace. Change xfer_to_guest_mode_work() to handle
TIF_NOTIFY_SIGNAL the same as TIF_SIGPENDING, signaling to the vCPU run
loop that an exit to userpsace is needed. Any pending task_work will be
run when get_signal() is called from exit_to_user_mode_loop(), so there
is no longer any need to run task work from xfer_to_guest_mode_work().

Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
---
 kernel/entry/kvm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 9d09f489b60e..2e0f75bcb7fd 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -9,12 +9,6 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		int ret;
 
 		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
-			clear_notify_signal();
-			if (task_work_pending(current))
-				task_work_run();
-		}
-
-		if (ti_work & _TIF_SIGPENDING) {
 			kvm_handle_signal_exit(vcpu);
 			return -EINTR;
 		}
-- 
2.32.0

