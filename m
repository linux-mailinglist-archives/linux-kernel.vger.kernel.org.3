Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600E24C21DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiBXCu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiBXCuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:50:55 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62945237437;
        Wed, 23 Feb 2022 18:50:26 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4so772073pjh.2;
        Wed, 23 Feb 2022 18:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0pXW77xbSqoqd07SPOdMy6+frewnUErjG3BJoCU9xDQ=;
        b=BLl5H9NX6YUNRD93h7c/vngLNJjudh/21VVtQn4DmFm4iDSShGw+uLt07zvfShhW07
         dBYZBERO7cmVboh9TwHp4FnA0CzWX/LLjG/N9A4qmDJc5UgIOmuW9HBCw4Jqf0OUHbsN
         ju92gxmIxzoNxkGEBgCoHLq0olkXCLU1qmV91MD/PB7gdQlmtmr8FSSTFasK5a17Dibc
         jiOodnBm1xqhGEo+nLPFpXvTQlQH7f2ma5h9pNIJdcUVegGGpIjCsFujiF88i4MZXsyJ
         CHvy3p+RAGAQvwJKOxFy+hPumyv6LsvMokjYvbhpB0iuqqvs9VOli87W8AT8tO1xriAE
         EXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0pXW77xbSqoqd07SPOdMy6+frewnUErjG3BJoCU9xDQ=;
        b=A7gx/tmD8EZ+KsSnFgwjsbzZRrt3IMALyhPROB22cfqeS6r61OaKl7lm51pU80KYpY
         GAG4BXOCH4gSQjbtA/taZ0WPmHmQiXkwZdkHS8qp3CIo0mVJmmXklXDps/NIGWJEmfdk
         /bOC4jRN1bRE71Ii6xkcrKQV3pQWQplowyK+aZM6ji3hv1pWmM0WS6DEsYv9wmcQpzJR
         4Sw35iwpZsiM9sIThaLox7Wf39m0JcLB+KJxtZV3q5BsMNKH7GTSDVMDKBlgk5PUHKEf
         hHuL0h4YxyeZEoQVgNiaTRxX2wISoylbfczlYOBRq7f/bCEK2VxilJY1aftDbx2hKJvC
         P7eA==
X-Gm-Message-State: AOAM5334HNE+ouKYRUtGi0jue34lTE82T3qWFs6SRU0ZXwFRny3rYITi
        gnt8TtIyYq4wvTjeCqhP3s4=
X-Google-Smtp-Source: ABdhPJz24dHKQmcXqS7azyJDfNBw3zXK87BYAbvO4kajEuZofKqEzzgChDHeA43qUG4bxXTECXNDiA==
X-Received: by 2002:a17:90a:fb84:b0:1bc:4d16:51fb with SMTP id cp4-20020a17090afb8400b001bc4d1651fbmr12561044pjb.22.1645671025820;
        Wed, 23 Feb 2022 18:50:25 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id 84sm906752pfx.181.2022.02.23.18.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 18:50:25 -0800 (PST)
Message-ID: <7489a7f8-2589-29de-1c95-b99d1d9b1850@gmail.com>
Date:   Thu, 24 Feb 2022 10:50:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
 <YhUbCH+dhKkgMirE@slm.duckdns.org>
 <2e17c058-8917-4a37-896e-1093446339f6@gmail.com>
 <39db454d-ca30-fb42-3d72-899efa34fb78@gmail.com>
 <YhapCurbiI21WYmm@slm.duckdns.org>
 <efd94670-9d6d-5651-358c-2f88646298cd@gmail.com>
 <Yhbod7pJ1X4CGhEZ@slm.duckdns.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Yhbod7pJ1X4CGhEZ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/24 10:07 上午, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 24, 2022 at 09:51:04AM +0800, Wang Jianchao wrote:
>> The initial version of this patchset has two targets：
>> (1) Add a sysfs interface to open/close the policy per device. Then we needn't
>>     waste cpu cycles and memory if the device doesn't need the policy.
>> (2) Make the policies modular, then it easy to maintain the code of policy in
>>     production environment as we only need to close the policy and replace the
>>     .ko file.
>>
>> The loading module when open policy in sysfs interface is just to avoid modprobe
>> manually. There is similar operation when switch io scheduler.
> 
> Each rq-qos mechanism already needs and has a way to turn off itself.
> There's no reason to add another layer on top. If the current way of
> disabling isn't efficient, we should improve that instead of adding a new
> layer of interface on top.

Yes, right now, every policy has their own way to turn off, but we always need to
iterate the rqos list and enter into the policy's callback to check it. And every
blkio cgroup needs to allocate memory for it even we don't use it.

I don't this patchset is adding a new layer, but blk-rq-qos layer has been already
there , we just add a unified interface to open/close the policies.

Thanks
Jianchao
