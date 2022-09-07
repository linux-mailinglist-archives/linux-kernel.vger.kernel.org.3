Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B42E5AF9F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIGChC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiIGCg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:36:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9FD915C7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:36:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so13966486wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 19:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JGQk4Yytf6Zg4zT4gEe/PL2ZkzZ8fPqkUsY9qVM+pqs=;
        b=RbYSUwdDs2C68JbvIHxEXs2vUhp1qhiqoa4K/9IEZcZonH3tlSWdevFewCl22OlVDS
         5aQxIEpvxo7MQfQuTxDjyq/vIFITZWPawPLV2tqEM+NS73R4MEuESsG8QQjvTELCnnDI
         f/fbQDc6sPrGu3BX2TPwjq5fZH3Hkxm57BdLCN+vJbKgTPDnEh0ui39pcfGGQl2uKlPQ
         SCstofc0gxWJc07XVhSNvl27saMWn2qfqpc7YhXJOmMYe+ac+IIg08XGNirQ/hx/xLA9
         ElMUMPoONnipjWdoorq49p0aYn0ucwAWu82x8w1DcplDou/pOulAYciYHk3fK4gWNOIM
         Fe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JGQk4Yytf6Zg4zT4gEe/PL2ZkzZ8fPqkUsY9qVM+pqs=;
        b=wXds2KsNu5FfdVwJHfmNagqqnh+lWfzbs0jxzo8KVgabT/3bAydJuQFZj5rthKkiwg
         Pth5uWQEyE74xQJoXuyj1via7Z6uWmF0KqAuoqh291EPaZ8hqKjEqd+XOvC6pefZEiOd
         eidoMuMPC30q3sPfEHO+qgQ9vdTsP7aWav82+XzdIOdfN/yjnI54wXPp/IFW9/Y2wg5E
         lyp8mzwWavOwyCnP0S2CZu9qSsU1qQDpzfPB4iwstrwl8D7Dhll8wm0K4ZG/VZ7DV+u1
         5k1h/OINalPKNsOMldicCsUjpVP/BKhx+O51oL9NyaFiXhn7gQUm8CNVQqSs5jwbDrgL
         1zcA==
X-Gm-Message-State: ACgBeo2WW9lLIPNFhR13US5XfG0VbvvfyyyIHMQNTmOK8HAKn67xEbyr
        csOjvFOtcKTTx+vmZQio/D5XZD8A5tKQkYcZKhopTA==
X-Google-Smtp-Source: AA6agR6ZHmV5opBNE6+QYR8MCxikmETVbfAhDyULrVR6PaJX8J7kUYKWe3MS1oGyiPTUmdDCEW8xNpH+HI1qsoLZrZs=
X-Received: by 2002:a5d:6084:0:b0:228:67c1:e160 with SMTP id
 w4-20020a5d6084000000b0022867c1e160mr597899wrt.83.1662518217295; Tue, 06 Sep
 2022 19:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220902204351.2521805-1-keescook@chromium.org> <20220902204351.2521805-2-keescook@chromium.org>
In-Reply-To: <20220902204351.2521805-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Sep 2022 19:36:46 -0700
Message-ID: <CAKwvOdmeaUQYkd9kZPgwK0kK5BRxFi8aszyFzw8TA4JFF6y8EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fortify: Fix __compiletime_strlen() under UBSAN_BOUNDS_LOCAL
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 1:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> Co-developed-by: Nick Desaulniers <ndesaulniers@google.com>

That's overly generous of you!

Anyways, the disassembly LGTM and the bot also came back green.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Android Treehugger Robot
Link: https://android-review.googlesource.com/c/kernel/common/+/2206839

Another thought, Nikita suggested that you could also compare mode 1 vs mode 3:
https://github.com/llvm/llvm-project/issues/57510#issuecomment-1235126343

That said, since mode 3 returns 0 for "unknown" I'd imagine that
wouldn't be pretty since it wouldn't be a direct comparison against
__p_size.

Thanks again for the patch!

> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index eed2119b23c5..07d5d1921eff 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -19,7 +19,8 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
>         unsigned char *__p = (unsigned char *)(p);              \
>         size_t __ret = (size_t)-1;                              \
>         size_t __p_size = __builtin_object_size(p, 1);          \
> -       if (__p_size != (size_t)-1) {                           \
> +       if (__p_size != (size_t)-1 &&                           \
> +           __builtin_constant_p(*__p)) {                       \
>                 size_t __p_len = __p_size - 1;                  \
>                 if (__builtin_constant_p(__p[__p_len]) &&       \
>                     __p[__p_len] == '\0')                       \
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
