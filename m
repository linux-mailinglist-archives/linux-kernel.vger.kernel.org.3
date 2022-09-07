Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0985B1045
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIGXSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGXSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:18:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E14A5C63
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:18:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e68so3067443pfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SyyrjMprS3NErINjE30okKQmNuDNpwUJEMON7tAxo1Q=;
        b=mdIv4jbq82QQqnPao5mTtHiJpr/izsQpuITHl2f3R4QHTodUWY8jke2gdE2MI4irT3
         I/y8FWZyYUnJltBREmfFSrR2viS+629k1iAIRbmyiAiEkEnGnjtj+CVGD4slBy76iGI2
         GGxm0HggwzcnFy83SJIkMMp3WLFpWnOgvK/Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SyyrjMprS3NErINjE30okKQmNuDNpwUJEMON7tAxo1Q=;
        b=rlM5TZoai87vs0d1YtFahBka4sawlvijyO37fkhcGuTkngMo1SDvGyudiW7KnXn1z8
         IxtjJ349FTK5xdezT5xrEqBBuJlgWeNCSc57qMH8rf80fjM0C77+JmU/PC7Q2kQVLdO6
         t1i7MLaPM+DIQWc+TbBmXKklfMqgFP7sLW797MkPfh0DltGYaS5fyHOKQDVvwOqSyW9B
         sZBDkv00Atn6VLm/w5/O6u7ozIeZve/bRzWG7XQEKGlKyDJp9J2Z5+FmGKwNNT64Yv+k
         jqBjNhzrJdRF3BsPFsTvI7j+jEHKleJ0p8zwJ8zEQ1Pzn4836ZGrsiIU57w/AxlXwcuE
         kzeA==
X-Gm-Message-State: ACgBeo3U8nP7usurSMVLBCoDjapuyG/pobz1mGbZY2iKf/FKhaBk8l+U
        xWixH5ub7lK1FgZvNVnfLxRF7w==
X-Google-Smtp-Source: AA6agR5ueDUNwxeTzeEDSiLI9eh0YlYBj0jPE2hM3Z0UzjPp3FRddh3oFD9BLWUhXFyw+ilA9HsRMQ==
X-Received: by 2002:a63:e205:0:b0:435:c80:ecd0 with SMTP id q5-20020a63e205000000b004350c80ecd0mr2614435pgh.174.1662592722429;
        Wed, 07 Sep 2022 16:18:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t8-20020a6564c8000000b0042c29d1610dsm11153529pgv.63.2022.09.07.16.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:18:41 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:18:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fortify: Fix __compiletime_strlen() under
 UBSAN_BOUNDS_LOCAL
Message-ID: <202209071613.A08F0F9225@keescook>
References: <20220902204351.2521805-1-keescook@chromium.org>
 <20220902204351.2521805-2-keescook@chromium.org>
 <CAKwvOdmeaUQYkd9kZPgwK0kK5BRxFi8aszyFzw8TA4JFF6y8EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmeaUQYkd9kZPgwK0kK5BRxFi8aszyFzw8TA4JFF6y8EQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 07:36:46PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 2, 2022 at 1:43 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Co-developed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> That's overly generous of you!

Well, it was a lot of work to track down, and you wrote it up that way,
I just moved things around a little bit. :)

> Anyways, the disassembly LGTM and the bot also came back green.
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Android Treehugger Robot
> Link: https://android-review.googlesource.com/c/kernel/common/+/2206839

Thank you!

> Another thought, Nikita suggested that you could also compare mode 1 vs mode 3:
> https://github.com/llvm/llvm-project/issues/57510#issuecomment-1235126343

Yeah, it could work (I tried this as well), but I think the better
approach is checking index 0.

> That said, since mode 3 returns 0 for "unknown" I'd imagine that
> wouldn't be pretty since it wouldn't be a direct comparison against
> __p_size.

Yeah -- it is a little weird. I might come back to this if we get more
glitches like this in the future.

-- 
Kees Cook
