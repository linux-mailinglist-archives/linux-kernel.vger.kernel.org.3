Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB1504B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiDRDKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbiDRDKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:10:11 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9411918B0D;
        Sun, 17 Apr 2022 20:07:33 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id f7so4406038uap.4;
        Sun, 17 Apr 2022 20:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tNjjyGaUEQ8lUKWlzMg1jMDbdSXdCmUFakLqiNuNiG8=;
        b=mVWSz28HnIW7UGdwHQ9Pim8IwvN/k61x7XuAbnp6HBASWmnWsgHZFnJK9SoO/3TENd
         qFw5XS5DkZtd2I0JG6EKulOKgQl0LOsmZ2qw9lMTT8yrUzAoojuIfpD8giPfiIO7U8+E
         rXqBnA2MOD919ZaSbv9a+HpqK3c30BFuHmLPvQ2zfcTnP0C8mMkxskzknziFzMS3Qiu0
         A9q5GlpfUayZ9nk8ZGjJocVDuGRYc/SOWIEvOINiMP2sTPfbVv36ZxkKFHSd8EEz5awS
         xDGvMnYJhH+s3oPQviw6HmHV6mM73l6Ipx8WAHEuUnJ6rxH3JRsoXe6lf3k/mFgGOn71
         L2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tNjjyGaUEQ8lUKWlzMg1jMDbdSXdCmUFakLqiNuNiG8=;
        b=QnpAwUz7yQxvQRl8V3G7nMx/SxrX9WyZYTPmQ6Lrv+x3k3wzvzZQM1nU1fuOGu2kBt
         vXl2e4hG370Xb5TO/9JMRLaBfcsp8FGA0wHwzFbyuftUw/VVD1GZ2ca0ZL35P0ZVHjLP
         g6c5NbVJQRmHKj3wwdYsbPwdOSFZK7dhG/m8kSAese7zPzh7popr8T1X3xPg+p+mlnrp
         nKUFX3qOmiIbw4QbWi0emiuGG9wNSFN21I9BOxnDe25Uq1CaMa56SG0LtDeJGY53phfs
         E7FE5fW4KHpw7cKgkas4YSsnsu8+KMWOIkUCViXE6+UZ4KFrsF2q6L5XKdBxdg3Q1YGB
         ZUag==
X-Gm-Message-State: AOAM533raX4o0q2hZSDMKAkabOEm8OSBNoXsOXknsD6jSU0JSxN9b0PZ
        iWKjHNYx+0CenmxAm6cWdxeH0JnFgbrs3jxEwPbMShpcKQvIcw==
X-Google-Smtp-Source: ABdhPJzDlWT4b6XmkHk9RENmkRsTi5OYlhZMVY04k+uYdTNe0NBDTUr3NYQwuOaj6746OpaTNxAORnKjX0nLmE9rk7A=
X-Received: by 2002:ab0:6f8f:0:b0:35d:5045:46c4 with SMTP id
 f15-20020ab06f8f000000b0035d504546c4mr1856021uav.116.1650251252646; Sun, 17
 Apr 2022 20:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
 <20220417165208.39754-1-schspa@gmail.com> <CAHp75Vc8HwheQVOpcn_Lxk-bOOMLybr=m6OdO7mJ-vE9xywBLg@mail.gmail.com>
In-Reply-To: <CAHp75Vc8HwheQVOpcn_Lxk-bOOMLybr=m6OdO7mJ-vE9xywBLg@mail.gmail.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Mon, 18 Apr 2022 11:07:21 +0800
Message-ID: <CAMA88Tr6NvfEiPYnt0A60GiQKiiT6LT7X83GRku-4PDcG2EtoA@mail.gmail.com>
Subject: Re: [PATCH] gpio: use raw spinlock for gpio chip shadowed data
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "hoan@os.amperecomputing.com" <hoan@os.amperecomputing.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opendmb@gmail.com" <opendmb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

>
>  Changelog:
>  v1 -> v2:
>          - Reduce the useless stacktrace.
>          - Split to series of patches
>
> Changelog usually goes after cutter =E2=80=98--- =E2=80=98 line.  Besides=
 that you haven=E2=80=99t compiled your tree just after this patch.
>

Yes, thanks for reminding me, I will fix it by upload another version
of patch if there is no other problems.

>  Link: https://lore.kernel.org/all/20220415165505.30383-1-schspa@gmail.co=
m/
>
>  Signed-off-by: Schspa Shi <schspa@gmail.com>
>  ---
>   drivers/gpio/gpio-mmio.c    | 22 +++++++++++-----------
>   include/linux/gpio/driver.h |  2 +-
>
> You can=E2=80=99t do it for one driver only. As I told it will require to=
o much of additional churn to make this to be series.
>

It seems I have misunderstood your "too much of additional churn". Can
you explain it?
The gpio-mmio.c and driver.h here are the basics of other gpio
drivers. In my opinion, these two files
belong to the basic code of gpio, and functions such as bgpio_init are
declared in
include/linux/gpio/driver.h and implemented in
drivers/gpio/gpio-mmio.c. So there is no churn.


--
Schspa Shi
BRs
