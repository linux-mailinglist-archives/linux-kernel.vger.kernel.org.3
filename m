Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C659A5D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351009AbiHSTB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350833AbiHSTBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:01:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F47107AD9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:01:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso8371176pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=cXsSHHpnoTh2+F/5sCHLWMtTW4VH+4NF/mMlIkwDIfg=;
        b=ggBv9qFM7zXn0eUb/pwRHzZTrR4EqH6pCbu984mIrX/hWYDe8R+MSKXZVQb/S4PHQU
         2ttjysKIM+QdLbktXrxWJNNtR7FUN61zPG9evbLZN7KzRaY/SWvOpJgJy3Y7tzlQ34Ya
         gw7dSg0kibUFbVQkFj7kkKfyyGcNBvUhVl6GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=cXsSHHpnoTh2+F/5sCHLWMtTW4VH+4NF/mMlIkwDIfg=;
        b=HAX540CIVsUmb3JprnZ8aMwijNWhWB5RC1YFyvH/iz1PEmHRUz53pwt1nNjhBwNNfQ
         nU0pLIeugrrzzuLBZ7UQ9t3WVPctxNCUqfV9Dsi30GE/sMSwQ+JmRTo2uLHUF9R+dXyG
         2EflfKOkmQb2D82qCTBWkjSKLSgm43lSfcHMOy9xWS/EbiNA+8JxQsWrreAxeWIpJbJa
         tOxwblgJYzDlLLv/nwYDSEAz0H9Rbl/ydxEd0zGuzgdGnsaKuNzbFBH+xFzvdEtmTe5K
         PNOwVrqfPpRaMOKt/M4lOis8H1rmzbjvWIxmJy6REGQ7sBLmGw0xC1WrVbS2s0/O3JPz
         IU3g==
X-Gm-Message-State: ACgBeo0CZUCiQuldV46wZIeMnCRehMS+rXvFMOSxw7qlYmd0Sw321QBu
        sVXYx3mFb+DvZ7MMQS2OQjrG9A==
X-Google-Smtp-Source: AA6agR4d+h6ax+4AOqMh7T81NqJrBcgS7o8oaZ36P3VqJG2jgW7aZyd7vkb6EvK54pDa5fJ45vqQRg==
X-Received: by 2002:a17:902:b109:b0:170:9d92:4110 with SMTP id q9-20020a170902b10900b001709d924110mr8265278plr.32.1660935677172;
        Fri, 19 Aug 2022 12:01:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b0016c6e360ff6sm3544018plf.303.2022.08.19.12.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:01:16 -0700 (PDT)
Date:   Fri, 19 Aug 2022 12:01:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Erhard Furtner <erhard_f@mailbox.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: [GIT PULL] hardening fixes for v6.0-rc2
Message-ID: <202208191200.C8B461644@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two kernel hardening fixes for v6.0-rc2.

Thanks!

-Kees

The following changes since commit 27603a606fda0806d7c08914bc976931aa42020e:

  dm: verity-loadpin: Drop use of dm_table_get_num_targets() (2022-07-28 21:48:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.0-rc2

for you to fetch changes up to 012e8d2034f1bda8863435cd589636e618d6a659:

  gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin disabled for a file (2022-08-16 12:25:53 -0700)

----------------------------------------------------------------
hardening fixes for v6.0-rc2

- Also undef LATENT_ENTROPY_PLUGIN for per-file disabling (Andrew Donnellan)

- Return EFAULT on copy_from_user() failures in LoadPin (Kees Cook)

----------------------------------------------------------------
Andrew Donnellan (1):
      gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin disabled for a file

Kees Cook (1):
      LoadPin: Return EFAULT on copy_from_user() failures

 scripts/Makefile.gcc-plugins | 2 +-
 security/loadpin/loadpin.c   | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
Kees Cook
