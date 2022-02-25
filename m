Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743E4C4ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiBYTdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiBYTds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:33:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113941986F0;
        Fri, 25 Feb 2022 11:33:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d17so5942618wrc.9;
        Fri, 25 Feb 2022 11:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTabVBpdhiK8UZ6gYY0q0CbgdkcTzXpvDDahteadHtk=;
        b=KqEfD0QFY48L5w9MBf4PJotkLP+NQN3xHmZQkR/HYQfcDqhuBk/QSn0Zyc4vZOsRvd
         XqkzUYrkLvkyTkQPBAmA5aT28iuddvEajLv8Bcw38sfLscC4/I3Q90AWOWIyC6E2csW9
         VqsIJausYk4BR8HMZgPd7G9EVuEPOBoMegz1lEfLVsFTbgs6TPFUJAt+zWcu6vsc2+Ab
         mYU+UPAVgzwb5ki5lfDIkSUglJZQpsUBeKI0F1qKYqB8rXHdmt+8NtHC4OHT1dSKQfz6
         z9JHi+2Kpm+ZbbCzq3U4aby39rvc8qSdwtkd1QfaZD65Uumb9VMs4+nFjxihf43YmPIL
         MOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTabVBpdhiK8UZ6gYY0q0CbgdkcTzXpvDDahteadHtk=;
        b=JyoIHsTwI3Aj2DdUgbAXJ6iPbf9C70cbn2hCXMx7EBAfMO/f7Pj+HlyCFWzvUQk9hT
         F2K5UFDXLHoIuUzdzdKNajP02HTiTfkZFx0Zm2G/apE4otowReoYzJKrlFohqdcy+4kZ
         l9ZQ/9gauH4Gmn5rj50SX9s47rykEE2cRzBHibc+PR/b+DswPtKcXilWDxEhnWiQSJMU
         aToKEXgmBCw7J85cfjxLsxWfA9QQpomT3Ikr8/gCPGzcJJbVBpVtdwWZNTH3WcaPu/o1
         1tHBu6uMVy4wljQWX0TQoezvikr5krexs4wgPLs1NLtDdO7NITOqbiQd3FXq+ALpyFny
         CMeA==
X-Gm-Message-State: AOAM532vKvUucHfpQqnPF/OKPBcYI9nzCifDZ49DwidwB76TOZHa7IYr
        OsgYKkfBuLBmkxQ80VNNlDM=
X-Google-Smtp-Source: ABdhPJyGFJ0ColLkne3T6BJpK+32d8j6YcS3hAhC7NRH0q1U0DWrDs5cqK3liozxoNnjPv3lwXBTMA==
X-Received: by 2002:a5d:4d4a:0:b0:1ec:fab3:61bb with SMTP id a10-20020a5d4d4a000000b001ecfab361bbmr5128965wru.50.1645817593652;
        Fri, 25 Feb 2022 11:33:13 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id w26-20020a7bc11a000000b0037bf8fa8c02sm3240281wmi.13.2022.02.25.11.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:33:13 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jonas@kwiboo.se, nicolas@ndufresne.ca,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v3 00/14] Move HEVC stateless controls out of staging
Date:   Fri, 25 Feb 2022 20:33:12 +0100
Message-ID: <1807725.tdWV9SEqCh@kista>
In-Reply-To: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
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

Dne petek, 25. februar 2022 ob 17:45:46 CET je Benjamin Gaignard napisal(a):
> This series aims to make HEVC uapi stable and usable for hardware
> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
> and 2 out of the tree drivers (rkvdec and RPI).
> 
> After the remarks done on version 2, I have completely reworked to patches 
> split so changelogs are meaningless. I have also drop "RFC" from the
> titles.
> 
> In this v3 I do all the changes (new controls, documentation, etc..)
> in the staging directory before moving the HEVC uAPI to stable 
> steps by steps (unlike the big one patch in v2).
> 
> At the end fluster tests results on IMX8MQ is 77/147 for HEVC codec.

I'm working on PoC code for V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET on 
Cedrus, which should be finished over weekend.

Note: git am complained about trailing spaces. Run scripts/checkpatch.pl --
strict on patches before sending next round.

Best regards,
Jernej

> 
> Benjamin
> 
> Benjamin Gaignard (11):
>   media: uapi: HEVC: Add missing fields in HEVC controls
>   media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
>     prefix
>   media: uapi: HEVC: Add document uAPI structure
>   media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a
>     dynamic array
>   media: uapi: Move parsed HEVC pixel format out of staging
>   media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
>   media: uapi: Move the HEVC stateless control type out of staging
>   media: controls: Log HEVC stateless control in .std_log
>   media: uapi: Create a dedicated header for Hantro control
>   media: uapi: HEVC: fix padding in v4l2 control structures
>   media: uapi: move HEVC stateless controls out of staging
> 
> Hans Verkuil (3):
>   videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>   v4l2-ctrls: add support for dynamically allocated arrays.
>   vivid: add dynamic array test control
> 
>  .../userspace-api/media/drivers/hantro.rst    |   5 -
>  .../media/v4l/ext-ctrls-codec-stateless.rst   | 831 ++++++++++++++++++
>  .../media/v4l/ext-ctrls-codec.rst             | 780 ----------------
>  .../media/v4l/pixfmt-compressed.rst           |   7 +-
>  .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
>  .../media/v4l/vidioc-queryctrl.rst            |   8 +
>  .../media/videodev2.h.rst.exceptions          |   5 +
>  .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
>  drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++-
>  drivers/media/v4l2-core/v4l2-ctrls-core.c     | 198 ++++-
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  32 +-
>  drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
>  drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
>  drivers/staging/media/hantro/hantro_drv.c     |  27 +-
>  drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>  include/media/hevc-ctrls.h                    | 250 ------
>  include/media/v4l2-ctrls.h                    |  48 +-
>  include/uapi/linux/hantro-media.h             |  19 +
>  include/uapi/linux/v4l2-controls.h            | 436 +++++++++
>  include/uapi/linux/videodev2.h                |  13 +
>  22 files changed, 1686 insertions(+), 1169 deletions(-)
>  delete mode 100644 include/media/hevc-ctrls.h
>  create mode 100644 include/uapi/linux/hantro-media.h
> 
> -- 
> 2.32.0
> 
> 


