Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1D5388AE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbiE3Vt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbiE3Vtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:49:55 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927AD53730
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:49:54 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id m68so240299qkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyIZLMpN8yM0C+zjTwxWjwcZ2QrcKF6IgeGKdgmBFJY=;
        b=gHcxRtGDoYeO+1kAyP6pFVBMMe0X3RvUE1GAgq20de6KB30VN8KNhd8+GPYpjxwIY5
         KALbPX55/RvHg8AeuuBUC4el4dBrfSm5QYa8H2uW/dP1D7PigbqIlrl084fYKQlgJ10E
         rjdcV65g8ZK0vPIc/mvl+B3HbQbtfCD3+f8RqOH5FB0hd2DyFYG6EPD3ZckOXOjtf6ql
         pUU6rLqd+YbMNhBb6sy1J6kxHWO1pUtOc14aHifvdD+NFbpEZh2DjDpvVP8GBhEoaBya
         6uhd0jw2PLnFaW5RpzLveGX/SVZd+SWgUM/MWyw4FuAuAxlXPXxk3x9gXFrlIWW27Z5x
         HguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyIZLMpN8yM0C+zjTwxWjwcZ2QrcKF6IgeGKdgmBFJY=;
        b=5VPvVWw/0jHPJhZ+ScRQ66Al7xYYU8YWEgc2ZVDlb55KTiSXd+yGyJTasoH8RCFI+0
         OFR38f5Y5SJs5ytYrpVVwQmXu/NsDK8ltRNXMFi/MFIqKCr+zXGeOi8TrPlaOY7g3jad
         y4vXqiaAek4fasLbE47h5tm95v8ftFyz4D7B4V7ipatKQEwQiF9L7Rpaq6ZQqcd4HVjy
         gOfWTNlMGv3VLrOKjPjQbQF/ZYsKpDYpCjMo6AG2KRpXvaeDEF7zQyVv+CsJyUQ4cvCH
         yc6Gvg3dMhPZCP7BxFulIOG+PaOB0tHyIkdzaBdPod7UmT/ZBojzxoR9X3axAmNcDAmv
         Wukw==
X-Gm-Message-State: AOAM531tsQMVpfdRnh22dKMNzMAUSdlyt+KIeaLvhC7XzAQMJ/wAQy3H
        yhtAjbMYXNBpthzwAhB88T+SejOjFKtQ/E7v0rnVGQ==
X-Google-Smtp-Source: ABdhPJwsqssNs4WAxkzWklQmjHdnCgJ3D8qJrLr2CI/UtjeDrebRWydyU53sBgITCNcpLLIKJKP3und/snBq/5zczLM=
X-Received: by 2002:a37:6883:0:b0:6a3:42ae:e17b with SMTP id
 d125-20020a376883000000b006a342aee17bmr36933263qkc.59.1653947393598; Mon, 30
 May 2022 14:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <1653877196-23114-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1653877196-23114-1-git-send-email-baihaowen@meizu.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 31 May 2022 00:49:42 +0300
Message-ID: <CAA8EJpqfvMPZza=J-TKxNtP2L1GPsy+va_dJ9EWuCAYtZWQrjA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Fix pointer dereferenced before checking
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 at 05:20, Haowen Bai <baihaowen@meizu.com> wrote:
>
> The phys_enc->wb_idx is dereferencing before null checking, so move
> it after checking.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
