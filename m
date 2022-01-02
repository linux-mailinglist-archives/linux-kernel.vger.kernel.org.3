Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EF0482A1A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 07:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiABGSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 01:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiABGR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 01:17:58 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF73FC061746
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 22:17:57 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i31so68472164lfv.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 22:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iC7A+GoR8RwKEFgUsuTtN/Q+BKY7a0f+GB28CxnS1+8=;
        b=EINnMhs6LPEv3m6DkNvSnaeGNwGSWEal/4Gvy41xt8Gz7JvcWUehAeGnHGc9w18cC/
         9AqXW7Xkl2yaz8zK+T0PkXB9E9yhz8EvogGdimkVLnTQ/caxU9qx9zWGdlo8SNHsF0lQ
         WXrHBsFLFebrbVS4AwYJ4ECo12nRXcDJIm2o8+YCIEA1ef5DTwzs5UByuKPpnkwIuWWv
         txrSShZA/0OpCm1DXp1q2wO9g7RWLOyROOOXFpN9Qs3jksXIZ6W+mNMLd4gqfpaeYKJR
         NFrfEZ8++NAvZe/M6ozutMW3QuyEmnFRZ/Pn9D9LOQncZndpqy9hqbVMybX4Uo3xy8NX
         5tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iC7A+GoR8RwKEFgUsuTtN/Q+BKY7a0f+GB28CxnS1+8=;
        b=wPjHASJ2pprPY4csptinMjJlq5RnQ/uUhU/0TK9wPJQD1vCPixl2/Q6x4ALBC+2Cby
         1o8pbJ4Z6ZuAVVnjJXMh8EPHX4Z2ftjfDjSxTl7esj2/JloSbnE/lPfYS3B/Ds1Ys4/X
         w98rkisVWZKt1F1hnmuyO+iAC3sSP4FMtKwL/7GZ1x+o0Nsz/+DqDhR3FRlPEck7GUDt
         PI0WA37s40P0X7dcxPTe5J5CFZDMaoNub0WmTmhG4IlJzgCvsPmZrdUbewzUGITLGKcM
         qvtLaWtjnS0ZO2K8PVl0Ask82UwTV/fU1MjjK9pgOuxW5tmuIKVMItHUXHy6zn0jg6ez
         9pvw==
X-Gm-Message-State: AOAM530XGDPrEJpcX/M1cT1cvNeZF5u0wQCn8eVrNFvACuIqYys+nIhF
        bshOvfif6lVWiAj1Hc2jIz2swsg4rzpacVlGqTVD3g==
X-Google-Smtp-Source: ABdhPJwULsbFGX/DZNANVtAff9Bt8eVxG0y9VQmg8HurFIplcLKzs8UUUcAzDGECT5bKHr22NRhPANGVwYZPhZgN4uo=
X-Received: by 2002:ac2:5445:: with SMTP id d5mr37503031lfn.349.1641104276112;
 Sat, 01 Jan 2022 22:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-32-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-32-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:17:43 +0100
Message-ID: <CACRpkdbQgF6WHTJWgM6w++SWG7M8m7KViVqAim7K+-m+8wUzow@mail.gmail.com>
Subject: Re: [PATCH 31/34] brcmfmac: fwil: Constify iovar name arguments
To:     Hector Martin <marcan@marcan.st>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "Daniel (Deognyoun) Kim" <dekim@broadcom.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 4:40 PM Hector Martin <marcan@marcan.st> wrote:

> Make all the iovar name arguments const char * instead of just char *.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
