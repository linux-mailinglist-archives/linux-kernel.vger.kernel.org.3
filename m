Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5482A4D2F75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiCIMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiCIMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:52:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D6617777E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:51:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CB26F1F382;
        Wed,  9 Mar 2022 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646830293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkquTILc7aEHvGG2BhXXypdsFY/K4IZMrpqZS6leWTc=;
        b=oVG3ZhWViFKiI1T3xF4qLO4s1THrZ/YK8ZHTa9oZGqyV+r1BpDMEH9gVzhFv/gjqoDF9IK
        BszTnNrwrsFAfqYNEd0J+l3XppRAsQNTsW52MN4spcM3HJJPibRfU+vFmCRkJDgd4YdSFD
        uEgfWgyP774lgMeRR7OZ24zCZg4P48w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646830293;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkquTILc7aEHvGG2BhXXypdsFY/K4IZMrpqZS6leWTc=;
        b=o+dfUm+iSID+6POQ+JDMUVw1Z5Do1EXfhsfo5qLBfWhM69bdVrE0QN5W9s+VUtGz8ILK6Q
        /XiuSAsrtRaBNnDQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 27C92A3B85;
        Wed,  9 Mar 2022 12:51:28 +0000 (UTC)
Date:   Wed, 9 Mar 2022 13:51:33 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
In-Reply-To: <20220308153011.021123062@infradead.org>
Message-ID: <alpine.LSU.2.21.2203090959150.672@pobox.suse.cz>
References: <20220308153011.021123062@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022, Peter Zijlstra wrote:

> Hopefully last posting...
> 
> Since last time:
> 
>  - updated the ftrace_location() patch (naveen, rostedt)
>  - added a few comments and clarifications (bpetkov)
>  - disable jump-tables (joao)
>  - verified clang-14-rc2 works
>  - fixed a whole bunch of objtool unreachable insn issue
>  - picked up a few more tags
> 
> Patches go on top of tip/master + arm64/for-next/linkage. Also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

FWIW objtool changes look good to me. 

I only came across 

arch/x86/kernel/head_64.o: warning: objtool: .noinstr.text: unexpected end of section

with CC_HAS_IBT=n, which you already know about.

CC_HAS_IBT=y compilation gives

vmlinux.o: warning: objtool: xen_vcpu_setup()+0xa3: unreachable instruction

Miroslav
