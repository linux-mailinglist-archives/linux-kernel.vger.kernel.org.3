Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650BF4C1B88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbiBWTLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBWTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:11:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5225A3BA6A;
        Wed, 23 Feb 2022 11:11:04 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a23so54298990eju.3;
        Wed, 23 Feb 2022 11:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agRAC2t1wbxohDTZY1tvrdvahcqEsXAlVugrCvK5vAI=;
        b=NusxRs+hCFFeFBdSmlJLGYQwHnHOOgK+XcGfTP8vviCjpin68ddNpvUStPpR1vs32r
         TSWokMdnZp3qoW8u3QQsVe614BTTiM2S1OUs2b3Vb71shGx0snmeU4iBDCba1zG8FJoQ
         mHYHi1vQhWLqFo5zhPqfWl1T/NBq54QQblGM0WrwdkdJunMjW/lpzylPIOAbJvXeWQ9Q
         KdSi/D5Ic5z76YBqYMZr3J5azQ2Ye08A1NoR++EabeIAOaB6Qer9weo9V5hyf4XvAkx7
         j2yyrc9I0QvjjgeVvVrGkBDUKdsyKjeR7S2n0m8n9Oe5XA2bpGYN0v0hLpNUKX69zWaX
         cvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agRAC2t1wbxohDTZY1tvrdvahcqEsXAlVugrCvK5vAI=;
        b=OCQQbsjF2C+osYjRhxCArKGJWnR6ZY1bPMagzAoSCBli7jn5EhHd8ofT9Fx/1+2l8S
         NRaRgXuxtHYC56oWfTuMPABXG8CwcRHi9CoIFpczCJrNUPfWQHkLjTgGwcFpLqSUHG82
         Q6Yr2icJDjKaC9OPmmZpxi2yEwn7FKeUsP7n/8tZpvqC7R9iBuNqYoMw7x4An0lGqAw3
         mg0pxrYO7fvb7rOCkGQoFrwPK8p22S3ghiuU70jmKxWGTsdtZFqqFuI+7ixL85kEEg2+
         pJ8V9Ce4bVIYzfAgdFAts2J8rvEdMUPUMn0iogmAlnkYrNWGk2H1Yb8uhIqMMlq/hiM2
         8HYw==
X-Gm-Message-State: AOAM53307cDkkXBpQuKMhZMAv0uLM9mM8Ad8l4qybDz4IPmApB5ddrdt
        PPCwLh5zFvdph1/ycIlupAS1cpRbsyGiYQsZGCQ=
X-Google-Smtp-Source: ABdhPJxJVHoCAqyhAv3zdWC2MUzmw01qvg7Ykv7dkMiDqJyJrCrRorpy9OxB6Uj4g42Ws7PlRNI2UTmCoDCbAB9Zr2g=
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id
 q7-20020a1709064cc700b006d07efb049fmr841882ejt.639.1645643462730; Wed, 23 Feb
 2022 11:11:02 -0800 (PST)
MIME-Version: 1.0
References: <1644890386-65119-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1644890386-65119-1-git-send-email-wangqing@vivo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Feb 2022 21:09:38 +0200
Message-ID: <CAHp75Vc29_LUiiH0mOUXBFqshin9UMbntwxxFr09Vvxje-4eEQ@mail.gmail.com>
Subject: Re: [PATCH] spi: add missing pci_dev_put() before return
To:     Qing Wang <wangqing@vivo.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
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

On Tue, Feb 15, 2022 at 6:04 AM Qing Wang <wangqing@vivo.com> wrote:
>
> From: Wang Qing <wangqing@vivo.com>
>
> pci_get_slot() increases its reference count, the caller must
> decrement the reference count by calling pci_dev_put()

Thanks for the report!

This is not fully correct. I'll send a patch soon.

-- 
With Best Regards,
Andy Shevchenko
