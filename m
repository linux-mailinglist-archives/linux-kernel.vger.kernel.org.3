Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521F24BBBC7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiBRPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:04:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiBRPEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:04:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF84B29720E;
        Fri, 18 Feb 2022 07:04:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D8F561D5A;
        Fri, 18 Feb 2022 15:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B0EC340EF;
        Fri, 18 Feb 2022 15:04:29 +0000 (UTC)
Message-ID: <58bfb1fb-431d-a47d-ee9e-fbef89a700a0@xs4all.nl>
Date:   Fri, 18 Feb 2022 16:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 0/4] Add V4L stateless video decoder API support to
 NVIDIA Tegra driver
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207141937.13089-1-digetx@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220207141937.13089-1-digetx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

On 07/02/2022 15:19, Dmitry Osipenko wrote:
> Support V4L stateless video decoder API by NVIDIA Tegra decoder driver.
> Tested using GStreamer [1] and libvdpau-tegra [2][8].
> 
> [1] https://github.com/grate-driver/gstreamer/commit/b8509bdbb69b534e61419ea1798f32f9ad2f3597
> [2] https://github.com/grate-driver/libvdpau-tegra/commit/f822e95911e5e0c39f8ba19f843ddc1e0138d5ce
> [8] https://github.com/grate-driver/libvdpau-tegra/commit/80db4d02369f2a984ce3173d6bc305f32e9fdb97

Nice work!

Can you make a v4 that just moves the whole driver to drivers/media/platform? I see no
reason for keeping this in staging.

Once I have a v4 that does that I plan to make a PR for it.

For the v4 don't forget to update MAINTAINERS with the new path and to drop the TODO
file in staging.

Regards,

	Hans

> 
> Changelog:
> 
> v3: - Added new decode_params flags [7] instead of V4L2_BUF_FLAG_*FRAME flags,
>       as was suggested by Nicolas Dufresne.
> 
>       [7] https://github.com/grate-driver/gstreamer/commit/c5cd847f9c26b7669720ae58f9058de2515f51a2
> 
>     - Added new patch that removes legacy UAPI.
> 
> v2: - Made V4L2_BUF_FLAG_*FRAME flags mandatory [3] and dropped reading
>       of raw bitstream from the driver code, as was suggested by
>       Nicolas Dufresne.
> 
>       [3] https://github.com/grate-driver/gstreamer/commit/aee292f0f2e84b7654a314dd7e63f916888ffaa5
> 
>     - Ran v4l2-compliance [4] and fluster [5][6] tests, like was suggested by
>       Nicolas Dufresne. Fixed minor v4l2-compliance errors that were related
>       to a partial initialization of the coded format and were harmless in
>       practice, but made compliance checker unhappy.
> 
>       [4] https://gist.github.com/digetx/5d6bcdab633488f1dcc7c141ab90d30e
>       [5] https://gist.github.com/digetx/b06c5d779e9d25afa41d9f46946fe399
>       [6] https://gist.github.com/digetx/ac4198bc340e5065aa8ec3288bb21356
> 
> Dmitry Osipenko (4):
>   media: v4l2-ctrls: Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags
>   media: staging: tegra-vde: Factor out H.264 code
>   media: staging: tegra-vde: Support V4L stateless video decoder API
>   media: staging: tegra-vde: Remove legacy UAPI support
> 
>  .../media/v4l/ext-ctrls-codec-stateless.rst   |    6 +
>  drivers/staging/media/tegra-vde/Kconfig       |    7 +
>  drivers/staging/media/tegra-vde/Makefile      |    2 +-
>  .../staging/media/tegra-vde/dmabuf-cache.c    |    2 +-
>  drivers/staging/media/tegra-vde/h264.c        |  946 +++++++++++++++
>  drivers/staging/media/tegra-vde/iommu.c       |    2 +-
>  drivers/staging/media/tegra-vde/uapi.h        |   73 --
>  drivers/staging/media/tegra-vde/v4l2.c        | 1018 +++++++++++++++++
>  drivers/staging/media/tegra-vde/vde.c         |  945 ++-------------
>  drivers/staging/media/tegra-vde/vde.h         |  121 +-
>  include/uapi/linux/v4l2-controls.h            |    2 +
>  11 files changed, 2170 insertions(+), 954 deletions(-)
>  create mode 100644 drivers/staging/media/tegra-vde/h264.c
>  delete mode 100644 drivers/staging/media/tegra-vde/uapi.h
>  create mode 100644 drivers/staging/media/tegra-vde/v4l2.c
> 

