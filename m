Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D623519BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiEDJ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347185AbiEDJ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:29:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267D25EBB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:25:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so1014077edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q+Z/CcX4Id4JbsXonHSGB6ejiNGBlahZ75nCWD3W3RM=;
        b=scFF/Vl4bGjvxuOPaey/7QOBiztze+VFXr7ZvitQ52CkAHr/2Kp26vvU0bhAozkUun
         gr1Dy36O8h9O3Yl5s2Pk3aqE2vFCcgAruFoT8BhKy2mbwdeUgtlYNYttn/86zsziYNEU
         TeXfjSyfkCxEQVhrVtU2UVvoMxYYN5xcCgPG5WLl3ODiBqOALxGSwRxJpBSFYmYVycP3
         rOFCFBdyOz/MGvu0zEuVtp3YP/0hCBxDOVTbrn6NSS1/sWGbrTZaH852apDqX5dcifMs
         yKo/uHElQ9JOfU/srpkQR6OBxwH8e0f7FIzV4zndPFZd0QZxt4zE19fFgs4es8FvlmlY
         h0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q+Z/CcX4Id4JbsXonHSGB6ejiNGBlahZ75nCWD3W3RM=;
        b=IuE8DuGQMTDKbkgx56VyuW51iTVa2SjQmHKhGeidMBNMYUoAgrq2fN2NcfN20hQ+xB
         3jezs8QiYNYGIACV1H+oEK38xW5PWVoYArtLK54dzwdle+6w7ie4C2OCZRTJAvDeilxS
         3QDmTQPgH2je/dCUQZZY9lC3byXdtguC91Y3xYMTkveoeRAlQ8jLtzjGRaYFmOwkyrZZ
         JJV75kotR/HI4ehrT7dgJK45UMTRz72vjxyiDlZZjCxTM63txaux2dxEEHXliAKJQOig
         Dm0+2SmkEqlUS0loG31WE1mg845zIFoSA7BSkormW7WeyhXPtTho2atYigu/4Kd5kimH
         15ZA==
X-Gm-Message-State: AOAM530LRhxRM34mrN+pmTYRkQ8yOMLTqKzK8BEBM5EH9QvTeUhuJzDj
        PATU5ziy4caJggW4usFf2bS+Fw==
X-Google-Smtp-Source: ABdhPJwKNOKsOvROYrLOBQu7wO7jR60NHxZ8OdxoNzOegcF1BHg80TmYssVHWv4xbPTOTU1kxlwF7g==
X-Received: by 2002:a50:d79a:0:b0:425:e577:c71a with SMTP id w26-20020a50d79a000000b00425e577c71amr22118629edi.188.1651656339695;
        Wed, 04 May 2022 02:25:39 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w5-20020a170907270500b006f3ef214db4sm5395395ejk.26.2022.05.04.02.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 02:25:39 -0700 (PDT)
Message-ID: <f927e316-25ab-fed6-5b78-33db478fbf06@linaro.org>
Date:   Wed, 4 May 2022 11:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [next] db410c: WARNING: CPU: 3 PID: 57 at
 kernel/locking/mutex.c:582 __mutex_lock
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <CA+G9fYtYRVKKRx=W7npj911E8QPY9UObSBCppFyGGkT=wZsXFQ@mail.gmail.com>
 <CAK8P3a062No7XP5AUcpc5ZdECmDUUWgGfP+fdXqY2Ko=HnYHbQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK8P3a062No7XP5AUcpc5ZdECmDUUWgGfP+fdXqY2Ko=HnYHbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 11:22, Arnd Bergmann wrote:
> On Wed, May 4, 2022 at 11:09 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
>>
>> Following kernel DEBUG_LOCKS_WARN_ON(lock->magic != lock) noticed on arm64
>> dragonboard 410c device while booting Linux next-20220502 tag kernel.
>>
>> warning:
>> ---------
>> [    6.052275] ------------[ cut here ]------------
>> [    6.052289] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>> [    6.052314] WARNING: CPU: 3 PID: 57 at kernel/locking/mutex.c:582
>> __mutex_lock+0x1dc/0x420
>> [    6.052345] Modules linked in:
>> [    6.052361] CPU: 3 PID: 57 Comm: kworker/u8:2 Not tainted
>> 5.18.0-rc5-next-20220502 #1
>> [    6.052374] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>> [    6.052384] Workqueue: events_unbound deferred_probe_work_func
>> [    6.052408] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    6.052421] pc : __mutex_lock+0x1dc/0x420
>> [    6.052434] lr : __mutex_lock+0x1dc/0x420
>> [    6.052446] sp : ffff80000c42b9a0
>> [    6.052453] x29: ffff80000c42b9a0 x28: ffff80000b314860 x27: ffff00000408810d
>> [    6.052481] x26: ffff80000adb4bb8 x25: ffff000005220a74 x24: 0000000000000000
>> [    6.052506] x23: 0000000000000000 x22: ffff800008bbef8c x21: 0000000000000002
>> [    6.052533] x20: 0000000000000000 x19: ffff00000c1a5110 x18: 0000000000000000
>> [    6.052558] x17: ffff800008bbd594 x16: ffff800008bc10f4 x15: ffff80000927b6c4
>> [    6.052585] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 5f534b434f4c5f47
>> [    6.052611] x11: 656820747563205b x10: 0000000000000029 x9 : ffff8000081cc7b8
>> [    6.052637] x8 : 0000000000000029 x7 : 0000000000000013 x6 : 0000000000000001
>> [    6.267204] x5 : ffff80000adb5000 x4 : ffff80000adb54f0 x3 : 0000000000000000
>> [    6.274321] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000005265080
>> [    6.281439] Call trace:
>> [    6.288524]  __mutex_lock+0x1dc/0x420
>> [    6.290789]  mutex_lock_nested+0x4c/0x90
>> [    6.294610]  driver_set_override+0x12c/0x160
>> [    6.298605]  qcom_smd_register_edge+0x2d8/0x52c
> 
> The problem is in
> 
> static int qcom_smd_create_chrdev(struct qcom_smd_edge *edge)
> {
>         struct qcom_smd_device *qsdev;
> 
>         qsdev = kzalloc(sizeof(*qsdev), GFP_KERNEL);
>         if (!qsdev)
>                 return -ENOMEM;
> 
>         qsdev->edge = edge;
>         qsdev->rpdev.ops = &qcom_smd_device_ops;
>         qsdev->rpdev.dev.parent = &edge->dev;
>         qsdev->rpdev.dev.release = qcom_smd_release_device;
> 
>         return rpmsg_ctrldev_register_device(&qsdev->rpdev);
> }
> 
>  static inline int rpmsg_ctrldev_register_device(struct rpmsg_device *rpdev)
>  {
>        int ret;
> 
>         strcpy(rpdev->id.name, "rpmsg_ctrl");
>        ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
>                                  rpdev->id.name, strlen(rpdev->id.name));
>        if (ret)
>                return ret;
> 
>        ret = rpmsg_register_device(rpdev);
>        if (ret)
>                kfree(rpdev->driver_override);
> 
>        return ret;
>  }
> 
> This allocates an uninitialized device structure that is then passed
> driver_set_override() before calling device_register(), so the
> mutex is not initialized yet.

Folks, this was already reported by Marek and fixed:

https://lore.kernel.org/all/20220429195946.1061725-1-krzysztof.kozlowski@linaro.org/

This has to go via Greg's tree.

Best regards,
Krzysztof
