Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9613E52F127
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351931AbiETQ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbiETQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:56:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C65C87C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:56:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y41so8211972pfw.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L9Uqg73Lka5chFS5zb9bS7SoEX4aGwiCW9rsgcbKHU8=;
        b=WCgjyI/pbMDZt70/ehioRounN5pA+7LkAnLwVBt5i2W43nM7tKoH6B5ttsBfWBgo6D
         ki/kXFgEIVboqXvyQa7Ju8Fe4j2gUlJDvQJ/z1Izt5yPYUeHzutkgKgMvjwLrulEG1hK
         hYg+HgyBXqyq/Z/nhlE7+ssXsm4fP2u2Ob1gqHeRYkLyEKVEmij0ed4Mua47CxL8W+6u
         eN0vFWoaM6bhlCvvxyG1dcvexERXpbuStK1Hp6VfxRKuHrI5RDL7hksQ7bMWM7ynVKmQ
         VvZS5J/C7XumERU5SOsgWCrqosIk8n2xBtOuih/QHUYxR3qQWVyCWhRQaxjLOplJQbrE
         dVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L9Uqg73Lka5chFS5zb9bS7SoEX4aGwiCW9rsgcbKHU8=;
        b=GZXmaC6dllbVUSy3v6clX1YSoyqgqZIq8Lppg96KkSQtBef81pD9LMI3VtPtg7UnDW
         2sQ3VmAuzwxIz0RzNVg/gv4MA8sJ3SnlFpoihCq9pQZrpmsMgUBsYnF/J4xFOU1EvOyF
         eQgTDxWM/2ki8KXqdzRmebYzdeYbuXq/asP+pVNHZ3NwwOmvwx87ZaxVPGxzCCnKPH0F
         Mc0PrqDMtgVwq5qLic9FTqL7p9zAKtenDHJn29eYAkdLJ2k8+NZ2XQWkFYKYJSThHqb3
         vk0XdrBik4jalLk6wF1qrasq6Psd8IwMI9sxQtb+QI53GD2sxPOXRMBn7wu68Ncg1Vl4
         fThw==
X-Gm-Message-State: AOAM5322kXiexJigx8NmV6MQ0+RootrjCQKp3G0u0Jq/yk714RrBlkzJ
        AqcqYs3Ta5j8r+Ybe8F55xVIrQ==
X-Google-Smtp-Source: ABdhPJxxwklaCHPwxufCg4de+9ueaGPfNoNDXbigS4fAynaoaFEgIm1jY/OTJrmDMijuou7j+TuQWg==
X-Received: by 2002:a05:6a00:1709:b0:505:fa47:b611 with SMTP id h9-20020a056a00170900b00505fa47b611mr10982307pfc.65.1653065811417;
        Fri, 20 May 2022 09:56:51 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b00161a2d98a8esm5903314plb.226.2022.05.20.09.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 09:56:51 -0700 (PDT)
Message-ID: <1fadd74c-25d0-b9ab-8a06-27a9faa6579b@linaro.org>
Date:   Fri, 20 May 2022 09:56:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Hillf Danton <hdanton@sina.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
References: <20220412192459.227740-1-tadeusz.struk@linaro.org>
 <20220414164409.GA5404@blackbody.suse.cz> <YmHwOAdGY2Lwl+M3@slm.duckdns.org>
 <20220422100400.GA29552@blackbody.suse.cz>
 <20220519112319.2455-1-hdanton@sina.com>
 <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
 <YodNu2C5iHKW3UeZ@slm.duckdns.org>
 <489592f6-b783-7bdb-2cc8-0c8e35ebc674@linaro.org>
 <20220520164255.GB17335@blackbody.suse.cz>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <20220520164255.GB17335@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 09:42, Michal Koutný wrote:
> On Fri, May 20, 2022 at 09:38:12AM -0700, Tadeusz Struk<tadeusz.struk@linaro.org>  wrote:
>> as this is a result of enqueuing the same css->destroy_work onto the same WQ,
>> one on the rcu path and one on the css_release path.
>> I will prototype it today and test with syzbot.
> In my understanding, you'd need two independent work_structs in a css,
> not two separate workqueues to put the single entry on.

I think either way would work, but two workqueues would be less churn.
I can try both.

-- 
Thanks,
Tadeusz
