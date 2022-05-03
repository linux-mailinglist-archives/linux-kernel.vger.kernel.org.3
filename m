Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C14518B64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbiECRuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiECRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:50:46 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791762717C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:47:12 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id w187so32369971ybe.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wH9AqNVAXAx+G8p70VLB9NLbw+BOxltF83VPYgsU5tU=;
        b=V6/QN94FhhxIxqe8YbyaOCHnphbTgJrBTkf0BsoQbw1QuH//ynFGSx01fnUpHsY+2f
         AKNPpBEP4ZaHDvIoEYvZUEdYNRB52cLValVbK5drg2y7PycdnKY0paVsWa/QPw+pqUvx
         y+CKExy99v2cxDrCvoO+IdjXElcDZkAEShcKYMjm6P8sQouiNjSJ/xnnJzSczk59X5vQ
         QvMmpELOhMPiNv6PmcZbys1gtAzlMXRVHA6YX/PXBivLKMoR0w/49P33V5fR2OBkg+Sz
         ACpuao1aCaguqwqD77zKnRE8J38NJSbtOTN0D6g5QhleEigk9WTLqcxvPvGwdG+cuxZB
         CEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wH9AqNVAXAx+G8p70VLB9NLbw+BOxltF83VPYgsU5tU=;
        b=g3bDeaHtz9gst6F6YF2sLgURsMZcAhK0higU/7LYiACmTh3/OlmvnQ3w2fpW/mHiHo
         LiCK9+rj1gnOt2KHR2CvYoPuoRRikab8dGT0qx7cRGlbfdwIDPqMoy+OMcMrqwb3I31r
         Y39Hfz9VFKukI824LQ8vPAAguxt6IeDWwOXqsOqiSV4y5QmCOtOdI3l0Q0ruZCuGZ07M
         CKi2YNsrUdujeP/h5uaXWh1RYWzJn0cj2W75SH/50frIvFEVLKAuouoVM7noUf0YRlLd
         kugEKNTJ4+sTVYqkywEx9zcD4CWg97oULkWQSOCRaGvNL+j2/MnAHeQIixghZntZGMZX
         lVdw==
X-Gm-Message-State: AOAM53378m4SeCdb8OYdWLpwDeRLnDqCVyoCnrEmf+v35G7Vg1Qy83kx
        MJapjMdQ67+emFHVbm9g9kjnXAZ9JRCQCSn1zpnyvw==
X-Google-Smtp-Source: ABdhPJxyfn/UPn8JhbzCElu45EEVIRaxIOY63aN6mUJjop+zXdOGi1to9G+/0FjgUmEdeI2Q9N+4Q/+PJGB3nZtwMMM=
X-Received: by 2002:a5b:dcc:0:b0:628:d6d9:d4bc with SMTP id
 t12-20020a5b0dcc000000b00628d6d9d4bcmr14393804ybr.178.1651600031693; Tue, 03
 May 2022 10:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220503130448.520470-1-robert.foss@linaro.org>
 <20220503130448.520470-6-robert.foss@linaro.org> <YnFlnbPsf6oBf+A1@builder.lan>
In-Reply-To: <YnFlnbPsf6oBf+A1@builder.lan>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 3 May 2022 19:47:00 +0200
Message-ID: <CAG3jFyuuAxN7OXyN3q8=avvi-5xVBC2Toa2Y_42ssFgHnU3j8A@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] clk: qcom: add support for SM8350 DISPCC
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2022 at 19:25, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Tue 03 May 08:04 CDT 2022, Robert Foss wrote:
>
> > From: Jonathan Marek <jonathan@marek.ca>
> >
> > Add support to the SM8350 display clock controller by extending the SM8250
> > display clock controller, which is almost identical but has some minor
> > differences.
> >
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> You handled this patch, as such your S-o-b should be here as well.
>

Ack
