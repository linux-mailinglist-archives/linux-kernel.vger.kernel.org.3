Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD73253343E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242897AbiEYAU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiEYAUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:20:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40770901
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:20:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id rs12so26776468ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFNyhH2PA3ljDR5ctK4z4sd4lSPZnlCyP4REV9FrmG0=;
        b=atWef+0vCmx2JhZX3or/VLDUlzqQvaVadsgA7a2K6VVGhaF69s+puWkmzOaeg0+asP
         O1vbjspHUOIG2pAXNJuiSX+WrGw+bHTpwC9A+ov/SfFm1yYp1mh4oO5HU/qudPE+DYxp
         3+5zkA3cv6irqzWRwOaCYJJqZGcBnVKB4JMCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFNyhH2PA3ljDR5ctK4z4sd4lSPZnlCyP4REV9FrmG0=;
        b=JDdmcbJwz0NuDjADtk+EYLbtADKdzHn/nTp7iDNI+4ymh6m+/fs+QsBfaCs7ahZ4p5
         hE2ORAsoE0gFhKD66FXzLGEgKfyWbU28DKcQIG/hH6v58KGi7wv/SpKDUgsxKBavwNCH
         udhR+/zXi4pBmtI/ztrZiKNHhddjp5amfOPT9lPb54ipTMwYCm3sRms48xSiwkZ0VUHM
         NgHlULsu147mPPWTH705Ws2KeUhgAopP6LH8Nt1ws/nH8ee2dSEZbOidzrlYvE+FkH3z
         JuFD8+0R5ss43O7sbZaNSl8lx6wtgLvmaizOnlqO6FA/gEr1vjN5fNGz4uHs/hQfh3Io
         aC1w==
X-Gm-Message-State: AOAM532S4khaQuPH1sTLpuqvrOaCoAaRy2QPgH22Tvh3hr1cjEo1L7Mp
        EAewR9FDHRZL1o80TnuU+cQ4bNF/mXGwKZMAEFM=
X-Google-Smtp-Source: ABdhPJyr0N/NzkNSxZY/Xq1NtIJSKJc/8MkwD9IHNevIpN6QxEu1CzpR6wKiJcJZ5pR6LDV9Mip+AQ==
X-Received: by 2002:a17:906:3958:b0:6fe:90ef:c4b with SMTP id g24-20020a170906395800b006fe90ef0c4bmr27218124eje.36.1653438048898;
        Tue, 24 May 2022 17:20:48 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id z4-20020a05640240c400b0042617ba637fsm124692edb.9.2022.05.24.17.20.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 17:20:48 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id s28so27760926wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:20:47 -0700 (PDT)
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id
 8-20020a056000154800b0020fc4e3637amr15834745wry.513.1653438047238; Tue, 24
 May 2022 17:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <1653082028-10211-1-git-send-email-quic_khsieh@quicinc.com> <1653082028-10211-4-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1653082028-10211-4-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 May 2022 17:20:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vc2zSTHTdneE4yCypg2SO_0xVsEx69BuArDAF3nzSfWA@mail.gmail.com>
Message-ID: <CAD=FV=Vc2zSTHTdneE4yCypg2SO_0xVsEx69BuArDAF3nzSfWA@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] drm/msm/dp: delete vdda regulator related
 functions from eDP/DP controller
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 20, 2022 at 2:27 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> @@ -101,11 +101,6 @@ struct dp_reg_entry {
>         int disable_load;
>  };
>
> -struct dp_regulator_cfg {
> -       int num;
> -       struct dp_reg_entry regs[DP_DEV_REGULATOR_MAX];

You forgot to delete the #define of DP_DEV_REGULATOR_MAX earlier in this file.

Other than that, this looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
