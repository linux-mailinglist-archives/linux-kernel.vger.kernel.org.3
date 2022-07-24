Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C29057F6C3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 22:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiGXUKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 16:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGXUKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 16:10:36 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012D8B489
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:10:33 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i4so7108424qvv.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NQyh2bs88XAyOOdXIMOFXmDnOwmGl1o/0rUMi4/QHQ=;
        b=PTRW02txEXSRXk8Xo1Q2TayCDLjbCuulOWRBmQ5t7Qi4FjCMoPit1qMWO0hbUeK56c
         E64UPS1q/n68EwFHdAiCJyjc0At5jFUT4KhA6iRj6vQXkW6SGSGmU6wqFlcjqppswMx6
         D5L1diBp31p8SEVf5tD7KLA2sOMQBmlTkWpj+3xA1MEySDiFWsc1koRhLM18/EQn5dk6
         DYdZUug9O7n5Kso9Uxz6878taL42QEbsQxBW36fflVmEqBfd5rmLTTmqWGUyyiMR93vd
         rYsZus7SMgWJsypemqb6MYdM/EW9zEt4PzrK41q4LXNfXv2cqF9PhI/PiSFw2i+H9bv1
         I/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NQyh2bs88XAyOOdXIMOFXmDnOwmGl1o/0rUMi4/QHQ=;
        b=lH9T2dzVv+pxVXjFcWCw1Xd/isgRwn4D5g7e/0Fq1BGnGzj7O6pZdkWfZ4/Vn23+Ns
         0w4akrRa7IWruAPFzr6zGLTl5qxfh6N9fd6FxQNjLbuGvJ3HcgD5d0mwfUKLSWoq/RLG
         +0SIy+8qRV0jA+86JB6koaOfm5mbOSJ3bO1DIvt1hybTSq8qNG/OREV/DTKdXwpsh0eK
         HNsYM7mg69MMWonPe4DXDEA2RKFSAF6/A+JP+UouyyvY4xJeAONUCdOlt1QSHcfbJxbt
         zllLih41HyxaP+pcnt6/2Q/c5An4TcJ+GnDqJ08hIedVuGcSXSWygkvWdOLkKHEUuEWY
         3r7A==
X-Gm-Message-State: AJIora9G4+AlgYU4WCmjlon6TvcAakQFoQclO67W58cwqJkRNPHOQLDt
        fIeunInXVtONmGFN+HTyza1s4b1Yv0M88Wo71x5e/GKg5YI=
X-Google-Smtp-Source: AGRyM1v7WhO0L7GbCrccVmyoYUn068LyDJDUELP+QZpK71QGYLNkxFlkoRfB9mBp1JKXkq9msK6IFtm0la5TZjy7Rus=
X-Received: by 2002:a0c:8ecc:0:b0:473:2fa4:df7c with SMTP id
 y12-20020a0c8ecc000000b004732fa4df7cmr7835949qvb.55.1658693433038; Sun, 24
 Jul 2022 13:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220724111327.1195693-1-javierm@redhat.com> <CAA8EJppEpPe4nfZ_kvNen6shSvgyUoL3adSQfhhCGCS2VmVZhQ@mail.gmail.com>
 <6b3f98db-83bf-41cd-b23d-79b455a06ebd@redhat.com> <630a6654-0305-f3a8-e062-f13a0074d35a@redhat.com>
In-Reply-To: <630a6654-0305-f3a8-e062-f13a0074d35a@redhat.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 24 Jul 2022 23:10:21 +0300
Message-ID: <CAA8EJpr1xf9mkfT-FhK9M58syMnWCFXozWHH9L_gxtXOqgh0yw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm: Make .remove and .shutdown HW shutdown consistent
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 at 22:51, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> On 7/24/22 20:47, Javier Martinez Canillas wrote:
> > Hello Dmitry,
>
> [...]
>
> >> Now there is no point in having this as a separate function. Could you
> >
> > The only reason why I kept this was to avoid duplicating the same comment
> > in two places. I thought that an inline function would be better than that.
> >
> >> please inline it?
> >>
>
> Or do you mean inline it as dropping the wrapper helper and just call to
> drm_atomic_helper_shutdown() in both callbacks ? I'm OK with that but as
> mentioned then we should probably have to duplicate the comment.
>
> Since is marked as inline anyways, the resulting code should be the same.

Yes, I'd like for you to drop the wrapper. I'm fine with duplicating
the comment, since it will be in place where it matters (before
checking ddev->registered) rather than just stating the contract for
the wrapper (which can be easily ignored).

(And yes, I do read patches and commit messages before commenting.)

-- 
With best wishes
Dmitry
