Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B0551FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiFTPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242848AbiFTPDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B34E1A056
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655735756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sB5vA/PYt/B++hSiLWtw5RtdOSfa5Qtze5kAXPaq3gM=;
        b=ZeiqzRH3HsFuhMSdwRgj/fIYF+n7hC5hqi1p+yLatFnYWibEadVSXPD83Vq7km/l7R5/hZ
        IJyga3ECB1X3SAvG2xnqGpO7hHg/7bcFMBBFC4CyReqBzUR0fARLxGY7D9r5yBG1ZGx+YN
        UPNoXw0ARX0tfScyF4Mruc1496HKvgs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-zg0LXaoKMdC1YOXlaYTCKg-1; Mon, 20 Jun 2022 10:35:54 -0400
X-MC-Unique: zg0LXaoKMdC1YOXlaYTCKg-1
Received: by mail-ed1-f71.google.com with SMTP id h16-20020a05640250d000b0043572a34a61so4089387edb.15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sB5vA/PYt/B++hSiLWtw5RtdOSfa5Qtze5kAXPaq3gM=;
        b=F/88+Pd54SuHoyBaiUIVgRMmzaD7zq9an49lOrzL1Gm3Soiyra9DCtGbYhqq+lsxrQ
         AI6S7ovqq6KyP0RNfwksdYmnMR8Qes54TtE4ZvzOanrQiqsfFAC4mSRumflOcV+9hLQL
         i5qQbVPi3t1pQDWH7ED7TIQeMur8zvoRDddIaNP4sELUzw9pdjlCFl0EmxSdQBoOiO5M
         3rVOvzVqdL6yp8Vdu/zjEKXtDXvTyA4KAnO8XCBIiRdDdmd26ejYURZU9vEXFfc34wUL
         9/ksQD0jfoE0Q/N3TKOnKP00yed0LFJkefG2xfei8WnDnI7jeK7CbKb2OIrOWiDx9PjP
         aGJw==
X-Gm-Message-State: AJIora/m7VQNg1ORJUiu7og2ywcQPuki0BRehLU75WvnDWaib5OFg48p
        dWdNLZ69NHpdKOctJYgcwq32mW0Tvllne1poD57rTDrnwkJ9sOtFFp9qljo+4S2LkSiqq7b50Nn
        IIYPZFwJ0SvI+nsxkdy1qow8X
X-Received: by 2002:a05:6402:f8d:b0:435:6df2:68a with SMTP id eh13-20020a0564020f8d00b004356df2068amr15504692edb.209.1655735753655;
        Mon, 20 Jun 2022 07:35:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vd1G5IDERU5ls3ZLMFPONjt/JzOY8kxQyAIF3O5ehuje2w68JMZlruTfRe1V2x9eaZ6rKddQ==
X-Received: by 2002:a05:6402:f8d:b0:435:6df2:68a with SMTP id eh13-20020a0564020f8d00b004356df2068amr15504675edb.209.1655735753508;
        Mon, 20 Jun 2022 07:35:53 -0700 (PDT)
Received: from [10.0.0.147] (D57D5A4B.static.ziggozakelijk.nl. [213.125.90.75])
        by smtp.gmail.com with ESMTPSA id rh17-20020a17090720f100b006fef5088792sm6001911ejb.108.2022.06.20.07.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 07:35:53 -0700 (PDT)
Message-ID: <738d00dd-f05b-9b31-5260-0158ee89e399@redhat.com>
Date:   Mon, 20 Jun 2022 16:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/1] usb: typec: wcove: Drop wrong dependency to
 INTEL_SOC_PMIC
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220620104316.57592-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220620104316.57592-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/20/22 12:43, Andy Shevchenko wrote:
> Intel SoC PMIC is a generic name for all PMICs that are used
> on Intel platforms. In particular, INTEL_SOC_PMIC kernel configuration
> option refers to Crystal Cove PMIC, which has never been a part
> of any Intel Broxton hardware. Drop wrong dependency from Kconfig.
> 
> Note, the correct dependency is satisfied via ACPI PMIC OpRegion driver,
> which the Type-C depends on.
> 
> Fixes: d2061f9cc32d ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/usb/typec/tcpm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 557f392fe24d..073fd2ea5e0b 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -56,7 +56,6 @@ config TYPEC_WCOVE
>  	tristate "Intel WhiskeyCove PMIC USB Type-C PHY driver"
>  	depends on ACPI
>  	depends on MFD_INTEL_PMC_BXT
> -	depends on INTEL_SOC_PMIC
>  	depends on BXT_WC_PMIC_OPREGION
>  	help
>  	  This driver adds support for USB Type-C on Intel Broxton platforms

