Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF1571FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiGLPs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGLPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:48:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E982C54BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:48:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p27-20020a05600c1d9b00b003a2f36054d0so52442wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2nlWovdml3x38ikBsijP4iu2GVcLVtEJCFEUL/KVw7o=;
        b=l7epumwrTzHY/T/kgehRLD4WmQF+WOR5a1v/PiZIlCt0xOL8TbVuf2dOsADboZauYg
         yoHGQR9uyhRHNy5Z+nD+Yr/Q4cjuuoa9717gHmCsEmXCZ/rp5QqzsjCTFNVry0nBuUQs
         oNuoDRJgCp4nizfkUcp4m7npXsvxkMY4EcPEbXdtKtMaGrRwD85mdhlPbmIF6zfSi++s
         MNocdcQZIE4dJTnTes/KPHJRgRQ+FMrgxNsAtRDCoZVdJvj0T1yzqWZ/cFRMRp4d3UfS
         mwVBT0upNQxQC+KQnXKvDcnVv44yLYa7rwH++mX8p7TUCXdA7Gowr+9glk8fn+Chx/hG
         Nn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2nlWovdml3x38ikBsijP4iu2GVcLVtEJCFEUL/KVw7o=;
        b=bN8dzG5FiUtSFgFaq25VrbBMJBjneph4GXTI9z6cp6FUl0fxOlalmm/Sgrad4+xKc1
         Ny8XsJpRto4w9QjOzty9trm7QNX+8qzYMvQba9/4bfoPWzhVvILCYFZNgOrD1St2YFzl
         3LqVMPM0zzIzbHu07iIvsVZ35PNicsQtLmos6ZXwRmC25DR8OFMWQXM4IZiQXtDrex9Q
         dzbM9n3WpPqzyV1V4j1iAc6J7ARXDw0qMUIbCd5Oz+NmyaT6excK0Md/syt1Kn53Q7Wb
         wGAHDCDOlyNOt1D6UEoDAESAPVo0tTSnMffJZIcVP9Dkiq4SWEGd6+kny4f9PVuqVqIZ
         9IOA==
X-Gm-Message-State: AJIora+alQLwMoXTEj2GWNWd4QYCY3ZYdLGlSK0l6ZbJRHvO1vY3sT8T
        v1DDbQCQcyS41eFvVqSwcZSEZLE0ZZh8kNad4J+HBnQESg==
X-Google-Smtp-Source: AGRyM1u6t4VbjNJona2UEpNHlKP5wTHkHby6Ya+C9mPUk56Zqy7EeRgKiauK/i7GOVZQ7XHor7ObgQc+c29/qmHZ6+0=
X-Received: by 2002:a7b:cd0c:0:b0:3a2:e864:98b8 with SMTP id
 f12-20020a7bcd0c000000b003a2e86498b8mr4562927wmj.200.1657640899216; Tue, 12
 Jul 2022 08:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220712042258.293010-1-jstultz@google.com> <13c5ca05-a366-2751-4f26-d978d074f748@amd.com>
In-Reply-To: <13c5ca05-a366-2751-4f26-d978d074f748@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 12 Jul 2022 08:48:07 -0700
Message-ID: <CANDhNCp_d2M+n90T1ziP5rHF85ZsxyN6qg4iE84ucPO-XK_HUg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] drm: drm_syncobj: Add note in DOC about absolute
 timeout values
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Chunming Zhou <david1.zhou@amd.com>,
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

On Tue, Jul 12, 2022 at 12:40 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> Am 12.07.22 um 06:22 schrieb John Stultz:
> > After having to debug down through the kernel to figure out
> > why my _WAIT calls were always timing out, I realized its
> > an absolute timeout value instead of the more common relative
> > timeouts.
> >
> > This detail should be called out in the documentation, as while
> > the absolute value makes sense here, its not as common for timeout
> > values.
>
> Well absolute timeout values are mandatory for making -ERESTARTSYS work
> without any additional handling.

Yes! I'm not saying it's wrong to use absolute values, just that
relative values are common enough to create some confusion here.

> So using them is recommended for ~20 years now and IIRC even documented
> somewhere.

So in addition to "somewhere", why not in the interface documentation as we=
ll?

> See here as well https://lwn.net/Articles/17744/ how much trouble system
> calls with relative timeouts are.

Yep. Well aware. :)

thanks
-john
