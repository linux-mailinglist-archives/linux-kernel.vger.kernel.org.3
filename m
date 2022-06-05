Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C553DE84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351566AbiFEWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiFEWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:02:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D0DD95
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 15:02:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q1so25646799ejz.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt9GSJY6oHFpCzwgjAcBrGgFRTLh7TnEuClTteoy+qI=;
        b=fD8XxZY1UodhyOBn79r1tZ+Q0MT0UQOxYmKuwWu9STl2WERhDyPRlrW76bSrHbR0p8
         h2jIOQMEfKo943/CfW+W7qD3jgv8tlDwjC38Z1qyfiROdPyldOBURnJyTjq+0wFyEQOv
         ZOymioOaqVofr8QXjy5bYg0FEnQs8GYNYYIlsIkqVeYAUXLIRFsmX/DXdu41cZy60tvx
         nqI9VHkEHq1z4KTzZ8pKcWGAa8ctpadE/cjcK3VZSw2YGKVjZAmRhoRlQ4FjZNlRYuq5
         1WxPCDQd8EDwxH/hZFWu2q0o7VouN3IK6vpONMII7jLb5dcT+6YyJJVv/6F5DKewRHt0
         GFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt9GSJY6oHFpCzwgjAcBrGgFRTLh7TnEuClTteoy+qI=;
        b=aYErGC1OZcMb+rIJPdlDtKNs0kusfb/ehRw8b/IdInsa+ZhbV0IVcP8rz5cMnbFrvt
         ZQ1dO5iQ5EXdZirK0AzQTn6U9m060CvaBdxOTErwGNlALsuGY3c9kWrWAywbVo3MY8x1
         SsC4nwsYk9uFKgWlojJhxhLsmQxP1ibaQrmukHCfwvBchJZ01bV2THo8BDGkjT3/YoUX
         8bPmoM6yOzKAFBDA56aIu/gloLrcdbT6/im3u53gNyo3J+Cs+rqzy+01/7tHhZql5pH8
         y6xrHXldoTnEUVKeMG9XIY0eztdkgw+Wx2YL7S1qaFI1nQAEL4emKML91wiizqkr5e3+
         eKPQ==
X-Gm-Message-State: AOAM533com5b44h8+NtBNAxTE8weaYJqV5MKC137/RqB83D8rad9IjLV
        Y0po273cK9DIlEGjz4MVf6lpP2V/tnRgtW3ehfE=
X-Google-Smtp-Source: ABdhPJwPw8jFhUlGOroYyzAMGOrWBCkJypBlZn//O+7ZtQdDWM0D6LpkEi2VMyUEjPbLEZCd+AQhTQeVLI3Q18ByDY0=
X-Received: by 2002:a17:906:b18e:b0:710:26db:7a53 with SMTP id
 w14-20020a170906b18e00b0071026db7a53mr10185146ejy.290.1654466568353; Sun, 05
 Jun 2022 15:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220601033927.47814-1-linmq006@gmail.com> <20220601033927.47814-2-linmq006@gmail.com>
In-Reply-To: <20220601033927.47814-2-linmq006@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Jun 2022 00:02:37 +0200
Message-ID: <CAFBinCAkdRrk+EcZvFFiGEU3r9QtKfxYEPgpkn-HtRmBdwRSmA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/meson: encoder_cvbs: Fix refcount leak in meson_encoder_cvbs_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hello,

thank you for your patch!

On Wed, Jun 1, 2022 at 5:39 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_graph_get_remote_node() returns remote device nodepointer with
> refcount incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 318ba02cd8a8 ("drm/meson: encoder_cvbs: switch to bridge with ATTACH_NO_CONNECTOR")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
As far as I can tell this patch is identical to the one from v1.
Please keep my Reviewed-by from the previous version in case nothing
has changed for this specific patch:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
