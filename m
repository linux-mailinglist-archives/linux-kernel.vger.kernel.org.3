Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAAD531E39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiEWVwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiEWVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:51:58 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000BFB0D34
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:51:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r3-20020a9d5cc3000000b0060ae1789875so8768321oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8SrzKwXbwxEUVDgvvMve7Yi3txpWp8p+iQJgO5oLAk=;
        b=iohk/agXfsij0LTxGdU0vY6kpIgx4QqFuvhQEnzmWnnDNBRfp7M+LaYZhlEqiOM+PD
         5Ofsc/QN1DC5SCtQ8cTlukZabTVMItX/J9cVbGmwqSVtQVsxHaKZnORw2esG2MBxarHq
         LHaKztBDVV9SBBmVYUc7/xgb0bTh0We+ra5CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8SrzKwXbwxEUVDgvvMve7Yi3txpWp8p+iQJgO5oLAk=;
        b=LoUBNDY6qqdWFFuDGjRDCtfE/SDfbFcxPjGd4GGs2MzhR2q4nJx9+qtJ8FlCGxmFoJ
         6YIowM93zW/T298damr7YxxulNpK9OK0IMZOE1BOr/oOABqncNiF/TVPV0UDZvmoVKvt
         LTBcVm+z6Z7Xz45DUjSt3fpxY4TeN40O5kfGwhqauHN4zwCmqJqqH3D5QuZXYILOHP3y
         BgjRuMPoymY5HeQSvKAZiZQxXS/xqSYDtGf0Lth4xxnqmwC32b4q4ka3GDeTnK/i35y4
         rwiAIv5zfFnpJm8+yHgOJBWOEATNCL/I+Wbu0DYzn5llinrBslyHNX9VvEDnZrdODbrq
         3WcA==
X-Gm-Message-State: AOAM531MX7b7ovrat/9xsGS6feM3XNbG6Td1YxaxTk+bVipEQxQHijU6
        IZ8/Q1jmbawpAo/CHNCOS7+QbgFi0DZuvA==
X-Google-Smtp-Source: ABdhPJyNhF51Ma7p3W0Kn1kJ6C8fHN2MBEcTJ+DteyRQWUjH0Uae0ghwnYBz1xcLgnntfXBMreVMBw==
X-Received: by 2002:a9d:2f61:0:b0:5e9:4bfb:61cc with SMTP id h88-20020a9d2f61000000b005e94bfb61ccmr9030819otb.355.1653342717048;
        Mon, 23 May 2022 14:51:57 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id l6-20020a056871068600b000e686d1389esm4400385oao.56.2022.05.23.14.51.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 14:51:54 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l84so2077063oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:51:54 -0700 (PDT)
X-Received: by 2002:aca:5e84:0:b0:2ec:9c1d:fc77 with SMTP id
 s126-20020aca5e84000000b002ec9c1dfc77mr600365oib.291.1653342713974; Mon, 23
 May 2022 14:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220228202532.869740-1-briannorris@chromium.org> <CA+ASDXNSThy7usMKkN22VBq2iyej7sCJ8CAmgnNvxDgZiMbukA@mail.gmail.com>
In-Reply-To: <CA+ASDXNSThy7usMKkN22VBq2iyej7sCJ8CAmgnNvxDgZiMbukA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 23 May 2022 14:51:42 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMW14GqJUAogQ0=dVdamhTTGDzcMRv-8Cx-TaXShHxj+A@mail.gmail.com>
Message-ID: <CA+ASDXMW14GqJUAogQ0=dVdamhTTGDzcMRv-8Cx-TaXShHxj+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: analogix_dp: Self-refresh state
 machine fixes
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liu Ying <victor.liu@oss.nxp.com>,
        Doug Anderson <dianders@chromium.org>
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

On Thu, Mar 10, 2022 at 3:50 PM Brian Norris <briannorris@chromium.org> wrote:
> On Mon, Feb 28, 2022 at 12:25 PM Brian Norris <briannorris@chromium.org> wrote:

> Ping for review? Sean, perhaps? (You already reviewed this on the
> Chromium tracker.)

Ping
