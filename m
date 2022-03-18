Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944434DD467
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiCRFdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiCRFdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:33:10 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D72D3AF0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 22:31:52 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 8DA081F84
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:31:51 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id V5DLnWMTp22u3V5DLn2ZTp; Fri, 18 Mar 2022 00:31:51 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nHjdoFFbTloWbSbcTB9Xd34hQqBVAfoUskKY6xI1CyI=; b=2bqIbxx7e306+T8LJxWfDkxoYc
        w3cumUWMA3SAP46t8b0qOMPbYPHfC4hBJ7EDHLxF/OmFeL17WTO9yqB1exvoVb6wvFaFjiQHbduz4
        PTpbxVn3q+XvcH9OaK0tWBFSHIOKuz6lV7UD6N3Hkky0sErv/l8EuEOBxiKBV6kK7b9SdVViHovuN
        qnJo2FF8NWNEDbCBMdtaWcFDShg6mHpHtRyH8zhGyBSO+a6o6SH5Y83NcJyDtTg+AEQAWwLxi+V6P
        HNUJ76elTgs03NEPvqMrdHdkYFHi4MbSEafi7Oa2Yrj22ymSYT5EDMZjWEbRyR4xq+NCqS8NDDd1M
        EciZt6Ag==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57536 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nV5DK-001Put-W5; Fri, 18 Mar 2022 05:31:51 +0000
Date:   Thu, 17 Mar 2022 22:31:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brandon Wyman <bjwyman@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus) Add Vin unit off handling
Message-ID: <20220318053149.GA3333429@roeck-us.net>
References: <20220317232123.2103592-1-bjwyman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317232123.2103592-1-bjwyman@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nV5DK-001Put-W5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57536
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:21:23PM +0000, Brandon Wyman wrote:
> If there is an input undervoltage fault, reported in STATUS_INPUT
> command response, there is quite likely a "Unit Off For Insufficient
> Input Voltage" condition as well.
> 
> Add a constant for bit 3 of STATUS_INPUT. Update the Vin limit
> attributes to include both bits in the mask for clearing faults.
> 
> If an input undervoltage fault occurs, causing a unit off for
> insufficient input voltage, but the unit is off bit is not cleared, the
> STATUS_WORD will not be updated to clear the input fault condition.
> Including the unit is off bit (bit 3) allows for the input fault
> condition to completely clear.
> 
> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus.h      | 1 +
>  drivers/hwmon/pmbus/pmbus_core.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index e0aa8aa46d8c..ef3a8ecde4df 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -319,6 +319,7 @@ enum pmbus_fan_mode { percent = 0, rpm };
>  /*
>   * STATUS_VOUT, STATUS_INPUT
>   */
> +#define PB_VOLTAGE_VIN_OFF		BIT(3)
>  #define PB_VOLTAGE_UV_FAULT		BIT(4)
>  #define PB_VOLTAGE_UV_WARNING		BIT(5)
>  #define PB_VOLTAGE_OV_WARNING		BIT(6)
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index ac2fbee1ba9c..a0d899dc81f0 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1373,7 +1373,7 @@ static const struct pmbus_limit_attr vin_limit_attrs[] = {
>  		.reg = PMBUS_VIN_UV_FAULT_LIMIT,
>  		.attr = "lcrit",
>  		.alarm = "lcrit_alarm",
> -		.sbit = PB_VOLTAGE_UV_FAULT,
> +		.sbit = (PB_VOLTAGE_UV_FAULT | PB_VOLTAGE_VIN_OFF),
>  	}, {
>  		.reg = PMBUS_VIN_OV_WARN_LIMIT,
>  		.attr = "max",
