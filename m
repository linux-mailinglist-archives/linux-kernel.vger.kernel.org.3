Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83333543E48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiFHVKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiFHVKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:10:38 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C73247076
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:10:37 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id h187so16555967oif.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=vQ5zV0B7pOGodfXiebn/fw6Qsn79wg3GSx0QkLVitEw=;
        b=ObCYZH59GDh91oJjS1g4NaYPr30Lr7f0wbDD095I4UXcHZtR0hrOM+MBUuvujHIXDT
         /zkhcfJu5oxzatY1oEFxUHt241rMRO12JUOZAxXWXEETh6M9woaTvh2v/CnSQ+VC/vUN
         Qma3Pqt0uBLifXvw2Kn/wmDwqAnwyRD1xJ58E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=vQ5zV0B7pOGodfXiebn/fw6Qsn79wg3GSx0QkLVitEw=;
        b=gAO63LuVWLkHHcEVheaEIOyJ5s1KZwt89Cc+HhcSGPCs3tGUp1M7Ds7YhrfiDrQq66
         q7P4OaqIhPOeLfUg2p9j/O6N8ATSLVgw7mfwOU1XlxB+QWntXDUOK45hcTf8Yam2FXGa
         uYOriKtVGn+tBBquDWBYFV5YJQJj+PZ9avrWeATm5oy3SCgcOSGthtZh2WXIduUVh2gX
         bzEUscO7aN+gkOCEYoqzRXWHefazBxonIWeY/Tcwg/UhNUsHUoES7oE8K2yjQqt562i4
         46x4NSzn75jdIGw9J5oBqgwoPapHoP2l+Tsg4Te7fDhV9Mt1Qo+l77cQoLbVSbfrvjbe
         C0lA==
X-Gm-Message-State: AOAM530l6VnPzVsgZFrV+QCr+Oo72b9rlp+K2oIFC2ourtomaXwXQOgl
        e61DW1TIcsthX/Rz3lgW/JXT8lDkVbEHy9BGEENAEw==
X-Google-Smtp-Source: ABdhPJxThNPxKm6DBWNVQmje3sZQD/b9lnb/4/mWaU3otxajRxIYi8mOZwrmJwbJ1u1zTAMvjt2M+t4QGTd/X6Bb1gk=
X-Received: by 2002:a05:6808:e87:b0:32e:4789:d2c with SMTP id
 k7-20020a0568080e8700b0032e47890d2cmr3382495oil.193.1654722636454; Wed, 08
 Jun 2022 14:10:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 14:10:36 -0700
MIME-Version: 1.0
In-Reply-To: <20220608094816.2898692-4-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org> <20220608094816.2898692-4-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 14:10:35 -0700
Message-ID: <CAE-0n53Ey7wyc274krmFDk4x1HH5fVniCpNoxU5Vs_vBdzeamA@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] drm/panel: panel-edp: Implement .get_orientation callback
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

Quoting Hsin-Yi Wang (2022-06-08 02:48:11)
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
