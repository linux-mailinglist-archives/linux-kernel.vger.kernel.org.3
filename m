Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8548013D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhL0P4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241680AbhL0PzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:55:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A2CC08EA73
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 07:48:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j6so63057793edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruYVqDjSzvKE9ESDPOstmLOwEK7+kWJthKgCsoXnHVY=;
        b=gncD0yuRaX+MOn2Kq0j/LeVUg8abEo1ACRTxQ6aLtpDnN9/a2GUIwaLmSNy7xfXDmH
         +5ecYsxj+WJ49A1B1MAWUBY667WuJ/xk18ROqTqZcFB/xiSeYrZybosg5tTWvSWnePOF
         /MaNtMrJ/QFkLpQLSOB57zKZYNQZtRs1pQAM25x1sPo/ZXzF9/Xr575HQO8zUpKBPzXc
         Pim6X6E8EiYFsdO+XelUg0gDZHgxUbq9waD8Ep37ER/fVO3qbepfA3LDtBU231R0PJNa
         4Ib7NkZ6AejM255yP3a17tRZgAtUx1gB/6OAxqZ6pyAszJclgSw356QQMsQ8Z4ZTH4oN
         W/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruYVqDjSzvKE9ESDPOstmLOwEK7+kWJthKgCsoXnHVY=;
        b=Ebw5z1kOrr4FyaTfXz12WjviP93AQ24qwid7MFl5EjduBC6RjDXFMwb2+ykcvvDY/T
         3t0KypN5VHS1MVh9unbr3ssvuId0RqYzD01Kq0nTgYzvyx9oHHsbO6p17mPfQ6wueh0j
         A1FGyNW1seJ6QziKtcF2rUot+LWF0EZR2kWJDDIZBRQ4gXdbeNhEvDGSEqGdWaFuq9v0
         i+FgpIYnQADwiXglcweAdeGT8e017qd81i343BZMYNmXsHiV2FbNEVgPVbvj2UqOj1nk
         sT7Gfbk0u6sdPekg9ro9lxQFQsFqfg0ortk7y2TaNmTW87LfI4TZRydjeyXxra6Byewe
         mlYg==
X-Gm-Message-State: AOAM532/M8uEE5wG1SUEmfc7fcYZr6CdDbJXpCbgCNFT4I8zE5rjJJ89
        942E5/FbIa/Nsqswiii99WowTOv/ssfcUJ28l4bF
X-Google-Smtp-Source: ABdhPJykLSQBHob3XG4bD0UAP8+YA6SVKSYWEEW+4XpOd3xphqx/nenjfXqcIvc7dsZdFgHEfd0gNvauJ5cgfEAh/qE=
X-Received: by 2002:a17:906:7304:: with SMTP id di4mr14134518ejc.327.1640620121150;
 Mon, 27 Dec 2021 07:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20211224150739.3278019-1-trix@redhat.com>
In-Reply-To: <20211224150739.3278019-1-trix@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Dec 2021 10:48:30 -0500
Message-ID: <CAHC9VhR+ou3fx_b0dKgu12L6janT8_7DEHQ54QY-QYsZcUDEag@mail.gmail.com>
Subject: Re: [PATCH] selinux: initialize proto variable in selinux_ip_postroute_compat()
To:     trix@redhat.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nathan@kernel.org, ndesaulniers@google.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 10:07 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this warning
>
> hooks.c:5765:6: warning: 4th function call argument is an uninitialized value
>         if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> selinux_parse_skb() can return ok without setting proto.  The later call
> to selinux_xfrm_postroute_last() does an early check of proto and can
> return ok is the garbage proto value matches.  So initialize proto.
>
> Fixes: eef9b41622f2 ("selinux: cleanup selinux_xfrm_sock_rcv_skb() and selinux_xfrm_postroute_last()")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Tom.  I don't think this is something that could be easily
triggered on a normal system, even if the compatibility mode was
enabled, but this is something that we should fix regardless.  I've
merged this into selinux/stable-5.16 and will send this up to Linus as
soon as it clears the normal automated testing.

-- 
paul moore
www.paul-moore.com
