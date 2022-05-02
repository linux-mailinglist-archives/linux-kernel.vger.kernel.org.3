Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FF516ED8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384714AbiEBL15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiEBL1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:27:55 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C677512AD6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:24:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7bb893309so143748967b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 04:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwvAnvUaIJJRSunJbC4OZJs6Vyt9EM+0eDUVq9Dsk1U=;
        b=o5NF9FC6K72F/h2n6aulgh1GAdeHgc502Z3ip0I0sJNkdARQtJTxlS5trv1wZ5AS0n
         6JcW5cs7Og9CMtp1veD6Bx0U9UVHsEuMpoI32UwSF8Hgy8F7XKXyOmr9nCKsi3yOm6Pb
         tBhlmLnV3sOQq+C9Ah3WJSalLWARBjWDc0ptRv0dAwrtUt7PUHLlw00jomdPOkN4wxBr
         QGwZvCj2ZuJDr16ke4mByrEILwjjGrMcWPpdN8bx4UcCQGnKqyTxQDSMpVgDgHKUCBOQ
         cADaoPvzFL0xadH/FZhGfihwvgp1mozXhO2XciPURpjNhbEHKE4PX8DksJuKzJQc8YIE
         mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwvAnvUaIJJRSunJbC4OZJs6Vyt9EM+0eDUVq9Dsk1U=;
        b=V4rQCg1fvYxkEy19oCZDjKGoZSoxHMm3jUeEziAm7qhWF9Mv8ZNA7Zmm7xYEt6Q7sD
         qFGHhtRL9vyqisiPxY0bSnXS2yynOfIQ5XdkCzwWLSY1/sBi33dQb06iR5Iosqv/q+kx
         zTQasLf8qv0jxdZnScBgdsYLxA48HVEv1c4GV7Qr5hteclk7YALCfZGzozv2VHpE0RYN
         8DLyBJ6i62OCsAOhUpwYRRIdy3dddMPeMHX6dsT8q3n0FZQ63gmwCU2nmEJHa4hUvyBX
         sfnlqCt4vgMEtEfhBWLSfZJuQmiN9q79Ngt7NBL9jgSJyI58vUy35r4GaPRvVlJ8G3D6
         AxOA==
X-Gm-Message-State: AOAM533ZxF47ygVz/9SxeLXzq9rrJA90ciprkFpPXskk2tzmQpAGup1i
        JQWs1La2xPSzbZNQikeNxUvImbQAfhVMfPzif7ujSw==
X-Google-Smtp-Source: ABdhPJyyuuuymm2QCmlEC/ne5u5JNUW4iQTzzOrBK/AxxQJVCIoeNaPB6/OiCvFOLasBDFTghU/wpeTaxPurtfSVyMI=
X-Received: by 2002:a81:4e83:0:b0:2f8:f7d3:2c71 with SMTP id
 c125-20020a814e83000000b002f8f7d32c71mr6947056ywb.264.1651490665824; Mon, 02
 May 2022 04:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220502110741.951055904@infradead.org> <20220502111216.350926848@infradead.org>
In-Reply-To: <20220502111216.350926848@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 2 May 2022 13:23:49 +0200
Message-ID: <CANpmjNP6k5F0vHg6xiu9yhmC7PotGPxVW8M2_pvSKY25eNCnDQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] jump_label,noinstr: Avoid instrumentation for
 JUMP_LABEL=n builds
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        kernel test robot <lkp@intel.com>
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

On Mon, 2 May 2022 at 13:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> When building x86_64 with JUMP_LABEL=n it's possible for
> instrumentation to sneak into noinstr:
>
> vmlinux.o: warning: objtool: exit_to_user_mode+0x14: call to static_key_count.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x2d: call to static_key_count.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/jump_label.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -256,9 +256,9 @@ extern void static_key_disable_cpuslocke
>  #include <linux/atomic.h>
>  #include <linux/bug.h>
>
> -static inline int static_key_count(struct static_key *key)
> +static __always_inline int static_key_count(struct static_key *key)
>  {
> -       return atomic_read(&key->enabled);
> +       return READ_ONCE_NOCHECK(&key->enabled.count);
>  }

Did arch_atomic_read() not work? Or should this also be unchecked in
instrumented functions?
