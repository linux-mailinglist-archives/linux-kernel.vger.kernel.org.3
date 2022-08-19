Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8A7599821
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbiHSJC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346731AbiHSJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95420F23C8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660899744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2hCRGU8uolgt6AszyDmYkNdB78RbK6mGmWkx2eq+Dw=;
        b=ha35y184v2BPXqQ9niRl+24vNE+47kJHZ2LFZxTw+dKaCwPeIDlqkygXt2nsyZXfg8o4Cb
        S2eJSLMJmgIEwzVIqSc2wJa8rq1vEsgIC7/CdmLbXZECv/JvjTvyH2HFC+0Ll6QOlYdJz0
        pmqFRzFM0AG9y9dA+apsdh3CwOpwlt0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-pReHpZ1vM0aXagFfHByP0A-1; Fri, 19 Aug 2022 05:02:23 -0400
X-MC-Unique: pReHpZ1vM0aXagFfHByP0A-1
Received: by mail-ed1-f71.google.com with SMTP id b6-20020a056402278600b0043e686058feso2492488ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=k2hCRGU8uolgt6AszyDmYkNdB78RbK6mGmWkx2eq+Dw=;
        b=AYalplO9pAlkX+TdkbfVRzt3blDyH48DSn+t8jdyxFNmebb2BtcWwiA9HnijJh/GxD
         iWQtVd2r05fT6Tlle/aak0RMRzSrDknRsRJyGB/DS4e5tDeKOcxc3/t0mPUqFk+h2YXQ
         M5yErNgZqzD1us3JNMpz/4Do2XW4w02Dxd9qOB3VbfnGLI8S2PoyAkWRMYXE1sgT3LDJ
         bADyyN2jowfau/Ygw5VweR63Efp6jXcHWrF5WebWBzNxZEQXtltfPe48Vmm047yrPjMU
         ZlLp/Pp8iu2p8vzjfXRCdy1pV/SpxqJU47IhxXuDMRsDdgTUWx8JAtosvUzJt9WEVwM2
         D4Gg==
X-Gm-Message-State: ACgBeo1d7O68xBblHi3ER7V/yHs+cDqvvlQ8l4r1ALDQqr0Um2G7sh75
        Cr9C8aXAi38MI+VObQvgaCVrWZIcC0IEBzZWWKOZ1xERKjUSFTHohBnfAeIYEkxUX94j/uWEWTq
        36LnR7yoC+cwJZBYrJDKs7N8E
X-Received: by 2002:a05:6402:2216:b0:445:eb9a:bfb5 with SMTP id cq22-20020a056402221600b00445eb9abfb5mr5497661edb.36.1660899742538;
        Fri, 19 Aug 2022 02:02:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4eSBN9FVsNr1HGfl52khWYN1MKvWaGEJavx9fVkDeTBRmlQ/2uknC0GX8kHPSkQSLMjA8+7A==
X-Received: by 2002:a05:6402:2216:b0:445:eb9a:bfb5 with SMTP id cq22-20020a056402221600b00445eb9abfb5mr5497645edb.36.1660899742323;
        Fri, 19 Aug 2022 02:02:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id la26-20020a170907781a00b0073c23616cb1sm1677531ejc.12.2022.08.19.02.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:02:21 -0700 (PDT)
Message-ID: <159f2466-44b8-07c8-fe14-e177e962c50b@redhat.com>
Date:   Fri, 19 Aug 2022 11:02:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] virt: move from strlcpy with unused retval to strscpy
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220818210120.7565-1-wsa+renesas@sang-engineering.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220818210120.7565-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/22 23:01, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/virt/vboxguest/vboxguest_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
> index 0b43efddea22..dfd69bd77f53 100644
> --- a/drivers/virt/vboxguest/vboxguest_core.c
> +++ b/drivers/virt/vboxguest/vboxguest_core.c
> @@ -198,7 +198,7 @@ static int vbg_report_guest_info(struct vbg_dev *gdev)
>  	req2->additions_revision = VBG_SVN_REV;
>  	req2->additions_features =
>  		VMMDEV_GUEST_INFO2_ADDITIONS_FEATURES_REQUESTOR_INFO;
> -	strlcpy(req2->name, VBG_VERSION_STRING,
> +	strscpy(req2->name, VBG_VERSION_STRING,
>  		sizeof(req2->name));
>  
>  	/*

