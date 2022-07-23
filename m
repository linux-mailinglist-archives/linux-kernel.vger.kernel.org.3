Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D9657EC93
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiGWHwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGWHwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2690A1758B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658562727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lJTjyETsZNAo1P5N7bdIAit9hr9njNCUE7Bu1UytZ4o=;
        b=NWEfVvDOwMLlqkIkvd8lLRsYvbAsCNK3bMd0ik4STn3CpqElZZyt+kON7z5POjzf2EzQiv
        TeGiX1+h7Z2x8XYcqgBEUQGKwkaWmclsF0ZcKztzYWa3rARHYDZcXN+aRVDLCcLcAXaqF4
        VBlFbnaV8aHOSwkKsKCW8JG33s/64dQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-2ytnlvEDOQuvuN4AmPiVgw-1; Sat, 23 Jul 2022 03:52:05 -0400
X-MC-Unique: 2ytnlvEDOQuvuN4AmPiVgw-1
Received: by mail-ed1-f72.google.com with SMTP id h15-20020a056402280f00b0043bd8412fe0so1254368ede.16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 00:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJTjyETsZNAo1P5N7bdIAit9hr9njNCUE7Bu1UytZ4o=;
        b=K9BHJC8MxNsBQKEARCyHWWf8OkdATdYUVPuA51hcaQ3MSiJ/S1ubdc4xT3Gq5/01xJ
         +PROrI3n4Yn+qa8vZqFQj8Syk5s4S/FzgSaPBQ7f0KWBFqLwAazz1kWtE9MqDMfZZSFR
         2KxXxhuy697n5VVymVPXdlCZBWnC4/VkJWAz1qYSMhMZUZE/wL5RRWUF4IHnc87h3bpj
         yIUj2bG2jORui+oedPCGwJIKtWmM94vaHYpmNnGCBLfQc5CPlIBq/GD9F3DlgTcQ8dZ6
         5zlMya8KQd4SjPSVqGJW2ItQ7J2sZmXBa2KtuU//oK823H87dLdig6HF+Wl5xgmqyZSi
         xzDg==
X-Gm-Message-State: AJIora8rJbxXSrrKjvuFiXiIqd64H3T9u/yCvHl513DPmFPiHZ+QMCfY
        r05AIwJlUqLLrGwpm+rmTd9MmsCmMpfxF8+D5wSRtOmdyB2iaGO7G6zO+3jQtyTP5jAGEMu7MGa
        4Mw8Ebxc5XGIgLtBX0TwbLb0v
X-Received: by 2002:a17:906:58d0:b0:72e:e25a:46e7 with SMTP id e16-20020a17090658d000b0072ee25a46e7mr2727037ejs.459.1658562722478;
        Sat, 23 Jul 2022 00:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vyVGVozt0cw8AcViZHx16PlOGgbrv2BKkHYcD1TrQ0KkRk9MpV/mbIJWx50rqcVOj1gwbcUA==
X-Received: by 2002:a17:906:58d0:b0:72e:e25a:46e7 with SMTP id e16-20020a17090658d000b0072ee25a46e7mr2727032ejs.459.1658562722281;
        Sat, 23 Jul 2022 00:52:02 -0700 (PDT)
Received: from goa-sendmail ([93.56.169.184])
        by smtp.gmail.com with ESMTPSA id g19-20020a056402115300b0043bbc29de5fsm3640746edw.73.2022.07.23.00.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:52:01 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 5.19-rc8
Date:   Sat, 23 Jul 2022 09:51:59 +0200
Message-Id: <20220723075159.865703-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 79629181607e801c0b41b8790ac4ee2eb5d7bc3e:

  KVM: emulate: do not adjust size of fastop and setcc subroutines (2022-07-15 07:49:40 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to cf5029d5dd7cb0aaa53250fa9e389abd231606b3:

  KVM: x86: Protect the unused bits in MSR exiting flags (2022-07-19 14:04:18 -0400)

----------------------------------------------------------------
* Check for invalid flags to KVM_CAP_X86_USER_SPACE_MSR

* Fix use of sched_setaffinity in selftests

* Sync kernel headers to tools

* Fix KVM_STATS_UNIT_MAX

----------------------------------------------------------------
Aaron Lewis (1):
      KVM: x86: Protect the unused bits in MSR exiting flags

Gavin Shan (1):
      KVM: selftests: Fix target thread to be migrated in rseq_test

Oliver Upton (1):
      KVM: stats: Fix value for KVM_STATS_UNIT_MAX for boolean stats

Paolo Bonzini (1):
      tools headers UAPI: Sync linux/kvm.h with the kernel sources

 Documentation/virt/kvm/api.rst          | 2 +-
 arch/x86/kvm/x86.c                      | 8 ++++++++
 include/uapi/linux/kvm.h                | 2 +-
 tools/include/uapi/linux/kvm.h          | 3 ++-
 tools/testing/selftests/kvm/rseq_test.c | 8 +++++---
 5 files changed, 17 insertions(+), 6 deletions(-)

