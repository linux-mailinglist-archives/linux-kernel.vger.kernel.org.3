Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6381F534676
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiEYW0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345368AbiEYW0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:26:13 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285B10F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:26:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id on14-20020a17090b1d0e00b001c7a548e4f7so2003614pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=1+sE54bQx2t4fwpbWEt17sU4LeDI45Rz3nd8Z1fxEVM=;
        b=ShFQVD12P8JMQ//0COOqBxO64VBS2rO4ICn0VoixRym+8gf7yxI5GUCZwQa/dMooZZ
         zNj9bZnqXh6tAOLyWobqHp7Yo6b1qsvfxeaDZbVB87VtxVPq2wCD/RGxCYYFLaCe5kAy
         bUrnz0suGuIVrHH3yNidW0GXjtZYuxoRBQfPYnPVmhB0JYIb/Q0LZKfmmDM1rq12GeE4
         sWjYbFS8TWnaTCjTouv4h7bs6aW21oT6MGJjHjqGSf0Ej0oPq9jCCHZjuzPdTMBqdSj7
         0iv2lnADB6batSLynOoQ5dB9Vg2lm7vggQz5JVZroRUQhzavtTSt6sQU6nnRTKGGZHwb
         tdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=1+sE54bQx2t4fwpbWEt17sU4LeDI45Rz3nd8Z1fxEVM=;
        b=ngC2r8quACrPUbB9is6nPyml5ABInONGU6UYjnaA08YFlhHr1DgBkBUtPbWcQjIxiD
         ZEooMlVddgDnrUrQIffDvLKWr6PGB14u56aBQ3YNI2Wos41BsTivblrlzY6nUh6N0FZ7
         hdG7KgBHKGLq24pgonoD+67JdamdguOl9D5r27HemdERfbcmVU7wZ6EJqjKmXZy0ra1D
         q5Cav5Ojg5jrsooaegGYb33ZrdgsReY+nKxNhXWNVImYNz8XuY0eEnWAJTa2ZJwhG4AO
         GlZCtqrT5fPSwTIJi6gAs/9+Mctb6TRHpUB+Och/huP8KYDKuAA6dnnbZUA3V4o9rrl+
         6aMg==
X-Gm-Message-State: AOAM533GxsXNfnCMTDrUPkCu9OJWXtj+s6wJfAz5XBC+Mpl9ikb+s9N2
        XCPIAplztT8geIC8nwBlML7+V56w49s=
X-Google-Smtp-Source: ABdhPJxzEOOjvl7kgGks3plOPdNixXYXYcduS3W+WrJEIL+vcj1zZdB3vif0SZDFUx6i5RTW5fMkKhe71nU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:38ce:b0:1e0:5bb2:9316 with SMTP id
 nn14-20020a17090b38ce00b001e05bb29316mr12652709pjb.51.1653517569704; Wed, 25
 May 2022 15:26:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 25 May 2022 22:26:01 +0000
In-Reply-To: <20220525222604.2810054-1-seanjc@google.com>
Message-Id: <20220525222604.2810054-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220525222604.2810054-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 1/4] KVM: x86: Grab regs_dirty in local 'unsigned long'
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>,
        Kees Cook <keescook@chromium.org>
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

Capture ctxt->regs_dirty in a local 'unsigned long' instead of casting
ctxt->regs_dirty to an 'unsigned long *' for use in for_each_set_bit().
The bitops helpers really do read the entire 'unsigned long', even though
the walking of the read value is capped at the specified size.  I.e. KVM
is reading memory beyond ctxt->regs_dirty.  Functionally it's not an
issue because regs_dirty is in the middle of x86_emulate_ctxt, i.e. KVM
is just reading its own memory, but relying on that coincidence is gross
and unsafe.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 89b11e7dca8a..7226a127ccb4 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -269,9 +269,10 @@ static ulong *reg_rmw(struct x86_emulate_ctxt *ctxt, unsigned nr)
 
 static void writeback_registers(struct x86_emulate_ctxt *ctxt)
 {
+	unsigned long dirty = ctxt->regs_dirty;
 	unsigned reg;
 
-	for_each_set_bit(reg, (ulong *)&ctxt->regs_dirty, 16)
+	for_each_set_bit(reg, &dirty, 16)
 		ctxt->ops->write_gpr(ctxt, reg, ctxt->_regs[reg]);
 }
 
-- 
2.36.1.124.g0e6072fb45-goog

