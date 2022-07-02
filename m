Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705A56416F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiGBQZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiGBQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 12:25:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45FDFED;
        Sat,  2 Jul 2022 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656779123;
        bh=ECmIgjLTKytPyBEDMmI2VK9eRJh1128iQ8MWsgmvsKs=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=E+xmS4SFVAL6Zy53anXRIj5s7tyGiiZHrMBOHCw4v1T/h6BXV8tdtHT6Dx7g9P3wm
         0luEz6qR0A6joYxzTwC3BkfNN5W5+/f85kfCkuZWfpyam2nPa0iYEdxbpm7f36KeB3
         +gyY7uZDuhKS1ooPOTewLIKgVG9sdCZrWMhm/9w4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.144]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1nZASf23ZC-00a02L; Sat, 02
 Jul 2022 18:25:23 +0200
Message-ID: <040d5924-eb42-2ee4-d663-88ef393cd4ae@gmx.de>
Date:   Sat, 2 Jul 2022 18:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     jeyu@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <Yr8/gr8e8I7tVX4d@p100> <Yr9l24rvCAPJvuJQ@bombadil.infradead.org>
From:   Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2] modules: Ensure natural alignment for .altinstructions
 and __bug_table sections
In-Reply-To: <Yr9l24rvCAPJvuJQ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d6098/lqYVZ20tS1l89uFsCFqQB1S0RvNxPNlGEyumJZc8rOcW2
 GvmnERpuS/ZlV0HZMpz40JeKSzHitTGzUgHKe4jbqV1Oif7ADIaF6W78YZQMvzCeuOsyrtq
 4tfgM6Kj2AGvzijt8T6aL+U/Pw28EHESarPUux0IrfsX1iR6CE+GBh5/rcFxT3I5Hiwj3zV
 52OwjI0tZJpySwoC1EDmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eN3IGzjjCC0=:ViB7D5Jt+QBPGsf05dYqca
 1QChswvqbAWjcDS/bLfq9LSpIfOL/ukW7LGRCVpitvU/Mc6GIgCn5oLoFqZeaQDcT+a7YJ9s4
 0wygtuFX06EIBP+hfQCkjtdYIf5Mgs40X5u+fc/5Bhq1T/zFjdSlwgfIhhQz+U8V5aWMcL7tx
 AbikhTufveJhYvrzgAZU1+fV7qgKI4mpXr+M144VEJO8xPCKDbN3qtbK9rikWd5z/Fw7Yb5zo
 mYsnAmE7vuWMO2Quay5QJIOLrTidQudAYKf5vUFItEOAUNme13qN5975j/BJ3tit+RDX3nadt
 XUAvF4PNguv+LmpQ30aT+6PxXR3wZlXUUkT90XwbteL4e8FawsCz3e6+V1W6A4j7ofHxnZEM1
 rZcH/PyylxoI+l4dKNzmExBS3L/Anz2gq1oXSjQjnDU4bwvdl6KRD+leeVjXnw+w2TOM4VCWA
 z2rQc9BRNyfGT1fE/TSjwb3bqE4L2p+bmjAEBATBr/uLHk6ecJi9FesInCrWazUmgL0jwv+F1
 fo7+RnuNPyGhB0ZVl0mbv02+bt2mSk3kzUJErvjyAglgtJTWbPWL2mrJMSJTZJYnVn/f2XmsH
 6guLtLH0GBv7ZDGy25lbAGEyVR0eiSQrWBLjLYxp9ZvlnNXx6QbwOogAZEX6ssXgUGoBZn4zD
 +QlTUuBG08LcjXtSJPpD7MZjVT4prq3FnRYlUyiHGrx00565Jqcsdu6LCoCcuTXWb0XzvnYbk
 M8j17/B2j21TAHEw7aTvVKC1ekDPLIVLesQy0JAeCYd9stsNKFVJ+Y+aTidYKvA/xeGC6KCdV
 H5Q6Lobf8KC2fDzye+dq7CHY2cMI3Hi36UG/77kc7O+OPvR3nAL208CYmqRwUUv5hgXmXDqhl
 8++TL6Son9TV7kx72xhwqCo+J3CJT80Vjh1t2d4DzZnGwbAFebnkm3wg2im65RmwTXfgu3xdH
 A7pFSZ8LbLA34OB/3/5YuPTsMAm15hVOCwtn9vFNrZ/Zo83rrEUIkRZhrMtaopPg4pbSb5hAc
 kOM+DSGE5/graqg4u4lBfWQ8RBVMOehuuPtK7sWvbS+EzHKSB/uvYb7J2sfNdox3Y+9SUmIBT
 amWL5Eee0oy0VdAKPlVQqiIm+VUuHF1+n7J1cvPmidseQUWaTfniJX0UQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 7/1/22 23:23, Luis Chamberlain wrote:
