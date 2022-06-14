Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1D354AF48
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355765AbiFNLXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356301AbiFNLX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B154825596
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655205805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DeSyU/TE5RCJvUem9lvGVeASpqzw6FLVpfJvGFrZeZA=;
        b=RKuP4JRAAaLUlTTz8/JXtzaoCXUSV32e3OwcNJmNAsONar/71gsh9a+7ZaZPQRhwju3VAL
        QmgywiXnPdngAdN6a+bis0O+o3XG5vONe9guIQ3XV5vwFnEyFkS9i0DOmRdGFv9yC0WvmE
        JoGhQrpW0ef701J63YR74GC9XtmXN9Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-jRr0AnV9MzypSXSlXQV3NA-1; Tue, 14 Jun 2022 07:23:24 -0400
X-MC-Unique: jRr0AnV9MzypSXSlXQV3NA-1
Received: by mail-ed1-f71.google.com with SMTP id m5-20020a056402430500b004319d8ba8afso6002127edc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DeSyU/TE5RCJvUem9lvGVeASpqzw6FLVpfJvGFrZeZA=;
        b=cKVpJpDBM0om4sOTnm0Oz7HReWoJ2c+JqGKA1H7lcMvU+0rNogGkBbFMqafvWYajpX
         j05bjykn+RA/VKuGYEiMKisWTD35KTZhGXJ2xAWAcMlqa/cs4Oo1uODQg85rCPgRzdvr
         FoygbBi034h5ilWCiGWl758OUpNiX52V6op0vIsifoSAluNVHYPBV91MjBiErmINLB6Z
         TWoEax4KeP1zRM54chmjWztlzjVZupxxlKlkIIRRz2yClDuUgOATsEiXXRHBsHAv+Ott
         JE6IOutCWdQeer3N5cN7jk8vWyL2Ra0FQ9V9+gj9bVJY6dAgy6J2M9uv/xozv3l8/A9r
         EZTA==
X-Gm-Message-State: AOAM5320jh5MEHzAHC3VV4KPxqWfpeF+/KkzQEf8KP0x2DW6Vb/e3hGb
        PD36ovC+VvLU2b8pES9lPXXbk/skkbyzxLNVb7xNoe0SVl+IZjeCDKdR12o0xxnlP7Xb7srAj+3
        LkcL6y7MlakHPEV5e/pnARJrO
X-Received: by 2002:a17:907:3f97:b0:711:d61d:df9 with SMTP id hr23-20020a1709073f9700b00711d61d0df9mr3913085ejc.644.1655205803107;
        Tue, 14 Jun 2022 04:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQHMluBcpPYWc2yp7uCcemI90Mdk5ZmtpRcGvCZkTZAWWy/1vIWBvgwwPdeOTQ0uucLYHirA==
X-Received: by 2002:a17:907:3f97:b0:711:d61d:df9 with SMTP id hr23-20020a1709073f9700b00711d61d0df9mr3913061ejc.644.1655205802817;
        Tue, 14 Jun 2022 04:23:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fs36-20020a170907602400b00705f6dab05bsm4902373ejc.183.2022.06.14.04.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 04:23:21 -0700 (PDT)
Message-ID: <bd21d5c6-ed5f-dd8c-f0bf-73f54ca8ee58@redhat.com>
Date:   Tue, 14 Jun 2022 13:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/1] phy: ti: tusb1210: Don't check for write errors
 when powering on
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ferry Toth <ftoth@exalondelft.nl>
References: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/13/22 18:08, Andy Shevchenko wrote:
> On some platforms, like Intel Merrifield, the writing values during power on
> may timeout:
> 
>    tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
>    phy phy-dwc3.0.auto.ulpi.0: phy poweron failed --> -110
>    dwc3 dwc3.0.auto: error -ETIMEDOUT: failed to initialize core
>    dwc3: probe of dwc3.0.auto failed with error -110
> 
> which effectively fails the probe of the USB controller.
> Drop the check as it was before the culprit commit (see Fixes tag).
> 
> Fixes: 09a3512681b3 ("phy: ti: tusb1210: Improve ulpi_read()/_write() error checking")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Copy and pasting my reply about this in another thread to keep everyone up2date:

"""
In my experience with using the phy for charger-type detection on some
x86 android tablets which don't have any other way to do charger detection,
these errors indicate a real communication issue for reading/writing
phy registers. At the same time this usually does not seem to be a big
problem since the phy seems to work fine with its power-on defaults.

In case of Bay Trail these errors were related to 2 things:

1. Autosuspend of the phy-interface block in the dwc3, fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7c93a903f33ff35aa0e6b5a8032eb9755b00826

But dwc3_pci_mrfld_properties[] already sets "snps,dis_u2_susphy_quirk",
so I guess it is not this.

2. There being no delay in tusb1210_power_on() between toggling the
reset IO and then trying to communicate with the phy, fixed in:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df37c99815d9e0775e67276d70c93cbc25f31c70

Maybe the:

#define TUSB1210_RESET_TIME_MS				30

Added by that commit needs to be a bit bigger for the possibly
older phy revision used on the merifield boards?

(note it is fine to just increase it a bit everywhere).
"""

IMHO it would be good to try and increase TUSB1210_RESET_TIME_MS (start with say 100
and then see if e.g. 50 also works). If increasing that does not work

I'm fine with going with this workaround patch to fix things.

Regards,

Hans



> ---
>  drivers/phy/ti/phy-tusb1210.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
> index c3ab4b69ea68..669c13d6e402 100644
> --- a/drivers/phy/ti/phy-tusb1210.c
> +++ b/drivers/phy/ti/phy-tusb1210.c
> @@ -105,8 +105,9 @@ static int tusb1210_power_on(struct phy *phy)
>  	msleep(TUSB1210_RESET_TIME_MS);
>  
>  	/* Restore the optional eye diagram optimization value */
> -	return tusb1210_ulpi_write(tusb, TUSB1210_VENDOR_SPECIFIC2,
> -				   tusb->vendor_specific2);
> +	tusb1210_ulpi_write(tusb, TUSB1210_VENDOR_SPECIFIC2, tusb->vendor_specific2);
> +
> +	return 0;
>  }
>  
>  static int tusb1210_power_off(struct phy *phy)

