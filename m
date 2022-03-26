Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627B24E83CE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiCZTmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiCZTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:42:15 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F43712E149
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:40:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d5so18574808lfj.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eo+NI/ZY6vwsGX0YbjboRUexcl2mfDPwhfiG8UnYnwk=;
        b=BnS1v48fprKmSRXFjcrnsMCOkSZvYZQKHkA3LVRLp/DQnYYFla62uXIfXJRAbLMigi
         bFCZxlifzHg0dE0dAEH4xtBlMhLSpHZdPD89nlH9F7pdl3UwkeWWhnSQ/WTlG5C7cq9x
         p3SeW6+eqS57A/bUxi4swECZhDIttG9TD9X6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo+NI/ZY6vwsGX0YbjboRUexcl2mfDPwhfiG8UnYnwk=;
        b=VAqgvHV+Vp35xBdDDqS4Z2YJory5WzvQ3CTS0YWc7CP7T2qAoNZiyne4ZzSJnLTF/8
         gRSE4EjpWtEWpnLp3VKuEuQBVdvv+tw3oQz6vQ7dXvpqGmI3GiHWwmrpzZ7Fz5L9FVxY
         nKdBZThpCmVFUnjnFgfG36fFUtBEAmQIf3rU6tBDLjvz5s13Obh0yeSTahMF+nXsXTtK
         iPHcHFck2JJRVrQzms1Subx4Xk+nCWBOf3/d4cjtErd1grswVxiUtKWNzHKjA8Jqyw5+
         ltLmRp/lWlr4wdVQmn7Nqau5i9ZvqUfvv6joq6qpDnVUuS0UxtR3tyNZubkLQ/3wFc0+
         O1jQ==
X-Gm-Message-State: AOAM5307J4y2H6buVT1FFQ/R4LsIm+Dagd5A4e20/Y3izTIqByuvt1KB
        PuYYO6da40vQGTvmeNsSGcglSwbu2w3RXhruXa0=
X-Google-Smtp-Source: ABdhPJx7BuXLdNeQ5k7WyoxV5/MGZerTWFe8l6G5YV+hRrmgVlPf3yVs7OYn+GGUHVavzSc3BVmeHw==
X-Received: by 2002:a05:6512:3c92:b0:448:392d:af85 with SMTP id h18-20020a0565123c9200b00448392daf85mr12826114lfv.511.1648323636219;
        Sat, 26 Mar 2022 12:40:36 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h7-20020ac25d67000000b0044836d7c475sm1147556lft.147.2022.03.26.12.40.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 12:40:35 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id bq24so2636403lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:40:35 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr12881072lfh.687.1648323634830; Sat, 26
 Mar 2022 12:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <202203251443.9BBADFD98@keescook> <CAHk-=wjeGc-BjkDWTYkXzyQu-vf9EEujuT-6=U7Od0DvCUfb8w@mail.gmail.com>
In-Reply-To: <CAHk-=wjeGc-BjkDWTYkXzyQu-vf9EEujuT-6=U7Od0DvCUfb8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 12:40:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wid1da7CONOA4ia++vKe5pCFda6gwdafjFP4HXJQcjcsA@mail.gmail.com>
Message-ID: <CAHk-=wid1da7CONOA4ia++vKe5pCFda6gwdafjFP4HXJQcjcsA@mail.gmail.com>
Subject: Re: [GIT PULL] FORTIFY_SOURCE updates for v5.18-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Sat, Mar 26, 2022 at 12:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Because if all the compiler issues and warnings have been sorted out,
> it sounds to me like the compile-time side could/should be done
> unconditionally if there are no runtime downsides.

.. or do the existing compiler warnings for the builtins already cover
all cases, and the only reason the fortify-source code has
compile-time warnings is that the option takes over the builtins?

So maybe there's no upside to the fortify-source code for that case?

              Linus
