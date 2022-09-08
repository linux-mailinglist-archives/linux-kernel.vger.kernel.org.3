Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAAF5B231D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIHQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiIHQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:07:34 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85536F9108
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:07:33 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3378303138bso170430057b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JJv51cMEwPKHeGHtyDWtDlnrabxmd1GuWDEXM9pG4rU=;
        b=TcrxrJCtL6pyn3nnmMSCsZMPhcs5m3fyi2iV7TKoaOShZwoPJQYgjIx1KBYqXESOP0
         bNBni7sHtK8MyEgvjgrpp9gur+gQLZj+Q80cmIREIB/RY5abPTO5tOnxFz9MXRG2zAar
         117pLJeiY50esGdC1pApVgf1nKk0IeyoJawvZDOf+oLvJ5A3IdPLmHWZdai1sW8jlrMb
         xwzeasSr/jc0rmPNyLp5Ak2o/AWa7XoT5FdGPt4i8iaKYZyk2vwijRjgAAhGmtRjhhJg
         Ga9S67aUzkZzbjdoTAAvgPD6bPdvsVs0DJbIvQEU9UZrrTy4JUidRk74VH05GppL80F+
         SGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JJv51cMEwPKHeGHtyDWtDlnrabxmd1GuWDEXM9pG4rU=;
        b=SzAG7cUq05iF3Nrk9n6w9fC9Cjs1Hk6iJEQCCZ6FgOsQWmqA9m4cIq+/UaMVl07sB1
         YjqwMs3Pb7jbqqJq4IQIzQ/yGO1it6fKdrggb0kn3Pvi9n2VdAxyKrdlXZgtED8wxvt9
         MtEw35p7CvAhxveSEv2jVRXKoXNjT+2fvlFxNg5gmrXn4tc82jppUBl5SMumO+ccJ3ZG
         JYvv3UPGuZf6lmJ1rM6kbylxepGRi3u2zst0EQg5P9gurLNGndDMJ9sWeq7NTcInKGvf
         VrGJluB7oYJS1duYqIaVU3XvFAFJ1FehOwF4wj0Is7DBfUuwuSYhRe8iobxwInuwv1xW
         y/qg==
X-Gm-Message-State: ACgBeo1na3RBF6RAHe+ERkhgxueTQ6FdbU+0X72wQ+bg8F8ELSaXa5Ln
        MzTze2c2BLMCtxwRhn0OeMTHTHJqmCOTxxB12arYaOiJJ0s=
X-Google-Smtp-Source: AA6agR4zjZ5M4DR5iRReMpuVoqJUCuQUa9QEuRg73CcLPLa7gZkhLwEqcDY/mIHWG91nOJscsrrtch3EhKjLReFSL5I=
X-Received: by 2002:a0d:ffc5:0:b0:341:6cc1:c589 with SMTP id
 p188-20020a0dffc5000000b003416cc1c589mr8431078ywf.418.1662653252731; Thu, 08
 Sep 2022 09:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <1662651516-30283-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1662651516-30283-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 8 Sep 2022 19:07:21 +0300
Message-ID: <CAA8EJpr_cBTyugJx1qZCEEgsdNvxHmZ7TPZiqRu_kb=NNNVLKw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: cleared DP_DOWNSPREAD_CTRL register before
 start link training
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 8 Sept 2022 at 18:38, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> DOWNSPREAD_CTRL (0x107) shall be cleared to 0 upon power-on reset or an
> upstream device disconnect. This patch will enforce this rule by always
> cleared DOWNSPREAD_CTRL register to 0 before start link training. At rare
> case that DP MSA timing parameters may be mis-interpreted by the sink
> which causes audio sampling rate be calculated wrongly and cause audio
> did not work at sink if DOWNSPREAD_CTRL register is not cleared to 0.
> This patch also make sure bring sink out of D3 power-down mode into D0
> (normal operation mode) successfully by retrying 3 times.

Split into three separate patches please.


-- 
With best wishes
Dmitry
