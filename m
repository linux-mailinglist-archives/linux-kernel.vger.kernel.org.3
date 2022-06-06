Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5A53E8C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiFFMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiFFMm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:42:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041612B7E14;
        Mon,  6 Jun 2022 05:42:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x5so13563662edi.2;
        Mon, 06 Jun 2022 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQw1JMjVkiQNJoOck+3BLNmeUABMQ6F26CTlYYxJVUg=;
        b=Ng7rwDZs533yTuxU6qmIud7CHDX5RNauYlwduBAqI+VGpzLM0OfZsGM1OY4you+QAm
         I2WojNNq/1fgByZPnJgEnHqcIJQVs9fL078n2Sxk8yA4pT+6gsXheyQiPl4SIocvQ5wx
         QRPkI/g3NoNPjZq/B8jryfbkxTNVDlktLexVWZlqWLT7/YbOJ/OISJlNT4Bt7Yq7ZhZr
         9yWGewT9fsB7jb251KLuS+9Kq4j1aZ3/Qiuecv3UJYlXMntjonJBMurM1KuwsmzuDlAr
         h+umElD64fVZLEKmqMLyG59TH3EohIXZhzAISLsEQBl6NNDzglq3jUpFScYx6B3c1irJ
         SNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQw1JMjVkiQNJoOck+3BLNmeUABMQ6F26CTlYYxJVUg=;
        b=2HXWRFBOkVuIsvFm3OXyThhc4MhjvNHvj0U/KEYT0hOMsQ0e23rYerN4XB4H/zYrBM
         +z3ebeILZ7eGeJIuYzmreKClDyWAT6acngqpG7FbfqNxFYZQNAZZ+Vx2l1Bzgx5xcnrb
         JEdZ45zUgbJZJ7qBDKWttJ20J6atB89JK9xa+xNX5PteknTUPGWQtMrMS4DRRfbpelEE
         iFZloroVAbObmKDlZaVtgpHRHLh/OpA7M1BDUcjIn4rmYSq6fBhLK7gqUa4USBrNU1OC
         AgrV8WMLYkmJXeoucMTdVNpi5fpolDefJ9uYi2tY+wSPGg449J5uPVpCHNpf09KjXnKh
         iTww==
X-Gm-Message-State: AOAM532lSh+CqEedHQBNR+8GIMYtUQz9EKBUu4ufVKyG61nHIWxJvP3I
        nX0qfYujXwlAi91Hak90UFY1+NjXks6hCFexWqo=
X-Google-Smtp-Source: ABdhPJwd9NnSRZjTJzpvbi20WWr6ZovTSqz3iv90KI/emBK8/uza2eOFP3qY1UAXZTHLv5clWLpBxiOnXe+NCscAG7E=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr25491093edc.97.1654519375435; Mon, 06
 Jun 2022 05:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220606111316.19265-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220606111316.19265-1-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 14:42:18 +0200
Message-ID: <CAHp75VfRF=NyU9TN0FJ=cj0w_C-cKL+foa+WskwpoBP9b+SfDA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: trigger: warn about non-registered iio trigger
 getting attempt
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Jun 6, 2022 at 1:23 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> As a part of patch series about wrong trigger register() and get()
> calls order in the some IIO drivers trigger initialization path:
>
> https://lore.kernel.org/all/20220524181150.9240-1-ddrokosov@sberdevices.ru/
>
> runtime WARN() is added to alarm IIO driver authors who make such
> a mistake.
>
> When IIO driver allocates a new IIO trigger, it should register it before

an IIO

> calling the get() operation. In other words, each IIO driver must abide by
> IIO trigger alloc()/register()/get() calls order.

I believe triggers usually acquired at ->probe() time, means that in
case if the following code (however, I believe it will be quite rare)
goes into deferred probe cycle the WARN will be repeated. Perhaps
WARN_ONCE() ?

-- 
With Best Regards,
Andy Shevchenko
