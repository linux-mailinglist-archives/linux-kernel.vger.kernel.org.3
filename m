Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6164485ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbiAFChf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbiAFChd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:37:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E436C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:37:33 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so6909259pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6F+wgRNGA6fmbi/NQHkyKHDOaLPRpTVQjDWUyB2GPWs=;
        b=GvA3rXcKfSWrlZAUME9wINoWn7f8pSfd/2Ds8BW2zGgDk1lp8ibquF/buACF79wpwf
         sLkViwkR5MJpIdl40Vo2HcbhCdr6OjT+caVm91LhfA4phGuTC+e4WZxMJmAxmK/Nteuj
         kuj9PVQEtOT4wkME91KVVUK0ar10CNb46Djdt3hH6hoGcjTXvXGWRnE5B8Go2zPfXz2M
         1GAiZ6PQL0F6xf+BsE7Rwa5eeIj/MD7+sG5bcNqWKBxuIy5oKkck5w263IGLxfzO0S2W
         RIBuow/+T58Ik9rybBUvwYRutvEgfxhMg1h5vs8IJ/HrTCagirO7tERNYX2uvBW/yMHX
         35Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6F+wgRNGA6fmbi/NQHkyKHDOaLPRpTVQjDWUyB2GPWs=;
        b=qANgYqDGiUaUG28evXin/vm9JSE9Cu8oTG08A54Qsdbxv73uUz1E39D9nogcnYubpB
         3RaPviTo7iV+NOfeJaJYODrwnKQEHtFZVv6LWb75hR6jUBmghrN0ctsj09DZmjqC8qqE
         pgZm74gOwjBPWN8W7gBGbtla04TwJEORqWyaJMvxX9AxitB+L01h+ynAVUoa2cODGnMj
         uIZcCchIEbo3R00GKy1/GeR5fNTTO0U/94CjTyzXb8rhu7RCMhNUXRwGuTOfXyPvII36
         SO+B5lV5TwkblMSWzYixX3TtWLGt8AW9TM8Nh1GaQHb0+AFyEpzGmX4LnFJ1OGWzK/hq
         AsnA==
X-Gm-Message-State: AOAM533uaNmOrJ6tBajGX39QOu7CcSnIDOHgdsCkk9BQFPfWVzTBLy9W
        63hb+DJ2oP67J9ryaAm88Tw=
X-Google-Smtp-Source: ABdhPJzxZu1N5RV7hhwDk6hn3lgcW3Vx1ADnJ/qD/dkyPtxwow6lgw84fht+Zu496a7mZFLa+PaeZQ==
X-Received: by 2002:a17:90b:4b0c:: with SMTP id lx12mr7654723pjb.146.1641436652809;
        Wed, 05 Jan 2022 18:37:32 -0800 (PST)
Received: from szeter.. ([2001:8004:44e0:acae:b2b7:5ce1:129d:48de])
        by smtp.gmail.com with ESMTPSA id ot7sm4575514pjb.12.2022.01.05.18.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 18:37:32 -0800 (PST)
From:   Samuel Zeter <samuelzeter@gmail.com>
Cc:     samuelzeter@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/2] arch/x86/tools/objdump_reformat.awk: Ensure regex matches fwait
Date:   Thu,  6 Jan 2022 13:36:04 +1100
Message-Id: <20220106023606.283953-2-samuelzeter@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220106023606.283953-1-samuelzeter@gmail.com>
References: <20220106023606.283953-1-samuelzeter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is "wait" mnemonic in the line being parsed, it is incorrectly
handled by the script, and an extra line of "fwait" in
objdump_reformat's output is inserted. As insn_decoder_test relies
upon the formatted output, the test fails.

This is reproducible when disassembling with llvm-objdump:

Pre-processed lines:
ffffffff81033e72: 9b                    wait
ffffffff81033e73: 48 c7 c7 89 50 42 82  movq

After objdump_reformat.awk:
ffffffff81033e72:       9b      fwait
ffffffff81033e72:                               wait
ffffffff81033e73:       48 c7 c7 89 50 42 82    movq

This patch fixes the issue by requiring spaces, or tabs, along with the
"fwait" instruction in the regex match.

Signed-off-by: Samuel Zeter <samuelzeter@gmail.com>
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index f418c91b71f0..276e572a6f60 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -12,7 +12,7 @@ BEGIN {
 	prev_hex = ""
 	prev_mnemonic = ""
 	bad_expr = "(\\(bad\\)|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
-	fwait_expr = "^9b "
+	fwait_expr = "^9b[ \t]*fwait"
 	fwait_str="9b\tfwait"
 }
 
-- 
2.32.0

