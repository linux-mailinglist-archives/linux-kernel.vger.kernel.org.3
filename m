Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929C04F7B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbiDGJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiDGJLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59B4750E29
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649322592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hB372ZQZwFtHcO7eQrCjRw+uc8WqcWd1Sg3EXTJwdeA=;
        b=BSnJdYGbVdL36NcFpY3DjaPtCinTmAKD+zSC6bAZ0qIM3AHkxUV1fHGMEgGVDhujlj0waC
        5OsSPfIZDdItbTvUit0n+cCAYtDm2mJyTREs5/gE/HKP7UuxPSOf7LVqz2uphApzm1ude4
        zolOHFPWYlPqaZEGL0lzslKHsukOwrw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-ecJQl6WjOUyex8BeIJNltw-1; Thu, 07 Apr 2022 05:09:18 -0400
X-MC-Unique: ecJQl6WjOUyex8BeIJNltw-1
Received: by mail-wm1-f71.google.com with SMTP id v62-20020a1cac41000000b0038cfe6edf3fso4297005wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hB372ZQZwFtHcO7eQrCjRw+uc8WqcWd1Sg3EXTJwdeA=;
        b=2miAqkNGT0cYg+d9n35GPgs2vSuM4q7bqNkc4PhgMAuNd6jmz3wjoCV6TV1sKSe65T
         4R75g3xYHYjWWwFbsmD3Ab4YyBP2CZfgPU0ufqacjTXaY8fidE1oPbLvN6PJ3vvyN4Oy
         uta3VrH3RyjAgMRqNU1kgTPLWNS4PsL94VtGYYsuEmuwTomNR9CmgvxHYrIqSPu9IF8l
         MSCgxT80J8V4iAZQaGF77AcoLDfa9uQpJ2jF95odiY3/DzfvKNGxdCHW0l5/gaHNC1MA
         tCBtdb/4ISK1ZKNJlYhB9eekPIY7g77b4qBGtvvTux4wG8yfzcf18T1Vz2GK66LYk//n
         bcmA==
X-Gm-Message-State: AOAM5331aHjKrLTR89mdvjzP9zzm+ol5wwA4zEPgpwewRC/iWOgVpm+h
        orjp1LWO+jnueG7BTkW2ypawUmvaCFyeAGRamv4uO/S2BvtwR0r3ylv73D4CBI+uDF72VuQhu2V
        EAoXsE/oHYjCD0N0AjkAdHguzqQ5pjMaDoW1b6SxLWP77AEVK4jyMosPG1mfJeEH6F9B6xPUcE8
        A=
X-Received: by 2002:a5d:4288:0:b0:206:b7b:db7a with SMTP id k8-20020a5d4288000000b002060b7bdb7amr10086641wrq.28.1649322556300;
        Thu, 07 Apr 2022 02:09:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyl0hLCrJWyvNC3LHUnOPVnkuMzNK6MdN9AyHNReSrLGnx8hW5NAoD1FUkaGxU16mm66GKK9g==
X-Received: by 2002:a5d:4288:0:b0:206:b7b:db7a with SMTP id k8-20020a5d4288000000b002060b7bdb7amr10086613wrq.28.1649322555951;
        Thu, 07 Apr 2022 02:09:15 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c2cc500b0038e9ac68d54sm38955wmc.32.2022.04.07.02.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:09:15 -0700 (PDT)
Message-ID: <4957c527-3346-104e-0265-8231be093d1f@redhat.com>
Date:   Thu, 7 Apr 2022 11:09:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND RFC PATCH 1/5] firmware: sysfb: Make
 sysfb_create_simplefb() return a pdev pointer
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaoqian Lin <linmq006@gmail.com>
References: <20220406213919.600294-1-javierm@redhat.com>
 <20220406213919.600294-2-javierm@redhat.com>
 <Yk6o2MzkMQeSAcsb@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yk6o2MzkMQeSAcsb@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 4/7/22 11:03, Daniel Vetter wrote:
> On Wed, Apr 06, 2022 at 11:39:15PM +0200, Javier Martinez Canillas wrote:
>> This function just returned 0 on success or an errno code on error, but it
>> could be useful to sysfb_init() to get a pointer to the device registered.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> You need to rebase this onto 202c08914ba5 ("firmware: sysfb: fix
> platform-device leak in error path") which fixes the same error path leak
> you are fixing in here too. Or we just have a neat conflict when merging
> :-) But in that case please mention that you fix the error path leak too
> so it's less confusing when Linus or someone needs to resolve the
> conflict.
>

Ups, I thought that had my local tree up-to-date but it seems that was a few
days old. I've updated my remote now and rebased, so will have this fixed in
the next revision of the series.

And this patch becomes smaller indeed :)
 
> Anyway Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 

Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

