Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0B6584317
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiG1PaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiG1PaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:30:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AE560694
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:30:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ss3so3738977ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aupJBzXbRBMWeUz6YCx7u7A83Uk4qjGDN/B/6Mku+q8=;
        b=LIm80Vb5CQ069rOnNC7dzy+Fumvxt87zKwsiZAH6N0gJ4uEJJ6g8AAlfwk6Hj8kuYK
         P0q6FHxLbCFZvDAFAsY6qMz4t7lMEe9I+3h6VZZc3CmdtuDOeXlrt2T2IFH0j36AQ6Ao
         ZgyLdWQ/QczYP7QMAYnGNBfVV1QkxOqm2SZYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aupJBzXbRBMWeUz6YCx7u7A83Uk4qjGDN/B/6Mku+q8=;
        b=rcnEV5UJ/SPL6IjIC3n0Uj2fCoDoG4Y0/n0erSFlbzqekieHoEXQmuopxtP6RAgxUY
         mT6HhXr+MgZbnMJARtth5Mc0MXvs61a26P7wfzRo2lr3lCnwuMWj8b6e+nEmoND9/uwo
         vxFhnJvC4KZab+cNj0kPmV/3LEDtF0FbyQNYJnlB9bkDU6cjscDR8clr/YJgBF49t031
         b/0lJW0Uu5t6fsMjVOrYO9krrqzdvzveHxAM2FoTUZuk2TQdQk6j8oFq/6h0aj5npSgS
         Azpw9HNliMHDwuAhrUzrNfdr9cs9gsup4KghJIRsh5NaoVHYPUKZGiM1ScphHolqEuDm
         jgrw==
X-Gm-Message-State: AJIora9Jd95uXoQAKFgnAST7kC6PN0MhQ8I26Dd7j1Y+4uDvt98uqz1A
        bliyu3/E31GHS8HbdaEcginOd93lpdnZSOQW
X-Google-Smtp-Source: AGRyM1tS8L5ipiRRnrYwg0euGnJb0FerbBSQOx5tc1q7zGiV8r3TKj9DjGOs7dQCplm5HKqqDVUC8Q==
X-Received: by 2002:a17:906:a402:b0:72b:8e6e:64ea with SMTP id l2-20020a170906a40200b0072b8e6e64eamr22164415ejz.469.1659022198536;
        Thu, 28 Jul 2022 08:29:58 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090676cf00b006fed93bf71fsm547262ejn.18.2022.07.28.08.29.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 08:29:57 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id n185so1147057wmn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:29:57 -0700 (PDT)
X-Received: by 2002:a05:600c:1549:b0:3a3:2aa2:6f60 with SMTP id
 f9-20020a05600c154900b003a32aa26f60mr6915481wmg.57.1659022197135; Thu, 28 Jul
 2022 08:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220712110248.1404125-1-atomlin@redhat.com>
In-Reply-To: <20220712110248.1404125-1-atomlin@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 08:29:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WwAO-QDBmfODJ+-8nzN_+m=3drRhMg7mRd-82U4RML=g@mail.gmail.com>
Message-ID: <CAD=FV=WwAO-QDBmfODJ+-8nzN_+m=3drRhMg7mRd-82U4RML=g@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/gdb: Ensure the absolute path is generated on
 initial source
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>, atomlin@atomlin.com,
        LKML <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 12, 2022 at 4:03 AM Aaron Tomlin <atomlin@redhat.com> wrote:
>
> Post 'make scripts_gdb' a symbolic link to scripts/gdb/vmlinux-gdb.py
> is created. Currently 'os.path.dirname(__file__)' does not generate
> the absolute path to scripts/gdb resulting in the following:
>
>     (gdb) source vmlinux-gdb.py
>     Traceback (most recent call last):
>       File "scripts/gdb/vmlinux-gdb.py", line 25, in <module>
>         import linux.utils
>     ModuleNotFoundError: No module named 'linux'
>
> This patch ensures that the absolute path to scripts/gdb in relation to
> the given file is generated so each module can be located accordingly.
>
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  scripts/gdb/vmlinux-gdb.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> index 4136dc2c59df..3e8d3669f0ce 100644
> --- a/scripts/gdb/vmlinux-gdb.py
> +++ b/scripts/gdb/vmlinux-gdb.py
> @@ -13,7 +13,7 @@
>
>  import os
>
> -sys.path.insert(0, os.path.dirname(__file__) + "/scripts/gdb")
> +sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + "/scripts/gdb")

It seems to generate an absolute path for me, but some quick web
searches show that it's not guaranteed so I guess you must be hitting
whatever corner cases it ends up being relative.

The fix seems reasonable to me, thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
