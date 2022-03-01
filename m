Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C81E4C8203
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiCAEM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiCAEMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:12:24 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098258827
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:11:43 -0800 (PST)
Received: from integral2.. (unknown [182.2.73.137])
        by gnuweeb.org (Postfix) with ESMTPSA id BF3617EC80;
        Tue,  1 Mar 2022 04:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1646107903;
        bh=3w2AxpLXX7FDNdhNQtKsmRuPVl/hBEnkMiP8fFyfR10=;
        h=From:To:Cc:Subject:Date:From;
        b=XXlcngaMZLMDjGdg4ozmnsihW6FwV1zp3Ppp8t0wcAiES3d0GHcCuiJ5QY3RRWDpf
         /xs+WJPclbKSGyvzzK5wMglLJ9phywcxJvlb7hRxLCMi4ipDlzru8fTXv7KVkVydYy
         Nm5yJOet9cpK/Eo/l4ibHM9kXjqBkiuimeqD+ZGMgSWcXXLJsKmsfsrpY/pPqGwfBN
         ujA0CQ5uvZfqwRac81ugs5EUNfmPp+4FHn4QbMwUqpsE0iYBNLOvdL2En3Sa0BumHa
         PW/xpbsyXMa+WV9hXP/hWsHr6Zci++G1AqbZ3igHneR/ro+ShAHNLxdB9algEyEPnG
         KJrAPowaz7zlQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     weidonghui <weidonghui@allwinnertech.com>, tools@linux.kernel.org,
        linux-kernel@vger.kernel.org, gwml@vger.gnuweeb.org,
        x86@kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] scripts/decodecode: Make objdump always use operand-size suffix
Date:   Tue,  1 Mar 2022 11:11:19 +0700
Message-Id: <20220301041119.55085-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better reading, always use operand-size suffix for the generated
AT&T syntax Assembly code.

  $ echo "Code: 50 e0 49 8b 4e 08 48 8b 51 50 48 85 d2 75 03 48 8b 11 48 c7 c7 02 " \
  "47 40 a1 48 89 c6 48 c7 c1 b6 38 3f a1 31 c0 e8 25 72 d5 df <0f> 0b 41 bc 01" \
  "00 00 00 e9 da fb ff ff 48 8b 2b 48 8b 7d 08 e8 fc" | scripts/decodecode

Before this patch:
------------------

  All code
  ========
     0:   50                    push   %rax
     1:   e0 49                 loopne 0x4c
     3:   8b 4e 08              mov    0x8(%rsi),%ecx
     6:   48 8b 51 50           mov    0x50(%rcx),%rdx
     a:   48 85 d2              test   %rdx,%rdx
     d:   75 03                 jne    0x12
     f:   48 8b 11              mov    (%rcx),%rdx
    12:   48 c7 c7 02 47 40 a1  mov    $0xffffffffa1404702,%rdi
    19:   48 89 c6              mov    %rax,%rsi
    1c:   48 c7 c1 b6 38 3f a1  mov    $0xffffffffa13f38b6,%rcx
    23:   31 c0                 xor    %eax,%eax
    25:   e8 25 72 d5 df        call   0xffffffffdfd5724f
    2a:*  0f 0b                 ud2       <-- trapping instruction
    2c:   41 bc 01 00 00 00     mov    $0x1,%r12d
    32:   e9 da fb ff ff        jmp    0xfffffffffffffc11
    37:   48 8b 2b              mov    (%rbx),%rbp
    3a:   48 8b 7d 08           mov    0x8(%rbp),%rdi
    3e:   e8                    .byte 0xe8
    3f:   fc                    cld

  Code starting with the faulting instruction
  ===========================================
     0:   0f 0b                 ud2
     2:   41 bc 01 00 00 00     mov    $0x1,%r12d
     8:   e9 da fb ff ff        jmp    0xfffffffffffffbe7
     d:   48 8b 2b              mov    (%rbx),%rbp
    10:   48 8b 7d 08           mov    0x8(%rbp),%rdi
    14:   e8                    .byte 0xe8
    15:   fc                    cld

After this patch:
------------------

  All code
  ========
     0:   50                      pushq  %rax
     1:   e0 49                   loopneq 0x4c
     3:   8b 4e 08                movl   0x8(%rsi),%ecx
     6:   48 8b 51 50             movq   0x50(%rcx),%rdx
     a:   48 85 d2                testq  %rdx,%rdx
     d:   75 03                   jne    0x12
     f:   48 8b 11                movq   (%rcx),%rdx
    12:   48 c7 c7 02 47 40 a1    movq   $0xffffffffa1404702,%rdi
    19:   48 89 c6                movq   %rax,%rsi
    1c:   48 c7 c1 b6 38 3f a1    movq   $0xffffffffa13f38b6,%rcx
    23:   31 c0                   xorl   %eax,%eax
    25:   e8 25 72 d5 df          callq  0xffffffffdfd5724f
    2a:*  0f 0b                   ud2         <-- trapping instruction
    2c:   41 bc 01 00 00 00       movl   $0x1,%r12d
    32:   e9 da fb ff ff          jmpq   0xfffffffffffffc11
    37:   48 8b 2b                movq   (%rbx),%rbp
    3a:   48 8b 7d 08             movq   0x8(%rbp),%rdi
    3e:   e8                      .byte 0xe8
    3f:   fc                      cld

  Code starting with the faulting instruction
  ===========================================
     0:   0f 0b                   ud2
     2:   41 bc 01 00 00 00       movl   $0x1,%r12d
     8:   e9 da fb ff ff          jmpq   0xfffffffffffffbe7
     d:   48 8b 2b                movq   (%rbx),%rbp
    10:   48 8b 7d 08             movq   0x8(%rbp),%rdi
    14:   e8                      .byte 0xe8
    15:   fc                      cld

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 scripts/decodecode | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/decodecode b/scripts/decodecode
index c711a196511c..ab400891610f 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -98,6 +98,8 @@ disas() {
 		fi
 	fi
 
+	OBJDUMPFLAGS="$OBJDUMPFLAGS -M suffix"
+
 	${CROSS_COMPILE}objdump $OBJDUMPFLAGS -S $t.o | \
 		grep -v "/tmp\|Disassembly\|\.text\|^$" > $t.dis 2>&1
 }

base-commit: 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
-- 
2.32.0

