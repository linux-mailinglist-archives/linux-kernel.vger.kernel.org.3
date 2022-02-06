Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E54AB10D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbiBFRpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344844AbiBFRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:45:17 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B853C0401C0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:45:12 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q132so9626696pgq.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vqdb+IjvR7W8E5ZbYWXJikM0js3mZmH+zUbAZQxhgw8=;
        b=CD2cSm+Jq/YqWHrsk91+IgI6ZtNrSFWIZi4U225H/t3jQslCYy7ZusGLWFch+Nqa5o
         6cf8TP6OuQL4NNV/YI9/dN29UEneYoQDDCjSI2vFPM0k+6gBBXmBNREyEc2cLADqQR98
         3+OJykZ7Y+YwhWGkvn/y6NFZOkBdehWpaiagw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vqdb+IjvR7W8E5ZbYWXJikM0js3mZmH+zUbAZQxhgw8=;
        b=14DvGd6EoN6FdSu7VXJbpCrgNBxx3migwyyXYFA1Cfjmp4820ShKeC7muie8UvnLI9
         8jn101qXtggaIutP5iHgp7Z0Oz9RZ6End3bV4xWCg4k3mDL8uJS8b3wOjZvfXp/HFuw2
         bT3r07dRag8fWGkFtmXfRR8zGpAIwY3H615RDm/4J1lkikh3NvV+cvxdpiydXgSU39As
         jakbcjgOiY38x0iyYG1QmxKj0KzN6azz8/pcAywes5A/m1P6sJeXKxa+YxneOV15s5cZ
         sHx51+BQ4YZrPD0lOUMk7yb07wymCC/0J6baMs2NEb3euHYRLeNlbAXzKao3Hmd5nF96
         Su0w==
X-Gm-Message-State: AOAM532oH/RCYBLzWyTBbXR61aPuRTLY+vXbTN1vuW4BoyPHV75RPzBI
        XUhZ2fBrXKfyekRcgKkj/XlCIQ==
X-Google-Smtp-Source: ABdhPJyEofsTh8CiCMqluEuIuZ1SrpnKNOKrVsxFi0C1QiJP1PbwZoDra0ohb1ZaCI+aRJ92f52J5w==
X-Received: by 2002:aa7:9d9b:: with SMTP id f27mr12269201pfq.84.1644169512496;
        Sun, 06 Feb 2022 09:45:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f3sm9537609pfe.67.2022.02.06.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 09:45:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] gcc-plugins/stackleak: Ignore .noinstr.text and .entry.text
Date:   Sun,  6 Feb 2022 09:45:08 -0800
Message-Id: <20220206174508.2425076-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206174508.2425076-1-keescook@chromium.org>
References: <20220206174508.2425076-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; h=from:subject; bh=pVDpB0fLeXzkw7qtOTlz2Xjee/LCaGQ3lZV5lGGvWcE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAAkjkTUerpEggmIzHyPJuyDEgbgzPKYmgGRrnVOi cs5tNtOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgAJIwAKCRCJcvTf3G3AJhwwEA CMMwXjllOJPlCgUdB/Vxpjt1yZo3bgDDu0djnWckBM5Fdstv8Pm9MoCDUdWaCOhgCM5JWYowz91COz e4xHfc0WiPZE9YvNSQ/HjlAewWRP0D4Qdfz3hRfxBL2h2lqOAD/kqbkbJutoB0FvsaR743uPk9lfsY S904GcaCkeMn7wBkzR/jEiJht7Z0TmKDahakj5yOfUiQXKckEO/k+NqdrfxjEQdJlJgNHusa9aREVG z4M/hxIuTSBZNjkI/zU/CJtPsZcxODRzsof+af4XcbH/wWHZGetGx2MyTThL381ZheVCCz/MPjvhDN 1OBV4wRzNrTCWrsUAiTCGLFgcAa6quWbqGJQ7Vg++5UXXjY0bxWSCea4ouYA9G8uLyUhUYjkp1ch30 yozbt2bpcWX5uwGFrIO/yjv52WnpDwwpSLnkbNkDiJSVRkMtAmoN7npt5M/stzHbZgEISVGONmcbNl cJERD8Whq8p9RQUM5KuSTCfl/BMoxDfDuZfINCB6TCG497jTLQq0+OEJ2D+9XklmTFYmVn5JqIjK32 SQxtSUW2Rg+2barzot9TFsjVzZXaXAO9ntsYn4Blm4vWEFxvaaBkJAy0OuBRU2HFA1Ib6MUxBLe9Es gqI1DbTc5+7Aw8Uzt1vfvxXR9+2IKquvEnSkrNpMrLT6gWPd801T5o2S9Hbw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .noinstr.text section functions may not have "current()" sanely
available. Similarly true for .entry.text, though such a check is
currently redundant. Add a check for both. In an x86_64 defconfig build,
the following functions no longer receive stackleak instrumentation:

	__do_fast_syscall_32()
	do_int80_syscall_32()
	do_machine_check()
	do_syscall_64()
	exc_general_protection()
	fixup_bad_iret()

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Popov <alex.popov@linux.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/stackleak_plugin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index 623bcad6d0c7..c8dc7fe4f959 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -463,6 +463,10 @@ static bool stackleak_gate(void)
 			return false;
 		if (STRING_EQUAL(section, ".meminit.text"))
 			return false;
+		if (STRING_EQUAL(section, ".noinstr.text"))
+			return false;
+		if (STRING_EQUAL(section, ".entry.text"))
+			return false;
 	}
 
 	return track_frame_size >= 0;
-- 
2.30.2

