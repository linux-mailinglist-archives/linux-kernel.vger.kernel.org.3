Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3052F47B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353498AbiETUff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353501AbiETUfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:35:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB6F19FB25
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:35:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gh17so4589707ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUvHmCiaUykxHI8OvIFLVAwT2TJ4ujC+7HAZA4KLm9o=;
        b=E7VekmNmqzzPvnMy92tHR6mFRFrwHRPFMUmM3juUv3W7Caij6EZHqbPF7ji6Ppk5ak
         cLMD4QdxKzTo9OL54y8cUEo8NCYpKVhEHKEn+bt4ImwfTax8nV5J7UHC/HtAlpSHRNly
         +trvejQGwU/eryTVgCTqDvA6Vvw0FwAohxVZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUvHmCiaUykxHI8OvIFLVAwT2TJ4ujC+7HAZA4KLm9o=;
        b=5ZBwtjXVpAsk2PAENi7Hw9tZf07VfHxnTF68ZKlNrs1o5/WKPL/EH4gklDnOG/ZKmY
         6H7Y1H3MjRwi29LHfpILe3I5ThfwIRhDFLPCPAH4bonJcazFVc9mMHurqlRPBxWSbDii
         WSGP+YBS/CIWG3BZeC0OBb7CtIriCZfayFF0LVgeivBvAZ8WSyngFvGOAn58SRrrmwjO
         8kdSBBda3s3DiZWoUOHQ2t6RB3v9NbzHV7i47lO/96WXuuAsnb7z4xbvzSID8ThrlZve
         4UlraRD5V/BOrlbrU7FspKjEq9RSAmUNdXswXtLttVCXstNpIJFXx3+BUFmLF/dtCVm7
         M9yw==
X-Gm-Message-State: AOAM530fiXoFsJYLKJgW5xI534R0f7cNcaYDJtwrbzLL1/2YEKM/NLOC
        aT+4R/JrNdes2dDNHPqfeA5QUqDAV7CmnFdmZy8=
X-Google-Smtp-Source: ABdhPJyj7qZEtQqn6AuprvKb5TJ3YfDgmveZ92aBqWpj8XqKGo92C/KB/Ql83MlEpY0cT46hwo/0Zw==
X-Received: by 2002:a17:907:8a14:b0:6f4:4365:dc07 with SMTP id sc20-20020a1709078a1400b006f44365dc07mr9821028ejc.693.1653078930015;
        Fri, 20 May 2022 13:35:30 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7dcc7000000b0042617ba6383sm4765625edu.13.2022.05.20.13.35.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 13:35:29 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso4951875wmp.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:35:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4f13:b0:394:8978:7707 with SMTP id
 l19-20020a05600c4f1300b0039489787707mr10309201wmq.34.1653078530208; Fri, 20
 May 2022 13:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220510192944.2408515-1-dianders@chromium.org>
 <20220510122726.v3.3.Iba4b9bf6c7a1ee5ea2835ad7bd5eaf84d7688520@changeid> <CAA8EJpqBnR_-YaNj-hc6fjfeRX-aTBhuzCFKg77QEyANu37cnA@mail.gmail.com>
In-Reply-To: <CAA8EJpqBnR_-YaNj-hc6fjfeRX-aTBhuzCFKg77QEyANu37cnA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 13:28:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VBkCZXL-6LnHMSCOwbUn5t8m0bhLRVh7R64w0Ce6FOvg@mail.gmail.com>
Message-ID: <CAD=FV=VBkCZXL-6LnHMSCOwbUn5t8m0bhLRVh7R64w0Ce6FOvg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: Add devm_drm_bridge_add()
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 10, 2022 at 5:22 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 10 May 2022 at 22:30, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > This adds a devm managed version of drm_bridge_add(). Like other
> > "devm" function listed in drm_bridge.h, this function takes an
> > explicit "dev" to use for the lifetime management. A few notes:
> > * In general we have a "struct device" for bridges that makes a good
> >   candidate for where the lifetime matches exactly what we want.
> > * The "bridge->dev->dev" device appears to be the encoder
> >   device. That's not the right device to use for lifetime management.
> >
> > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks for the review! For now I'll hold off on landing this until
sometime has time to review the other patches in the series. While not
technically required, it seems weird to add the devm function without
any callers.

-Doug
