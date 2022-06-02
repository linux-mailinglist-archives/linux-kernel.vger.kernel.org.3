Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9553BC73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbiFBQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbiFBQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:25:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BD72B07F8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:25:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id u4so2200320pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ptx9nKuMpe8cN9LSrB99oPepT7glRBTRuC8F0mpobtI=;
        b=lwvLwCAZxW7Mdhe4b1idijTXLUAFniIA9oZKU3gDrHbAxJd4wggZo64h6tFIy7Zz9Q
         wfD5yoHw6l7pVDROPmOfmHIgLwUIi3vlPGWI+AI8ncEjfpAYvZI2TMvVblW7XMFmRcQS
         8HV4A8zcaFG4yzbLO9ze7Rxw3rkbl50ayvbeLFWSKc9x7nDGULudHGKdre4slZDhkKgF
         KCOoT/jM/j89jF3YEGm5bvfppYFA/aL7mFodejrqSN8QZlJ2bi7+coTTqGRQQzzcRK1/
         t0OKjBnmDJD0aiahy4xHvFpYlMOxz08ng2dpsBCndlWR966fT4Zr+Ic9U6o6190N+1W3
         8K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ptx9nKuMpe8cN9LSrB99oPepT7glRBTRuC8F0mpobtI=;
        b=PnQ4Pqj9i/DJ/ftw17OxpodPor1CQKT/VghRxQF/ctE3izIuCEVIdJV1pbjawgy+Nz
         0hQ3HvmD2Oqq4AGGfSX0S1D869xFnIagkWWo5qQ388YKzKqNfmRCxgyA7UW+eUr5xfow
         jD2PSf2i4R2VpDF5hl+9ENQmZ153oOznj9TBjx14HVURWeKlw8eeG/5BIvWedMajylE0
         E1L1P5OgfHh/cGbNzJTCeOSSfOyHyXqSfBPJi0DTrBnmNjRUrETFsCWngZJ8VMpYN8jQ
         mnZmB/mzuumWke77L3OeZE3FZjTn+XQVzeBSMdgYCFqKfmxVBg5C4UOQzTYcZ6/kZLCz
         2LdQ==
X-Gm-Message-State: AOAM5313vTn1l78665WdeZF5Y2YupWBqaBPytZ4aqvH6rIGoWUDOqJkI
        DqPQEPmiRgpY67miRIHNa+FpbA==
X-Google-Smtp-Source: ABdhPJxCddjwyZ/cieUSoYmXsNWRjbeIQnp5P/tjSr/RKCa3xx43k+5umY+pgkmw0EF1j2qWMMBhtw==
X-Received: by 2002:a63:4822:0:b0:3fa:8a91:267e with SMTP id v34-20020a634822000000b003fa8a91267emr4892371pga.240.1654187138793;
        Thu, 02 Jun 2022 09:25:38 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b0015e8d4eb237sm3731554plh.129.2022.06.02.09.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 09:25:38 -0700 (PDT)
Message-ID: <21780d7b-2fe0-e6b8-6b4c-7053ec7b99ef@linaro.org>
Date:   Thu, 2 Jun 2022 09:25:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] bpf: Fix KASAN use-after-free Read in
 compute_effective_progs
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        syzbot+f264bffdfbd5614f3bb2@syzkaller.appspotmail.com
References: <CAEf4BzY-p13huoqo6N7LJRVVj8rcjPeP3Cp=KDX4N2x9BkC9Zw@mail.gmail.com>
 <20220517180420.87954-1-tadeusz.struk@linaro.org>
 <7949d722-86e8-8122-e607-4b09944b76ae@linaro.org>
 <CAEf4BzaD1Z6uOZwbquPYWB0_Z0+CkEKiXQ6zS2imiSHpTgX3pg@mail.gmail.com>
 <41265f4d-45b4-a3a6-e0c0-5460d2a06377@linaro.org>
 <CAEf4Bza-fp-9j+dzwdJQagxVNseNofxY2aJV0E6eHw+eQyyeaQ@mail.gmail.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <CAEf4Bza-fp-9j+dzwdJQagxVNseNofxY2aJV0E6eHw+eQyyeaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/22 09:11, Andrii Nakryiko wrote:
>> Did you get a chance to look at this yet?
>>
> Hm.. I've applied it two days ago, but for some reason there was no
> notification from the bot. It's now c89c79fda9b6 ("bpf: Fix KASAN
> use-after-free Read in compute_effective_progs").

Great! Thank you.

-- 
Thanks,
Tadeusz
