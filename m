Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF15535571
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348841AbiEZVZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349208AbiEZVYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:24:34 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8E3E8B97
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:24:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x16-20020a63f710000000b003f6082673afso1292267pgh.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=sjrWadd+U6s3AE9OlHKd1vSx1dK7nsNaDjQLzkoUXcg=;
        b=TQVt0Vq76cHTUEa2X6kDVHu+UhrNE6fY2WluDwgnGkC5IRYf796KPXGLhfr04Uy3YZ
         6kBFEBE021obJjvVQEwo/PWkRY+xLg5Z1XpTssEYByESOvro3h2/ts3s+hfAVhsAxFqn
         70IeBknD328cT/+s0eWCstTi2PBxxkLVBD6skaLODHTTWc58vzrIeMni8h4pEEr6iTFW
         fYzf6XTbKN6Lm9Kpw+ZG4tbsdEOKBd9GJnzIMzKjvgGXsggp+y8oQBokLA70b8+BylEg
         52jqDFIsfdKJVhJIl/iRCeWIcuUWUmsp1vtPsMFHjg7HQGHRRO/QCD7qildWl4DVyUWm
         M7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=sjrWadd+U6s3AE9OlHKd1vSx1dK7nsNaDjQLzkoUXcg=;
        b=ogPb11GGAKqwULekX++bw8mBzTcDzebDpvNNjDo4l4AiL7gOX7qSvEcGkc+ZZDG7p1
         I4mjKz+l8o1NEArv9JxpUWqtlcJ3gDJm5meGBM8IDkyExXr9J+9E73b9IhvgYP+gvnr0
         hkdy/drOF5S5z3CRREheNWAfx+KXBjutpSNDQpSrVgiF67FWGELUb6lnvUQ3emnvu6Pp
         4u9SWNQ8YgJIapSyskoVoXwV6m0xx2nqTyo1fZezvRgs3UBZ/0imAIoEgIkaAagl+pZC
         R7UMK3201tMdnOe5y/yBluRDxO9buaqYwRWGRWW6YcaAdQj6iwGLjef2IkxqVyFWFexG
         FTHQ==
X-Gm-Message-State: AOAM533e0ZBqhv5K/DDGKfnvZ/2W2pRgc/DAtIUXovIor6+RTn6dlJvK
        vvQ0nOgBoDryLtYoXEtxh0gQraQDZHo=
X-Google-Smtp-Source: ABdhPJx8M0VoHr57nLlA/sX8zTDrVXkgT1bsVM9bmwFgKG11EQvIc6zvT1j59UbsqyEBKS3z3uAnVG+SZ80=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:e819:0:b0:518:6a98:b02 with SMTP id
 c25-20020a62e819000000b005186a980b02mr34100732pfi.74.1653600270603; Thu, 26
 May 2022 14:24:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 26 May 2022 21:08:17 +0000
In-Reply-To: <20220526210817.3428868-1-seanjc@google.com>
Message-Id: <20220526210817.3428868-9-seanjc@google.com>
Mime-Version: 1.0
References: <20220526210817.3428868-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 8/8] KVM: x86: Bug the VM on an out-of-bounds data read
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Robert Dinse <nanook@eskimo.com>
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

Bug the VM and terminate emulation if an out-of-bounds read into the
emulator's data cache occurs.  Knowingly contuining on all but guarantees
that KVM will overwrite random kernel data, which is far, far worse than
killing the VM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2aa17462a9ac..39ea9138224c 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1373,7 +1373,8 @@ static int read_emulated(struct x86_emulate_ctxt *ctxt,
 	if (mc->pos < mc->end)
 		goto read_cached;
 
-	WARN_ON((mc->end + size) >= sizeof(mc->data));
+	if (KVM_EMULATOR_BUG_ON((mc->end + size) >= sizeof(mc->data), ctxt))
+		return X86EMUL_UNHANDLEABLE;
 
 	rc = ctxt->ops->read_emulated(ctxt, addr, mc->data + mc->end, size,
 				      &ctxt->exception);
-- 
2.36.1.255.ge46751e96f-goog

