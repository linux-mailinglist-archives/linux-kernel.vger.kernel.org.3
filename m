Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325B04DABBD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353510AbiCPHVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiCPHVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:21:36 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFFF5F8DC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:20:23 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id t7so1097003qta.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UrYIeGG5yGpNR6ELr9LbkL+htuceQjp8Txzg7tIWr8=;
        b=xowO6W4alrFFSDBXTAefiI91pi8pbTk+grQZsE2+dwN/3XPP88AeWJsVZn53hBwFvW
         diDPMBmQ7zzADt3VJhcYHPshoI6Xa5O14ZuWgtvWkmdHV1SzPydsyxnOPVf67ovlreXz
         cClkCEyKDDGP2PE47ERVSI3rja63o5sOJkLLF8GQiS6J/+b0zxqS1TgTiB/HRwpcuCX2
         GIz/BIB4Tt0ukI8ToWwgt8kBS/OKbwtxbiE/Gs+Bcl1D5lm/RgUYfkFGm28ojUUh9bBT
         zqsH51mnY2GeZ2A2ilZwB+j1ZTFy8xMB5ac/rildqWSZCrPCnnuwIZ5rpGYXi6I7Jfg4
         D1YQ==
X-Gm-Message-State: AOAM530Ab7wKYu8D4iazrAsWI8CUfiFSL7/PbfNQoyUufDmXDzz0JAMQ
        3DU4qp4u7q/D4QZ6xL3yL287kxBDz+IbvQ==
X-Google-Smtp-Source: ABdhPJw1E3+xEQ4K28YwIim9g7sVXpIv9dzJty13Z/LOvtopcvM2dbl0f3qIaLf8qL51W3TGXSA7Fw==
X-Received: by 2002:ac8:5a16:0:b0:2e1:ea00:b4e1 with SMTP id n22-20020ac85a16000000b002e1ea00b4e1mr1189166qta.329.1647415222137;
        Wed, 16 Mar 2022 00:20:22 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a188300b002e1cbca8ea4sm951318qtc.59.2022.03.16.00.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 00:20:21 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id o5so2854647ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:20:20 -0700 (PDT)
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr26791854ybn.6.1647415220657; Wed, 16
 Mar 2022 00:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220315235148.54253-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220315235148.54253-1-yang.lee@linux.alibaba.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Mar 2022 08:20:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXvgXAnZTGxBWyQ78LPko1f1uUhQRT6TxE1ZDHhRiT2Zw@mail.gmail.com>
Message-ID: <CAMuHMdXvgXAnZTGxBWyQ78LPko1f1uUhQRT6TxE1ZDHhRiT2Zw@mail.gmail.com>
Subject: Re: [PATCH -next] ptrace: Remove duplicated include in ptrace.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

CC Eric

On Wed, Mar 16, 2022 at 12:52 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
> Fix following includecheck warning:
> ./arch/m68k/kernel/ptrace.c: linux/ptrace.h is included more than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/kernel/ptrace.c
> +++ b/arch/m68k/kernel/ptrace.c
> @@ -19,7 +19,6 @@
>  #include <linux/ptrace.h>
>  #include <linux/user.h>
>  #include <linux/signal.h>
> -#include <linux/ptrace.h>
>
>  #include <linux/uaccess.h>
>  #include <asm/page.h>

This is due to commit 153474ba1a4aed0a ("ptrace: Create
ptrace_report_syscall_{entry,exit} in ptrace.h"), which is not yet
in the m68k tree, but only in next-20220315, so I cannot do anything
about it before v5.18-rc1.

Eric: Can you still fix this in the original commit?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
