Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B54D5ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346598AbiCKFww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbiCKFwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:22 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D370ECC72
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:18 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id s12-20020a17090a13cc00b001bee1e1677fso4722912pjf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=LFNHAAPX/kZouSwMoXOBUFgDa9kMaYQcNIefhEVTw0c=;
        b=hZOQR8NNC7Jc6qPQsx2jRgRv8S3khyQzNleTtHfmHUKmr3aI1+sg0ysZ6XcshjO/cq
         aBX/GZY6n5t+VCt/fw97UsCU++MjJzKkM+D81d05KlTAlGatL46LrE107o66AJULdBIY
         Utt+hd8n3pbooLQpSKvuubTpfFaWGK+MnK0WsMDHRGOTuJ9WUrDNav7KyHI4GiHoSTje
         2W0bzaAogcmPVqATfj8rzl3xX5wlu9q4t/Jr0YYmSvUeNegIqkxizh7BHTcUkSzSbvZN
         h+lSc46lZwV4Ys17GiUIlXesXLNLm3DPzFTxwAe8Ph7qHaql43MGVA5mNS63YC73HoQ9
         YwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=LFNHAAPX/kZouSwMoXOBUFgDa9kMaYQcNIefhEVTw0c=;
        b=GjBKC4tLJ5cfUSjkDBV6MimvmZ0tHz3BRzW6JjmZ+10ukfyayxLzyBGmhZ/+/ZLW+4
         ktRDPsk/5B2cPYbBvG1Z5wC392ruwOdo1ylFxTxU2+8X1HP0ifp7ivmJStNuWXXUkvy7
         iRS3paLpSDSUg/jQC1XX1f8ztNLMsQbLM4J9lC8X/bVv15/uPIIhB+APWcx8rh20SSyW
         Uo1Up9roqTmJlvncq970vuMz1yNFcere62NDZ/uQsIeSff1BwRePE6ylfb7/O4X8XoEk
         122rAWeNTCD+6yy3nm4RZRxYNmWUssiJKc4vy+LsVnvA6+W/qjDiY14DnjmflHU/yARd
         0nFw==
X-Gm-Message-State: AOAM533clWZFqAJwTtBjL1vgcPghbDR3YEVWCF0LiujhEP5iocEOPkGI
        zXZDVmDdEjy35EmjaU1la8tHB/GJqUmnKnRdcJ2xz8iaDh2m0Qf8wi6/jr6GQBlibleF0WIthep
        o1ePZbLH0acUG/7RsK85h4hDD+7LgIgL4PB1hH7wyNbS/bkI4s/EcbpHut+VHc09P+aT0eQ==
X-Google-Smtp-Source: ABdhPJzAYB5wZO5z4h0uJukX+hC2nTIMeUXg1DUD8TWi+zMbdXrqkGD6B5HaTk/m5CkoM38ut3TO/7kbhVg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b597:b0:14f:3396:a7a5 with SMTP id
 a23-20020a170902b59700b0014f3396a7a5mr8574736pls.29.1646977878060; Thu, 10
 Mar 2022 21:51:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:18 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-8-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 007/105] KVM: selftests: Add hyperv_svm_test test binary
 to .gitignore
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index dce7de7755e6..62f9b781545b 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -20,6 +20,7 @@
 /x86_64/hyperv_clock
 /x86_64/hyperv_cpuid
 /x86_64/hyperv_features
+/x86_64/hyperv_svm_test
 /x86_64/mmio_warning_test
 /x86_64/mmu_role_test
 /x86_64/platform_info_test
-- 
2.35.1.723.g4982287a31-goog

