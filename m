Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EBF5613D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiF3H5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbiF3H4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:56:52 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC0C403F2;
        Thu, 30 Jun 2022 00:56:51 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31772f8495fso170968337b3.4;
        Thu, 30 Jun 2022 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pEG1/5zis6fn9rNZ4cGko3gg4B1FcMMHyqkPX5BcdX8=;
        b=lUC9kYaRwM0BjvSJzSRdKvwLFR+U74/hzLpRgkBkjOYr3XOjlj8CgqHmG2gaxHtuXW
         1p75RyRI75cVj0hLo6CN4AvRSRqvF8919+hwoZ+eS6PhYrHH8dnELlYJpoDseAw7VhOo
         YvtV6hmG/9VwnLXEUbU58K+8kqJhnUsZWZJUfHjM7H/QyIeUdrBB2NtsHrvGxBrWj8zn
         yWrCYFkZpCdJ9Cv1Wykh5yWKbAOic2NH8/ekh+lNWvY30npihYkkuaKywkv1Mml0gnUR
         ko0SCMOC/MoRxXjcrijqOJxmOCmK9mwWlNQoGhTEgsz9JYEy3Ek6VyKRMaW9lGQGlnBh
         ZeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pEG1/5zis6fn9rNZ4cGko3gg4B1FcMMHyqkPX5BcdX8=;
        b=F3pUhr1e3yoggIiQXQN/2ZICZsMt8gSHkzD5FshbaeCT0/EzmIHmdK8u9b+TmkCZPW
         22f6Wy7TRP1R7cHQajG1yMa184MKEfQ0gRpTiwP25iMvmzwT8rTwlNYVJAzblITq9sbP
         LIH4Ogot65byst8OJWyHKCntZNs1Y9RHfUviArbsRn6G5b0TgBoSO0rZVVVD/HbRqkHM
         zacfozMnKT3dpTg80gbZzSgKnGPqKHBByaXIWsc1IxfPUVfs0qWMQOnL61Iqn685T2m7
         SVHENeLrYddwynI/6KGay9x3GAmD3L1s/Uuc126QKeS+joe5K8Oxxt+/rZM2Q1nAAf17
         bWkw==
X-Gm-Message-State: AJIora9CQ5FV9dTzXPmsMwrZrliptktsGwWkBeL7Qa5u4A081xXenXrd
        7hFwlPrtyoF1ZBNFcA25H23Wcg+YIFr+cDCbYONzUJyoK4zmaQ==
X-Google-Smtp-Source: AGRyM1so4U5iXRDnUOmFWKUYfH0VuZUgTl25P/lq+qTjChyyYigKaV1z5jimYDiiHWkd9cptmD5wDFJk6IJadT5Wtj0=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr8806187ywj.195.1656575810965; Thu, 30
 Jun 2022 00:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220628214511.37373-1-andriy.shevchenko@linux.intel.com> <4ae74f48-c51c-cb74-548d-46ff9a9a7a7b@linux.intel.com>
In-Reply-To: <4ae74f48-c51c-cb74-548d-46ff9a9a7a7b@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 09:56:11 +0200
Message-ID: <CAHp75VfY_4CA36MHSi7=VtmcGdXi5kL9aB1HYy2WOJNqc-6L9g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Drop PM ifdeffery
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 9:42 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 29 Jun 2022, Andy Shevchenko wrote:
>
> > Drop CONFIG_PM and CONFIG_PM_SLEEP ifdeffery while converting dw8250_pm=
_ops
> > to use new PM macros.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> Not directily related to the patch itself but do you have any idea why
> 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")
> didn't wrap RUNTIME_PM_OPS() pointers with pm_ptr()? I'm asking this
> because in SET_RUNTIME_PM_OPS() the callbacks are only created with
> #ifdef CONFIG_PM so I'd have expected RUNTIME_PM_OPS() to maintain that
> behavior but it didn't? Was it just an oversight that should be fixed?

I have had the same question, but I think it might be related to how
PM runtime functions when there is no respective configuration option
set.

+Cc: Rafael.

--=20
With Best Regards,
Andy Shevchenko
