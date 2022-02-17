Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0ED4BA9EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbiBQTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:36:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245269AbiBQTgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:36:51 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1472A24587
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:36:37 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a12-20020a05683012cc00b005acf7c91097so448176otq.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=H+l6hsd+n/fdXKs16VSP4q/PbtQuMzGtJT4cgvfkyLM=;
        b=TFS6wlpWxxfiSvxGIJT5wKWz8pYgNIlYtyrOibWyZ+S/iJaoGCQre53jIw5wLhCoob
         DMY/KuX/4BN7wh9Zi9o7iO0x06vdpsMf7L29hiurIB4sWLyndkE68bUK7GewspaLaqDi
         0ZSe0caSnelzPSVH1HIECXuzTI4WwvijpBa00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=H+l6hsd+n/fdXKs16VSP4q/PbtQuMzGtJT4cgvfkyLM=;
        b=Ay7syJo6ylLXxHKYHz30e2sxPZ1kZBmHwsH5DX7wucQFTR8lioOok9Xgzc9AmtEOqW
         w7Gof0PDS9bKxCXJcb3Q7+8BrIe4paBJ4aUhhHYSagcqh+ebzyWqBmoPzn7QZ3MY2xNR
         6P4o7BqugVUw3iVGdGsbaD5xTlmi88x9/sQQH/m6mmn9rEwidmBgBsaaHkseux8hjwPv
         /B8Q6tD+/VDsDGNbW0OEHf0KVa2dlijxTF0IAWS2kDIpgkqhePdV6YyDIokXavmoIz6U
         f1uaYE5+/C0quSG6iuJupgK0rRma0mM+sIdAg3B5+nUXmfqXMUOwwd6vaAOrICzpymgb
         w01A==
X-Gm-Message-State: AOAM530AD0P94IyfuD9eUaUCcCXx5BQPR29xFva1WaqkzCowBMZdaUf6
        6BRcdzIl/gG/6nctJ+PWGXbn2krrHAb2JqQ2V+12IA==
X-Google-Smtp-Source: ABdhPJzCvdEu8Ryr/y4DCzdw3lIqkwqkZu7z2hNcjMQo26YSTG5Hasgkw13cOP+fiQjDeEpiazhD4HoKhTitptumMTA=
X-Received: by 2002:a9d:7687:0:b0:59e:da8c:5d32 with SMTP id
 j7-20020a9d7687000000b0059eda8c5d32mr1419683otl.77.1645126596435; Thu, 17 Feb
 2022 11:36:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Feb 2022 11:36:35 -0800
MIME-Version: 1.0
In-Reply-To: <1645122930-23863-4-git-send-email-quic_khsieh@quicinc.com>
References: <1645122930-23863-1-git-send-email-quic_khsieh@quicinc.com> <1645122930-23863-4-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Feb 2022 11:36:35 -0800
Message-ID: <CAE-0n52cz6JibgsJ4MWsdGhAjxHa6en+JbyKjKHVwQDnM8-5Og@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/msm/dp: replace DRM_DEBUG_DP marco with drm_dbg_dp
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
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

Quoting Kuogee Hsieh (2022-02-17 10:35:30)
> Since DRM_DEBUG_DP is deprecated in favor of drm_dbg_dp(NULL, ...),
> this patch replace all DRM_DEBUG_DP with drm_dbg_dp().
>
> Changes in v4:
> -- replace (strucr drm_dev *)NULL with drm_dev

Why can't the platform device be used?
