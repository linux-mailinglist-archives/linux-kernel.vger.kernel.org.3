Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C32B51BFFF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378331AbiEENB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378295AbiEENBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:01:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0E553E3B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:57:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g6so8579799ejw.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RybWbrXcj8zBS10i0C/9NHfeL8tGwcNcqo6inv4EpAI=;
        b=d7ws1vmB8TNasv2lYZpKICd2vTQXUueLbTwFXYGVqHpQ8H7SyvH2fl6/g62DCgDWaA
         fRW66tJ5nWbqkYv2F+uwnoUBQ0VhC7V40TrefZW2K7wY5hhgHFI0bMpqYtJsxDlk/IP8
         AQFbrHBEVLvgQHq3gyz3ga5LiF8TDzDBKFzBq/3CLCP+nEXz1UNTy7EM8Pj2M6D7/bXx
         rVmyxES41BJeedBgaQs82ycRHSuZpGNQHb+HIHtYs19eNWBu0xI6aA5uVIsoFPKxMdhv
         jcdEBeWv/1d59lQKC+eLFIb73JCKOYx1yiBelaxx/HkTPjtP+53zYjRczjThZJQLBaYP
         beUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RybWbrXcj8zBS10i0C/9NHfeL8tGwcNcqo6inv4EpAI=;
        b=XthUJFEnFO/CQsHXh4zkIQR/wTNskcqwO57sXhkKUu8/o/oaCRoYhgSVENm4mHtQ07
         H5Xihoxb1HqRco6kEFPfNsdL9jqNdN9sn4aTS1f98jaARf4LGz3uMyIuCxXZv+h/gCjh
         5LykqNTG4bcYBE0f0fduBquAoJSwacobRCR0Z8opJvg+pwjUPYpbFgc4p1HGi3metQOW
         pHOBIS9DXja8slE6uSV38luWB9fxcCreJ5ff2gPVaEzrakCbMqU8kizZyomMk5KhSJeu
         AoQLGDUV0Gv5uroL6bzHaQsUV4VcmPRgYjdsl9xW9QZotaFLl1XQblWgfTKaaepvPo3t
         c7fw==
X-Gm-Message-State: AOAM530MuzP+E8SgkaaCRHX12CLZ3Vcl0AnYnZjlPuhCud0vOPeUF8F0
        CZojwdhWYnCPuJdD5lo77vsVzbPTsfO+juwCOOOZPQ==
X-Google-Smtp-Source: ABdhPJzm7DvuddhoB6IlDfOb7PG3Zm7dp7T7j+cXQJ/VMgHGfFkalZ86UDm1bktcuRSPyzrSERhqQrQnGfs2PDceCNc=
X-Received: by 2002:a17:907:3e28:b0:6f4:3900:78f8 with SMTP id
 hp40-20020a1709073e2800b006f4390078f8mr21669903ejc.736.1651755462487; Thu, 05
 May 2022 05:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220504144406.36744-1-jonathanh@nvidia.com> <CAMRc=MeXUN6P8kWxB75GsXdKD7Owz9mX5HpgfQoMGeJh-z3=Rw@mail.gmail.com>
 <6629e06d06f647923c04502ce3133f76@kernel.org>
In-Reply-To: <6629e06d06f647923c04502ce3133f76@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 May 2022 14:57:31 +0200
Message-ID: <CAMRc=Me=10YmTMQVWtBe6gUQxUSAL9fe_X7qq_F-mFGbWvrGtw@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: max77620: Make the irqchip immutable
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 2:54 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-05-05 13:42, Bartosz Golaszewski wrote:
> > On Wed, May 4, 2022 at 4:44 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> >>
> >> Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
> >> immutable") added a warning to indicate if the gpiolib is altering the
> >> internals of irqchips. Following this change the following warning is
> >> now observed for the max77620 gpio driver ...
> >>
> >>  WARNING KERN gpio gpiochip0: (max77620-gpio): not an immutable chip,
> >>         please consider fixing it!
> >>
> >> Fix the above warning by making the max77620 gpio driver immutable.
> >>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >> ---
> >
> > Queued for fixes, thanks!
>
> You mean fixes for *5.19*, right?
>

Of course I did. 100%. And I'll stick to this version. :)

(Thanks for the heads-up!)

Bart
