Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6689458C2B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiHHFHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHFHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:07:49 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C56300
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 22:07:48 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id d12-20020a4aeb8c000000b004214e709b72so1458083ooj.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RlxNA00D9e7VQPoEGTaRVAdyo9WHW2wiWsTFor+8nJw=;
        b=Hk3W+eo6HKWQsdmG6QfS9M4TjMnr5f6FjyQracP5ocBC8obtbDAh278xmWvMKbMXqw
         e0TT4tk/bwAQUF+jbw2jPvlzV9OFPpJ21ueR1JdoGg19kInhs1flRl4UGLwWsr1z1tM1
         GNDpLdqEYpw0M4V/JXfxwlMtmRUkq1+Z/7DFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RlxNA00D9e7VQPoEGTaRVAdyo9WHW2wiWsTFor+8nJw=;
        b=V3DU8K2Eq4Gb3LRUpCw0rjg3hzyUixH31DPZ1/sFfS21BGZWoBhoTHY8cjSoVKn+rd
         Cp4+AtYJCMoggWIgJdxb0GKuoWfLV1ZcMH/9g2X0fl/TTPkGqCuLXEx5L6L4LNi9hmez
         fJlVNhPW1KoOQG2guUsJzaZ1AziNIDxhJ+I2mxGJkWj3JCmOJUOGBRxEVejbuu676PGO
         KUJccLs7VEYTj6ElpviEEac+9v3fTMuN+G1nzGKYXhZi8Pb8wZ+43LhzIE3TiW5oF/PD
         tMvQI4UHcB/nZEJ1aDnWZ6VM8hYzTfMRjpyHF6hmJWVQQCjFq0PLbU3G9+bo8/hRq2rg
         bHZA==
X-Gm-Message-State: ACgBeo0MsAQeEjh7aMHttuzszKb3dcW0wukEySysLH+t9uAk+EYXNEyl
        izebYqtFutI8VS905O9B3HTf2BuTmTfVDQ==
X-Google-Smtp-Source: AA6agR4rM+o0+gL4ws5gatmqJ2qS0sN4Pfi8WTkUden0dSK+rnUVT4EGf21M3aSi6wjSeU0Ryyu5Rg==
X-Received: by 2002:a4a:4847:0:b0:443:347d:6617 with SMTP id p68-20020a4a4847000000b00443347d6617mr4736052ooa.94.1659935267593;
        Sun, 07 Aug 2022 22:07:47 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com. [209.85.160.52])
        by smtp.gmail.com with ESMTPSA id o4-20020a9d6d04000000b0061c4c925c87sm2005077otp.78.2022.08.07.22.07.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 22:07:46 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-10ee900cce0so9405855fac.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 22:07:46 -0700 (PDT)
X-Received: by 2002:a05:6870:f593:b0:10d:887e:70fa with SMTP id
 eh19-20020a056870f59300b0010d887e70famr7477971oab.241.1659935265684; Sun, 07
 Aug 2022 22:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220719195325.402745-1-gpiccoli@igalia.com> <20220719195325.402745-4-gpiccoli@igalia.com>
In-Reply-To: <20220719195325.402745-4-gpiccoli@igalia.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Sun, 7 Aug 2022 22:07:09 -0700
X-Gmail-Original-Message-ID: <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
Message-ID: <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] firmware: google: Test spinlock on panic path to
 avoid lockups
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        halves@canonical.com, fabiomirmar@gmail.com,
        alejandro.j.jimenez@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com,
        dave.hansen@linux.intel.com, dyoung@redhat.com,
        feng.tang@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com,
        jgross@suse.com, john.ogness@linutronix.de,
        Kees Cook <keescook@chromium.org>, luto@kernel.org,
        mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, Alan Stern <stern@rowland.harvard.edu>,
        Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com,
        vkuznets@redhat.com, Will Deacon <will@kernel.org>,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        David Gow <davidgow@google.com>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:55 PM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Currently the gsmi driver registers a panic notifier as well as
> reboot and die notifiers. The callbacks registered are called in
> atomic and very limited context - for instance, panic disables
> preemption and local IRQs, also all secondary CPUs (not executing
> the panic path) are shutdown.
>
> With that said, taking a spinlock in this scenario is a dangerous
> invitation for lockup scenarios. So, fix that by checking if the
> spinlock is free to acquire in the panic notifier callback - if not,
> bail-out and avoid a potential hang.
>
> Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: David Gow <davidgow@google.com>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
