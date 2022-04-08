Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5D24F9405
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiDHLag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiDHLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:30:32 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DCF99EE4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:28:27 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e71so6297ybf.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 04:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=basnieuwenhuizen.nl; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ixi8kZe3SkhTQxe+wXeMeIxrtbGzlOxLmNLbF+cZC8M=;
        b=JC/JLxvdznj2flCGhE/ltsXvXoWICpPPcZVAc4nW/hIHqnRvzJNB0Djd9odaS3YkfV
         s7aspmSbK8nu1lhQj0rQcmzyNOBf11KgGcACQNMYUITCRoOPSaTHtBKBtYiSppKmbIHg
         79M4wAqawm6e81OjbTeIDHjoSSDr5I1WSqTQlKJOS20EBWB7SF2O5DSc6brgdosF2zkB
         VbrGxDeYyx7ZWsOy1ZBfoJCiqP8pOC4IEHZhP1jEO9lc6jF5xxO0NeNu7+29zOtTl2Sx
         RJcldomKk4zPxcBPtRPr9CH+LPdC6JbNgeblwnmgGh/LUavVVJLGHVJfFLN8kqTzMdaK
         sGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ixi8kZe3SkhTQxe+wXeMeIxrtbGzlOxLmNLbF+cZC8M=;
        b=WbXclc0LCSwLEDMzsv1ow2vKpxYaFYFeFT7lCGU5swUpJcI3Svf3hA2fnS8jhhkqQg
         KVADEWCEiSd6ZdftqDnr1jzVMGdRIGlRH1xkXk1JgdkC68aSAuyupqVmuaueZ/eCuHlp
         edTx+bG577RbVTntwRey8A+8DWSxJEM0GIhd1siN3O65Mrp38A2flJK6qr7L8FJKEiLH
         KoGQn4Dt11qotF8KG1/E6qaRhWIdRLt603NmQY4YIcjgXuGCPssIwk8taqEywtZ3jsLT
         1yJUv+nSsxk5lHMBgMUYkuKPVSdn+dVcMvzwxVrTUL4t4m5A/zUgFFb3RNFhe6+yrVrr
         nlIg==
X-Gm-Message-State: AOAM53045VouRWN8wczob+uYT/3IcavYlXSBiOkH1yqrd/Uy4pHSx4VM
        AG2jvLWYPc8LrU0DxYjRfDOVU/tL5V1BUU+YzhaNew==
X-Google-Smtp-Source: ABdhPJzwFRM17qVNXqispIOAMRuWTccQv1dCmb99J12Wu/5Bz2f0suYtIbNIiAk2urkS/Qj+dWH8wJUS9YWSs5bZwKU=
X-Received: by 2002:a25:1409:0:b0:63e:4e0c:9158 with SMTP id
 9-20020a251409000000b0063e4e0c9158mr6468964ybu.555.1649417306934; Fri, 08 Apr
 2022 04:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220408092803.3188-1-h0tc0d3@gmail.com> <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr>
In-Reply-To: <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr>
From:   Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date:   Fri, 8 Apr 2022 13:28:25 +0200
Message-ID: <CAP+8YyED70CSqVRaB7JgrAtK-yvBx5EsvrrdR7EpvOG2AVhskQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer dereference
To:     Simon Ser <contact@emersion.fr>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Evan Quan <evan.quan@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 12:01 PM Simon Ser <contact@emersion.fr> wrote:
>
> Is amdgpu_display_get_fb_info ever called with NULL tiling_flags/tmz_surface?
> If not, there's no point in adding NULL checks.

It isn't called with NULL anywhere, the NULL checks that already exist
seem redundant.
