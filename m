Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93458CE4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbiHHTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244208AbiHHTGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:06:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3038BA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:06:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id l24so7856037ion.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csp-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DfkYWLinzITcd/FJI51hf3bH49wjjl87W/fTyl+XXYA=;
        b=KnuCUT3+QBXT0EVXP+LbdiSG5CLJ3zJmeNDuR+4pqdnGPgyDrAg7SnOg8S1imSdBkf
         MtLWzaleN9Zvz8IwTnM4do1QofcWTqe8Jq2AMdRxO3aRnWuEH/Eu6rcGWyweC0GZQ4nb
         kU433WHsLh3X0wXBa9p01pHjHYZpDMocJkCxizLpVE0Sduc+GWzWGH0chtieR7/BDp0D
         cijh+MCJGYfQnXcdnARpuNT25CsPPeoklFEuhrA44f6aWpu8F5h4HZeDNymhEvYvA1dg
         Muu9xYQU3NT6ZRwXYPhgg/xRD2lfeILv6lS/N9YWuaTxTyB2wOadymrXSjFdKn7VS6SE
         17Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DfkYWLinzITcd/FJI51hf3bH49wjjl87W/fTyl+XXYA=;
        b=KoL3SCH3VdGSRnhB6wDFRdK4jrW8HGPmlJ7Mg3CtfWD6FZmIGHFQsQyUiy+y2+R5z7
         9J2zzkqa+k3RFb7bCGvSDPrXiw801ROsnfm2sf9/k1RhZ5PThxB8tSmfQkHP3iVigsIs
         HAvHabATDK1LgIqNCX1SwUO82SqqJmYFUIc1k66A/yZ2JiFNvBOaKNPvNRzgDNnyt/aI
         5mXie0l8IZRhBxVjVuDN2t4hM72j16AwHqt+D1+aAXFr4mNrIE7cEj0prHzSa+5fg3JH
         gq//8hli6uHoko9PKOw5xEkLYcWNYLuegkwx0HcNi19RtKf6qeijNtARcwpkH43X4tOs
         DYWw==
X-Gm-Message-State: ACgBeo355CfT024X+FSClgqgJMkjOke3QZevo5DRFJA32oKu5PyvJhOA
        ji/2LqjPIT2POrnpZRamGLW7tg==
X-Google-Smtp-Source: AA6agR4juG/N3jgczX70o0Dl3DOvEQ4/ob1i7PWSjLhiBKoVD/uHlbCBcNDorCHqYK4EVygW1FnuOg==
X-Received: by 2002:a02:238b:0:b0:33f:4ccb:3139 with SMTP id u133-20020a02238b000000b0033f4ccb3139mr8959740jau.20.1659985596901;
        Mon, 08 Aug 2022 12:06:36 -0700 (PDT)
Received: from kernel-dev-1 (75-168-113-69.mpls.qwest.net. [75.168.113.69])
        by smtp.gmail.com with ESMTPSA id c29-20020a02331d000000b003429ee6ca96sm5380638jae.1.2022.08.08.12.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:06:36 -0700 (PDT)
From:   Coleman Dietsch <dietschc@csp.edu>
To:     kvm@vger.kernel.org
Cc:     Coleman Dietsch <dietschc@csp.edu>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        stable@vger.kernel.org,
        syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
Subject: [PATCH v3 1/2] KVM: x86/xen: Initialize Xen timer only once
Date:   Mon,  8 Aug 2022 14:06:06 -0500
Message-Id: <20220808190607.323899-2-dietschc@csp.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for existing xen timers before initializing a new one.

Currently kvm_xen_init_timer() is called on every
KVM_XEN_VCPU_ATTR_TYPE_TIMER, which is causing the following ODEBUG
crash when vcpu->arch.xen.timer is already set.

ODEBUG: init active (active state 0)
object type: hrtimer hint: xen_timer_callbac0
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Call Trace:
__debug_object_init
debug_hrtimer_init
debug_init
hrtimer_init
kvm_xen_init_timer
kvm_xen_vcpu_set_attr
kvm_arch_vcpu_ioctl
kvm_vcpu_ioctl
vfs_ioctl

Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")
Cc: stable@vger.kernel.org
Link: https://syzkaller.appspot.com/bug?id=8234a9dfd3aafbf092cc5a7cd9842e3ebc45fc42
Reported-by: syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
Signed-off-by: Coleman Dietsch <dietschc@csp.edu>
---
 arch/x86/kvm/xen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index a0c05ccbf4b1..6e554041e862 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -713,7 +713,9 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				break;
 			}
 			vcpu->arch.xen.timer_virq = data->u.timer.port;
-			kvm_xen_init_timer(vcpu);
+
+			if (!vcpu->arch.xen.timer.function)
+				kvm_xen_init_timer(vcpu);
 
 			/* Restart the timer if it's set */
 			if (data->u.timer.expires_ns)
-- 
2.34.1

