Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A4648CFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiAMBDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiAMBDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:03:01 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B47C061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:03:01 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i14so4120186ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tolh3fWC8TzEFvR0VYDqmge8PKhESkhvv8oEEP8Bf/E=;
        b=DUaImKW4iNccfk54IyZZJnpJecwSSeSobRWp8u89j4HUEsFQE8MsHVfuSlYkQSEhUI
         Z0j/sc4J9KiunrdW8P+yG3Q+mm9bMgK4yLACViPVZtGSV99RnleBTlWB8yWzzykNQFk6
         AuEfF63NVZ4XuNRXJYbIIVtNLLjjKpTtZBc4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tolh3fWC8TzEFvR0VYDqmge8PKhESkhvv8oEEP8Bf/E=;
        b=6TKQjWkefiQ0JDQdQAA7WtLHy4KlzHs1VHUHSPyyf9re9h2raQKCHg+y6JqldXCSb+
         ynIFFq36742b4NVmTlXIkiSm5fJHXI8xmbPvMhk6krYS+MmmRf8FXf6JwK0pZN4WRX4d
         9ALAXxH11X8Funu3D1g7kns2a/rGl3kSEj/lp4sAOZ9sKc0QVn1UYXwZYpF3WmrTG070
         M0xN8Kb8k1m9nNqJbKNpR5z0EcWeutIN5/rbqmbsDxnq4cYUOlGFywCvFG+Jn0RgJkRf
         P/JUpW0TEhrovQZ9FwBdGuV43XQEDPNJ2iR+50ee4dwz95z7cICvsrxXfml/iNdg+knP
         K4mw==
X-Gm-Message-State: AOAM532dfU7nwsFLvAIHxxqi31qi8cBm+jztxlo09QhdW+IeMGvTVefs
        UwgnpbYdywozib/z9IfE7s4hol6pE3iP+g==
X-Google-Smtp-Source: ABdhPJzzKmjDUr6gNMaQzFTWgpsbOlVIGtaTijmFBcqFaZbMaZb6AjQKz1Sl1VU4T15xB1RE9jxOFA==
X-Received: by 2002:a05:6e02:1a66:: with SMTP id w6mr1220647ilv.209.1642035779969;
        Wed, 12 Jan 2022 17:02:59 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id z5sm1042352ioq.49.2022.01.12.17.02.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 17:02:59 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id z17so2133296ilm.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:02:59 -0800 (PST)
X-Received: by 2002:a05:6e02:20e6:: with SMTP id q6mr1247332ilv.180.1642035779032;
 Wed, 12 Jan 2022 17:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20220112191048.837236-1-mka@chromium.org> <20220112111028.v19.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
In-Reply-To: <20220112111028.v19.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Jan 2022 17:02:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xt79oe=wCOpBqE-Y6wKbOV+77-BXVnxb9itozcX0WjPQ@mail.gmail.com>
Message-ID: <CAD=FV=Xt79oe=wCOpBqE-Y6wKbOV+77-BXVnxb9itozcX0WjPQ@mail.gmail.com>
Subject: Re: [PATCH v19 2/5] driver core: Export device_is_bound()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 12, 2022 at 11:11 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Export device_is_bound() to enable its use by drivers that are
> built as modules.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v19:
> - none
>
> Changes in v18:
> - patch added to the series
>
>  drivers/base/dd.c | 1 +
>  1 file changed, 1 insertion(+)

Though it's probably above my pay grade to do so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
