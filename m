Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242714D7676
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiCMPhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiCMPgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92669723CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647185744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lIyBMBGORfp1VxiABBqMU4c3GxXnpu4EV87YIyaZMI=;
        b=bChcxHYKWd/T4sDxR4B5tj/Z58ew73S9xl7EODfAeZoR3coVMzT+Sd3tnRDBP5R57SD84r
        H6nkpWl38rTb1Q1OegDdzKLqWAqsy+1vlDhExF3boobCRockkl/p++EqpIoEtJqm1aXjHw
        tOgUKLW6/iheHJdyKjO1wntF12qmsnU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-ehKApbcXMASilGmf16-fzA-1; Sun, 13 Mar 2022 11:35:43 -0400
X-MC-Unique: ehKApbcXMASilGmf16-fzA-1
Received: by mail-oi1-f197.google.com with SMTP id m16-20020a056808025000b002d9ddfbc38fso9793310oie.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8lIyBMBGORfp1VxiABBqMU4c3GxXnpu4EV87YIyaZMI=;
        b=1MurW2UbL3QaR02VmmV4rf0h9LfDghjChfmrRVQvhy+iypWZvqwknEU+10hPs9f6Dv
         GNE3lv9FEsjOFwH9tLcg5mxDQR7T7Y6uHIGVgcpOijaQmR8p0TgmsmDyulIoHU/82SVv
         RcIplQscE2zUv1uIWeQYVBhxFulrzXoFjY5d+wtrfMFZDyJZAlYMQrECpA52hNkUW+LB
         PIm5X1vtXNDPFX8dj7+yVi6SS1as0JUrz6wcg1HFJBbiqq8EbdFulyygJYZqp8iJkgdV
         Ecg+h6+RerShzmQ5d7m2eN+akTTuUUZOjLXy9ODbG2ojrJZmJpdI4hQDh0a99h1VFsf/
         lK2Q==
X-Gm-Message-State: AOAM5334slx5AJLMwGseQ6mJFuhb/h80jisaJfIqoEVFhE/6o0RP1SeJ
        QA2Xzwv/v/3jYnuM6tzjrIHWKg48WBjBQh6spXTCEEb+kEWqFXmAPGE/p4vhaWi/ckG7yw44HaW
        VysrtRUcdlyPZuT0Xnu8lo2D+XAIVzLpGHGnYIch5y+5dIdDSChShwi1b7qLpjnOjRVdh4OA=
X-Received: by 2002:aca:2119:0:b0:2ec:a7ff:c042 with SMTP id 25-20020aca2119000000b002eca7ffc042mr5766992oiz.73.1647185742614;
        Sun, 13 Mar 2022 08:35:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiUqUbO1cgdW16d+fK6APreS35khYTNjQE4uRvu0O4kZQO/jSJCfXtJ8gHlGESptMtsI5+bg==
X-Received: by 2002:aca:2119:0:b0:2ec:a7ff:c042 with SMTP id 25-20020aca2119000000b002eca7ffc042mr5766977oiz.73.1647185742376;
        Sun, 13 Mar 2022 08:35:42 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s2-20020a4ae482000000b0031c42eb457csm5875274oov.43.2022.03.13.08.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 08:35:42 -0700 (PDT)
Subject: Re: [PATCH] media: stkwebcam: move stk_camera_read_reg() scratch
 buffer to struct stk_camera
To:     Pavel Skripkin <paskripkin@gmail.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, cai.huoqing@linux.dev,
        xose.vazquez@gmail.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312173049.1410977-1-trix@redhat.com>
 <65a1d178-8511-a023-2655-94540114086c@gmail.com>
 <c3723690-cacb-0c42-cc5d-397a3363b4da@redhat.com>
 <0d8dfedb-1c2c-1a70-18dc-0c4439cf4bda@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b5711870-b047-d1cb-d272-b193175d6238@redhat.com>
Date:   Sun, 13 Mar 2022 08:35:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0d8dfedb-1c2c-1a70-18dc-0c4439cf4bda@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/13/22 8:11 AM, Pavel Skripkin wrote:
> Hi Tom,
>
> On 3/13/22 02:48, Tom Rix wrote:
>> These do show up in my usual static analysis and it why I was looking at
>> this file.
>>
>> And was sidetracked by the short malloc.
>>
>> Unfortunately I looked and there are many other similar instances
>> treewide ~100
>>
>
> Most of them are in very old drivers and I don't think they ever be 
> fixed. I've looked into one bug reported by syzkaller and there was 
> like 30 calls w/o proper error handling in one driver. Redoing whole 
> driver logic without access to hw seems dangerous :))

 From the checkpatch change below, there are about 150 dinky allocs treewide

Here is a refactoring

https://lore.kernel.org/lkml/20220313141008.1503638-1-trix@redhat.com/

>
>
>> These aren't caught in checkpatch, so working on that..
>>
>
> I think, it's not checkpath responsibility. Maybe it worth adding such 
> check to smatch. I tried to implement such checker, but never finished 
> it :(
>
>
Poking new development to not do dinky allocs I think is worth it, here 
is my checkpatch patch

https://lore.kernel.org/lkml/20220313140827.1503359-1-trix@redhat.com/

steal the regex for smatch.

Tom

>
> With regards,
> Pavel Skripkin
>

