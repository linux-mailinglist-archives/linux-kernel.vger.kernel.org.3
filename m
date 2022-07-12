Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FEE5711D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiGLF3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGLF3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:29:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC265C362
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:29:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 9-20020a1c0209000000b003a2dfdebe47so3300886wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Io6RTZE60SvPtzfl8Dwm+AesX4Q9CRLNrTuqz3l+qg0=;
        b=Qy2pxTIDUhMcsrUj9m9+hKPul6UxVB+rIB5xK1BX53iPqa4Kj/PE67MjJsTMNkepFs
         C3Hg07/0BMsdINcb+ODlseHtuCnrkWEnUAIzVa5/vjLkhOgjvcqTJcbNiaBNNVnBifB3
         70dBirHYnACWQ/iJuTGwU9BSTP9l+HheELEyKL8skCvIx5OGrsqQjCBZYTVVAz96SI6g
         KCE1eqBa2i4GLSOStPR80aBR1Rwkwtej10rTgAf05wH3i6g7z5rIM99Uzu4AXZ3ByqHT
         KwvUC99jMfOJOYSJGhpl4IQjG/tXUKoZ+tDn9D+fCBV5ngFDEpttivrImYgsYTU6JdiU
         0GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Io6RTZE60SvPtzfl8Dwm+AesX4Q9CRLNrTuqz3l+qg0=;
        b=HdCyFBrTXtNoPH4PueDHHZcLmNXG2Mw0yNaU+tKeDBF1BUCv7KeHZmij8hArQCHK6+
         9EweTVZzbAq+jSDrd0z4DBb5z2JSvO/CZs4JDWciaS/VHTok+PqX6UhhA+kP9jci0m0e
         T2ukAUTLJClR00KNBWU/t2SEy/tJb0xU/ON1RbtTQ1if3Xz0O48r3Zc4OuOHd02bUFqh
         kaZf/WS+GdJ1mbCJwKnuEClc2veN6cpJ5FqrnmdAp3b8kr8aODLOgPD4bnOcshHNrNw2
         5QmeSJpBWU2v5Ot61ppCuYDuu1k17qVbioB4C4KhdnkFm8KUm0QmvcD/kHmubQ1cD4IX
         v6UQ==
X-Gm-Message-State: AJIora8hWovfQRUyDXaM9rnbqFohFhXIH+MfQ39GhLTAeArbIgV65VIS
        ROrqb8y4AP7DR22t7dxSJv3gwlRtnqqv+dfef79dbFsm3IpJ
X-Google-Smtp-Source: AGRyM1uoa3h801J1LOR4UOkbUc3ab3I4GoLHFV24M189awXOGbaMINiGcQqFZ7RZGX/UyNDGs84MIhCLAx3C16hS9VU=
X-Received: by 2002:a7b:cb8e:0:b0:3a2:da0f:d8ae with SMTP id
 m14-20020a7bcb8e000000b003a2da0fd8aemr1847538wmi.23.1657603754324; Mon, 11
 Jul 2022 22:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220712042258.293010-1-jstultz@google.com>
In-Reply-To: <20220712042258.293010-1-jstultz@google.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 11 Jul 2022 22:29:02 -0700
Message-ID: <CANDhNCrq16wedmvZbvyRzwVaLmc1STmAzv0nBLOcVnz-SRf4Bg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] drm: drm_syncobj: Add note in DOC about absolute
 timeout values
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jason Ekstrand <jason@jlekstrand.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

On Mon, Jul 11, 2022 at 9:23 PM John Stultz <jstultz@google.com> wrote:
>
> After having to debug down through the kernel to figure out
> why my _WAIT calls were always timing out, I realized its
> an absolute timeout value instead of the more common relative
> timeouts.
>
> This detail should be called out in the documentation, as while
> the absolute value makes sense here, its not as common for timeout
> values.
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jason Ekstrand <jason@jlekstrand.net>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Cc: Chunming Zhou <david1.zhou@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.=
c
> index 7e48dcd1bee4..b84d842a1c21 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -136,6 +136,10 @@
>   * requirement is inherited from the wait-before-signal behavior require=
d by
>   * the Vulkan timeline semaphore API.
>   *
> + * It should be noted, that both &DRM_IOCTL_SYNCOBJ_WAIT and
> + * &DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT takes an *absolute* CLOCK_MON=
OTONIC

Gah. That should be &DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT. I must have
pasted in the wrong symbol.

Fixed in my tree and I'll share v2 in a few days so I can get
additional feedback.

thanks
-john
