Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5478547870
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 06:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiFLEDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 00:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLEDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 00:03:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18123982B;
        Sat, 11 Jun 2022 21:03:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id s12so5128616ejx.3;
        Sat, 11 Jun 2022 21:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbFRE+VCdz/Mvat4l03Ru/M9ljAjH7/8wgRe5uPLKmA=;
        b=JylIYtTShS/QVxxbVK6KZgGdN2BZID9npboqy/8nxih8wIBzeXClsDxln2BxALdDKo
         s/rdJm9lAJOmYNN48gAD4YprUguICzlGaD2n5L+7N8UDtwFkb10xOgcJROs17fds/p0C
         djKJtLrvwes1nNTxMct5KgVOoJHnvlGqfRffcNGB3xI2tq12ydBIJQHokfeodlOA/OOS
         dYL3kFDEUOlRW3hG09rOFTU1ut9Ig2Vy409NhFVaCYhKZGXtR2Br5lyBBBhkA4Dy49q6
         TzI1y3h5cFKs45EFz7cIirMCXSqmb9Tt9rLTkz+gaZA4p2T4AjtpmqQTeePPu2QxhL0S
         e16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbFRE+VCdz/Mvat4l03Ru/M9ljAjH7/8wgRe5uPLKmA=;
        b=flLrjLdRaiAQgM3Mc9ju5vCDgn6aR2ZkPPYoiOmu7XFMjopWbE0uJeUrz1PMvDlb8g
         kMoFkeGd7lcVPHcTvEc/Mh4aM6yX6NT77LnnIqxFc72U5eIjzADWC/plMcK0/zCSZBIy
         AgYuhu/7aSW7JmWMwEF7oiQw3Mdk7dcn7Nib6HmZbTK34ilvApyuP0yOBMMhRe3KgjRi
         MB4IL747iIBhD1CynATIvcn4ubSRuUkU429OchsWfZB6QqSrfqo6kORBtSwtwq0AK4Jv
         /qInlFtv27HGeYKMplioiBTBRrk1dcu23WDNRXlU/SeT8B5xfSwUbSrnXDRDTwSky+CI
         bAcw==
X-Gm-Message-State: AOAM530+3cWZt40z033rjF/9ePiCEjv/GH38iNPjWNqxLlIjyxPP9s/X
        EHAPVB1EuUlWgF76qMDi0EXWV3uHgieuyzM2vLU=
X-Google-Smtp-Source: ABdhPJy9n/qDVUSTdlF1vXGTql2S/bTRtKA5PHOMP6KIlAgDuGmiLNoP/0JDATNBnLXZHa3pJmlXULj0phEuLoDftkE=
X-Received: by 2002:a17:907:1c19:b0:711:e5f9:2ec7 with SMTP id
 nc25-20020a1709071c1900b00711e5f92ec7mr23267565ejc.518.1655006591088; Sat, 11
 Jun 2022 21:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220529180428.2577832-1-robdclark@gmail.com>
In-Reply-To: <20220529180428.2577832-1-robdclark@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Sat, 11 Jun 2022 21:02:59 -0700
Message-ID: <CAPaKu7QDoZiPRDAptk7+cfv3Da+oXU7f0f4m6LQiwfzd=x=TuA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/adreno: Allow larger address space size
To:     Rob Clark <robdclark@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Connor Abbott <cwabbott0@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Sun, May 29, 2022 at 11:04 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The restriction to 4G was strictly to work around 64b math bug in some
> versions of SQE firmware.  This appears to be fixed in a650+ SQE fw, so
> allow a larger address space size on these devices.
>
> Also, add a modparam override for debugging and igt.
>
> v2: Send the right version of the patch (ie. the one that actually
>     compiles)
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
