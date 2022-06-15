Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF854D34E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347569AbiFOVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244563AbiFOVHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:07:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83C33EAB2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:07:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so3147759pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aFmjegxJ0x5HkJ5J9CQ9V8AxruB5OQZDckAfYicQBNM=;
        b=m9GXhxfL68ZZHpInHwCBDJm5U+2Pe8SV3ihjEoIrZDoTuOdytL7YlSJmVVexCYF+4X
         Twhc1EH/Jj9pCQOVJYL6IzH8GxtVtp+03YlS6bqFEngysw/5ke3cTiHElgmays0oodeS
         huteevd8TSr9uj2enNkl8iwAsZ01jpZ+3MAH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aFmjegxJ0x5HkJ5J9CQ9V8AxruB5OQZDckAfYicQBNM=;
        b=nTDqI8zYCpBMlXv9jAo+V94pgfiYZ6wevQPKWDsG8K97xbw7eKczNoMgA3ouGN96U8
         AknWKyq/MDyiPaux9E7SZQYLwY0zzuCX9GdaoNZ+Kmv7X8MNtFNb306ytsnDWo6aYhy6
         o6rGoRRyGktDMKCAcgGhVIL6OfAPkGJ3KjHhzdH+PfYY5FucGUeh2exQtGBLYJhBWKzK
         pQDCrqCsfUI804T0MQQpsSZ4kphCViZCajg4gPiVkw8r8+lQhbzPzf7y53owJWB5GoOg
         oNH4yuOnT0VP90GjP5xPMw3JuxCLq4bXwRq3mPQsgsCneI5kOwM0SkbsULpmTddxn+9O
         gHcw==
X-Gm-Message-State: AJIora9IWKW0zNHXrey6NeMhAYLkYegNjVGWPU5i+5tHH+282bMBssrV
        GoJmfR3bo+b4/D1avadIGXmQaA==
X-Google-Smtp-Source: AGRyM1u5xnZMie+HzmezNlX/Hm1QnUY2FGdgDouirmOZANOOLWGB+wkAvsFrZAHfYeSd+TRofm02Kw==
X-Received: by 2002:a17:902:7085:b0:168:97dc:ddde with SMTP id z5-20020a170902708500b0016897dcdddemr1597817plk.25.1655327226160;
        Wed, 15 Jun 2022 14:07:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b0051c0784cb45sm86203pfk.99.2022.06.15.14.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:07:05 -0700 (PDT)
Date:   Wed, 15 Jun 2022 14:07:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zorro Lang <zlang@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [GIT PULL] hardening fixes for v5.19-rc3
Message-ID: <202206151405.D8EDB70EA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these kernel hardening fixes for v5.19-rc3.

Thanks!

-Kees

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.19-rc3

for you to fetch changes up to 1dfbe9fcda4afc957f0e371e207ae3cb7e8f3b0e:

  usercopy: Make usercopy resilient against ridiculously large copies (2022-06-13 09:54:52 -0700)

----------------------------------------------------------------
hardening fixes for v5.19-rc3

- Correctly handle vm_map areas in hardened usercopy (Matthew Wilcox)

- Adjust CFI RCU usage to avoid boot splats with cpuidle (Sami Tolvanen)

----------------------------------------------------------------
Matthew Wilcox (Oracle) (3):
      usercopy: Handle vm_map_ram() areas
      usercopy: Cast pointer to an integer once
      usercopy: Make usercopy resilient against ridiculously large copies

Sami Tolvanen (1):
      cfi: Fix __cfi_slowpath_diag RCU usage with cpuidle

 include/linux/vmalloc.h |  1 +
 kernel/cfi.c            | 22 ++++++++++++++++------
 mm/usercopy.c           | 26 ++++++++++++--------------
 mm/vmalloc.c            |  2 +-
 4 files changed, 30 insertions(+), 21 deletions(-)

-- 
Kees Cook
