Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE31556C91C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiGILAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGILAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BAB966ADD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657364415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQBLs9X3UVmuSijYPcRlzWs6MdRhwWT1uwigpsmgrrA=;
        b=A03ASoGZPlioB2WYOGkYPI8Qx87sukDgv6BHpMKnXVzw1MAxE6XtWHDnzj8B9+ZhAypokh
        0yEPOaH3Si7uJuMHAPVRQG5Tl+S8zCdH3sEbBMfnczyKjC6AwqTM3POivhS9eXyX9eBrMC
        6EGLQ62POP65njiKBslGa9ULLfy2BbA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-zJZOWlPlMAC-0rNzL4K3MQ-1; Sat, 09 Jul 2022 07:00:14 -0400
X-MC-Unique: zJZOWlPlMAC-0rNzL4K3MQ-1
Received: by mail-ed1-f69.google.com with SMTP id y5-20020a056402358500b0043592ac3961so885314edc.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 04:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZQBLs9X3UVmuSijYPcRlzWs6MdRhwWT1uwigpsmgrrA=;
        b=CkkfE7+R8iArnd193H0tTmYWDb4UDgAeoYt3pIuAiknbsbVll69adynlOdHjLRrdwk
         WDxbPYf1UIzvP4sRMmfphUDWtoxdpNihrOetGj6lNAy3B1Ib/eKKMn/0LpF5MkRRkTcz
         u0vXzorqH0TiJUvsoTSfD3HEXY+lTxowF0D24ZPAbnytM/2mhCmEiZrqEFIrUEkALjFu
         C/9jz1uonaLutt2IzI1xJPtxq/nK1Y9UjdbKXk9WbsUMsoxD+mzOVb60SGc0F0M4ewdJ
         jPRz6yRuuyVlKflqimBNYy8M7UY/7bTHFM+OenfFdlXCogbT7OrnTFA6lKekyQDbdciA
         ZNhQ==
X-Gm-Message-State: AJIora8Md8QPk+e4tNL6DEhkvGZPeXzemr349sp98twbuhJ09sADbxaV
        I7NNSWDzKt4I0VzqFvoWEDfRVH+fZ0zTv9djrI+VQxH9r5Yg2Z6EQPD067DzypzOUDnj/oaNlHR
        ZqZ8kowTPA8yVC31Yl8meY7QJ
X-Received: by 2002:a17:907:7615:b0:72b:35a6:5992 with SMTP id jx21-20020a170907761500b0072b35a65992mr2438628ejc.97.1657364412703;
        Sat, 09 Jul 2022 04:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sY/i0u1cEw273KBJP+T3Jnpm4kGkd+snLcHDhEjCMSVpU29b4hjl/vIUymQ8xDKIp5nQ0RIg==
X-Received: by 2002:a17:907:7615:b0:72b:35a6:5992 with SMTP id jx21-20020a170907761500b0072b35a65992mr2438596ejc.97.1657364412366;
        Sat, 09 Jul 2022 04:00:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906c41700b0072b16a57cdcsm486818ejz.118.2022.07.09.04.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 04:00:11 -0700 (PDT)
Message-ID: <154a12ef-29a7-8189-1a5d-648dc92cffd3@redhat.com>
Date:   Sat, 9 Jul 2022 13:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 2/7] platform/x86: serial-multi-instantiate: Improve
 autodetection
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
 <20220709000636.35550-2-andriy.shevchenko@linux.intel.com>
 <9826f272-ed7d-1daa-c852-6f353258bb2b@redhat.com>
 <CAHp75VfVoTcZD7vXxXckxu-crsXr7m4bx8F9D9cs2TtBbyeYqQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VfVoTcZD7vXxXckxu-crsXr7m4bx8F9D9cs2TtBbyeYqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/9/22 11:52, Andy Shevchenko wrote:
