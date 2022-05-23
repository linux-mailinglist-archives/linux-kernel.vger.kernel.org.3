Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8F531A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiEWTdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiEWTdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:33:40 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8810BA774C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:18:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r71so14523673pgr.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=geAnGwGZeOVDnERCKEkbiFQECD+yZAWuAA2groNZJl4=;
        b=KhR20UPiAVSdoaWSNSeOYGq4UvU8JUyD/aYozDK7s58U2fWGxBlVsIsLzQ6/xSOL8d
         pnMv+S7pCdcm04CdJ8I+oYzN5Luf8P9xmYlF9e7PINjgxiEXBQWbMjML5YRf7TD2SlGg
         hlhMaouKIgFMowDdl/129+EuIdjtZxNySzZr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=geAnGwGZeOVDnERCKEkbiFQECD+yZAWuAA2groNZJl4=;
        b=Z1hQVnO7rZfffsM+lXMXm82igm3oBSRnK38/HnulK1aUCcm18zlLl3N0kSN4TNKu4B
         4nX3Fo7cRMrP4Z1r/TM+kE/ziXA4Fp2vLuTLr8Y6LzNdjzwthwRRCLzS2Uj5WKZiibwG
         sjZkFVBt5h0ujs+PjVvggv26J4Zfo835zQdE8VjkofzCTUxBGzH4CHMqmsxosLPszs9/
         ZbgX4tVu4sTTip1pcMEiLA2BfXgsOpm91dzB2XqbChrjgeT79S1/WvWezoSjao60h9Dn
         u7Bn1XE8l8mV9xw7Nwyf+3M8IfhIOsyPKlYgKTZlFQt/RDiHJf37XzDczpCuHyMYL4vF
         2Alg==
X-Gm-Message-State: AOAM5318oOjSrDzEmNjcvnNXm4xY1cPN+O9yYOwIf9TEWtZBLf4HfSyR
        sLFspItK7uCN+BbkUoZypbnWPA==
X-Google-Smtp-Source: ABdhPJwJWxhPVilsqx4KRoB24cp2AgZEG8o6Ap7EI9eoXBA1GihVesKobZIwkUY719IvJqC+IKA8qA==
X-Received: by 2002:a63:4666:0:b0:3fa:287f:b714 with SMTP id v38-20020a634666000000b003fa287fb714mr7747712pgk.398.1653333538118;
        Mon, 23 May 2022 12:18:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o4-20020a170903210400b0015e8d4eb1f1sm5445793ple.59.2022.05.23.12.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:18:57 -0700 (PDT)
Date:   Mon, 23 May 2022 12:18:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [GIT PULL] execve updates for v5.19-rc1
Message-ID: <202205231218.4D24FEDCF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these execve updates for v5.19-rc1.

Thanks!

-Kees

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v5.19-rc1

for you to fetch changes up to 70578ff3367dd4ad8f212a9b5c05cffadabf39a8:

  binfmt_flat: Remove shared library support (2022-04-22 10:57:18 -0700)

----------------------------------------------------------------
execve updates for v5.19-rc1

- Fix binfmt_flat GOT handling for riscv (Niklas Cassel)

- Remove unused/broken shared library and coredump code (Eric W. Biederman)

----------------------------------------------------------------
Eric W. Biederman (2):
      binfmt_flat: Drop vestiges of coredump support
      binfmt_flat: Remove shared library support

Niklas Cassel (1):
      binfmt_flat: do not stop relocating GOT entries prematurely on riscv

 arch/arm/configs/lpc18xx_defconfig |   1 -
 arch/arm/configs/mps2_defconfig    |   1 -
 arch/arm/configs/stm32_defconfig   |   1 -
 arch/arm/configs/vf610m4_defconfig |   1 -
 arch/sh/configs/rsk7201_defconfig  |   1 -
 arch/sh/configs/rsk7203_defconfig  |   1 -
 arch/sh/configs/se7206_defconfig   |   1 -
 fs/Kconfig.binfmt                  |   6 -
 fs/binfmt_flat.c                   | 239 ++++++++++---------------------------
 9 files changed, 66 insertions(+), 186 deletions(-)

-- 
Kees Cook
