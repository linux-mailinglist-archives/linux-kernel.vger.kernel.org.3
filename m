Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C211049B6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580627AbiAYOvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389164AbiAYOqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:46:32 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE71FC061748;
        Tue, 25 Jan 2022 06:46:32 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s9so31351539oib.11;
        Tue, 25 Jan 2022 06:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=7Z5bK0+Pm8PkUYWJw79nfAVnr5089YtPM73aqhByRKU=;
        b=HMWk3U3Ns5ptKCExZyPaCNn8o7exF6BOZW5ey1aGWKCE77urECqLQzdacioQoIggXv
         1fmBVm+hEkodpaVj+Glni4eA5hN8DIdsjPW4e+WfTkzI/OIfSFsoXzQPhMQnVMXsuyaw
         9yZrctiNDhZUuib0WDQuxUs+4580gHb3Hgc8MGsJ74rd5BqXsNrIXDN5jEfGFa5dDs/m
         u23th50rE40GyPS2HoEK7hH/U7AUAqV3VEOjDSOwVUclkfJ4VhI3kj7uHrNbor7xRK3S
         QN7hRwUjQbgdp85oDXM5Ag1q0vYBZuLgx/ivXSA1gKoPwNVuyTZ+HBC0GvMZKiKSW7rc
         m8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=7Z5bK0+Pm8PkUYWJw79nfAVnr5089YtPM73aqhByRKU=;
        b=nXA4HNYGOQtc+ldzjiRfAo8FV1LdVe0kMaBq/5SLBwSIJaEp1niwGX4S57LXLaIT7Q
         QFT0C7jnQnZZYuRZGgTVISQAjD+kNSzpErIZLwZW2tsZ7M7XBDwiNHqh8sFB2f2ZlyPC
         AAxQ31nT52NdrX/zH0zoU88BiQg+Hoktxdl6OlQJS18+iRI6T088YNkfIjW7bYT9Oe1J
         nkbsc6eGX9f35rsuOL8n2w8MQfT/D5idbzPJC/x3j0HGEI6FiQmTEuCA2tRHkwHAsg57
         Ra0zGztu47Q9fB+PkLl3QqDPWbLxqvnbLH0p6FHTZHoseIiCeKh173kkc0YnDhhObLlH
         N/Vw==
X-Gm-Message-State: AOAM530KazsJWikBbBWrRTMN9VkOz90sdhdBRFClodVT+wmf5U/61dE7
        FAvin67IibtqEnnrP5D54sI=
X-Google-Smtp-Source: ABdhPJyQqewm1+WDe2tCvEPLVuiVcWjlKl/DXT10mxiastthfwWfY7zILNKoHxUWlIE/IWQWQ9uUrg==
X-Received: by 2002:a05:6808:909:: with SMTP id w9mr850518oih.101.1643121992069;
        Tue, 25 Jan 2022 06:46:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 44sm7181915otl.15.2022.01.25.06.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 06:46:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e7ca9d8-c545-160a-5578-cf1438223759@roeck-us.net>
Date:   Tue, 25 Jan 2022 06:46:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     krishnar4 <krishnar@ami.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Deepak Kodihalli <dkodihalli@nvidia.com>,
        Shakeeb Pasha <spasha@nvidia.com>,
        Vinodhini J <vinodhinij@ami.com>,
        Pravinash Jeyapaul <pravinashj@ami.com>,
        linux-kernel@vger.kernel.org
References: <20220125130116.18646-1-krishnar@ami.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH linux dev-5.15] hwmon: (pmbus) modify PSU fan_target
 convert value to false
In-Reply-To: <20220125130116.18646-1-krishnar@ami.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 05:01, krishnar4 wrote:
> Description: PSU can't use sysfs fan_target to control PSU fan duty.
> 

This is neither a proper subject nor a proper description.
"modify PSU fan_target convert value to false" means that the
value reported from the attribute is used directly without
conversion. The subject should reflect this.
"Description:" should not be part of the description, and
the description should describe the reason for the change
(ie explain clearly what is wrong).
"PSU can't use sysfs fan_target to control PSU fan duty"
doesn't explain anything and doesn't match the subject.

> Signed-off-by: krishnar4 <krishnar@ami.com>

"krishnar4" is not an acceptable name. This needs to be a real name.

Guenter

> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..a56c2e1c4079 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1889,7 +1889,7 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
>   
>   	sensor = pmbus_add_sensor(data, "fan", "target", index, page,
>   				  0xff, PMBUS_VIRT_FAN_TARGET_1 + id, PSC_FAN,
> -				  false, false, true);
> +				  false, false, false);
>   
>   	if (!sensor)
>   		return -ENOMEM;

