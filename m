Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD84C7406
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiB1RkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbiB1RiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:38:02 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59672574B3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:33:28 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qx21so26261454ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c4YZwBBQho++OJi9JKUYs2TaH6tp8j1xjs9eFNnTtXc=;
        b=GC0TsiAVVJWcZVS7y6WfiVVuddzdFvXLwaqD8MOHUPUkZnINo5dgZeh9W91OpCsxUZ
         FJ/IjgTSgueCGSK+DEliiFeEC0Eymkq27Dxaw2jSO+WMlyaAqHT+u5BWu9rA/IqBF156
         f4TzIMGYp8xsELnG9XxGIEJIxOgEdiknRQm+j4+hMAg+Wnqj6aDUWCubU5DqHfN7GpU4
         BkKw/UXDLw11uA7rux+U7mzHJRphIdhsrhMwObLtSvxQ85ssCbskQUmx6KB6p35hs8td
         Gtj0QwrXoZ+mLuZ+me90bYoDHKD1o0Myyl58n39NGydn8Nskv5RR8DKicI83T4ovQ0UR
         LN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c4YZwBBQho++OJi9JKUYs2TaH6tp8j1xjs9eFNnTtXc=;
        b=iytvU/hy6IAljeDULXO5K/SmighJUK8l60GeSgg5NUGOj2hWO4wkLOub8KvokMtz5/
         OMYPbxv04KdlxiDtY0lrcPxggXHZOnaK13hUgP3Y8py/G1jXgVmqgSR7TMMqGxOW4LcB
         Yu33hqeCiAOqI1PwyJDM7Ix29d+p75tV9uuOqyOjZt4auuN9Abi8gR85TRFoHDYFKtG8
         Kpl0W/B71U6oj6PGRiaejcoJ9F+ne6G3qWHpad2OLKR49F8Ul5I1pCp2dCngvrhPFxpX
         riMcLNWJRbaT9tSYefb+GPEmdpkf61eKTB+xNsrXBeaIF5JvH7fTHICnv6yq+jLlcRBB
         vm5w==
X-Gm-Message-State: AOAM530MZw0T2i5fsZONyHJeStHACgV79En6ethE0W6HxgjuLMk04A+B
        56OvBA/CHHuQ9QR40Lg0hPVo1ZOvcdMXXzed5oQ=
X-Google-Smtp-Source: ABdhPJyYuGLKMR9wTGeDFqadaZHRCnFQi/61QLVu89LXmFHy20TIOLSpP5zb0c30j56gV5BWVNscHOF85Dgt6lEnILo=
X-Received: by 2002:a17:907:234c:b0:6cd:7ca0:8423 with SMTP id
 we12-20020a170907234c00b006cd7ca08423mr16012446ejb.218.1646069606778; Mon, 28
 Feb 2022 09:33:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:e914:b0:6d0:9dc2:9a62 with HTTP; Mon, 28 Feb 2022
 09:33:26 -0800 (PST)
In-Reply-To: <20220228172651.12642-1-youling257@gmail.com>
References: <20220222024651.36675-1-qiang.yu@amd.com> <20220228172651.12642-1-youling257@gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Tue, 1 Mar 2022 01:33:26 +0800
Message-ID: <CAOzgRdaCuBX1E_eeaKsx+toFaBeR6p9RXN8PJZXc5OMY0a76UQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: check vm ready by amdgpu_vm->evicting flag
To:     qiang.yu@amd.com
Cc:     pmenzel@molgen.mpg.de, christian.koenig@amd.com,
        alexander.deucher@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://gitlab.freedesktop.org/drm/amd/-/issues/1922

2022-03-01 1:26 GMT+08:00, youling257 <youling257@gmail.com>:
> this patch cause suspend to disk resume amdgpu hang,
> [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled
> seq=8330, emitted seq=8332
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/1915
>
