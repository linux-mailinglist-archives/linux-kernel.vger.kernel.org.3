Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455CC589EA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbiHDP1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiHDP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:27:02 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E94C2AE11
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:27:01 -0700 (PDT)
Received: from linux.gnuweeb.org (linux.gnuweeb.org [172.17.0.3])
        by gnuweeb.org (Postfix) with ESMTPSA id B86B5806D7;
        Thu,  4 Aug 2022 15:26:59 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1659626819;
        bh=HYO9pbZDfPK8O2lWn2CBuaUHv0WEHOMviXfeXDRJLKA=;
        h=From:To:Cc:Subject:Date:From;
        b=TJeNRHNQL1XWDPG+R6s0LyhOh8/N1EkpcS4OrbbFlgRKczMVApE5eFDNz8p98FfRg
         HtmXQLrfhDrejMveOWwuLH6EgLSVByl9Lp30U6XB4qpqX7XmBDICi++2hM/eHVgmX8
         J0wORvL63SXGi6Yp+ry/y7jpGJykibSmETuNRn9AOjrPTz4DQvZp5gncMHEgC+w4bj
         MuPC5XCIdxAR55+3ayJXnNyCuSAEZ5FwKYy8J2ueqwuxI0Aui2fRnTWRcgXWH4tRZr
         aJQsRYWOwXhUYr9ueN/bwTvVE/61ZO7dT/sClFjpt0NuZ54nTrtSxkawG94MgKKl0n
         s7tG85INNuygA==
From:   Kanna Scarlet <knscarlet@gnuweeb.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Kanna Scarlet <knscarlet@gnuweeb.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Roth <michael.roth@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] x86 change mov 0, %reg to xor %reg, %reg
Date:   Thu,  4 Aug 2022 15:26:54 +0000
Message-Id: <20220804152656.8840-1-knscarlet@gnuweeb.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux x86 maintainers,

I'm an informatic student 19 y.o. I am still studying Linux kernel open
source in GNU/Weeb community. I want to be a linux kerne dev in the
future. This is my first time sending a patch to Linux Kernel, I am
still learning the community. I may make a mistake in this email, please
correct me if i am wrong

I want to improve x86-64 assembly code with this patch. This patch
changes mov $0, %reg with xor %reg, %reg because xor %reg, %reg is
smaller so it is good to save space

asm:
ba 00 00 00 00  mov   $0x0,%edx
31 d2           xor   %edx,%edx


Regards,

Signed-off-by: Kanna Scarlet <knscarlet@gnuweeb.org>
---

Kanna Scarlet (1):
  x86: Change mov $0, %reg with xor %reg, %reg

 arch/x86/boot/compressed/head_64.S     | 2 +-
 arch/x86/boot/compressed/mem_encrypt.S | 2 +-
 arch/x86/kernel/ftrace_32.S            | 4 ++--
 arch/x86/kernel/head_64.S              | 2 +-
 arch/x86/math-emu/div_Xsig.S           | 2 +-
 arch/x86/math-emu/reg_u_sub.S          | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)


base-commit: ff89dd08c0f0a3fd330c9ef9d775e880f82c291e
-- 
Kanna Scarlet

