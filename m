Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC25AC1AB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 01:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiICXEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 19:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiICXED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 19:04:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515094A10D;
        Sat,  3 Sep 2022 16:04:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so5412729pji.1;
        Sat, 03 Sep 2022 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=N5clPe5lVC3TDguE3nbHaBibca5uw8kzSOg1ZNJ98mk=;
        b=fpnXIei2gVJWC+0so8sk1ItqpBrUIpDKP7IOrV18ajuiz6k4xXw6ZLJ539uTImXWSI
         yB74XrwyKuSBPi34OmN8uZj/lm4cWH/oXjSFKpronLwdaHkNIiejnG1Bjn7tQyafNJCW
         iNOfdR0+/h4sJWZ+C2ER8rf18MPsJkurujMQqE3S0H4icc0mBV5KZNnyolDFDuYQGdj8
         x4VTRmFW3szjeMdkOd3sWG50aZB00YxJzUKszSAWSaXesu+9vNQvd4mqbFUcUsmJ+Lz7
         DME7m0HCOFCp5qnXV8D+7UgtEtJfi1o3wylmxAmKX9FuFZp/pLEOcZiGGxv8/YGeLSM4
         IqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=N5clPe5lVC3TDguE3nbHaBibca5uw8kzSOg1ZNJ98mk=;
        b=CUZe78lMK+8Xw6YL1EXTz6F/9TZn6j3U8q+gWCzU7lT7/s4KcXQkbLj8+ZSlqFLPR+
         PMNK1sZXV2dtohVNR9mVE+N2vZuoRWQ2q5cyArNtQwZvExyoj2maF7u00qRAKivWocfv
         F2MSISxcBVWwI4ca588hCI2MQ3RPNrPZiaoreBHD8jmLnz7JSV/mzdyMh3K3NqHXxfp/
         JNQ773WdwNVrojwTNVnwWtF2AoNOXljMB3RVc6DJSGdc7NbqBoYcUf8P6vCiZ/7xTAD6
         WE9K7+XpN+dHxeroy9vZ7poAHJ4Rak33PQWZnGKsSC3xedtIWM0iMxpRxbG94Anua0LT
         eZSw==
X-Gm-Message-State: ACgBeo3T58aQHDty8o8s5pkSktv+gUDsTNXgvgYWbyqZ7X6PiXOqiJII
        +lCMAPxdY73jo39QkX27UzljALuIYtV1SYrqvRoxXrvDA/eOEg==
X-Google-Smtp-Source: AA6agR4kYx+rBmRCzoeybgc9H+dn/UxyajKjCI7AL/hnZfZLZcnW6KE5SZXjhpImMwN2psoUWG7ExhMHhtt4G9ibnPQ=
X-Received: by 2002:a17:90b:33c9:b0:1fe:5861:7a0f with SMTP id
 lk9-20020a17090b33c900b001fe58617a0fmr11781214pjb.187.1662246241727; Sat, 03
 Sep 2022 16:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220828205416.1957305-1-floridsleeves@gmail.com> <CAJZ5v0jrQwBh3ToZc-7J69qDJEAZ8+wXPzqjZ+zpxB4a69W-Ng@mail.gmail.com>
In-Reply-To: <CAJZ5v0jrQwBh3ToZc-7J69qDJEAZ8+wXPzqjZ+zpxB4a69W-Ng@mail.gmail.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Sat, 3 Sep 2022 16:03:50 -0700
Message-ID: <CAMEuxRryb0L6O92r-qzJ8VaBEpW+cghhoZFi6+RtFfDtDWD3sA@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/acpi/processor_idle: check the return value of acpi_fetch_acpi_dev()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
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

On Mon, Aug 29, 2022 at 6:56 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Aug 28, 2022 at 10:54 PM Li Zhong <floridsleeves@gmail.com> wrote:
> >
> > The return value of acpi_fetch_acpi_dev() could be NULL, which will
> > cause null pointer dereference if used in acpi_device_hid().
>
> That's true.
>
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> > ---
> >  drivers/acpi/processor_idle.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > index 16a1663d02d4..519f8f741da3 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -1117,6 +1117,8 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
> >         status = acpi_get_parent(handle, &pr_ahandle);
> >         while (ACPI_SUCCESS(status)) {
> >                 d = acpi_fetch_acpi_dev(pr_ahandle);
> > +               if (!d)
> > +                       break;
>
> But shouldn't this be continue?
>

I think here is break instead of continue because if we use continue, variable
status will not change. Then the while condition will stay true and loop
forever.

> >                 handle = pr_ahandle;
> >
> >                 if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
> > --
> > 2.25.1
> >
