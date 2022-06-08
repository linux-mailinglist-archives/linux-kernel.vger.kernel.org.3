Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8E543E62
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiFHVNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiFHVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:13:01 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6738D405279
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:13:00 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id j8-20020a9d7d88000000b0060c1484c93eso2611233otn.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=zU2IqojqnmMw7oHCklReG2t+BVElCfqra7nD/0zeq60=;
        b=nL4lh+nhXy6KDiZMuEC7AZ+4T+CP3Ep054FT+G2lyrT98EsI9lclYve4NTngxRw4nj
         gYZnhWXCE+kV1tiFShrOpXOvU+rJpkUA8gsvKgpj3BnM5tTzUIxtVcWi4oo7qXu3+QW+
         p6qqZh7ij1fnnc73xDYW10Ir3V9zRzUW3F08M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=zU2IqojqnmMw7oHCklReG2t+BVElCfqra7nD/0zeq60=;
        b=6otWZYnajW4rAz/L20O7iSCPyJIvvZ+whkTD5XibFtHf2qpSxuRe4uTGZRMgv/ME8x
         EIRInNJeLDSTo94pw38TNdfDYiUFKRLvb/qVNRbLgkAjEs49pTsRC4z/8jGlPfl6EkEQ
         A8pXY+LZ4UbvO8UxApoYSlm1GLoX6fNnaqTC2X//8lvNG1EBVbt4RjnyF5eJLH80ZQAt
         JpLDqw58f4wYL9bTM3o33gXZ/DbkepPXbSGwbFSQDRIRzvz2HqBZDt2BXiApnwf0wZC6
         qw/UACq7KQGvRIjUo1uU+/HQRI/lmniSEV7cnMqoiwlcGCjIQpZZM0MoX9tObKLs1d7S
         QE8w==
X-Gm-Message-State: AOAM5327BUa/fok2y9+WjWsNMQUHPeFf8/beggW8RXc761pf0YYhaGGP
        z+u5uNO+P465eNugJwhAXKda09cNu52yQfK2Sz0qQQ==
X-Google-Smtp-Source: ABdhPJyR4UOJKCdH5PXUeGUCZIN4eiKjKZgdVngW7ipxNAeZ+R7k6eQQUsVT11umQLjPb0Qz/kSYO1exywAyN9vRN+o=
X-Received: by 2002:a9d:729b:0:b0:60c:21bd:97c0 with SMTP id
 t27-20020a9d729b000000b0060c21bd97c0mr617497otj.77.1654722779429; Wed, 08 Jun
 2022 14:12:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 14:12:59 -0700
MIME-Version: 1.0
In-Reply-To: <20220608094816.2898692-7-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org> <20220608094816.2898692-7-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 14:12:59 -0700
Message-ID: <CAE-0n50C0rJkoH=EPkXfqOPz9ZfODAfx6eimeV8VK8dxRXU_5Q@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] drm/panel: ili9881c: Implement .get_orientation callback
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

Quoting Hsin-Yi Wang (2022-06-08 02:48:14)
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
