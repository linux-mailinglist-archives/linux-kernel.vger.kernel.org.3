Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E87750DFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiDYMLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiDYMLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:11:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884725AEF4;
        Mon, 25 Apr 2022 05:08:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z19so4859204edx.9;
        Mon, 25 Apr 2022 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9RppN5aDTjXCcWCJ05N8v1cRlmedZ0/iK/cwkqMY7Q=;
        b=K8VTHVCFjhdnXo6DLKplzZMQxuRWrIiQ9JCYhxordsBWfolL+JYV+kK6T0tgtmNOjv
         pQe1Rlm3IFiIF8K07VP1EaJ/7muJTC/8hDFM5A3BbgjJDKPlZVx44G4OXuMJpHojhMzN
         fr+kUU8Dy7HH8m/ndTdr7Pd2tzWMoOY1k4ZZx9Klb10dICE02ylOjgCSTBy0/JSnfEBm
         TaS2x2wKkklIZs++4b1OnxoWCle8vNLFMfum+ezpoNiSJ/fWe80fMyfehHAHhL5it2/v
         yINBCFCb7NCEHOXbvKdeTYO7kgM70UefeJSMUd93ZHy4usNzbVZxDMDp+H3g4LbSOJe1
         l6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9RppN5aDTjXCcWCJ05N8v1cRlmedZ0/iK/cwkqMY7Q=;
        b=GC0ixuxKG2qbsrTHmjL8LdCmde7D+2NfqLQcw0hFQnjqxkCfFOZNev5bu0gdQ2/gHQ
         XFHyo3vyw+TAWKF3JF9ztPJkEPObMPrbAtkK8RQHC0aYu1taN09N8MPorhrq/1XiZFn+
         BgylCcUm8T3ODup5ahvG+jz121zlnBP1gWzE2onLvxmm9qSMUhSnCR9Ittt2z7QO8GPg
         mOQbf0E4v0tsv6n1YZonicI/0mOaCUF7zX5yHYJgLsSrpkK5NS4LRyagHRt2CmAGQb0z
         nThY8f69/rNjJ/CXDc5h0syfA2A2Li9di8/VSbNgZjSfHKtKWBhsTAfndI7S/Xeryi5P
         MNFA==
X-Gm-Message-State: AOAM531XUrwAGeYAJhS4XEAHmi8TUDwz4gmHbk2VsaVeToCGqtEZV1AO
        u114yIpOaf42ZAi5T+9ZafVsiWGX+QDv3mDHALrlAWlb
X-Google-Smtp-Source: ABdhPJwwombBhtn/hditfmKV6ABUCDrdDlZARzVwJYcq1LzEyDPnJPRWmfMa+G0fNPCZHT/SivOWdsp4f6g/9QZGwPE=
X-Received: by 2002:aa7:d543:0:b0:416:13eb:6fec with SMTP id
 u3-20020aa7d543000000b0041613eb6fecmr18946181edr.348.1650888508669; Mon, 25
 Apr 2022 05:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220412135534.2796158-1-aford173@gmail.com>
In-Reply-To: <20220412135534.2796158-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 25 Apr 2022 07:08:17 -0500
Message-ID: <CAHCN7x+C9dkdMKsx4uQqRBQrJDpF9v3RDhpuOmwNRMx0hj63TQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] media: i2c: imx219: Enable variable xclk and 4-lane
To:     linux-media <linux-media@vger.kernel.org>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Tim Harvey <tharvey@gateworks.com>,
        cstevens@beaconembedded.com,
        Adam Ford-BE <aford@beaconembedded.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 8:55 AM Adam Ford <aford173@gmail.com> wrote:
>
> The driver currently only supports a 2-lane camera, a fixed external
> clock (XCLK) at 24MHz, a fixed Pixel Rate of 182.4MHz, and a fixed
> link rate of 456MHz.  There are a bunch of hard-codec values in a
> table of operating modes which expect the above to be true.
>
> According to the datasheet, the driver is capable of operating in
> either 4-lane with a pixel rate of 280.8MHz and Linux frequency
> of 702MHz or 2-lane configured as stated above.  The XCLK can be
> anywhere from 6MHz - 27MHz instead of being fixed at 24MHz.
>
> Split up the hard-coded values into smaller helper functions that
> dynamically set the registers of the camera based on the XCLK and
> desired number of lanes.
>
> This series was tested on a Beacon RZ/G2M streaming video at 640x480
> to an LCD with fbdevsink
>
> media-ctl --links "'rcar_csi2 feaa0000.csi2':1->'VIN0 output':0[1]" -d /dev/media1
> media-ctl --set-v4l2 "'imx219 2-0010':0[fmt:SRGGB8_1X8/640x480 field:none]" -d /dev/media1
> yavta -w '0x009f0905 2048' /dev/v4l-subdev12
> gst-launch-1.0 v4l2src device=/dev/video7 ! video/x-bayer,width=640,height=480,format=rggb ! queue ! bayer2rgb ! fbdevsink
>
> Due to hardware limitations, the XCLK is still 24MHz, so anyone
> willing to test this series with a different XCLK would be appreciated.
>
> Due to the video format, streaming video at larger resolution was
> not feasible, however individual frames captured at 1920x1080 were
> successful.
>

Any comments from anyone on this series?

> Adam Ford (4):
>   media: i2c: imx219: Split common registers from mode tables
>   media: i2c: imx219: Support four-lane operation
>   media: i2c: imx219: Enable variable XCLK
>   media: i2c: imx219: Create DPHY helper function
>
>  drivers/media/i2c/imx219.c | 340 +++++++++++++++++++++++--------------
>  1 file changed, 213 insertions(+), 127 deletions(-)
>
> --
> 2.34.1
>
