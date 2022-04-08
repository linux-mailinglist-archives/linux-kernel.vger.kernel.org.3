Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69354F9691
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiDHNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiDHNXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:23:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB312625
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:21:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so17297353ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YPyUmvWPJhClpiPWaffqsk3VwK+C7LO2AiimuAuL1Ro=;
        b=aEjngbWMuGEjH4EmejJTL8nfW0MPlu5EnEsysirIWeHL6wcIbqM/rsJpoG6/zo3m2C
         KNjMkZlpU+uOua8w7roVr1e7kiu2wEe60HwJD3IJuXNbsg5kY5wrqOi1uFQj6bjhmAQU
         H5Od0tMND3SzzYECenAG+5rIcMxRtG9HF1bpWrabqGSeA/T0jholG7YCwSYzokS+szVA
         Us9sBu+b33kGR5i63A2vc3u7BrE0+o9V8+Tf0PhtmpFIGUnL9VlR175cPjKTAJxClp3F
         CspHFKflvB2bdfOJJe73Rx1J1kBFRMxr7WQjFQCj4Aj295d1LL7Z12/4gzpG8DXxzcp7
         Lx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YPyUmvWPJhClpiPWaffqsk3VwK+C7LO2AiimuAuL1Ro=;
        b=xpidVxnColnuiHx8Rxp2cj3raLpkENcPW23S3C7qdlcS4Nt1VrY+GsLNA4+fiQpeqW
         18x2PKc4b4aBJfoZh9HAYvVVUNaAO8gnhcXMpNLVUrHCi7/M850gOzylpSb3ixmEcwV/
         BHYPvftlkjLvldFwjfSQcwx4+Xkx4QKvM35WpHcuJvfRyT9sAqb5MB5JcZwZ24oz6+Je
         XdzCV116T7ZRlKihdNSJeNZ0U53WOD/rDreTcOrizA3elqASKs/9xN64LVRRTv3onFFL
         Ql9paBbNWBhZf0fNLlcKQFF3PanZ30XqGWgmIxdC6kAKRHtVSlLdFxcE7EDoynAyI8Q4
         lIzA==
X-Gm-Message-State: AOAM5306VsYlvLM8tDXUdZQ4zuWhX/P1k/qtHmiIeHyvKqDAuq2hiSJo
        hliQoD4jAsOgwSTQp9rRHx7SfCYfJS8rW707baM=
X-Google-Smtp-Source: ABdhPJz5+siwf2gqw3X2rRzoJIanYM41NMCYQCryCJRCwC2NONx2btw2hzLJPUuBprtMbGxfMaoG02PJ8uEuLtKbtJ0=
X-Received: by 2002:a17:907:9485:b0:6db:331:591e with SMTP id
 dm5-20020a170907948500b006db0331591emr18204422ejc.478.1649424066578; Fri, 08
 Apr 2022 06:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220408092803.3188-1-h0tc0d3@gmail.com> <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr>
 <CAP+8YyED70CSqVRaB7JgrAtK-yvBx5EsvrrdR7EpvOG2AVhskQ@mail.gmail.com> <QfKpxmkE_cy9wt5VJruw_TSdnl5KceKM8BxJGmZSBs-KiaRwIYfgc8h_-5h7Wmj6G-NtUJ3A88V5pzPvZuLlpkK-oRO5pSjeTxwHcZWlogs=@emersion.fr>
In-Reply-To: <QfKpxmkE_cy9wt5VJruw_TSdnl5KceKM8BxJGmZSBs-KiaRwIYfgc8h_-5h7Wmj6G-NtUJ3A88V5pzPvZuLlpkK-oRO5pSjeTxwHcZWlogs=@emersion.fr>
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
Date:   Fri, 8 Apr 2022 16:21:04 +0300
Message-ID: <CAD5ugGD6QzCUqk7_EVwH9Cc6PQtx_VfjVRWzzP9uKR5tkGh1RQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer dereference
To:     Simon Ser <contact@emersion.fr>
Cc:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Ser and Bas Nieuwenhuizen, do you understand that you are
proposing to make the code less safe in the future? In the future,
someone might rewrite the code and we'll get an error.

=D0=BF=D1=82, 8 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 14:48, Simon Ser <c=
ontact@emersion.fr>:
>
> On Friday, April 8th, 2022 at 13:28, Bas Nieuwenhuizen <bas@basnieuwenhui=
zen.nl> wrote:
>
> > On Fri, Apr 8, 2022 at 12:01 PM Simon Ser contact@emersion.fr wrote:
> >
> > > Is amdgpu_display_get_fb_info ever called with NULL tiling_flags/tmz_=
surface?
> > > If not, there's no point in adding NULL checks.
> >
> > It isn't called with NULL anywhere, the NULL checks that already exist
> > seem redundant.
>
> Grigory, would be be willing to submit a v2 which removes the unnecessary
> NULL checks?
