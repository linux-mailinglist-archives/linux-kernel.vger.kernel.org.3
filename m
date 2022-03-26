Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422244E847B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiCZVzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiCZVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 17:55:04 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21048F47
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 14:53:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q5so14509453ljb.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P460qBR9qVCfobuQ79cK1V0yFKiu9kVeZ2foGTksCVY=;
        b=c1rqYC+jwsqrDMMgqVOTKPytpzM5CVnx4yfphdce7HCiv+/+GnaK45XIouAqnrBlCK
         m2hHCUVajze95venepizTWrorZNo+FV2fqjfWWNfc2dFTgmD7FPdRBx50cS3k0rHIyrg
         WZYOB067EQzBpYZXsYQZZKqr3kfAaQ9SUQqU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P460qBR9qVCfobuQ79cK1V0yFKiu9kVeZ2foGTksCVY=;
        b=sYniSGCaubMXZeLn6GCPa4tSbb0W5WhONPnhe4TeCv8sCtiMwsWUBU8NBaCj57i0q/
         x6AV89ODXPblGvuXJfQysXw8olYXnF6UuXyOZvL5M6cgJ+wVh8+j+00QnbVLkjIHMZtR
         OLmJu32idKd26siABTTl2kMQCJVheTTS/fF2oTCEuSrCPgYFsLDaT9FAtscxF6GR1l4U
         BN8isdQKkpw9DlrGQlLnDyb07ts58awh+fN1Nrx8VZFXS5qAFtMD5Fd4FcA7+L2OPyMX
         hm1oMIP7zTswnf4GD84kH0KKdLlcQoJQF/STQ8XrWfhGor1xLmK5Ekt6UNp3qj6ksD4U
         2GLw==
X-Gm-Message-State: AOAM530y9OpzUc5T45DOCne8F6AL3lEcC2mOSUAY0zyS/TDhBI4tecu7
        tgTKHRciRwHgai6drGegwx7Gz5VRa8nw+MxZRPs=
X-Google-Smtp-Source: ABdhPJzJIoQFzyWbEECTA343rRTDyPPgkS+YPncsmlEvL5ulQ4mibdBiN7voRCcwF+EgGJWkdSjPTw==
X-Received: by 2002:a2e:9d08:0:b0:249:b8b6:8f7a with SMTP id t8-20020a2e9d08000000b00249b8b68f7amr7857536lji.310.1648331605111;
        Sat, 26 Mar 2022 14:53:25 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e9796000000b00249b86a210bsm678197lji.91.2022.03.26.14.53.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 14:53:24 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q5so14509410ljb.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 14:53:24 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr13307754lji.152.1648331603613; Sat, 26
 Mar 2022 14:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220326152646.GT8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220326152646.GT8939@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 14:53:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhG15HiqR+WM5M2mMy9F17yVdT8_M0ra0tGJS+5ibrdw@mail.gmail.com>
Message-ID: <CAHk-=whhG15HiqR+WM5M2mMy9F17yVdT8_M0ra0tGJS+5ibrdw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/core for 5.18
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
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

On Sat, Mar 26, 2022 at 8:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi Linus, my first pull request in like forever, so please bear with me.
>
> Boris talked me through it, so hopefully it isn't entirely insane :-)

Well, it's not exactly working too well:

  fatal: couldn't find remote ref x86_core_for_5.18_rc1

there is actually a branch called "x86/core" there that has the commit
you mention as the top commit, but I'm _hoping_ you had a signed that
you created, and just never pushed out.

So I won't pull that branch I found, in the hope that there's a simple
"Oh, let me push that tag out" solution that gets me the signature
too.

               Linus
