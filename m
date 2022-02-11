Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77E4B2DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352966AbiBKToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:44:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiBKToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:44:08 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F270038F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:44:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk11so4633900ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AluQhblsYxVB6MXmZPefwr1gRPxgWLvjtu1enYqV/OM=;
        b=AweMfrL2L+mSok1hCUX9TP752KsO1feW1ZVW/nKLTq0WDqUigTqbIAcm9lXGFuMLoR
         He6+EjLcu5miMXc4MNxgl50SMX9Bt19Vp0HWXsYqTNOQuyYa7rQr11sZh6CCnHg9w2lt
         WjwRXewgAPQxOT3VAh+8zkRUBcfKgWZyZmNuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AluQhblsYxVB6MXmZPefwr1gRPxgWLvjtu1enYqV/OM=;
        b=sz1wwiHPSxZmR54EIbQKzTTwXHYSFOdskln0BZlkj6QTAlFJ5teZIqWAMH/sSVJ0Wk
         /r4oqqTx/ZsPTGN8nI2wAGdhiG8gnXZbVOsMKYq84DqcKz5aA/vjKJhTHIXFL0aaBaeD
         4enMoZMy9kxmCwqUopQLN1A0Tb23wX2QkuM2hkmG7IbU6AKJbzB2QnBxsDIWOU5l/iID
         VIPzsSJJVkUg1gDFx2d2ycK/pXGwgCi/aJDoUKx3ZLe+kvJ8O4R0fG0AcTBwiu9Ni5AA
         2rCu2+0wIEdJ40lFgCdxrlpad0/v/U3cR+FNwmCZKgUeJFJqUSi7zWLoMX3dAltpw0Qh
         fngQ==
X-Gm-Message-State: AOAM533VdOYT899siJcdaMPf+5i3hrDONo+BHU4f45IDeJZ0FqyMlo+n
        3xKx2PBF6rCBbJd7Ujx1Rstz9bEb2plKVp8+
X-Google-Smtp-Source: ABdhPJxefcwv8RZZqOQDAeudvZtsoA7/L5H6WIS9IBiV9i6lNHzwuY957uSQFNPiUXqRUgMlywko5A==
X-Received: by 2002:a17:907:a428:: with SMTP id sg40mr2750680ejc.128.1644608645449;
        Fri, 11 Feb 2022 11:44:05 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id z4sm8148703ejd.39.2022.02.11.11.44.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 11:44:04 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id p15so24986641ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:44:04 -0800 (PST)
X-Received: by 2002:a17:906:15ca:: with SMTP id l10mr2791084ejd.435.1644608644279;
 Fri, 11 Feb 2022 11:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20220211164026.409225-1-ribalda@chromium.org> <CANn89i+2idhm3wpGO79RHdCYMfYuKURvBaWmoXmYxBwj5z59yg@mail.gmail.com>
In-Reply-To: <CANn89i+2idhm3wpGO79RHdCYMfYuKURvBaWmoXmYxBwj5z59yg@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 11 Feb 2022 20:43:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCsm5W0nN9CmrHj9JP-FurVNZDs5b+0MxNUwOv3SvmUG6A@mail.gmail.com>
Message-ID: <CANiDSCsm5W0nN9CmrHj9JP-FurVNZDs5b+0MxNUwOv3SvmUG6A@mail.gmail.com>
Subject: Re: [PATCH] net: Fix build when CONFIG_INET is not enabled
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric

I failed to find that patch. I only searched in linus/master. Please
ignore mine.

Thanks.

On Fri, 11 Feb 2022 at 18:24, Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Feb 11, 2022 at 8:40 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > If the kernel is configured with CONFIG_NET, but without CONFIG_INET we
> > get the following error when building:
> >
> > sock.c:(.text+0x4c17): undefined reference to `__sk_defer_free_flush'
> >
> > Lets move __sk_defer_free_flush to sock.c
> >
>
> deja vu ?
>
> commit 48cec899e357cfb92d022a9c0df6bbe72a7f6951
> Author: Gal Pressman <gal@nvidia.com>
> Date:   Thu Jan 20 14:34:40 2022 +0200
>
>     tcp: Add a stub for sk_defer_free_flush()
>
>     When compiling the kernel with CONFIG_INET disabled, the
>     sk_defer_free_flush() should be defined as a nop.
>
>     This resolves the following compilation error:
>       ld: net/core/sock.o: in function `sk_defer_free_flush':
>       ./include/net/tcp.h:1378: undefined reference to `__sk_defer_free_flush'
>
>     Fixes: 79074a72d335 ("net: Flush deferred skb free on socket destroy")
>     Reported-by: kernel test robot <lkp@intel.com>
>     Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>     Signed-off-by: Gal Pressman <gal@nvidia.com>
>     Reviewed-by: Eric Dumazet <edumazet@google.com>
>     Link: https://lore.kernel.org/r/20220120123440.9088-1-gal@nvidia.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>



-- 
Ricardo Ribalda
