Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7858251B250
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379228AbiEDWxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379102AbiEDWxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:53:15 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8426053728
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:49:37 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id b198-20020a6334cf000000b003ab23ccd0cbso1337080pga.14
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=309h4CdGAPcwiHb0ZM4SWUVDb0T/f6xUJOwKAgDDSGM=;
        b=ZUrelAy0Bnhc0z7Dj1FvhcDcGJufecyEo9sS9WZIefn7dmdWq21xt4WaQ2OXpsybKq
         o6ilh7c+GhOO9FjT9yt5ae/jq0ta7aIPRzCDwZeVNNbqSrdav/H60mydYTiPdR6oD7bW
         51zuLMcd6dho3EGrqFALGhLITdC/t4A2JX2TIUlTcHdcMEjnvi4PaFEdSmUUtHoLW4fR
         geMCTJUNfo5r9O715SPThADanpQl9PQvGb2WAnzGHWTgOwnR6FUn+hy5jGDSAbKfqWZv
         y1rAgl4LxLNEMPcc7zX8/ZWhdzOekI9X9riy55mouWBfcpRER2apGHf5AXDAZ+mp7CGg
         pnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=309h4CdGAPcwiHb0ZM4SWUVDb0T/f6xUJOwKAgDDSGM=;
        b=ITsbeUcUWFK9vK7YKW6wvQLZTiZprJ3MBKl9liOWcErzDvADVwJvcmWs6HdTEZnGec
         wI3vkoFvnVbeGo1GAx3VJizoLVkpCwQGPeF/BC6fEQ93NzonGrceZ3h0MJOtnWMv0HNQ
         6iinnvu9sPaflB8/40HYMAV9Fie/KPGKW1Y9VKeq3o6K8M6v+HLFnVeKMYGoMm19NQNu
         DUUziIX0mMH3mlyiQPdR+WNASI456Oo+HqcTcHGiTLKEin9ezWnEHowXLPiN9M0IzXWP
         F9+tTAYSLim2NTO8GJUF1PMGnNN3NvT8e+YhHDB86D0z2d7hvgHg+v0VKvWiQpUo5vn5
         /oig==
X-Gm-Message-State: AOAM530BOTpf8nLDYZ6r4FM8xZD/MIQhtaokL+slZn5c1JuHgRuyU1JN
        b5E8fSaCwpAsePMnrqUwFsCdC2KcXCo=
X-Google-Smtp-Source: ABdhPJyroa6y79geaC1Voqxr63GiFITL3Z3N0TL80As4HKXy0ciZTzff0PRUBNCA1EGsP1cZU0jjKr5Viis=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:aa09:b0:159:684:c50d with SMTP id
 be9-20020a170902aa0900b001590684c50dmr24671868plb.51.1651704576963; Wed, 04
 May 2022 15:49:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:09 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 003/128] KVM: selftests: Unconditionally compile KVM selftests
 with -Werror
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

Specify -Werror when compiling KVM's selftests, there's zero reason to
let warnings sneak into the selftests.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index af582d168621..c8efaaeb0885 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -153,7 +153,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
 else
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
-CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
+CFLAGS += -Wall -Werror -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
-- 
2.36.0.464.gb9c8b46e94-goog