> On Fri, Jul 01, 2022 at 08:40:02PM +0200, Helge Deller wrote:
>> In the kernel image vmlinux.lds.S linker scripts the .altinstructions
>> and __bug_table sections are 32- or 64-bit aligned because they hold 32=
-
>> and/or 64-bit values.
>>
>> But for modules the module.lds.S linker script doesn't define a default
>> alignment yet, so the linker chooses the default byte alignment, which
>> then leads to unnecessary unaligned memory accesses at runtime.
>>
>> Usually such unaligned accesses are unnoticed, because either the
>> hardware (as on x86 CPUs) or in-kernel exception handlers (e.g. on hppa
>> or sparc) emulate and fix them up at runtime.
>>
>> On hppa the 32-bit unalignment exception handler was temporarily broken
>> due another bad commit, and as such wrong values were returned on
>> unaligned accesses to the altinstructions table.
>
> OK so some bad commit broke something which caused bad alignment access
> on altinstructions... But why on modules?!
>
> I am not aware of modules using alternatives, given that alternatives
> are hacks to help with bootup. For modules we can use other things
> like jump labels, static keys.

IMHO altinstructions isn't a hack.
They are much simpler and easier to use for static replacements.
jump labels and static keys are much more komplex, but of course they
give the possibility to switch back and forth if you need it.
But let's keep this discussion aside...

I checked a few other architectures, and here is what I found.
I dropped unimportant sections/lines.

Linux amdahl 4.19.0-20-arm64 #1 SMP Debian 4.19.235-1 (2022-03-17) aarch64=
 GNU/Linux
deller@amdahl:/lib/modules/4.19.0-19-arm64/kernel/block$ objdump -h bfq.ko
bfq.ko:     file format elf64-littleaarch64
Sections:
Idx Name          Size      VMA               LMA               File off  =
Algn
  6 .altinstructions 000000b4  0000000000000000  0000000000000000  000090a=
4  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
 13 __jump_table  00000018  0000000000000000  0000000000000000  0000d358  =
2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 15 __bug_table   00000018  0000000000000000  0000000000000000  0000dcf8  =
2**2
                  CONTENTS, ALLOC, LOAD, RELOC, DATA

-> aarch64 uses altinstructions in modules as well.
-> alignment of altinstructions is wrong (but offset suggests it gets addr=
ess right).
-> jump_table/bug_table -> Ok.

=2D---

Linux abel 4.19.0-20-armmp-lpae #1 SMP Debian 4.19.235-1 (2022-03-17) armv=
7l GNU/Linux
deller@abel:/lib/modules/4.19.0-20-armmp-lpae/kernel/block$ objdump -h bfq=
.ko
bfq.ko:     file format elf32-littlearm
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  9 __mcount_loc  000002ac  00000000  00000000  00009bf4  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
 11 __jump_table  0000000c  00000000  00000000  0000b320  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA

-> arm looks good.

=2D---

