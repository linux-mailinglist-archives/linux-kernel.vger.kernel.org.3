Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D144D5B41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiCKGA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346749AbiCKFzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:05 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC0EC5CC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:33 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id n11-20020a170902d2cb00b0015331a5d02fso993297plc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dbOZYIDkIB5UtzwmNzQd2PJFJKvUjWfX0QUBO7DMuHY=;
        b=ZW7p3/empagVn6qWi2qV2Fw/Jea9KHyPEQ/vR2lLt7x5xQ/n9QFJgs20pAfrcFhOX5
         Mg2VlAUZQUDCSPkkY/XK50S7uRv20+ltLZRzpwJtLZXcfmO5BcxfbSwUwVn0b1ZuC2Es
         usMkbxzEHJ7QAQhg2z5MjIcEE15DRqRw14x7iO6wi/CENn8V2uHCxmJ+1ReWzKdUX7D9
         za3uttdMRh7xJtfxr3sqKRwitHzUxd/yxh2SmBQcLLxIlK/abZ3E56em3/3n+ZRHFi+f
         1tqiZRcsESrr0HQbBxeGxYr72C+N6KIkMs95vPa/uANoRwGkkWDKHAwURrj0LPA1sHLa
         FOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dbOZYIDkIB5UtzwmNzQd2PJFJKvUjWfX0QUBO7DMuHY=;
        b=SX9ao2i8jPA7jbPfBv2Obw5pAjIGETfJuYh9zm9NPdngxa5Qc+feAwdAGnmbbMao9y
         3WTG9ajHALUyu/sZMk4Up2P2fDquyXDZ++4ILMy4nCYfOZOPC0csZP+1hJ+8lcLGEUjp
         Q+G4oNHW5QR3WdnCkFOT7pby3fyPps1cQbRvTE82q5ougrkNnCXrd23O6EdFe2Z0iKQS
         zo41FOtdM5Bq11DpD4OCvdzKqHbpGNfvx3nQVm1UI3fG1CXEq6LxFw8c4gBF9xTDeQ2w
         WXEZFpqpxebBXwhAePje431rPNjMAO7Uc/Vf4WRyi33+rFIMWA9HcJ/xISLh1KWvEcc+
         8I2A==
X-Gm-Message-State: AOAM5310hbYo45CFMjd4dB/9EiHMRQfOXRwao093HPLVC/pmy0Ul1vnv
        NVQP5V53D3/IcKEs83n3VgdFC8cHZbTQIRNRqjXu4fouEfQqe369Gek3HBEUuhuX8Zgt/ovnXV7
        EZnMFBJS20tkGRdCwgUiYGGFGhWRHXlkYpey2E95LABAZ5cXYblt96d7OsMh8I+VPZ9lpNA==
X-Google-Smtp-Source: ABdhPJxYLaOH73e7m+mnSAZekPfjT2yy59uVJxgfjNuVkH+Ngsckb8WhTzoVwTs89r4J4osxvPLlWshdVnI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2181:b0:4f6:f1b1:1ba7 with SMTP id
 h1-20020a056a00218100b004f6f1b11ba7mr8300681pfi.73.1646978013119; Thu, 10 Mar
 2022 21:53:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:38 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-88-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 087/105] KVM: selftests: Fix typo in vgic_init test
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
 tools/testing/selftests/kvm/aarch64/vgic_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 32dac03f5600..f8d41f12bdca 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -418,7 +418,7 @@ static void test_v3_typer_accesses(void)
 			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
 
 	for (i = 0; i < NR_VCPUS ; i++) {
-		ret = v3_redist_reg_get(v.gic_fd, 0, GICR_TYPER, &val);
+		ret = v3_redist_reg_get(v.gic_fd, i, GICR_TYPER, &val);
 		TEST_ASSERT(!ret && !val, "read GICR_TYPER before rdist region setting");
 	}
 
-- 
2.35.1.723.g4982287a31-goog

