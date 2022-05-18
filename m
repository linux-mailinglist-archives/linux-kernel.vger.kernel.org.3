Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8E52BDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiEROtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbiEROtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:49:14 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3616D10E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:49:07 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:32848)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrKz3-002PxL-IC; Wed, 18 May 2022 08:49:05 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38630 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrKz2-0003X1-BV; Wed, 18 May 2022 08:49:05 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
        <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
        <1652782155.56t7mah8ib.naveen@linux.ibm.com>
        <8735h8b2f1.fsf@email.froward.int.ebiederm.org>
        <87v8u3o9tk.fsf@mpe.ellerman.id.au>
Date:   Wed, 18 May 2022 09:48:40 -0500
In-Reply-To: <87v8u3o9tk.fsf@mpe.ellerman.id.au> (Michael Ellerman's message
        of "Wed, 18 May 2022 12:26:15 +1000")
Message-ID: <875ym2aoc7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrKz2-0003X1-BV;;;mid=<875ym2aoc7.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18OF6jAwaXaz6ojJSRU8FUF7d0ERwA10Zc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Michael Ellerman <mpe@ellerman.id.au>
X-Spam-Relay-Country: 
X-Spam-Timing: total 613 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.7%), b_tie_ro: 3.1 (0.5%), parse: 1.33
        (0.2%), extract_message_metadata: 15 (2.4%), get_uri_detail_list: 3.4
        (0.6%), tests_pri_-1000: 11 (1.8%), tests_pri_-950: 1.08 (0.2%),
        tests_pri_-900: 0.78 (0.1%), tests_pri_-90: 60 (9.7%), check_bayes: 58
        (9.5%), b_tokenize: 9 (1.5%), b_tok_get_all: 12 (2.0%), b_comp_prob:
        3.6 (0.6%), b_tok_touch_all: 30 (4.9%), b_finish: 0.73 (0.1%),
        tests_pri_0: 440 (71.8%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 65 (10.7%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 75 (12.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>> Looking at this the pr_err is absolutely needed.  If an unsupported case
>> winds up in the purgatory blob and the code can't handle it things
>> will fail silently much worse later.
>
> It won't fail later, it will fail the syscall.
>
> sys_kexec_file_load()
>   kimage_file_alloc_init()
>     kimage_file_prepare_segments()
>       arch_kexec_kernel_image_load()
>         kexec_image_load_default()
>           image->fops->load()
>             elf64_load()        # powerpc
>             bzImage64_load()    # x86
>               kexec_load_purgatory()
>                 kexec_apply_relocations()
>
> Which does:
>
> 	if (relsec->sh_type == SHT_RELA)
> 		ret = arch_kexec_apply_relocations_add(pi, section,
> 						       relsec, symtab);
> 	else if (relsec->sh_type == SHT_REL)
> 		ret = arch_kexec_apply_relocations(pi, section,
> 						   relsec, symtab);
> 	if (ret)
> 		return ret;
>
> And that error is bubbled all the way back up. So as long as
> arch_kexec_apply_relocations() returns an error the syscall will fail
> back to userspace and there'll be an error message at that level.
>
> It's true that having nothing printed in dmesg makes it harder to work
> out why the syscall failed. But it's a kernel bug if there are unhandled
> relocations in the kernel-supplied purgatory code, so a user really has
> no way to do anything about the error even if it is printed.

Good point.  I really hadn't noticed the error code in there when I
looked.

I still don't think changing the functionality of the code because of
a tool issue is the right solution.


>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>
>>> Baoquan He wrote:
>>>> On 04/25/22 at 11:11pm, Naveen N. Rao wrote:
>>>>> kexec_load_purgatory() can fail for many reasons - there is no need to
>>>>> print an error when encountering unsupported relocations.
>>>>> This solves a build issue on powerpc with binutils v2.36 and newer [1].
>>>>> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>>>>> symbols") [2], binutils started dropping section symbols that it thought
>>>> I am not familiar with binutils, while wondering if this exists in other
>>>> ARCHes except of ppc. Arm64 doesn't have the ARCH override either, do we
>>>> have problem with it?
>>>
>>> I'm not aware of this specific file causing a problem on other architectures -
>>> perhaps the config options differ enough. There are however more reports of
>>> similar issues affecting other architectures with the llvm integrated assembler:
>>> https://github.com/ClangBuiltLinux/linux/issues/981
>>>
>>>>
>>>>> were unused.  This isn't an issue in general, but with kexec_file.c, gcc
>>>>> is placing kexec_arch_apply_relocations[_add] into a separate
>>>>> .text.unlikely section and the section symbol ".text.unlikely" is being
>>>>> dropped. Due to this, recordmcount is unable to find a non-weak symbol
>>>> But arch_kexec_apply_relocations_add is weak symbol on ppc.
>>>
>>> Yes. Note that it is just the section symbol that gets dropped. The section is
>>> still present and will continue to hold the symbols for the functions
>>> themselves.
>>
>> So we have a case where binutils thinks it is doing something useful
>> and our kernel specific tool gets tripped up by it.
>
> It's not just binutils, the LLVM assembler has the same behavior.
>
>> Reading the recordmcount code it looks like it is finding any symbol
>> within a section but ignoring weak symbols.  So I suspect the only
>> remaining symbol in the section is __weak and that confuses
>> recordmcount.
>>
>> Does removing the __weak annotation on those functions fix the build
>> error?  If so we can restructure the kexec code to simply not use __weak
>> symbols.
>>
>> Otherwise the fix needs to be in recordmcount or binutils, and we should
>> loop whoever maintains recordmcount in to see what they can do.
>
> It seems that recordmcount is not really maintained anymore now that x86
> uses objtool?
>
> There've been several threads about fixing recordmcount, but none of
> them seem to have lead to a solution.

That is unfortunate.

> These weak symbol vs recordmcount problems have been worked around going
> back as far as 2020:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/elfcore.h?id=6e7b64b9dd6d96537d816ea07ec26b7dedd397b9

I am more than happy to adopt the kind of solution that was adopted
there in elfcore.h and simply get rid of __weak symbols in the kexec
code.

Using __weak symbols is really not the common kernel way of doing
things.  Using __weak symbols introduces a bit of magic in how the
kernel gets built that is unnecessary.

Can someone verify that deleting __weak is enough to get powerpc to
build?  AKA:

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..7f4ca8dbe26f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -117,7 +117,7 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
  *
  * Return: 0 on success, negative errno on error.
  */
-int __weak
+int
 arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
                                 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
 {
@@ -134,7 +134,7 @@ arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
  *
  * Return: 0 on success, negative errno on error.
  */
-int __weak
+int
 arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
                             const Elf_Shdr *relsec, const Elf_Shdr *symtab)
 {

If that change is verified to work a proper patch that keeps x86 and
s390 building that have actual implementations should not be too
difficult to write.

Eric
