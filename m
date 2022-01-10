Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3514A48979D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244877AbiAJLiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:38:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiAJLgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:36:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D126C1F395;
        Mon, 10 Jan 2022 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641814605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uAD9DJ0MQoyTuyFy6X2dhuK2MO+0lKFW6l+xo1ezmLQ=;
        b=MllJ6h9cEzSdxdR2Muh7zT43r2az9KmD+5ttxSBJMIYvKjH7HayyE6NDYI7T9l9hRbXi+l
        dH3V9Z+pzxodL/OMnvIEaHlWALAZJXOnJqZZKpwmU7kiK+FIdqQ7jxEqXj/fZW71cL1Xn0
        CW1ZyfThOEqW6YjOTpuJOHLjCUhydPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641814605;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uAD9DJ0MQoyTuyFy6X2dhuK2MO+0lKFW6l+xo1ezmLQ=;
        b=qtus/VVwAMjHhNqKHhwF3v/BRghE9vbjnjmLUzI6QCR3echFPyOWNadYvclYvOgsPRpGQ8
        40JiOJB0SqFUg3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF5DF139ED;
        Mon, 10 Jan 2022 11:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DVVQKU0a3GGTdgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 11:36:45 +0000
Date:   Mon, 10 Jan 2022 12:36:53 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for v5.17
Message-ID: <YdwaVT1HCfqZZRFr@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull what looks like a relatively big amount of movements in
RAS-land this time around, for 5.17.

Thx.

---

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.17_rc1

for you to fetch changes up to 3376136300a00df9a864b88fa969177d6c3be8e5:

  x86/mce: Reduce number of machine checks taken during recovery (2021-12-31 18:22:32 +0100)

----------------------------------------------------------------
- First part of a series to move the AMD address translation code from
arch/x86/ to amd64_edac as that is its only user anyway

- Some MCE error injection improvements to the AMD side

- Reorganization of the #MC handler code and the facilities it calls to
make it noinstr-safe

- Add support for new AMD MCA bank types and non-uniform banks layout

- The usual set of cleanups and fixes

----------------------------------------------------------------
Borislav Petkov (13):
      x86/mce: Do not use memset to clear the banks bitmaps
      x86/mce: Remove function-local cpus variables
      x86/mce: Use mce_rdmsrl() in severity checking code
      x86/mce: Remove noinstr annotation from mce_setup()
      x86/mce: Allow instrumentation during task work queueing
      x86/mce: Prevent severity computation from being instrumented
      x86/mce: Mark mce_panic() noinstr
      x86/mce: Mark mce_end() noinstr
      x86/mce: Mark mce_read_aux() noinstr
      x86/mce: Move the tainting outside of the noinstr region
      x86/mce: Mark mce_timed_out() noinstr
      x86/mce: Mark mce_start() noinstr
      x86/mce: Check regs before accessing it

Smita Koralahalli (2):
      x86/mce/inject: Check if a bank is populated before injecting
      x86/mce/inject: Set the valid bit in MCA_STATUS before error injection

Yazen Ghannam (6):
      x86/MCE/AMD, EDAC/amd64: Move address translation to AMD64 EDAC
      x86/amd_nb, EDAC/amd64: Move DF Indirect Read to AMD64 EDAC
      EDAC/amd64: Allow for DF Indirect Broadcast reads
      EDAC/amd64: Add context struct
      x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types
      x86/MCE/AMD, EDAC/mce_amd: Support non-uniform MCA bank type enumeration

Youquan Song (1):
      x86/mce: Reduce number of machine checks taken during recovery

Zhang Zixun (1):
      x86/mce/inject: Avoid out-of-bounds write when setting flags

Zhaolong Zhang (1):
      x86/mce: Get rid of cpu_missing

 arch/x86/include/asm/amd_nb.h           |   1 -
 arch/x86/include/asm/mce.h              |  28 +---
 arch/x86/kernel/amd_nb.c                |  49 +-----
 arch/x86/kernel/cpu/mce/amd.c           | 280 ++++++--------------------------
 arch/x86/kernel/cpu/mce/core.c          | 149 ++++++++++++-----
 arch/x86/kernel/cpu/mce/inject.c        |  46 +++++-
 arch/x86/kernel/cpu/mce/internal.h      |   2 +
 arch/x86/kernel/cpu/mce/severity.c      |  41 +++--
 arch/x86/lib/copy_user_64.S             |   9 +
 drivers/edac/amd64_edac.c               | 275 +++++++++++++++++++++++++++++++
 drivers/edac/mce_amd.c                  | 146 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
 12 files changed, 653 insertions(+), 375 deletions(-)


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
