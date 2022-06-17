Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9329954EEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379579AbiFQBl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQBlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92B7963BC9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655430113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/DD/JbIqyCltKPwmfzhCpkXevQRYLJ0ZJFcUAJ03F54=;
        b=N8cuFGBcvKhKM8QMGhOn0sdq0k6ArxHGjmfN1wIIBImRNmNdu06Im3xYLEvnDQX87Jbfvd
        aWXD15GVvKw9b0S5rt2+xaq+6J4K1iyJdrx0yEACiY+M6iqNv+VtZyPqX3xDdAiDfZDPf8
        NgQFB8LgNPK0O2s0e+djdQstY2rEcn8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-TVSti-rFPyazRZJ-JWuURw-1; Thu, 16 Jun 2022 21:41:51 -0400
X-MC-Unique: TVSti-rFPyazRZJ-JWuURw-1
Received: by mail-io1-f70.google.com with SMTP id r76-20020a6b2b4f000000b00669b75529e5so1747322ior.16
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/DD/JbIqyCltKPwmfzhCpkXevQRYLJ0ZJFcUAJ03F54=;
        b=sjv/re5Y0hJmVkoJQYpt1wNl0xsyxQ+PxxR1QYMtTYZT19zhT2c8nmo6b6gTyX4/FW
         fdXhdABlH7gseIaPv/i1V1TMZdzNnbIzRHew+rXyT2GXZX1oTbOniF9EtrWPmzkNNulg
         Tdwda+EmmfbHI0jj74yDjzYx3JbS1xNM1VYBIuoofKk2hOxdr6/sWyaZoEPXJD1o5Uqj
         rhTjHyDdJowSDT9CB3sp2iq2+Y7W0cOP9iMSTeZVBf0w9RQH6I+7vf1/nWRFp0ZJDghb
         RTq9nlkNZnB/aecPEiVvNcMFAdjutY4ID4ogpoBmo4BP4cdVYTb5gX3X1o279AKCK2V1
         zB4Q==
X-Gm-Message-State: AJIora/8msAjbGFtRyMVA1jA0gzMVmJvKi9jqGWxBpUPdpvRuZwX7K1r
        Ua4x1n1iD+/k9FZX8VFNHTgAGoaYO4yRu7PESD8MpJDmD+MCUsQRjmUXSYhMfJ8jTeZe02oJ/V/
        2cEPofTeCGRtHvEZB4rLe+7X7
X-Received: by 2002:a05:6e02:f4f:b0:2d8:c9b1:d7b0 with SMTP id y15-20020a056e020f4f00b002d8c9b1d7b0mr4409629ilj.99.1655430111108;
        Thu, 16 Jun 2022 18:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtH1fB1CTBTIxUDTUJnGxdyhGmr8yEs3Uk7gUcYkCtiqMAyVuKyZ5em+h2G7ONgFzOt+7eaw==
X-Received: by 2002:a05:6e02:f4f:b0:2d8:c9b1:d7b0 with SMTP id y15-20020a056e020f4f00b002d8c9b1d7b0mr4409616ilj.99.1655430110891;
        Thu, 16 Jun 2022 18:41:50 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id n4-20020a056e02140400b002d522958fb4sm1726538ilo.2.2022.06.16.18.41.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jun 2022 18:41:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com
Subject: [PATCH RFC 0/4] kvm/mm: Allow GUP to respond to non fatal signals
Date:   Thu, 16 Jun 2022 21:41:43 -0400
Message-Id: <20220617014147.7299-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Marked as RFC for now]

One issue was reported that libvirt won't be able to stop the virtual
machine using QMP command "stop" during a paused postcopy migration [1].

It won't work because "stop the VM" operation requires the hypervisor to
kick all the vcpu threads out using SIG_IPI in QEMU (which is translated to
a SIGUSR1).  However since during a paused postcopy, the vcpu threads are
hang death at handle_userfault() so there're simply not responding to the
kicks.  Further, the "stop" command will further hang the QMP channel.

The mm has facility to process generic signal (FAULT_FLAG_INTERRUPTIBLE),
however it's only used in the PF handlers only, not in GUP. Unluckily, KVM
is a heavy GUP user on guest page faults.  It means we won't be able to
interrupt a long page fault for KVM fetching guest pages with what we have
right now.

I think it's reasonable for GUP to only listen to fatal signals, as most of
the GUP users are not really ready to handle such case.  But actually KVM
is not such an user, and KVM actually has rich infrastructure to handle
even generic signals, and properly deliver the signal to the userspace.
Then the page fault can be retried in the next KVM_RUN.

This patchset added FOLL_INTERRUPTIBLE to enable FAULT_FLAG_INTERRUPTIBLE,
and let KVM be the first one to use it.

Tests
=====

I created a postcopy environment, pause the migration by shutting down the
network to emulate a network failure (so the handle_userfault() will stuck
for a long time), then I tried three things:

  (1) Sending QMP command "stop" to QEMU monitor,
  (2) Hitting Ctrl-C from QEMU cmdline,
  (3) GDB attach to the dest QEMU process.

Before this patchset, all three use case hang.  After the patchset, all
work just like when there's not network failure at all.

Please have a look, thanks.

[1] https://gitlab.com/qemu-project/qemu/-/issues/1052

Peter Xu (4):
  mm/gup: Add FOLL_INTERRUPTIBLE
  kvm: Merge "atomic" and "write" in __gfn_to_pfn_memslot()
  kvm: Add new pfn error KVM_PFN_ERR_INTR
  kvm/x86: Allow to respond to generic signals during slow page faults

 arch/arm64/kvm/mmu.c                   |  5 ++--
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  5 ++--
 arch/powerpc/kvm/book3s_64_mmu_radix.c |  5 ++--
 arch/x86/kvm/mmu/mmu.c                 | 19 ++++++++----
 include/linux/kvm_host.h               | 21 ++++++++++++-
 include/linux/mm.h                     |  1 +
 mm/gup.c                               | 33 ++++++++++++++++++---
 virt/kvm/kvm_main.c                    | 41 ++++++++++++++++----------
 virt/kvm/kvm_mm.h                      |  6 ++--
 virt/kvm/pfncache.c                    |  2 +-
 10 files changed, 104 insertions(+), 34 deletions(-)

-- 
2.32.0

