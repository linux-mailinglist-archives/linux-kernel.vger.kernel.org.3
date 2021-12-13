Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F134F47378A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbhLMWdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhLMWdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A971C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:37 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n8so12212676plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWq/Vm9U+NU9ckxCj+Oob1cgY0t7DDNTXPt/nez7hMg=;
        b=fvXDqJrCYq9NpOuPPS0XQjbVAn7MuytIiwxEdoBwM4ig7pA4PvWrAjOP0GjCftnAuH
         1Nr02+KPfxnXppHb8j/WhLN9jxG/6Sm9BlDIunlR1l00VFNFzQ/qALUTPmnrzdHFdRA5
         tC9nnRi3KgH3QnRG72ST9/VyfzgRRtQW3R5XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWq/Vm9U+NU9ckxCj+Oob1cgY0t7DDNTXPt/nez7hMg=;
        b=jxIyKpt7dSkaFJVtAzrdQ/ir6mu2pabGTHX/WXSDcjsXyYYyHGWDyOMDWZyay2mPFk
         mSEkTJEruApjaCftDWIk2cq2iHRclyNrSetEuCTGU+Qeta3xrrgNxmyVMbuU2mbZRzcQ
         PErBfvW+apyP9I5WocXDErOiCU6aYHNHbkJeaYks3S/I2n/rF6UgVyJ4YHxAAWgEqVPy
         Z0LnUAvnrrPfdlF4f1MkLm0ewqSHnOQ9y87aqyNgtg+ReBsx5hFjSgyHiwWw+YpUhpPN
         WlsRGcT8o0Zp2rf52zEu76iydD42d5TPTAnTwyzB5ZPUwIHj4Yo6iwJ4nAsVG8ZK/gPG
         9FYA==
X-Gm-Message-State: AOAM532grDld+B+w0YlE7YU34Jhbd+l+h5ToXOAb6R4PcC5ATSS/nHHj
        sb589jrK+ApYbnvz5q+5MEVKtQ==
X-Google-Smtp-Source: ABdhPJxyhfmnnFOxl8wXMxB0aXwT8gvUMWVhGrFpP2DZ1sF+r+LHM15DsYLk/QUGsdfKvaJS8ssv6g==
X-Received: by 2002:a17:902:aa89:b0:144:ea8e:1bd7 with SMTP id d9-20020a170902aa8900b00144ea8e1bd7mr1025847plr.65.1639434816531;
        Mon, 13 Dec 2021 14:33:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j11sm13494263pfj.35.2021.12.13.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:36 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] KVM: x86: Replace memset() "optimization" with normal per-field writes
Date:   Mon, 13 Dec 2021 14:33:15 -0800
Message-Id: <20211213223331.135412-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=keescook@chromium.org; h=from:subject; bh=mdlW7CLNTmQAaAzZfwZ39J0G2nNHT637++cNLn7fNig=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o2GvwOSfRHyTuFv1mC2m1Fp6FFVT8q3Ob030Tv eqrmoMuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKNgAKCRCJcvTf3G3AJlHjD/ 0ZquigJmxm/TjDTvQWzYx3LsxH7jAP69bqfNQX1O/4tgeAKhuo5x2opFymtPeWMD9U9uleKf9POAqf mJcpP/Y9Dv8eG50KXaQSf6Snwn2YaNWEkLO+1fkCFu8sfsgYyqWD/V98AqqVleoRArnlZZUEuTe5S7 CXIPBNi+2I4mcPmvpW9mXVEDwlFKWPhvQEhxfFt4f+SwKwWzhGFNflUi06zuAMNRWMs/5gGkeD81JQ cj46ih11ElKrjLNHqoSi6jeIR4urgQzcizVNV+G91+Wa87KZ+WvRPI68OtKVBU8iBNktVy+V1KQjw7 3OgWWdKRfj3P4Ww9mdwW0SuahuxSRx6Cnw+fnIx0gzyOQk7u5m8VPeHlFDfOnLwGLtjJKVS+OnKnoi vLiSbsqr9SBhuSSrecitE3wqn3cWwKQQH7eJ5ztLW2e5T7cfPb3bV0yFn4Trx3KUOX1PoJOYzIlcC2 ToR/K6xga+bsJT6KY1CW2XRC9xH/Yl0ElRmlfy6RZT6QjJPxn0U0vaBGufKuNxrMFT2n2mNU6wwytz 3CwXszAh8o9AHaMY9UdbJ/N3RRjp31+uMqnOsM466bSDvr/JzCakGjXC0wZ7SjD3oUzJYvPp66UIUB oQ0FkhNB+mIMyxppoH4frEQXNFFeE/AYhRBI0bbBEv/iEgpvXJdun9w/Oa9g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Explicitly zero select fields in the emulator's decode cache instead of
zeroing the fields via a gross memset() that spans six fields. gcc and
clang are both clever enough to batch the first five fields into a single
quadword MOV, i.e. memset() and individually zeroing generate identical
code.

Removing the wart also prepares KVM for FORTIFY_SOURCE performing
compile-time and run-time field bounds checking for memset().

No functional change intended.

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/lkml/YR0jIEzEcUom/7rd@google.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kvm/emulate.c     | 9 +++++++--
 arch/x86/kvm/kvm_emulate.h | 6 +-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 28b1a4e57827..7401a3133e17 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5381,8 +5381,13 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
 
 void init_decode_cache(struct x86_emulate_ctxt *ctxt)
 {
-	memset(&ctxt->rip_relative, 0,
-	       (void *)&ctxt->modrm - (void *)&ctxt->rip_relative);
+	/* Clear fields that are set conditionally but read without a guard. */
+	ctxt->rip_relative = false;
+	ctxt->rex_prefix = 0;
+	ctxt->lock_prefix = 0;
+	ctxt->rep_prefix = 0;
+	ctxt->regs_valid = 0;
+	ctxt->regs_dirty = 0;
 
 	ctxt->io_read.pos = 0;
 	ctxt->io_read.end = 0;
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 68b420289d7e..bc1fecacccd4 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -336,11 +336,7 @@ struct x86_emulate_ctxt {
 		fastop_t fop;
 	};
 	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
-	/*
-	 * The following six fields are cleared together,
-	 * the rest are initialized unconditionally in x86_decode_insn
-	 * or elsewhere
-	 */
+
 	bool rip_relative;
 	u8 rex_prefix;
 	u8 lock_prefix;
-- 
2.30.2

