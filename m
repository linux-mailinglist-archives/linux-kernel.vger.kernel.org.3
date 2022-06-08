Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C0543E55
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiFHVNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbiFHVNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:13:31 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA533E0C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:13:30 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w16so19793384oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=5k2lXIDEokraHei/3DYd5toc4NljbiupbB9a2J4ktCM=;
        b=IKyGCewybNq/ZI5ZI8rwFTQc4RMHecpFlA6Sr294bP744cAsP+FMFaE7S+Izj5Pgsr
         bi78zZngqLumr8m/yfk8rwxl4Ia6FixggXylLiikaOAyOvLZFTYDcEZrBE279aF9WHCh
         ozjGevapw8S4vym5rOMGlXpwAh88TvZ1rrnxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=5k2lXIDEokraHei/3DYd5toc4NljbiupbB9a2J4ktCM=;
        b=l1aLcId6b9lhEvX5ExhGL1Cr7CSAh//7mVvpUu4jrugC1ujKcO2j+Pi4lZAnoNAgAk
         wJfoIdlyJ1oFM4BU0V9I8sOfL9AzLicjQn21qUBf+5ZBkxDSizn4QrnQvl+aKH2NP/IU
         3RZFjgi+oXanJPLAjs0XI8YJUxNVa0rxdmln1RQM+rnTB/JHh5nkh7C5w3IBKbz2428X
         JbsS583ZAHWppwFMg6NmLXcRY8P8faPbhRw1KNQAYPvLvRQrRRB9eFU5xkGojhobSTc6
         PLbAudsjU4AjoDeaL06I4/xh0P3Ugpkg8AocKtWpikjemXlHK1VGSCC5FE176VmIfjn/
         kecg==
X-Gm-Message-State: AOAM530cmtEe4Q/jNj5f1LMef7ttG0SmWx7sJaJHv3udcOouy968jIqR
        My862vH4CXodPgucytwGT30amOQ172GWeCr6eRVhZzwMIsU=
X-Google-Smtp-Source: ABdhPJwFB1+veA013diaL1hpc7zDl+bDQYmdQp2R/FPuKhRGEK6UJHYtZ6FE7vIIHppzs22TjDEAh6WxjTFUaZDzHJQ=
X-Received: by 2002:a05:6808:e87:b0:32e:4789:d2c with SMTP id
 k7-20020a0568080e8700b0032e47890d2cmr3389111oil.193.1654722809854; Wed, 08
 Jun 2022 14:13:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 14:13:29 -0700
MIME-Version: 1.0
In-Reply-To: <20220608094816.2898692-5-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org> <20220608094816.2898692-5-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 14:13:29 -0700
Message-ID: <CAE-0n519y4i+8RnRv0xUHuW+s3uDG4Cn8i0t5i3NCyUT-s=q-g@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] drm/panel: lvds: Implement .get_orientation callback
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

Quoting Hsin-Yi Wang (2022-06-08 02:48:12)
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
