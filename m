Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA8D58EFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiHJP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiHJP5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:57:39 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3784C62B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:57:37 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so18266141fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=D332tIEC5qZA+2v1aF7oqZP76Nc0uHuaS+9UBYQnMSY=;
        b=SPzt8Er15c0/1ir+dkWZ4YaTefkit/sba5ySr7EOWCX1a15PKxHi96Bekiij14Oj9E
         KbYncyBD4U/QHSCjFVHKKH/nuz0ieHySUywNFXIZ0vv4dOT0GcxLbeZGC84yKju6eDwO
         VFv55pw+zWQ3xyfClYyP7T2d5WwWpMmiToyljivD74zhJEnDHGF6456B+qr4M441MEV+
         M2YgELVPtnowCO4fEOSwy7sDNTApNiKRjjc5mjwo3f8r/osH/P9I4cvRoOzs6uEe9S+w
         /S1n/pI8H2nyBrXO5trZfSgXn7qNGu7AjOFglzwmakVrrD+DBwfAa2i4/9g5kcdbPnsJ
         mjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=D332tIEC5qZA+2v1aF7oqZP76Nc0uHuaS+9UBYQnMSY=;
        b=XAagx7VFvoR79jF6FrSPHCt7w5rHNDkLJDX998FHhKDVxGKY3CcN/Hqvm2HUXdvaNH
         g22JMZBRYz2m09qzWHxe52TBRQfaBl1OTicQPdx2/qZda92qCe3Cu9S9ZCmxCBKTaNBs
         zeujE4xyzg/NnaiPKlvDbI0FFPfH7gYHkn+6cXTvor64wPberuud+gBof/U0boRE8MDr
         57iIQQjvXbo+WR6rX5aMDcdFS4Mfu16Gn6RZfi6xb+7WBSvZvQSbrdfkQ16OUSujMbLL
         6D281huxk8xxzsFHSVWCeEnxigQJjvXNtMbZoRuvX0p2AWucJcc+D51VniKkSWUnBMRd
         vcsw==
X-Gm-Message-State: ACgBeo0ZCAWjO2++1kDVvBVW/IFyF5Qv53L21PEnSCVrmvOxYl9JaNUo
        VOWoX855R/8UdE6RluZwduRTQl/undMdQkrTPzA=
X-Google-Smtp-Source: AA6agR4MeaIsJ9o2zQxHjpx8+Y0OUvyRfCxhFk6Vs05DJ2iVybOtAieG8xQ344mI4roaNvgbi6iaOJesEQp6C2sy5D8=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr1690928oae.33.1660147057231; Wed, 10
 Aug 2022 08:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220726182152.123649-1-andrealmeid@igalia.com>
In-Reply-To: <20220726182152.123649-1-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Aug 2022 11:57:26 -0400
Message-ID: <CADnq5_MJAbhQ8VZcPVY5nhg3VnefKPnSscMnRPsm2wB04G6wBg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/amd: Add more GFXOFF stats for vangogh
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom St Denis <tom.stdenis@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 2:23 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> This series adds new logging features for GFXOFF available for vangogh
> and documentation for it.
>
> I've created a small userspace program to interact with this new debugfs
> interface and it can be found at:
>
> https://gitlab.freedesktop.org/andrealmeid/gfxoff_tool
>
> Changelog:
>  v2:
>  - Make entrycount uint64_t
>  - Add a note in docs about data types and overflow

A minor comment on patch 2, the rest looks good to me.

Thanks,

Alex


>
> Andr=C3=A9 Almeida (4):
>   drm/amd: Add detailed GFXOFF stats to debugfs
>   drm/amd/pm: Implement GFXOFF's entry count and residency for vangogh
>   Documentation/gpu: Document GFXOFF's count and residency
>   drm/amdgpu: Document gfx_off members of struct amdgpu_gfx
>
>  Documentation/gpu/amdgpu/thermal.rst          |  18 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 168 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  39 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  14 +-
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  45 +++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   3 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  35 +++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  22 +++
>  .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |   5 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   5 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  92 ++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
>  13 files changed, 443 insertions(+), 8 deletions(-)
>
> --
> 2.37.1
>
