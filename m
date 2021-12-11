Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ACF4716EC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhLKV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhLKV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:57:25 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68FC061714;
        Sat, 11 Dec 2021 13:57:24 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 07868202E0;
        Sat, 11 Dec 2021 22:57:20 +0100 (CET)
Date:   Sat, 11 Dec 2021 22:57:18 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, robdclark@gmail.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        abhinavk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org
Subject: Re: [PATCH v2 2/2] drm/msm/dpu: Fix timeout issues on command mode
 panels
Message-ID: <20211211215718.pe675o5wvculxavc@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, abhinavk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20210911163919.47173-1-angelogioacchino.delregno@somainline.org>
 <20210911163919.47173-2-angelogioacchino.delregno@somainline.org>
 <b325fc8d-e06b-36de-b40a-b5ffbcebb1c5@linaro.org>
 <94bedea3-0e5f-5ae8-79d1-ceb17ccdea23@somainline.org>
 <20211211213528.uroqfdksvokspbxf@SoMainline.org>
 <CAA8EJprT5gcWOsS5jJk8egUpxutBpUdW2Pnh-8FFXhgOd3hr=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprT5gcWOsS5jJk8egUpxutBpUdW2Pnh-8FFXhgOd3hr=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-12 00:49:09, Dmitry Baryshkov wrote:
> On Sun, 12 Dec 2021 at 00:35, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> > [..]
> > On this note, does it perhaps make more sense to call the "internal"
> > _dpu_encoder_phys_cmd_wait_for_idle function directly, instead of going
> > through the "public" dpu_encoder_phys_cmd_wait_for_tx_complete which
> > seems solely intended to handle the wait_for_tx_complete callback?
> 
> Either one would work. The main difference is the error message. Do
> you want to see it here if the wait times out or not?

I prefer calling _dpu_encoder_phys_cmd_wait_for_idle directly and
optionally adding our own error message.  IIRC DRM_ERROR prints source
information such as the function this originated from, and that makes it
impossible to distinguish between the wait_for_tx_complete callback or
the invocation through dpu_encoder_phys_cmd_wait_for_commit_done anyway.

- Marijn
