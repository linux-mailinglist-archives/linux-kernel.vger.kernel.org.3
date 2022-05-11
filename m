Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC1523C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345939AbiEKR4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbiEKR4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:56:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8A2B1B9;
        Wed, 11 May 2022 10:56:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bv19so5597307ejb.6;
        Wed, 11 May 2022 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4/SAPsJ9f4OXJYDdFhUA/nd1PhxlZKu/Ys21YszRaA=;
        b=lZEjE+zhrFuarohgPN3uPPp3/1ifjXsr/pHVEE0WklPDTG0muYg+gRfQm2JpIVeLvD
         clhRYNK89WLQOLEF94OpOfecWz2CWB13B5z9QOXm+oktp5meLYxiZUPtVY4RmjBvnbU3
         /6S+aX7/uBWmn4YPi3VlznZnHBTIcH+uzmAH44/GYOmx5EzjXaGqEnaUCkbHSsCQfOwQ
         uiJKgh0Zk6QECVwJKFJJXrHJmbV0GCiYQ1QJ1kjzTUF0Ipw3OmLJmYyhewMiTpW0KmUe
         lVtK3VEzSqYqWOLRlsoGOs41WyZV7byxDZ95xdgEm5bo3p5E1r9aBwsJMQlreZFFRNUx
         DGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4/SAPsJ9f4OXJYDdFhUA/nd1PhxlZKu/Ys21YszRaA=;
        b=XPQ5w/QMa1DkjJQUWuoW3k+gKvWb4tReBAn6K3+fe2/8i2/3xBme3QcLF3l1RraWQT
         OGKdulsC78ISGHj6XAodhZ/E621PSAlJFJf0KSwbRLH1MrDJp8BCFbaQI5/PJybEWkuI
         aeE/HpABFEMaIKp2nE18QuoRWFlwccSOzeTtzZz8x3Wvml3hnIyUGEVVEEK0WtKddhHo
         CHuBKh0HEDuVFZ39H5Npcpe9y/GTz6Lb9qmvuhpRlL3gVAr/s5oa3sSwByKMtjYsFIc9
         iRII3k15g6ZRHYJUjjXOPMcnqXZWmfvso1+Z7fYs4pYWXNmy0w7R3SFBAd87JAVS0RsP
         EujA==
X-Gm-Message-State: AOAM533AgeaBPqGZVtsnNGhXnT6H4S7PDIaeoJ47MQJVkoSWyVerstaQ
        EsINZ0PVmZCR7aJm2c1Icsv3BHdZRmiB4KEOUamTjPO9mZeA4Q==
X-Google-Smtp-Source: ABdhPJwVD3U070rN+XeenMtclJ09vcrP7AYcNnGmrmWjBeX2VPQ+rXyde6ML2tgSNrC70rjKc3pedg9gQgeK2xdVdq8=
X-Received: by 2002:a17:906:c10d:b0:6f4:a770:846e with SMTP id
 do13-20020a170906c10d00b006f4a770846emr26455803ejc.497.1652291768721; Wed, 11
 May 2022 10:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220511153905.13980-1-henning.schild@siemens.com>
In-Reply-To: <20220511153905.13980-1-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 May 2022 19:55:30 +0200
Message-ID: <CAHp75Vc6imwy0faWEtmnnsNh6WfccA2KuJuy2e7+VHuxhQ8VbA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] simatic-ipc additions to p2sb apl lake gpio
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
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

On Wed, May 11, 2022 at 6:50 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> changed since v1:
>  - rebased
>  - split p1 into p1-3
>
> This switches the simatic-ipc modules to using the p2sb interface
> introduced by Andy with "platform/x86: introduce p2sb_bar() helper".
>
> It also switches to one apollo lake device to using gpio leds.
>
> I am kind of hoping Andy will take this on top and propose it in his
> series.

Yes, I will. Since it seems it requires a v6 of my series after
v5.19-rc1 and will be material for v5.20... we have time.

-- 
With Best Regards,
Andy Shevchenko
