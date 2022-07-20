Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB5657BEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiGTTml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiGTTmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:42:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7307E54658
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:42:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q16so14215401pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ox6O9Gm4Xocdz9Dx1hEcNVYNiyGO9dkfC4GAUnl++hQ=;
        b=UWq+thcxVh3baukLxLz7PR7+gR9zPMO3QUAYm3OiJ+S3pQu7yl9vhaMsaVCr26QfFj
         MCvdGPrjOdEecd7y7a0J6ADivBbOMurPWIxyM94wYX6aeB6WKRtwH4XF53rN6BREx/D9
         KeqhTPKUTTfxu2M/I9HTGuS0yx1J0R3oyuHW1HZZQ7LFAIp/2dKKxtRyr8rFcbWFIFXe
         JsdNC/YF3O6zJPrtOVGPlqGpFSoHhkaDmys853IxgxIMr9zY4D/tyhFyD2Et6mAmUfCB
         SD9dq30xIYzQhtsNsN+ci2u1eqP4deAbiZ96U2Bu8TptzWFFETnDCxSGNQoZ9NEXZiNj
         aVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ox6O9Gm4Xocdz9Dx1hEcNVYNiyGO9dkfC4GAUnl++hQ=;
        b=NId5eovSSwfIlz3HENkrK9TPqgPtuIJJcBQxi/3T+aim1nlaIAOOjCLjeYhKrbI6QK
         A6AQ8tMd2cTHVQC5SMG8Wgw5kpS727CD+hq7R6fB7k5eZe/V/Hr9fWpwZSPprw8JKxl5
         edSgmQjaBC6ZfsLDC/lNMMAj0tKOh+oQeMSc7AlxCGeaLZ051nKsIoHed8PgTwXT0NVd
         urKNEtpKsenkb9sHlqDC50chU8fTSwrgpmIH2V11d9SFist8PTCgSkTSgsP7BeJt06Xm
         qgToVgz/jkYt2MnZCkgqi5pOqBuxRjYr7VvOph6YU4fP8iUJe5VPaZOhaWH9y7fQGEWv
         S4og==
X-Gm-Message-State: AJIora+rMnztHxpK5w4+Nb/OR9cBu32DeevA7jyEGtiiLw6AUJV2v9pO
        AEnpDr1YVzdIR2XCvHZ25KHjdBgb108W0vBB
X-Google-Smtp-Source: AGRyM1t8pzZ4/zoZIaFlX0Uhsrdy39CPDVggdjgqQxcICnwpgQjRrKeakPPR+60hLwZl+9Tmh85I6A==
X-Received: by 2002:a05:6a00:3392:b0:52b:4896:b317 with SMTP id cm18-20020a056a00339200b0052b4896b317mr26940349pfb.17.1658346157737;
        Wed, 20 Jul 2022 12:42:37 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:2568:566e:fec7:763b])
        by smtp.gmail.com with ESMTPSA id w23-20020a170902a71700b0016c9e5f290esm14196344plq.10.2022.07.20.12.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:42:37 -0700 (PDT)
Date:   Wed, 20 Jul 2022 12:42:30 -0700
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
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YthapuEHKoci4OkQ@google.com>
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
> That means the offset of +10 lands in the middle of the CALL
> instruction, and since we only have 16 thunks there is a limited number
> of byte patterns available there.
> 
> This really isn't as nice as the -6 but might just work well enough,
> hmm?

pcc pointed out that we can also just add two more ud2 instructions to
the check sequence if we want to be safe, with the cost of extra four
bytes per callsite.

> Also, since we're talking at least 4 bytes more padding over the 7 that
> are required by the kCFI scheme, the FineIBT alternative gets a little
> more room to breathe. I'm thinking we can have the FineIBT landing site
> at -16.
> 
> __fineibt_\func:
> 	endbr64				# 4
> 	xorl	$0x12345678, %r10d	# 7
> 	je	\func+4			# 2
> 	ud2				# 2
> 
> \func:
> 	nop4
> 	...

I assume this means the preamble must also be 16-byte aligned to avoid
performance issues with the FineIBT alternative? Which means we'll have
a 16-byte preamble preceded by the usual nop padding.

Sami
