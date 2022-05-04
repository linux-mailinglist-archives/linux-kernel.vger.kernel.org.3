Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11451B2F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379231AbiEDW4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379466AbiEDWyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:07 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC3EBFF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:50:28 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u9-20020a17090282c900b0015ea48078b7so1368788plz.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=sZH9G7euzV9rnyh47iho6g8MIzosuwbetrmDjZD8ZTE=;
        b=RdrJ3mSRKo8KcMIwl96zO0aVxE7Kd9yL5NnXUXbiElkEsbIHCGetW9mNt/Ova49R5d
         mbq0ihLPoPr8O8x5f7yUR6wqbj29pYJEAQgJzDg/S9AqPY+NuGb7FrZKR17SoZD2PXdd
         3VQjbAqr9W2MRmdIRzUDkgAiG6SuwvQxlMN3KwFp/V0SDgiAY0q8LOtdwzu9OPMekRF2
         2OW6PxJgdXCv1nZTwI+7V9t70/wt/ydAdX8ruvgbp4gSYans10VAUkaiIQO/n3mMLRXn
         oGOmXVwvBH29ReHDXHJ6Rge3Y3rHuZbastkUEoO32vaZ745UOzdImh5SNEFuKdd7LfR8
         iQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=sZH9G7euzV9rnyh47iho6g8MIzosuwbetrmDjZD8ZTE=;
        b=1qW+k0ZOkTMnQ2PT2zi/3ggo1xYMbQ9xIqS/6eSMSz342wug966b0IrE6DYpEa9zg3
         Zo3cVaIFdFUnEhu/GLsreYLqaKZuXOEwjbpLjoOe2pGE0Ep33zIKBmXv0+ImbR5CnQ7F
         MSJRt0+iTwvJm0RwBKIHqkWiU/4tcQ3B2vxdLyiNFVok4Vow0JqGKbYX2pZshIYNt1HN
         Szj927qy2nC/S0iiaTJODml5g3/J1JvvxGti6/FQ/CALznp8pT7nSOrnICaH94A9Iowe
         3YEfr058Nxa3GYxfCU5sDDxRt7zhgEnsoQbnEcxhB5qdoeC1rmbz229xHHW3ex0keBqj
         kbqQ==
X-Gm-Message-State: AOAM533fSEVwnOzPQIzPH70L019NOhxJELn/kLEEFpkx8LxKT8KvFPyD
        1KdiJ4tKcg/ZdgOyKN+uC5ilacmBvEc=
X-Google-Smtp-Source: ABdhPJxz4jVPHmo56+gbSe+F7J/gie2YxwPijSVt8ps/mj3nYM65D/hVu0uM9fwRXY7yFUn0vH5sn5IwQas=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:bf06:b0:156:af5b:e6c with SMTP id
 bi6-20020a170902bf0600b00156af5b0e6cmr23996876plb.147.1651704628278; Wed, 04
 May 2022 15:50:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:39 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-34-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 033/128] KVM: selftests: Use vm_create_without_vcpus() in hardware_disable_test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
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

Use vm_create_without_vcpus() instead of open coding a rough equivalent
in hardware_disable_test.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/hardware_disable_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 81ba8645772a..32837207fe4e 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -104,9 +104,7 @@ static void run_test(uint32_t run)
 	for (i = 0; i < VCPU_NUM; i++)
 		CPU_SET(i, &cpu_set);
 
-	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
-	kvm_vm_elf_load(vm, program_invocation_name);
-	vm_create_irqchip(vm);
+	vm  = vm_create_without_vcpus(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
 
 	pr_debug("%s: [%d] start vcpus\n", __func__, run);
 	for (i = 0; i < VCPU_NUM; ++i) {
-- 
2.36.0.464.gb9c8b46e94-goog

