Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B7458BA6B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiHGJUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiHGJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 05:20:43 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA852615;
        Sun,  7 Aug 2022 02:20:42 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id d1so4640854qvs.0;
        Sun, 07 Aug 2022 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=hPq7Rs0PKAtGhzg20DKLKbGoILEjF6QA+sJshG/YwdQ=;
        b=iwREscdJXw31Y55OGgafI0MwsZgG5unhAFC9fnZE2e+pEEwpKqkP0jGBMes8xBPMVc
         eAseSILTPdg3KeXGeMoUhu0CZk+kiNmWLYjPITiRS0AMccFoiq8DcjY3uW9+6wgEY3PK
         Dv3PHw/ysIaRUvgupwutjVxiucIZDaqe0FWNsZVnUhHwMk21Sch4YiUQK9b7aKjjQxY9
         BHOjXfbvYkadE7Nhy5PlKvjrmeg5w9OMZ12T41l5ctSY6qoFrEXXM+soRt1PPPz8rgCL
         c+nKcN9WqKaGsauLvf8TPFi22PkJcatsD3gmCZ3E7f6FrsSCIgpuCSNtS7zau1wAfl/P
         0CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=hPq7Rs0PKAtGhzg20DKLKbGoILEjF6QA+sJshG/YwdQ=;
        b=EWXnooaJKp4+2wZbE16SGi359soRfw8UaZY7ikNMv4g4y17TFpMA6IwdPNROUNeo2f
         /UQ9ssQiDGWacS/rCz8I4uu34nYw0qsROc7A7fVXIWGRJdvwwSut66qxRhnSnupUqrZd
         hc/K4bsoPbZCZne2jj5LgOYgRV0b9tAi4xZx0wZxITOPCHsM0NtwUNnhml4KeizO4R5z
         gnx1ROFepOivJl5JGW/ynG68LhX/GRPeA1mQkZ+JWF9VOTKjuEcBGUJI1BNAKB9Cz/dL
         E4VCfWCHn6O9M3M8HwV7QMLKXqoQ3N3qRfeKr4ksr8zWfmuJ6ST17DagzZCkGCxWPY2C
         f/9w==
X-Gm-Message-State: ACgBeo0hIvja3VuHkDc9Q5vzbfh+VbtXrzeKF0Y3qxWRJz7SWh5cbJox
        lw0cOErkLl1206TekXZZOwrXsg2JRb1Y4WVc9oNHYIThBcQ=
X-Google-Smtp-Source: AA6agR5Z+5yEdIt0HqPLiFmmNHBxMho0YzeS+EthG+MoaA1QRlPxVKuCyxFD5HmD2RHMtJEtTGE3XORNR4PmaZYgX/8=
X-Received: by 2002:a05:6214:5290:b0:479:5df:e654 with SMTP id
 kj16-20020a056214529000b0047905dfe654mr9829191qvb.97.1659864041026; Sun, 07
 Aug 2022 02:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com> <20220807083438.qqe3mzp43aytxbcl@pengutronix.de>
In-Reply-To: <20220807083438.qqe3mzp43aytxbcl@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 7 Aug 2022 11:20:03 +0200
Message-ID: <CAHp75VdYrnb8k72TFhB9eKDtyj_pm1gDqL+sDYixkuYy0Xb_Pw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] hwmon: (pwm-fan) Make use of device properties
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
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

On Sun, Aug 7, 2022 at 10:38 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> at a quick glance this looks nice. I wonder if it makes sense to split
> the patch. For example the change
>
> -       ctx->pwm =3D devm_of_pwm_get(dev, dev->of_node, NULL);
> +       ctx->pwm =3D devm_pwm_get(dev, NULL);
>
> could stand alone. Also I think this change is the relevant part in
> patch #1 that makes patches #2 and #3 possible.

True.

> When this patch doesn't get split, the series needs some coordination,
> as patch #1 is for hwmon and patches #2 and #3 are for pwm.
>
> Splitting the series into:
>
>         hwmon: (pwm-fan) Use of devm_pwm_get() instead of devm_of_pwm_get=
()
>         pwm: core: Get rid of unused devm_of_pwm_get()
>         pwm: core: Make of_pwm_get() static
>
> for pwm and the remainder of this patch for hwmon might make application
> of the changes here easier to coordinate.

Either way it will need the hwmon maintainer ACKs or alike.
Since we have (plenty of) time I will wait a bit for hwmon maintainers
to react. Guenter, what would you prefer?

> But still: Thanks for your effort and
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks for looking into the series related to PWM core clean up!

--=20
With Best Regards,
Andy Shevchenko
