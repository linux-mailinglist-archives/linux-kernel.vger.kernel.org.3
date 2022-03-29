Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EBC4EB1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiC2Qi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiC2Qiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:38:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA3973058
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:37:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bq8so22325618ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbJk0tnKIVIGfOYC3TDZlX4uGjeQKwVPpyRczD7tbFk=;
        b=K22KiM1d/xsIZkexASjSgNs8svDl3aD0kPeEa1JQfSfINsXxJ7HcVaM8mccdfRxXBj
         1JlsSV3RtwXllgCf6PYJH+ZAN1lYhTedkQhP8XJ7qkfnEyldYxkMp3FlnFHkXjUntFXL
         7cat0tJr/MYu4d+EWFFGx9P44wtA1tUDrjH54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbJk0tnKIVIGfOYC3TDZlX4uGjeQKwVPpyRczD7tbFk=;
        b=vAt/Ev6hFyDw9DX4EL4I2lZtMo/6ES9mwU+2nUCe7Wso8XGOJ/KrhGxvx4eQNV25pA
         znklYgDi5hUqeekCOlvFcMOXMuSdwsUpYOEJsELGUHI3dq1slTd2lVj7xEb+bCr3RpfG
         GkUoLYp9G3KKUZCpxfwfoGUYtVbqsoNFFWWgxa5jVB7xi0eWbH6PYw73+mTYlnUbqJjp
         rn3TWeEj6RI22nQ36I/4KoBuC84wY37X/+TFyiw9zg5XMtzG2Js4KjAIwhFmQ+5mR0ZH
         LR7E9Pb4p2McdFEHiTnl3CifFL41W3HUD6bhzu1ij0nbKiFAWC77ythPhIAZhaUlkQN/
         kJ9Q==
X-Gm-Message-State: AOAM530zaHtVcZQ6J063NCd+PI5X8HsH3pJzygf/CKnhbVHR2Tr5ypLh
        rrEZFgOtY9iimHKsg5ESGsDS3/HpK0BeUyDN
X-Google-Smtp-Source: ABdhPJw1kjX7GRfdwqVfhgiUzOsumnpeaLoThqFGgHcsimMy0r3RLGZxTJoVaAKxco7t+Ql2G14G0g==
X-Received: by 2002:a17:906:c148:b0:6e0:2196:9251 with SMTP id dp8-20020a170906c14800b006e021969251mr35190887ejc.180.1648571830513;
        Tue, 29 Mar 2022 09:37:10 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm7188298ejc.64.2022.03.29.09.37.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 09:37:08 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id n35so10668198wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:37:08 -0700 (PDT)
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id
 o24-20020a1c7518000000b0037c07ebf255mr677656wmc.29.1648571827704; Tue, 29 Mar
 2022 09:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220324134819.v2.1.I816014b6c62da5a33af5021f3cc35cea66552c00@changeid>
 <CAD=FV=UdRzeHio5Vo+zmXDt9a8oUwXiZyHvxkqjx4HVcrx7W-g@mail.gmail.com>
In-Reply-To: <CAD=FV=UdRzeHio5Vo+zmXDt9a8oUwXiZyHvxkqjx4HVcrx7W-g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Mar 2022 09:36:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqO1E_pvChX-mBy3T+bOuWt+SoJD2MgW2Njzxosohxhw@mail.gmail.com>
Message-ID: <CAD=FV=WqO1E_pvChX-mBy3T+bOuWt+SoJD2MgW2Njzxosohxhw@mail.gmail.com>
Subject: Re: [PATCH v2] panel-edp: drm/panel-edp: Add AUO B133UAN01
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 24, 2022 at 1:51 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Mar 24, 2022 at 1:48 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Add support for the AUO B133UAN01 13.3" WUXGA panel.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> > Changes in v2:
> > - autodetect and configure the panel based on the EDID data instead of
> >   relying on a compatible string and hardcoded mode settings.
> >
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Given the trivial nature of this change, I'll plan to land it in a few
> days barring someone else yelling about it.

I modified the patch subject slightly since the extra "panel-edp:"
prefix was redundant, then pushed to drm-misc-next:

ec57376fba5a drm/panel-edp: Add AUO B133UAN01

-Doug
