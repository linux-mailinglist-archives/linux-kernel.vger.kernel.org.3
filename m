Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA02450F027
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbiDZFXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiDZFXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:23:34 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FE0DEE5;
        Mon, 25 Apr 2022 22:20:27 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id q2so2555364vsr.5;
        Mon, 25 Apr 2022 22:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmipgUUMUxm6hMiwU+RA9EjYQMfT2FPr6LOz5agz4nY=;
        b=YReamCBovqxWJMpctPfDpKZNrx1dmPy/xjCTi+m48IelAKatIYLGf3lCKhKQFPrsgZ
         AsDjGq/B7lC/s/JDzPp/2t3Id3Z4WppDo5cfo0N1xS9bcRDTjSMFMmregTw0QqtHUT5+
         QqTubU+P2H7VCCr/CXPw+q2O7r2G6RaT7rU8Rjww1FVngj29exEVbfRnwW9XMQisQ2fP
         T3So57d/E5ftsGh1/V159jPSYVkNlCk2m4hH1uj5zv+pazl5KzRgbryKHTc3uK5Q0gDV
         HCXHahhWEwRey/g5xxUpmiNIYc2g1oIAOmIcCcwnekFqEk0bOQaQNjzWmgIntpiCoe4/
         CtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmipgUUMUxm6hMiwU+RA9EjYQMfT2FPr6LOz5agz4nY=;
        b=1NUg9Dxy9ZIRY9gVdhPd8bERBccHm47mCEXV7KUKyPKlFI1Tsq2PELhOafmfhxBPVG
         11L5yaih4mZLjLtlRBGfCV9gy44JIRI05+WxEGkeF0V6YarnMBBbS3VT3ATamh6H6taj
         vm44iEsq4vF/Nvyv9UgASPTDZyLy6MARsil6kvLrnolOQPqqVTuG8eGw0S2ET61WQGZK
         ycPOlJHLi6RSjX4q3gbffHgUV6fIPTfXmrB7BNfIH0mhbkBms4+AnZ98HjUkyPNybVFW
         mglyipBJ3YaOw3V0CM8G8aB1Ce8a2Q1yXoxcItZ2mj9bGmPCJBlscBlYEO8jnRu2qlN0
         /ubw==
X-Gm-Message-State: AOAM532w4Cw18L/no1D+D5HSJUqzpcg+g2Sl5XkLo+UeGNldSAq+sBwP
        x5bU90SoeCV8dNjLZyF+HFlH0aljSkR1XoocBxA=
X-Google-Smtp-Source: ABdhPJwW7mSpFATTE7BSdK+yHISsvHvDyufD5OFhDBveJm9IFoOlVggyKp3WbRiXt2XfYMoessN1mzZ2tYzvpxGGMho=
X-Received: by 2002:a67:dd03:0:b0:32c:a569:4f17 with SMTP id
 y3-20020a67dd03000000b0032ca5694f17mr4129187vsj.86.1650950426553; Mon, 25 Apr
 2022 22:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220419135908.39606-1-cai.huoqing@linux.dev>
In-Reply-To: <20220419135908.39606-1-cai.huoqing@linux.dev>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Tue, 26 Apr 2022 06:20:14 +0100
Message-ID: <CALeDE9NJcruoVU1v0uG2GSJFoPbsob+YTzW94wG2+DbPiu2xKA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/nvdla: Add driver support for NVDLA
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 3:08 PM Cai Huoqing <cai.huoqing@linux.dev> wrote:
>
> The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
> which is integrated into NVIDIA Jetson AGX Xavier,
> so add driver support for this accelerator.
>
> NVDLA introduce:
> http://nvdla.org/primer.html
>
> User mode driver:
> https://github.com/caihuoq/nvdla/tree/main/sw/umd
>
>
> Cai Huoqing (2):
>   MAINTAINERS: Add the driver info of the NVDLA
>   drm/nvdla: Add driver support for NVDLA

Are there device tree bindings that are required to test this IP, are
there additions for the Xavier SoCs to test them? They should also be
published as patches as part of this series.

>  MAINTAINERS                             |    7 +
>  drivers/gpu/drm/Kconfig                 |    2 +
>  drivers/gpu/drm/Makefile                |    1 +
>  drivers/gpu/drm/nvdla/Kconfig           |    8 +
>  drivers/gpu/drm/nvdla/Makefile          |   19 +
>  drivers/gpu/drm/nvdla/nvdla_bdma.c      |  200 +
>  drivers/gpu/drm/nvdla/nvdla_cache.c     |  215 +
>  drivers/gpu/drm/nvdla/nvdla_cdp.c       |  300 ++
>  drivers/gpu/drm/nvdla/nvdla_common.c    |  295 ++
>  drivers/gpu/drm/nvdla/nvdla_common.h    |  835 +++
>  drivers/gpu/drm/nvdla/nvdla_conv.c      |  683 +++
>  drivers/gpu/drm/nvdla/nvdla_drm.c       |  695 +++
>  drivers/gpu/drm/nvdla/nvdla_drm.h       |  127 +
>  drivers/gpu/drm/nvdla/nvdla_engine.c    |  233 +
>  drivers/gpu/drm/nvdla/nvdla_engine.h    |  272 +
>  drivers/gpu/drm/nvdla/nvdla_gem.c       |  393 ++
>  drivers/gpu/drm/nvdla/nvdla_ioctl.h     |   99 +
>  drivers/gpu/drm/nvdla/nvdla_pdp.c       |  446 ++
>  drivers/gpu/drm/nvdla/nvdla_reg.h       | 6411 +++++++++++++++++++++++
>  drivers/gpu/drm/nvdla/nvdla_rubik.c     |  217 +
>  drivers/gpu/drm/nvdla/nvdla_sched.h     |   52 +
>  drivers/gpu/drm/nvdla/nvdla_scheduler.c | 1005 ++++
>  drivers/gpu/drm/nvdla/nvdla_sdp.c       |  728 +++
>  23 files changed, 13243 insertions(+)
>  create mode 100644 drivers/gpu/drm/nvdla/Kconfig
>  create mode 100644 drivers/gpu/drm/nvdla/Makefile
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_bdma.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_cache.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_cdp.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_common.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_common.h
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_conv.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_drm.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_drm.h
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_engine.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_engine.h
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_gem.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_ioctl.h
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_pdp.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_reg.h
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_rubik.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_sched.h
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_scheduler.c
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_sdp.c
>
> --
> 2.25.1
>
