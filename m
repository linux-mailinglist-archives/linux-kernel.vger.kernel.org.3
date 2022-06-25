Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9166155A549
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiFYAMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiFYAMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:12:49 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FED5E081
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:12:48 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id o43so6900147qvo.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mB243O2vDZbtklHZe05Xzr0fp3GBiFubevpzgOWKzOU=;
        b=GtEibzDijC4BeVChXPiU/2H4lz4ffgbfvTFu6q18HRJhvIHF5zpBoNQ8NPZr0o1A/M
         oiq4fK/AaGi1CWJ4UXU+ukNcj8/3v6IUcOBV1fGgIJamg10q86KmF+s3fth+XvGVFXKG
         tKxgecGUfAPi/gQXQ8sClI9DJW5S1TADlDQlbwe4PQnJX5PQewGdRFpQsLSwfMXRYhGq
         urM7p8gp+eslHqSnl1R9/pEFTdYHfPOgKsT4Ck5pYmdSFpZb9fYBU6U1ZyNde8cgiV9f
         EFePB6CwBRIjvAPsYqU6jLO02i0mRY80kzzHv509055iUvjkprkTpdnOI3hkfO54lLel
         Dkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mB243O2vDZbtklHZe05Xzr0fp3GBiFubevpzgOWKzOU=;
        b=HSBxfyRDaxrA9ZhPuu6pOK4hcAEQtNDkiOEvKsUocfEbJxL1PO0Pd9XmVgpJp3t/rW
         QdwU+qNbvnnZdhOOl3Kf3eF95ElWQNUyQecStLHBPia0MMSTdm5fbEj/jLhQZzsUnmvJ
         K5KBazBc84XGMZPGO/ODd8m9ShtRy2fcWsOddQc5lNmpyztkTCp1njSouTgvZCSH54vf
         FnDs+PV/itgxH2NGCu4EBg4h1NGO+hYvgW7fG8Z2iF9PZKqVDNazqgyJrhwJ0aNMyYwJ
         MwhDcZIqgwhyZZ0NJFZXGg5l+NuFarpBzNXYn9GLGvljtDa4AEH1OgYXAQjJqKdN+SMX
         CkjA==
X-Gm-Message-State: AJIora+cXYBozQphUTi42NOZdjlsS2YC/3Nb53iwNiOVHBs1OsiIN2GO
        zjhZgX37Ti/rhg8qqTpsZa1KSQBmZl7Zw1H0iDZQ7Q==
X-Google-Smtp-Source: AGRyM1ulqLC3UhHGmkjCmq1ZXZo6/6GUqiNwLS35/4vL9h/wWZBzRC4/Bqvi6XyEgTCXEO/7EbD2SvRu66ZMiSV7vAA=
X-Received: by 2002:a05:6214:2a83:b0:470:a898:e467 with SMTP id
 jr3-20020a0562142a8300b00470a898e467mr1174976qvb.122.1656115967606; Fri, 24
 Jun 2022 17:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220624184528.4036837-1-robdclark@gmail.com>
In-Reply-To: <20220624184528.4036837-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Jun 2022 03:12:36 +0300
Message-ID: <CAA8EJpot4qN68Edq9SZdE76DJof+2i05SUD1yJ1uBHu49jBM_w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gem: Fix error return on fence id alloc fail
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Fri, 24 Jun 2022 at 21:45, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> This was a typo, we didn't actually want to return zero.
>
> Fixes: a61acbbe9cf8 ("drm/msm: Track "seqno" fences by idr")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
