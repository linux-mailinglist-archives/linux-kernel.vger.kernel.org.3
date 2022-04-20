Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C869C509352
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383066AbiDTXHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383059AbiDTXHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:07:16 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A41EED7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:04:28 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ec04a2ebadso34411467b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpEREu4SeXLkngfAouq9cgXQg3g799UvWzvJuLUJPhA=;
        b=NpfBl1JjpPzahZy++ENXUKPXbNVlfYpe5U2cmewY1Ry8JYEZMexFoqnTWEn/2GBPRk
         oXajgHV6HhDCFe6G7hNqA1fGOfZRVIyfl1T26XJgpRr2zDAD5Dd3U82faM1HRsbMB1wF
         aYwTmv5lHGxLEVILkYNe/9XiflvpqQD4gLsJVXselEpLWSH5P6mH1ldqZ+T+GPGsAhqF
         VDntvRllhyhcfPUB0GMyLzGpM5SAIZC928c4HQips6II2RZvovBt4vmakyW86WqaK5sj
         jd06Zybomj8NxLybtBAlvbMoNNZHq5nvGdU0jiwYJrCKFLysgs5rJp+JKcT4iplQfksZ
         l9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpEREu4SeXLkngfAouq9cgXQg3g799UvWzvJuLUJPhA=;
        b=wmoFhu9tGZ7h3QJ74yQ3ps1nsJjgWWo+OLiq0LrFTgfS8Uu6rX1xJuuMui6+c8tTb5
         1kGSuga8ppfX3maBQww7dIDRw50hsy2iAstV2Vu2j2hg8VeYGFSnFdGrkWJzRpVnEAAC
         YK9Cd6eibD39ZSDq2I+PpzZZbCjxEBLfDxnYRogw05HhztxNd5TuVuLSKwMhtxf5rx3/
         KwtmqDNMCyeUDEzhefIvGF1MypvEbT9tr8KJgwd1Sba8cBMFKDa5Lawup45pcharHJU8
         UNSOX44G915GgTtiinfPhFGb2nzS6jvBQ02IeEn/lWEVoOFmguREbeScURjiAF6h4c3W
         Z66A==
X-Gm-Message-State: AOAM530i95Quc7ulGImNbQwDOvGwKQPpPLAzRh1yMPyhLC0JdBFMfQKI
        s/VPehAWeatPujoOvckYG5xvY7S/+o7fLuHVY1zBKQ==
X-Google-Smtp-Source: ABdhPJwsExULrcGo+zB6QCeXOvGyyhhZONGahcox/I8dMPcIDaw+fNvTnfI0grkCX9NGGPUxkAaaipRC/LQyn5maIAw=
X-Received: by 2002:a0d:e813:0:b0:2ec:1e83:e5f0 with SMTP id
 r19-20020a0de813000000b002ec1e83e5f0mr24226692ywe.151.1650495868004; Wed, 20
 Apr 2022 16:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649533972.git.sander@svanheule.net> <8d4e0848f233c2c1b98aa141741c61d95cd3843f.1649533972.git.sander@svanheule.net>
In-Reply-To: <8d4e0848f233c2c1b98aa141741c61d95cd3843f.1649533972.git.sander@svanheule.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 01:04:16 +0200
Message-ID: <CACRpkdbSdDAKiFAsHBosdVDpBhWW-Keoq+t8GJ5LsyWjOZwp_g@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] gpio: realtek-otto: Support per-cpu interrupts
To:     Sander Vanheule <sander@svanheule.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 9:56 PM Sander Vanheule <sander@svanheule.net> wrote:

> On SoCs with multiple cores, it is possible that the GPIO interrupt
> controller supports assigning specific pins to one or more cores.
>
> IRQ balancing can be performed on a line-by-line basis if the parent
> interrupt is routed to all available cores, which is the default upon
> initialisation.
>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

That sounds complicated.

Sounds like something the IRQ maintainer (Marc Z) should
have a quick look at.

Yours,
Linus Walleij
