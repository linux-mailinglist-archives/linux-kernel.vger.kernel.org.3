Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C1C4A47AB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378391AbiAaNAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbiAaNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:00:37 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E4C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:00:36 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i2so2539562ilm.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSdj6+/sfksSA1uArlRQHiUhIJOWxGXX+eQ0rGayhu4=;
        b=J1xqT4WdO+z9nBPjGXWQQTsijFA3X8Ksw+wJJXK/vOuUo/cQKQcSRkP5Omdgcy5luX
         +YmdWF7nH2oHD1AnotOBWD3ovK3VpPU/K7wYAp8uClL91ZxAzVa2hL2bQbhUcWw4D3q2
         kb4ruW5s2SjojUtylRCcErcbp0cbk0B9pLObgbOW3Kc83ER/eeONMSyt0LXa/LL0RzaT
         HExbqB9d3n0761mfKYbc5JGfZZmn/sXQNPq7E7YSVI6UIIT70VvQWmV7bEUwLMgwIYWE
         CqfWaOtTiweXrQPG8s0Pc8aV+XmKDXybEJnzIYgKIzgBMgl9vO3kyxcoZkgdOiROC2+B
         i5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSdj6+/sfksSA1uArlRQHiUhIJOWxGXX+eQ0rGayhu4=;
        b=rLIKKYkUY9CeC224rBFTw7E2lemgurBbcHfkVYAQ+zDWcn2bK5rEqLGUkzZQBldDt2
         IoiSl6ZBZdZDdV7vhKW/y16SoTEDC99mSbmtabn2NrrT+upWkX2S/sPq7mNlJIZfKlwd
         LVij1TzXq9cBjf1xRyUuLEY1dFSTY+XcaTEYLcsgzKOQ59dgwTlmZNaBpY2KKxKVRkHE
         Gfj9Q3OuAoMp4QKQ1sSWKhiDvj+yTha7VTekXrQIkEHYw47EZSw2YVq97Wxy6GtLmd3/
         APhAjIO+xCjPjIihzaaAHhSUglZJP/OsgPkl9CmVAYmVcpObV3sS138CbJUU+KYRY1CV
         Rq0w==
X-Gm-Message-State: AOAM5334vG/TS+P1kNrKAQRPO1a7VaGP2fLQJ+ls5n/N9GU3VNevBwjm
        RkKA151cTCaBFH+GGwJjPAbHW5k7mN2PnH5VVLsd9A==
X-Google-Smtp-Source: ABdhPJzz9PBIZoI54/Sn7+tK+W6MwqqxsuFaxpqQ+8QZ+g2GlJrc0cvmg6zXfBoXxvr8tHXNTYJYIUAxBAWDvjNcVUE=
X-Received: by 2002:a92:8e0d:: with SMTP id c13mr11729336ild.159.1643634036343;
 Mon, 31 Jan 2022 05:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20220130145116.88406-1-nbd@nbd.name> <20220130145116.88406-4-nbd@nbd.name>
 <CAKQ-crhDHXZptWr5rO5Rb9JttQREoPqE4YO-6nzC2OWc-z06_g@mail.gmail.com> <04c91b4e-e7c8-ac6a-f60a-0453a49122fa@nbd.name>
In-Reply-To: <04c91b4e-e7c8-ac6a-f60a-0453a49122fa@nbd.name>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 31 Jan 2022 14:00:25 +0100
Message-ID: <CA+HBbNE5nRmFAR44gYMW+Uqi_5e4s+4wBGoQTUbnhC0Pdkc6iw@mail.gmail.com>
Subject: Re: [PATCH v9 03/13] ARM: Add basic support for Airoha EN7523 SoC
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        John Crispin <john@phrozen.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 1:57 PM Felix Fietkau <nbd@nbd.name> wrote:
>
>
> On 31.01.22 11:51, Luka Perkov wrote:
> > Hello Felix,
> >
> > On Sun, Jan 30, 2022 at 3:56 PM Felix Fietkau <nbd@nbd.name> wrote:
> >>
> >> From: John Crispin <john@phrozen.org>
> >>
> >> EN7523 is an armv8 based silicon used inside broadband access type devices
> >> such as xPON and xDSL. It shares various silicon blocks with MediaTek
> >> silicon such as the MT7622.
> >>
> >> Add basic support for Airoha EN7523, enough for booting to console.
> >>
> >> The UART is basically 8250-compatible, except for the clock selection.
> >> A clock-frequency value is synthesized to get this to run at 115200 bps.
> >>
> >> Signed-off-by: John Crispin <john@phrozen.org>
> >> Signed-off-by: Bert Vermeulen <bert@biot.com>
> >> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> >> ---
> >> index 000000000000..ea23b5abb478
> >> --- /dev/null
> >> +++ b/arch/arm/mach-airoha/airoha.c
> >> @@ -0,0 +1,16 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * Device Tree support for Airoha SoCs
> >> + *
> >> + * Copyright (c) 2022 Felix Fietkau <nbd@nbd.name>
> >> + */
> >> +#include <asm/mach/arch.h>
> >> +
> >> +static const char * const airoha_board_dt_compat[] = {
> >> +       "airoha,en7523",
> >> +       NULL,
> >> +};
> >> +
> >> +DT_MACHINE_START(MEDIATEK_DT, "Airoha Cortex-A53 (Device Tree)")
> >
> > Since this is Cortex-A53 core is there a reason why this is not placed
> > within arm64 directory?
>  From what I can tell, it's a stripped-down core that only runs in
> 32-bit mode.

Hmm, this is new for me that you could do that to an ARMv8 (A53) core.
I know that you can run ARMv7 code but not that you can reduce it to
32 bit only.

Regards,
Robert
>
> - Felix



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
