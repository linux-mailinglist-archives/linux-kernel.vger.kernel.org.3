Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7171A4F6D43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiDFVsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiDFVsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:48:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D356615AE33
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:32:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d7so4160875edn.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a32qnBztE2IXtzvLnaEci16ST2DBqAaVGBlmBFvRnDc=;
        b=Am3wn/I//RT+8eEj8AGDpa3XAgi7OxffpcM51aNFuWlwe39zYgN3D7PZ0yNbmCtitb
         8XL+DUuK3lUirphpaiMnKyQHtTcKLbM9hGqiE5K3nG1hjkYzjpCbMfLYcjqj9VXadHUY
         7+eJOKPbRDfaBR8hmjQR4txexhRpvrohH/03Dv4dUHm40iAgkDAUL6nxY5zatf5qFMmF
         OMlBQQ5e7roLBLt1v4e+U88WesZhkMtEAPZ8+bQ3LRuYmd9MKC4iUUiFMeByMa1+zH8R
         D8h/aSuF7uNcLC1A2g0lo9no+3zg4xnad0m77CDSPc7HbBu1+CllhuMZqV5zidnJOcnG
         CMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a32qnBztE2IXtzvLnaEci16ST2DBqAaVGBlmBFvRnDc=;
        b=OUxVqqT9hmFQtMzpNxwN4VSAqfzLJTc2nZxPnbOKtIbtplMhF+EX84qr7mCag7n0+M
         TTRvY+pE+ezBKnsfR0oEidu2+qVUds5RF/mwzHnbHgZ3+0x4zmmmMo4ktvFjLM0ofXDD
         BZ93f5ShEEk1KuCSvNKef2QObDzReJxiwZEoEQfz1rbcWGga9T6ceLNDNhTsLxzCY0BJ
         +HReJ3mH+MHPWJ5op6jrneYd6EUDiFoq3QtqODbFjf7hVJv+iNVi5Uoq/LCmnsF+NHh8
         TdpChsEz6ZgPloONc0swgcPNquTjCUnHoKyGuVgwz0iMFXVFfVI2C0uOWnPGm8BoBTqf
         cbjQ==
X-Gm-Message-State: AOAM531RCOrUna+ppJxicezDAK9soyMbFU/I+uiM9SdHu/DeJ8Y+7Hti
        kFfr+yjpqBOKwsCfn6GaZHGyDu1q/9BVNWj8gCMi0IqQoK9sI8qE
X-Google-Smtp-Source: ABdhPJy7jr2rjkpSgrB0uWoNfSr5yY0hfXjtoI1MFRT5vPFgLXCaEZb/W4AjmRfU/AXvAIpD1uyXUeDLWbd253pxzOw=
X-Received: by 2002:aa7:cb8b:0:b0:410:9aaf:2974 with SMTP id
 r11-20020aa7cb8b000000b004109aaf2974mr10907125edt.173.1649280757166; Wed, 06
 Apr 2022 14:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220404041101.6276-1-akihiko.odaki@gmail.com> <Yk4DGZfpYbK8dofL@chromium.org>
In-Reply-To: <Yk4DGZfpYbK8dofL@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 6 Apr 2022 14:32:26 -0700
Message-ID: <CABXOdTcY3w56hc7kWsDLxKU-c6fCLYt_jigK13tKjjm9OHi2+w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Akihiko Odaki <akihiko.odaki@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
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

On Wed, Apr 6, 2022 at 2:16 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Akihiko,
>
> Thanks for the patch.
>
> On Apr 04 13:11, Akihiko Odaki wrote:
> > The EC driver may not be initialized when cros_typec_probe is called,
> > particulary when CONFIG_CROS_EC_CHARDEV=m.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 4bd2752c0823..7cb2e35c4ded 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -1084,6 +1084,9 @@ static int cros_typec_probe(struct platform_device *pdev)
> >       }
> >
> >       ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
> > +     if (!ec_dev)
> > +             return -EPROBE_DEFER;
> > +
>
> Just a quick check: are you still seeing this issue with 5.18-rc1, which
> contains a null check for the parent EC device [1] ?
>

I may be missing something, but from the context I suspect this may
make the problem worse. My understanding was that the problem was seen
specifically if CONFIG_CROS_EC_CHARDEV=m. In that situation, it
appears that the parent EC device does _not yet_ exist. If the driver
returns -ENODEV in that situation, it will never be instantiated. The
big question for me is why the type C device is instantiated in the
first place if the parent EC device does not [yet] exist. I have not
been able to identify the code path where this happens.

There is a similar problem with other EC child devices which are also
sometimes instantiated even though the parent EC device does not exist
(ie dev_get_drvdata(pdev->dev.parent) returns NULL). That can happen
if the parent EC device instantiation fails because of EC
communication errors (see https://b.corp.google.com/issues/228118385
for examples [sorry, internal only, I can't make it public]). I think
we need to track down why that happens and prevent child devices from
being instantiated in the first place instead of trying to work around
the problem in the child drivers.

Guenter

> Thanks,
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/chrome?id=ffebd90532728086007038986900426544e3df4e
