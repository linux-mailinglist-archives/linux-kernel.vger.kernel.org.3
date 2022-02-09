Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9508C4AF34E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiBINxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiBINxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:53:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA5C0613C9;
        Wed,  9 Feb 2022 05:53:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i186so4474766pfe.0;
        Wed, 09 Feb 2022 05:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8/AZkkT2BVNgodrUD/MMatfmgWFwg9OSnHgJXVSPYQ=;
        b=S0X5buGW6MxOtOof3n2zS6GPnSC4/FQ7SeVVq855JIk0l2BMxKbSsblrYi6bc+k+xz
         e8jSjrBptslyDMOdc0nmzuu49RMdoen7n8XK+yLDeiFcCMRpifGCmsdRAHZsZd5BkhCH
         FNWwBE7IN5j1WhGAd2nIrbZ5+qHQkCV6GgoLfnOA3meNwrRIe2srZfiUFki+Qch9yX+m
         tA08obLFvoGwrT78EokS/TB6hgSO0EGhBwn/OZjEQ6nT6bdRj6i1kk8jROkumsnvg9bK
         gNUPFdsmGTn3+CTwadqzqSo/erG3s/x86KhJoxiF6F5i6VkBoM/BjRtFBTGaV+M1e14b
         NHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8/AZkkT2BVNgodrUD/MMatfmgWFwg9OSnHgJXVSPYQ=;
        b=oZu/oKf//VJEvJQsF1X3xJ8PZ2T+ZxlcXVJY3WiSPJYqjwaAvLFgCiu3DBF4GIPkyt
         S0gCfBcbO++ut2wJ8SV3r5HnsSzfgn9mLQ6ZXkGiIepYFS7SQiHaZ+bX0f/G+bA+1s3d
         UhoOgQJ4zxfk8nv7yQMxjx7AjGT8dblgQFIpbLivukMs5K58TzPXw3RYW6QX1lkwGar/
         w+qGEm/hypKQvB1SV8MSBsTov1J+4fyoEAAwHaLS47nu57ZhX5j3kpb/vSzh1XFtCK+m
         CDCPO2//G8OPcDp86fixdxbBCOCG5E0GsZ4lBwLTQsr038/rml9G5AHtsyT1icJECFPO
         wvTw==
X-Gm-Message-State: AOAM532wcQr6ovxuq1ZbzH8vocrz48isqsH0C3nBcB80k8xk2/jybGwL
        NM4mo08W89OeynFOkn29b+tUyIQfb1dWFlnY1JI=
X-Google-Smtp-Source: ABdhPJyfW3I/Z5JYdSp25pASfbFmWPnPOui+NwrZYdVF7p1gfcVVmgs/1PT+wZyzR9ZV+9ghLA0gQOPIJL0wl+bW4VI=
X-Received: by 2002:a63:5d61:: with SMTP id o33mr1994897pgm.442.1644414787717;
 Wed, 09 Feb 2022 05:53:07 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2202082148490.52266@hadrien>
 <CAPybu_30=ua4emx3hP2eFeJ4gtoOncah+X+NmsBdQq7cTuqZ+g@mail.gmail.com> <YgO9uo1etPr+pCQr@sirena.org.uk>
In-Reply-To: <YgO9uo1etPr+pCQr@sirena.org.uk>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 9 Feb 2022 14:52:51 +0100
Message-ID: <CAPybu_3MB9Dv_p9pgpF_8eBuCBoHAsnMdnz5to+Q8co3PG7OQw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-xilinx: fix for_each_child.cocci warnings
To:     Mark Brown <broonie@kernel.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tejas Prajapati Rameshchandra <tejaspra@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/S5P EXYNOS AR..." 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org
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

Hi Mark

On Wed, Feb 9, 2022 at 2:12 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Feb 09, 2022 at 11:33:34AM +0100, Ricardo Ribalda Delgado wrote:
> > On Tue, Feb 8, 2022 at 9:51 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > > Fixes: 3973536c4560 ("spi: spi-xilinx: Updated axi-qspi controller driver")
> > > CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> That's not what Signed-off-by means, you should only be adding a signoff
> if you're forwarding on a patch or you wrote it - please see
> Documentation/process/submitting-patches.rst for details on what this is
> and why it's important.  You probably meant an ack or a review.

Sorry, I pressed the wrong shortcut. My apologies.

I meant ack



-- 
Ricardo Ribalda
