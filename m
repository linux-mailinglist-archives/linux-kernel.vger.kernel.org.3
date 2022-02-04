Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6E4A951B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356397AbiBDIa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:30:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234366AbiBDIa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:30:26 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1C1D1EC06A9;
        Fri,  4 Feb 2022 09:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643963425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ofHqQ4SurO6eGbHKRovoC68iUpsdRIsx+TX9bNpORIo=;
        b=JqVE3xoXfO6EJADk2G05Pz35rYdguCoYyCIBwHKyzm1OWV4EXTt+t5q2PwPJZjvn/Nk0yw
        MHZvPN11jplUbvgggkXSjEeuyI+YJxsw9rV1lKFDdfVdo4Q2Et9VTtMDqB7Xi6tqzSPtC1
        Wp9rm92dejrOWQxt5xoLlq+9LAvgoc4=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86/mce: Fix more noinstr fun
Date:   Fri,  4 Feb 2022 09:30:12 +0100
Message-Id: <20220204083015.17317-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here's a second small set of fixes for objtool noinstr validation issues
in the MCE code.

It goes ontop of tip:locking/core where there are some more commits
changing generic helpers to be always inlined.

As always, comments and suggestions are appreciated.

Thx.

Borislav Petkov (3):
  cpumask: Add a x86-specific cpumask_clear_cpu() helper
  x86/ptrace: Always inline v8086_mode() for instrumentation
  x86/mce: Use arch atomic and bit helpers

 arch/x86/include/asm/cpumask.h     | 10 ++++++
 arch/x86/include/asm/ptrace.h      |  2 +-
 arch/x86/kernel/cpu/mce/core.c     | 58 ++++++++++--------------------
 arch/x86/kernel/cpu/mce/internal.h | 23 ++++++++++--
 arch/x86/kernel/cpu/mce/severity.c |  2 +-
 include/linux/cpumask.h            |  4 +--
 6 files changed, 54 insertions(+), 45 deletions(-)

-- 
2.29.2

