Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493645AB584
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiIBPms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiIBPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:42:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764566106;
        Fri,  2 Sep 2022 08:30:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w28so1716105qtc.7;
        Fri, 02 Sep 2022 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i/lSYC+D0YCnW06asS8PvEZs2Um2pfXz+8inDQOxELk=;
        b=Nk0mtwUDGiNbIUIaCOGmhASrJX3y/iRIMkGZeAHzSCD8WLD2F90k6A4zvLgKuENfHt
         62+DjbAm4X6X95z+0QVHgA+kqz+Wd8AkfywVT6ZrIt+6YdnRpXTwXbv/CRib8YgNpjTk
         In56YCt/4xSXQL5AgosfyWIItcqhUnK2ch0xc0XiH75/LQS99vQgDGKQdD1YD6NCso+q
         WS1q1BtdxoQjcpcfeBeF3F9fzMBVwnf8f2/TMQ7IUWAhPM1BYRClKABzYDVaqLi3q58a
         ry0wPHtD+03CmXrDWfBgGhUMlVepxQcuugBOH/8UKj6OG76UVsqtCN3MExcbO9oqrl3t
         AiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i/lSYC+D0YCnW06asS8PvEZs2Um2pfXz+8inDQOxELk=;
        b=Z+al0kImFv9pjMwWNs1FF3meVDmPQGs8SlhLKhCYG499PJJwYINynqjXbp9QsXYskA
         vOjukCin2adOWnIMfeglwBh+WTuYALOJF0xrDhg+rqZv64FnMW0eRhd4tCcDjRRyakbc
         H3JCUP0phtAFb69BoexH5VmeRGdhX1XMxvAwqQG/1OTOFzco3YNh8zm9HDCKaxZnsXRD
         MFK2phQqtjwndGFCjvsBFrACp89gRABsWRfDiXCtK+9q+VEEK9tdos6mfZqr8dwmO/tG
         fo3Mi9beNr9elUN5njJVUDrVTsKz72Xv7KLnOApblMhgqOtLzM17LmRLBxLosiHYtthx
         9oCg==
X-Gm-Message-State: ACgBeo2rdaHbB+wtGSY0eqzLi3WyaPbJjIZn++Lo+TG0jxnUxpKaZyWP
        Pg15sA+7sWQPv5TuEnnfTs3yVeOGSTiMHdlhH1U=
X-Google-Smtp-Source: AA6agR5Rgp0kyFjwyS3DApvOOGCsBu2ulqeosuzPG7bZV2mOlC0O+BdaOlpQAcFyKB+Vu1wdP7GAFU1Dx8k0GE0HIU4=
X-Received: by 2002:ac8:7dd0:0:b0:344:afc1:b11d with SMTP id
 c16-20020ac87dd0000000b00344afc1b11dmr28058813qte.195.1662132642756; Fri, 02
 Sep 2022 08:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220902131328.3316436-1-cmo@melexis.com>
In-Reply-To: <20220902131328.3316436-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 18:30:06 +0300
Message-ID: <CAHp75VeyR-0E+7rs4h-KfPHcef5LGg0vt7f5Pxjfij6vmmLQCA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: temperature: mlx90632 Read sampling frequency
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 4:13 PM <cmo@melexis.com> wrote:
>
> From: Crt Mori <cmo@melexis.com>
>
> Allow user to read sensor sampling frequency to better plan the

the user
...or...
users

> application measurement requests.

...

> +       int ret;
> +       unsigned int meas1;

Reversed xmas tree order?

...

> +static const int mlx90632_freqs[8][2] = { {0, 500000}, {1, 0}, {2, 0}, {4, 0},
> +                                         {8, 0}, {16, 0}, {32, 0}, {64, 0} };

Can we use better indentation? Also one of the sizes in the definition
can be dropped.

-- 
With Best Regards,
Andy Shevchenko
