Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5655A245
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiFXUAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiFXUAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:00:40 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40A4826B5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:00:38 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-101b4f9e825so5185212fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=oSfiCBI6rADUaj04vQ0405OWvsI1kvVtIUHFA11oGr0=;
        b=AzTPUiC43Gj/6Z9t+n4i14I6mGkZI/39weVhrwvNGDiaTV4vwIKZbNSfRAN5wtW1nF
         oDCOsFoC7WQUkXmCGuGxCvYrus4LASoYLkbeuSQnfDmRtkfY21qyLZ2A/1TkZLVaBiKV
         io052kql7sg6+CHv5tGOG8Qn3PSb0td2XoY50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=oSfiCBI6rADUaj04vQ0405OWvsI1kvVtIUHFA11oGr0=;
        b=ufghHV+rPRWz+W9+9cZh2NIT4zdKYdxXA3Icuar6qTKm0PxC5KOeOmFcnQxk6rUzJP
         ShbkClWGVTsOsAuxaSoHSKWypwyanuosy/+h5DmBvWKMoTCQUJwNPTTmjiy7Dsh66WNO
         kcSLduAjUv7/IFPn6SlNBFC5mgMczNEpPINy1VqdasWwdQAjIGPd2rQMRlX54CLeaU6x
         BvKA4yWxKhxmPTiWYZ7Wmq6YpzZj0eNT8OqPCT0fDYpIkXDiOqNZTiPxOUqAP1ToDzUw
         0gc513i1XY9C1Hx+tzAPMjcoagc0kFEvVxeYvN08G5mJWV2SVjSz7gZqJvni8KbX9Jif
         dn8w==
X-Gm-Message-State: AJIora+siXOwfdB0RM4jfajvB2wEE7NCuAWv0rQk6eB/2h3c5u0L987i
        znDWW4cjA0bPH1iDPK61BdYJqgRzKwZlE+QCacwOaw==
X-Google-Smtp-Source: AGRyM1vLrNlfEUnoqHSJ2ARj6K9GI68cyGAkEp1ju+dJRkgXCY63E4sSustNSy9m4JbTmpCAiuev4LGT2ZxCahAMIj0=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr461990oap.63.1656100837975; Fri, 24 Jun
 2022 13:00:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jun 2022 13:00:37 -0700
MIME-Version: 1.0
In-Reply-To: <1656090912-18074-3-git-send-email-quic_khsieh@quicinc.com>
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com> <1656090912-18074-3-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 24 Jun 2022 13:00:37 -0700
Message-ID: <CAE-0n52RW+UFJ=hqMWjwR8qvEbww7QjzPW1nhL3Atd97QXAnYw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Quoting Kuogee Hsieh (2022-06-24 10:15:11)
> Current the index (dp->id) of DP descriptor table (scxxxx_dp_cfg[]) are tightly
> coupled with DP controller_id. This means DP use controller id 0 must be placed
> at first entry of DP descriptor table (scxxxx_dp_cfg[]). Otherwise the internal
> INTF will mismatch controller_id. This will cause controller kickoff wrong
> interface timing engine and cause dpu_encoder_phys_vid_wait_for_commit_done
> vblank timeout error.
>
> This patch add controller_id field into struct msm_dp_desc to break the tightly
> coupled relationship between index (dp->id) of DP descriptor table with DP
> controller_id.

Please no. This reverts the intention of commit bb3de286d992
("drm/msm/dp: Support up to 3 DP controllers")

    A new enum is introduced to document the connection between the
    instances referenced in the dpu_intf_cfg array and the controllers in
    the DP driver and sc7180 is updated.

It sounds like the intent of that commit failed to make a strong enough
connection. Now it needs to match the INTF number as well? I can't
really figure out what is actually wrong, because this patch undoes that
intentional tight coupling. Is the next patch the important part that
flips the order of the two interfaces?
