Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768594896D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiAJK5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244301AbiAJK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:57:40 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6DFC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:57:39 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e17so2293593pgg.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 02:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/d//iXcvScFsS0QFG+KfjeysK3dVRYehHeXn/qZMF0=;
        b=HS5Yr71lnN19txyrnE+hh7IH7NiptHECau7hysX67+PRmWzEEBssnq23eTWrUlDAWo
         tzib9q2i8eh3HJZ0o9XyavdlX/t70lI/hpSLnOlqm9xQX8K366BpAhkThlHeaFDS2ARL
         lGIG8GgAtRdTXHXJMld9sgD17TVt13nYOrBuW+kh+HGmmeta3X+CaeOwxh6vfFbxED7z
         vy+1/S6rWiuT6iS7CW0NOdqgl1CnjOxzUU48/tmHkBGfPixXMX4SuFRGcN9VQZFvGiq7
         4oS1k0dv6PDnR8gcsaeXVuKDyX+hGSzoQpZP6qjD/riOYy14RTHTyHekp2XqwuGt9Q9p
         7MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/d//iXcvScFsS0QFG+KfjeysK3dVRYehHeXn/qZMF0=;
        b=UtU0NSkC3ImlY4389/lC40dB4YMVIyjjPgmJ/K9OE36HuVzf6lIZfR9a8ExQRYGB3X
         zeTGD3WS0b62LBaT7K1Pi8bTUUlwC1Jmu6Z3q/VDmFIl8shD5VnDoXfAn04jrjFKjWYH
         OR6bzUP3JaieyABlVVg8gk+YIf0Qb2CKLQG5nmzF6x1mneXhoNSxLgwz47hAjA3KOcGl
         6v9gIN09Hq+bUGv4/H8tRq9vzWvp5mi6PgwMTiND7mkeS3+YdZkn6iYb/dKNK9axSsuK
         tvkvUdZaM5Lja/VnXypaoy2L8bWhpm+zCAI7GwKt96NVncxybWLshaygjqYd4tzcJmZN
         IsMA==
X-Gm-Message-State: AOAM532nPbXcptDbz9YM9UQTXydu9TKiL3aFaacJOjcZjmJq9/W8Djjo
        Qjx9oBLnCFoP3lXs31z0CzruD2LreMdE5XHOI4B6Og==
X-Google-Smtp-Source: ABdhPJxewZSFmncqdt+aIYkjVjxgUAgUZXseR9yJSWIN6IiOi/ELijCRc1d2oxYKYMgw46GSFH37ke9r4b1b5EIxjZM=
X-Received: by 2002:a63:7c51:: with SMTP id l17mr4785548pgn.178.1641812258383;
 Mon, 10 Jan 2022 02:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20220106100127.1862702-1-xji@analogixsemi.com> <20220106100127.1862702-3-xji@analogixsemi.com>
In-Reply-To: <20220106100127.1862702-3-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 10 Jan 2022 11:57:27 +0100
Message-ID: <CAG3jFytyKqwQkG8soz28tr75=xq76BR01ROoCoSM7qiioeBGBg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/bridge: anx7625: add audio codec .get_eld support
To:     Xin Ji <xji@analogixsemi.com>
Cc:     andrzej.hajda@intel.com, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied series to drm-misc-next
