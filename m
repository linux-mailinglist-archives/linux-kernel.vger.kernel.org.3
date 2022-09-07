Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7785B01EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIGKaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiIGKaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:30:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A22D237FD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:30:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bt10so21747064lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Yh7EP9E1bY57iyGLbA3U+rsfppFelPTsU7HrsvIKkms=;
        b=S2I+xRADc9Pg/U+U8TdBBI1ZkPWcrte3gR+yOuHYUiDu71CVKzuiuvDhZm8SytmMYS
         hR/2OzNyqcUkAi7ASqbWfk/3rtsnCgiMNfNAhQFMbC8b/c1VRv/1TXjAbpqU7vAdx1we
         S69wh2KOCuAbUb/8L4u/HPsJZxO1TvU/XcxsIQH0uk3W0/oFjHF+PWdSeuY0Z0v7RaLM
         ziLcYarw11N3zYKzUWCQ6CIS1Fx+TnC1EFo0GbeJEv4Xs03Ql4Hue31tLeSvS4SICcxC
         N1NOwtcd/myxIDm1TsHMhKH6p0/5Y8MieWI74GqCCIGbIqDfU9u+tM0o2HbUbQwCrxXl
         B86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Yh7EP9E1bY57iyGLbA3U+rsfppFelPTsU7HrsvIKkms=;
        b=w2JOF7NdZp+H9hPJ/RmG0U8oIeh+65VY+zIVZ8uaASWwW/HQIvE+va+R9s+8e/EpCE
         b73xWgbrlWTYtoHlwPLcip0cyZbBhuaCXdswzCO5FGdGxk0NCtplfyuB+CjWtyNM5cvw
         eHuLRjLWKRAMNliFkQpl9moz4zCqzO9XecvatMSf2YRX9A/j5D1cn+WkU/xHRIw0GRja
         /X+mctRWN98Yc/wWhEmfu4JY2J39FQviGJtynRpCoQ/77ujk891+wK2TS7vo83ffuoXR
         GS6ct2KuCLvG+00Nc2nNL0AwZsvJp+OVLBDokPuw+c408gqZdyG8bMji9wcZLaJVistq
         bKZg==
X-Gm-Message-State: ACgBeo0X7Fkt/jpiepGk+CXcAX9jdcfm3Yi3EGSLZKrU2Hap2Q1HRJqy
        3M3QzWjLJ3CQHEYx9JUbteL+3S4Iot3WKqZuyWANCw==
X-Google-Smtp-Source: AA6agR7e9UFEyOx7xlO9YPEcerymB//PN3t+H86LvxXaUPkJBx1JVWMFdhoYsKnQWjD+W97muc1Pbb+KITSjmaJ/zC8=
X-Received: by 2002:a05:6512:1293:b0:494:96ee:80c1 with SMTP id
 u19-20020a056512129300b0049496ee80c1mr857731lfs.417.1662546607161; Wed, 07
 Sep 2022 03:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220907100533.1719128-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220907100533.1719128-1-vincent.whitchurch@axis.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 7 Sep 2022 12:29:55 +0200
Message-ID: <CACT4Y+aBpkfgEvM6rE9Kg5U0MwcHnUA+Fm_2F4g9A4QQ3hav4g@mail.gmail.com>
Subject: Re: [PATCH] um: Prevent KASAN splats in dump_stack()
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>, kernel@axis.com,
        Patricia Alfonso <trishalfonso@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, 7 Sept 2022 at 12:05, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Use READ_ONCE_NOCHECK() when reading the stack to prevent KASAN splats
> when dump_stack() is used.
>
> Fixes: 5b301409e8bc5d7fad ("UML: add support for KASAN under x86_64")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  arch/um/kernel/sysrq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
> index 7452f70d50d0..746715379f12 100644
> --- a/arch/um/kernel/sysrq.c
> +++ b/arch/um/kernel/sysrq.c
> @@ -48,7 +48,8 @@ void show_stack(struct task_struct *task, unsigned long *stack,
>                         break;
>                 if (i && ((i % STACKSLOTS_PER_LINE) == 0))
>                         pr_cont("\n");
> -               pr_cont(" %08lx", *stack++);
> +               pr_cont(" %08lx", READ_ONCE_NOCHECK(*stack));
> +               stack++;
>         }
>
>         printk("%sCall Trace:\n", loglvl);
> --
> 2.34.1
>
