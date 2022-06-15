Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA86354C9EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352753AbiFONgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352387AbiFONgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:36:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880C369F5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:36:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kq6so23270158ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zWnIQisaB23D1MVkJ7LO1Hk7sla55AkBqlxsG0Kthk=;
        b=DvQrJZOuXygLUHJr/UWGOxHJtFOET4POoEljY1Do+Nnqmr68OTk1L3WIgHJ5UVGARJ
         Nrf/2YD5NtlIolg9/TqczLw9ELFHgikQ6bwDqUGcHrVU8r8xGembhNekxtGZAYc/ZMsm
         w0II+sD69A1OUbKbLmBOceE/RXOy3t5uC2dYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zWnIQisaB23D1MVkJ7LO1Hk7sla55AkBqlxsG0Kthk=;
        b=Gy1SeOLC7cg77jV3/6TKHx5DA+NUo4kUiOXKjGiizdo3GuYkve4SiAQxTyEE75uEDj
         1f/M3Z95c4QWC1Oi7D3LmaaNv7a3f4e2ISTHN2mr99wpQ/wnIboYXFFbiY7NDuzZZAa5
         F2kDpEkRsopqB73GGpc8HwyIBv6Y2uwYgY/2EiYGh0rgGc1F9B6EFeop4ZzDnK2JbT2Q
         TSNYTrATnXLWcNIYoffIQBYMQwthcsFx22jyGZVp87Fl7HmmiHGVFKMAlPktjQuHcX9z
         LlQNMH1asv5V+sOzzdPSR/VTLxO2XAmyPZGEH4IMKCPTEg1MUrB8WTPBDA+kOJE3cXJx
         SEOA==
X-Gm-Message-State: AOAM531gJkdTxGloScCXTJH1+BBttSJoihF5hsaK+fEdz2iYY1oh1D7s
        TZxgvpA4gaBZhRm8fu43kxC2F2mmWeNcYnU3
X-Google-Smtp-Source: ABdhPJyBJ+tbEYaIb7cx3UPVFe5WmYz7i9bjvpzU/QTjOBXNVk08kQODgGm1x+F5NksnirQbZDNzgw==
X-Received: by 2002:a17:906:36c8:b0:718:d02b:479e with SMTP id b8-20020a17090636c800b00718d02b479emr8778574ejc.613.1655300188929;
        Wed, 15 Jun 2022 06:36:28 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id v14-20020a056402348e00b0042dc25fdf5bsm9669939edc.29.2022.06.15.06.36.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 06:36:27 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h5so15475035wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:36:26 -0700 (PDT)
X-Received: by 2002:a05:6000:1685:b0:218:45f0:5be6 with SMTP id
 y5-20020a056000168500b0021845f05be6mr10368799wrd.301.1655300186122; Wed, 15
 Jun 2022 06:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220609072722.3488207-1-hsinyi@chromium.org> <CAJMQK-hg5kLUV=ZgVN5=qX=bRiBWx3O-4X9wPF6CwxpQVSuinA@mail.gmail.com>
In-Reply-To: <CAJMQK-hg5kLUV=ZgVN5=qX=bRiBWx3O-4X9wPF6CwxpQVSuinA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jun 2022 06:36:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMjSu9pJHj+2L7vrVocDkn4+VcPQ07tNKZMfj4qUYgYA@mail.gmail.com>
Message-ID: <CAD=FV=XMjSu9pJHj+2L7vrVocDkn4+VcPQ07tNKZMfj4qUYgYA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add a panel API to set orientation properly
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi,

On Tue, Jun 14, 2022 at 10:50 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Thu, Jun 9, 2022 at 3:27 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Panels usually call drm_connector_set_panel_orientation(), which is
> > later than drm/kms driver calling drm_dev_register(). This leads to a
> > WARN()[1].
> >
> > The orientation property is known earlier. For example, some panels
> > parse the property through device tree during probe.
> >
> > The series add a panel API drm_connector_set_orientation_from_panel()
> > for drm/kms drivers. The drivers can call the API to set panel's
> > orientation before drm_dev_register().
> >
> > Panel needs to implement .get_orientation callback to return the property.
> >
> > [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/
> >
> > Hsin-Yi Wang (8):
> >   drm/panel: Add an API to allow drm to set orientation from panel
> >   drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
> >   drm/panel: panel-edp: Implement .get_orientation callback
> >   drm/panel: lvds: Implement .get_orientation callback
> >   drm/panel: panel-simple: Implement .get_orientation callback
> >   drm/panel: ili9881c: Implement .get_orientation callback
> >   drm/panel: elida-kd35t133: Implement .get_orientation callback
> >   drm: Config orientation property if panel provides it
> >
> hi Maintainers,
>
> All the patches are reviewed. If there's no other comments, will this
> series be picked? Thanks.

Unless someone beat me to it or yells, my plan was to land them to
drm-misc-next next week. Since it touches core code I wanted to give a
little extra time. Also at the moment patch #8 is all Chromium (all
author and reviewers are chromium.org) at the moment so that's another
reason to make sure it has sufficient time on the lists.

-Doug
