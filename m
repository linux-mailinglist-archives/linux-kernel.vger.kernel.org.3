Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B24C2111
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiBXBfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiBXBfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:35:15 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0311013AA30
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:34:46 -0800 (PST)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 9F320CFD62
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:18:47 +0000 (UTC)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 1C897C0003;
        Thu, 24 Feb 2022 01:18:04 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 23 Feb 2022 17:18:04 -0800
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 24/29] x86/text-patching: Make text_gen_insn() IBT aware
In-Reply-To: <20220218171409.990016403@infradead.org>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.990016403@infradead.org>
Message-ID: <5c77889ca6b988b0dff65136264bd1fb@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_X86_IBT
> +	if (is_endbr(dest))
> +		dest += 4;
> +#endif

Hi, FWIIW I saw this snippet trigger a bug in the jump_label infra where 
the target displacement would not fit in a JMP8 operand. The behavior 
was seen because clang, for whatever reason (probably a bug?) inlined an 
ENDBR function along with a function, thus the JMP8 target was 
incremented. I compared the faulty kernel to one compiled with GCC and 
the latter wont emit/inline the ENDBR.

The displacement I'm using in my experimentation is a few bytes more 
than just 4, because I'm also adding extra instrumentation that should 
be skipped when not reached indirectly. Of course this is more prone to 
triggering the bug, but I don't think it is impossible to happen in the 
current implementation.

For these cases perhaps we can verify if the displacement fits the 
operand and, if not, simply ignore and lose the decode cycle which may 
not be a huge problem and remains semantically correct. Seems more 
sensible than padding jump tables with nops. In the meantime I'll 
investigate clang's behavior and if it is really a bug, I'll work on a 
patch.