Linux plummer 4.19.0-20-powerpc64le #1 SMP Debian 4.19.235-1 (2022-03-17) =
ppc64le GNU/Linux
deller@plummer:/lib/modules/4.19.0-20-powerpc64le/kernel/block$ objdump -h=
 bfq.ko
bfq.ko:     file format elf64-powerpcle
Sections:
Idx Name          Size      VMA               LMA               File off  =
Algn
  9 __mcount_loc  00000530  0000000000000000  0000000000000000  0000bc68  =
2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
 12 __jump_table  00000018  0000000000000000  0000000000000000  000109d8  =
2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 16 __bug_table   00000030  0000000000000000  0000000000000000  000115a0  =
2**0
                  CONTENTS, ALLOC, LOAD, RELOC, DATA

-> ppc64le has wrong alignment for mcount_loc and bug_table (but file offs=
 suggests it's correct).

=2D---

Linux zelenka 4.19.0-20-s390x #1 SMP Debian 4.19.235-1 (2022-03-17) s390x =
GNU/Linux
deller@zelenka:/lib/modules/4.19.0-20-s390x/kernel/block$ objdump -h bfq.k=
o
bfq.ko:     file format elf64-s390
Sections:
Idx Name          Size      VMA               LMA               File off  =
Algn
  3 .altinstr_replacement 00000038  0000000000000000  0000000000000000  00=
00a440  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  8 .altinstructions 000000a8  0000000000000000  0000000000000000  0000b04=
e  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
 10 __mcount_loc  00000538  0000000000000000  0000000000000000  0000b1b0  =
2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
 13 __jump_table  00000018  0000000000000000  0000000000000000  0000c8e0  =
2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 17 __bug_table   00000018  0000000000000000  0000000000000000  0000d280  =
2**0
                  CONTENTS, ALLOC, LOAD, RELOC, DATA

-> s390x uses altinstructions in modules.
-> alignment should be fixed for altinstructions and bug_table

> So I don't understand still how this happened yet.

Happened what?
Even on x86 there is a call to apply_alternatives() in module_finalize() i=
n
arch/x86/kernel/module.c.
I didn't found alternatives in amd64 modules in kernel 4.19 though...

>> This then led to
>> undefined behaviour because wrong kernel addresses were patched and we
>> suddenly faced lots of unrelated bugs, as can be seen in this mail
>> thread:
>> https://lore.kernel.org/all/07d91863-dacc-a503-aa2b-05c3b92a1e39@bell.n=
et/T/#mab602dfa32be5e229d5e192ab012af196d04d75d
>>
>> This patch adds the missing natural alignment for kernel modules to
>> avoid unnecessary (hard- or software-based) fixups.
>
> Is it correct to infer that issue you found through a bad commit was
> then through code inspection after the bad commit made the kernel do
> something stupid with unaligned access to some module altinstructions
> section ? Ie, that should not have happened.

Right. Without the bad commit I would not have noticed the problem.

> I'd like to determine if this is a stable fix, a regression, etc. And
> this is not yet clear.

I fully understand that it's a hard to decide if it should go to stable!
It's not critical or required to go to stable series now.
My suggestion:
Add it to current head, wait for 1-2 releases, and *if required* we can
push it backwards at any time later.

Helge


>   Luis
>
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>>  scripts/module.lds.S | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --
>> v2: updated commit message
>>
>> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
>> index 1d0e1e4dc3d2..3a3aa2354ed8 100644
>> --- a/scripts/module.lds.S
>> +++ b/scripts/module.lds.S
>> @@ -27,6 +27,8 @@ SECTIONS {
>>  	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
>>  	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
>>
>> +	.altinstructions	0 : ALIGN(8) { KEEP(*(.altinstructions)) }
>> +	__bug_table		0 : ALIGN(8) { KEEP(*(__bug_table)) }
>>  	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
>>
>>  	__patchable_function_entries : { *(__patchable_function_entries) }

