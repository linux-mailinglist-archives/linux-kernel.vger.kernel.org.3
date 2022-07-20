Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496C657BC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiGTQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGTQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:56:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90313CF6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:56:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f11so15513064plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pXZuRlG5jo3/qyaJ4nhecGIbVjrr3hLyFH8U8e17hLU=;
        b=G9upKS7bzl/YRVjbw5pWR/u7xJwXXljEL/4mUvSZbTPqJpB1CNlMbfbFxhotpG9PB6
         UhokFKRvdLT1NS0HQhAjwJJnH5w4LM8mhBSigMtluxItJbnhoSFyR8pvLn2RwOQ9hy1P
         FdtjOQlohcHfITpPMcl1rOxQkJ39FzjmAXeZQ1P6tMVMk+ZRcP1WnYSXwx0Lk7qDlhLU
         BQCN+H5Y+J0phKtPTaE+oFMMpGt2yZUljR1kp4zTbpeG14BApij148lkA24V5+aeNbgS
         JUWMGCVw+2w7UIeZsTX4dW9q5jfCZMj8qxE+dEeLn4tiTvbFbSVU9BjVT3yIROXYSW0A
         gBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pXZuRlG5jo3/qyaJ4nhecGIbVjrr3hLyFH8U8e17hLU=;
        b=BfMF2GrciXI9gJrsb6J9xvLC7bAlVxwNyj15xMExG2ul3b9LLZOW+SJmaP50zln4m4
         NIlCDIqjGzCfN28B4iKM+i00zcXJEGCyG3cPShiHjnbmJo3GeQSqWJQaJWu78/OsIAYT
         0bsmj6eoD5YNxc27M5XfCQICirNP6VtYBe14mM8OpGp7ijpCM9LftapsuXCdV2PxCvOu
         f5Ap1LPVYZWeHI9f82YS53GPcWzQsR3HMYccMrWpcIEDWATlM1hAT6jIu3ZyO7ed8G6/
         Eqz5ZwwDLJqLUkEYEhcdr5maMITIvU+8VPJyw8jFeRPoIBPHxhaWsiYRoqjZAPasOdlU
         taTQ==
X-Gm-Message-State: AJIora/FMPmOwvGheNrn4c/NbFnd/P5DZH8e7ZcKlsF92rI0IKkvqcCT
        AeNTfod0KGkXe6yLbEGGdOaE9Q==
X-Google-Smtp-Source: AGRyM1tOXnK/BzY+tfUIeNIBwJyq3dLKHw5V9IoiyLbeMyS5WUdHNghDuDBN3xgrdtP9VvhJU1qOYA==
X-Received: by 2002:a17:90b:1642:b0:1f0:31c1:9e80 with SMTP id il2-20020a17090b164200b001f031c19e80mr6486365pjb.157.1658336165983;
        Wed, 20 Jul 2022 09:56:05 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:1b3a:60da:6fc4:edb3])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b0016be6a554b5sm14115927plk.233.2022.07.20.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:56:05 -0700 (PDT)
Date:   Wed, 20 Jul 2022 09:55:59 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <Ytgzn4A/sF9zY+7t@google.com>
References: <20220716230344.239749011@linutronix.de>
 <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx>
 <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <CABCJKufACEoUz=SVakAFVKhhwFb6biaPdiC_1cA=NRAUiak5hQ@mail.gmail.com>
 <YtXx8r5zfqZ12M04@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtXx8r5zfqZ12M04@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 01:51:14AM +0200, Peter Zijlstra wrote:
> So if we assume \func starts with ENDBR, and further assume we've fixed
> up every direct jmp/call to land at +4, we can overwrite the ENDBR with
> part of the SARQ, that leaves us 6 more byte, placing the immediate at
> -10 if I'm not mis-counting.
> 
> Now, the call sites are:
> 
> 41 81 7b fa 78 56 34 12		cmpl	$0x12345678, -6(%r11)
> 74 02				je	1f
> 0f 0b				ud2
> e8 00 00 00 00		1:	call	__x86_indirect_thunk_r11
> 
> That means the offset of +10 lands in the middle of the CALL
> instruction, and since we only have 16 thunks there is a limited number
> of byte patterns available there.
> 
> This really isn't as nice as the -6 but might just work well enough,
> hmm?

I agree, this is probably fine, or at least low enough risk.

Did you have thoughts about changing the check instruction sequence
to split the hash into multiple instructions and thus avoiding this
issue altogether?

Sami
