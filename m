Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C176D588DED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiHCNxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiHCNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:53:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B05247B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:50:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z2so11153909edc.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JobmQomHLtYAJ+DDomxdN8Lk7HYy1OLd4rHEITgLQdA=;
        b=OPbC8bWfgzWIie1MfD0jyh6gObqMl3sUtChiIWlKH1yMV8iPxv4ElTDcA/PzHNegar
         6Q0saDylV3e1iDeJ1byjBXOSyeKWMBGjWYRa5oQbwaeiE8Z2F7rmGUHCGcWI70WcGI+X
         +jYxrmH6tmuZkcUvlnKf2JFiqxRcT748c8QQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JobmQomHLtYAJ+DDomxdN8Lk7HYy1OLd4rHEITgLQdA=;
        b=GS6KKXsRgOa85TIpC8hd29eCbaFv48bWFzBnmne/u0ngIxCPnepLeQ1XJQs28U4frw
         2F7Pb7K/pmgOyjQx2F+mNm2BEtglG4GHIl10CLrsfTIQEoroxWIgV/tcinmNz0ZqIamj
         Pzry7a3rEPjlDkMYKq27NmCjti/wh1CnrzMuX6xkPF8zIqaCEWjXwPpO5fGR9+xW8X7T
         do6AG+0vy7p0I8vzcbZxNJxxaq21NJpSIIfXE/MqiveYJloDMUWZGnkhj1BVn73XFixR
         JD2tIGwX9g/0lvAs19sNflQ4KIT1CZi83KcZVZ1OasbaTiIjjK5TbyzM45o+4QSikmkG
         eIEw==
X-Gm-Message-State: ACgBeo1vhaehatlK1xTu5FZe4fjz1JanFfG7vAqFq673lrxlxc94ldRg
        w6ZhMzW+qRVrWbKgcaKZpIceTxDcOqgf3Fwq
X-Google-Smtp-Source: AA6agR4tbsiuV+55k3uLthG1xa62JOInULLm5dADGQ0Tnvgqc6nrbLmo9+ADu6B6cwzXIqlsGlR2cQ==
X-Received: by 2002:a05:6402:34ce:b0:43d:c2ce:6e8a with SMTP id w14-20020a05640234ce00b0043dc2ce6e8amr12533685edc.160.1659534651253;
        Wed, 03 Aug 2022 06:50:51 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id la20-20020a170907781400b0072b7d76211dsm7279150ejc.107.2022.08.03.06.50.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 06:50:49 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id z17so16966991wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:50:48 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr16303940wrr.583.1659534647816; Wed, 03
 Aug 2022 06:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.4.I7b3c72949883846badb073cfeae985c55239da1d@changeid> <232f875a-4986-300a-f1e8-18f2da3a8fc6@linaro.org>
In-Reply-To: <232f875a-4986-300a-f1e8-18f2da3a8fc6@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Aug 2022 06:50:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWxMis61zouPeAoTUC6xYz7rSUC33wdvyLii0Cd2j4Ww@mail.gmail.com>
Message-ID: <CAD=FV=XWxMis61zouPeAoTUC6xYz7rSUC33wdvyLii0Cd2j4Ww@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] drm/msm/dsi: Use the new regulator bulk feature to
 specify the load
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 3, 2022 at 12:12 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 03/08/2022 01:37, Douglas Anderson wrote:
> > As of commit 6eabfc018e8d ("regulator: core: Allow specifying an
> > initial load w/ the bulk API") we can now specify the initial load in
> > the bulk data rather than having to manually call regulator_set_load()
> > on each regulator. Let's use it.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> It might have been better, if the previous patch had only removed the
> load_setting on disable and inlined the dsi_host_regulator_disable().
> Then this patch would drop the regulator_set_load() from
> dsi_host_regulator_enable() path and inline it. Then it would have been
> more obvious that after these two changes the time when we set loads is
> not changed.

Seems like I should post a v4 to update the commit message of the
final patch in the series, but I'm going to leave this the way it is
since the end result is the same. Originally when I wrote the series I
didn't know if the new regulator API changes would be accepted, so the
previous patch did the most cleanup it could do with the old API. ;-)

-Doug
