Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D395A46D1C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhLHLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:17:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60742 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232208AbhLHLRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:17:15 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F8D01EC04EC;
        Wed,  8 Dec 2021 12:13:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638962023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=RQ7ctsH+/oa+SdqmE+cdY+OCQhuLgoBPS/Egthm7oZA=;
        b=qf44eYzZmJeAdyKBF6zVj47UMF+GN9eFffLqjo8+sy2MOzLWxIP9G7Nop/4Z717GLsbJ2Y
        t7Yjrr57LNpv46mBXf2kHsWInjojUPHw3iVdtAPo64LqVQ/1gLMcxNveNdOUg8w4kX5FV3
        XyWDsgCIHE+ymdMofT3J0gErlcN6BM8=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 00/12] x86/mce: Correct the noinstr annotation
Date:   Wed,  8 Dec 2021 12:13:31 +0100
Message-Id: <20211208111343.8130-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi folks,

here's v1 with the instrumentation "sandwiching" documented, as
requested by peterz.

Tony, I'd appreciate making sure nothing in them breaks your injection
workflows before I queue them. And it shouldn't but... :-)

Thx.

Changelog:
==========

here's a first preliminary (it is based on some random 5.16-rc0 commit
and is tested only in qemu) of the series which correct all the noinstr
annotation of the #MC handler.

Since it calls a bunch of external facilities, the strategy is to mark
mce-specific functions called by the #MC handler as noinstr and when
they "call out" so to speak, to do a begin/end sandwich around that
call.

Please have a look and let me know if it looks ok-ish.

Further testing will happen after -rc1 releases, thus the "v0" version
here.

Thx.

Borislav Petkov (12):
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

 arch/x86/kernel/cpu/mce/core.c     | 128 +++++++++++++++++++++--------
 arch/x86/kernel/cpu/mce/internal.h |   2 +
 arch/x86/kernel/cpu/mce/severity.c |  38 +++++----
 3 files changed, 119 insertions(+), 49 deletions(-)

-- 
2.29.2

