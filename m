Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA255AB6DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiIBQvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbiIBQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:51:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABC106D9D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:51:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so3412033edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CIuVjsJFs/1+sf+Cg+FMFftnB4n0/AkG3KNU3Ey0ETU=;
        b=eVZa+U/4lGIRtCWran8xhlisYjslgrH9X99Va98wep5cXSM2kOQtctY94/UKvuZ28G
         9//46c+63SVmePLmZj7oabn9iCeFyftXVMtqNu6oA/nDv0lI0E/SHG7RfBq9sY/UV0ex
         562giTCMbkSy8wKo9/bK9MDmb1hcU2IK/xYLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CIuVjsJFs/1+sf+Cg+FMFftnB4n0/AkG3KNU3Ey0ETU=;
        b=gkYK/0bCOybL0Gv30dLbOs1Ql+Yrsv74sPbKX04jxQtREfeYWjoXvlggwiZLI9jpEy
         t2j42AJvZimlRgAFe6OKjofOsvkm1m9oo4++HjUwfuaXm/KSuriZjiTlX6NDtoeP4p9L
         GViEsaxI8BMMeeAdB/Z09sOyE6MzwfLw1NfEiG4BCdTD6TkKJHJaJicZxiEe9QRG1eAe
         ij6gcIzUjTIPrGA/cSZzkd+eU2QbZs5nPg5wKDrWbtXndhnH4ZSHEQmRFL8WQirlOgWW
         5BWLO7Q7RiDOQ8DnHdy7HZn0L6oeoF8ocERmfAOOaMDMDE3vmISR6p7MXzGm95qhnpu9
         cxgQ==
X-Gm-Message-State: ACgBeo1yBJiyGbe5bYo55EQyxzfWg3GFsa5GZTIKaHciGaJsUphHatqi
        Mi8XtH7fL0bcwOxuPOOiws42uE1hbl7DMjTEyd4=
X-Google-Smtp-Source: AA6agR6qzf1cXKCkkWLYIx3/2INCUwuLiItBsM3xvmt8LWgzATJpU4EJnfdtOcf/lJhE9YMmoNJHxA==
X-Received: by 2002:a05:6402:240a:b0:446:39d9:95d7 with SMTP id t10-20020a056402240a00b0044639d995d7mr34341531eda.253.1662137495411;
        Fri, 02 Sep 2022 09:51:35 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id o27-20020a17090611db00b0072eddcc807fsm1486917eja.155.2022.09.02.09.51.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 09:51:34 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id v16so3040607wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:51:33 -0700 (PDT)
X-Received: by 2002:adf:e60b:0:b0:225:877e:176c with SMTP id
 p11-20020adfe60b000000b00225877e176cmr18213258wrm.193.1662137493486; Fri, 02
 Sep 2022 09:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220902130625.217071627@infradead.org> <20220902130947.190618587@infradead.org>
In-Reply-To: <20220902130947.190618587@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Sep 2022 09:51:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com>
Message-ID: <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com>
Subject: Re: [PATCH v2 08/59] x86/build: Ensure proper function alignment
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

On Fri, Sep 2, 2022 at 6:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> --- a/arch/x86/include/asm/linkage.h
> +++ b/arch/x86/include/asm/linkage.h
> @@ -14,9 +14,10 @@
>
>  #ifdef __ASSEMBLY__
>
> -#if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
> -#define __ALIGN                .p2align 4, 0x90
> -#define __ALIGN_STR    __stringify(__ALIGN)
> +#if CONFIG_FUNCTION_ALIGNMENT == 16
> +#define __ALIGN                        .p2align 4, 0x90
> +#define __ALIGN_STR            __stringify(__ALIGN)
> +#define FUNCTION_ALIGNMENT     16
>  #endif

Ugh.

Why is this conditional on that alignment being 16?

Is it purely because the CONFIG variable was mis-designed, and is the
number of bytes, instead of being the shift? If so, just fix that, and
then do an unconditional

  #define __ALIGN                        .p2align
CONFIG_FUNCTION_ALIGNMENT_SHIFT, 0x90
  #define __ALIGN_STR            __stringify(__ALIGN)

(leave the asm-generic one conditional, since then the condition makes
sense - it's arch-specific).

           Linus
