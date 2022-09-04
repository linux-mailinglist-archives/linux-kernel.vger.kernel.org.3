Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80955AC7D4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiIDVuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiIDVt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:49:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494B23CBDA;
        Sun,  4 Sep 2022 14:46:05 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y18so5094195qtv.5;
        Sun, 04 Sep 2022 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UlpWR5ed2XZK5Klo5/xjkHWkHkKItDNcFW7lQvP6GKc=;
        b=k3pluWbY2w8W4nYjcaId8Fh/lc2BZIjt+CjUl6ls86MVYvI9KZzwPE68URfCVj62z4
         2g2K2Hu/aKbdNSOAci/E4coAoridFV3GGMqkQkefHtARk9nJYd+022KSYb3AeJKi25hk
         XMTgHi3r6vHZxUmOaZseWixnvu5bQYjEqL+NpkjvMBBAWGAPCNaB/PafDwzCNiTo5AEI
         9a60mnfrybNGaGhXM2QS2CxIwQkF9pWVKfCYBBA0NCIARCJl5AR/HizMB0E9tFJBcXJF
         wLQnnzmBq+sE2CWQkCxEcLwUAVH7ZQP0T7JCNIRbT1YVzZRpDJJOjm6iJ4NOhIb/rQP8
         XrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UlpWR5ed2XZK5Klo5/xjkHWkHkKItDNcFW7lQvP6GKc=;
        b=0N6gweSfEjx24BGLeZTPU4DSnqeslU1yTKEu9hZNj9r2Ld5sewIEBV+wvilvqhNVzP
         Rouu+8pnkwmmSGmtYT1J+mFMK6m4MhW9VJH7oAuZJzzgtLnjdayYm0wWKIORXU4p6Urx
         Te1WG4OxzFzh28mb59M3Dr2dJH38fYmuzCJ21qh+0JqSJuGVP55bvqHWPJMO7h2NI2Dr
         fZuo1dlPd+QktDMDAdAg0fIxh7Y5mRI3lSmzv1zIn3dFFUkXUdpzY73Cp5PrkWI/TitD
         XdjuvIRwGxfC0a4hQu9MYoaLlbquoeK+e/roRNgYWohHMjcTEqegcWRly/ZeiNMK8za5
         qZ/Q==
X-Gm-Message-State: ACgBeo3ZlNkpMEqeKtFnARNZ5PV7IIvqeATYHak4d8AZyOMkwTXTQWSk
        O/W2PyRsTGjHMkczxX/F/CMgRgEV8KhkeNY86xw=
X-Google-Smtp-Source: AA6agR4/3egl8vc0J2M9+gA8XZdBh3sl6ViZ5Kf6sO3RC0Rc7qjiHhH0rVIy3TrUZovFXOvF0/9H+hd3hlMnrYMerrk=
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id
 z18-20020ac87f92000000b003448cd859a1mr38079150qtj.384.1662327926996; Sun, 04
 Sep 2022 14:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220903222336.3426005-1-cmo@melexis.com> <20220904153947.2b61bbdf@jic23-huawei>
 <CAKv63ushE8br=weV0GYQ1v7K1p=uP=tXeXRSJTy+VVO8bsPZBQ@mail.gmail.com>
In-Reply-To: <CAKv63ushE8br=weV0GYQ1v7K1p=uP=tXeXRSJTy+VVO8bsPZBQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 00:44:50 +0300
Message-ID: <CAHp75VeHOQ1eETO7_2Fet=wBOhCSAK=a9qiDb40xvhuBLDuZcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Mon, Sep 5, 2022 at 12:36 AM Crt Mori <cmo@melexis.com> wrote:
> On Sun, 4 Sept 2022 at 17:13, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun,  4 Sep 2022 00:23:36 +0200
> > cmo@melexis.com wrote:

First of _all_, please remove unnecessary context when replying!

...

> > If you can fix the patch threading (patches should be replies to the cover letter)
> > that would be great.
> Can you help me with a bit more details? I use simple git send-mail
> and I added a sendmail.from option in gitconfig as you complained that
> patches have no from, but I still send patch per patch. How do I make
> it as reply to cover letter?

`git format-patch --cover-letter --thread ...`

-- 
With Best Regards,
Andy Shevchenko
