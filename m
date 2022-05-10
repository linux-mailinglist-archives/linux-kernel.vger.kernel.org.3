Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790A7522358
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348526AbiEJSML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348520AbiEJSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:12:06 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2FD38BD7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:08:03 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l16so19381193oil.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PBkBGj9Wm+vqScoe3rXf56OJq4tLpJWe7pdFIsGR7f8=;
        b=m7/KE9hL4p0V34eJ5CG5gGQ7DBSHi8qVI0yoATdKhsJkfVe5nQTKMLYYHsuqRS/YRA
         5ea2LelxM0XZNjHjHHJfhc3mu4Rxb1PndcumidEOGMhdgylteyqyxUAMTwG/QDFXsEwY
         FbD95wZFveFO4CMVdlxSfo4qPwUHJCZ+n+IRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PBkBGj9Wm+vqScoe3rXf56OJq4tLpJWe7pdFIsGR7f8=;
        b=oPkZL7rP4q9Y+UnGhgsNNZlMLmErt9hk1JPFA817Z/7L9R53GbvOF0UNl5phJGWbat
         t5utyT4IhVo2TTWkkZyWZnI8Z8wm8B3uU9ZWAUfxiTtcQmeZPCtnceTXiaK6+4zb/L0e
         1gRjJgp5ae4ZQ137ldkOTQC3JvPpSMN0zi+egyLbyw0IOcS73Xu2PWNSgIi9okzQBHmi
         gpJLU1VPa0FMNooW7vt8NXV4gFUn7kyvPE33Uwo6jKlfxpklX9/K9VR8Avn6ZCxMDb5N
         xvnTtGQac4xnpTucPyvD5PfYzGcSFf/RVZtAkfn0dAer7D4te4OZTKCTZfILTXdgzM9+
         k56A==
X-Gm-Message-State: AOAM530ELz2W1ORaZwRJR5MebrBsdDDEdQoy1Fg8hYw7CBeekRM9KOWr
        /+SmaxG5ex+Byrm5mKm96VyvghiYliFuxW9VyiKvJA==
X-Google-Smtp-Source: ABdhPJwDubvKYE7hKn9RJqYmmvSUB6eZFEeHBr9soKfiUdvHF1qRxJgLuav4mDD81e+i0CrUgZhvbbnCOoGW8sOaAaw=
X-Received: by 2002:a05:6808:14c2:b0:326:c129:d308 with SMTP id
 f2-20020a05680814c200b00326c129d308mr633893oiw.193.1652206082707; Tue, 10 May
 2022 11:08:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 May 2022 11:08:02 -0700
MIME-Version: 1.0
In-Reply-To: <20220510165216.3577068-1-robdclark@gmail.com>
References: <20220510165216.3577068-1-robdclark@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 10 May 2022 11:08:02 -0700
Message-ID: <CAE-0n52TCi-Vy8WUqCQdbcoqLCX6j4_mkM_1pBQC072DdqC-Wg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix fb plane offset calculation
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2022-05-10 09:52:16)
> From: Rob Clark <robdclark@chromium.org>
>
> The offset got dropped by accident.
>
> Fixes: d413e6f97134 ("drm/msm: Drop msm_gem_iova()")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org> # CoachZ
