Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8E54A263
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbiFMW6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbiFMW5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:57:40 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18524F56
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:57:39 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d11-20020a170902cecb00b00163fe890197so3765772plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=CH5DREzyS2tatBMXpdEXlWqxqYpXIqULDbAajGOOJKo=;
        b=RIJuXisytih2NpyVfyghweWip1f0Rg+Br76HuU1orwNbLKH1cNyhUeCfnj1YUhfv6g
         uyRN33fSoGMSawGtzvMYXn7mthUpreQxJJ1ogm/LPUypufIe9Hf8lhXjY1wHGQusChRz
         bmZPtYtWj0CgR8ynUC9hRcYuBiEWP7/WS8BjJYdRO2B89AbXZ3AWw31O+sSqZ6HCNZ3f
         OnxRRhM0kqF4xcUwUIgYY7AyNP2BbJR6jsEAR6AVSCJKi42zS4zj1ulaGcqOV/38JklQ
         UBKB8OK/TxWV/Lvw609IYCcv98GCsLyDHHaFzjmIR+XRkBG765wPAdhEs2OUBEpqxLf3
         pl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=CH5DREzyS2tatBMXpdEXlWqxqYpXIqULDbAajGOOJKo=;
        b=ElLy5d8XIISGdN+L3WUyxa1bnEokqsvt2BKic8oP3zL7ViPL09ju+g7gqw0M+6PwY+
         2ddHfoCcH9JSMzMUfZwCKZShiHhiyEfAE53o8QVl75v1bHsF49hJKmnCKNOuDYtDp/0X
         6t+m95+qB5peRYIqhR82U+7HCS2YgTATP7z/EOi/7rHLYUzGV4x/X/H04Fit8HqoJG14
         WChWaC1sDCGBMIGOX3BA93Wx5f936AqSBcGUuVRxOoptC9WKEjX2i6sRySkHt3uScPGr
         85qDJLlFqcrBbsxDNcFpiywMlMAbP5pGtCmSOi6V5ZdvOHI8sUVLX5dcOz/RjsNhPqbz
         4uZQ==
X-Gm-Message-State: AJIora8g24f0C3DTm6Rcdj0KpogNXHDTVuzh1zdUNG4t03/6yqKU9d78
        JMBp/blErzqt200h5yLg5q186nHx7uQ=
X-Google-Smtp-Source: AGRyM1vzPhUIRhhvS3eRTgxLMPv9LYjTKe77b+/SMc6756A7kV3g3V5r9jXLT2nDC2hVGFG+vf4bXu/wm7M=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr48916pje.0.1655161058035; Mon, 13 Jun
 2022 15:57:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 13 Jun 2022 22:57:22 +0000
In-Reply-To: <20220613225723.2734132-1-seanjc@google.com>
Message-Id: <20220613225723.2734132-8-seanjc@google.com>
Mime-Version: 1.0
References: <20220613225723.2734132-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 7/8] KVM: x86/mmu: Truncate paging32's PT_BASE_ADDR_MASK to 32 bits
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Truncate paging32's PT_BASE_ADDR_MASK to a pt_element_t, i.e. to 32 bits.
Ignoring PSE huge pages, the mask is only used in conjunction with gPTEs,
which are 32 bits, and so the address is limited to bits 31:12.

PSE huge pages encoded PA bits 39:32 in PTE bits 20:13, i.e. need custom
logic to handle their funky encoding regardless of PT_BASE_ADDR_MASK.

Note, PT_LVL_OFFSET_MASK is someone confusing in that it computes the
offset of the _gfn_, not of the gpa, i.e. not having bits 63:32 set in
PT_BASE_ADDR_MASK is again correct.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 0bb2a6c97ebb..4087e58e2232 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -39,7 +39,7 @@
 	#define pt_element_t u32
 	#define guest_walker guest_walker32
 	#define FNAME(name) paging##32_##name
-	#define PT_BASE_ADDR_MASK PAGE_MASK
+	#define PT_BASE_ADDR_MASK ((pt_element_t)PAGE_MASK)
 	#define PT_LEVEL_BITS PT32_LEVEL_BITS
 	#define PT_MAX_FULL_LEVELS 2
 	#define PT_GUEST_DIRTY_SHIFT PT_DIRTY_SHIFT
-- 
2.36.1.476.g0c4daa206d-goog