> 
> 
> On Saturday, July 9, 2022, Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> wrote:
> 
>     Hi,
> 
>     On 7/9/22 02:06, Andy Shevchenko wrote:
>     > Instead of calling specific resource counter, let just probe each
>     > of the type and see what it says. Also add a debug message when
>     > none is found.
>     >
>     > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com <mailto:andriy.shevchenko@linux.intel.com>>
> 
>     Only probing for I2C resources if some are present is deliberate:
> 
>     commit 68f201f9061c000d7a4a9f359f021b1cd535d62b
>     Author: Stefan Binding <sbinding@opensource.cirrus.com <mailto:sbinding@opensource.cirrus.com>>
>     Date:   Fri Jan 21 17:24:29 2022 +0000
> 
>         platform/x86: serial-multi-instantiate: Add SPI support
> 
>         Add support for spi bus in serial-multi-instantiate driver
> 
>         Some peripherals can have either a I2C or a SPI connection
>         to the host (but not both) but use the same HID for both
>         types. So it is not possible to use the HID to determine
>         whether it is I2C or SPI. The driver must check the node
>         to see if it contains I2cSerialBus or SpiSerialBus entries.
> 
>         For backwards-compatibility with the existing nodes I2C is
>         checked first and if such entries are found ONLY I2C devices
>         are created. Since some existing nodes that were already
>         handled by this driver could also contain unrelated
>         SpiSerialBus nodes that were previously ignored, and this
>         preserves that behavior. If there is ever a need to handle
>         a node where both I2C and SPI devices must be instantiated
>         this can be added in future.
> 
>         Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com <mailto:sbinding@opensource.cirrus.com>>
>         Link: https://lore.kernel.org/r/20220121172431.6876-8-sbinding@opensource.cirrus.com <https://lore.kernel.org/r/20220121172431.6876-8-sbinding@opensource.cirrus.com>
>         Reviewed-by: Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>>
>         Signed-off-by: Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>>
> 
>     So nack for this 
> 
> 
> 
> This effectively means nack to the series.
> But it’s easy to fix. I can add check for ret == 0.

I don't see how this is a nack for the series, just drop 1/7 + 2/7
and rebase the rest. Yes there will be conflicts to resolve in
the rebase, but the rest of the cleanups can still go upstream
after the rebase.

Regards,

Hans



>     > ---
>     >  drivers/platform/x86/serial-multi-instantiate.c | 16 +++++++++++-----
>     >  1 file changed, 11 insertions(+), 5 deletions(-)
>     >
>     > diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
>     > index 97db23243018..e599058196bb 100644
>     > --- a/drivers/platform/x86/serial-multi-instantiate.c
>     > +++ b/drivers/platform/x86/serial-multi-instantiate.c
>     > @@ -232,6 +232,7 @@ static int smi_probe(struct platform_device *pdev)
>     >       const struct smi_node *node;
>     >       struct acpi_device *adev;
>     >       struct smi *smi;
>     > +     int ret;
>     > 
>     >       adev = ACPI_COMPANION(dev);
>     >       if (!adev)
>     > @@ -255,15 +256,20 @@ static int smi_probe(struct platform_device *pdev)
>     >       case SMI_SPI:
>     >               return smi_spi_probe(pdev, adev, smi, node->instances);
>     >       case SMI_AUTO_DETECT:
>     > -             if (i2c_acpi_client_count(adev) > 0)
>     > -                     return smi_i2c_probe(pdev, adev, smi, node->instances);
>     > -             else
>     > -                     return smi_spi_probe(pdev, adev, smi, node->instances);
>     > +             ret = smi_i2c_probe(pdev, adev, smi, node->instances);
>     > +             if (ret && ret != -ENOENT)
>     > +                     return ret;
>     > +             ret = smi_spi_probe(pdev, adev, smi, node->instances);
>     > +             if (ret && ret != -ENOENT)
>     > +                     return ret;
>     > +             if (ret)
>     > +                     return dev_err_probe(dev, ret, "Error No resources found\n");
>     > +             break;
>     >       default:
>     >               return -EINVAL;
>     >       }
>     > 
>     > -     return 0; /* never reached */
>     > +     return 0;
>     >  }
>     > 
>     >  static int smi_remove(struct platform_device *pdev)
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

