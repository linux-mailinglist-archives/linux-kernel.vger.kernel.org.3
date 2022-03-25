Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7854E79AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245683AbiCYRMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiCYRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:12:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872D7C12DD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:11:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t4so3873472pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRLLN0nP5/RoZpBXrFtCQIhtCHUrUR5HmoWhmD7h+8s=;
        b=GbpHBjlK4o+gHNg8WkkGA0RCOdc8Z5PW0JYiKuvhnC8HnOczEyVRVKK015lH3RPLjA
         M1A+ff/kLZEf7g4Xve+PTOLovMX0Ql8EbsZiEBs0aTrOIkLnNc0X6sZbWnS+HhLE03ek
         v4uMCE/H1gQkabyBz2lb1BBTGl7yXrj2LkXB9GvKVAmncju0odfabad1mRH6ID9TaRKN
         UlQeVqhAankb1YjUSNZSNvGHSoltBe7lD1np+uA2mFbx7TM3PMh6HmA5+aWmbplrohZ+
         Her9GMzczeAk8RmFPjnIMV9AaA+eA6Fs8zBWgrazYEhCYeZPwKmje3umIkD5Oru+wC37
         yikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRLLN0nP5/RoZpBXrFtCQIhtCHUrUR5HmoWhmD7h+8s=;
        b=1bDzmRoaKXjzsdF3h4MOgXhxwR2cthyNvAZITK156p1sVL6d88plYVCVdHTRobAzo7
         2+jXPER6SVNQJV4tjhyq7pN23bdlbYgbCt3RiNv8LL0EqdlyjJpXRTUONrirvwn/Daf3
         km1O5BpwuVazhEsBf8QEmzi5emZMZX0dVFg22TKkjTr+YFe0FhU6ZcCofwFPdlWvDM6t
         KXbeOn9SO4taAbj5yhXZ1yDrktoEx9T+wB9VulxnLpoPkbz2vgTMIpkJdVedDiIAEBFy
         k0+kd5VIgvyYmw09FmohKK3YIwRnV4HtMr3uyERWxLRrmL5fzTjkP13IGhDQJfoybp91
         l+CA==
X-Gm-Message-State: AOAM5338n172bGJ1UkW9/ORfCgNotWF3Yv5ZsxMThmxARTQKBDwk28CO
        5Mz4uMUisX7FP9503pZD+VqQ7gXfpSliwg==
X-Google-Smtp-Source: ABdhPJyoF3kJPjgXvAs21cHp8TGA72qw4lvjDwamhGVN/+o5U7zK5DqgENFVR8256cIpZ5VLoO+VSw==
X-Received: by 2002:a63:eb13:0:b0:382:1cd5:7d06 with SMTP id t19-20020a63eb13000000b003821cd57d06mr467345pgh.280.1648228270995;
        Fri, 25 Mar 2022 10:11:10 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:7734:79fa:d15c:6089])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a001acd00b004f76d35c1dcsm7169388pfv.104.2022.03.25.10.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:11:10 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL v2 00/18] xtensa updates for v5.18
Date:   Fri, 25 Mar 2022 10:10:59 -0700
Message-Id: <20220325171059.111208-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following Xtensa updates for v5.18:

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220325

for you to fetch changes up to 1c4664faa38923330d478f046dc743a00c1e2dec:

  xtensa: define update_mmu_tlb function (2022-03-22 09:45:09 -0700)

----------------------------------------------------------------
Xtensa updates for v5.18

- remove dependency on the compiler's libgcc
- allow selection of internal kernel ABI via Kconfig
- enable compiler plugins support for gcc-12 or newer
- various minor cleanups and fixes

----------------------------------------------------------------

Changes v1->v2:
- use https:// URL

Bjorn Helgaas (1):
      xtensa: Remove unused early_read_config_byte() et al declarations

Jason Wang (2):
      net: xtensa: use strscpy to copy strings
      xtensa: use strscpy to copy strings

Max Filippov (15):
      xtensa: rename PT_SIZE to PT_KERNEL_SIZE
      xtensa: use XCHAL_NUM_AREGS as pt_regs::areg size
      xtensa: add missing XCHAL_HAVE_WINDOWED check
      xtensa: add helpers for division, remainder and shifts
      xtensa: don't link with libgcc
      xtensa: add kernel ABI selection to Kconfig
      xtensa: make secondary reset vector support conditional
      xtensa: fix stop_machine_cpuslocked call in patch_text
      xtensa: fix DTC warning unit_address_format
      xtensa: merge stack alignment definitions
      xtensa: rearrange NMI exit path
      xtensa: clean up kernel exit assembly code
      xtensa: enable plugin support
      xtensa: fix xtensa_wsr always writing 0
      xtensa: define update_mmu_tlb function

 arch/xtensa/Kconfig                         |  48 ++++++++++
 arch/xtensa/Makefile                        |  10 +--
 arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi |   8 +-
 arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi  |   8 +-
 arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi   |   4 +-
 arch/xtensa/include/asm/asmmacro.h          |  34 ++++++-
 arch/xtensa/include/asm/core.h              |   7 ++
 arch/xtensa/include/asm/pci-bridge.h        |   9 --
 arch/xtensa/include/asm/pgtable.h           |   4 +
 arch/xtensa/include/asm/processor.h         |  10 +--
 arch/xtensa/include/asm/ptrace.h            |   7 +-
 arch/xtensa/kernel/Makefile                 |   3 +-
 arch/xtensa/kernel/asm-offsets.c            |   2 +-
 arch/xtensa/kernel/entry.S                  |  75 ++++++++--------
 arch/xtensa/kernel/jump_label.c             |   2 +-
 arch/xtensa/kernel/mxhead.S                 |   2 +
 arch/xtensa/kernel/process.c                |  10 ---
 arch/xtensa/kernel/setup.c                  |  10 +--
 arch/xtensa/kernel/vectors.S                |   4 +-
 arch/xtensa/kernel/vmlinux.lds.S            |   4 +-
 arch/xtensa/kernel/xtensa_ksyms.c           |  14 ---
 arch/xtensa/lib/Makefile                    |   2 +
 arch/xtensa/lib/ashldi3.S                   |  28 ++++++
 arch/xtensa/lib/ashrdi3.S                   |  28 ++++++
 arch/xtensa/lib/divsi3.S                    |  74 ++++++++++++++++
 arch/xtensa/lib/lshrdi3.S                   |  28 ++++++
 arch/xtensa/lib/modsi3.S                    |  87 ++++++++++++++++++
 arch/xtensa/lib/mulsi3.S                    | 133 ++++++++++++++++++++++++++++
 arch/xtensa/lib/udivsi3.S                   |  68 ++++++++++++++
 arch/xtensa/lib/umodsi3.S                   |  57 ++++++++++++
 arch/xtensa/mm/tlb.c                        |   6 ++
 arch/xtensa/platforms/iss/network.c         |   4 +-
 32 files changed, 676 insertions(+), 114 deletions(-)
 create mode 100644 arch/xtensa/lib/ashldi3.S
 create mode 100644 arch/xtensa/lib/ashrdi3.S
 create mode 100644 arch/xtensa/lib/divsi3.S
 create mode 100644 arch/xtensa/lib/lshrdi3.S
 create mode 100644 arch/xtensa/lib/modsi3.S
 create mode 100644 arch/xtensa/lib/mulsi3.S
 create mode 100644 arch/xtensa/lib/udivsi3.S
 create mode 100644 arch/xtensa/lib/umodsi3.S

-- 
Thanks.
-- Max
