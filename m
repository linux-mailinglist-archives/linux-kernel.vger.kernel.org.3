Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E34E7177
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbiCYKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbiCYKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC5DC13E83
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648205006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyWiTIMiSmG4u6YzwD4u0xt7w+vIGYOcYZHs6UnFBQE=;
        b=eJjdFzr2Rxkt/Fc336re0ukzCLGrympQOXu4WK9exMaPk1HtgnfRqCKELSj+BYeRKY8dNz
        M8VIqcmWM/YFIdkWh0G6Os1lOeuDpBSD6B0yMVgke2kAv10BttW8yLQXQn4uYrzE3nvAOD
        KPBInNZ7PS0MoVcph8iD67pvdIWB6ik=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-TCpQkqBJPwGiWE3EXHZCAA-1; Fri, 25 Mar 2022 06:43:24 -0400
X-MC-Unique: TCpQkqBJPwGiWE3EXHZCAA-1
Received: by mail-ej1-f69.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso3902225eje.20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SyWiTIMiSmG4u6YzwD4u0xt7w+vIGYOcYZHs6UnFBQE=;
        b=XzBpagHJW8BWrpqsjSdqaX4qAUVUNm+0nXcZoU42o0yCm8Fiey9KwefGXEKAcPFXCm
         2ZOmKBfa5nPpyLKxgFK6R0P6NtHQZtpNRkGHCnVdjF7+zbJ/hqLmKpez90IoWbTlXzn0
         73DDWzdPkGS6Mq7YePq+G792OQi+C4oUjh9GPsvJDJJwZi7jyVerUq20qfhfYtUI3g2B
         9t7J2Kl+x+higaBAwtNIhAvum+98Kg+K4xTAZGO0g0Bvrjb8lWACnLcwoiIux8UTtaPT
         0v+O+7vIqrkj8jVZwBLDwcHPckIdUqrg0Lu+4uZAs5WCNLBTRRmx+UGc4f4uSbqKbnni
         dn6w==
X-Gm-Message-State: AOAM531VhrJ5MplWWK7KhxtWhhevW8Jb00g0gRAYbUOrEb+o5KHYFkxI
        l3MnNi/HwVx0KjoTSr/dax5Y/bXv2pyMl9oxJ64jeXNizg6seW3zTDrA+pbtiMSWlA6mM99wLGh
        cH2PqWxNs0PPqceeDj8d0J7YE
X-Received: by 2002:a17:907:7f0b:b0:6e0:a336:a3f5 with SMTP id qf11-20020a1709077f0b00b006e0a336a3f5mr2269067ejc.541.1648205003495;
        Fri, 25 Mar 2022 03:43:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn7dUpU6RhGkH+cmx02L2Lt5GssfkfC3amGgQ/83AFggV0T8LFHEtxdXiKDxurycDIh0lMlg==
X-Received: by 2002:a17:907:7f0b:b0:6e0:a336:a3f5 with SMTP id qf11-20020a1709077f0b00b006e0a336a3f5mr2269046ejc.541.1648205003312;
        Fri, 25 Mar 2022 03:43:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id d23-20020aa7d5d7000000b00418f7b2f1dbsm2658310eds.71.2022.03.25.03.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 03:43:22 -0700 (PDT)
Message-ID: <5c372eb8-d1f6-a001-fad2-fe11e0b37575@redhat.com>
Date:   Fri, 25 Mar 2022 11:43:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] Documentation/ABI: sysfs-driver-aspeed-uart-routing:
 Fix sphinx warning
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220324165918.22005-1-hdegoede@redhat.com>
 <20220324165918.22005-2-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220324165918.22005-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/24/22 17:59, Hans de Goede wrote:
> Fix the following warning from "make htmldocs":
> 
> Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing:2:
>   WARNING: Inline emphasis start-string without end-string.
> 
> This is caused by the used of '*' in the example cat command,
> mark the command as code to fix this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I see that this was already fixed by escaping the '*' with a '\',
apologies.

So this patch can be ignored / dropped.

Regards,

Hans



> ---
>  Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
> index b363827da437..1e25cd2cacc1 100644
> --- a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
> +++ b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
> @@ -8,9 +8,10 @@ Description:	Selects the RX source of the UARTx device.
>  		selected option marked by brackets "[]". The list of available options
>  		depends on the selected file.
>  
> -		e.g.
> -		cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> -		[io1] io2 io3 io4 uart2 uart3 uart4 io6
> +		e.g.::
> +
> +			# cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> +			[io1] io2 io3 io4 uart2 uart3 uart4 io6
>  
>  		In this case, UART1 gets its input from IO1 (physical serial port 1).
>  

