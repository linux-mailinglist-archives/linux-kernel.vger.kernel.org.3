Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1765A163A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242901AbiHYP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242884AbiHYP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:59:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22DBB284D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:59:31 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u14so23816473oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4W8sbga13vF4WDksQp6y3D5fZvihCL3tYDFOfdvfLZc=;
        b=SJgqQ5bCbirbRTCLVk61AB1UqyE0/TeFroOFgSCwTQmSkIMyKRH7peBwGMcwW4uaTm
         Z5zzIy5lmODpKJozwalKwef4CCI/FtB8oP+RS/12+HMob0CeVlyVaUw7UCI1jk1Hn8dO
         cOkOw+6Yq2DjkvK/QFBl6vJ8P/dg+8gnO7JA4uqWniQ6VHKqRDsGYByf2/iDLI1HHzW0
         RztFyvZriJkNtpCKQd1F5NSkgKKKW+0DrhC8xbarnw9jZM61/ixSKUlzT/FKbQnxBdLb
         J3ciH8q3TvBObx33TcU+jj82pNd2zfu20r8OyUZr5P1gGTP/r0Frgg5hlwfKXsvOmrZ2
         Pt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4W8sbga13vF4WDksQp6y3D5fZvihCL3tYDFOfdvfLZc=;
        b=BM+qAEF5RuH93VvU0P74CrIcFRUfSCmq2MhG2s7WhgJJsHdtwG0mYDB1vo6pblzxMb
         Wv6uuy/LnU6Ub0+M3duVlucnoswtjMR2OovleFXLoCTvqz64likio5hDROLiVM2cUkEv
         LA2q8I9jSRnZPRwxPSP0Ta9mkjhEq/Q1c1K/aqjlCNW24QatXC4fzr0kIj0q2g8xPawv
         usEfF083LMuezKxxnaTyyohm5LdcLnMbFSXBXk4A+TEImAS7DU8EiTrOkdVhNqU//+f6
         067hRM6dnZkCDtX/ZJQP1aAWWcdT+XWFCUTpxLN1gxAlIPCaRHlmi4bHdCJuKO+2lV71
         Dv8A==
X-Gm-Message-State: ACgBeo1WvjIxreaAVcd+5Cy+bmbWE0iBkpJJuBlJzhWnhwZut1piO3cw
        uI9cT0MrzLDvr4nqXpChWC0cLsOI/kfZGSwj/RM=
X-Google-Smtp-Source: AA6agR5mCsJkJx+TJF4q8EJOBBcvvHuVfq9LpQ3+egvzyXQ+FPo4kGWaPWMkrrj7AesPgq3CvJGrQwVH0EAcyTELYnU=
X-Received: by 2002:a05:6808:2187:b0:344:eccd:3fc5 with SMTP id
 be7-20020a056808218700b00344eccd3fc5mr5927139oib.46.1661443171311; Thu, 25
 Aug 2022 08:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220823063546.11499-1-bernard@vivo.com>
In-Reply-To: <20220823063546.11499-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Aug 2022 11:59:20 -0400
Message-ID: <CADnq5_NiyLjKtZ_C0jLBp8ChzvXvFkLd82dLN3x_JFeqV+XaVw@mail.gmail.com>
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

Alex

On Tue, Aug 23, 2022 at 2:36 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> This patch fix potential memory leak (clk_src) when function run
> into last return NULL.
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> index 85f32206a766..c7bb76a2a8c2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> @@ -1643,6 +1643,7 @@ static struct clock_source *dcn31_clock_source_create(
>         }
>
>         BREAK_TO_DEBUGGER();
> +       kfree(clk_src);
>         return NULL;
>  }
>
> --
> 2.33.1
>
