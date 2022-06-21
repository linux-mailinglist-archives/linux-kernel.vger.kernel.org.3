Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAAE553778
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353781AbiFUQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353768AbiFUQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:10:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52745BE15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:10:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f65so13539194pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cbMkNF6F3Ld4xQ45Oa2UvUrcvR0Hf6I/PwT2kBwxAs=;
        b=aB5j0VbEE/nmIbXsK0SDlivbqh84Xhr061uGq8iD+WWz1c+oIBC0c1aXlmCVOXhzHK
         AAGOJx6jqamYX1GtqvHExxYoa2FRKSt6PridsYBLQa8Z7K0AVaKV7YWDBIUQfRm+Sup4
         qqrikaWUQ7A/vUeD9Ukcr6oFAVZROfENjgWyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cbMkNF6F3Ld4xQ45Oa2UvUrcvR0Hf6I/PwT2kBwxAs=;
        b=M8ApuL4SlzuFAWdr5+kDz3m/J0V6C7/RM8y2bzr4uBcNsWGCfWDsfwFiTU8CV7zsNl
         UfnVs3VD/thYRy8CHIpfSHnH0VYonHjXzqrJMigaEY1hPF8aEoufx6aVgVzV9umgr3E7
         S5t+7epgEwLnmzJHgwRbFxIdGZ8cPwG3bApt6rZMkOic4p2Y3NG43k3vvRPHLkS7MP84
         EwCNJBcVrtcwhW8gFmFYwyz95uZhR6wB3vFBJgDzStxntRaYZAK6SZyESvgB4RVs4EA7
         ZAw0LUKvjxqV++eIDoD/UnLt8WsL0Pq1qZZADN9k6LiIG+2Wl0rfptia2A3TS5odKyrJ
         2lnA==
X-Gm-Message-State: AJIora9PJnoxGpcup+t7bPDDJB2dvAkA1SrRn4CB/HCbrxOGXG6IoTqA
        T5YXMR9Rx/SLPf/CN44uSpWXOESlISeUqg==
X-Google-Smtp-Source: AGRyM1sU6PMYF0+iTW2SErP7L6WftxnNAF3IPg2lmPKyhTua7dsjec23qxJZ9j4mRxIJDECmv7J4Aw==
X-Received: by 2002:a63:a55:0:b0:3fd:e492:354e with SMTP id z21-20020a630a55000000b003fde492354emr26540493pgk.416.1655827834601;
        Tue, 21 Jun 2022 09:10:34 -0700 (PDT)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com. [209.85.215.171])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902a38a00b0015e8d4eb20dsm10932804pla.87.2022.06.21.09.10.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 09:10:33 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id a14so3933851pgh.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:10:33 -0700 (PDT)
X-Received: by 2002:a05:6602:29d0:b0:669:1723:c249 with SMTP id
 z16-20020a05660229d000b006691723c249mr14916031ioq.208.1655827822015; Tue, 21
 Jun 2022 09:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220614215418.910948-1-dianders@chromium.org>
In-Reply-To: <20220614215418.910948-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Jun 2022 09:10:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCCaD-YxhyQeUXe-L06me7XnTRxvsuzjMjWMRYtFxpjw@mail.gmail.com>
Message-ID: <CAD=FV=WCCaD-YxhyQeUXe-L06me7XnTRxvsuzjMjWMRYtFxpjw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] drm/dp: Introduce wait_hpd_asserted() for the DP
 AUX bus
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 14, 2022 at 2:54 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> This is the 2nd four patches from my RFC series ("drm/dp: Improvements
> for DP AUX channel") [1]. I've broken the series in two so we can make
> progress on the two halves separately.
>
> v2 of this series changes to add wait_hpd_asserted() instead of
> is_hpd_asserted(). This allows us to move the extra delay needed for
> ps8640 into the ps8640 driver itself.
>
> The idea for this series came up during the review process of
> Sankeerth's series trying to add eDP for Qualcomm SoCs [2].
>
> This _doesn't_ attempt to fix the Analogix driver. If this works out,
> ideally someone can post a patch up to do that.
>
> [1] https://lore.kernel.org/r/20220409023628.2104952-1-dianders@chromium.org/
> [2] https://lore.kernel.org/r/1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com/
>
> Changes in v4:
> - Add comment that caller powered up the panel.
> - Comments now explain that we may wait longer due to debouncing.
> - Mention in commit message debouncing vs. powering on timing.
> - Rebased to handle the fact that the stuct moved files.
> - Reorganized logic as per Dmitry's suggestion.
>
> Changes in v3:
> - Don't check "hpd_asserted" boolean when unset.
> - Handle errors from gpiod_get_value_cansleep() properly.
>
> Changes in v2:
> - Change is_hpd_asserted() to wait_hpd_asserted()
>
> Douglas Anderson (4):
>   drm/dp: Add wait_hpd_asserted() callback to struct drm_dp_aux
>   drm/panel-edp: Take advantage of wait_hpd_asserted() in struct
>     drm_dp_aux
>   drm/panel: atna33xc20: Take advantage of wait_hpd_asserted() in struct
>     drm_dp_aux
>   drm/bridge: parade-ps8640: Provide wait_hpd_asserted() in struct
>     drm_dp_aux
>
>  drivers/gpu/drm/bridge/parade-ps8640.c        | 39 +++++++++-----
>  drivers/gpu/drm/panel/panel-edp.c             | 33 ++++++++----
>  .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 51 ++++++++++++++-----
>  include/drm/display/drm_dp_helper.h           | 30 +++++++++++
>  4 files changed, 117 insertions(+), 36 deletions(-)

Pushed to drm-misc-next with Dmitry's reviews.

f5aa7d46b0ee drm/bridge: parade-ps8640: Provide wait_hpd_asserted() in
struct drm_dp_aux
3b5765df375c drm/panel: atna33xc20: Take advantage of
wait_hpd_asserted() in struct drm_dp_aux
2327b13d6c47 drm/panel-edp: Take advantage of wait_hpd_asserted() in
struct drm_dp_aux
841d742f094e drm/dp: Add wait_hpd_asserted() callback to struct drm_dp_aux

-Doug
