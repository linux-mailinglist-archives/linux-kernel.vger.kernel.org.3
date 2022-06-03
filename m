Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D253CC44
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbiFCPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiFCPZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:25:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AEB27152
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:25:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so5521090ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/ErmsKgHRGBSbHIqeaw4XfKuXA04q3v6x85oN3ceSE=;
        b=nyfCnV8YZstnNR+xgQCiDZXUcsDanH2/VTv56tmrhsftNpvAv5FD/WtqKiepbFRifh
         kG1DJQ0o2QT8CgDaW0x7B7DsAWiGc4ilx4OC+hd/wDMQ7GP1yNwtBg2jNTpM5RnrnyfJ
         PNUCRLz/c7PtTqPFR3Vm7nLcBzN+AEhiBHGJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/ErmsKgHRGBSbHIqeaw4XfKuXA04q3v6x85oN3ceSE=;
        b=LAivAC96pXt/Zqio9cnjGqh7xWOcSGYT8wuOBMiV+/yYQiI0D3tbhnUE2ZL2Xy9I1C
         vmJUSoEPeCi16YQZ0SXqgAUCERhPeOtKJtSVfshNVSaSfu6LhO9Xf56k0ypOxMaUYlGg
         Ii/yVU+FqZFr0CusmpFmiXkPU+QXhkGIcZdYZue4QUMeyHBqZHGwWYAz20CM9wzpHMii
         gvNj6LcrHJODJFvDRwg4bS0EzR9H5KIy1psUDmVkLs2rWACAgVslpGj7TpVhH9RgH9Zv
         MZvkfC6pZvV/CHNadf+9pCVi02aWtdBXrZSSc7xsrAsNCYEHaWEDu3hI1TkPhu6mL0wQ
         kfYA==
X-Gm-Message-State: AOAM530OVHuPf+Kg1N9JUxMEti5lEyVgm2JjQs9Y56zi8FrQFP1GYd/c
        DRCw46cGfubL9cVOlEMX9xOXhrK864jie8Rho3E=
X-Google-Smtp-Source: ABdhPJwUPRYn1kP4arobQg1QgluwPXC0d9Vzk7X1CBRPWQ0YMA5T4GqKVP/pOQF6XZ8wddyUu7FArA==
X-Received: by 2002:a17:907:7b86:b0:70c:a99a:f525 with SMTP id ne6-20020a1709077b8600b0070ca99af525mr5557491ejc.606.1654269931500;
        Fri, 03 Jun 2022 08:25:31 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402000f00b0042e1cbc4471sm2079557edu.3.2022.06.03.08.25.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 08:25:30 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id d5-20020a05600c34c500b0039776acee62so4956973wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 08:25:29 -0700 (PDT)
X-Received: by 2002:a05:600c:2e53:b0:397:4730:ee7a with SMTP id
 q19-20020a05600c2e5300b003974730ee7amr37868828wmf.118.1654269487107; Fri, 03
 Jun 2022 08:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220228202532.869740-1-briannorris@chromium.org>
 <CA+ASDXNSThy7usMKkN22VBq2iyej7sCJ8CAmgnNvxDgZiMbukA@mail.gmail.com>
 <CA+ASDXMW14GqJUAogQ0=dVdamhTTGDzcMRv-8Cx-TaXShHxj+A@mail.gmail.com> <CAOw6vb+myB0gB1kPvwuL+T1Ka10gDN5rGS2hW+UG+-+K2NGz_w@mail.gmail.com>
In-Reply-To: <CAOw6vb+myB0gB1kPvwuL+T1Ka10gDN5rGS2hW+UG+-+K2NGz_w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Jun 2022 08:17:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1F61nDcoQz4w1pJX_=Zzt6sLH8bcsGrxxTpGs6=yZ4w@mail.gmail.com>
Message-ID: <CAD=FV=X1F61nDcoQz4w1pJX_=Zzt6sLH8bcsGrxxTpGs6=yZ4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: analogix_dp: Self-refresh state
 machine fixes
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liu Ying <victor.liu@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 3, 2022 at 8:11 AM Sean Paul <seanpaul@chromium.org> wrote:
>
> On Mon, May 23, 2022 at 5:51 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > On Thu, Mar 10, 2022 at 3:50 PM Brian Norris <briannorris@chromium.org> wrote:
> > > On Mon, Feb 28, 2022 at 12:25 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > > Ping for review? Sean, perhaps? (You already reviewed this on the
> > > Chromium tracker.)
> >
> > Ping
>
> Apologies for the delay. Please in future ping on irc/chat if you're
> waiting for review from me, my inbox is often neglected.
>
> The set still looks good to me,
>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

Unless someone yells, I'll plan to apply both patches to
drm-misc-fixes early next week, possibly Monday. Seems like if someone
was going to object to these they've had plenty of time up until now.

-Doug
