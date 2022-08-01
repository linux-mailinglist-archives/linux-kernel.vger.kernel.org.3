Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81D586FC7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiHARxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiHARxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:53:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A918364CC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:53:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso16050587pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VSwGnG8dDTn5rxoFgo7Afvv+QGLuFo++2NSwfZK8J/g=;
        b=gmzaVqgUtBekCaQCkmeGSndKJb/l3DKzYwso86ySBlGeN6Myxcv3R6fInghAMKWFki
         DBrVEzBZ1VTh234ZNamMA1PRsiJcAdrx32k9z+FJvNbjQGE+Mvh/nLIiV8DC9oD87e0i
         14KWyN9jBzKPMo4LA3yXSvCMANtLH1RMB86aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VSwGnG8dDTn5rxoFgo7Afvv+QGLuFo++2NSwfZK8J/g=;
        b=102vPo1Zrw7gchN4MYTE4JoIpR47vahQqeCGjwiwQF2ChX/dhfrEMSfPu7JmzAxe3w
         TYo+cODxPzdyCXQyQM0QvPxC3I5/kKXCL7/YgMhHTkA5QbAPOfuF8C+0a66ObAYNTzeR
         KrXfxplVoIU9gp0z+aUqu6TMO4EP4Or2EKy1NVy4kzF4Bt9NyAAU9M7mQm0Bs8gguwUJ
         JHH5uSnj9hNIgUlHjCrDbQcg2VWyCwgrRJY5+2VZEKGtX9lbttZKT8f0x6ZK2obmEZBj
         j91vonJr5t8DzWBYDI/yUZuYXDRC90arnpikmp4bHL/D/R5mrXGotTBTiaFyo8uWgt+j
         qGow==
X-Gm-Message-State: ACgBeo3MhyoBHsxUD8elGgWovRkQI0jPEf/viooS8u6s2fPirPlfgYy/
        Uh9mWFro5fsKPYQXedatyE1tQw==
X-Google-Smtp-Source: AA6agR6hePyHFGsgqRxGvjq+Sev7MC4F83mdATJE+DpVYiMCle6rLX4Uk5IUKjkkkfZ+zaQiOnrALg==
X-Received: by 2002:a17:90a:df96:b0:1f3:22e:7826 with SMTP id p22-20020a17090adf9600b001f3022e7826mr19795042pjv.21.1659376415140;
        Mon, 01 Aug 2022 10:53:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b0016dbdf7b97bsm9997077ple.266.2022.08.01.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:53:33 -0700 (PDT)
Date:   Mon, 1 Aug 2022 10:53:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, GONG Ruiqi <gongruiqi1@huawei.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [GIT PULL] kernel hardening updates for v5.20-rc1
Message-ID: <202208011044.A374B6CF83@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these kernel hardening updates for v5.20-rc1. Two
cross-maintainer notes: the dm-verity/loadpin changes are Acked by
Mike Snitzer but they have been carried in my treer; the LKDTM change
is duplicated in the drivers/misc tree (it was late in cycle when Greg
and I both picked it up).

Thanks!

-Kees

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.20-rc1

for you to fetch changes up to 27603a606fda0806d7c08914bc976931aa42020e:

  dm: verity-loadpin: Drop use of dm_table_get_num_targets() (2022-07-28 21:48:12 -0700)

----------------------------------------------------------------
hardening updates for v5.20-rc1

- Fix Sparse warnings with randomizd kstack (GONG, Ruiqi)

- Replace uintptr_t with unsigned long in usercopy (Jason A. Donenfeld)

- Fix Clang -Wforward warning in LKDTM (Justin Stitt)

- Fix comment to correctly refer to STRICT_DEVMEM (Lukas Bulwahn)

- Introduce dm-verity binding logic to LoadPin LSM (Matthias Kaehlcke)

- Clean up warnings and overflow and KASAN tests (Kees Cook)

----------------------------------------------------------------
GONG, Ruiqi (1):
      stack: Declare {randomize_,}kstack_offset to fix Sparse warnings

Jason A. Donenfeld (1):
      usercopy: use unsigned long instead of uintptr_t

Justin Stitt (1):
      drivers: lkdtm: fix clang -Wformat warning

Kees Cook (3):
      MAINTAINERS: Add a general "kernel hardening" section
      lib: overflow: Do not define 64-bit tests on 32-bit
      kasan: test: Silence GCC 12 warnings

Lukas Bulwahn (1):
      x86: mm: refer to the intended config STRICT_DEVMEM in a comment

Matthias Kaehlcke (4):
      dm: Add verity helpers for LoadPin
      LoadPin: Enable loading from trusted dm-verity devices
      dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional compilation
      dm: verity-loadpin: Drop use of dm_table_get_num_targets()

 MAINTAINERS                       |  21 ++++-
 arch/x86/mm/init.c                |   2 +-
 drivers/md/Makefile               |   1 +
 drivers/md/dm-verity-loadpin.c    |  75 +++++++++++++++++
 drivers/md/dm-verity-target.c     |  33 +++++++-
 drivers/md/dm-verity.h            |   4 +
 drivers/misc/lkdtm/bugs.c         |   2 +-
 include/linux/dm-verity-loadpin.h |  27 ++++++
 include/uapi/linux/loadpin.h      |  22 +++++
 init/main.c                       |   1 +
 lib/overflow_kunit.c              |   6 ++
 lib/test_kasan.c                  |  10 +++
 mm/usercopy.c                     |   2 +-
 security/loadpin/Kconfig          |  16 ++++
 security/loadpin/loadpin.c        | 167 +++++++++++++++++++++++++++++++++++++-
 15 files changed, 380 insertions(+), 9 deletions(-)
 create mode 100644 drivers/md/dm-verity-loadpin.c
 create mode 100644 include/linux/dm-verity-loadpin.h
 create mode 100644 include/uapi/linux/loadpin.h

-- 
Kees Cook
