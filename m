Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040F5517651
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244567AbiEBSMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiEBSMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:12:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C32AD7
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:09:10 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2039D1EC01E0;
        Mon,  2 May 2022 20:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651514945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NVLQylm2xzPSr3TT7+KNSbEKEKGW1lybixymd1yf/Gw=;
        b=bl7z4cc0hgKV/lbVncKPlulWFsGk2EYhefedPle4H/e8JJzMKETwtE0EFGlAEa4h0La6ye
        643dlrATYX6vJgFj9MpK6nt8/4K/NuVw/4vf070u4VZrPOxGBBy317YtssKgXuWkcmWTjr
        qSTP3loE1VEjwPNCtDqEMT438XQIWOQ=
Date:   Mon, 2 May 2022 20:09:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V6 3/8] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
Message-ID: <YnAePwYZwq0N1fjJ@zn.tnic>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-4-jiangshanlai@gmail.com>
 <YmmBHABKMk7Ctx46@zn.tnic>
 <CAJhGHyANWhu-HX20_4XhgACE8tUd8SFa5BTH-ynJscNQ7QxBRw@mail.gmail.com>
 <6c0dd7c7-593b-d8cf-347b-3d32310fcc11@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c0dd7c7-593b-d8cf-347b-3d32310fcc11@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:42:50PM +0200, Juergen Gross wrote:
> I think you could avoid the extra call/ret by doing something like:
> 
> SYM_CODE_START_LOCAL(error_exit_push_and_save)
> 	UNWIND_HINT_FUNC
> 	PUSH_AND_CLEAR_REGS save_ret=1
> 	ENCODE_FRAME_POINTER 8
> 	jmp error_exit
> SYM_CODE_END(error_exit_push_and_save)
> 
> ... and use this instead of patch 5:
> 
> 	ALTERNATIVE "call error_entry_push_and_save; movq %rax, %rsp", \
> 		"call push_and_clear_regs", X86_FEATURE_XENPV

I'm afraid I can't follow - you still need to call error_entry on
!XENPV. You have a function error_entry_push_and_save() but above it is
called error_*exit*_push_and_save...

Bottomline is, this should be as simple as possible code - an additional
CALL/RET doesn't really matter, perf-wise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
