Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8548A577EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiGRJ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiGRJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:29:53 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA91A05A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:29:52 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i206so19773183ybc.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pC3YC3d9bXDprR56rXx3gA8+RrhPYL1457fQ3w6d17g=;
        b=o6bXP62Kaj26+UgnjvTe0fgRRikgdJJvDAUgx77U8YMM5C6NVJY7SpzSQ9yEZDFFS2
         Uy0mQgmMkehBX5txvBV22HACjM/2lxegZZASdZ0Chg0cEotSpqYjDanRSKtiFzTJygUo
         UxJTgL67an7phN+ONvpjqynlmqG3EoGm1O1FIxlydqB5LI9PiMooHeCUDcKOB6DMvqeO
         M1IG/2AJOin6e0vgIBcgYg4N5iGDcg2ves6E6Bs/0XqzbodwXWh4S7cAXtJM0lfOayum
         rK332wmyWwBSeaVVLUouJMDSqZC8YgL7sLWFWI5e/RCy9y+WHaRQRS9z7jglMAVxh3x3
         c/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pC3YC3d9bXDprR56rXx3gA8+RrhPYL1457fQ3w6d17g=;
        b=lTEYmOy2X9lHRrkSOv32hqyUpdM/SnzgXjRaABCMg0fn1h5Nc6RxwWZfdXltUEFAkG
         TaF2e7E9eYqSxKcHuZOHEAjG086vVVXasi60E+vzDQ3fwXQYmXmYQJ3X8TYCni+Hf4Jc
         LhCd+C3RZA1wPWKEHAtwcctxJN4BUYMjY21GZcKMsnMYf4niESY1/Moejj9cjbAbNIJg
         SQasEQf/oFTRoayMvvvkrbuIUujtccT6u6Rui3gcY+BhIKXlt+4EA7cInlhCxy6gQPC4
         hnTJoy7L4FK+N1pON+YaZ7Hx1IE6UsZcQANAgwBXh4b41yi4qajOL4PPPpKFZmmvAZg2
         fFLA==
X-Gm-Message-State: AJIora+V5A5/F4PmYxCGwX1MkvYmEtpFewmVz5COD96pe3i8mNUMUDUg
        RdYnviCCDQgAOiGO7kxeAiTGJ38VClIlGhU6RZqHzQ==
X-Google-Smtp-Source: AGRyM1vk4BvOZcZB37sdvcpmGFUE3a7MsmuV6qdRpMfWmQDwonT4ic54kK/m++/blILmh+qKIi4G3qDpIT53bHKQ3dI=
X-Received: by 2002:a05:6902:124e:b0:668:222c:e8da with SMTP id
 t14-20020a056902124e00b00668222ce8damr25109558ybu.383.1658136591808; Mon, 18
 Jul 2022 02:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220714020319.72952-1-warthog618@gmail.com> <20220714020319.72952-3-warthog618@gmail.com>
In-Reply-To: <20220714020319.72952-3-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:29:40 +0200
Message-ID: <CACRpkdb=AO-mrkAMsY6owzZoF=aEJRCw5pHM_aono7vaRVBgXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] gpiolib: cdev: simplify parameter in call to hte_edge_setup
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, dipenp@nvidia.com, andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 4:04 AM Kent Gibson <warthog618@gmail.com> wrote:

> Improve readability by using the GPIO_V2_LINE_FLAG_EDGE_BOTH instead
> of combining the rising and falling edge flags.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
