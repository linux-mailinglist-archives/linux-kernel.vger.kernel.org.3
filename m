Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7914E9D10
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbiC1RK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiC1RK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:10:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F731FCD9;
        Mon, 28 Mar 2022 10:09:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so30032805ejc.7;
        Mon, 28 Mar 2022 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oz/GhbrsSoiiuJbFSvXUMfpNUWNZ2X3Kmt6C0b9MtEY=;
        b=XLFg6dCmzHI6UVEuH8BLYtKKM4uvH1ZozdUxJhyd9zDVCSiCtUzw6R4eiOcIvKdtp+
         OKddStrGMKY8ErWM/NqQq/kTWdaunQJTqePkGKtU1344Wj+/F/i30ItvbA4IFnBLSQwF
         V54eQVV+UGCyhBuPy2yjZg2dmrMr+eoLRbjvlMQ1nkV1S+tR/6RAYXCgx+dCLXCwTgOu
         w6GK9j/qC32+SQY+8OroKJsE2UtR34akAYW9D+sOA0gZhXFh1I3RJnD6fFQuFmo/0BU/
         PRSsL+VvNUjbki90jg38CzUeCr2IKa7ibdhMwchZvJ3LJYdvrreSSh3J/0os/8ijeegd
         s8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oz/GhbrsSoiiuJbFSvXUMfpNUWNZ2X3Kmt6C0b9MtEY=;
        b=7ae/eTvSNuu4AkaQhjqhBqSL+aSkDL8qfqHqmcCVfV0CSQvc9WPaUo7PLX6lmxYo7v
         Pqr9egLr2rmlSUqkphc83LYWnq6j+qBfe74jexfXV6iumy9rWQwOcyJ0fWwuhDG2CVUJ
         AdcbKWRh4WBZX2PRupilIxAPqe1xBT3XOQAD+KkHtHWSBckKLQwGkxsy27x9rcUxFoUE
         Q97LDjruvO8tVcZp806dx0qz84GbFd/EzgFpo2ce+7jK/G1s0e+VlDyUfgVEyVJLfF9E
         u0iqyjypen2iJF9TxK36pYYevaTgiI6TO8n6koRxwmlPCpBaJH0+GGWDYfxe4Sj7qLad
         Ubpg==
X-Gm-Message-State: AOAM5320MaRDafYIVmIdkeoGqrkUAEZDOwTZLqlBrtOEQ45G0/dAFuy5
        a7cCItsNIdraX0rFuteT+xGZUvXUARA=
X-Google-Smtp-Source: ABdhPJxn3BJyJKNC9/61CZcKeOhAnR0kP6RUMvDsLZPNcLzptiHSJT5FmZKkFiS6yu0S2vwJNZhpcA==
X-Received: by 2002:a17:907:7ba3:b0:6df:b07c:ee35 with SMTP id ne35-20020a1709077ba300b006dfb07cee35mr28691222ejc.588.1648487353124;
        Mon, 28 Mar 2022 10:09:13 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id o17-20020a056402439100b0041938757232sm7321011edc.17.2022.03.28.10.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 10:09:12 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     acourbot@chromium.org, tfiga@chromium.org,
        hverkuil-cisco@xs4all.nl,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 2/2] staging: media: cedrus: Rename H265 to HEVC
Date:   Mon, 28 Mar 2022 19:09:11 +0200
Message-ID: <4697363.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20220327084308.9053-3-sebastian.fricke@collabora.com>
References: <20220327084308.9053-1-sebastian.fricke@collabora.com> <20220327084308.9053-3-sebastian.fricke@collabora.com>
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

Hi Sebastian!

Dne nedelja, 27. marec 2022 ob 10:43:10 CEST je Sebastian Fricke napisal(a):
> Rename all instances where the identifier H265 is used with HEVC.
> The codec has multiple identifiers H.265 (ITU-T), MPEG-H Part 2 (ISO),
> but the actual name of the codec is HEVC (High Efficiency Video Coding).
> Also nearly all other related drivers use the term HEVC instead of H265.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

This patch is not constructive. I admit, it's unfortunate it's not using same 
name as other drivers, but anyone dealing with HEVC will know H265 is synonym 
for it. This patch doesn't improve anything and actually makes any fix harder 
to backport, if something cames up. According to diffstat, this rewrites more 
than 50% of cedrus_h265.c, including renaming the file. Additionally, it's easy 
to miss something to rename and we could play this game in the future too, for 
no real benefit.

So NAK.

Best regard,
Jernej

P.S. Please wait at least few days before resending patches, even if you find 
something. After all, RFC patches are meant to get some response, it's not 
expected they will be perfect.

> ---
>  drivers/staging/media/sunxi/cedrus/Makefile   |   2 +-
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  30 +-
>  drivers/staging/media/sunxi/cedrus/cedrus.h   |  14 +-
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>  .../cedrus/{cedrus_h265.c => cedrus_hevc.c}   | 438 +++++++++---------
>  .../staging/media/sunxi/cedrus/cedrus_hw.c    |   4 +-
>  .../staging/media/sunxi/cedrus/cedrus_regs.h  | 394 ++++++++--------
>  .../staging/media/sunxi/cedrus/cedrus_video.c |   4 +-
>  8 files changed, 448 insertions(+), 448 deletions(-)
>  rename drivers/staging/media/sunxi/cedrus/{cedrus_h265.c => cedrus_hevc.c}
> (53%)



