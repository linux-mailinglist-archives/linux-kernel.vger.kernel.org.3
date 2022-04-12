Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8EF4FD4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354504AbiDLHSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352220AbiDLHE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:04:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C6B27162
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:47:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kcx9w2HNHz4xXW;
        Tue, 12 Apr 2022 16:47:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1649746069;
        bh=m4MwxwbcZdNUXgF4qvMI9+VwYgaKkYE8vyW9IWIBWtI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bpPJhxFIp5kqmWf/g0qcLrUdm0Lgg1PISHaoWjkrZcEjmaDyJPe8un+f43k4joLTp
         ZTsikZTszA6+03sTHL53h/XUNP7WjYqWSZ8yzKklwFbzWZ4h57tLtlTavQdBD+FYVD
         fhGWiyOgX+t+4dyqjzCVXDImNMnqGG/IQoRlRbu0rCSihnAI4wCJXD/Sio8KsQvBth
         Cz4fJyEsDPUCxrr2tBilZdyMak7lRicCSC4GzRqSKPAfgd7ZkDZcwMYUv9/biWB9hs
         dHj39a+vrhdDqV25Tcm5vnBaWLeG0nGWJz+xTBSqViLq0vXiwSDcE6tuGHEwYgnAfE
         sWNvp+ui4F6xg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ariel Marcovitch <arielmarcovitch@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: False positive kmemleak report for dtb properties names on powerpc
In-Reply-To: <a9d13878-7820-d41c-9357-135094c8357f@csgroup.eu>
References: <9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com>
 <YjtXXlnbEp64eL0T@arm.com> <Yjtvtkn+CishCef6@kernel.org>
 <2603cae9-3b75-cd13-1d41-2f1bed6ca32e@gmail.com>
 <a9d13878-7820-d41c-9357-135094c8357f@csgroup.eu>
Date:   Tue, 12 Apr 2022 16:47:47 +1000
Message-ID: <87pmlm6bn0.fsf@mpe.ellerman.id.au>
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
> Hi Ariel
>
> Le 09/04/2022 =C3=A0 15:47, Ariel Marcovitch a =C3=A9crit=C2=A0:
>> Hi Christophe, did you get the chance to look at this?
>
> I tested something this morning, it works for me, see below
>
>>=20
>> On 23/03/2022 21:06, Mike Rapoport wrote:
>>> Hi Catalin,
>>>
>>> On Wed, Mar 23, 2022 at 05:22:38PM +0000, Catalin Marinas wrote:
>>>> Hi Ariel,
>>>>
>>>> On Fri, Feb 18, 2022 at 09:45:51PM +0200, Ariel Marcovitch wrote:
>>>>> I was running a powerpc 32bit kernel (built using
>>>>> qemu_ppc_mpc8544ds_defconfig
>>>>> buildroot config, with enabling DEBUGFS+KMEMLEAK+HIGHMEM in the kernel
>>>>> config)
>
> ...
>
>>>>> I don't suppose I can just shuffle the calls in setup_arch() around,=
=20
>>>>> so I
>>>>> wanted to hear your opinions first
>>>> I think it's better if we change the logic than shuffling the calls.
>>>> IIUC MEMBLOCK_ALLOC_ACCESSIBLE means that __va() works on the phys
>>>> address return by memblock, so something like below (untested):
>>> MEMBLOCK_ALLOC_ACCESSIBLE means "anywhere", see commit e63075a3c937
>>> ("memblock: Introduce default allocation limit and use it to replace
>>> explicit ones"), so it won't help to detect high memory.
>>>
>>> If I remember correctly, ppc initializes memblock *very* early, so=20
>>> setting
>>> max_low_pfn along with lowmem_end_addr in
>>> arch/powerpc/mm/init_32::MMU_init() makes sense to me.
>>>
>>> Maybe ppc folks have other ideas...
>>> I've added Christophe who works on ppc32 these days.
>
> I think memblock is already available at the end of MMU_init() on PPC32=20
> and at the end of early_setup() on PPC64. It means it is ready when we=20
> enter setup_arch().
>
> I tested the change below, it works for me, I don't get any kmemleak=20
> report anymore.
>
> diff --git a/arch/powerpc/kernel/setup-common.c=20
> b/arch/powerpc/kernel/setup-common.c
> index 518ae5aa9410..9f4e50b176c9 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -840,6 +840,9 @@ void __init setup_arch(char **cmdline_p)
>   	/* Set a half-reasonable default so udelay does something sensible */
>   	loops_per_jiffy =3D 500000000 / HZ;
>
> +	/* Parse memory topology */
> +	mem_topology_setup();
> +
>   	/* Unflatten the device-tree passed by prom_init or kexec */
>   	unflatten_device_tree();

The 64-bit/NUMA version of mem_topology_setup() requires the device tree
to be unflattened, so I don't think that can work.

Setting max_low_pfn etc in MMU_init() as Mike suggested seems more
likely to work.

But we might need to set it again in mem_topology_setup() though, so
that things that change memblock_end_of_DRAM() are reflected, eg. memory
limit or crash dump?

cheers
