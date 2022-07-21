Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95A157D16E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiGUQY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiGUQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:24:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB788E19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:24:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e15so2825006edj.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdzyaaSS9wVD/EeKAhIRDfgg/YpGZ+e1ODi82IyhDFc=;
        b=ixbeGzrVmvVURAdO5sU9OOcCnx0pffmC11dEXfqHTPv7aPiBEc70P0ZZGoaIHU3BTQ
         A9M6pSaNj9xmUq15oOdfCneHQ0oBU1DIhG+Mkm71JN+8EIG3QsRnX+RGJnlZQQZk2ZPm
         Om2nQfvVC8EjD+aZQMkscw2RC8rR7VediHcGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdzyaaSS9wVD/EeKAhIRDfgg/YpGZ+e1ODi82IyhDFc=;
        b=Ha78wl7GnVRlZK4RjXcng9xAPfiU5XPUO1VKNsqTi0OfR8rvyVdEHJpsT6HkA0GgCe
         5N9RujI3oDcMdsAHshKKaFN9gTNYiPYNZubU5uZOXS2l7HPXeLZqe1wiPv69vEJ9Br4X
         4b/VoRpRS/NHNqGngHkwMAz7TI7z2pN/FXpHVmn8QBbuNp6bH2IoEDuHuSLjH1BaQnfe
         2ma1ndxr4cwnd5vH2aCPEiT9IJqhdL4oy3933nEAJGvY5DLdvPz9veXQe4s7nkbv9x7N
         m5Kp+eRxAThsUy2t08dwCa6TIr0yXf4wwR5TI2RZblpu3/1Jc9DLGTfXx9UsgHWPvQpj
         SfnA==
X-Gm-Message-State: AJIora9/7lG+0f5sGzuhELo4ySVj96o4WPV9YfwsRdiHsOGlglC1yA8M
        EKvLN0IVLz4SYt6IjA4G8sI54ATaQvkWJl2DA4E=
X-Google-Smtp-Source: AGRyM1sPpPvk0BSR51Ghukd9/ryEb8uBe9rg3KV+x73uZgr6nDuowExiH6ftgqpNT2AcsEMP/y0EHQ==
X-Received: by 2002:a05:6402:d05:b0:425:b7ab:776e with SMTP id eb5-20020a0564020d0500b00425b7ab776emr60003850edb.142.1658420688351;
        Thu, 21 Jul 2022 09:24:48 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906328f00b006fee98045cdsm1051088ejw.10.2022.07.21.09.24.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:24:46 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so1101693wmm.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:24:46 -0700 (PDT)
X-Received: by 2002:a05:600c:4e86:b0:3a3:2edc:bcb4 with SMTP id
 f6-20020a05600c4e8600b003a32edcbcb4mr4239876wmq.85.1658420686023; Thu, 21 Jul
 2022 09:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093042.9840-1-khalid.masum.92@gmail.com>
In-Reply-To: <20220721093042.9840-1-khalid.masum.92@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Jul 2022 09:24:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UbRX194rDztr_=eoALg4kTmjzq=EXCX6RJSSq3vO=fbw@mail.gmail.com>
Message-ID: <CAD=FV=UbRX194rDztr_=eoALg4kTmjzq=EXCX6RJSSq3vO=fbw@mail.gmail.com>
Subject: Re: [PATCH RESEND] scripts/gdb: Fix gdb 'lx-symbols' command
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 21, 2022 at 2:31 AM Khalid Masum <khalid.masum.92@gmail.com> wrote:
>
> Currently the command 'lx-symbols' in gdb exits with the error`Function
> "do_init_module" not defined in "kernel/module.c"`. This occurs because
> the file kernel/module.c was moved to kernel/module/main.c.
>
> Fix this breakage by changing the path to "kernel/module/main.c" in
> LoadModuleBreakpoint.
>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
>  scripts/gdb/linux/symbols.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index 46f7542db08c..dc07b6d12e30 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -180,7 +180,7 @@ lx-symbols command."""
>                  self.breakpoint.delete()
>                  self.breakpoint = None
>              self.breakpoint = LoadModuleBreakpoint(
> -                "kernel/module.c:do_init_module", self)
> +                "kernel/module/main.c:do_init_module", self)

Fixes: cfc1d277891e ("module: Move all into module/")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
