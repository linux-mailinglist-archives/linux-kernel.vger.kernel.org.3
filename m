Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B04EAF47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbiC2Oeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbiC2OeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 427BB1EC40
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648564349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESW2vknun2r+H+//LkALq88WuwZHy/xnjjPu8pzsygo=;
        b=hZ/DRNsQ7Qj5vlDEjyQTQJuYE3W9KNBJ1ThWVWKmy96Iba2/aw/w6A4Qfx5awBttcUxcRi
        o+dKam5QJ5gpEOOG+WaFwYUawU89vohRpQWY8ui4DYEMLi6iF3zyDOJsK2ji0b7d7Le5BX
        1QOtAI+BHcOqFAFGg/8buvA/Q1VFlZI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-9JQKRvsxM_SDzBKEMn8UXw-1; Tue, 29 Mar 2022 10:32:28 -0400
X-MC-Unique: 9JQKRvsxM_SDzBKEMn8UXw-1
Received: by mail-ej1-f71.google.com with SMTP id my15-20020a1709065a4f00b006dfd2b16e6cso8299288ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ESW2vknun2r+H+//LkALq88WuwZHy/xnjjPu8pzsygo=;
        b=LLFZ6ELkFi4M9qJFBQ428R8ZpuBv0L/gWRXUIQ/fT+iu3VgspeUMXZLtqcHljN7Mvy
         jUCVIIu9A5N3nIAiscu8HBQD/N2YtL3Hg8E1IXujk8jr1+8eKH98Dofr6xk1nwxbXFKF
         ReeAMBKsnPxi6rxYk2YjtkosSiv6sXQxZsghdJZxO+JMjxl2W3xLN5f9KohkQ7nC9Yy4
         W94lnwEKKUUF7haef/BA/O0ZxO1+qzxwIfVN3ztUo4SRn8DIQqBLJOdVaJkUrbbV1UUO
         /80hqKboij38cjTbHTPYgJjDOZmdG8zpsQ/m6zz+3lA7e906HggpLHrw39hUmoLWeZSn
         xWZw==
X-Gm-Message-State: AOAM533yz5KTZiwXk8rFRzhSpRV1dd6RKYxgt4o7aK69avRn83AHzjZt
        QmVzP9d4T/U2oJsLxTSJSr1kgC5mYlIHd+fx+CDe5HPd2+9TDW1FvBD7Jk9L2X4lS+2xWymcKxk
        OIh6jamaQmILCRwenAz2XrX+K
X-Received: by 2002:a17:907:3f29:b0:6df:7eac:7fa4 with SMTP id hq41-20020a1709073f2900b006df7eac7fa4mr35078968ejc.391.1648564347140;
        Tue, 29 Mar 2022 07:32:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAxTDxTwlbMr8NJVUMbUrfqBKX8Vaz+7Son3w1hZtBbDNugxIwe3doyVaKuUEy09wTK/3U3g==
X-Received: by 2002:a17:907:3f29:b0:6df:7eac:7fa4 with SMTP id hq41-20020a1709073f2900b006df7eac7fa4mr35078940ejc.391.1648564346890;
        Tue, 29 Mar 2022 07:32:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090672cd00b006df86017b61sm7192393ejl.105.2022.03.29.07.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:32:26 -0700 (PDT)
Message-ID: <e47ed54f-dacc-f9c7-0307-a47b38fc675d@redhat.com>
Date:   Tue, 29 Mar 2022 16:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 3/4] input/i8042: Add debug output for quirks
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220329142718.30921-2-wse@tuxedocomputers.com>
 <20220329142718.30921-3-wse@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220329142718.30921-3-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/29/22 16:27, Werner Sembach wrote:
> Make new quirk table easily debugable with some debug output.
> 
> With no functional change, evaluation of i8042_reset_quirk and
> i8042_reset_never_quirk had to be moved for this.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/input/serio/i8042-x86ia64io.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 1d2b34aac0c7..5c0eb5594fb1 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -1421,6 +1421,31 @@ static int __init i8042_platform_init(void)
>  
>  	i8042_check_quirks();
>  
> +	pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
> +		i8042_nokbd ? " nokbd" : "",
> +		i8042_noaux ? " noaux" : "",
> +		i8042_nomux ? " nomux" : "",
> +		i8042_unlock ? " unlock" : "",
> +		i8042_probe_defer ? "probe_defer" : "",
> +		i8042_reset == I8042_RESET_DEFAULT ?
> +			"" : i8042_reset == I8042_RESET_ALWAYS ?
> +				" reset_always" : " reset_never",
> +		i8042_direct ? " direct" : "",
> +		i8042_dumbkbd ? " dumbkbd" : "",
> +		i8042_noloop ? " noloop" : "",
> +		i8042_notimeout ? " notimeout" : "",
> +		i8042_kbdreset ? " kbdreset" : "",
> +#ifdef CONFIG_X86
> +		i8042_dritek ? " dritek" : "",
> +#else
> +		"",
> +#endif
> +#ifdef CONFIG_PNP
> +		i8042_nopnp ? " nopnp" : "");
> +#else
> +		"");
> +#endif
> +
>  	retval = i8042_pnp_init();
>  	if (retval)
>  		return retval;

