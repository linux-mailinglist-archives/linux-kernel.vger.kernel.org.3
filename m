Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF470533660
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiEYFZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242821AbiEYFZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:25:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD88A5158F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:25:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ff37db94e8so168863167b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=FnZF3+YZLg3UFQmraDPfJnhkCIHSpQV9nRiWF2uBduI=;
        b=n7h4rDY5bqq1Nj/uWMH/BOjjGRxHVlwv0daDi3oPceK1xowU04YOjIO/3FhY9RNxQB
         NlW5br8u8IyvUC8XXP+1RUMgGNfkrIiUS3xiwoFvkgSh4XjAzATxOx3RKK6OVWfU1okA
         VELt3MwX8YxpZBuCRqJBZ5i6Qw7i9KkhlCaU7zc4bpMQ2FzwLe4PVfFIo6dhVQtl16P9
         k0GfRSGF1Iv98TqoAoDGbyfUV7M7+JDsfG6qZvzQHbtLXd3Ia9RJ/mkcxNWnexJOoYDH
         DgHQh35Gz3YKyuSZ/OidTYUmKgGf03Lc4j6wRIqoAExalNzTWmjDGxpZMjoMVIzkVvop
         MICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=FnZF3+YZLg3UFQmraDPfJnhkCIHSpQV9nRiWF2uBduI=;
        b=RUZRx8IaWm2IdykaiCSne5kzl2BgPe/auXG33OzEDASoNb6rpPv5ixI0CQNvIFFpnQ
         N1V0+FjPfRkJHAUh2K1ZozCPxcdTSISVOp5O3ItzGj6UXiBUUjJ6GrvfgHXQON3m/Y/Q
         dXyx7h5/zJ8psmwr3OU4BQqDLCZ7evL05Orlcgw2snnxSFBRGS6yXhyLI0pw6kHgOyNs
         SFzhlmpL0mPE4nXlKIsC0VnUBFaYc8Idal83L8+lQx6Pp+2ItbcahZdRWKJhK+dTUkvj
         VQ6uQbi/mQnndDvUDjzLWvjQuEiHLMSzMTn1HyUFPhm6FELa7CPNf7vuzzZQn2REV5mC
         NsmA==
X-Gm-Message-State: AOAM530PomeIbY0J1+OG00Yt9F3aHeZFncolNLcahPo6I905jjnroqOM
        TG97SIgS/NjG8HVrVRrkAD7/I6po6PKxMEhZU/l843HCebWm1UCN5OnKRj10oOVEpjuD496aiWB
        snHXyJeyki+DLozt0dEqZGMQhDL8VzFZUp396KzTdcxxujezh1U3qZawcZj6ZabE/ajwS2BM3
X-Google-Smtp-Source: ABdhPJw6Cr/yE0TgWX3Hl/9bUyXZB4vjuoFmuTWgHhQUQLb8N9Z8hgceptJxtdDxGHJy2bavjx8OQyvoqfPN
X-Received: from mizhang-super2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:61c])
 (user=mizhang job=sendgmr) by 2002:a05:6902:1c4:b0:64d:b1e0:4075 with SMTP id
 u4-20020a05690201c400b0064db1e04075mr28882459ybh.589.1653456341806; Tue, 24
 May 2022 22:25:41 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Wed, 25 May 2022 05:25:38 +0000
Message-Id: <20220525052538.1753922-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH] selftests: KVM/x86: Add APIC state into kvm_x86_state
From:   Mingwei Zhang <mizhang@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APIC state into kvm_x86_state and properly save/restore it in
vcpu_{save,load}_state().

Doing so fix a bug that was triggered internally in Google. The selftest
(WIP) creates an L1 which then creates an L2 and runs L2 in vcpu0. Before
L2 finish, it exits to L0, save the state, stops the VM, restarts it and
add the vcpu back and finally load the state back. The test uses another
vcpu to shoot a posted interrupt. The result demonstrates that the L2,
after this vm save/restore, was not able to receive posted interrupt.

Our debugging shows that it is the APIC state was software disabled after
vcpu_load_state(). Adding the APIC state into the kvm_x86_state and loading
it in vcpu_load_state() fixes the issue.

Cc: Jim Mattson <jmattson@google.com>

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 1 +
 tools/testing/selftests/kvm/lib/x86_64/processor.c     | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index d0d51adec76eb..e4683429bd8b8 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -123,6 +123,7 @@ struct kvm_x86_state {
 		struct kvm_nested_state nested;
 		char nested_[16384];
 	};
+	struct kvm_lapic_state apic;
 	struct kvm_msrs msrs;
 };
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 33ea5e9955d9b..113f4ce752579 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1173,6 +1173,10 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 	TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_DEBUGREGS, r: %i",
 		    r);
 
+	r = ioctl(vcpu->fd, KVM_GET_LAPIC, &state->apic);
+	TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_LAPIC, r: %i",
+		    r);
+
 	free(list);
 	return state;
 }
@@ -1222,6 +1226,10 @@ void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *s
 		TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_NESTED_STATE, r: %i",
 			    r);
 	}
+
+	r = ioctl(vcpu->fd, KVM_SET_LAPIC, &state->apic);
+	TEST_ASSERT(r == 0,
+		"Unexpected result from KVM_SET_LAPIC, r: %i", r);
 }
 
 void kvm_x86_state_cleanup(struct kvm_x86_state *state)

base-commit: f3f19f939c11925dadd3f4776f99f8c278a7017b
-- 
2.36.1.124.g0e6072fb45-goog

