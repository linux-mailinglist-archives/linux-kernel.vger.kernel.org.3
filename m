Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6704D31F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiCIPme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiCIPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:42:33 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB5D17C430
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:41:32 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KDGdP4YVVz9sSh;
        Wed,  9 Mar 2022 16:41:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sf-CINmH9zVP; Wed,  9 Mar 2022 16:41:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KDGdP3NhXz9sQv;
        Wed,  9 Mar 2022 16:41:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5ECF38B780;
        Wed,  9 Mar 2022 16:41:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Lvh8lYiafQd6; Wed,  9 Mar 2022 16:41:29 +0100 (CET)
Received: from [192.168.202.27] (unknown [192.168.202.27])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B31918B763;
        Wed,  9 Mar 2022 16:41:27 +0100 (CET)
Message-ID: <8bba9ed8-ae1f-7c98-fde5-808927935447@csgroup.eu>
Date:   Wed, 9 Mar 2022 16:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 00/23] Add generic vdso_base tracking
Content-Language: fr-FR
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20210611180242.711399-1-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
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

Hi Dmitry,

I'm wondering the status of this series.

Wondering what to do while reviewing pending powerpc patches and 
especially 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20201103171336.98883-1-ldufour@linux.ibm.com/ 


Christophe

Le 11/06/2021 à 20:02, Dmitry Safonov a écrit :
> v3 Changes:
> - Migrated arch/powerpc to vdso_base
> - Added x86/selftest for unmapped vdso & no landing on fast syscall
> - Review comments from Andy & Christophe (thanks!)
> - Amended s/born process/execed process/ everywhere I noticed
> - Build robot warning on cast from __user pointer
> 
> I've tested it on x86, I would appreciate any help with
> Tested-by on arm/arm64/mips/powerpc/s390/... platforms.
> 
> One thing I've noticed while cooking this and haven't found a clean
> way to solve is zero-terminated .pages[] array in vdso mappings, which
> is not always zero-terminated but works by the reason of
> VM_DONTEXPAND on mappings.
> 
> v2 Changes:
> - Rename user_landing to vdso_base as it tracks vDSO VMA start address,
>    rather than the explicit address to land (Andy)
> - Reword and don't use "new-execed" and "new-born" task (Andy)
> - Fix failures reported by build robot
> 
> Started from discussion [1], where was noted that currently a couple of
> architectures support mremap() for vdso/sigpage, but not munmap().
> If an application maps something on the ex-place of vdso/sigpage,
> later after processing signal it will land there (good luck!)
> 
> Patches set is based on linux-next (next-20201123) and it depends on
> changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
> on my changes in akpm (fixing several mremap() issues).
> 
> Logically, the patches set divides on:
> - patch       1: a cleanup for patches in x86/cleanups
> - patches  2-13: cleanups for arch_setup_additional_pages()
> - patches 13-14: x86 signal changes for unmapped vdso
> - patches 15-22: provide generic vdso_base in mm_struct
> - patch      23: selftest for unmapped vDSO & fast syscalls
> 
> In the end, besides cleanups, it's now more predictable what happens for
> applications with unmapped vdso on architectures those support .mremap()
> for vdso/sigpage.
> 
> I'm aware of only one user that unmaps vdso - Valgrind [2].
> (there possibly are more, but this one is "special", it unmaps vdso, but
>   not vvar, which confuses CRIU [Checkpoint Restore In Userspace], that's
>   why I'm aware of it)
> 

I'm wondering the status of this series.

Wondering what to do while reviewing pending powerpc patches and 
especially 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20201103171336.98883-1-ldufour@linux.ibm.com/ 


Christophe

