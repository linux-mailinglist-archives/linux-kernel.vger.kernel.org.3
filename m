Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0980D4B913A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiBPTdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:33:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiBPTdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:33:04 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BAE1F3F1A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:32:52 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so3717641ooi.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2WrcofDXNq4fQvSh+Kgl5hWSou8+2EddXrcFZuX0Coc=;
        b=RQVD6Spf4AVQMUKOvOtdRaF6z6yGnhjSw8BOFMzXDxDLTsIV7N90lSsRuK7rkB89zP
         nWfOiGR4LbcGTUwut8aVKi2UOfIKbHGA0/KjIHo602H/Yfh6a6jQwRADuwfaxyxeWTtW
         H5l6f/e8+KGiQ8AvZ5yO3THM3fAuwp1xg9Vws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2WrcofDXNq4fQvSh+Kgl5hWSou8+2EddXrcFZuX0Coc=;
        b=XzmWHJO6gEFd5bmBMMMJRaVclJVCKkrebMsBWdf3b2LMx2L4lSXbRLgiV6E23EOLC1
         PNvCAAVHIGkC/ClNP6Zw948F+O6SFuGarnOFHtNvtGTO2B4ShDwCS+q09JBm1eoLf9ZE
         M7A5yjQL5nCYYMNabXfgHffVLKHQp9KEYroyeJYWBtrDrQ6mkHTlVUGyCVRyN3LNzsQN
         dq7BvmXFrH11GJwXPQhKxtsYbErmvmacV18AAwSCMqgUghRtz/QnD4MbMjZ6DuScElfh
         1i3i0fLDJamoI1tGrwziRIey7yolDZrDm9oZOby0s310+3GJQU4mH6aSb6WQd8kDMzlH
         aesg==
X-Gm-Message-State: AOAM533px8IIbnusjqGcpDqulRk/knuMyO0PwQdef8VUZkmjb3NahIEw
        3ytyYlSDgDcYlgHONs+B78/oS7ucPL3RWZcC/42R8Q==
X-Google-Smtp-Source: ABdhPJx3zyPVZHUH69iPnA4f7fxjaXMj27nLEaHyAfo/3Oh4oEDYw/v72mxHVfbQirS6DyQb4puuq4DHvHwI5ooAV3c=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr1130229oap.54.1645039971470; Wed, 16
 Feb 2022 11:32:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Feb 2022 11:32:50 -0800
MIME-Version: 1.0
In-Reply-To: <1643066274-25814-1-git-send-email-quic_khsieh@quicinc.com>
References: <1643066274-25814-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 16 Feb 2022 11:32:50 -0800
Message-ID: <CAE-0n52uYJ-E2HZnwjJL5VfXnVjiSGJ5MnZG827i=3NP7QNm1g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: always add fail-safe mode into connector
 mode list
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-24 15:17:54)
> Some of DP link compliant test expects to return fail-safe mode
> if prefer detailed timing mode can not be supported by mainlink's
> lane and rate after link training. Therefore add fail-safe mode
> into connector mode list as backup mode. This patch fixes test
> case 4.2.2.1.
>
> Changes in v2:
> -- add Fixes text string
>
> Fixes: 4b85d405cfe9 ( "drm/msm/dp: reduce link rate if failed at link training 1")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
