Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88060542379
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbiFHAdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382403AbiFGVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:51:24 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7141D502C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:08:46 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q76so11304520iod.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBZRrGNSZ5Xl0z15O0Xk88yjDszs7TKdMgfjuiPJgmM=;
        b=GqAQd+Yz3A+QhO79joLQGMr6YFmt2jbjW/N5dGcQWNI6pKy/Jh9/r7QRm5oMmO7TM7
         YfaHGGz139f8EDYHgZ7gXLPik5y64QwjIc8Iza7hqjhDh2VvegQasYdZV7cowar+4lGC
         BliWWhtnBqWUH4Ts2hJOeNjwXktdXoFBHYzUSDNp9vl1E36P65d4hBCMRlREAxbdau6r
         fxLxuU6IqyYdDTWNfGt5fAxnmQbyg3qriDG0D5diHQlw3DwRtakaNm+9wgIaGTKTH0pq
         1XtM+l6MMzTJbCjo1URWWNFdHno57Ybh//4gb7Ao7tCO5ktId2huX8hUPgVQ6hrGW+aQ
         62sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBZRrGNSZ5Xl0z15O0Xk88yjDszs7TKdMgfjuiPJgmM=;
        b=ydOczoqyiveHqVwAxfHDVvC12ffh9btaPB0o6zwaRxry173XxNunox+zfKcKOaRdEE
         dI1uf8vYWbGzgVfPS+YNDrfWCgATXb+6lIF++hrQomh4VQEY5JxVaC6wlmbkTM9XCbsz
         uEtEHRNVH7RJIKJCmuMbJ9wGSlz0RyWJY4a/uWh+s5zrVjXeuRQRo9F1Bn+dnvroggks
         fyDOyzgxBZjBFV/kWE7vMRLP0+nDqMkxzNzqDa7DIZFOWe0RUKHNmCVSKS/QeDYYcdnS
         oiFDuuSdtPSWLkzXfhxepYUwe5xyNwXWPfciL09xxe0rSP4Lw5zmILw2mfM8RnlOAddf
         yDew==
X-Gm-Message-State: AOAM532mjj2LZU8kQvxtr/bD7hOgSvufRoWEq8oyfFTmI5sxW8ZvDYlx
        ILPCqe8LH7QRndNH+BB9oWmmoubBJ9lur7v7J6s=
X-Google-Smtp-Source: ABdhPJwyfmrwvW5BMuTQdxQDQKJNaAvZax/AKYssdzPmPw6YRiYZZfzwQ248pFfsaehNvtQvfx4+Rx5/OhEr6YXWhwU=
X-Received: by 2002:a05:6638:270b:b0:331:b9e7:65af with SMTP id
 m11-20020a056638270b00b00331b9e765afmr5375557jav.256.1654628925830; Tue, 07
 Jun 2022 12:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220607180406.1116277-1-steve@sk2.org>
In-Reply-To: <20220607180406.1116277-1-steve@sk2.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Jun 2022 21:08:34 +0200
Message-ID: <CANiq72kRhmT37H1FAGYGny83ONYXeqJuO8ZPbym0ajQOWKY4Kw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: ht16k33: Use backlight helper
To:     Stephen Kitt <steve@sk2.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Stephen,

On Tue, Jun 7, 2022 at 8:04 PM Stephen Kitt <steve@sk2.org> wrote:
>
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h.
>
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.

Thanks for the patch! Looks good to me.

There is a functional change in that `BL_CORE_SUSPENDED` is taken into
account with this change, but I assume that is expected. In that case,
it could be good to mention it in the commit message.

Cheers,
Miguel
