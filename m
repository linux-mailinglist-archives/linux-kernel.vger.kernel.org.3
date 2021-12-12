Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DFB471D07
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 21:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhLLUpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 15:45:44 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:35357 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhLLUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:45:43 -0500
Received: by mail-ed1-f45.google.com with SMTP id v1so46470627edx.2;
        Sun, 12 Dec 2021 12:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+jU9TwvZz6ds629SS50NuvlyPyvUin2EKXsAKDkl/o=;
        b=Pr2ikDq7xsSvxFAivbHPkZIV8HPbXwdpCqXi2zI+6xayw3kbod0NYGr8i0ux558xSz
         5rLgXDOKiw3VYqkP14SIe5VJBZB0dlfAkCkFIytjzQootQnJSnrqvvssc2yO0z8dpp9Q
         krGJYoPXhz6svZylYG0XN171BcetGyW6Wa9PBmF7bUhFOPE3erVAZHnhiLxtZSt6pI1t
         3KySp9F6XX6bbVB4FLRBZKp4K08BvS+Zr7mTF837VT646cnuL7ForINYG8G4InT2UlBA
         f70GJLvJGwsql0agMOgcb5yvcwJx45IhR7uxdHOFYB100K3auJoHFhLvpeMhL+a9M3Se
         K41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+jU9TwvZz6ds629SS50NuvlyPyvUin2EKXsAKDkl/o=;
        b=twZQ6Mh1MRDigr9Sx4Cjmec9pkVdD1BAEbJJqD5znzs2/KCZL70382RKQTmAFFThZg
         ORBm0sL/pbyszXjiFlZigkZsABhI8WeOehbjxafD+2K5RhRUndFhRgO4cgh7m89QVKSj
         wpbdp63tGHoAVdz2ylWql8Z036H1Dc4pZu3ITvKZJGGVE1F1i87TNcFeAME/KzvKh/HY
         30NhiYP4FZbFn7msJ/WoNS7+NCPzxpZjZNJnDcxsQUrM5AfRClygTsVUtcEUv1ZWqMdw
         j+Z3xixNboTBpCjub0zqFbrqgdu98zgrIFyLC29EBBQXY54TD9jXvpnt01vEvRgtsNPA
         InpQ==
X-Gm-Message-State: AOAM533IghIFECT4EU5B7fs5vRFukjEsqxq1z9Ej1OYLfxeiTKLcoX+J
        iLnsxp+klRBrKFHlvwmh6jQOkKBjvC99p3TnQCo=
X-Google-Smtp-Source: ABdhPJxkmlWd+BZwRjj9CSpXloG+l68GfRzkIvb5IJeOu55RSbLqR0+VCFVVVWUBho//vQZicGVrSVp3uoY2qAc8Nvk=
X-Received: by 2002:a05:6402:2792:: with SMTP id b18mr57454758ede.329.1639341882173;
 Sun, 12 Dec 2021 12:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20211212201844.114949-1-aouledameur@baylibre.com> <20211212201844.114949-4-aouledameur@baylibre.com>
In-Reply-To: <20211212201844.114949-4-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 12 Dec 2021 21:44:31 +0100
Message-ID: <CAFBinCDnDxVj+Gtue2oA3u4jnTDmca6Dr-CTKcpkqGCLSRtALA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] phy: amlogic: meson8b-usb2: fix shared reset
 control use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     khilman@baylibre.com, p.zabel@pengutronix.de, balbi@kernel.org,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 9:20 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Use reset_control_rearm() call if an error occurs in case
> phy_meson8b_usb2_power_on() fails after reset() has been called, or in
> case phy_meson8b_usb2_power_off() is called i.e the resource is no longer
> used and the reset line may be triggered again by other devices.
>
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework, use of reset_control_reset() on shared reset line should
> be balanced with reset_control_rearm().
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
