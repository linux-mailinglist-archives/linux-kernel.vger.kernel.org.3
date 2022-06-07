Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1291154029D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbiFGPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344190AbiFGPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:39:55 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3425292
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:39:55 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id bc11so5179722qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xr4dhCfuSdEr2WcWiYRbEtXrj+jlCFWCiFgRYjOI+Uc=;
        b=zR+xtsgJ7G+nQWsuYa6k/ouh729YUTTDJBzipWtz9ukuJpMGaeqMVf9/jok5oWpmvX
         YAzp0z9zSbazae95tjtxp+y4Vnlf4xBnLRh5rVDm/43851H+pwhEYwY7WURjBSmTJPm9
         tJfYt1Ehw/6luGRjwLQN98v46Py2YABHohs35P8/7A8ZFcKy9Q8pVwSXgcS6Aunbmo1H
         R5iXA6vqA9buEW5D/hpkUVfbZvayZUQV9s5dgyOEp+BtWcn/HJrrEZ0XEAD0c8y2RMdY
         F44d87V25qja1/4yPakraXZ/qTXDpvQFSNZzxxpxqPflN5Q9sCHh8m7oXvomgJQUb2vs
         45mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xr4dhCfuSdEr2WcWiYRbEtXrj+jlCFWCiFgRYjOI+Uc=;
        b=eEZdF03GBZ8VKcaSZjGdz0AgU4i84EUI1eZ7kAsfykqapPeRDKX9u+P4TnX6eqMaRb
         aA5iBNmyUa0m3IBh0VCtsoL67Og+AcO9faa62zuv3WnbdWG7IBVS9Hyg9Y2GVzdZlCGw
         Zdniy7Mt+XZVoS+ypwrAXIXV/OlRGInfGvDLqad1nAz/xtVNn5qLP9xq6LLst2Xw6h5k
         zr0Ub8wr8yB1gsgy4nrYmbuYMiFYhMlsnq871q0/aSAHLXQtlNfZlYKjqs/wMndZnrPy
         E1BBott5qnX59EByg5JQbkSCTQFQSZNb/thAfXmG2QdGnqPF1UBWrAzqvsqlzNU1MbNN
         kWKg==
X-Gm-Message-State: AOAM533fQguTk44dDiOcX3AIuA7HFbUvdM4Rwj9QY0PWHkgxGt8Qac9a
        eJtHvYoF0Bt5lUbWF0iGaN516F0I7UZBPHdJK2y8sQ==
X-Google-Smtp-Source: ABdhPJy03x7T/95dDtPpCaHNjzfEcVjlYBBdheV4q9h21nNZHKPRkMbcYwtcf2LWNvzyM9zxVElpH3U8pvu3bg0PTMc=
X-Received: by 2002:a05:6214:5488:b0:46b:b272:f7d1 with SMTP id
 lg8-20020a056214548800b0046bb272f7d1mr4833597qvb.73.1654616394183; Tue, 07
 Jun 2022 08:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220607110841.53889-1-linmq006@gmail.com>
In-Reply-To: <20220607110841.53889-1-linmq006@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Jun 2022 18:39:42 +0300
Message-ID: <CAA8EJpo0f_F8kuc617UK0ovmiWvUAN+KBkViV-TPQdbt001drg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/mdp4: Fix refcount leak in mdp4_modeset_init_intf
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        David Heidelberg <david@ixit.cz>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Xu Wang <vulab@iscas.ac.cn>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 at 14:08, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_graph_get_remote_node() returns remote device node pointer with
> refcount incremented, we should use of_node_put() on it
> when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 86418f90a4c1 ("drm: convert drivers to use of_graph_get_remote_node")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry
