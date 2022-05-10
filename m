Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5315223CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348831AbiEJSZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbiEJSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:24:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBDD1D502A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:20:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k27so21008260edk.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Yk1Asd++vaP19BlzM04q8JrUNHDRJ05bhviE9yuAPk=;
        b=INLIAOxhhXUy3b2Wv5oKZ+ASdc4ha8u5IcIg9AnYC6zreX0H2HoaFCK9hB4CykHXkK
         XZVzvSizz4kB/TJKeRip9CJTqze5/crAgaFDNGly6mvn766BTLQaXX64kjijz9t2BbOA
         vmmC2vidST0NUSonzNfh4DJqDLkcLfMAxkRAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Yk1Asd++vaP19BlzM04q8JrUNHDRJ05bhviE9yuAPk=;
        b=QKt4RY1iq3I3nmErW9+4bMi+F1XMS4WkG3S7qT9UBnTxpVab10uJAuzlWptUsCau1I
         Z9oS6HZdJ1MMwz7UJsJNkJIbrARQPO0jUG52WVaq7iwrp2oC6/liNn7g/Vl/fGSmSPS7
         o3t2q1Y/YXeHx9U8bot6DvPmPI7N8RI1Jpcp/0HLMk7QQNcuTTRgTr26y0JU8++GG9W4
         qz6X38AQVADH9oMq9kl6QET918Ed0g5GZmDKTpevEVcp+uKHcY5vnzpCbPU4PKQTPJdZ
         uuoCMD8DdI5r87xDtZNvL26L4s8sKibCFNGI/ByL+K7zmVU/8lXTYUzY5/nSA2Cd+irw
         P5Wg==
X-Gm-Message-State: AOAM531joQqSVCmNkamwQESnOGj2m39bhjtblWTACuf3KZsqcD4VM3tT
        wX7KCoDvx9wDTNcMLzWHX3VV3RIZhSQ51pU7
X-Google-Smtp-Source: ABdhPJyuZDN7BK48OR5WttkP7RDkgaf/Ya/HIDPjl+PxdDR7kOG/+KZz5rV8+arsVngQGvjzbp9fPw==
X-Received: by 2002:aa7:d70a:0:b0:425:e56d:c1b9 with SMTP id t10-20020aa7d70a000000b00425e56dc1b9mr24302909edq.78.1652206853448;
        Tue, 10 May 2022 11:20:53 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id rs1-20020a170907036100b006f3ef214e49sm8443ejb.175.2022.05.10.11.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 11:20:52 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id i5so24936226wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:20:52 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr19493674wro.679.1652206851534;
 Tue, 10 May 2022 11:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220429055145.3852271-1-chi.minghao@zte.com.cn> <CAD=FV=Vo+1O=m_-Wf5z6fxcXAtRabQu3u7tc3pt8Q645b1n1VA@mail.gmail.com>
In-Reply-To: <CAD=FV=Vo+1O=m_-Wf5z6fxcXAtRabQu3u7tc3pt8Q645b1n1VA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 May 2022 11:20:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XizF+13_QzYfOQA2YCUqgVMvcE=GCN+cSdpwkRvYUsNw@mail.gmail.com>
Message-ID: <CAD=FV=XizF+13_QzYfOQA2YCUqgVMvcE=GCN+cSdpwkRvYUsNw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 29, 2022 at 9:21 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 28, 2022 at 10:51 PM <cgel.zte@gmail.com> wrote:
> >
> > From: Minghao Chi <chi.minghao@zte.com.cn>
> >
> > Simplify the return expression.
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> > ---
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

e090532246fe drm/bridge: simplify the return expression of
ps8640_bridge_host_attach
