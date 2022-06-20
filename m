Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5F551458
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiFTJ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbiFTJ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:28:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6211A30
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:28:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y16-20020a9d5190000000b0060c1292a5b9so7945807otg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+E3s3QkzcGFpv21zvwpnb65PL/N10eRE8HHqyGPUlDc=;
        b=DJ+WMLVyMwk8maVS9kj+U87ierbJivmOILpqH3I4hGvoc2Z9YfIw2VmzeT+Uuheqxv
         nPvWVaQSB3YN4TTTiQWhxCQuuYcir5Ex60T9T7HKonhAYy41SC93O31KDnNVe31cciL4
         AAxR6NsWDL6VfIlvS1pVm9ii3WUK3k4wRcVRjtokGdyVty9/xnQip4De6UptgBNIBp07
         3VvCIrKKP5X4gV5gW2SwoXawpX5TzEBTLQtmtbIZhaekKODLM/mMoMessleLAVEg1V33
         rHbkx+ZruDcbZGT06xaIMQuIMrszKhbGykUyEIUhEgEQaTjHd4ckIY4GJpuDdYeA3Mw2
         6oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+E3s3QkzcGFpv21zvwpnb65PL/N10eRE8HHqyGPUlDc=;
        b=BAptEKgJRK/cphYf8u2pdRd4Yx03nJuFkB//5sOSB8K/lok+nnqiBaxDPdLNNDK8P3
         uUbZetwJsdW+Cs0knwqpulQjhzwy0cwnFKOImBZ9Ug4usqLpQ9ZO1qMGmMmXt3Zrnz8V
         ap8vRmwgIYw7R3FNcz1xZa3ZQL45V+EvR0p5qUGKw1hTvEN3zwVFK8p3PS4wZQf9Dpl4
         r2zieZ0KSJRlpqXSRzns84Nlb0hpsdyw5aCGgI/rqM/A7CYpaX2bciSLqKf0JgfqQ5E0
         pj6I0vXiI2AzhWNuM4lk/qdujXNVIrEPO7NkMipOJdOgdYzf9la3c3MREg9y4xHbF04q
         qEWA==
X-Gm-Message-State: AJIora9wtfB81QSzqYbsQeS/J8o3iNdksQqX3/YpgZUdahqAnPXecsWy
        je0d6aiMzyDuWgR/FxJmCYBV/EkOeAaevT/NkgLVDPWC/EIJSw==
X-Google-Smtp-Source: AGRyM1u7wtq73sNYXuB85ckFWHp/sUaPQojdzAh+InCrMmV7DdteUrkzZjnIv3HX4ij2uk7XcCZ6MyDeHlvDKFC0AzA=
X-Received: by 2002:a05:6830:2b23:b0:60e:3067:e496 with SMTP id
 l35-20020a0568302b2300b0060e3067e496mr8585268otv.16.1655717325999; Mon, 20
 Jun 2022 02:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220126014725.1511-1-jammy_huang@aspeedtech.com> <20220126014725.1511-3-jammy_huang@aspeedtech.com>
In-Reply-To: <20220126014725.1511-3-jammy_huang@aspeedtech.com>
From:   Lei Yu <yulei.sh@bytedance.com>
Date:   Mon, 20 Jun 2022 17:28:34 +0800
Message-ID: <CAGm54UHobZ7f9q7vB5F8fJDeyr_PSbRxJPg45etscxxSvRtFVA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] media: aspeed: Fix unstable timing detection
To:     Jammy Huang <jammy_huang@aspeedtech.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-media@vger.kernel.org,
        openbmc <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We hit an issue where the resolution is not detected correctly.
The issue could be fixed by this patch.

Tested-by: Lei YU <yulei.sh@bytedance.com>

On Wed, Jan 26, 2022 at 9:49 AM Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>
> Using stable-signal in resolution detection, and try detection again
> if unstable.
>
> VE_MODE_DETECT_EXTSRC_ADC: 1 if video source is from ADC output.
> VE_MODE_DETECT_H_STABLE: 1 if horizontal signal detection is stable.
> VE_MODE_DETECT_V_STABLE: 1 if vertical signal detection is stable.
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  drivers/media/platform/aspeed-video.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 5d1ec3de50ad..eb9c17ac0e14 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -153,9 +153,14 @@
>
>  #define VE_MODE_DETECT_STATUS          0x098
>  #define  VE_MODE_DETECT_H_PERIOD       GENMASK(11, 0)
> +#define  VE_MODE_DETECT_EXTSRC_ADC     BIT(12)
> +#define  VE_MODE_DETECT_H_STABLE       BIT(13)
> +#define  VE_MODE_DETECT_V_STABLE       BIT(14)
>  #define  VE_MODE_DETECT_V_LINES                GENMASK(27, 16)
>  #define  VE_MODE_DETECT_STATUS_VSYNC   BIT(28)
>  #define  VE_MODE_DETECT_STATUS_HSYNC   BIT(29)
> +#define  VE_MODE_DETECT_VSYNC_RDY      BIT(30)
> +#define  VE_MODE_DETECT_HSYNC_RDY      BIT(31)
>
>  #define VE_SYNC_STATUS                 0x09c
>  #define  VE_SYNC_STATUS_HSYNC          GENMASK(11, 0)
> @@ -909,6 +914,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>         bool invalid_resolution = true;
>         int rc;
>         int tries = 0;
> +       u32 mds;
>         u32 src_lr_edge;
>         u32 src_tb_edge;
>         struct v4l2_bt_timings *det = &video->detected_timings;
> @@ -939,6 +945,13 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>                         return;
>                 }
>
> +               mds = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
> +               // try detection again if current signal isn't stable
> +               if (!(mds & VE_MODE_DETECT_H_STABLE) ||
> +                   !(mds & VE_MODE_DETECT_V_STABLE) ||
> +                   (mds & VE_MODE_DETECT_EXTSRC_ADC))
> +                       continue;
> +
>                 aspeed_video_check_and_set_polarity(video);
>
>                 aspeed_video_enable_mode_detect(video);
> --
> 2.25.1
>


-- 
BRs,
Lei YU
