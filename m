Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280475170B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385337AbiEBNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385346AbiEBNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03369DF01
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651498757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AACCYwEb3HAEwNDAWzh6kcVyACHhLSxVfI/MApFcd18=;
        b=K5e678xA1LSNJSzVEU6wUOVqslkHv57QMs14rl+Azv2dqvh1YrUrf6JezAZN0jN54diW3R
        cJ1KsyghtCEJPj3Iyx+8/9DvOLnggOWilI274c7V3/PtpoXrSsMB5EyzJn5j7AZIrmMzOT
        xZNtmeCMefxjzRM0colJ0C6FsWfDH0w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-6NUqvsDkMkKIlf9hwQPv5A-1; Mon, 02 May 2022 09:39:16 -0400
X-MC-Unique: 6NUqvsDkMkKIlf9hwQPv5A-1
Received: by mail-wr1-f71.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so5307117wrg.19
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AACCYwEb3HAEwNDAWzh6kcVyACHhLSxVfI/MApFcd18=;
        b=NTzMMTx19b3JfdVmaRtLaOz2BTi43TknUPmOfXGyTT0DNMdwrw6nR9S6MMAHLHdLe7
         K3eN7Cwr1dQVnxoIAatST+LNzLvw+Fama5i3L6mbe0vQZl/r/kY1YnVmtbaKgdw50l7N
         WhPukVdUCwN2HA4Tz8r+Sufo3Ey9ukYeS9ncmqIlIpWuPUUEF1Z2eruA+3wPUSJEYKvL
         DnyFTxEhjnp8724QG4oS4/mclyv9C9IAHCmG2mf1wVlKgrONLezkAlSWz4Y1WJwLgAKu
         Y63E67CK4JN9fyXJ3A3G6sYhA1DA2Q/Kf2flR7VLNfXdNsEks51yiMY8uTbCaebAfXL9
         GjJA==
X-Gm-Message-State: AOAM530hBcealNIK8KuJBTKx9VxiXfQ4wZbHLVRJ/IIUX4T0vrVIxOwh
        yqvEpeLpyxvDC7g9Fc2EyJ7TPNPJEEegfhYVun37c9o265pGuuK3sgMj9zp6Ur4TjLnyZZ5kVVn
        TKiiNnN/u+2zy2HWTWsrqMBkA
X-Received: by 2002:a5d:6949:0:b0:20a:e021:f8e0 with SMTP id r9-20020a5d6949000000b0020ae021f8e0mr9732262wrw.231.1651498754780;
        Mon, 02 May 2022 06:39:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiFHiruw5PqOFfDYvA2cdleMn/Sl8zUlYotGSp7XuBWv4ZRfgdGg8OrKeSHP/woSkX0+a5Lw==
X-Received: by 2002:a5d:6949:0:b0:20a:e021:f8e0 with SMTP id r9-20020a5d6949000000b0020ae021f8e0mr9732248wrw.231.1651498754561;
        Mon, 02 May 2022 06:39:14 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v22-20020adf8b56000000b0020c5253d8d4sm7052912wra.32.2022.05.02.06.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:39:14 -0700 (PDT)
Message-ID: <f4430a8a-1112-9f27-4c38-4fc852c811fd@redhat.com>
Date:   Mon, 2 May 2022 15:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220502130944.363776-1-javierm@redhat.com>
 <20220502130944.363776-3-javierm@redhat.com>
 <193c9eef-af13-219c-e5e0-2cc9469bf562@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <193c9eef-af13-219c-e5e0-2cc9469bf562@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/2/22 15:20, Thomas Zimmermann wrote:
> 
> 
> Am 02.05.22 um 15:09 schrieb Javier Martinez Canillas:
>> A reference to the framebuffer device struct fb_info is stored in the file
>> private data, but this reference could no longer be valid and must not be
>> accessed directly. Instead, the file_fb_info() accessor function must be
>> used since it does sanity checking to make sure that the fb_info is valid.
>>
>> This can happen for example if the fbdev driver was one that is using a
>> framebuffer provided by the system firmware. In that case, the fbdev core
>> could unregister the framebuffer device if a real video driver is probed.
>>
>> Reported-by: Maxime Ripard <maxime@cerno.tech>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks.
 
> This seems like the correct thing to do in any case. Thanks for the 

Agreed, it's certainly a bug if not the same that was already reported.

> patch. Before merging, you should also add
> 
> Fixes: 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced 
> removal")

I thought about that but I don't think that's accurate since the bug is
not related to that commit. That might make easier to reproduce it but
is something that would happen anyway if for example someone attempted
to remove a module or unbind the device using the sysfs entries.

Maybe I can comment in the commit message that this change made it more
likely to occur and for that reason I'm adding a fixes tag.

> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
>

Indeed.
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

