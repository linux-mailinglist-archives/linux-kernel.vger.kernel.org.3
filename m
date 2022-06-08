Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2055543E67
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiFHVNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiFHVMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:12:49 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E253FE0DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:12:42 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id v5-20020a4ae045000000b0041b770b8a13so2015934oos.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=hQ3IV3/ZgkYf70xRZku6s6da0sJmVdJtXd3Stc7Z+94=;
        b=nLwHtBbwYTTVuA6Y2XxUYiXbCQe8igJ+yjqCM/Uy9hflLIY+xeH7VlvUvCMjCG/ljw
         lhGbX/iZPFY4GvB3s85kGp14z97NYCCdJnUtbgkVYToUWmP+uLISbv/WFQH2nm+Qxu8x
         XFMjWLHfSE3xcmFGu9gm439+rIRFZc1uO4Hsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=hQ3IV3/ZgkYf70xRZku6s6da0sJmVdJtXd3Stc7Z+94=;
        b=umy0BbKQiBelD0CoK//bS9xDzMQnO88qACKsrqv1uOZPq/LCgV2ts8OonGbHy0U4VA
         nQAcGYYLguaD3EUbIlAIsjeGOV6IiBswGrmxwwn2CK+207GhiAaBDhOu3COYJHGy/975
         KTBmR/4G0YLF6ZNJaK6zFFyGd/Tv3B7WtODz7buitfmT5jiZTBaI1WVGDzEXBowIim5Z
         ww7Yib7EtPq8yM0BQQPsK8heNg0E4Z2Yj2Vz83HHU/OEaZR6ga6IHEjWRXZ2ADnGMuEM
         sAn3h2n/G1AFd2AaRWFtZ1tqanbU4jZEfsQG8dLTS1d9/TbIZEzLRlVBnn/OgNt7Ju5A
         XQ6A==
X-Gm-Message-State: AOAM5327t5WjZ1t6I7EANXg7Ri1YD+8TEKy5blrD0PeC7k8nUtHw2sLP
        lt35Q5YornbRdyHWWtwvGtul5hEZXSn1gDqS4oQlhZw9yyw=
X-Google-Smtp-Source: ABdhPJwjGeXpq5/LR/zc84DPsGPwvGYWM0t2vZmF7kf3QNbvzQ/3l2tprk8LtLHXYaUVSSSwOaJJi4HX6Hr2p41sFZU=
X-Received: by 2002:a4a:d547:0:b0:41b:3ade:c99f with SMTP id
 q7-20020a4ad547000000b0041b3adec99fmr14181891oos.25.1654722761756; Wed, 08
 Jun 2022 14:12:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 14:12:41 -0700
MIME-Version: 1.0
In-Reply-To: <20220608094816.2898692-8-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org> <20220608094816.2898692-8-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 14:12:41 -0700
Message-ID: <CAE-0n52UBMstzZLeg99TvDUhgVJ+7KLBc2bFYEA1jz4=sYDsLg@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] drm/panel: elida-kd35t133: Implement
 .get_orientation callback
To:     Douglas Anderson <dianders@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2022-06-08 02:48:15)
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
