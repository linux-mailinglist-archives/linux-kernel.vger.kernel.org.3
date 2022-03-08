Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2F54D15EF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346368AbiCHLOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346579AbiCHLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:13:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5481F45794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:12:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCXhz2CXTz4xvN;
        Tue,  8 Mar 2022 22:12:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646737923;
        bh=buvhDmN44a7EjR7cfC8Y+d11RSrc5DDw84MVawIAw0g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MjQPGrm0AjorCpR4jq0lCg/VQy/SiwnkYszlGtxCVhkFDjj8ShmYAKaPLTzUDwMJq
         KeUHvCk7fSbirP1W0WjTUe0qj0XLDdvqhk5RnsayvJ2xryY2G2w7AyMTpSo4cZdCPf
         WLpUw63UImpRFJS9iRg28UpLvFM1J1pqB5WrnU/1V3YOtCoGYH1UtX4d0uPuCVgSnN
         S+fg0dKwxFpOE2XDsY+cQBdt4P6cnyN+fJDRqzQSrNEF3u2TNbmZtZOnXNnm/QHQyZ
         kRxw7OznZHsVe4NYrgoddb8fwpxypXrP8B1TVuwUeUCtCa4jHf3q/1lPHKVoPb0M5D
         PN2vuBytg5S9Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v1 4/4] powerpc: Move C prototypes out of asm-prototypes.h
In-Reply-To: <5c839e08-661f-6430-0da8-0f3b1c87c2e8@csgroup.eu>
References: <3ed660a585df2080ea8412ec20fbf652f5bf013a.1646413435.git.christophe.leroy@csgroup.eu>
 <62d46904eca74042097acf4cb12c175e3067f3d1.1646413435.git.christophe.leroy@csgroup.eu>
 <5c839e08-661f-6430-0da8-0f3b1c87c2e8@csgroup.eu>
Date:   Tue, 08 Mar 2022 22:12:02 +1100
Message-ID: <87v8won1fh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 04/03/2022 =C3=A0 18:04, Christophe Leroy a =C3=A9crit=C2=A0:
>> We originally added asm-prototypes.h in commit 42f5b4cacd78 ("powerpc:
>> Introduce asm-prototypes.h"). It's purpose was for prototypes of C
>> functions that are only called from asm, in order to fix sparse
>> warnings about missing prototypes.
>>=20
>> A few months later Nick added a different use case in
>> commit 4efca4ed05cb ("kbuild: modversions for EXPORT_SYMBOL() for asm")
>> for C prototypes for exported asm functions. This is basically the
>> inverse of our original usage.
>>=20
>> Since then we've added various prototypes to asm-prototypes.h for both
>> reasons, meaning we now need to unstitch it all.
>>=20
>> Dispatch prototypes of C functions into relevant headers and keep
>> only the prototypes for functions defined in assembly.
>>=20
>> For the time being, leave prom_init() there because moving it
>> into asm/prom.h or asm/setup.h conflicts with
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.o
>> This will be fixed later by untaggling asm/pci.h and asm/prom.h
>> or by renaming the function in shadowrom.c
>>=20
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/include/asm/asm-prototypes.h     | 51 -------------------
>>   arch/powerpc/include/asm/ftrace.h             |  3 ++
>>   arch/powerpc/include/asm/hvcall.h             |  5 ++
>>   arch/powerpc/include/asm/interrupt.h          | 11 ++++
>>   arch/powerpc/include/asm/kexec.h              |  2 +
>>   arch/powerpc/include/asm/processor.h          |  8 +++
>>   arch/powerpc/include/asm/setup.h              |  7 +++
>>   arch/powerpc/include/asm/smp.h                |  3 ++
>>   arch/powerpc/include/asm/syscalls.h           |  4 ++
>>   arch/powerpc/kernel/early_32.c                |  1 -
>>   arch/powerpc/kernel/interrupt.c               |  1 -
>>   arch/powerpc/kernel/irq.c                     |  1 -
>>   arch/powerpc/kernel/mce.c                     |  1 -
>>   arch/powerpc/kernel/prom_init.c               |  1 -
>>   arch/powerpc/kernel/ptrace/ptrace.c           |  1 -
>>   arch/powerpc/kernel/setup_64.c                |  1 -
>>   arch/powerpc/kernel/smp.c                     |  1 -
>>   arch/powerpc/kernel/syscalls.c                |  1 -
>>   arch/powerpc/kernel/tau_6xx.c                 |  1 -
>>   arch/powerpc/kernel/time.c                    |  1 -
>>   arch/powerpc/kernel/trace/ftrace.c            |  1 -
>>   arch/powerpc/kexec/core_64.c                  |  1 -
>>   arch/powerpc/kvm/book3s_hv_builtin.c          |  1 -
>>   arch/powerpc/kvm/book3s_hv_rm_xive.c          |  1 -
>>   arch/powerpc/lib/vmx-helper.c                 |  1 -
>>   arch/powerpc/mm/book3s64/slb.c                |  1 -
>>   arch/powerpc/mm/fault.c                       |  1 -
>>   arch/powerpc/platforms/powernv/idle.c         |  1 -
>>   .../platforms/powernv/opal-tracepoints.c      |  1 -
>>   arch/powerpc/platforms/pseries/lpar.c         |  1 -
>>   30 files changed, 43 insertions(+), 72 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_=
init.c
>> index 0ac5faacc909..3b49065daf21 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -41,7 +41,6 @@
>>   #include <asm/btext.h>
>>   #include <asm/sections.h>
>>   #include <asm/machdep.h>
>> -#include <asm/asm-prototypes.h>
>
> Need to keep this include as prom_init() couldn't be moved to asm/prom.h=
=20
> due to conflict with drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
>
> Can you fix it ?

Yep, done.

cheers
