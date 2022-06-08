Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1081543B61
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiFHSVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiFHSVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D62213391B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654712490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AplAc6a8QOXCETcO7123jkvaZ+lJW5aCuY9fsYD1Od0=;
        b=IiW8PB/p0kegPDR9/5CdTfVIdJgCBdv4KvbJnu4Brc24YbeK6EEOfZFCAB+hbM+gj7Ciia
        Pntt189n4lZeYDndgXZ2N71ebBSD5HYyhMnYX7T+CRdU+GfiV/0Arx14pqnoRvYelIg66C
        dYLoy4r4rQPr+7OFHVF5sXa8Y/jYuxE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-BVNE5H2JOEiyZDoeXevbtw-1; Wed, 08 Jun 2022 14:21:29 -0400
X-MC-Unique: BVNE5H2JOEiyZDoeXevbtw-1
Received: by mail-wr1-f70.google.com with SMTP id ay4-20020a5d6f04000000b002183e363f9bso2901258wrb.22
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 11:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AplAc6a8QOXCETcO7123jkvaZ+lJW5aCuY9fsYD1Od0=;
        b=5AEHxy+RmcLY+FjV37rFXwk4FZwd8o/48XTqakimhjbjBW4Pw7dOB7YPnYzv3HBnJw
         VT0weSxRlvtfD1M+ADqG/Qa1WdeYDqn+JeZD+iHZuHxE1//A+hmO5l5ygqCtHWhKebVT
         vYhsuQaw8QE8heCREyYD979C9S+W6vIK4/LINf3sA4UjNTxD/X8Nsv9iqBuoqQ2QrvVr
         ZQgp71qedC27OgiDYuLAQDOPbKTK1PI9nHeauUmCUWa2rET7t/RN7q3E6+6nQXm419+Z
         JNcXtmjKZCCPZnJjvClwDrpkhH5ny/edUCjY1z49VhN7cA85xb+LZANt2zxxCn50f15e
         Ja2A==
X-Gm-Message-State: AOAM531UCkhBb1ny9ZX/GgAT+5ILI89dDBGAJjnqvNGfy+zyApo1tYDx
        44bRlcGeYxByh9yNpwaBDurnxk8p0WlYOX4chcuX23T2w2lrpmKiEZ/6Y9ZwDFyNks+9KonDD19
        nOub+WXAu8YgLhse/31UBaGe7
X-Received: by 2002:a5d:59af:0:b0:20f:d3fc:c5ba with SMTP id p15-20020a5d59af000000b0020fd3fcc5bamr34709236wrr.436.1654712487854;
        Wed, 08 Jun 2022 11:21:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytN1yNREN+xEJL+PmOrUb+qQLHlPiSWENDFL16UOHvtBZ3/qpuCv5lltkP8wjt/dbq5fCq8A==
X-Received: by 2002:a5d:59af:0:b0:20f:d3fc:c5ba with SMTP id p15-20020a5d59af000000b0020fd3fcc5bamr34709210wrr.436.1654712487545;
        Wed, 08 Jun 2022 11:21:27 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i19-20020a1c5413000000b0039c457cea21sm14833010wmb.34.2022.06.08.11.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 11:21:27 -0700 (PDT)
Message-ID: <18d9e587-b4f7-6ee7-185a-af0e667e0ec5@redhat.com>
Date:   Wed, 8 Jun 2022 20:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>
References: <20220601173204.1372569-1-javierm@redhat.com>
 <20220601173204.1372569-4-javierm@redhat.com>
 <87h74vteb1.fsf@mail.parknet.co.jp>
 <ddd3eb76-5595-4946-95c2-067d5fbaae99@redhat.com>
 <87czfjt726.fsf@mail.parknet.co.jp>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87czfjt726.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 19:10, OGAWA Hirofumi wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
> 

[snip]

>>> Probably, we should change the nlink only if both of dotdot update are
>>> succeed and different file type. Otherwise, we would have to revert the
>>> nlink change on error path (and can remove unnecessary update as bonus).
>>>
>>
>> Agreed. I'll wait a few days before posting v5 in case you have more
>> comments on the other patches.
> 
> Ok. I have no comment other than this at least for now (reviewed all
> patches). If I found more on re-review I will send email.
>

Perfect, thanks! If you reviewed all the patches already then I'll send
the v6 tomorrow.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

