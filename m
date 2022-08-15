Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42EB592FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbiHONZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbiHONZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 230FA5FC0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660569921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIIzjPxeddzxMn7RZ9/iKALDcfamsWN+Y3QvwDD0LAQ=;
        b=HQkC9+r428EDkWPmbBpUhX/NXorfdxCkf1gETUN/ra99SNJI4t+f/TUdFlrK4/xW3by+zE
        eFvpNYrYu57+pwRsB65hiJ2icMYdbf+SXSrEZQuDnTuVOthulBBt2SLMI3wI+tt4QDBf96
        2/et5c+ppWNYhM//T58+qpy9fT7pRy4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-nIvCrt5HOHu_dvSAN2j5yw-1; Mon, 15 Aug 2022 09:25:20 -0400
X-MC-Unique: nIvCrt5HOHu_dvSAN2j5yw-1
Received: by mail-ed1-f72.google.com with SMTP id x20-20020a05640226d400b0043d50aadf3fso4811331edd.23
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dIIzjPxeddzxMn7RZ9/iKALDcfamsWN+Y3QvwDD0LAQ=;
        b=3kyuKB17Ph69kiRiA0TvZmL245NvWijQAkNdjiwp9oF0DhyoxwBFZ8jLNVvJkgGopD
         OFuu2tRiqYxugzGNuW41pX4mShtZW8N9rk1vfzE8RDnE0W5CDjj49n6LSWLFBgbEC3/U
         pEQJDnBSldzeY7mwt4UMsSW40eQpFnVU0B9HTaPg1cYZswKR1cQlL/67KDm0IzkaJWEo
         F/O1Ytyd7/KeUMH/eSiSZ5HJtvwzIkebmRfs0fgO9Auu5yDEKT5W3fDVP+eMYMUOOtfi
         j23HuX++WNUDQl9PBEpaI/OSR5N1OEOhdYzDrcUL9sKJiguW8LMorpWOVLzSlKWxhkHr
         pk5w==
X-Gm-Message-State: ACgBeo2vM2u26FJqkdDMsHIEeBOApJgpUngn0i2YbGzTONg176Tnwfv7
        Gtv4otc4fGcbL789ik9s2ozxtYp0Z9ylU9277xzHFS6insyvfPdc5wGwOsC+xXmgMOZEiNfsoCd
        98V8B3x9K2IbbJHqfe5PgP+Gd
X-Received: by 2002:a17:907:a06b:b0:730:9496:4f63 with SMTP id ia11-20020a170907a06b00b0073094964f63mr10323126ejc.238.1660569916908;
        Mon, 15 Aug 2022 06:25:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Np8EHjN3xV6j5gtUKKxrJruO/oaY6oPl7sUzHkQj7ymdHJKpTA67SMUruPrbigSRKc8zgyg==
X-Received: by 2002:a17:907:a06b:b0:730:9496:4f63 with SMTP id ia11-20020a170907a06b00b0073094964f63mr10323118ejc.238.1660569916757;
        Mon, 15 Aug 2022 06:25:16 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id j4-20020aa7ca44000000b0043d1a9f6e4asm6703036edt.9.2022.08.15.06.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:25:16 -0700 (PDT)
Message-ID: <fc250b82-c7c7-9215-f3dd-be87e0a72edd@redhat.com>
Date:   Mon, 15 Aug 2022 15:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable
 method")
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220812222509.292692-1-luke@ljones.dev>
 <20220812222509.292692-2-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220812222509.292692-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 8/13/22 00:25, Luke D. Jones wrote:
> The dgpu_disable attribute was not documented, this adds the
> required documentation.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thanks for the patch. Note that the Fixes tag should be above your
signed-off-by and then the patch should otherwise have a normal
subject + body. I've changed the commit msg to the following
while merging this:

"""
platform/x86: asus-wmi: Document the dgpu_disable sysfs attribute
    
The dgpu_disable attribute was not documented, this adds the
required documentation.
    
Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable method")
Signed-off-by: Luke D. Jones <luke@ljones.dev>
"""

and I will make similar changes to patch 2/6 and 3/6
> ---
>  Documentation/ABI/testing/sysfs-platform-asus-wmi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 04885738cf15..0f932fd60f4a 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -57,3 +57,12 @@ Description:
>  			* 0 - default,
>  			* 1 - overboost,
>  			* 2 - silent
> +
> +What:          /sys/devices/platform/<platform>/dgpu_disable
> +Date:          Aug 2022
> +KernelVersion: 5.17
> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Disable discrete GPU:
> +                       * 0 - Enable dGPU,
> +                       * 1 - Disable dGPU,
> \ No newline at end of file

Next time please make sure the file always ends with a newline
even in intermediate patches.

Regards,

Hans


