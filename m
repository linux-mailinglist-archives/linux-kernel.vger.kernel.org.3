Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F206247F349
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 14:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhLYNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 08:05:37 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54940
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231734AbhLYNFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 08:05:36 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1DC353F1A9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 13:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640437530;
        bh=5vgRgsACjyf0KpwZ4x9GcJr9J4OAYwXoNUUUezQLgDc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mrBxaNboGGkBzjwYzds86DoqJZMEQV3GRjfbojidYgWgDButKBIKbM2xydv0m/1N8
         ket00qf2gmTeEE7bWzE1YXZVkobDdMSgdYvWPquNqXD2TTrtc17MWyzNV6divnLfSW
         vZO4ykzjn1If3//C50Oq2ML3wXwj5KxVWGVpFDEyk779qoR8mN/81OL2staDxaVPc9
         GF3XDHSO6HUHeC3wMPLjalMKGC/hB1zBitT8yuM8iKyw/eKzVeEpiblDElgE/EP+Xr
         Y3wCUekaqUIpMkd+ZE8RWyNPWZDa9E7Mf/KvDYFyCArFOjOqKlbcsPhi6Pk0xKje2i
         ZoXsSZYZqSjYg==
Received: by mail-oi1-f197.google.com with SMTP id be34-20020a05680821a200b002bd24f9a87bso6245506oib.17
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 05:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vgRgsACjyf0KpwZ4x9GcJr9J4OAYwXoNUUUezQLgDc=;
        b=4yHewR0XnlhJp3Z9F9PcBPD1p9efSu5hCzQcOVMqaxOLZ6rjX/HNA1Fd0NYyQb1Cur
         hJ8XO/supIWaK1kIJPgOu4+yFt+P5mfM8Md5hv2YslxvunXE65mfX8Gf3M+S+01GZn/p
         deCP1iDoPBEBdXMvJsQ5+KNcY0P1z8YSRTN3Vvd9jqN5/SSTNstM0ZUjxHz39s+MZG40
         Hhny6PsGqg9TwGFrb/fTpbEZv+yQG2qQr95USZWbWVmq6O3e3h00BSiHo5NtXB4DPk6C
         X48TLbVriz6g2IYhzeB3QYo1erWWwT6ErP6HF/ghmSTQdB9b/sQ1OX0RwY9SHjH6LEo+
         iIBw==
X-Gm-Message-State: AOAM533lP0LyjL0NGqR987YAaAsT3Bv+AS58pYKwpFqEeInF3RXFpjfr
        n2bTVr3nCM/VjZ0tSSglW3ogZvaYAFuG256O6QyCkyznqGDUE1eVVwgINGyKqIN33/zaGMKOLfe
        xGXILXh+UIUl7Xevf/ezXiKSyTiN031JZRBuOTfSQ1hSvbqiOrwl1pNPRhQ==
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr7775522oib.98.1640437528976;
        Sat, 25 Dec 2021 05:05:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywtcV8AugdqKTUuFYNwYzhOpgFEsipGaIvGTQ7BlGJn7EdZ03wzS7bG4U9zk080L/wAGwxtR5BygeeP15fWjk=
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr7775512oib.98.1640437528728;
 Sat, 25 Dec 2021 05:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20211224145903.368999-1-kai.heng.feng@canonical.com> <CAHp75Vd3RhVUe_Yoz-fPErzYcV=+gtOVsxNTmn2_52JbSUaMaA@mail.gmail.com>
In-Reply-To: <CAHp75Vd3RhVUe_Yoz-fPErzYcV=+gtOVsxNTmn2_52JbSUaMaA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Sat, 25 Dec 2021 21:05:17 +0800
Message-ID: <CAAd53p7bu=+bs5c2Y1LQLC7fPLUihNX_QHw-yOh=fUKUdXWWhg@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hdc100x: Add ACPI HID table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chris Lesiak <chris.lesiak@licor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 7:32 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Friday, December 24, 2021, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>> x86 boards may use ACPI HID "HDC1010" to for hdc100x device.
>>
>> So add an ACPI match table for that accordingly.
>
>
> No. We do not add abusing IDs blindly.
> Why this is in use? Is the creative creator of that informed that is an ACPI spec abuse?

Can you please elaborate more on this topic? How is this an ACPI spec abuse?
I did suggest them to use PRP0001, but I also don't think this is an abuse.

> What devices are those? Is it available on the market? Where is the link to DSDT?

It's not on the market yet. Do you need the full DSDT? Or just the
part of the ACPI device?
I'll need approve from customer to disclose these info.

>
> Does TI has an ID for that?

I was told by customer this is approved by TI.

>
> NAK until all above is answered in the commit message and all parties are informed.

OK, I hope this can be resolved.

Kai-Heng

>
>
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/iio/humidity/hdc100x.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
>> index 9e0fce917ce4c..ad1dfac543c52 100644
>> --- a/drivers/iio/humidity/hdc100x.c
>> +++ b/drivers/iio/humidity/hdc100x.c
>> @@ -417,10 +417,18 @@ static const struct of_device_id hdc100x_dt_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
>>
>> +static const struct acpi_device_id hdc100x_acpi_match[] = {
>> +       {"HDC1010"},
>> +       { },
>
>
> No comma.
>
>>
>> +};
>> +
>> +MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);
>> +
>>  static struct i2c_driver hdc100x_driver = {
>>         .driver = {
>>                 .name   = "hdc100x",
>>                 .of_match_table = hdc100x_dt_ids,
>> +               .acpi_match_table = ACPI_PTR(hdc100x_acpi_match),
>
>
> Use of ACPI_PTR() is wrong here.
>
>>
>>         },
>>         .probe = hdc100x_probe,
>>         .id_table = hdc100x_id,
>> --
>> 2.33.1
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
