Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DEB59FECB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiHXPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbiHXPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:50:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2502CC87
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:50:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661356203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofO6K+OMSITsaGHE8wMcO5f9lytJ/iLlxdnlabEaK1I=;
        b=JhAQ6V4+16Gu0NBUcQAaWB5DQVw7zIvVKEKq1ImhWzXV1gpNPmr0C47vKMlFhsZTGAaFvC
        Zpq2UiNxhNmcfubZKrBjLw1umInlc0KbV7pxvbPYoRQx2pwExH+4Q+UjW8hPUt+EMEEJLH
        fC7FVVMWmqqa+88Qt+ll9Rhi2ssmSfBOPeFmMChicEXkmlzutUwnFXHv4aw7MC+b6vnLi5
        iJmUuhNujcXCJjsQZcjfsfj9Ue6qgm0BaYwy12sJmWeMDup7rE8rsOe7owBKHmoJ8vXvZg
        T7muHnONglPF47wdMZxhJzfx5wJ/Nsv+V+1jCnCTou+6qzg7sOjxQSflypEVjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661356203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofO6K+OMSITsaGHE8wMcO5f9lytJ/iLlxdnlabEaK1I=;
        b=rceyqpXABUnxU14b/oZvdTgDd0fvgTIrPw6CSbkO8vumkFD8F/DxDbYPEYopggl/o00niP
        LVD0UfvOuNn2gZCQ==
To:     suhui_kernel@163.com, mingo@kernel.org
Cc:     akpm@linux-foundation.org, bp@alien8.de, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mgorman@suse.de, peterz@infradead.org,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org,
        nhuck@google.com, ndesaulniers@google.com, lukas.bulwahn@gmail.com,
        masahiroy@kernel.org
Subject: Re: [PATCH 09/15] sched/headers: Introduce
 kernel/sched/build_policy.c and build multiple .c files there
In-Reply-To: <20220823074702.2900118-1-suhui_kernel@163.com>
References: <20220315084247.40783-10-mingo@kernel.org>
 <20220823074702.2900118-1-suhui_kernel@163.com>
Date:   Wed, 24 Aug 2022 17:50:02 +0200
Message-ID: <87pmgpy72t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23 2022 at 15:47, suhui kernel wrote:
> Hi Ingo, Since commit f96eca432015ddc1b621632488ebc345bca06791 merged, the
> scripts/clang-tools/gen_compile_commands.py can't work very well.
>
>   In this patch the build_policy.c and build_utility.c include kernel/sched/xxx.c(
> such as rt.c idle.c...), so it compile the build_utility.o build_policy.o directly,
> and it won't generate kernel/sched/xxx.c(such as rt.o idle.o), so the gen_compile_commands.py
> can't work.

gen_compile_commands.py works perfectly fine and generates the entries
for build_policy.o and built_utility.o as expected.

gen_compile_commands.py scans the build tree for .cmd files and extracts
the command line from those files into the the json file. As there is no
.cmd file for the .c files which are included into build_*.c there wont
be entries in the json file either.

>   It will report "[8/23/2022, 3:24:06 PM] "rt.c" not found in "${workspaceFolder}/compile_commands.json".
> 'includePath' from c_cpp_properties.json in folder 'linux' will be
> used for this file instead.".

No idea where this message comes from, but certainly not from
gen_compile_commands.py because that generates the file.

The clang-tidy kernel build target generates and uses that file and that
works perfectly fine.

So what exactly broke?

Thanks,

        tglx


