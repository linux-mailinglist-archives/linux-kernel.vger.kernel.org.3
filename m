Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC8578E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiGRXwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiGRXwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:52:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7BD33422
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:52:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ss3so24152054ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeoZcQXjPYfGM6NHDdN44xGgOfK7e6P3NcGDah0veFw=;
        b=Tsr6vm5Og8CXWOejNJLfAeeA2UoM6xTxcxAVY74PflXgYE5HetiipEHSqM3JM2GHtB
         gH0O4RCdoEj01KLyLQyPWvVjLudH9MCNar1Q5Q0Sv3eo/s3Bz4embZVCMm19YzKRsAQH
         FR2+kNXdGShg3oDupslhJZ+P8B99cCpt6YzJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeoZcQXjPYfGM6NHDdN44xGgOfK7e6P3NcGDah0veFw=;
        b=qljxgvwgusTBxxMYR+FISkm6eEYFNoFZcs1MSE7AhJdksJSDWO9+lIQqO7u6YYVej8
         UFkZ3osEMoka1lWykCdtV01rF0LhLVSUfCQPbir38o9Q7NjifkfrxmGQCMRlMtoguzer
         rHbPX3yyJWw7J+IptcOj5DWPUfg2d1z++NK7nUQrVyonRTOLCBG5HITvYYZ/OoPglmns
         zMY3yHJ00xxgnpmkVD0jgntdY6v2OFPQyH3qbmE0CGCbuKWdmUgOm8YQ6PoenOirL89r
         39ILQ3r/71mKtZqm7XojoA4s8FtDalJjMKoYD2MeA3rmwf0aC20HuRFED3X9+rr5QMbk
         iqkw==
X-Gm-Message-State: AJIora/YBAl58PzWUIXnCkfqFTOiJk0vtoGwnVqiMo0y4YZsPkQdUpZW
        wpZpj3sLgd6VdKG+ppWEJ7PBERUp+/dy0IqZfSs=
X-Google-Smtp-Source: AGRyM1v5oocCng51wchsI6saEYe0TF9YP4JCHm6oiWrnJmo/ZrmXtY20YMPLbI/k0Y/5OazEXGSzlA==
X-Received: by 2002:a17:906:730d:b0:72f:1031:2130 with SMTP id di13-20020a170906730d00b0072f10312130mr13340064ejc.481.1658188349609;
        Mon, 18 Jul 2022 16:52:29 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7c7d4000000b0043a587eb95dsm9533574eds.5.2022.07.18.16.52.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 16:52:28 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id b26so19288735wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:52:26 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr24554501wrw.274.1658188346000; Mon, 18
 Jul 2022 16:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx> <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
In-Reply-To: <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 16:52:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
Message-ID: <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 4:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> You have the "real" marker before the function.
>
> But you also have the "false" marker that is part of the hash check
> that is *inside* the function.
>
> The "real marker + 6" points to the function head itself, and so is ok
> as a target (normal operation).

Of course, one fix for that is to make the hash be only 24 bits, and
make the int3 byte part of the value you check, and not have the same
pattern in the checking code at all.

Honestly, I think that would be a better model - yes, you lose 8 bits
of hash, but considering that apparently the current KCFI code
*guarantees* that the hash pattern will exist even outside the actual
target pattern, I think it's still a better model.

I also happen to believe that the kCFI code should have entirely
different targets for direct jumps and for indirect jumps, but that's
a separate issue. Maybe it already does that?

                 Linus
