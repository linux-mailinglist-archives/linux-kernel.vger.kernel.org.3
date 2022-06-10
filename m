Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB55546E33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350528AbiFJUVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiFJUVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:21:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8122FEB96
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:21:41 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s124so628029oia.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=v6z8gULTHIEXJFyVfHn/zYRZEQ/mq5kGz4DwMssZmiM=;
        b=Yas5LCbeDxcOPo3MtUKZPoVtjGz2N7nWVFhOKmjgn5RnpUF00Uq4gIqlVy09L363kc
         gdafOTbPwf1O8ium0rvj7YV7d7ulOBtUIuJlR3T0KBIQJpQn9u1liHa411It6wWWEuN5
         FJVF4ZMWGGE2AhisPOXQ1h6NI1U6P69ujwl/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=v6z8gULTHIEXJFyVfHn/zYRZEQ/mq5kGz4DwMssZmiM=;
        b=NVaj6njTwBvf8yVrdkn6xHYC/Kxyf5GufLhwrikg9AnvYD7xRAroRNjACnrFc7jl4I
         KLhskP2Z+iglmb7xNfEp4KJ8WN6EeWXQM5Ty8Ul5V5/iBtX7hGUCgHQYdd4VkSV7oZfh
         NIcOlHxOAR8T5OsvhGHx/zV4PodPeiIPGLdtaho+IXcAeq1USH1Vm0HH8vXDtZmnFrHd
         c05SrBqVC2ev9HIItG6javeISCqDs/OlGEfRcNJRQVDhZ+u7otPJb/uEE9Jx4UF0ixXD
         NRZRJywXGqzYitQx1aeTqySgn39za3fI/ujQsabd6IrfGIFvLkB54r6eu2uTI5H8BQIj
         Xgeg==
X-Gm-Message-State: AOAM533MTwo1rIbbDot6ur9pDPMUyT2ZYoAy8ys0pCrgQinnz5yuCF0L
        adgCO1ownDIlLovBqbajPUK1+B2KTydCED8i1cjerQ==
X-Google-Smtp-Source: ABdhPJwZSfk+gNJ3MxdQNfb3bKMEr+pEObaXeEJqxZl5sl6oW8U5vvDxSDnaFP1z3ZStaQR+bR5RyDX3py/JnYaYMbI=
X-Received: by 2002:a05:6808:e87:b0:32e:4789:d2c with SMTP id
 k7-20020a0568080e8700b0032e47890d2cmr774448oil.193.1654892500954; Fri, 10 Jun
 2022 13:21:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jun 2022 13:21:40 -0700
MIME-Version: 1.0
In-Reply-To: <20220609072722.3488207-9-hsinyi@chromium.org>
References: <20220609072722.3488207-1-hsinyi@chromium.org> <20220609072722.3488207-9-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 10 Jun 2022 13:21:40 -0700
Message-ID: <CAE-0n51UTDJ1zkhrwcxrYL7X9_MrhAeodiTJ30k+3Zef3zP2=Q@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] drm: Config orientation property if panel provides it
To:     Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2022-06-09 00:27:23)
> Panel orientation property should be set before drm_dev_register().
> Some drm driver calls drm_dev_register() in .bind(). However, most
> panels sets orientation property relatively late, mostly in .get_modes()
> callback, since this is when they are able to get the connector and
> binds the orientation property to it, though the value should be known
> when the panel is probed.
>
> In drm_bridge_connector_init(), if a bridge is a panel bridge, use it to
> set the connector's panel orientation property.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
