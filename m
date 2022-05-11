Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407C4523E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244787AbiEKUGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiEKUGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:06:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A988233363;
        Wed, 11 May 2022 13:06:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m1so4430407wrb.8;
        Wed, 11 May 2022 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6YNSoA5Dua0+s/FF7SpEIcKqn99xdL9v6a8e8wASjE=;
        b=huVs1irgBIkg9Eul0wYK5EYPJx3b0ncqN0x9QsTfJvBcQ2t5FOtXmqR45KnVbSBCt0
         tRVR32t6absZdZ99QabYYfqRY9JvV5eBYNqMncuhU2tTBEa3Jx27JsNQ5Qk/8J/I1Rqd
         uiZxKXViZRvewgUcnsIcC3Lbrm8xA1GbN6EW0FjiDtQoz/UCGHm8rUNxBJguevCQ8bby
         hbqSts8HPIVGxqadiiBHoU5HXVcqmZGmu8SOnw+2/jhm12VXAimJtNgdng9UB3jfuSIq
         6e1eUh5wALaSoHtArYquH1ViBA4Y+EuTOUaXV46Htl6nWhXkQD9cVPMgbXCnlOic3bq7
         XXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6YNSoA5Dua0+s/FF7SpEIcKqn99xdL9v6a8e8wASjE=;
        b=jIbk90YdUXfXvJZ8ACJopqiFLW53MdJ1ZBNfinMfZzq1Q9dsnQc/MonA3T6WsAU7cO
         RVQKq2yvIyyM8DrG3mLon9itHq4PlxZgiTcG/hf+n1ee74HYm3h4KJsbEVgoVvxCrPsu
         cTzxpxs0RgpI3DgJX3FhgYrCmmuMALv9HQYwSDqRsCoRje6j34gus6G0J3/nnefiMrom
         bGQrAxDC/EJdkLqw1Lxr1+QQbg4zIebyGRExAUmQuvCCxn8rmENi4g0rLGeCAVoSm3xF
         ouA9g+/ip7jECnhJ3NNGm1cN7R43Y4qHc0A5kRjZ0NoP6Fyq48ZEoKaQubD2uVW+xHKa
         pDVw==
X-Gm-Message-State: AOAM530RVgx+jmsPzKj9Oqa0FkGjdL/YX4TxAB1Cfd9+9WnKj1jEQ/xs
        ZBnySnD8853MWCBnco9Z96cN9YfzowL9mF6Tj4g39n6z
X-Google-Smtp-Source: ABdhPJztZ9XbUj0FLLKnjaG49uOatzw5PqIll6Yx+Z6ecof8fZ/Xg+4CXVkwVcsz/BnqI+EDtAS88Q5dTYmp2/hyOH8=
X-Received: by 2002:a05:6000:156e:b0:20c:5218:8907 with SMTP id
 14-20020a056000156e00b0020c52188907mr24120425wrz.297.1652299596131; Wed, 11
 May 2022 13:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220510070140.45407-1-tomeu.vizoso@collabora.com>
 <20220510141329.54414-1-tomeu.vizoso@collabora.com> <CAPM=9tzLR-wsLhg2ikGjoK06s-ju5XWa1rtPPiUpN=pwD1vgtA@mail.gmail.com>
 <CAHk-=wg8YgH1h3wrm9CtXff7rSewa+NE0Z5upb1GOE8XiTL9HA@mail.gmail.com>
 <CAF6AEGusO9XAqHNatJLgV+wpVoyyLg1vHtUsnSkAxJeV7n3WNg@mail.gmail.com> <CAHk-=wjbE0f2AGroB1Hy=fx2fh7cRpS0wNdB46Ybk14Mb0b5Jw@mail.gmail.com>
In-Reply-To: <CAHk-=wjbE0f2AGroB1Hy=fx2fh7cRpS0wNdB46Ybk14Mb0b5Jw@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 11 May 2022 13:06:23 -0700
Message-ID: <CAF6AEGvNfC6=o63hH7eoSzT5JmF5C73sDyYXJj-hecS_cgRjHg@mail.gmail.com>
Subject: Re: Adding CI results to the kernel tree was Re: [RFC v2] drm/msm:
 Add initial ci/ subdirectory
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, May 11, 2022 at 11:40 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > It is missing in this revision of the RFC, but the intention is to
> > have the gitlab-ci.yml point to a specific commit SHA in the
> > gfx-ci/drm-ci[1] tree, to solve the problem of keeping the results in
> > sync with the expectations.  Ie. a kernel commit would control moving
> > to a new version of i-g-t (and eventually deqp and/or piglit), and at
> > the same time make any necessary updates in the expectations files.
>
> Wouldn't it then be better to just have the expectation files in the
> ci tree too?

The main reason is that we would frequently have situations where both
-next and -fixes pointing at the same ci tree commit, but with
differing expectations.  If we kept the expectations in the ci tree,
we'd end up frequently updating the ci tree and then updating the
kernel tree to point to the appropriate ci tree version.

Additionally, on the mesa side, it has been useful to squash the
expectations update into the commit that fixed a bug or added a
feature.  It provides a connection in git history between code and
test results.

BR,
-R
