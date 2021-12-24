Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF447EE92
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352576AbhLXL26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbhLXL2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:28:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D29CC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:28:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m21so33621338edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6+zNhyVpAd1yt6QotZQ7Xk8kKzHfnTIwVxR7WF0umc=;
        b=LyjtZ7luDamqPDobRNstqyUpfBBZrH3fuZjsL3NVVTRyXXb+uWxTEHiAx1DobcLD4N
         EZmsN6yJZDgHpcNiYGak0wH1F3hYVMcJl4SaROuRvxs4vFBV6x0ezepmwKNCemw7dElh
         2NDr1C7KWmjCs3wc7N+ewTLvByqXCqafVTraoWldptZOW4+5/Rp4L81GCWFJa3lZx10F
         hRRy2zPqIyReLivWSzlgUkDizslmCXnG+C1qEcNaVAeBN/I1c48f1iW1wu+68UvYjT0S
         ta/W/5hnanhFbImoo2LIVYsEcx17ueyeMJd6rE3+qJxCsCg0rEB0XVfXf+2J4NYl0LME
         uAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6+zNhyVpAd1yt6QotZQ7Xk8kKzHfnTIwVxR7WF0umc=;
        b=sTGHVtf4VDE+bhgd4/3Nq5fvD6/uu6gWHNylujTsD732L1obnK+nSroG1rqPfHcZs9
         eqPy9izT3U8ANKp2upjw7nzAUxjWJcUZca3Qv2JPBscvxp+0Re1yCx43J4hJp8FZPUXK
         vXK5VPyP8rYaUvw7fNgrzP1P/bL8obzD/Z8fPd+IXBSjdXOiZH43S9Qd/PMt329p4gV9
         Byd9vDjVdZfBEJdF8AhwShxYbw8wiTlCSqrjKkmyvzWDeTEyVM1qG4CwHyA7ruBDRcmP
         eMAQqaCfI7OSo45Mb0Doec6GnWyRxUVx4qFcIaWfu0GfOk3O/GhGlJYcnmvN9atD/Qxd
         WTFw==
X-Gm-Message-State: AOAM530Lt+QRfO8y0r0aicoq4yJL03gdPbNSQ4crIiWGLDMQ1ALvaAMC
        tb5VK+iEyE2AKorkp/t+4b0K6Ije5kz+aPE2Z0w=
X-Google-Smtp-Source: ABdhPJz/VEguBxwKmq/gRAv2PUycqknitzt4BRNHoWGhvjynxeaEz0DmzkUp+WffftJ9MdzgWlKuAzfduXEiXxxRHiM=
X-Received: by 2002:a17:907:98b8:: with SMTP id ju24mr4893416ejc.516.1640345333968;
 Fri, 24 Dec 2021 03:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20211220084602.952091-1-wangborong@cdjrlc.com>
In-Reply-To: <20211220084602.952091-1-wangborong@cdjrlc.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 24 Dec 2021 03:28:42 -0800
Message-ID: <CAMo8Bf+731hRJ-HTbE7Co_1Hfdhf09vQ_Sqk9gS0DOam3V5gAQ@mail.gmail.com>
Subject: Re: [PATCH] net: xtensa: use strscpy to copy strings
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:46 AM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The strlcpy should not be used because it doesn't limit the source
> length. So that it will lead some potential bugs.
>
> But the strscpy doesn't require reading memory from the src string
> beyond the specified "count" bytes, and since the return value is
> easier to error-check than strlcpy()'s. In addition, the implementation
> is robust to the string changing out from underneath it, unlike the
> current strlcpy() implementation.
>
> Thus, replace strlcpy with strscpy.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/xtensa/platforms/iss/network.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to my xtensa tree. Thanks.

-- Max
