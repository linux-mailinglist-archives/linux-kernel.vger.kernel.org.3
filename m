Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5965ABA59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiIBVvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIBVvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:51:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2E8F32FC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:51:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id k18so3485004lji.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gN0Irs2o7oP1brfekJlSB6uGcftAcPdWHSp57rRt4Lw=;
        b=Zf1RwmozYFv+ANs5Gsy4/WsBmDjw/JT43hlHNS0w9g86VKya0DDyD27O1voWWrKxQ9
         ETFZ1f6B5nezMOJQ0k+J3NnLDgKmHJ+tquVFusKYsR9SXhIyiUxwn7ryF65i8Eh2PPiI
         30bcQLSr3pxT8LQntuioWTHobmla49/diTT1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gN0Irs2o7oP1brfekJlSB6uGcftAcPdWHSp57rRt4Lw=;
        b=0mfZjtQqmvnI2Pbx7Vjx8wEdoKIByyJ7SUGCDZk/ULLxm3wt2z3Jc8c8lezKr6NEUm
         aTXg7VH92YJ4TpZ5+Dssq/+ueuxcqBobeUnRXa6LfRwzn92M6Jy3vn0a5VP2eClRiGBA
         jXCoDg7QKJLi509hpzdgZH9GGhDWHfVyWxU3+7bZl4s1j09GfA12LLaVcewX+dh9vGCX
         0hoOscr2vVbadkY6T9mXnNqhp2R/wHM5AcCm3sZF9SC+db2PFZKZkunQU8VBGjuuy3Vf
         ZakyDJfq+TbEPQsnYqYZemHF34kniKx8HEJK8JnqAeOm0/BizsKKL6hI3D0xWTh3I1bx
         S3XA==
X-Gm-Message-State: ACgBeo2bi0bNmU42m4f+ca4igYyacnC8zO9rIcb+6EOZeXuYHStxdfLF
        oo/tNF+BBnBEbC5ZaDB6V9nVJVAEc/6m+fBjR8s=
X-Google-Smtp-Source: AA6agR6r6vmS7kBU8IEbaJUkL3F9wGJTg8uVLKL63NeLJJjxMyRJuv3hfMF0EZmJb3FMFOlRyGRgYQ==
X-Received: by 2002:a2e:8188:0:b0:25e:4ae6:5503 with SMTP id e8-20020a2e8188000000b0025e4ae65503mr10935526ljg.412.1662155495389;
        Fri, 02 Sep 2022 14:51:35 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u26-20020ac2519a000000b0048b17b0db44sm366487lfi.61.2022.09.02.14.51.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 14:51:35 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id q7so5098616lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:51:34 -0700 (PDT)
X-Received: by 2002:a5d:6045:0:b0:226:d21d:947b with SMTP id
 j5-20020a5d6045000000b00226d21d947bmr17791740wrt.274.1662155184166; Fri, 02
 Sep 2022 14:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220902130625.217071627@infradead.org> <20220902130950.205726504@infradead.org>
 <CAHk-=wig7_=CpkvZXrbcM97pBGk5MCbVkA0yBGP2moiho-XS_Q@mail.gmail.com>
 <YxI3Zf5drSHAkBL3@hirez.programming.kicks-ass.net> <YxJmdG9Ug7euJdZS@hirez.programming.kicks-ass.net>
In-Reply-To: <YxJmdG9Ug7euJdZS@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Sep 2022 14:46:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-njE+DwycFcVQ=ouXZpgKU2rjG3G0keNXSFWa_etrEA@mail.gmail.com>
Message-ID: <CAHk-=wj-njE+DwycFcVQ=ouXZpgKU2rjG3G0keNXSFWa_etrEA@mail.gmail.com>
Subject: Re: [PATCH v2 37/59] x86/putuser: Provide room for padding
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
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
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 1:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The below (mashup of a handful of patches) is the best I could come up
> with in a hurry.

Hmm. It doesn't look too horrible, but yeah, fi it still ends up
getting the same padding overhead I'm not sure it ends up really
mattering.

I was hoping that some of the overhead would just go away - looking at
my kernel build, we do have a fair number of functions that are 1-31
bytes (according to a random and probably broken little shell script:

    objdump -t vmlinux |
        grep 'F .text' |
        sort |
        cut -f2- |
        grep '^00000000000000[01]'

but from a quick look, a fair number of them aren't actually even leaf
functions (ie they are small because they just call another function
with a set of simple arguments, often as a tail-call).,

So maybe it's just not worth it.

> If this patch makes you feel warm and fuzzy, I can clean it up,
> otherwise I would suggest getting the stuff we have merged before adding
> even more things on top.

Yeah, it doesn't look that convincing.  I have no real numbers - a lot
of small functions, but I'm not convinced that it is worth worrying
about them, particularly if it doesn't really help the actual text
size.

              Linus
