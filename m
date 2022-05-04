Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818B251A3ED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351935AbiEDP1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiEDP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:27:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFB341318
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E904EB826BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A952C385A5;
        Wed,  4 May 2022 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651677809;
        bh=ktJHAAfxXY27F4Yp0pVOFZhlUjZRdnCIMDE+o9mcaSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wf/i3XzvW7iUXulwTOOL76y5ntY2o/iZzlM7DltPzIOvHdDuYW8HHcuc2aVasFSrX
         SkjKm6Wvv3MhL9TGp012sDM+fPVHy1+flzdjIVPFzBnVUsp+nDdzzxz/MLh0+cy/If
         nWOhDXTQlG1MoQPNJ6jSQsdJGrJuGBo74GAUFkAXSgHzeouIe4SD9q1SZwlllvTYfR
         whAlki5jIkAsUXS1pHxGR4PZTtksbMoDE9Sqqlmlghj3swVeelD8PmFbI3MxXq5l5m
         Hoy75fcqSulg9leoTxV1K+5q6Ym3nBY9Vxrtuef0mJSCW+eXvL6js7GYW3AtrAqmwY
         QFSYZzrqzjmsA==
Date:   Thu, 5 May 2022 00:23:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-Id: <20220505002325.f29a5deaebb77549b80d59ce@kernel.org>
In-Reply-To: <YmvTbN966XmLSZk+@hirez.programming.kicks-ass.net>
References: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
        <YmvTbN966XmLSZk+@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 14:00:44 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Apr 29, 2022 at 11:20:24AM +0200, Peter Zijlstra wrote:
> > 
> > STACK_FRAME_NON_STANDARD results in inconsistent relocation types
> > depending on .c or .S usage:
> > 
> >   Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
> >   Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> >   0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
> >   0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
> >   0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
> >   0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
> >   0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0
> 
> So that weird .rodata entry is optprobe_template_func.
> 
> It being in .rodata also means it's not validated and there is no ORC
> data generated, is that all intentional? The changelog for:
> 
>   877b145f0f47 ("x86/kprobes: Move trampoline code into RODATA")
> 
> doesn't really say anything useful about any of that :/

This commit was introduced just for reducing attack surface (the
trampoline code is NOT executed but just copied into trampoline
buffers), but if the ORC unwinder doesn't work correctly, please
revert it.
I think there is no functional change.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
