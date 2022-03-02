Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0814C9BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbiCBDHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiCBDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:07:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED868AEF04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:06:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x18so681746pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 19:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4uQWZ5eZTfa9okHYlvMe6xuV/p7mWvmKZNg/Hz4Am3Y=;
        b=BIaD9FNraSb6wiOQFQhZ5ISIkGwvyd5VR6/NcjkrFX7S08TfqnMNK8YIUrpyLk6U44
         rtYy1wOKPCpGN7mmdUvzI9MlXebh+Gv2VLlAMbgAnJyOyDtdEl/yEP9ZfjuA5+9OLCf2
         6fA1aYcN79lwfDOWzpZONi3fA7tNpVXfGIZGi0mEjMygD9qi1kPfxhBxr6XXxsVu9Fuy
         32Ts+4tMk0GaetgE1nkkf/UFswX+wVmYIwO6S6NmtdgJ4eHQHgAU935WvAvX7uPV+pCO
         sZNeZAxfXwX5AuNs36WFYFvX+blKS8ruRyeVpgraWFnYVKJYZaH6i7Acqk7EQ77Mm6Rw
         vNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4uQWZ5eZTfa9okHYlvMe6xuV/p7mWvmKZNg/Hz4Am3Y=;
        b=kiQ5XbqdGWVL3C5NoKfM9LnamWs/7nq/M7mqepl+8R2mUKSlGj93l1oeTCxvIogEKx
         azQcp2kzWxu8mmSzlwBSWLFG6YZs/qhh6lnrwOB4YiqZcBSjbMvWKlD+yQ+vuVzQERYN
         y+I1Brq2QZIwhclhwqhdrjrxDNHmGma4IgPUPO6DQAnTWOcVbtg8/MCwMzWuc92xsN3j
         XvQlGD0G3/RqUYU4uw+m7eWbIK/uWYYEer8Mh3OdscKAxuah9zssgGvwh5jPA+tCp7Ma
         qTUQBvrdyXhUHpD++JOS4LMpvVHWvRTQfXF9tNgyHV2cKSlTzh5dmF6KxgCic2RAWhsZ
         bcrg==
X-Gm-Message-State: AOAM533qRsTXwc62g5WG6nD09OvaUq+Y/3EJ/l/QylD5q7pUxBsaKj6F
        E/8nT8MtqztaMeuOt6dNijLZdQ==
X-Google-Smtp-Source: ABdhPJzjrpjpwq6XNmCzDIGQ61zH5fVSYvT9ToczJ0xSUPOr+Yek7VBUiQzg6UrMFKqjHvd+z9+CPg==
X-Received: by 2002:a63:d443:0:b0:364:51b7:c398 with SMTP id i3-20020a63d443000000b0036451b7c398mr24417257pgj.511.1646190387158;
        Tue, 01 Mar 2022 19:06:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:367d:623c:c89d:99ef])
        by smtp.gmail.com with ESMTPSA id f9-20020a056a00228900b004f3ba7d177csm19396666pfe.54.2022.03.01.19.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 19:06:26 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:06:21 -0800
From:   Peter Collingbourne <pcc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joao Moreira <joao@overdrivepizza.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <Yh7fLRYl8KgMcOe5@google.com>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211133803.GV23216@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

One issue with this call sequence is that:

On Fri, Feb 11, 2022 at 02:38:03PM +0100, Peter Zijlstra wrote:
> caller:
> 	cmpl	$0xdeadbeef, -0x4(%rax)		# 7 bytes

Because this instruction ends in the constant 0xdeadbeef, it may
be used as a "gadget" that would effectively allow branching to an
arbitrary address in %rax if the attacker can arrange to set ZF=1.

> 	je	1f				# 2 bytes
> 	ud2					# 2 bytes
> 1:	call	__x86_indirect_thunk_rax	# 5 bytes
> 
> 
> 	.align 16
> 	.byte 0xef, 0xbe, 0xad, 0xde		# 4 bytes
> func:
> 	endbr					# 4 bytes
> 	...
> 	ret

I think we can avoid this problem with a slight tweak to your
instruction sequence, at the cost of 2 bytes per function prologue.
First, change the call sequence like so:

 	cmpl	$0xdeadbeef, -0x6(%rax)		# 6 bytes
	je	1f				# 2 bytes
	ud2					# 2 bytes
1:	call	__x86_indirect_thunk_rax	# 5 bytes

The key difference is that we've changed 0x4 to 0x6.

Then change the function prologue to this:

	.align 16
	.byte 0xef, 0xbe, 0xad, 0xde		# 4 bytes
	.zero 2					# 2 bytes
func:

The end result of the above is that the constant embedded in the cmpl
instruction may only be used to reach the following ud2 instruction,
which will "harmlessly" terminate execution in the same way as if
the prologue signature did not match.

Peter
