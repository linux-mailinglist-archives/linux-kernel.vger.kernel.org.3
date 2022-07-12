Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05E1571FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiGLPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiGLPxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:53:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618ABA143
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:53:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so5066627wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zsJYeJMzYlfchoyhqcYMlXXcIufBbaJhfBIHb8zwwSQ=;
        b=gw/KFQdJ9JRUU7g6lqNSyqfre+WjyR6C5Q8qOW1vetF8YDFm+o9PnNOj4OiYiW+4jM
         21ozEHT0wjlMx1wqfYwIrj+cDyDvYKW+jLGW0Vp1qID4hDCOs28hmMYB1rGA4EAx2oj7
         3hOOoMJkILQEr6BgSPoO/xi8TShwptp8t2Ey85OIU48Bs6qdkWHO8+eeWXUw+ZHdLwRq
         Qs0kdw4JZHYNvmTybTfm3otKNdz4gOQUzVrQjimJK9rwCwHyYOatS/82WBU3NBHgUW2/
         5kuGS74i0LhQafgbgONlgnpqmnZwubk6GRCCSqQYxkT2OChP6ZxkMf61QP8MZgviGugt
         WQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zsJYeJMzYlfchoyhqcYMlXXcIufBbaJhfBIHb8zwwSQ=;
        b=yc2bwUZs/ciXV2/UH7Xef9GIOqfW/OKFsbmCUv9K9vJ28b7cOzFYT+sQBYHt1gErSg
         UUI4j8SMxE5zBMA4Pe6e3ljpLXTf6N397njDLU5j1O0++TIA18BxR7JdDZpEB1JvNiJu
         XC2hIoAcMZlvi3uHJvZxUSpQGXpwfvl5Y71BhYYeuxSLvlD7Cw/mJhVRtucV+q8iMWn3
         iVj4obsm4eG1l/vQSEWghCT5BGO5fDkGuqh0Q2ub1trS2J9x6aX0R6R/NK6fSmDgUR5U
         JEQeprjyzPLllFuGuoOabjIBB0P6YydptJj+w3OEZgc+sIiwzixp3ubVgPIDC+4gS9ox
         suug==
X-Gm-Message-State: AJIora9OxcKuq2l4MaIWT4Xac7e+7rY6aIIRvQq0DUG8AzFJj8TVeJ2N
        E8/QpQ5j68g948yARFRT+GvFHYCTNKgLeoMeD+qV
X-Google-Smtp-Source: AGRyM1t+yrnEq9cKm/OAPFzrU5umggLNBl1nhf3RM8sC1K9l5Y10G/Ylf/WpJKAFTrggYCcyC1Nz2OO5uvyvyqG6STU=
X-Received: by 2002:a05:600c:3b03:b0:3a2:ead2:c844 with SMTP id
 m3-20020a05600c3b0300b003a2ead2c844mr4600729wms.129.1657641184963; Tue, 12
 Jul 2022 08:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220712042258.293010-1-jstultz@google.com> <20220712042258.293010-3-jstultz@google.com>
 <44e2cb41-641c-2a50-3e38-284e4504f012@amd.com>
In-Reply-To: <44e2cb41-641c-2a50-3e38-284e4504f012@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 12 Jul 2022 08:52:53 -0700
Message-ID: <CANDhNCrPhJacBjQZ4DMhmo9iaxBov8m8tbTqdU07PheaKFbE-g@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/3] kselftest: Add drm_syncobj API test tool
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Chunming Zhou <david1.zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Shuah Khan <shuah@kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:43 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> Am 12.07.22 um 06:22 schrieb John Stultz:
> > An initial pass at a drm_syncobj API test.
> >
> > Currently covers trivial use of:
> >    DRM_IOCTL_SYNCOBJ_CREATE
> >    DRM_IOCTL_SYNCOBJ_DESTROY
> >    DRM_IOCTL_SYNCOBJ_HANDLE_TO_FD
> >    DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE
> >    DRM_IOCTL_SYNCOBJ_WAIT
> >    DRM_IOCTL_SYNCOBJ_RESET
> >    DRM_IOCTL_SYNCOBJ_SIGNAL
> >    DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT
> >    DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL
> >
> > And demonstrates how the userspace API can be used, along with
> > some fairly simple bad parameter checking.
> >
> > The patch includes a few helpers taken from libdrm, as at least
> > on the VM I was testing with, I didn't have a new enough libdrm
> > to support the *_TIMELINE_* ioctls. Ideally the ioctl-helper bits
> > can be dropped at a later time.
> >
> > Feedback would be appreciated!
>
> DRM userspace selftests usually go either into libdrm or igt and not
> into the kernel source.

Appreciate the pointer, I'll rework and submit to one of those projects.

thanks
-john
