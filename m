Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC76512FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344960AbiD1JRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345363AbiD1JOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F25E75DE40
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651137100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ev0V3dh1Yk75AssijLWz6pZJn0r8SgSUi6JEJ9qm3Yk=;
        b=dzxY7BJ4eObF1A0bshke3CeG3Bp0LOzHX6+xGYjirs7+EgZ5dCjsvl/1rThwUiteLzi/Hv
        yxj0/jAlHQ9TuufMWIQfsx1FrQiWLkdvIvHEguwnpdEI2jffzAWWb8sq/Su26cjop2eClT
        1vjUBHCBr4Pcj1GFNDRV2X7YBwV/jog=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-KRos-1RnOziNrTyGxQcN3A-1; Thu, 28 Apr 2022 05:11:38 -0400
X-MC-Unique: KRos-1RnOziNrTyGxQcN3A-1
Received: by mail-wm1-f71.google.com with SMTP id m125-20020a1c2683000000b00391893a2febso1687855wmm.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ev0V3dh1Yk75AssijLWz6pZJn0r8SgSUi6JEJ9qm3Yk=;
        b=PJV0KMWU+x2NoEU6GuHGtBF+zkEOBK2/FAwV1qHToLd2RlZnGMPsE5hHBA26s/cZaY
         EEJ65TS7c4M6x1hwPnXTMdtpPe0Za677Gxbx+HGW3lIgQyTRkn3fjcj1IVenVQiOiVL+
         lCoECmaoTG7ehIHW6/1uUFjNhXUrQSjw4sFeYAQBosd4DqCOszmwYZw675fZYMwWa7Aj
         QonwVUtNPVnNmn2tzYO3cjlLfsPMu0IKjuB4vPR1W1eNVq4oWd9/NmtutUxMX5dsVIxP
         xC5kgbHGn+nhmbVfUxESY7V5QfosIf6UUjYIQb59KW5yhTXEaXyeTF+ik4X2IdgVNbFC
         KQmw==
X-Gm-Message-State: AOAM533HpWCLxZq5hMw5+VJwn6vmET0g9Fsm/BOryjjQrqiuWQJK3I21
        hasOVWA+xrNgOdo/UdUqNZaMmmhae+Kf/vHWCE+UqmESHt4RpV6APRettcpDZzt8i5+cN4XM7Zx
        LxCNwAdGWguprFuBO8/cE/XiX
X-Received: by 2002:a1c:f415:0:b0:37f:ab4d:1df2 with SMTP id z21-20020a1cf415000000b0037fab4d1df2mr38264532wma.75.1651137097336;
        Thu, 28 Apr 2022 02:11:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxli1ru5EtzorJANXnGcbADNMy0+tRE2gZ3UT2MrzMXCufukyc2wlVDBGNCEj1I2BummVcvXQ==
X-Received: by 2002:a1c:f415:0:b0:37f:ab4d:1df2 with SMTP id z21-20020a1cf415000000b0037fab4d1df2mr38264512wma.75.1651137097145;
        Thu, 28 Apr 2022 02:11:37 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm4479447wmq.40.2022.04.28.02.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:11:36 -0700 (PDT)
Message-ID: <8181a700-4955-cbdb-553f-311d790c603f@redhat.com>
Date:   Thu, 28 Apr 2022 11:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] drm/display: Select DP helper for DRM_DP_AUX_CHARDEV
 and DRM_DP_CEC
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20220428082244.390859-1-javierm@redhat.com>
 <c2ce3927-44ac-45cb-9ced-cfd3f9a184a6@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c2ce3927-44ac-45cb-9ced-cfd3f9a184a6@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 10:42, Thomas Zimmermann wrote:
> Hi
> 

[snip]

>>   drivers/gpu/drm/display/Kconfig | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
>> index f84f1b0cd23f..1b6e6af37546 100644
>> --- a/drivers/gpu/drm/display/Kconfig
>> +++ b/drivers/gpu/drm/display/Kconfig
>> @@ -31,7 +31,8 @@ config DRM_DISPLAY_HDMI_HELPER
>>   
>>   config DRM_DP_AUX_CHARDEV
>>   	bool "DRM DP AUX Interface"
>> -	depends on DRM
>> +	depends on DRM && DRM_DISPLAY_HELPER
>> +	select DRM_DISPLAY_DP_HELPER
>

My rationale was that since DRM_DISPLAY_DP_HELPER is not a user-visible
symbol but DRM_DP_{AUX_CHARDEV,CEC} are, the latter should be able to
be enabled by the user without relying on other drivers to select the
required symbols (I would argue that even should select DP_HELPER but
that can't be done or otherwise the helper couldn't be built as module).

In other words, either DRM_DP_{AUX_CHARDEV,CEC} can be user selectable
as a standalone symbol or can't and will only be visible if other driver
selects their required symbols.

In which case, why not just do this non-user visible and just make the
drivers using their helpers to select it directly? That is one of the
options I proposed before.

So I believe this is the less intrusive change that will preserve the
current behaviour as much as possible.

I don't have a strong opinion though and if you prefer I can change to
be a depends instead.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

