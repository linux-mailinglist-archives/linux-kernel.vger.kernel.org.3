Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F204742AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhLNMeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:34:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231742AbhLNMeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639485251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i9NmLeQ63zbolJJY9i+NPxINNjB3b7pDhuEfJE8U834=;
        b=FAyNqfFWXXlCJt4ybePSwYmuVsID5869j0TYcfHUTJnYgQHHGruRAxnQjxhpNopGeeOjna
        fM+wSmBGr5gB6sMwnAzQO5Vpyw7d3y82ckz07bvfw6d2oqCyw/igUec3K3keR1cxDsg58q
        1MjTGtHfXbikaUPeiRnJIWcsq3/2FzU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-BVzqpAoCMIqLoqdTTItBgg-1; Tue, 14 Dec 2021 07:34:10 -0500
X-MC-Unique: BVzqpAoCMIqLoqdTTItBgg-1
Received: by mail-pf1-f200.google.com with SMTP id a207-20020a621ad8000000b004aed6f7ec3fso11751798pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 04:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9NmLeQ63zbolJJY9i+NPxINNjB3b7pDhuEfJE8U834=;
        b=69buDRywj/fZQ9z7krPB8Xrd7syjs/jrB0tedPZU2OWH/srK8TfhqGlxhsP4vDPQfZ
         KvPfCPvQL/Ua4k9GhXrzMtJZQ0dfWd+Lm1j2UK51K4f6qfLauWq2H2miNVpvBznvLc5E
         yfMJJuJpEUJxfYPA7ghZaLUkaGktFm8b6hxhDZ37Fi0FB4+YVSySrwQASzBdsmq3POKO
         WRkNJa7p8j70OkfhkW4CIclmDjY7Fr3w3hbxUzUmIXud/uZOCzXov/s7jlZJkMUC2bmc
         S8Gm4a8wOmFhqSgR60bczWTdlm2x2Tdco9xmo3sMMPFksx/ztqbmEtbYwpf4E78Ebmnf
         Owcw==
X-Gm-Message-State: AOAM533ig3CD+gFxQOZvM/P4v6NzvWHK3oXSOXEq0MWIdxWv7Wt8TYRp
        1bwhKnjKw7zl07mURWI8mGtcSnwhcBPIgkr2wQCsD67Q65sPfil3KNltbah//mnLsLi8ts8+LYW
        3k98xppOnoZLXFcyYU40/SCdVnRsIQxx4yWDv9SF1
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr5215109pjb.246.1639485249344;
        Tue, 14 Dec 2021 04:34:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5YR0Aa198Pk+lvjUVrHei/CKU1OPDDwxRs0X6Sr1wL0nXnz1E7Z1AY0z+ShuLhaM7+s66tK87q/VZkdu2SUI=
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr5215082pjb.246.1639485249101;
 Tue, 14 Dec 2021 04:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20211208124045.61815-1-alistair@alistair23.me>
In-Reply-To: <20211208124045.61815-1-alistair@alistair23.me>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 14 Dec 2021 13:33:58 +0100
Message-ID: <CAO-hwJKtetKFcFiD_gwgLmKoxhMrUsOKeuEacUoqeWx+bcKQ_g@mail.gmail.com>
Subject: Re: [PATCH v16 0/3] Add Wacom I2C support to rM2
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jason Gerecke <Jason.Gerecke@wacom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Ping Cheng <Ping.Cheng@wacom.com>,
        DTML <devicetree@vger.kernel.org>, martin.chen@wacom.com,
        tatsunosuke.tobita@wacom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 1:40 PM Alistair Francis <alistair@alistair23.me> wrote:
>
> Add Wacom I2C support for the reMarkable 2 eInk tablet using the
> generic I2C HID framework.
>
> v16:
>  - Add commit message to DTS patch
>
> Alistair Francis (3):
>   HID: quirks: Allow inverting the absolute X/Y values
>   HID: i2c-hid-of: Expose the touchscreen-inverted properties

Given that those 2 patches and the third are independent, I took the
first 2 ones through the hid tree, branch for-5.17/core.

FWIW, I fixed the few checkpatch warnings before applying them.

Thanks and sorry it took so long to get merged.

I'll let Shawn merge the DT patch.

Cheers,
Benjamin


>   ARM: dts: imx7d: remarkable2: add wacom digitizer device
>
>  .../bindings/input/hid-over-i2c.txt           |  2 +
>  arch/arm/boot/dts/imx7d-remarkable2.dts       | 59 +++++++++++++++++++
>  drivers/hid/hid-input.c                       |  6 ++
>  drivers/hid/i2c-hid/i2c-hid-acpi.c            |  2 +-
>  drivers/hid/i2c-hid/i2c-hid-core.c            |  4 +-
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c       |  2 +-
>  drivers/hid/i2c-hid/i2c-hid-of.c              | 11 +++-
>  drivers/hid/i2c-hid/i2c-hid.h                 |  2 +-
>  include/linux/hid.h                           |  2 +
>  9 files changed, 85 insertions(+), 5 deletions(-)
>
> --
> 2.31.1
>
>

