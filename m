Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508C950C54D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiDWAFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiDWAF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:05:29 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422822C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:02:34 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso6554335otk.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=qPSkwD/MU+Iqo4BRfa/Ls4gx2geTEC9xNtBW72fotns=;
        b=SGhKHlx9rgmGuT6KRjWdwmxQ6DjMyJuzfLXLaIeYVZ5TcfYbaSKVqoxVTgfk6REXcQ
         TlgPEGIZWLwT8DG8S96iFRwCNg7xVZDKb+MzzlNcrntMSloJCzacD5SpwspomRzFRT3g
         wgr86qCSKfNxzHpd40okIrwxExUC0sZieWPdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=qPSkwD/MU+Iqo4BRfa/Ls4gx2geTEC9xNtBW72fotns=;
        b=6v5TEXiVvdJM84PpUv8317bvo27FT9gvqr3yxGnKAh+q1d7ZgCS5Xm9whaveKSKRCC
         L/8OB/bkUok+wo4ScNGOHWLS/OcZ1a5fVYnQp3b/EikNRhmG6Siqv5vFZ9wuNfIHr3SQ
         Eakh3OVj2vJgkWRDLN+a+9LBr1zSypbEcHYwXHsBKW/zDTVRB2i8+N64YPM7+J4sHTiK
         vSxL8uz8ebuQjiRlbxxvtevDeyOm/vXjmPu2/FSrpuJGyCX3aqmQ+uKhyeozTYydh34t
         AD7rSLwZLeFpUhSl7QS+KoXHsSqjpHUJHmZEfnPGPdQPCZe6tS5nbm6ab3nwNfRD9pY3
         OyqA==
X-Gm-Message-State: AOAM533WkkjmEeC5vHr2CmW2KlVGVJb9BEEKUegZTt0SHmyElMrbP6EP
        e7eIUaLO/aFJK/dRbapwaTlGgcfu9nKBBLAiTw2q4A==
X-Google-Smtp-Source: ABdhPJyCu1JPsTB5cEHaf/m5kBgPEh7iMzqGhHYkxVcYy1y6WXjtp50N6Ta3Ouu7RPsVdOORKVJbQT5IgWz1UxpYpbM=
X-Received: by 2002:a9d:20a1:0:b0:5e8:d2b6:f63f with SMTP id
 x30-20020a9d20a1000000b005e8d2b6f63fmr2689805ota.159.1650672153625; Fri, 22
 Apr 2022 17:02:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Apr 2022 17:02:33 -0700
MIME-Version: 1.0
In-Reply-To: <1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com>
References: <1650671124-14030-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 22 Apr 2022 17:02:33 -0700
Message-ID: <CAE-0n502Jc57jKDL5d3QbZBZrtAiuU+vj33BXxB3sb7EScTgHA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: move add fail safe mode to dp_connector_get_mode()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-04-22 16:45:23)
> Current DP driver implementation has adding safe mode done at
> dp_hpd_plug_handle() which is expected to be executed under event
> thread context.
>
> However there is possible circular locking happen (see blow stack trace)
> after edp driver call dp_hpd_plug_handle() from dp_bridge_enable() which
> is executed under drm_thread context.
>
> To break this circular locking, this patch have safe mode added at
> dp_connector_get_mode() which is executed under drm thread context.
> Therefore no lock acquired required for &dev->mode_config.mutex while
> adding fail safe mode since it has been hold by drm thread already.

Reported-by: Douglas Anderson <dianders@chromium.org>
Fixes: 8b2c181e3dcf ("drm/msm/dp: add fail safe mode outside of
event_mutex context")
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
