Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81814B7331
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiBOQPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:15:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbiBOQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:15:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB7E02F5;
        Tue, 15 Feb 2022 08:14:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p9so12448704wra.12;
        Tue, 15 Feb 2022 08:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=csNEKQKXZYs0Wbz+5J/UFBhsGdQCNtddqOoWSf3udBI=;
        b=VZ17/1E4s5XtF6FccGvOhBXz1wTXHx2fZTDNfE3vILbAIRMnAarfPPoyoh5VzG/MxU
         IOYglvaCFW7BRkmJWr69+DCG9MdH1KRXNo1hTok+9F+ndUZb+cw/EZAPB53lB0KOMMvd
         678woltWRAJcJK/myzihqagX220S/me09FooDgOTYgWBL412by8XlDhmGECO+C5iG1vs
         wW1AJjIlxzPUoasVOV2+kBrPCd9fKZj73eGBEEtaMi7DIxQ3wM0jlECoXSz2BbF9rHPv
         2ghBOtqsH7YPkeezizuFl/p37DGK7yxUhvg6BKo879YvWuMO0t95XPe09u2cf24LAUdz
         aNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csNEKQKXZYs0Wbz+5J/UFBhsGdQCNtddqOoWSf3udBI=;
        b=HX5DA29/ReSkwRa4tzYVazuacSEGxTlJtKWCVcirYROcCFpbmcTYky1JyiLaIDQvAQ
         je4wqS253C1mFPz+jEHdaoAd/tvAThHOgZl7R6MxPjLZ1Vm5P5Ho5w4PZgCacHjOH4Ef
         Lyb8KoyPHpO5SMuAWMgcaJGn29sq/Xqvb3N/z/Ne0oqPaJ7rc2zWWHD/oIurmzdwauTS
         inZh27yuMgrUym0JCT0RHdXtOUiMmH/kALORmrbWWHnyXvwegcGFQMizdG0/IjmLj/+F
         BetkPAavcmrWqX14oTH24SRJMzWRlavXIgzUFG5058mwXT6SuuG8pgKjYB1LVbh/RjCf
         ql8A==
X-Gm-Message-State: AOAM532SQCuyWR2C4DNNKIHU9YNOJVqW0yk82/+vn9KETL/aMarg+slp
        0hyoX5dvHR7EnSPpdmLUQxY=
X-Google-Smtp-Source: ABdhPJzGh6/pqxlCvaSd1g20cak5NbmWfQheK5MBk8dXKrdh23qIZCAK5ZLWnt0SRgOimwDeSP3qfw==
X-Received: by 2002:a05:6000:24a:: with SMTP id m10mr3859914wrz.367.1644941689955;
        Tue, 15 Feb 2022 08:14:49 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id l26sm14990465wmp.31.2022.02.15.08.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:14:49 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        hverkuil-cisco@xs4all.nl, jonas@kwiboo.se, nicolas@ndufresne.ca,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [RFC v2 0/8] Move HEVC stateless controls out of staging
Date:   Tue, 15 Feb 2022 17:14:48 +0100
Message-ID: <14572059.tv2OnDr8pf@kista>
In-Reply-To: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin!

Dne torek, 15. februar 2022 ob 12:00:55 CET je Benjamin Gaignard napisal(a):
> This series aims to make HEVC uapi stable and usable for hardware
> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
> and 2 out of the tree drivers (rkvdec and RPI).
> 
> The 3 first patches are from Hans to implement v4l2 dynamic control
> feature which is need by patch 7 for 
V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET
> definition.

Great, I'll test this soon on Cedrus, but I can't promise it will be this 
week.

> 
> Patch 4 move the existing uapi to stable, including definitions renaming 
> and CID number change to fit with v4l2 naming.

This should be last patch in series, otherwise you're changing stable uAPI, 
even if only few commits later.

Best regards,
Jernej

> 
> Patches 5 and 7 add fields needed for rkvdec and RPI decoders.
> 
> Patches 6 is cleaning up the uapi of useless field.
> Patches 8 change one field description and name to define offset by
> bytes rather than by bits
> 
> Benjamin
> 
> Benjamin Gaignard (5):
>   media: uapi: Move HEVC stateless controls out of staging
>   media: uapi: Add fields needed for RKVDEC driver
>   media: uapi: Remove bit_size field from v4l2_ctrl_hevc_slice_params
>   media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
>   media: uapi: Change data_bit_offset definition
> 
> Hans Verkuil (3):
>   videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>   v4l2-ctrls: add support for dynamically allocated arrays.
>   vivid: add dynamic array test control
> 
>  .../userspace-api/media/drivers/hantro.rst    |   5 -
>  .../media/v4l/ext-ctrls-codec.rst             |  58 ++--
>  .../media/v4l/vidioc-queryctrl.rst            |   8 +
>  .../media/test-drivers/vivid/vivid-ctrls.c    |  15 ++
>  drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++++++--
>  drivers/media/v4l2-core/v4l2-ctrls-core.c     | 182 ++++++++++---
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  32 +--
>  drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
>  drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
>  drivers/staging/media/hantro/hantro_drv.c     |  27 +-
>  drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  |  13 +-
>  include/linux/hantro-media.h                  |  17 ++
>  include/media/hevc-ctrls.h                    | 250 ------------------
>  include/media/v4l2-ctrls.h                    |  48 +++-
>  include/uapi/linux/v4l2-controls.h            | 224 ++++++++++++++++
>  include/uapi/linux/videodev2.h                |   8 +
>  19 files changed, 640 insertions(+), 408 deletions(-)
>  create mode 100644 include/linux/hantro-media.h
>  delete mode 100644 include/media/hevc-ctrls.h
> 
> -- 
> 2.32.0
> 
> 
> 


