Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135F523422
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiEKNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243843AbiEKNVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:21:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966B4507F;
        Wed, 11 May 2022 06:20:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i5so2930983wrc.13;
        Wed, 11 May 2022 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxBAEgkqPwjl7j2IRT0qwSbmvKmtMj9Uu/0rfJ9C3HY=;
        b=BFtrKj/WbzGddmQvEk3VMnzWRw/Gm8bqNWgAL4/V5F5ORGU/W+I2X+NRXETzGq4amf
         6zH2AEWErpG7i8W7RiUS4//aVUpKqlh0Sr/aMR+7ASspn0/PCyZ03Qdvt0F+2t48G/kq
         5CCvXmXubgkQQZvMu0/F4ff5eesEhAHHwFAWhJYWcFHKLwjlOa26aQT/lAOB2i18VVYN
         5QtKqLq4MZW7MZONTfYwK+HQBCO0oh6XpFj90Ac2Hlf8u2LliKuINKVPSPPTpyYgnm5R
         qyl64VtVW2CszZWmkOjshlLFYkcQVOBoXLciBSPETQvRTgDhgJDodoxEzbMVqqSzhQq7
         F7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxBAEgkqPwjl7j2IRT0qwSbmvKmtMj9Uu/0rfJ9C3HY=;
        b=4qm8l33olZrcGsnsIzuGdNiqJe0fssUC3Z0Ksa13XkMYEU36yZexRSchvNdB6TFNIG
         mZSKLo92MecxLcKxvmYTk2GBfa795dJaNYAnXW1rVOPujh/IlBRM0T9LIRJG522gYI7X
         GJeDKZKdckR89y/my8caoS+kfWsCkthUbnDxa+uBggDb8XOTVPsL00uD847iQlicpXtY
         irn7yNx4IN6V08/NMlLv2yvsL2BlxtE4ZNNp6ECEpPn9RgoSp/ADwag+SKXlGHtGum+6
         JLuXaGUi8OH1F+w3litIguEdNI/qrj4nwE4eXrwvmcFusaPGtXObFGivTY4QUk46SZ0M
         BT0g==
X-Gm-Message-State: AOAM530jsTnVzImicnzxCmB80j9LMPc8TbhnFp46sWFTxXFHdGgEFsRH
        ZExa0fNc7m9zZ+gcVD1wW0Kd2YBDB6gwoep2UU8cVeSb
X-Google-Smtp-Source: ABdhPJwMEuHOME5RAqLJg1dKTW2d5wEp9Fa+vDbBzf5cIsjIT1fvYzWr1ATGYW77vkjZEgwUvYYcJm1ccXNbRGIpIUw=
X-Received: by 2002:a05:6000:1a87:b0:20c:687f:6d10 with SMTP id
 f7-20020a0560001a8700b0020c687f6d10mr22188924wry.574.1652275246816; Wed, 11
 May 2022 06:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220510141329.54414-1-tomeu.vizoso@collabora.com> <20220511061533.56881-1-tomeu.vizoso@collabora.com>
In-Reply-To: <20220511061533.56881-1-tomeu.vizoso@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 11 May 2022 06:20:36 -0700
Message-ID: <CAF6AEGts6cKOrmRruo8uSXSW=Kq58VZxdPuS13Q7jVajbvga-g@mail.gmail.com>
Subject: Re: [RFC v3] drm/msm: Add initial ci/ subdirectory
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:15 PM Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
>
> And use it to store expectations about what the drm/msm driver is
> supposed to pass in the IGT test suite.
>
> Also include a configuration file that points to the out-of-tree CI
> scripts.
>
> By storing the test expectations along the code we can make sure both
> stay in sync with each other, and so we can know when a code change
> breaks those expectations.
>
> This will allow all contributors to drm/msm to reuse the infrastructure
> already in gitlab.freedesktop.org to test the driver on several
> generations of the hardware.
>
> v2:
>   - Fix names of result expectation files to match SoC
>   - Don't execute tests that are going to skip on all boards
>
> v3:
>   - Remove tracking of dmesg output during test execution
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  Documentation/gpu/msm_automated_testing.rst   |  70 +++++++++
>  drivers/gpu/drm/msm/ci/gitlab-ci.yml          |  11 ++
>  drivers/gpu/drm/msm/ci/msm.testlist           | 144 ++++++++++++++++++
>  .../gpu/drm/msm/ci/msm_apq8016_results.txt    | 141 +++++++++++++++++
>  .../gpu/drm/msm/ci/msm_apq8096_results.txt    | 141 +++++++++++++++++
>  drivers/gpu/drm/msm/ci/msm_sc7180_results.txt | 142 +++++++++++++++++
>  drivers/gpu/drm/msm/ci/msm_sdm845_results.txt | 142 +++++++++++++++++
>  7 files changed, 791 insertions(+)
>  create mode 100644 Documentation/gpu/msm_automated_testing.rst
>  create mode 100644 drivers/gpu/drm/msm/ci/gitlab-ci.yml
>  create mode 100644 drivers/gpu/drm/msm/ci/msm.testlist
>  create mode 100644 drivers/gpu/drm/msm/ci/msm_apq8016_results.txt
>  create mode 100644 drivers/gpu/drm/msm/ci/msm_apq8096_results.txt
>  create mode 100644 drivers/gpu/drm/msm/ci/msm_sc7180_results.txt
>  create mode 100644 drivers/gpu/drm/msm/ci/msm_sdm845_results.txt
>

[snip]

> diff --git a/drivers/gpu/drm/msm/ci/gitlab-ci.yml b/drivers/gpu/drm/msm/ci/gitlab-ci.yml
> new file mode 100644
> index 000000000000..9b7caa7fcab2
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/ci/gitlab-ci.yml
> @@ -0,0 +1,11 @@
> +variables:
> +  # Change this to use your fork of drm-ci
> +  DRM_CI_PROJECT_PATH: &drm-ci-project-path gfx-ci/drm-ci
> +  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha msm

btw, shouldn't we list an exact commit sha (or tag) for drm-ci, or am
I overlooking something?  We want to be able to uprev the drm-ci
version (and therefore igt version) in sync with any necessary updates
to the expectations

BR,
-R

> +
> +include:
> +  - project: *drm-ci-project-path
> +    ref: *drm-ci-commit-sha
> +    file:
> +      - '.msm-gitlab-ci.yml'
> +      - '.gitlab-ci.yml'
