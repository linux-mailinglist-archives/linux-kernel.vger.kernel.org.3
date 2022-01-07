Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1934871B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346056AbiAGEOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:14:18 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:32810
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346050AbiAGEOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:14:17 -0500
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 573E3402E0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 04:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641528856;
        bh=KN7zr37vFNHmq3As7p02jWEskyOVas7n+GBnbQV3xBM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=awUOQMhmILl0gi0nl++vBSWNn7L/FF/zmmZbWfFtelGWUlvVXnL34GPvMPvyoyXW1
         zBe5eT5hjxK8AQPqfg1T4wKsOBZxc2CSYFWW971qZtwsJKxeLcS6IfC/tivhDP+AVK
         aqW0bpNJGd9TBdLu+oZscNUFrtzGBZicJvBE7k0BQN6ZMEU6+1ie7h6JamqyZ8rMSL
         rCf7ZCELtNnOnA3NvhdIG+U7i59/tKX7O+5Wma4KvSVHreDYJfUeo/y1d4SdZoM66l
         DItdHK2mJHJFpJL+girBQgK69/9Ixm7zJ+P8M7UuTX9rol5G4OGwHKYLNMF7DMejH7
         K31ZiKpYRM+bQ==
Received: by mail-oo1-f72.google.com with SMTP id r2-20020a4a3702000000b002daa363a4faso2785996oor.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 20:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KN7zr37vFNHmq3As7p02jWEskyOVas7n+GBnbQV3xBM=;
        b=mQDPAWh1M3zR5+KZErNcDujGJW2KSy4vKIWVV5tHPv4WO9/7OAW4OK46il1f2hYOVi
         bZMKkmGTYRrRwI9A2d0l+D6ZysFYi5QhPjaUK54sWVajA/u6wOnumAf/5+5GVgas2fH6
         v/TqjNcZxuDBf+OdLRjCSQav9q7JpeJ6jfDDCopKBtbryiOYw/WWqE+lr5rBGdSHe/MK
         WBRhX7cX+mKMNlbCSAzgwKKFSo9GO4dBwrt5o3B8yQ2MGvAwsolcbMc3T/FCbrdclvnL
         qu+X9zMKltnONKt4LtG1bZmyrBDLhmlzK+vf2mhohtr0p8a1aZ/wPwiwbo4M2rlgbhBV
         tUyQ==
X-Gm-Message-State: AOAM533uasCqkQ1TCkoCHKk5LrHZoBlfuf165GYWYkWBj+ybuRJUkfmr
        q8d1kON1KeUg6DiAo9inZRMSfaRD4hCSkd0KFgffwiny0s26WQIYP3Nk6n81R7a5BZiEpSuTr7v
        Y8oD2CKPkPFrlMPeG8tCBYy0E8mtMxBYZ9fhozZR3+3eTc741hHB6OjFqqw==
X-Received: by 2002:a9d:6e8d:: with SMTP id a13mr3325111otr.269.1641528854878;
        Thu, 06 Jan 2022 20:14:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXyFaB7Xi1kpQZoP4YuMgov2PjKuP7iY/5uQwXAbieQMuxBCtvmJXJocnDAGSO2UZ5hq8oOuPWkcbUdahDf4o=
X-Received: by 2002:a9d:6e8d:: with SMTP id a13mr3325099otr.269.1641528854653;
 Thu, 06 Jan 2022 20:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20220106041257.927664-1-kai.heng.feng@canonical.com> <CAHp75VdxV+4_yxJv1H1MZPpu02e2gHUkP55dduUqN7QJ2j6aGg@mail.gmail.com>
In-Reply-To: <CAHp75VdxV+4_yxJv1H1MZPpu02e2gHUkP55dduUqN7QJ2j6aGg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 7 Jan 2022 12:14:03 +0800
Message-ID: <CAAd53p4nUDtuVmkFCqv2R1KEvGYQyLu+ibxJOsoUZs-SM6LuHw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: humidity: hdc100x: Add ACPI HID table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 10:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jan 6, 2022 at 6:13 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > x86 boards may use ACPI HID "TXN1010" to for hdc100x device.
>
> to for --> for the

Will correct it.

>
> > So add an ACPI match table for that accordingly.
>
> ...
>
> >  - Change the ID to follow ACPI Spec
>
> Is there any evidence Texas Instrument allocated this ID, or you just
> created it yourself?
> Please, add an excerpt from email from them to confirm this.

Sure, let me ask our customer to provide the excerpt.

>
> ...
>
> > +static const struct acpi_device_id __maybe_unused hdc100x_acpi_match[] = {
> > +       { "TXN1010" },
>
> > +       { },
>
> No comma is needed.

Got it.

>
> > +};
>
> > +
>
> No blank line is needed.

Will update.

>
> > +MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);
>
> ...
>
> > +               .acpi_match_table = ACPI_PTR(hdc100x_acpi_match),
>
> It's the wrong usage of ACPI_PTR().

Can you please explain a bit more?

ACPI_PTR() turns the value to NULL when ACPI is not enabled, seems to
be correct?
Not to mention most other drivers also use ACPI_PTR() for acpi_match_table.

>
> >         },
>
> All the comments are applicable to all your patches. Some of them I
> already commented on and even kbuild bot has sent you a complaint.

That one should be solved by adding __maybe_unused to acpi_device_id array.

Kai-Heng

>
> --
> With Best Regards,
> Andy Shevchenko
