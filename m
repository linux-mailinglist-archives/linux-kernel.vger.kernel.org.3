Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F04AB10A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbiBFRpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiBFRpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:45:15 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2AC043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:45:12 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u12so2368573plq.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6O2o8pG50xk23PLXPp5+UKk+LzVl21UwSd+T/RY4xM=;
        b=Js3Gu6abALq+9Rw5jzow76VsWNdYKgRb3cosC0c+nCrMduq/KxnH9S9oDgjFr1Y38O
         Kg8zxMG/u1p32rKiag+YvBC1OUgV+iFZMgQPspJlzvA7k0Om8N6Sro+XLP+MHYlqBke3
         Cx6xWQIcYFEChSDwzbfJsPiNZYZgBW/w+DHBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v6O2o8pG50xk23PLXPp5+UKk+LzVl21UwSd+T/RY4xM=;
        b=22o3Ug7IoVC19sJdhg9R0fGe9d6M/pSMxXX/ABPNcCeQsKQw6k6fz5lDZ1lWHwQYVR
         vQCQLZkO/y5JQjkhXBt7wnjnqJudRDyEU9kAfE3JybSSKAAajii3ZRP6jUKiE5GdQI4h
         Tvx7ESwL2D/Tbegxdwj5QB+uIFmB5SvhJV6vkhOMr8fngVvBef+wNKGYHLCxxWs6AS8q
         ZWM+wPMFbwywRFN0GHKqqWifT1YltZ7jPAGAyxW6oNzK9oLnst8FxhUIWZ2D1iU43hb6
         FvLJrShM7pEk2h1qcpJdGIQ/JCL2/ulaBwJX/ranvdDxKxk9ngwowDpoEgaf39Q+ooD/
         TkRg==
X-Gm-Message-State: AOAM531tqEsrrk6Raqzi0oqQWAqK9VjPYkQEEGlxrN+nxPcF5KSfpK7u
        WSsXnCrFwoRpJxhyqwlKIkjwJQ==
X-Google-Smtp-Source: ABdhPJxSvg4hChq0huexNav4rWvjba195f+0fA1dkTHKBmy7VjbGGLnAN+3xEAuI9rFWpjLkyYPwNg==
X-Received: by 2002:a17:90a:ec0b:: with SMTP id l11mr14212735pjy.200.1644169512190;
        Sun, 06 Feb 2022 09:45:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c12sm9988585pfl.130.2022.02.06.09.45.11
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
Subject: [PATCH 0/3] gcc-plugins/stackleak: Ignore .noinstr.text and .entry.text
Date:   Sun,  6 Feb 2022 09:45:05 -0800
Message-Id: <20220206174508.2425076-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=759; h=from:subject; bh=9Mpxe73Kgm9+18b3DRYv4LkxSc2djAQZd/LwhBPfIKg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAAkidd+gsthX8X4I2aZfDT4Z+LaGVX4rQib9in1s dFliP0+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgAJIgAKCRCJcvTf3G3AJhiID/ 4yXopOsjb2jNaBgv82czSWfbFloMfBRc9u6JvZQI/3D6b7aEnC9U4dhHnZBamcKRz6axTehlK6WwSV bUsZ7IN/8jafYXD6xLg8q1XPUFDb7DHxoncKSSzSaCbqGIDgMP8QqX5Rv8zbAy2F5s6dbDZgYrq2yP IvC6nGBc9DsFkbHKHzeN6wWSL2chZOXinqJDqTcC6E20r2FKsYbBnN8bBDKb5qTGi8iqgRzUoFW6yP vqO5u4AIujbIY2wl8yFSwDfRHaOKHCgGgLGy1r1wyz8egJdgksUjajewORaCowrNVEkD3Cf+uGThZC BCOhZEUwgs/7xycCK7wzpumWAGYBbJAiHGLaqYlPiRE321q7cAgHWyENloEfaB+2cRuNE01pkd1BbC jzxiUAOvzbeTt+lzdh4W69JjQ8Aeu/rBVbcqefQVhwBRf+zntZYvW4xm0oXFxeffSgTWSTV89XF4Yh 54BL1yGQKIcKiV5jZk8wzYT2a4ZemmapQVtcVIbgvjYPsze/d92lmsJqxI/M1izyzuSzJxyaC2AUW9 Gn5Yj8N3l932eHuDYYR5cl2p5Aa8XjRVHS4qHNZXsVOVxqJRmzpUoUGDk6Ub7aGakDiaqKCeOvPKZU 7mUMLYPmU0L//Y/zttSZi1IF30Aoy8ZNGQJlW+LecLNLpE0wbkW+gFy755Ww==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Out of an abundance of caution, do not perform stack depth analysis on
.noinstr.text and .entry.text section functions, as it may be possible
that "current" is not sane.

Additionally, to verify results, the verbose mode is wired up the Kconfig,
and the string matching is refactored for correctness.

-Kees

Kees Cook (3):
  gcc-plugins/stackleak: Provide verbose mode
  gcc-plugins/stackleak: Exactly match strings instead of prefixes
  gcc-plugins/stackleak: Ignore .noinstr.text and .entry.text

 scripts/Makefile.gcc-plugins           |  2 ++
 scripts/gcc-plugins/stackleak_plugin.c | 29 ++++++++++++++++++++++----
 security/Kconfig.hardening             | 10 +++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.30.2

