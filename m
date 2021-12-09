Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D25046E1BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhLIFL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhLIFL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:11:26 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35395C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 21:07:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id np3so3534073pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 21:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oAc97uz2Cujqe9KFIgnuc9y5PwmUaHTfcJnGM0LYlTM=;
        b=hzVw2WlgWT+n2fokbrz+vPrl1Fvko1T4p4j8g82IVa6WBD30MO0Z2ZcNGf0aPqtS9e
         wIa1wpat9swFKgNduKo1OTZG+DRN3C1v3q3iOOIksw6IgiyFRvTK7wB+V7p7r0pZw82v
         dsugPtXIUWsFbVrD/keLyM3owwB5OM8sttnqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oAc97uz2Cujqe9KFIgnuc9y5PwmUaHTfcJnGM0LYlTM=;
        b=byix36mtLQ1ndnIeA4K3ZJEYK/d7RBk2l5NJ6yFjwSMi+F8Rn0YsGaldMZ9urmvx2C
         a6TNykUFj5ZZEHRQscg4zhb5CLAOkHQF+nBox7Ni4UArK4dzpSl9mEGPdmYi+EXgmBTd
         qxvOI9HblQUKl12RzsfPRJVcgn/wVJI8Lit760qMeATKOLnE5YaDvgGE9A3+/ayNfQ8E
         2qiv/IJr8eq5kdRIPd7xWNuoeNZRHiMdVf+NQjEhZSb07LN0i03ctitWjZ/YlImtw5ft
         3nvNLmAXHwXxN4OgA2kb9mIFIr5eA3L+dQjoiiahR81lnBhuYXNVI+d9JVKAiQu14NZm
         UdNw==
X-Gm-Message-State: AOAM530M1tvWxCxq2efRshPIPO8cc/GtO+TuBFMc6wD6zuIEWiifmSIh
        5IKwjPMLQAFZ1tCQc8/MWQHVFA==
X-Google-Smtp-Source: ABdhPJzlX3NyyqZi6qmRsJyuu1pf9MJan5+mqXSsAqrMOgSJPV6WtN88xlUoNYPYv7C0HWsHNNPRjA==
X-Received: by 2002:a17:903:300d:b0:142:744f:c74d with SMTP id o13-20020a170903300d00b00142744fc74dmr66055721pla.26.1639026472470;
        Wed, 08 Dec 2021 21:07:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 59sm4273835pjz.34.2021.12.08.21.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:07:52 -0800 (PST)
Date:   Wed, 8 Dec 2021 21:07:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: question about all*config and COMPILE_TEST
Message-ID: <202112082057.C993DC6881@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

tl;dr: is there a way to force a config default to "off" under
all*config builds, but still leave it configurable? (i.e. not "depends
on !COMPILE_TEST")

I'm trying to understand a Kconfig behavior with regard to
COMPILE_TEST. I'm able to use an "all*config" target, followed by specific
additional config changes (e.g. turning off KCOV), but I can't enable
things like DEBUG_INFO because of their "depends on !COMPILE_TEST".
Whenever I want to examine debug info from all*config build I need to
patch lib/Kconfig.debug to remove the depends. I was hoping I could,
instead do:

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0e2de4b375f3..e8533ffc92c3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -212,7 +212,8 @@ menu "Compile-time checks and compiler options"
 
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL && !COMPILE_TEST
+	depends on DEBUG_KERNEL
+	default n if COMPILE_TEST
 	help
 	  If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.

Which would turn this off when COMPILE_TEST was enabled, but I assume it
doesn't work because an all*config target turns everything on first, and
therefore this "default" gets ignored since DEBUG_INFO already has a
value set.

I then thought I could use:

	default !COMPILE_TEST

since this works:

config WERROR
        bool "Compile the kernel with warnings as errors"
        default COMPILE_TEST

but I think the above is a no-op: it's the same as not having
"default COMPILE_TEST" when doing an all*config build: it'll be enabled
not because of COMPILE_TEST but because of the all*config pass.

How can I make DEBUG_INFO configurable, but default off under
all*config?

Thanks!

-- 
Kees Cook
