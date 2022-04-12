Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499194FEB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiDLXro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiDLXre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:47:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C845A0A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:36:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q19so112757pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lsjiEN+d0xZGpOa6pBRhA8BLrqhGEqU8HFO3kGnSCPI=;
        b=VZNUqcxsE+nn+FVrg6BFkNkc6vXP1YlUE1sFuNoCxVDWqxucoULbUz/CpSmd83Lc/q
         mHzY3lTx78nZRBMyz2qVont05w3lGFdha9DFWOGFYHgr7FGBnAzRaht8qy1cGPcKSMKY
         yag/toW8nrSeocJIAw5WpTQz1WnIssln4Gso4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lsjiEN+d0xZGpOa6pBRhA8BLrqhGEqU8HFO3kGnSCPI=;
        b=yyLWt9bmBd1UBB/nM1yRPiE7xyFVLSQjgqQesbL8a4NphQXiahIuxL4dYDcwDhJCtp
         /l9s0vCgGLVL+vdpZDpainPFgj+Xb5ddDs/8zdlEJmjvg87oS9fdy4GOjggbSnq6GlYU
         2OYvU0ZGekz0nOzT3+52oop2H/Z3HvpnSeb6ueDoRFT+oYGlo91+gX9VJ+Ny3JgfkYDb
         oUv6GqtsYS6Hs0tYQ6RhYjVRmDPVcrMGjBmWqGDpvpDfvf3tqqEA5nJWIaZQ8Az6puLG
         v/Gv5l7a6oIo0Jm931hHA6vBM6srbIk6/l4q59/9+YQAA1uCnIfkPE8i1pU4zuXMQqZg
         YjiA==
X-Gm-Message-State: AOAM531eBdtRR44iJMGocpcmNXsPKVMJaLnN988VawioRRL0CQ8qo0Wo
        6G2A6SJj++/4tst9AcJWaifChg==
X-Google-Smtp-Source: ABdhPJzhc14w95kxvt/O2AfrhOBb6YknE6CgG0xg8llGhBfyZwWt1tIZb0ewKycpFezbehz3olXgbA==
X-Received: by 2002:a65:4503:0:b0:382:aad5:ad7d with SMTP id n3-20020a654503000000b00382aad5ad7dmr32829979pgq.488.1649806571727;
        Tue, 12 Apr 2022 16:36:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a000b4300b004faee36ea56sm40665728pfo.155.2022.04.12.16.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 16:36:11 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:36:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [GIT PULL] kernel hardening fixes for v5.18-rc3
Message-ID: <202204121635.BCF6C9C4D3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these kernel hardening fixes for v5.18-rc3.

Thanks!

-Kees

The following changes since commit 229a08a4f4e4f9949801cc39b6480ddc9c487183:

  ARM/dma-mapping: Remove CMA code when not built with CMA (2022-03-31 11:19:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.18-rc3

for you to fetch changes up to c40160f2998c897231f8454bf797558d30a20375:

  gcc-plugins: latent_entropy: use /dev/urandom (2022-04-12 11:31:40 -0700)

----------------------------------------------------------------
hardening fixes for v5.18-rc3

- latent_entropy: Use /dev/urandom instead of small GCC seed (Jason Donenfeld)

- uapi/stddef.h: add missed include guards (Tadeusz Struk)

----------------------------------------------------------------
Jason A. Donenfeld (1):
      gcc-plugins: latent_entropy: use /dev/urandom

Tadeusz Struk (1):
      uapi/linux/stddef.h: Add include guards

 include/uapi/linux/stddef.h                 |  4 +++
 scripts/gcc-plugins/latent_entropy_plugin.c | 44 ++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 17 deletions(-)

-- 
Kees Cook
