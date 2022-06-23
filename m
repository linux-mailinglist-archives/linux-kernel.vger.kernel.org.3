Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97194558BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiFWXpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiFWXpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:45:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE9506E7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:45:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id pk21so1377459ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ikmHtD58shD6bwBLVpbuZjlxH1kCE1s2bn5lg6TI84=;
        b=Idb+m4MmDg0qMd2DH6fEfYzuuttvLSeFBYJHLxEIpsJQi14s4A53HQuCSN5EPUcDlu
         cHZr8bJG8h/PTgfMQpO0HbbedR/xKjdcHTojqasgMK1W7NG1vLAyJp2ONOWhpxRkyeua
         SwHT1Aus7rtxzv/TDgM3Hsx5fXimanh7yIQWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ikmHtD58shD6bwBLVpbuZjlxH1kCE1s2bn5lg6TI84=;
        b=wcnHcAi4Suy3a7pWzSrYAct8LCw/7QiW7Ovn0SfF35RjZPhf90oN4X/g5mrqY8kEKq
         DVoUpJEFWQbUgSS6v2YqpHB1+49E/BAFG9BU/A2+PM4WppbYAcytzSlyLPqPB/1YbHJ2
         mNsLkbBZcOXWgxRMbHqiMovmzpNB72x2j0/O0j+t9uCeVn5coONVLt5J/wN7MvgFBvi1
         fBxyTNy/kuoMhDQx3Z7LNSK4mnLj78boopnAqNPWTCvRmzEEi3c1yYVYKTdQaEmYHPL9
         eB1nJmgh4hfghn8hxfURx8f5ck98KEaQLY3x5kdlhpMOC+bF8KFaVyHa0x89MULW/o0d
         FJ+A==
X-Gm-Message-State: AJIora9RcxDzyFr0bRRRMxe5gs6n7QuId9qIK3BFBY2sCxdMh0xQvC+x
        HyMSyoQaXeahYMQp4b2qvwj52Iavp+3BUWtg
X-Google-Smtp-Source: AGRyM1vxXJ+z0I0K0jz5fZFsngyynwkvtYcHUlQhX02j+XSbNp/wBupdtVcxLQAkEH4+cTJbjo4miw==
X-Received: by 2002:a17:907:7f8c:b0:726:2c53:2f82 with SMTP id qk12-20020a1709077f8c00b007262c532f82mr1877405ejc.140.1656027907411;
        Thu, 23 Jun 2022 16:45:07 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id dx13-20020a170906a84d00b0070f7d1c5a18sm221727ejb.55.2022.06.23.16.45.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 16:45:06 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so2677897wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:45:05 -0700 (PDT)
X-Received: by 2002:a05:600c:22d9:b0:39c:4b1b:5f99 with SMTP id
 25-20020a05600c22d900b0039c4b1b5f99mr469227wmg.151.1656027905540; Thu, 23 Jun
 2022 16:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid>
In-Reply-To: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Jun 2022 16:44:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wsp6GA=L4GsEVjMqazgtw4qG40gtLq1HT++5e9eRrvTw@mail.gmail.com>
Message-ID: <CAD=FV=Wsp6GA=L4GsEVjMqazgtw4qG40gtLq1HT++5e9eRrvTw@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: vop: Don't crash for invalid duplicate_state()
To:     Brian Norris <briannorris@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Sean Paul <seanpaul@chromium.org>
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

On Fri, Jun 17, 2022 at 5:27 PM Brian Norris <briannorris@chromium.org> wrote:
>
> It's possible for users to try to duplicate the CRTC state even when the
> state doesn't exist. drm_atomic_helper_crtc_duplicate_state() (and other
> users of __drm_atomic_helper_crtc_duplicate_state()) already guard this
> with a WARN_ON() instead of crashing, so let's do that here too.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 +++
>  1 file changed, 3 insertions(+)

I'm not an expert in this area, but it makes sense to me to match
drm_atomic_helper_crtc_duplicate_state() in this way. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I would tend to assume that this would be landed in drm-misc by Heiko
if he's good with it. After several weeks of silence, however, I'll
commit it myself.

-Doug
