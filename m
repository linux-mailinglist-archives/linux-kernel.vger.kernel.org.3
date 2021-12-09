Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089E246DF2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbhLIAHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhLIAHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:07:45 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED87C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 16:04:12 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b19so4622050ljr.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 16:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NwkfgwE4hFBKZOW6AEiviT1UwHpyhZyudjz2jFh5pGs=;
        b=X4vu2guvvme1GenhG1YxA9LNY4p/yipWtN9Kyoc4It4SP0xJ1KI2qumwOEyNJxOXnG
         xx9Sthx5uQTmF6bKpQPYEImtzJbZtBpL5ErzUi4f7OcjqEsMe/gkQXDLX2dEluE6hylE
         IF0MNaKpcZp4f0YgeDdXVjtG6HJkqsd8P8fVrTiYSWtvxILZJDrL5f099w3RbvObkiuS
         GDf7luj1TFhO4VAm7bq8e8sZzd3GzLN46ID/eoOD7TRrcYhyT4SMez+LOt5TgFsSBfYm
         tE4JJgXxiK184TA3/nzom1OShnA+mpRWR1KQFlwkQQ0+YivYT1V0sH5HbTpWWzYjzZvl
         WPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NwkfgwE4hFBKZOW6AEiviT1UwHpyhZyudjz2jFh5pGs=;
        b=vhIopmCpJTzraDH7k4PFnEP5+dmGr0bfBwP57EbQM7DmfjNJL4Y7bBhJKDUKktSTHc
         GesKsXnd0x+jKFwhPF/n3apO5Rw9uaUwOgy9jhsF0eXv42QtmK1MdPO61HDKH80a7zEO
         DLjSoEdCB000DO1njvunpi1Hl88+iH5Ra9SnhoOxWIZwL7aIOBN0ZjTSc3RvNldDasko
         h0ik7N4DSmE6jdMP8j3aJ4YqQ4EXgZpqfRXZVrALZCFQoGEnlJAL6Casqk7IFVwp97mH
         zpQRdfT0Oi1p8R9eo6HhiENwyViPE13Tq5/ZzhdsjTK5OY192wxOw2P5y1KraSDRi7mQ
         g+MA==
X-Gm-Message-State: AOAM533T9tn14GvsTpXu4uoT4IMIAUz+HN7baLRyeeZuI6ag1hGwCIK4
        VhsXl0qtrDluasBvUByznHA=
X-Google-Smtp-Source: ABdhPJyk013Xzz0RmSxuRkrQ663IkNcmRsJXkp7HTUtRcNHFgY5U5UOFwTjTh/OcCcBciYUb29C/uw==
X-Received: by 2002:a2e:bc1c:: with SMTP id b28mr2747279ljf.500.1639008250838;
        Wed, 08 Dec 2021 16:04:10 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id n14sm376546lfu.285.2021.12.08.16.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 16:04:10 -0800 (PST)
Subject: Re: [PATCH V3 4/6] xen/unpopulated-alloc: Add mechanism to use Xen
 resource
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
 <1637787223-21129-5-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2111241701240.1412361@ubuntu-linux-20-04-desktop>
 <c2e8c00a-3856-8330-8e8f-ab8a92e93e47@gmail.com>
 <alpine.DEB.2.22.394.2112071506370.4091490@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <50997667-7c6c-491d-ff04-11e093fee7f0@gmail.com>
Date:   Thu, 9 Dec 2021 02:04:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2112071506370.4091490@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.12.21 01:36, Stefano Stabellini wrote:


Hi Stefano

> On Thu, 25 Nov 2021, Oleksandr wrote:
>>>> Please note the following:
>>>> for V3 arch_xen_unpopulated_init() was moved to init() as was agreed
>>>> and gained __init specifier. So the target_resource is initialized there.
>>>>
>>>> With current patch series applied if CONFIG_XEN_UNPOPULATED_ALLOC
>>>> is enabled:
>>>>
>>>> 1. On Arm, under normal circumstances, the xen_alloc_unpopulated_pages()
>>>> won't be called “before” arch_xen_unpopulated_init(). It will only be
>>>> called "before" when either ACPI is in use or something wrong happened
>>>> with DT (and we failed to read xen_grant_frames), so we fallback to
>>>> xen_xlate_map_ballooned_pages() in arm/xen/enlighten.c:xen_guest_init(),
>>>> please see "arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT"
>>>> for details. But in that case, I think, it doesn't matter much whether
>>>> xen_alloc_unpopulated_pages() is called "before" of "after"
>>>> target_resource
>>>> initialization, as we don't have extended regions in place the
>>>> target_resource
>>>> will remain invalid even after initialization, so
>>>> xen_alloc_ballooned_pages()
>>>> will be used in both scenarios.
>>>>
>>>> 2. On x86, I am not quite sure which modes use unpopulated-alloc (PVH?),
>>>> but it looks like xen_alloc_unpopulated_pages() can (and will) be called
>>>> “before” arch_xen_unpopulated_init().
>>>> At least, I see that xen_xlate_map_ballooned_pages() is called in
>>>> x86/xen/grant-table.c:xen_pvh_gnttab_setup(). According to the initcall
>>>> levels for both xen_pvh_gnttab_setup() and init() I expect the former
>>>> to be called earlier.
>>>> If it is true, the sentence in the commit description which mentions
>>>> that “behaviour on x86 is not changed” is not precise. I don’t think
>>>> it would be correct to fallback to xen_alloc_ballooned_pages() just
>>>> because we haven’t initialized target_resource yet (on x86 it is just
>>>> assigning it iomem_resource), at least this doesn't look like an expected
>>>> behaviour and unlikely would be welcome.
>>>>
>>>> I am wondering whether it would be better to move
>>>> arch_xen_unpopulated_init()
>>>> to a dedicated init() marked with an appropriate initcall level
>>>> (early_initcall?)
>>>> to make sure it will always be called *before*
>>>> xen_xlate_map_ballooned_pages().
>>>> What do you think?
>>     ... here (#2). Or I really missed something and there wouldn't be an issue?
> Yes, I see your point. Yeah, it makes sense to make sure that
> drivers/xen/unpopulated-alloc.c:init is executed before
> xen_pvh_gnttab_setup.
>
> If we move it to early_initcall, then we end up running it before
> xen_guest_init on ARM. But that might be fine: it looks like it should
> work OK and would also allow us to execute xen_xlate_map_ballooned_pages
> with target_resource already set.
>
> So I'd say go for it :)


Thank you for the confirmation! In order to be on the safe side, I would 
probably leave drivers/xen/unpopulated-alloc.c:init as is, I mean with 
current subsys initcall level (it expects the extra memory regions to be 
already filled)
and create a separate unpopulated_init() to put 
arch_xen_unpopulated_init() into. Something like the following:

static int __init unpopulated_init(void)
{
     int ret;

     if (!xen_domain())
         return -ENODEV;

     ret = arch_xen_unpopulated_init(&target_resource);
     if (ret) {
         pr_err("xen:unpopulated: Cannot initialize target resource\n");
         target_resource = NULL;
     }

     return ret;
}
early_initcall(unpopulated_init);




-- 
Regards,

Oleksandr Tyshchenko

