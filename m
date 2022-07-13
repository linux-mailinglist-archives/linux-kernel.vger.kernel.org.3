Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D8573F14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiGMVi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiGMViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:38:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAEA2A266
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:38:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s21so213026pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lurMWUcG4s0OCKSjs9Fij6iTynFLR09e9zya2710FIs=;
        b=C6nUxpEJ/UmAtarhlucdk0ULsOSkMhkH7Sh3nT+1a/ajverxLrdWBFRWJZq/SgUfyo
         CRXIGW9sDRjQFW9nB7BQTz01GncFR+bUZvhb+gmaLRv5NxG6SoxaJA1ai5YG1Rb5kq88
         uHvrJHW9v6eJGJZ5vAheDXO6Zsy8+rlMi3aFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lurMWUcG4s0OCKSjs9Fij6iTynFLR09e9zya2710FIs=;
        b=guClWbw7adGw4AmmFOVwHgFaWXyq7lkwkEBHhWmAv779orNouTK0aywkYUnLewVRBA
         yMf5J19IGkINGHydhac4Vf7bzXOuJzQd3gZabXZP72u3CVTQt79rvQNBP8jEpzglLPHN
         MO1sRyZn6kwg6mCGrvCFXE1TnWoj0r6wfiqc277QCiRl2NWomMbpHiHMuslzrst56RH6
         4bSO8kQlY8FTKXFRJUSbQUwyNgQaI7pMdcI3aYIRx3uO5MHhnd/KeiHAgEvyguCVSXnh
         eMcbdxCNj5ng7IKPek1/7RFt1G8b/cNqdk6foFVhyCXwxwZsh6rBe8EcgKv1VXMO0K6H
         +ssA==
X-Gm-Message-State: AJIora/3c4JKdCyuhTnC67sumtMnrBAPhsSc4nNfMY9Ot7+zP0k+kjqS
        +vZOhXYTxi/J3ybmmKZl6qEdbQ==
X-Google-Smtp-Source: AGRyM1tbFJ5f7N8R3a0dTpiKUwcwDDddPpxAjz6tw0rL0HZtzMH22AwHPObeyTK91pHVgcdQ1ncG6Q==
X-Received: by 2002:a17:902:d543:b0:16c:3150:9ba1 with SMTP id z3-20020a170902d54300b0016c31509ba1mr5342786plf.13.1657748301037;
        Wed, 13 Jul 2022 14:38:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w21-20020a1709027b9500b0015eab1b097dsm9265814pll.22.2022.07.13.14.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:38:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] x86/alternative: Report missing return thunk details
Date:   Wed, 13 Jul 2022 14:38:19 -0700
Message-Id: <20220713213819.460771-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; h=from:subject; bh=7cnQiPZSGEknMQkpYjY7msOmH6Um6L2HCGQYcllKfLc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBizztKmJqtG/dxRcJDzMP8KXL/haFB9JSxlG9xj+6e h4IDx56JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYs87SgAKCRCJcvTf3G3AJu/tD/ 9/y9aOcm+spyA9HZ5VbanIfGAcrKrPRJDwjq8oNgTY9DHsP3UYb3CNMrw12t58IYq7jrajV3GHT++6 /5Rs5dFlpuFSD5CAVXcsrrHPqv9plbu2FlI5BCBQvuVDRP4xassz5UdD1QCYCuW0uFoyxUyvcszqKH jsvXhm5qlCrLDsIcC6syp2l68m5SB7pP+xix66TYjQ+gZg7s6LEe8w3fFe+MMZrltVY+0671JAOfqz szknXi81Y/YkdR+16uM/NLrwpUyJXw/P2IbxYuBHg+adCVWTwfn0juzfgu/74iaX73y4fs62uCAPaL 3xxyyHKp1Ej2Nj4CWJtPLCDqA1aH9cM+GmHWfOYFHpSRppstIrodZlLFV6KpdXnxJZOhuw8DfTK1uT jYwmPQgeyRCeNZeMB7QJkmt/Y39ErOWLEkpxkf2F0WzAGa4W/HTg/FCWauJ5ZcBCmrQH4UjttrQsbn QX4mbYFBjEJMSHu93ouo0oi37RM4Yt+EdFzM+uoX/USvwphwAXBLIbTaa4QdEc54sIrfwWrLD3/S+V 3I37HYxwdr5md3jpIAmVM/HGnzsMETEHInWH+2ddFZG4vepwZoJDJ5t2f0hW/NoHWYTSCI0i/VXZNv 4eI3cRgDDGsyGxWZN6DxJB/DgsvY/Pc6fg2rbG/ox95Glv+eCQrkW/2pSuIQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging missing return thunks is easier if we can see where they're
happening.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/Ys66hwtFcGbYmoiZ@hirez.programming.kicks-ass.net/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/alternative.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d6858533e6e5..62f6b8b7c4a5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -555,7 +555,9 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 			dest = addr + insn.length + insn.immediate.value;
 
 		if (__static_call_fixup(addr, op, dest) ||
-		    WARN_ON_ONCE(dest != &__x86_return_thunk))
+		    WARN_ONCE(dest != &__x86_return_thunk,
+			      "missing return thunk: %pS-%pS: %*ph",
+			      addr, dest, 5, addr))
 			continue;
 
 		DPRINTK("return thunk at: %pS (%px) len: %d to: %pS",
-- 
2.32.0

