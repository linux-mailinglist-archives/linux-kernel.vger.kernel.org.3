Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726CB5150AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379006AbiD2QYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiD2QYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:24:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ABED116A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:21:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so16346494ejo.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/i96WVpRgOiedaJPGvdPTgpbnsmRjq9OCgYpWZ3z/Tg=;
        b=EpTcT0njbF1gKIlcMS6t8ZZuyXjeSUeO22i8GJW9dw3H99A25xCRV4aPVEz6ann8Gj
         nKDuvRRsMR/hbBPXxXrbNsULZ8FMSZ0bGnIA/dQB6VYpzFqcGqWKr7UZjVEZiO5UXsQI
         aeZXdoH+DGhJVPfrqpxRktng8xk2SJx9FnGOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/i96WVpRgOiedaJPGvdPTgpbnsmRjq9OCgYpWZ3z/Tg=;
        b=P+0w3EJxbzK9x1KoXl/vdk8rwhkZCyHtwTDNgpaCYUVDpLyma6E1OrWjoysHgYBBtL
         69KnvMe6eK76A/jMjE0NuI/3IiqmXqultDfzneB0/1OUSFHpWDtZXDq+0GkRNrTKUvcZ
         6YCjxXaug8wneDCTv+16A54RR6RVCRjHFkkoDSbkPq+9CrUGYSRKprvslhTOoI23BhnH
         fTJsjt49D/+1F39n3WeWc3tcoZ3hTuKvsCOY+7recitNfwc4c3Pd6up84+KGuqjBTz+k
         TaOpbtSmf6eIJbj6o1URSInYohSRZpyH+mpgeOVDHZ8IEEGwTChLx00hRNRGFrqZzYRK
         10Zw==
X-Gm-Message-State: AOAM532VdZIZa9nsxhj4cC7ibwFV58By0PV+Ssxx8qwaAULb1JZ5QuU4
        ws6MyymJe9V5QTpqcnujY5gnGZmJJHUVZPqz
X-Google-Smtp-Source: ABdhPJw1dDtIRHLhaVJZZxpLUu4KIwCHphPBnfpqtgtTrsYtdYcDgprBBMc/tujwqEG9ZeXuNprhFw==
X-Received: by 2002:a17:907:6095:b0:6e7:cc3f:c33d with SMTP id ht21-20020a170907609500b006e7cc3fc33dmr104629ejc.570.1651249290676;
        Fri, 29 Apr 2022 09:21:30 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id dq10-20020a170907734a00b006f3ef214deasm778766ejc.80.2022.04.29.09.21.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:21:30 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id c11so1609063wrn.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:21:29 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr17962780wro.679.1651249289469;
 Fri, 29 Apr 2022 09:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220429055145.3852271-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220429055145.3852271-1-chi.minghao@zte.com.cn>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 29 Apr 2022 09:21:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vo+1O=m_-Wf5z6fxcXAtRabQu3u7tc3pt8Q645b1n1VA@mail.gmail.com>
Message-ID: <CAD=FV=Vo+1O=m_-Wf5z6fxcXAtRabQu3u7tc3pt8Q645b1n1VA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: simplify the return expression of ps8640_bridge_host_attach
To:     jing yangyang <cgel.zte@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 28, 2022 at 10:51 PM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Simplify the return expression.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/gpu/drm/bridge/parade-ps8640.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
