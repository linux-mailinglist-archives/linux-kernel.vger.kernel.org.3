Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4134056C799
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 08:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiGIGwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 02:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGIGws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 02:52:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D686558B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 23:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6F90B82A61
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 06:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55140C341D4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 06:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657349565;
        bh=OItCzHGXam6f2RpFSde10A15StjZbNKKbQYgGQWL2X8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YXYFt0E8Ij3TgCUsoJLhq07xJOnDEU7zvUw1pDlWBWVtYAeRlTzPo0WnyE6pAWxtS
         Wz0OzuoKZtFXMr8oGb0REQjuF1MDG5iVNs69CRGEV7Bow5UEKaQPXR9DV1NU/kDYv4
         58yKRd25CSBnsOav4LnMTyDIMCAzREvO3I8lLvTK/U8qQcDPlut4I2biLvyU30UmA4
         7eI70hMQNcSP2tS/A/Ga2ou3NVv0CtwI1bYQDXOUazMReVaJxPuYigQtH6QnIAJLo1
         5q2PsqSEmMIznJRpTuh0e4tdAK+hDQNZLYIQzDuhWNJJfRwDVAURMOPZFz72X0VgwC
         lCRR31TOKW0jQ==
Received: by mail-ot1-f48.google.com with SMTP id r17-20020a056830449100b0061c1b3840a0so658696otv.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 23:52:45 -0700 (PDT)
X-Gm-Message-State: AJIora/RSZTeed+PjPx9oJj7j025llLk5V/OH0VhD2VoerPBpXqI1Ev1
        8T/Gx065LqAbC5gDVOYCR8ItyOyxgj44fA7zbZ0=
X-Google-Smtp-Source: AGRyM1v/vL19VArStGC5zZnGKw+rHp1LFl+18klaQ+vaUgTkXmX9bHLGmj/xFc/D4rPKBlkGaqozxcRH0jc+EUKYeYo=
X-Received: by 2002:a05:6830:4420:b0:616:e569:8ae9 with SMTP id
 q32-20020a056830442000b00616e5698ae9mr2892555otv.265.1657349564339; Fri, 08
 Jul 2022 23:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657301423.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1657301423.git.christophe.leroy@csgroup.eu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 9 Jul 2022 08:52:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFqs=YAbTDJOgzpse9ZkggSxPNNJJphEA=J94FQzF55qg@mail.gmail.com>
Message-ID: <CAMj1kXFqs=YAbTDJOgzpse9ZkggSxPNNJJphEA=J94FQzF55qg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Implement inline static calls on PPC32 - v2
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, sv@linux.ibm.com,
        agust@denx.de, Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, X86 ML <x86@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christophe,

On Fri, 8 Jul 2022 at 19:32, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> This series applies on top of the series v3 "objtool: Enable and
> implement --mcount option on powerpc" [1] rebased on powerpc-next branch
>
> A few modifications are done to core parts to enable powerpc
> implementation:
> - R_X86_64_PC32 is abstracted to R_REL32 so that it can then be
> redefined as R_PPC_REL32.
> - A call to static_call_init() is added to start_kernel() to avoid
> every architecture to have to call it
> - Trampoline address is provided to arch_static_call_transform() even
> when setting a site to fallback on a call to the trampoline when the
> target is too far.
>
> [1] https://lore.kernel.org/lkml/70b6d08d-aced-7f4e-b958-a3c7ae1a9319@csgroup.eu/T/#rb3a073c54aba563a135fba891e0c34c46e47beef
>
> Christophe Leroy (7):
>   powerpc: Add missing asm/asm.h for objtool
>   objtool/powerpc: Activate objtool on PPC32
>   objtool: Add architecture specific R_REL32 macro
>   objtool/powerpc: Add necessary support for inline static calls
>   init: Call static_call_init() from start_kernel()
>   static_call_inline: Provide trampoline address when updating sites
>   powerpc/static_call: Implement inline static calls
>

Could you quantify the performance gains of moving from out-of-line,
patched tail-call branch instructions to full-fledged inline static
calls? On x86, the retpoline problem makes this glaringly obvious, but
on other architectures, the complexity of supporting this model may
outweigh the performance advantages.
