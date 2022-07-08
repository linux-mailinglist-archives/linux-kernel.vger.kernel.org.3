Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78A156BD55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbiGHPnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbiGHPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:43:01 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506973939
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:42:59 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LfcxF5Z83z9tLy;
        Fri,  8 Jul 2022 17:42:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MrLG8Zz7NbHn; Fri,  8 Jul 2022 17:42:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LfcxF4gdYz9tLp;
        Fri,  8 Jul 2022 17:42:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E83F8B76E;
        Fri,  8 Jul 2022 17:42:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GlkeXLTRQmNg; Fri,  8 Jul 2022 17:42:57 +0200 (CEST)
Received: from [192.168.233.202] (unknown [192.168.233.202])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD89C8B763;
        Fri,  8 Jul 2022 17:42:56 +0200 (CEST)
Message-ID: <e5bee04b-f246-ab24-f019-b26011f32c32@csgroup.eu>
Date:   Fri, 8 Jul 2022 17:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v3 00/12] objtool: Enable and implement --mcount
 option on powerpc
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Sathvika Vasireddy <sv@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, rostedt@goodmis.org,
        naveen.n.rao@linux.vnet.ibm.com, mbenes@suse.cz,
        benh@kernel.crashing.org, paulus@samba.org
References: <20220624183238.388144-1-sv@linux.ibm.com>
 <ae669ab4-681b-1a0d-3bbc-4fdf13b501a0@csgroup.eu>
In-Reply-To: <ae669ab4-681b-1a0d-3bbc-4fdf13b501a0@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/07/2022 à 17:06, Christophe Leroy a écrit :
> 
> 
> Le 24/06/2022 à 20:32, Sathvika Vasireddy a écrit :
>> These patches are rebased on top of objtool/core
>> branch of the tip tree, and are tested on
>> ppc64le with ppc64le_defconfig.
> 
> Seems like objtool/core has been merged in 5.19. I was able to apply 
> your series on top of powerpc/merge branch. Only a small conflict with 
> patch "objtool: Add --mnop as an option to --mcount" because of commit 
> b42d23065024 ("kbuild: factor out the common objtool arguments")


In order to build, you will also need the following new file:

diff --git a/arch/powerpc/include/asm/asm.h b/arch/powerpc/include/asm/asm.h
new file mode 100644
index 000000000000..86f46b604e9a
--- /dev/null
+++ b/arch/powerpc/include/asm/asm.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_ASM_H
+#define _ASM_POWERPC_ASM_H
+
+#define _ASM_PTR	" .long "
+
+#endif /* _ASM_POWERPC_ASM_H */



> 
>>
>> Christophe Leroy (3):
>>    objtool: Fix SEGFAULT
>>    objtool: Use target file endianness instead of a compiled constant
>>    objtool: Use target file class size instead of a compiled constant
>>
>> Sathvika Vasireddy(9):
>>    objtool: Add --mnop as an option to --mcount
>>    powerpc: Skip objtool from running on VDSO files
>>    objtool: Read special sections with alts only when specific options 
>> are selected
>>    objtool: Use macros to define arch specific reloc types
>>    objtool: Add arch specific function arch_ftrace_match()
>>    objtool/powerpc: Enable objtool to be built on ppc
>>    objtool/powerpc: Add --mcount specific implementation
>>    powerpc: Remove unreachable() from WARN_ON()
>>    objtool/powerpc: Fix unannotated intra-function call warnings
>>
>>   Makefile                                      |  4 +-
>>   arch/powerpc/Kconfig                          |  2 +
>>   arch/powerpc/include/asm/bug.h                |  1 -
>>   arch/powerpc/kernel/entry_64.S                |  2 +
>>   arch/powerpc/kernel/exceptions-64s.S          |  7 +-
>>   arch/powerpc/kernel/head_64.S                 |  7 +-
>>   arch/powerpc/kernel/misc_64.S                 |  4 +-
>>   arch/powerpc/kernel/vdso/Makefile             |  2 +
>>   arch/powerpc/kernel/vector.S                  |  4 +-
>>   arch/powerpc/kvm/book3s_hv_interrupts.S       |  4 +-
>>   arch/powerpc/kvm/book3s_hv_rmhandlers.S       | 25 +++--
>>   arch/x86/Kconfig                              |  1 +
>>   scripts/Makefile.build                        |  1 +
>>   tools/objtool/arch/powerpc/Build              |  2 +
>>   tools/objtool/arch/powerpc/decode.c           | 96 +++++++++++++++++++
>>   .../arch/powerpc/include/arch/cfi_regs.h      | 11 +++
>>   tools/objtool/arch/powerpc/include/arch/elf.h | 10 ++
>>   .../arch/powerpc/include/arch/special.h       | 21 ++++
>>   tools/objtool/arch/powerpc/special.c          | 19 ++++
>>   tools/objtool/arch/x86/decode.c               |  8 ++
>>   tools/objtool/arch/x86/include/arch/elf.h     |  2 +
>>   .../arch/x86/include/arch/endianness.h        |  9 --
>>   tools/objtool/builtin-check.c                 | 14 +++
>>   tools/objtool/check.c                         | 51 +++++-----
>>   tools/objtool/elf.c                           |  8 +-
>>   tools/objtool/include/objtool/arch.h          |  2 +
>>   tools/objtool/include/objtool/builtin.h       |  1 +
>>   tools/objtool/include/objtool/elf.h           |  8 ++
>>   tools/objtool/include/objtool/endianness.h    | 32 +++----
>>   tools/objtool/orc_dump.c                      | 11 ++-
>>   tools/objtool/orc_gen.c                       |  4 +-
>>   tools/objtool/special.c                       |  3 +-
>>   32 files changed, 305 insertions(+), 71 deletions(-)
>>   create mode 100644 tools/objtool/arch/powerpc/Build
>>   create mode 100644 tools/objtool/arch/powerpc/decode.c
>>   create mode 100644 tools/objtool/arch/powerpc/include/arch/cfi_regs.h
>>   create mode 100644 tools/objtool/arch/powerpc/include/arch/elf.h
>>   create mode 100644 tools/objtool/arch/powerpc/include/arch/special.h
>>   create mode 100644 tools/objtool/arch/powerpc/special.c
>>   delete mode 100644 tools/objtool/arch/x86/include/arch/endianness.h
>>
