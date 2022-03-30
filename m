Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34DB4ECB04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349513AbiC3Rsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349672AbiC3Rsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:48:30 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06AEA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:46:44 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id t2-20020a4a7442000000b003245b0660afso13310407ooe.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2dUY3PgVjHooqkko5l4dkxAWtd/xyNFDozbG/aHxTaw=;
        b=gf5iDsAmK9ljVSjZDoF+cz+eyO8gggNes5Ws3RRtbNgH0eu/dpFquT4YJB+Y1qNDg8
         o4I2zi5iJQNAx46MTkU45AAXbVXInsgWLJQoOTXf2Pl14/CpbTYodytjoxh0j2qy13XY
         ooH5FBm37hWsKVAbBx0nEwJwbLa+T/4DCZmWXhV6shgzFuHVmJR97mDjfdKVxWBaOYAL
         EfpE/IcOKgBKxGZVdHKBZbkG/Ip/e2afO9BjwkXM50tZ3LQy+FREuemUQ6jHkE9JIDCJ
         B1gpzRUoN0/gFaxehpWksxSwo4HmI7Q8lpHMJZQrs4X4GYK8Hp70Eyw6NZ+aepM/6zl5
         In5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2dUY3PgVjHooqkko5l4dkxAWtd/xyNFDozbG/aHxTaw=;
        b=d56bXTVqM9O6nQNYQ8KnMo04WWyzcFTmpmtFXGVOqo+/cug0zWDLPzowSlabga4l9d
         PAr1bKKKBlmH9ZIPbzii1tv/2C9N+jXMDauvYuWKAAWbMqXi0elgtt06oQv835IJ+DGG
         ai9bQkSP1B6zfFC0TbUnuX8hJVPBgew3S1fXvB0p15edXE9F2f44DTDiGoTN4qE+hYse
         64RASd7MlsuBFe1r8XiDLojnwbwrpRWS7c8zoYtM0Co5doYZ8UpupW3o/A1Bk0EA8UqU
         Bmqf03Q1521eEddHVQ4JXF00QD1csXVujK4tLMo0J4scm5acU7NCvZYJ2nBT7fp3Vn5k
         +TFQ==
X-Gm-Message-State: AOAM531BMFViv7DAJGgrqXevNZPpGZt3HC7e5GUveoEW1TFJ9m0VqBun
        nnpFE5Z3FuxSvL1pRx1oYKBlMNDajcuj34sK4udMJno0Q9jXp25QE4Mk2KKaLdPcVirV5pmbyPX
        6vosjpWgun/xtkQ8RN4PFaZH+MZeNgiNyznJz/26VTBPVijjvPPdWsoJDei8WDT+S0vyVT2gG
X-Google-Smtp-Source: ABdhPJwItbVmkOlpOw+0i6B+kBdUV77Gp4sKPuBDJnSqIt5d6VC/YxajnwWOaaMSdWFD6AGJZ2stS6YMFVDq
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:7c53:ec2f:bd26:b69c])
 (user=bgardon job=sendgmr) by 2002:a05:6808:179d:b0:2ef:88be:74f5 with SMTP
 id bg29-20020a056808179d00b002ef88be74f5mr518446oib.96.1648662403217; Wed, 30
 Mar 2022 10:46:43 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:46:19 -0700
In-Reply-To: <20220330174621.1567317-1-bgardon@google.com>
Message-Id: <20220330174621.1567317-10-bgardon@google.com>
Mime-Version: 1.0
References: <20220330174621.1567317-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v3 09/11] KVM: x86: Fix errant brace in KVM capability handling
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
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

The braces around the KVM_CAP_XSAVE2 block also surround the
KVM_CAP_PMU_CAPABILITY block, likely the result of a merge issue. Simply
move the curly brace back to where it belongs.

Fixes: ba7bb663f5547 ("KVM: x86: Provide per VM capability for disabling PMU virtualization")
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ea1d620b35df..e00dcf19f826 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4365,10 +4365,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		if (r < sizeof(struct kvm_xsave))
 			r = sizeof(struct kvm_xsave);
 		break;
+	}
 	case KVM_CAP_PMU_CAPABILITY:
 		r = enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;
 		break;
-	}
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = KVM_X86_VALID_QUIRKS;
 		break;
-- 
2.35.1.1021.g381101b075-goog

