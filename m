Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FCF4E7B91
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiCYRa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiCYRaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:30:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C0960D87
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:28:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w7so14525455lfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTY6GWR33LHIYWWg3yO+Y770hJAr0sFM8vC8Hv97/Ho=;
        b=GTDYFnJ644kX2MgLtEY12KufCCj4yd/pS8r3hmYl3rs0CyI13At6qv069iToU8EJCn
         SuaIaEQOqSO+6hJN9H72YJVHpZ14Vi6pCeucZweYUhIsb3243hF3vwcX84SXcCZDGsCO
         5ZHnaXRtLKQgaTtZv/R8DB79i1EpD7Opusb1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTY6GWR33LHIYWWg3yO+Y770hJAr0sFM8vC8Hv97/Ho=;
        b=r5bWxt2xMTgqMdZV3dKZWudZYP0FSSVrDP4KQ6nFysUV86zEEu1P9qHt0aOYgLFUnC
         wKC5o556IwJIwYUyp/LJpi+S0EuR1Dk6WV8OSBxaZfrlWOn6BTF0tbhsEsdOZKygI3EC
         yOtNuZxPDt2DcRt9wnqirF4gHN7+lX+FtPMOam9mkCJG6z0xLlXzBEMn92gJO4FvOY93
         VJFFC7MQ1S5pXhNZ7kigAsX4EvjSc8sshXlYIv0inrtb8hKTHNvg2/7RmoVKMR8ITdYn
         jIETXv6BnpzVhQX/yiV8dy+6Gda6uF3FioPcFQK8czEha+EBhZExTHMFo4y2A13pUZNX
         Ui6g==
X-Gm-Message-State: AOAM533WZQGHxDAlAcrPdaeFH3qk6l1tGwV7Yxd3SQOOL9kHyfMmQ+Os
        XC8Y4oiBJfJLlxKl++3/AK1/rWLxSw0I/svX1pA=
X-Google-Smtp-Source: ABdhPJwlA9k8rSgNej3OgmcwYJG0l0KMVNUwXkCt9y5tYOA4c/YC8lwUUH/xv49s5XkcmrB47E/PCg==
X-Received: by 2002:a2e:bf12:0:b0:249:3a3b:e91a with SMTP id c18-20020a2ebf12000000b002493a3be91amr8967919ljr.343.1648228704836;
        Fri, 25 Mar 2022 10:18:24 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h14-20020a056512338e00b0044a1d49f459sm764607lfg.227.2022.03.25.10.18.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:18:23 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id g24so11157998lja.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:18:22 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr8705328lji.152.1648228702287; Fri, 25
 Mar 2022 10:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 10:18:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLZC4d-JjoDyJ-0_JNX+nOnkTQdTGKvOE3fBVNvAq-xw@mail.gmail.com>
Message-ID: <CAHk-=wgLZC4d-JjoDyJ-0_JNX+nOnkTQdTGKvOE3fBVNvAq-xw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Makefile.extrawarn: Turn off -Werror when extra
 warnings are enabled
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
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

On Fri, Mar 25, 2022 at 6:13 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> +#
> +# Turn off -Werror when extra warnings are enabled
> +#
> +ifneq ($(KBUILD_EXTRA_WARN),)
> +       KBUILD_CFLAGS += -Wno-error
> +endif

NAK.

If you enabled CONFIG_WERROR, then you get CONFIG_WERROR.

If you enabled W=1, then you get extra warnings.

If you enabled both, then you get extra warnings and they are errors.

This patch is just stupid.

              Linus
