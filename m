Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB4519708
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 07:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbiEDFub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiEDFua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:50:30 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AADB2AC4C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 22:46:54 -0700 (PDT)
Received: from [2a02:8108:963f:de38:1b3c:6996:5378:f253]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nm7qX-0004GI-Qd; Wed, 04 May 2022 07:46:45 +0200
Message-ID: <f4b00553-4e77-84bc-e25c-01383d7e92dd@leemhuis.info>
Date:   Wed, 4 May 2022 07:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
References: <YnHK1Z3o99eMXsVK@mail-itl>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Xorg SEGV in Xen PV dom0 after updating from 5.16.18 to 5.17.5
To:     Lucas De Marchi <lucas.demarchi@intel.com>
In-Reply-To: <YnHK1Z3o99eMXsVK@mail-itl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1651643214;fa53666c;
X-HE-SMSGID: 1nm7qX-0004GI-Qd
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Sending this just to
CC the developers of the culprit mentioned below (bdd8b6c98239cad
("drm/i915: replace X86_FEATURE_PAT with pat_enabled()")) and the
maintainers for the subsystem.

While at it a quick note: I wonder if this is problem a similar to one
that recently turned up with amdgpu and is fixed by this problem:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=78b12008f20

Ciao, Thorsten

On 04.05.22 02:37, Marek Marczykowski-Górecki wrote:
> 
> After updating from 5.16.18 to 5.17.5 in Xen PV dom0, my Xorg started
> crashing when displaying any window mapped from a guest (domU) system.
> This is 100% reproducible.
> The system is Qubes OS, and it uses a trick that maps windows content
> from other guests using Xen grant tables, wrapped as "shared memory"
> from Xorg point of view (so, the memory that Xorg mmaps is not just from
> another process, but from another VM). That's the ShmPutImage you can
> see on the stack trace below.
> 
> Stack trace of thread 12858:
> #0  0x00007f80029e17d5 raise (libc.so.6 + 0x3c7d5)
> #1  0x00007f80029ca895 abort (libc.so.6 + 0x25895)
> #2  0x00005b3469ace0e0 OsAbort (Xorg + 0x1c60e0)
> #3  0x00005b3469ad3959 AbortServer (Xorg + 0x1cb959)
> #4  0x00005b3469ad46aa FatalError (Xorg + 0x1cc6aa)
> #5  0x00005b3469acb450 OsSigHandler (Xorg + 0x1c3450)
> #6  0x00007f8002b85a90 __restore_rt (libpthread.so.0 + 0x14a90)
> #7  0x00007f8002b0a2a1 __memmove_avx_unaligned_erms (libc.so.6 + 0x1652a1)
> #8  0x00007f80015dfcc9 linear_to_xtiled_faster (iris_dri.so + 0xc91cc9)
> #9  0x00007f80015e3477 _isl_memcpy_linear_to_tiled (iris_dri.so + 0xc95477)
> #10 0x00007f8001468440 iris_texture_subdata (iris_dri.so + 0xb1a440)
> #11 0x00007f8000a76107 st_TexSubImage (iris_dri.so + 0x128107)
> #12 0x00007f8000be9a47 texture_sub_image (iris_dri.so + 0x29ba47)
> #13 0x00007f8000becd0c texsubimage_err (iris_dri.so + 0x29ed0c)
> #14 0x00007f8000bf2939 _mesa_TexSubImage2D (iris_dri.so + 0x2a4939)
> #15 0x00007f800213831f glamor_upload_boxes (libglamoregl.so + 0x1e31f)
> #16 0x00007f800213856f glamor_upload_region (libglamoregl.so + 0x1e56f)
> #17 0x00007f800212aea6 glamor_put_image (libglamoregl.so + 0x10ea6)
> #18 0x00005b3469a4d79c damagePutImage (Xorg + 0x14579c)
> #19 0x00005b3469a00a7e ProcShmPutImage (Xorg + 0xf8a7e)
> #20 0x00005b3469965a2b Dispatch (Xorg + 0x5da2b)
> #21 0x00005b3469969b04 dix_main (Xorg + 0x61b04)
> #22 0x00007f80029cc082 __libc_start_main (libc.so.6 + 0x27082)
> #23 0x00005b3469952e6e _start (Xorg + 0x4ae6e)
> 
> Disassembly of the surrounding code:
> 
>    0x00007596ae8c82fb <+123>:	ja     0x7596ae8c8338 <__memmove_avx_unaligned_erms+184>
>    0x00007596ae8c82fd <+125>:	jb     0x7596ae8c8304 <__memmove_avx_unaligned_erms+132>
>    0x00007596ae8c82ff <+127>:	movzbl (%rsi),%ecx
>    0x00007596ae8c8302 <+130>:	mov    %cl,(%rdi)
>    0x00007596ae8c8304 <+132>:	retq   
>    0x00007596ae8c8305 <+133>:	vmovdqu (%rsi),%xmm0
>    0x00007596ae8c8309 <+137>:	vmovdqu -0x10(%rsi,%rdx,1),%xmm1
> => 0x00007596ae8c830f <+143>:	vmovdqu %xmm0,(%rdi)
>    0x00007596ae8c8313 <+147>:	vmovdqu %xmm1,-0x10(%rdi,%rdx,1)
>    0x00007596ae8c8319 <+153>:	retq
> 
> 
> I don't see any related kernel or Xen messages at this time. Xorg's SEGV
> handler prints also:
> 
>     (EE) Segmentation fault at address 0x3c010
> 
> Git bisect says it's bdd8b6c98239cad ("drm/i915: replace X86_FEATURE_PAT
> with pat_enabled()"), and indeed with this commit reverted on top of
> 5.17.5 everything works fine.
> 
> I guess this part of dom0's boot dmesg may be relevant:
> 
> [    0.000949] x86/PAT: MTRRs disabled, skipping PAT initialization too.
> [    0.000953] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WC  WP  UC  UC  
> 
> Originally reported at
> https://github.com/QubesOS/qubes-issues/issues/7479
> 
>  
> #regzbot introduced bdd8b6c98239cad
> #regzbot monitor: https://github.com/QubesOS/qubes-issues/issues/7479
> 
