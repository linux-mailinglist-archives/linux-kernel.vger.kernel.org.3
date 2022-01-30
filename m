Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA4E4A3AD3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356786AbiA3W6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiA3W6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:58:17 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B84C061714;
        Sun, 30 Jan 2022 14:58:16 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id b186so17338752oif.1;
        Sun, 30 Jan 2022 14:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Df74O5bzOlukfRZbmLUqfOQQ47feWvT/frNyZtSZgI=;
        b=Lc0MfJf7Wux1Qlf2poiJ8kmsU1LkxpOYjVBHcUPGp71pVVbX+/spyalzfLM86jGXiB
         YIl1g8LQJQUhnAz8n9iulARDMREIEl/EI0UCl6cwy2yDhRR8p88KNZfXZ4zL+PeLHwNv
         9wF37kuBHdaVVuMfcx0ELHMkOfwSZaK0xgXCKaYmbbtIOtWZswYScY+KQ6nJGkaz/ca6
         dbv4wbEITXk+zBedR2QpqljpBF+geD4lFX2XWqKkXOUqc7hgPyiyl2p1nodNUtNJNtNy
         +bZPrT5ohfGsEyvtIt0KaEXto7i6EYscaBQqInH7BM7vm80t6Rg9Cp/VUbxcI+UR6mw9
         LPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Df74O5bzOlukfRZbmLUqfOQQ47feWvT/frNyZtSZgI=;
        b=DOSAcL/mG/9bw+UTW9vpgu+DIgv2Z3KG0WXZ6Gv+BA5Pb5HZ9DWu4D9yeOgbjxzR8h
         cs2Nt942iNoUbxWK+KCI8DnnxFeVvET4H14ymrnm5DI6GfEZtfmUuhel29rmTthLxv2c
         H8vIpI/Xvzh3Jl3VefYpUROhbqFNG6KXTeZYgvwU/wgzhIxPoP28VDb2thEAgwbk8tuO
         /1wGTSSMwYWeecUsEkr1fVlRw/2HYhjU37Xb8+MjCh9zrKbJ6YeN2b0Oy4N70kMk8aIn
         3savMyzFbJd+WUFF0zcu/cLJuKeHgBo9kqo/F7V9SFLnFtlBHxJhroUfN4iXbLQ7Ogp+
         Fkqw==
X-Gm-Message-State: AOAM531WXQ2HyBy3bgBUOsbCQ6NNku/wypqep7Ne6FVRZ50EhC2gFeUR
        PDC9DeaWNpYH9RHVvqiKYQbddtkRTRCR5Q==
X-Google-Smtp-Source: ABdhPJw5qC4Lgd7HZVVI15M/HLNZloNIY++bNFPk9Sgimu3r2Ae6uDZevOfSLauiuUwwnnstCDLiQQ==
X-Received: by 2002:a05:6808:189f:: with SMTP id bi31mr11430338oib.5.1643583495881;
        Sun, 30 Jan 2022 14:58:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4sm8070621otg.61.2022.01.30.14.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 14:58:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f153d3dc-f4c1-9c4b-aac3-da3a696a3313@roeck-us.net>
Date:   Sun, 30 Jan 2022 14:58:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] acpi: require CRC32 to build
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220130223818.16985-1-rdunlap@infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220130223818.16985-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/22 14:38, Randy Dunlap wrote:
> ACPI core now requires crc32() but the kernel build can fail when
> CRC32 is not set/enabled, so select it in the ACPI Kconfig entry.
> 
> Fixes this build error:
> 
> ia64-linux-ld: drivers/acpi/scan.o: in function `acpi_store_pld_crc':
> include/acpi/platform/aclinuxex.h:62: undefined reference to `crc32_le'
> 
> Fixes: 882c982dada4 ("acpi: Store CRC-32 hash of the _PLD in struct acpi_device")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/acpi/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- linux-next-20220128.orig/drivers/acpi/Kconfig
> +++ linux-next-20220128/drivers/acpi/Kconfig
> @@ -11,6 +11,7 @@ menuconfig ACPI
>   	depends on ARCH_SUPPORTS_ACPI
>   	select PNP
>   	select NLS
> +	select CRC32
>   	default y if X86
>   	help
>   	  Advanced Configuration and Power Interface (ACPI) support for

