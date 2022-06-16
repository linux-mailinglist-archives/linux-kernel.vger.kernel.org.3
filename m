Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE6D54DBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358866AbiFPHbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359098AbiFPHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:31:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0335C34F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:31:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n10so1135079ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WR22BROo7BpVfHELY0/whUHHBl6+EosORE6LfOKACTA=;
        b=OUIhC3rE3NvkmStO46Q/ciAcnSAFfmmzP6mMCl8KhOx5/114KZw66r2dI7lB2gyO+U
         YXT28KvwmSKXDzmCe05V3bq/L/Y3f1XBHYAeP0y9oPsvzE+Mnc4nYi5nB4TbP4MKMtc8
         f5xaaw1QHZbVpoaEsehgITiq6iJ32F2JFZpoVZv0Il+WXqz/Z1am1BBJCmjmfYUBoTDS
         0SE7jkh/BYXhmawMxmwZRlMvKX2CV2izN1hK6D41/1IWf4fexcBZIGsNiexb9hsvtGTn
         KrLgdQrobJGLY+RnrU8RhvBYod40AWOcexwODDHmhFMrC9QzPjK69+a8RzJnqacf6K1U
         R4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WR22BROo7BpVfHELY0/whUHHBl6+EosORE6LfOKACTA=;
        b=UwmrqW0N86vVcR++jqVr6LhJWNke0bPTt9d1z7Danr7AlrExJkIfEz3eHSdi6b7bXn
         UcpJbe2DKsMLK0jKj2u+hKw0byG8Wemj8pm2MHoxEMzR1Akx3IMI/ZhZc8E6fI8F0IUa
         0F/5A+nIolWG4sJJAOleQFUY0OE/OJO7H/pi4n3gtlr86dT0Jwu6FDghllByD78RRo5a
         JZS5kzhX4/RVOnuAfDucaXiqXbzyiMzmUK7dHnzSCjBeTahGreP/+tW93yMbQdPQigb8
         YBhcxq6M7qfHkOYG6RtKIPfAECpgr5YhZZWKvQukVs2wuFMj4/v/aeEufF8XYtTnOIcW
         hmAA==
X-Gm-Message-State: AJIora9EbYsyoSlKWWv1gJHSJMO87DiN9K3NehTkgRGFWrAxiEw1Ex49
        4GHKt48kSwMGSb/FIE0eW4o=
X-Google-Smtp-Source: AGRyM1s0/RHY2CxHyvPWA7qPtKPg63zpTc3tJxhXGQ31GmKyrOyZ12y3foJKnNWNWxsUEbgH4HVK6g==
X-Received: by 2002:a17:907:1694:b0:716:14a4:fba with SMTP id hc20-20020a170907169400b0071614a40fbamr3319578ejc.290.1655364703764;
        Thu, 16 Jun 2022 00:31:43 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id w7-20020a056402070700b0042db87b5ff4sm1148344edx.88.2022.06.16.00.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 00:31:43 -0700 (PDT)
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, hch@infradead.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220616053715.3166-1-jgross@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <573c2d9f-8df0-0e0f-2f57-e8ea85e403b4@gmail.com>
Date:   Thu, 16 Jun 2022 10:31:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220616053715.3166-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.06.22 08:37, Juergen Gross wrote:


Hello Juergen

> Commit fa1f57421e0b ("xen/virtio: Enable restricted memory access using
> Xen grant mappings") introduced a new requirement for using virtio
> devices: the backend now needs to support the VIRTIO_F_ACCESS_PLATFORM
> feature.
>
> This is an undue requirement for non-PV guests, as those can be operated
> with existing backends without any problem, as long as those backends
> are running in dom0.
>
> Per default allow virtio devices without grant support for non-PV
> guests.
>
> Add a new config item to always force use of grants for virtio.
>
> Fixes: fa1f57421e0b ("xen/virtio: Enable restricted memory access using Xen grant mappings")
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - remove command line parameter (Christoph Hellwig)
> ---
>   drivers/xen/Kconfig | 9 +++++++++
>   include/xen/xen.h   | 2 +-
>   2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index bfd5f4f706bc..a65bd92121a5 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -355,4 +355,13 @@ config XEN_VIRTIO
>   
>   	  If in doubt, say n.
>   
> +config XEN_VIRTIO_FORCE_GRANT
> +	bool "Require Xen virtio support to use grants"
> +	depends on XEN_VIRTIO
> +	help
> +	  Require virtio for Xen guests to use grant mappings.
> +	  This will avoid the need to give the backend the right to map all
> +	  of the guest memory. This will need support on the backend side
> +	  (e.g. qemu or kernel, depending on the virtio device types used).
> +
>   endmenu
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 0780a81e140d..4d4188f20337 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -56,7 +56,7 @@ extern u64 xen_saved_max_mem_size;
>   
>   static inline void xen_set_restricted_virtio_memory_access(void)
>   {
> -	if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
> +	if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain())
>   		platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);


Looks like, the flag will be *always* set for paravirtualized guests 
even if CONFIG_XEN_VIRTIO disabled.

Maybe we should clarify the check?


if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || 
IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_pv_domain())

     platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);


>   }
>   

-- 
Regards,

Oleksandr Tyshchenko

