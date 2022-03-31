Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82E04EDA52
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiCaNQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiCaNQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56B8A1CAF02
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648732497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OkVYYDJlFWTMMc2Z6dX/dM28zN0J9Wa3+IVOAevA2cY=;
        b=bKgIsddZPt7q7y6G/2Ykhzcto85dDVP12+otrtwFNqCrD28kG1y3JWjVVliyaPz4TCb27l
        +m6Fw5v7zSWnm//RSUJIli/xwQD4y9rHx8Aq0nMhMNzJ9DVX1sRULnZykfyfU6KcayrqTp
        PUz5tx0ww+HWob5pZ1JC1WpaBgV1ZYA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-SIfOBvMoOg6dTQSusTmXYA-1; Thu, 31 Mar 2022 09:14:56 -0400
X-MC-Unique: SIfOBvMoOg6dTQSusTmXYA-1
Received: by mail-ej1-f71.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso11540943ejs.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OkVYYDJlFWTMMc2Z6dX/dM28zN0J9Wa3+IVOAevA2cY=;
        b=C8y2TKvZgkfH4i3kPK7AhQFvefdZHI/P9ED5W8QI/EJyxsbBCwRgjfjf5ZKPkjdWUa
         AsJ3DPI7oZj6k4+sR7TanisXWmNFpiS2rP5FL3qL5ESj8uvHznSr75IHxIb12oze6+RP
         XFF42mTvfr7KKFXCncH6GiYWOtintsh5EA/mhzlwRX0ipIytiBl0gU9a5JiLXfxM16cH
         qIqK/xKQRzSQMdTYPPMRToUSKkFu0mFO6vF06IHTZXLrPqsx0cz+Y69TzApYJAv2AniN
         Ge1DrOIUboU5lgTH9odA8aOhVliyAB3AN6HyJUCobauKHHaEUNuEMaOBOKZ2bGvkQJKF
         Qadg==
X-Gm-Message-State: AOAM533L4dhAW2Efno7q/pwJPo0TfT9Prm3Tog0UTRLUs/n9b5hNYY5e
        kikSkL8UY9ktzoSNGaTKhO6V4eHTr9oO6Ogni23nm/klG58iKagyRUfIwa7pLYGRbs7Mum7L5+m
        C8i00Srqu5HSQpIiZIG4CR3AK
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr4827468ejn.437.1648732494961;
        Thu, 31 Mar 2022 06:14:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQzDYHAQVupCNTQk/C9Em0Ge5tk+eDG8bVZlBMOj8UpAlVt/FON7lA8mjtW2a+kFCvkwIF3A==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr4827444ejn.437.1648732494661;
        Thu, 31 Mar 2022 06:14:54 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:8ca6:a836:a237:fed1? ([2001:b07:6468:f312:8ca6:a836:a237:fed1])
        by smtp.googlemail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm9335197ejb.194.2022.03.31.06.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 06:14:54 -0700 (PDT)
Message-ID: <be9244bb-8004-05b1-9cb3-0e0852b6f712@redhat.com>
Date:   Thu, 31 Mar 2022 15:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [next ] x86: Assembler messages: Error: invalid operands (*UND*
 and .data..percpu sections) for `+'
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev
Cc:     Li RongQing <lirongqing@baidu.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
References: <CA+G9fYsaUWL4MfkmFJGyZ5WRjibieSLE1V1R8OPsWNmjeYWyUQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CA+G9fYsaUWL4MfkmFJGyZ5WRjibieSLE1V1R8OPsWNmjeYWyUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 14:45, Naresh Kamboju wrote:
> Linux next-20220331 x86_64 build failed due to below warnings / errors
> with gcc-11. build log link [1].
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=x86_64
> CROSS_COMPILE=x86_64-linux-gnu- 'CC=sccache x86_64-linux-gnu-gcc'
> 'HOSTCC=sccache gcc'
> /tmp/ccS5DmVa.s: Assembler messages:
> /tmp/ccS5DmVa.s:59: Error: invalid operands (*UND* and .data..percpu
> sections) for `+'
> make[3]: *** [/builds/linux/scripts/Makefile.build:289:
> arch/x86/kernel/kvm.o] Error 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Fixed already, but thanks for the report!

Paolo

> metadata:
>    git_ref: master
>    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>    git_sha: fdcbcd1348f4ef713668bae1b0fa9774e1811205
>    git_describe: next-20220331
>    build link: https://builds.tuxbuild.com/278RMAf1jcRHx7LwzjCMgFSMMLt/
> 
> 
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> 
> tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-11
> --kconfig https://builds.tuxbuild.com/278RMAf1jcRHx7LwzjCMgFSMMLt/config
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> [1] https://builds.tuxbuild.com/278RMAf1jcRHx7LwzjCMgFSMMLt/
> 

