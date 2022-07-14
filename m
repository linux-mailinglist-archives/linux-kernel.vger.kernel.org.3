Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5057555C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiGNSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiGNSuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F53491F1;
        Thu, 14 Jul 2022 11:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B35621B2;
        Thu, 14 Jul 2022 18:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED97C34114;
        Thu, 14 Jul 2022 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657824608;
        bh=TCqABXXcBNiycVEd9peMznw1VBAKPiSMiV1dL+tUSR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzgvOCcsy5Em/AwO9hrbVqhQOgRBWrFIiOIgcaNVJ9zE/4Tkc75GT0w1waJzQ8nVN
         cx72onxjJwHo5n5TWukISjD2gra+A8Fb9B0swFiOgp1nbvXInA2zeEqrYMgE/MkyFm
         uoo6e0EqOJ3gCdm6GCkZGbAOKMZ/G8kgejfj6e6M/iGrD1o0casitascKwKh5uU4UE
         EeGMDEyizBSqtihv7dmpMwFfsFRi2VwtJuIcl+72dqdgZyKqfdpMtmgFOqFFM6OR6Q
         5W4svVAVQ1O13NIwK3ixKq5amA+2Cft0LmkBo0+GG5VJNnQMRvah/Qao4P932yWYUd
         pdPt9UN1xX94A==
Date:   Thu, 14 Jul 2022 11:50:06 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86: Allow for exclusions in checking RETHUNK
Message-ID: <20220714185006.6brfnnzhz7p7zw3u@treble>
References: <20220713213133.455599-1-keescook@chromium.org>
 <20220713235556.umnau6nd7u6bz72m@treble>
 <Ys/DNIyc+4ju7Qmb@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ys/DNIyc+4ju7Qmb@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:18:12AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 13, 2022 at 04:55:56PM -0700, Josh Poimboeuf wrote:
> > Here's the ANNOTATE_UNSAFE_RET idea.
> 
> Right, I suppose that strictly speaking the compiler can do whatever and
> there's no actual guarantee the annotation hits the RET instruction, in
> practise it should work, esp. since noinstr.

Hm, KASAN is introducing a weird function, resulting in a naked return
warning since we have RETHUNK_CFLAGS removed on that file.

0000000000000000 <_sub_I_00099_0>:
   0:	e8 00 00 00 00       	call   5 <_sub_I_00099_0+0x5>	1: R_X86_64_PLT32	__tsan_init-0x4
   5:	c3                   	ret    


Looks like the "KASAN_SANITIZE_rodata.o := n" isn't working somehow?

-- 
Josh
