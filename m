Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1BE48D118
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiAMDuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiAMDt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:49:58 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4117CC061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:49:58 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id g205so6109330oif.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=DffZCC3gp+QrdwopCraMiw2Fz2AdA2RrLD50prd3Lys=;
        b=RyUdABnUrLH8KSg658JabzEHkkYv5flXObpi6vdyVF8L6lBKRXWv5U4TXDwx7s31e8
         EYl6Ah8dbpXTBfzEG3t5bzc8rZ+PoMhxkgji6Uayp2Puiy8FyNx1NagddA7xw5tGlKqO
         OoeSKLSDXl33B7D5Ftsui/AEQdU3E8Jv7qqC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=DffZCC3gp+QrdwopCraMiw2Fz2AdA2RrLD50prd3Lys=;
        b=sayf3ugYdOrdNWiYVLS5318cFk7nxQfyz6ZzYEFd+mx7+uhsAEbnjutC5mQjgfGmGW
         wNULA68cjZdrL22TOluHyoCIVhASd38wRXWI8TGKjs1oKdUWn5GNxF20muurwIM1Zt3M
         X8k82gvbvK9f7HWuTiJfzVmQOzg/K2n9NMu8gcoEnt6S6IXVeoIDJ8yKmJgrCcpsHJom
         Dty+TE6dW87F+jxcdAS/AKu+MJoUgnGmr1Sv52QzBTer8Wwho98qSNU0Hrcn0fsLa7qY
         NDzKXp/XrDfH4NRwW/q6wAzv3T6AYUlAMzZ4OAMrrrr5239Ipcuh1F1mQ4Epsv+KbUcR
         GHGw==
X-Gm-Message-State: AOAM532b+2gfwnq0Ye/mpqYOVkgkvcoTygHmnxexGN8odgN7tUFRTIjf
        W4jD1yc5IzaWJ2DZJVM2HHJEBl29gvD+DZQn/wC7nyy/fRY=
X-Google-Smtp-Source: ABdhPJzmoPJYdpuj8kks6dwGO+ZfWwnyZXVNcMS7NjIYBS/0NL6eI6YqZyK24u/PZuBjqFa4aQsax3ZIQFTCicbvjYU=
X-Received: by 2002:aca:4382:: with SMTP id q124mr1931870oia.64.1642045797637;
 Wed, 12 Jan 2022 19:49:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Jan 2022 19:49:57 -0800
MIME-Version: 1.0
In-Reply-To: <20220112111028.v19.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
References: <20220112191048.837236-1-mka@chromium.org> <20220112111028.v19.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 12 Jan 2022 19:49:57 -0800
Message-ID: <CAE-0n50FqiuSwnN8wczXcDWnFmzzaz_ZdhHj-qRCw7SOEaB3Bw@mail.gmail.com>
Subject: Re: [PATCH v19 2/5] driver core: Export device_is_bound()
To:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-01-12 11:10:45)
> Export device_is_bound() to enable its use by drivers that are
> built as modules.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
