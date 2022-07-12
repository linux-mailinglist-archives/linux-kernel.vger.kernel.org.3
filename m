Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6775B571EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiGLPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiGLPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:23:40 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35422ED47;
        Tue, 12 Jul 2022 08:23:23 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r3so14493726ybr.6;
        Tue, 12 Jul 2022 08:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4zVaXAHYGEjBqX8Osfzp8NTZ1YEzPNpU8FiUcyBMXw=;
        b=BjfnUxxBER7kBVTV/rYrCJAKut1jpBcdQ+NGg5oFMkYtBKRN9ftcYkYkTwrgotIN0K
         qVxOF3o3gPNBMSxySL8Sz9l2aDnNjeKqmQQM/BRCuwg+h3fMz4P//TD/eA0cD9lCOBf6
         11uUw1zxf3M9Typda8u6oOLK73G7CPxoFn5NhRqkk77mFAh+X/JOmNpDjRfxv+rxggUV
         Wypk8Ko+qg0KZep9qeOSCvV9fAHGk9+Qwy349nZ450Do3gIv1XU2pvhurvBjXtYOc8Lv
         1VxELoMQIDNSCySgBofhoth4Dri7/8C2qeHU0Q4kvEncTMMy1HzSL9bhvi5Y0xnJ0O6U
         Ku0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4zVaXAHYGEjBqX8Osfzp8NTZ1YEzPNpU8FiUcyBMXw=;
        b=ZnCkUc8eLtRdXTpt16Mh5koSchhVk3tRGN+6A/lL7UC6xewr2T1akbT83fq+8BtvtM
         rgRe9jhkFH22fqI+WUWc9sxUFyQr4k44TXUMLcqXCdQx2+3jCxDRejZnmO9B9gdToHww
         +TkxmtNR1mNk4PJUi0nAnN0cYHmnZPsntHE2w0WtmDrTSMrsoKSHTyVqFF0jRjW2cfg1
         c6SWpDfFtPGJM5p7YtMopb6/SUs1cgpDCt9fczHfeeBRCtueGVY7ZpQ9MZtE9atr3oIR
         NIMMEU2fHG0uPwefJEManOcAChaHECbbSTByWDt4ITYKAW51qRzm8160kkTDIECoaTzj
         G17g==
X-Gm-Message-State: AJIora9YHAxzRhm3SvgPuk7xI/O3pAWP7FV9k1fDFTa4wuQtv2zGqjQu
        K0EYvaXwBtV4Y4bSl+FkRnhvujkjCYi9rdoz5/M=
X-Google-Smtp-Source: AGRyM1tDemQeP2ceIw0i680p4Viiv90IO6kN+mK0WOipkdDwCJehX/cT4jh98s4uDAkhEmpQia4AtQkr1SDLhiTondo=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr22994159ybu.128.1657639402888; Tue, 12
 Jul 2022 08:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220712143237.13992-1-henning.schild@siemens.com>
 <CAHp75VeYHi8XTf3Y6HMmitVvuvF2uiWdSzpiKFji5SfV20HqpQ@mail.gmail.com> <20220712171602.1e7c49f4@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220712171602.1e7c49f4@md1za8fc.ad001.siemens.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 17:22:45 +0200
Message-ID: <CAHp75VdyTRTwFBc3=RL4VHy6VW3zGwijsQM5W47vfqZWxbko2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] add device driver for Nuvoton SIO gpio function
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>
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

On Tue, Jul 12, 2022 at 5:16 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> Am Tue, 12 Jul 2022 16:42:46 +0200
> schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> > On Tue, Jul 12, 2022 at 4:32 PM Henning Schild
> > <henning.schild@siemens.com> wrote:

> > JFYI: You have a strange subject. Had you used `git format-patch
> > --cover-letter ...`?
>
> Yes, but i changed that subject. Took the old line and turned v2 into
> v3. What is strange about it?

The 0/1 while it has to be 0/3.

-- 
With Best Regards,
Andy Shevchenko
