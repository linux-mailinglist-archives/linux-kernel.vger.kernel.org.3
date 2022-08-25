Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9E45A1635
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbiHYP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiHYP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:58:56 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFEE895EB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:58:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r1-20020a056830418100b0063938f634feso6992129otu.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=j+VXQR5pjPp1qqY+mCv39sQii/lw0V0SoJNg1H+SGfM=;
        b=eWFooHpe7iAYZmgL7/qWvc3KXLQmoiNDPoqUHkukC19j0wOKbMKmemC1mTNeKVXUso
         ojxe6R/tAxrGpuTv2oVQGI8T8jcsPUTWUwZbj4lcH4lfph/FD5riUcepD6gfaCZtN9JM
         +ofJfbxfxa9de+xdocWonrlW6B9Lqvbt7x4NwkTPIx/Hfb+j4uIrlSJc71VRxgJ5mYm8
         FDzIeN7sfeAB4zugNatkQelVC7etlJlwrQLNU9G5esvOtepXQZDNJuP+Vj+JFhH73JML
         FxjChEAlOgpw9PBR8eK3M6Rfa2LpPpDhD9Hv4F+kL0gz5HRE+pQtp4bB+kP8VJAhcWUq
         2NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=j+VXQR5pjPp1qqY+mCv39sQii/lw0V0SoJNg1H+SGfM=;
        b=Q/qzGdMK5nY2HJyfZIKpRzDj0pWrqUtawUQxyQ6KKVje28W0rluyy69B+Kypcsx9/I
         aXjGqK2OGyCYWDLSwBWRDAkHio2zyUgH212yo6Gp/SxXMCn0r+pov8qSIoKETVZ1HE+6
         RZEMlidk9mAtKSMtIaLnHCz+5RlLNrZ3NiyF7MlC5GWiGNY8UeW0Ddj3UoEjmDXGSjJM
         kyQQSR2cRHkO/gmz8mkDczupJmlWaYqd7L57LpBZnM3o5F+3SlB2Q8vBZuyYnLi/a2TG
         atkSElhOkPl3ZlG/zHpzE0IXIXi49RDZMx/k9k/LkOld5nWfUCrWY7y9lVPcx9ddfO/c
         dchQ==
X-Gm-Message-State: ACgBeo1Wva3c6Tz0EPOXwlFfMWWzDrNd/FO3ulB7TTpI6TGUPi+RnaJ7
        RxBJzXGq0c3ml5xTKUFdSP49Wd7Bg9ptJ4BlWD0=
X-Google-Smtp-Source: AA6agR5gQk9VJ4uU/OnL5wnN7qnr9Nq4p4F+5UpRJRWTSJCq+qbC+iFjKzMZbsJ0AxbXpriG6R0vjPjd5JF445MBg64=
X-Received: by 2002:a9d:6ad7:0:b0:636:f76b:638a with SMTP id
 m23-20020a9d6ad7000000b00636f76b638amr1649240otq.233.1661443134560; Thu, 25
 Aug 2022 08:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220823065001.16872-1-bernard@vivo.com>
In-Reply-To: <20220823065001.16872-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Aug 2022 11:58:43 -0400
Message-ID: <CADnq5_NsRSFb18pE1m-eUtPW_Y2z0arm0U5wzaBh=VUr978ZJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix potential memory leak
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, Melissa Wen <mwen@igalia.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhaojunkui2008@126.com
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

Applied.  Thanks!

On Tue, Aug 23, 2022 at 3:29 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> This patch fix potential memory leak (clk_src) when function run
> into last return NULL.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> index 85f32206a766..76f263846c6b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> @@ -1715,6 +1715,7 @@ static struct clock_source *dcn30_clock_source_create(
>         }
>
>         BREAK_TO_DEBUGGER();
> +       free(clk_src);
>         return NULL;
>  }
>
> --
> 2.33.1
>
