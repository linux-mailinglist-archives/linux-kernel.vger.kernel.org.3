Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2156C941
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiGILo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGILoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:44:55 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389AF64E11;
        Sat,  9 Jul 2022 04:44:54 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31cf1adbf92so9927007b3.4;
        Sat, 09 Jul 2022 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WecurZc/PD+8FSgyr1LUS8UeYsQb8Bww772Y3FfisNA=;
        b=cECSHQ/Jpc1SIPJf2KU6KHrPE59UPGYiOlnQF6JSY67SVLvYtv0ZaEaox8EzEWyehU
         e4SjU1Mr9YkrIiB6fOhyaFnbjsR08fvg4yKLfMAPXy64671YdJZAhn0b+gnHZN/leiQl
         AVHe8Y9SvIoM1gw0//+MRqYhUGxt2Eu+lcIasMkMT5CO664/lKLHiu94+HbBCwG0ODa+
         LKdGwzXafms9gd2+3iK+C5E61f0P8afGg2fJax8yGvMc6r8YJrpSFE+koR4W9nC4bt4M
         XwlizR4S/iKpuQLftjj+suHbsdG7idh3TDXVIyFgtC3RcEMz3HBjLR0SN9ymfMNqKoqg
         4fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WecurZc/PD+8FSgyr1LUS8UeYsQb8Bww772Y3FfisNA=;
        b=Qf0xjMnCdG8f4yyFpW0aRYEkY+1Ugu6R0uNGHvL6NLgn1zEzQ7PqcfUtDCLNliza59
         lRKKyNKo2Fzeg+5fj9jXrs59vRTJMiHEtWGtNbDeD9CC4BcWhf0zAPVZA/krfuS2pY4S
         xZShXuJHQUTWH5ZfVtw95SAeA4pt+HCQi0jm7zsFRb36Uz7og27Duw0uV9Rw0kyWWG9h
         gKebFnRLSKI1IdPYLzUVLOLs5CSnnnuGgF4FC3ooFPKV4Af1BgznkgYv9YrmdzmcqZZw
         0Xraadj9uAOcDLrGV2zRiyKQVafISsvnHVSRWuOYemEs5vUtWCj1GEruHRC959R7OIjw
         v2Iw==
X-Gm-Message-State: AJIora/YM8p3YSAj/aj0vaZl+xg0uBRkMKOhiEOAp9X2oKwUpQyqSY1P
        1LV+34Xv60ONlsibfVX3paZ6xYnNt10XlgbP6MQ=
X-Google-Smtp-Source: AGRyM1u/nIFaAJ6qPNU4u0ekU49mH3RtsLxWUhuQ7/nNsIH62cqo7wgZZ8iDEiBdOLaY4g53HK0MOXkNAWLvRwtYa5k=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr9010833ywa.277.1657367093389; Sat, 09
 Jul 2022 04:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220708084816.1140540-1-PaddyKP_Yao@asus.com> <20220708090731.1237488-1-PaddyKP_Yao@asus.com>
In-Reply-To: <20220708090731.1237488-1-PaddyKP_Yao@asus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 Jul 2022 13:44:16 +0200
Message-ID: <CAHp75Vc-5Py8heCJ4bKh1-7y+U+ycJxRuYdFwiT=NM5=gLqwQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev support
To:     PaddyKP_Yao <ispaddy@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Luke Jones <luke@ljones.dev>, PaddyKP_Yao@asus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>
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

You have sent two patches with the same version, your submission
confuses everybody, which one are we supposed to consider?

On Fri, Jul 8, 2022 at 11:08 AM PaddyKP_Yao <ispaddy@gmail.com> wrote:
>
> In some new ASUS devices, hotkey Fn+F13 is used for mic mute. If mic-mute
> LED is present by checking WMI ASUS_WMI_DEVID_MICMUTE_LED, we will add a
> mic-mute LED classdev, asus::micmute, in the asus-wmi driver to control
> it. The binding of mic-mute LED controls will be swithched with LED

switched

> trigger.

...

Not reviewing code because of the above.

Hint: `git format-patch -vX ...`, where X is a version number will
help. And when cooking a new version don't forget to add a changelog
between versions.

-- 
With Best Regards,
Andy Shevchenko
