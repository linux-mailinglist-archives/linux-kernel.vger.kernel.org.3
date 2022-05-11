Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEAA523436
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbiEKNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242446AbiEKNZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:25:21 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E974359BB6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:25:19 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-deb9295679so2778722fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0q9lSthzZA9ebdoWrGjLlspxL9ScqJqzeHJj1mFYns=;
        b=GDn6VZwUdzoS/PZ3WZphP5KfT1waNs06jisSm83Jmg2BvTfSwzZete6ZPWfptb04rq
         g5gUU7fic3GIzM1Mgeq4JVyhRZapxoA3A5msRnO/lcN93aupjMeMB1YeJk5wDGEsh2s+
         /otBPjaEM/keLmsADusUhUrkg9HGpi0c/zIlFTvtbzA2URjuV40krxeE8ivst2gpB10d
         KPsvuLy6lbiisozNE/mGASP7jdxF8LcLJaU7qwg1MDEaw6qxWAJ5KwY229psO1EdgQUj
         RQPqZq5elN4LeBdj+dxcQH2rYWZUA03ERM8kmtcUUl/uEzBUF/ixcHUkXxazJCFaYtqL
         JmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0q9lSthzZA9ebdoWrGjLlspxL9ScqJqzeHJj1mFYns=;
        b=faLGjOhBqyCLeB86velOMqbZNRBMcxfkDwCaX3jmFV7uWRpmOV8uu9AjNi8jvtcrdm
         RwTP09bhgfqOrLgcwVJtc7pLfX8Clxj8y1Cf1aFOyQ4sZJcJtj7sdzJNABQ47aO5ijq2
         pyBqHYlRAuOAX/ujRoRMCKvECD0eCwTLcs6/DrGxBjfZvO4B1LfUcfj12hv/d7TFzK9b
         6BbU/Iu5+b0oJ43nlvwBlUU/GlvI/QXj48yXiXa1d3or3GLQqv1z8N5uGVObyzkhWxNu
         Ba/ZtylVwDXpCd36Z/fmrJSlex5Q6/MfMBbBWaadpU+9MAh1DVq2teYAQXcFLk4ra/uj
         WQwA==
X-Gm-Message-State: AOAM530KSLG6GurNpzwcYS83q95UOko1S2w+99PqXxhB8pzMTEbHm1Cn
        ax66biXRZZA4/6QFnLYDEermpK/4wpNU1xqDRiPpx2ogYEchPA==
X-Google-Smtp-Source: ABdhPJz7GZ239s8+Wyg43/9unyRDmzOMvixUoOirET5gfDUKRAXG43OA/6RgP9YY/rZrHzWsdXtenPGfRKzZBh1mT0k=
X-Received: by 2002:a05:6870:5b89:b0:e9:bb4c:a6f1 with SMTP id
 em9-20020a0568705b8900b000e9bb4ca6f1mr2718055oab.52.1652275519287; Wed, 11
 May 2022 06:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220511124336.66705-1-schspa@gmail.com> <YnuyuFRaDTY2n4VB@kroah.com>
In-Reply-To: <YnuyuFRaDTY2n4VB@kroah.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Wed, 11 May 2022 21:25:08 +0800
Message-ID: <CAMA88TrZFp9XJ1YvAo_5JOEhtJ5wyueOLLVDnLPU=gxzvzN=sA@mail.gmail.com>
Subject: Re: [PATCH] driver: base: fix UAF when driver_attach failed
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, ming.lei@canonical.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, May 11, 2022 at 08:43:36PM +0800, Schspa Shi wrote:
>> When driver_attach(drv); failed, the driver_private will be freed.
>> But it has been added to the bus, which caused a UAF.
>>
>> To fix it, we need to delete it from the bus when failed.
>>
>> Fixes: 190888ac01d0 ("driver core: fix possible missing of device probe")
>>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> No blank line needed after fixes:
>

Do I need a new patch version for this ?

>> ---
>>  drivers/base/bus.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>> index 97936ec49bde..7ca47e5b3c1f 100644
>> --- a/drivers/base/bus.c
>> +++ b/drivers/base/bus.c
>> @@ -617,7 +617,7 @@ int bus_add_driver(struct device_driver *drv)
>>      if (drv->bus->p->drivers_autoprobe) {
>>              error = driver_attach(drv);
>>              if (error)
>> -                    goto out_unregister;
>> +                    goto out_del_list;
>>      }
>>      module_add_driver(drv->owner, drv);
>>
>> @@ -644,6 +644,8 @@ int bus_add_driver(struct device_driver *drv)
>>
>>      return 0;
>>
>> +out_del_list:
>> +    klist_del(&priv->knode_bus);
>
> Odd, how did you find this?  Has this ever been triggered by any
> real-world situations?
>

I found this when fixing this issue via code review.
Link: https://lore.kernel.org/all/20220508150247.38204-1-schspa@gmail.com/

It shouldn't not happen, unless the bus driver's match() return value < 0.
Which never happens with the existing bus drivers.

> thanks,
>
> greg k-h

---
BRs

Schspa Shi
