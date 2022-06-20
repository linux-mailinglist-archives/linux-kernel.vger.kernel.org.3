Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF3F551E21
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351896AbiFTOKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354643AbiFTN7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:59:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0A3A729;
        Mon, 20 Jun 2022 06:25:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so10304996pjz.1;
        Mon, 20 Jun 2022 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1SRZahO4w5J/q1AxamwHmWbo+QN6jL4DplQ3GJck67Q=;
        b=Yfz4kPN4Epxgld8RHdqX+DgMerLlPdZE2q1himsiKuhf+pOrqaCXF8BhF9LkVvWOnp
         9aXDpNUMjqDP+82FNjGLrCpz8XBIMlgUIZw2WdbxWL48Sz7rts4aspIOwQkX/wqVFqPf
         1J7wxlGwBSpxXBF4KejzRbs6XS/AkIeWCESXqSTQ8od47R9NnNgkxObeM+ef65Cw4L/q
         kMUTu32cmMNnlmV2j9suedht7lBl3hqCkNmCOAMTt8lVcqqgRKI9Rg4gacWUxgnzxf0I
         685KjzIxFwQuWdGBYc+wHHr6gV2zI8MQ/jhb8nevWRqiiInmgJjnHsmihePlazOzcsxz
         cLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1SRZahO4w5J/q1AxamwHmWbo+QN6jL4DplQ3GJck67Q=;
        b=DMmspJqnRLn0ajafL6qe5KJiN8AKBl3YCz1kynwnk2jZrP6IyMkZMe0lK2PMjG0kEt
         NAhQoRU2uuh4D9OU4JssM9+0g6aV1/2yICDzfeWS9GNChfwwS1NsLMV06z7fyq542fdE
         MroRUQDiAfAFeISouoTxe+9aBdcFNQgFLi4RA+8oolmwH8dgaKrzeZ7m8ae76fObvXjp
         KZIs+4ivKGwcjwUZyCJc9pWuSG7zykz0qoqUO7MhCHu8JwAXGukPd6JxenH8zy9ediDI
         Z38sJSooNpH5lbEx3RTQN/s4yRFcZrspeebW4rDqacI64a3NW0q5+MpWHdReTiTvZSIn
         MtWg==
X-Gm-Message-State: AJIora+RFshZHVa4qWdnRgUu96LapxCED+BAQPOlYXBpD7mMxHDPx4T/
        v/KqV2w+f1WMbw/1bVW4HXw=
X-Google-Smtp-Source: AGRyM1sriAMqD/tVrcUsQCeNd2USxuUFdiLg7orv2BCCs0tunNFnqevMKSGN2qUHWs8/wkImAEhsJQ==
X-Received: by 2002:a17:90b:1bc7:b0:1e8:317d:6b3b with SMTP id oa7-20020a17090b1bc700b001e8317d6b3bmr26630225pjb.136.1655731534551;
        Mon, 20 Jun 2022 06:25:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a694600b001ec839fff50sm4829562pjm.34.2022.06.20.06.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 06:25:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f8520fac-28b3-0d8d-4d27-25463978b2ec@roeck-us.net>
Date:   Mon, 20 Jun 2022 06:25:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/1] usb: typec: wcove: Drop wrong dependency to
 INTEL_SOC_PMIC
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <20220620104316.57592-1-andriy.shevchenko@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220620104316.57592-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 03:43, Andy Shevchenko wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 557f392fe24d..073fd2ea5e0b 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -56,7 +56,6 @@ config TYPEC_WCOVE
>   	tristate "Intel WhiskeyCove PMIC USB Type-C PHY driver"
>   	depends on ACPI
>   	depends on MFD_INTEL_PMC_BXT
> -	depends on INTEL_SOC_PMIC
>   	depends on BXT_WC_PMIC_OPREGION
>   	help
>   	  This driver adds support for USB Type-C on Intel Broxton platforms

