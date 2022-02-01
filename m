Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4124A5CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiBAM5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:57:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233789AbiBAM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQ6uizHs+T+wChsJ+DeQUo8BHktCkFmAePt89tVO1n8=;
        b=ADMKW1aG1TCJFDOZ01rveUJzNJcUF8cscxkn08cC7LI2DiX3TwISSm73vBYWKk1eOfaZRk
        5iZB4/1vm1wnHE0au+jn2goEWd7vDS19Euh01jL42jniGfuhAvhmKWh/ITOrgmScUky2Bw
        GZPmQAzaid8Ykxurd9Ldu0bcssPdo3g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-l1QI40yOOkiuBFDck7CYdw-1; Tue, 01 Feb 2022 07:57:05 -0500
X-MC-Unique: l1QI40yOOkiuBFDck7CYdw-1
Received: by mail-ej1-f69.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so6450914ejw.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 04:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KQ6uizHs+T+wChsJ+DeQUo8BHktCkFmAePt89tVO1n8=;
        b=hTyB3STC9iyhlz60HgfHjL7uYX7IWq3p22f5/Irzetl3IxpF0fNKxx6mGKSonxWlXm
         e+GJGlOfABOpFVKTFy6sLBgjh578LF7/+KFygfkhtI3tXYqaMRTd9ph/Wx/ce86464K4
         csPD5DI8I6CnQdwFWW9dVXJbJ+Ck6Vl5+F3wQOd+IPPuxsX8gN9CGhDThkex/nj2LVBs
         QR1x1sIiKuT1m1h+3DOz7H9ipWjaXX8PhzKoGjqKc68k3hX04C7J0elEhyCejCkfmca5
         T28nKZIsXS8fOQbK7SBFNSgUsrlB/PrPH43RXknyNwnacZsultrEqVG3xNwTBiNZokUJ
         z6qg==
X-Gm-Message-State: AOAM532XAmmcolod06U+rqvVBcJ+mY7ojKiUdAUwgDQDUupj5zvgibde
        Ipk5jhw3WKoFVtAQ9dWH1WOGcJK3wT0HBFpinNrf3O/32z3mzWPIDkG2cEOqatNC9N3otjyqhgW
        a77hadvssWU6GYmdTpT7/MD+7
X-Received: by 2002:a17:907:9816:: with SMTP id ji22mr12429456ejc.749.1643720224025;
        Tue, 01 Feb 2022 04:57:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWjr5Jp9grpxqx8hkic0kbma5PCsPcdjCNZZ93EtP+eq3QIEt7zcDM5f5WOomgiSu9D2jh4A==
X-Received: by 2002:a17:907:9816:: with SMTP id ji22mr12429451ejc.749.1643720223833;
        Tue, 01 Feb 2022 04:57:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id lm6sm14439602ejb.46.2022.02.01.04.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 04:57:02 -0800 (PST)
Message-ID: <01e51bfa-5107-fbd0-6a0b-82bca6c78e8e@redhat.com>
Date:   Tue, 1 Feb 2022 13:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 0/4] hwmon: (sch56xx) Automatically load on supported
 hardware
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220131211935.3656-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220131211935.3656-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/31/22 22:19, Armin Wolf wrote:
> The hardware monitoring solutions supported by the sch5627 and
> sch5636 drivers are Fujitsu-specific.
> After some online searching, i found out that the solution used
> with the SCH5627 is called "Antiope" by Fujitsu, just like the
> "Theseus" solution inside the SCH5636.
> I also found out that "Antiope" and "Theseus" are listed as
> DMI onboard devices on supported Fujitsu devices, so the
> sch56xx_common module can be loaded automatically an check
> for the DMI devices. However some devices like the Esprimo C700
> have both devices, so after verifying that at least one onboard
> device is present, sch56xx_common still has to detect which chip
> is present.
> This is safe however if at least one device is present.
> 
> Tested on a Fujitsu Esprimo P720.

Thanks, the new version of the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

> 
> ---
> Changes in v3:
> - fix usleep_range using the same value as msleep
> 
> Changes in v2:
> - fix unused variable issue reported by the kernel test robot
> by assinging the platform device id list in sch5627/sch5636
> to platform_driver->id_table.
> 
> Armin Wolf (4):
>   hwmon: (sch56xx) Autoload modules on platform device creation
>   hwmon: (sch56xx-common) Add automatic module loading on supported
>     devices
>   hwmon: (sch56xx-common) Replace msleep() with usleep_range()
>   hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING
> 
>  drivers/hwmon/sch5627.c        | 10 ++++++++
>  drivers/hwmon/sch5636.c        | 10 ++++++++
>  drivers/hwmon/sch56xx-common.c | 44 ++++++++++++++++++++++++++++++----
>  3 files changed, 60 insertions(+), 4 deletions(-)
> 
> --
> 2.30.2
> 

