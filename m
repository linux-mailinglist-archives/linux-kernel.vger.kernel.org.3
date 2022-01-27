Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5549E1AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiA0L4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiA0L4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2104C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:56:35 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35C761EC0354;
        Thu, 27 Jan 2022 12:56:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643284594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=/NJjuF2WQ7rWl41YLO9V/xg6y4cvb0ro/Gfodnl5jjU=;
        b=BYbg2tIiQyAcJZaSLPFt+Kq4X+rGdJdgMvWr+PietSXgSrWrtELo7T1L+9ZlEssWWQ4E6m
        Seucg0fovw7Gu+xPZy2wehWi5HunxoklHBHiLmnoS+EHy017K6v4KQx3MnSpShsGY6FDIG
        tBjJmEUTNoEoxGiaKLy21+/pBYOKsF0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] x86/cpu: Do some janitorial work
Date:   Thu, 27 Jan 2022 12:56:20 +0100
Message-Id: <20220127115626.14179-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here's v2 with some adjustments due to dependent changes which went
upstream, in the meantime. I figure I should send them out one more time
before I queue them.

Also, patch 1 handles printing of naked feature numbers for which we
don't generate a string for /proc/cpuinfo now too.

Thx.

changelog:
----------

v1
--

Beef up clearcpuid= so that it supports the strings from /proc/cpuinfo
too and remove a bunch of useless, and, in some cases even downright
dangerous, chicken bits we have added over the years.

Borislav Petkov (6):
  x86/cpu: Allow feature bit names from /proc/cpuinfo in clearcpuid=
  x86/cpu: Remove "nosep"
  x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
  x86/cpu: Remove "nosmep"
  x86/cpu: Remove "noexec"
  x86/cpu: Remove "noclflush"

 .../admin-guide/kernel-parameters.txt         | 24 ++---
 Documentation/x86/cpuinfo.rst                 |  5 +-
 Documentation/x86/x86_64/boot-options.rst     |  9 --
 arch/x86/Kconfig                              | 11 ---
 arch/x86/include/asm/cpufeature.h             |  7 +-
 arch/x86/include/asm/disabled-features.h      |  8 +-
 arch/x86/include/asm/proto.h                  |  1 -
 arch/x86/include/asm/smap.h                   | 24 -----
 arch/x86/kernel/cpu/common.c                  | 94 +++++++++----------
 arch/x86/kernel/setup.c                       | 28 +++++-
 arch/x86/mm/Makefile                          |  3 +-
 arch/x86/mm/init_64.c                         |  1 -
 arch/x86/mm/setup_nx.c                        | 62 ------------
 scripts/Makefile.build                        |  1 -
 scripts/link-vmlinux.sh                       |  3 -
 .../arch/x86/include/asm/disabled-features.h  |  8 +-
 16 files changed, 91 insertions(+), 198 deletions(-)
 delete mode 100644 arch/x86/mm/setup_nx.c

-- 
2.29.2
