Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D094C3552
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiBXTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiBXTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:06:43 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77A1E6947
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:06:12 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id f2-20020a17090a4a8200b001b7dac53bd6so1650430pjh.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=tRTyWoUT8Z4OzVC5lunrsGHroBV40dUXZgGF7XBnc+Q=;
        b=V+Ie7+FLqApLIKyEME7fNXxMFvv90VU40vDpm/F0pt8qL1M+87C5HjaSfRwk0sce8w
         NM1xuxTR36n7WwPFMIov8O+AiRVQOaWT02iWE/ZNfbsB0IMc70Pk4F/T/grXXc5K6EPp
         W+vSd877CAKLqIMdPmBCx4zIdB6/L4BPqt2f0eJYOMO9ZMSrsHyh2JPLrHjTjBWbaZCO
         xO4tAA1vJe8zBB3iXjsaJql0c16ekfjP18VVXriAhCkehNJmmigligE6IXLNie2+IToa
         qv2pet9dUhx+K4bEl33ybHn+Co6Xai1sSPlL4qH5x8XZ/jtk2QzsVSYiEbY+xHWfv+AQ
         Cxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=tRTyWoUT8Z4OzVC5lunrsGHroBV40dUXZgGF7XBnc+Q=;
        b=qRL4a+nyYHBcgwtuiItbvUqJ8vtzGtBrjklhLpqypfalDMOiJxCNVtx+5nhh2HGc4m
         aQg3iZu4polKqzwQPqY+Dtvy1X0sEYquwuwKHuCIzJaGQkF8S4FxBCMpQ3hzUXINmtYR
         PJq56K/3r/NIXNtmqR99ni7JbIwzOqfbDD8xzuWWAzAHF9/3f/bmLU0OlgF51ryHg05c
         WkoN6ryDvsO9g2VgFnJ+QJgiiW6fQ2gbzymQpMTjgBIo1KX0OZLvLXbvyaot5Z5ConJ6
         5ZWBbKrbCS5Dxv6+4ijeImGmMF5DOcwndIcnZ7lEmpKD9oTPPkpP3I4/oz/7io7oAsrY
         mKQQ==
X-Gm-Message-State: AOAM533G4y3BBKwbfcFhifIKS2cAW1E7PN8Zj+teEO10aLg/Z5XpynSx
        N/IQXcIo0XMl1e6ytxnVtWsl9Jh4VBw=
X-Google-Smtp-Source: ABdhPJzxFG1H7KLUQjomyBBRfDT+45ps1ISZ/nCH4k3y1lheY9PjUzqXyEcY3ZmMH8Qn1wDGTsujYhqwjy4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2b0d:b0:1b5:8087:4b4e with SMTP id
 x13-20020a17090a2b0d00b001b580874b4emr4198507pjc.70.1645729572011; Thu, 24
 Feb 2022 11:06:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 24 Feb 2022 19:06:09 +0000
Message-Id: <20220224190609.3464071-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] KVM: x86: Reacquire kvm->srcu in vcpu_run() if exiting on
 pending signal
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reacquire kvm->srcu in vcpu_run() before returning to the caller if srcu
was dropped to handle pending work.  If the task receives a signal, KVM
will exit without reacquiring kvm->srcu, resulting in an unbalanced
unlock kvm_arch_vcpu_ioctl_run(), and eventually hung tasks.

 =====================================
 WARNING: bad unlock balance detected!
 5.17.0-rc3+ #749 Not tainted
 -------------------------------------
 CPU 0/KVM/1803 is trying to release lock (&kvm->srcu) at:
 [<ffffffff81042a19>] kvm_arch_vcpu_ioctl_run+0x669/0x1f60
 but there are no more locks to release!

 other info that might help us debug this:
 1 lock held by CPU 0/KVM/1803:
  #0: ffff88810489c0b0 (&vcpu->mutex){....}-{3:3}, at: kvm_vcpu_ioctl+0x77/0x690

 stack backtrace:
 CPU: 7 PID: 1803 Comm: CPU 0/KVM Not tainted 5.17.0-rc3+ #749
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x34/0x44
  lock_release+0x1b4/0x240
  kvm_arch_vcpu_ioctl_run+0x680/0x1f60
  kvm_vcpu_ioctl+0x279/0x690
  __x64_sys_ioctl+0x83/0xb0
  do_syscall_64+0x3b/0xc0
  entry_SYSCALL_64_after_hwframe+0x44/0xae
  </TASK>
 INFO: task stable:2347 blocked for more than 120 seconds.
       Not tainted 5.17.0-rc3+ #749
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:stable          state:D stack:    0 pid: 2347 ppid:  2340 flags:0x00000000
 Call Trace:
  <TASK>
  __schedule+0x328/0xa00
  schedule+0x44/0xb0
  schedule_timeout+0x26f/0x300
  wait_for_completion+0x84/0xe0
  __synchronize_srcu.part.0+0x7a/0xa0
  kvm_swap_active_memslots+0x141/0x180
  kvm_set_memslot+0x2f9/0x470
  kvm_set_memory_region+0x29/0x40
  kvm_vm_ioctl+0x2c3/0xd70
  __x64_sys_ioctl+0x83/0xb0
  do_syscall_64+0x3b/0xc0
  entry_SYSCALL_64_after_hwframe+0x44/0xae
  </TASK>
 INFO: lockdep is turned off.

Fixes: 5d8d2bfc5e65 ("KVM: x86: pull kvm->srcu read-side to kvm_arch_vcpu_ioctl_run")
Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e55de9b48d1a..6de4d810f5b2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10281,9 +10281,10 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 		if (__xfer_to_guest_mode_work_pending()) {
 			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 			r = xfer_to_guest_mode_handle_work(vcpu);
+			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
+
 			if (r)
 				return r;
-			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 		}
 	}
 

base-commit: 991f988b43c5ee82ef681907bfe979bee93a55c2
-- 
2.35.1.574.g5d30c73bfb-goog

