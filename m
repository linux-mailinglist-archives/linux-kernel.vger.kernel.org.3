Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB885A2289
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbiHZICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiHZIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:01:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5354CD4754
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:01:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w20so1125417edd.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tWIs8cEPcFM8qOdbk90dp96g6UtdbhFONDoS8mVkd8Y=;
        b=kTBkZ/vJ5n2n97pr3kT81obP3hfsaezJ6KFMEJTL1lsNXFKhKzemQUQdgcdRNbzyTZ
         s0HWMKsbc+lbyQDjhFij+Cp2TS2lUir7QmbYUJJbFIBEwTNB7adCi0QzywlXhPfYs8s2
         SQdE03uMV25M1ok9gNeKENF0H6S/jqSw+Ndac2t6yXHqvPtYaTokRd+r/eDg6DIaXOTv
         OaADBgD0JfADnq+jT76Cp3WZcNBPQ0aT5cHGaD4KjqzxPr24IRohzL371KJ72NXcLs+g
         Nz0tqT8QLidJhxQgFiuIi4h4YJxshl+nNhA1mGcu0C4N+SmDNQKBxJrD8hH8wP5zSrv4
         GyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tWIs8cEPcFM8qOdbk90dp96g6UtdbhFONDoS8mVkd8Y=;
        b=LJlbwp1qK6Bxd+wrtxRwZ5USUFDhvrBlNCNx7q47Ac9XERWfVw4cRDxBCBMYoS4lGd
         2CS9ORcja+ZSjksDLRn3t5cJj+/EzBCbC/3oYeOP6DNdqXoLHzN0vlrzQY9/jEB7tYcv
         NMeUUCoTOS7b5ARAAxMaA9nj5/9H2GbNWls1YhqnbRjLyDBPcWDThVk3utzHFH34v/MN
         mocQHY9b34BO5bFLq53hu40BpBbglgaWkIEV/bTNP3F8ZZ+YcfMTGiaMyCZonM/QlKnF
         6srsPBvyOc06QRFunHDNw5CqhD/7UNN/iuBurM6jzOcPA34yFq1EuJF2nFJRz0yEvSP/
         QR4g==
X-Gm-Message-State: ACgBeo0D3qoXQ63TM7C8s8uQlTYkvM0E/Q8HRJ8QATOOk2InFTBCMLML
        8IZs5+KxFiuaf+CAKh+9Vgu1q9DNKQOHPhw0Uknt4w==
X-Google-Smtp-Source: AA6agR46aDo68kfNYLpzXurqLX2JUxoPuwhHyxbf0HWbQkstABaXM8HF7+f5S1ulK2ZyQnwOMdOgwGAxQUVpUedU7FI=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr5913742edb.133.1661500911209; Fri, 26
 Aug 2022 01:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220826152650.2c55e482@canb.auug.org.au>
In-Reply-To: <20220826152650.2c55e482@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 10:01:40 +0200
Message-ID: <CACRpkdYZOK9NhEqqU4Wkg1XHCHEQk=AR6w9730qo_tHmgGrorA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 7:26 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the pinctrl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
(...)
> Caused by commit
>
>   e6cbbe42944d ("pinctrl: Add Cypress cy8c95x0 support")
>
> interacting with commit
>
>   ed5c2f5fd10d ("i2c: Make remove callback return void")
>
> from the i2c tree.

How typical, the ideal way to resolve it is if there is an immutable
branch with the
basic changes I can pull in from the i2c tree and apply Stephen's fix on top,
or we can just wait for the merge window and let Torvalds sort it out?

Yours,
Linus Walleij
