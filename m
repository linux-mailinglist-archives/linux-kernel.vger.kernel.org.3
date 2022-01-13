Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A7048DA2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiAMOzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:55:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36076 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiAMOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:55:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14D55B82276
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B2BC36AE9;
        Thu, 13 Jan 2022 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642085731;
        bh=5IIlP/dcj0u2/HtXNVZZXpRVadMODR7b9mQA/ONvj+o=;
        h=From:To:Cc:Subject:Date:From;
        b=f3igraaEGJkWKgwdeJPqrDMTe7DB/I5JyoqPtggE+7KbplWHshLiPwBK3lBU4EGS5
         GTghnxGnx+9Vc2GRnjngMD6k0r6H3VJnQRRBIoJU8SefqTbXkaS1/FPSSAntLut8GU
         ZzigyZMCb14XzTnASE8fDzA6EGlXBHgxussiRJFIpmm0rwmYg+WrdMPLTtQLB0NOwA
         vMKLbEuuuNlfyM8BmCUHQDCx7asGHpxpYA+z0UxTZYJ3HhznTF5/MZ8KOL9isFEh3M
         SvSffdAYOXCXwF0AkjnSrGmzyxB5MtVtBXk2lZni4+pRrQkQ/aj71IHk901uTwl5yn
         OAuLLXv3WT/sA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jianhua Liu <jianhua.ljh@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] kprobes: Misc bugfixes
Date:   Thu, 13 Jan 2022 23:55:29 +0900
Message-Id: <164208572899.1590449.14007562142219520042.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some bugfixes and cleanup for the kprobe architecture
dependent implementation. 2 of 3 are found by Jianhua Liu on
arm64 optprobe code. I found that the similar issue on ppc64
and arm32 implementation so fixed those. And last one was
reported by kernel test bot.

Thank you,

---

Masami Hiramatsu (3):
      ARM: kprobes: Count MAX_OPTINSN_SIZE in kprobe_opcode_t
      powerpc/kprobes: Fix alloc_optinsn_page() to use all area of optinsn_slot
      ia64: kprobes: Cleanup unused 'template' local variable


 arch/arm/include/asm/kprobes.h       |    3 +--
 arch/ia64/kernel/kprobes.c           |    3 ---
 arch/powerpc/include/asm/kprobes.h   |    6 ++++++
 arch/powerpc/kernel/optprobes.c      |   25 +++++++++++++++++++------
 arch/powerpc/kernel/optprobes_head.S |    5 ++---
 5 files changed, 28 insertions(+), 14 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
