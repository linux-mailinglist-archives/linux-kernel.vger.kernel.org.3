Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5E4B5D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiBNVwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:52:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiBNVwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:52:47 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00D812D220
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:52:38 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s24so18914342oic.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zmZMNg8yirylbypUIIKEO/EPeXpVI509iUbW2YvzzY=;
        b=fPfvpg6iu+DE1UjGM06KRdvsHlYCBjpXnM+qLTt9zo8a/r2MjOmsrxXUdY6KBrj/RK
         BtQe8Ph4IzCbya/WerKt8rmQy60UVxTmSLFYVFpcS0ZoAZxXg4H92peuRNGcjyUegGnQ
         e8G8YQ5Dwp6OPnyCO/QTspf2dYhEiTZVXTe/yQDelafJvHg78pQqymlyLEM+9coslaBJ
         yTS2v740JPRRx8H6bqPhzWaRulVwuK0YZI4WY5MDxhxGtyw0sQ0FHZ8jNaS0Rpw+nNP5
         n6trpn8ogmloXG4d3l9wj7v5l0J7gS/G8Oj/yQpoNp32kDmkJ2hfoaaesoc8TuHW7SEC
         zfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zmZMNg8yirylbypUIIKEO/EPeXpVI509iUbW2YvzzY=;
        b=7ONHuKiCSoieuHvIBzXwsb4WK0I8zHSLDnU3BGTVNRIcOJJbHbsnbbORdgfwhLC9mZ
         1iUD4+tzPqduU4qcYs5jJbdl7amgKvoNPui0/Y/e29nPRele9wVygnOhnNFSLcu1bTQO
         lR7szSj7t32MmXNXXStk+6wKwBI0PcQBUD3EWSzxlWG1KXED+LH88bu0p+Pn4quNmu2O
         SSj1gWRgNADBYcoArsOTTzqaI/Pixy8pSZ+XjvR63Y0P5ifwQi4wba7eP6fvipL6wfhM
         z0g7vgHnzeiLO8+123u4qGbe/6xdy9SSAXjpkkcGkymzKxWD3hiuVGyevsC4jcywbDvx
         Z/Zw==
X-Gm-Message-State: AOAM532YYPKQLK1VyeRSxvXyVsJkxnV/Cy9lSYKuH88dO8lficba+0U5
        fedokHLQEQPuvFLG6f38TJponUtMVTw9FGlzKS8=
X-Google-Smtp-Source: ABdhPJzA3uzspnOYFs6i9DW+fiv36kgx3jpnJcTh6jp5Esnikv18hVw4BUzWj0HpJxRzAX/q+tTul5ga/gaDmADiO9w=
X-Received: by 2002:a05:6808:159e:: with SMTP id t30mr414528oiw.132.1644875558252;
 Mon, 14 Feb 2022 13:52:38 -0800 (PST)
MIME-Version: 1.0
References: <Ygf7KuWyc0d4HIFu@eldamar.lan>
In-Reply-To: <Ygf7KuWyc0d4HIFu@eldamar.lan>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 14 Feb 2022 16:52:27 -0500
Message-ID: <CADnq5_MfR99OhjumQESCO7Oq+JVOHOVgyVQHX4FpGFDnPu6CyQ@mail.gmail.com>
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic
 in suspend (v2)") on suspend?
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, 1005005@bugs.debian.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dominique Dumont <dod@debian.org>
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

On Sat, Feb 12, 2022 at 1:23 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
>
> Hi Alex, hi all
>
> In Debian we got a regression report from Dominique Dumont, CC'ed in
> https://bugs.debian.org/1005005 that afer an update to 5.15.15 based
> kernel, his machine noe longer suspends correctly, after screen going
> black as usual it comes back. The Debian bug above contians a trace.
>
> Dominique confirmed that this issue persisted after updating to 5.16.7
> furthermore he bisected the issue and found
>
>         3c196f05666610912645c7c5d9107706003f67c3 is the first bad commit
>         commit 3c196f05666610912645c7c5d9107706003f67c3
>         Author: Alex Deucher <alexander.deucher@amd.com>
>         Date:   Fri Nov 12 11:25:30 2021 -0500
>
>             drm/amdgpu: always reset the asic in suspend (v2)
>
>             [ Upstream commit daf8de0874ab5b74b38a38726fdd3d07ef98a7ee ]
>
>             If the platform suspend happens to fail and the power rail
>             is not turned off, the GPU will be in an unknown state on
>             resume, so reset the asic so that it will be in a known
>             good state on resume even if the platform suspend failed.
>
>             v2: handle s0ix
>
>             Acked-by: Luben Tuikov <luben.tuikov@amd.com>
>             Acked-by: Evan Quan <evan.quan@amd.com>
>             Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>             Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>          drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
>          1 file changed, 4 insertions(+), 1 deletion(-)
>
> to be the first bad commit, see https://bugs.debian.org/1005005#34 .
>
> Does this ring any bell? Any idea on the problem?

Does the system actually suspend?  Putting the GPU into reset on
suspend shouldn't cause any problems since the power rail will
presumably be cut by the platform.  Is this system S0i3 or regular S3?
 Does this patch help by any chance?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e55a3aea418269266d84f426b3bd70794d3389c8

Alex


>
> Regards,
> Salvatore
