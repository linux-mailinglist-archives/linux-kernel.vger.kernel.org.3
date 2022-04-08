Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08B44F9CBC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiDHSdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbiDHSca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:32:30 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC6D399B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:30:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e22so11604605ioe.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8c4w2SqV3Zwtk6hjN9XQDs1ojn8rP0mcUHvQvhzuNaU=;
        b=YpRUx5naQgJOrPJtNsmh78aDsmIIkswFS8lXDrNYheqXIeJEK2ARoLdZkPcn+nfw5T
         oYiFN+5ZvBke8G2w+I4t1ThEG9QAMUoMMfn3SprosOFXtLJQ9uLglI+1t3LYKARK0RE9
         fZFK0+HB8gFFQwUCeNj0/qHoPWD0MoYjgz6Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8c4w2SqV3Zwtk6hjN9XQDs1ojn8rP0mcUHvQvhzuNaU=;
        b=H+qvz/XD0FMvUFJDxqwackn0dlrJfj87zAtrFv+8wOzqBoOchjOdYIIyt9gVr6SUGv
         yBWzzgQjE1Gd0QWKodyX/YrLkdyObaaNgWb9nYD3J2LmRf7fS/nweyPqF5Tj92UOttAL
         kLtfpt5cWpMofMikqQz11aTyRbNyWVuZwLWUzeencsnpy+0Ar7cr99oWWqeTAQzUdR6i
         SL4Vy48ThCSZzlXROxxdbeJ3XMNbVUjAEkA+3m3MWQmdJUWlCNTllYh0tdRrackivuj2
         H7ydGv0lXEa1zmeFV/GGYUcMXkEZP8m+zQFMW/rOzaBrLV2NO3/TOGOFAcfOv7B01gAn
         aqAw==
X-Gm-Message-State: AOAM531vzfmhc0DlmXiU8Jqr1KN/Hq6sCfHprPAlnsf9S1npbc5hixCD
        RmXa3v9FwMl3wXG1+oA6yXyEMg==
X-Google-Smtp-Source: ABdhPJz0knJI2EvKgFMOby7OjCoRi/HEQHXa7piPfbIdw92oEo/ocHWDiLbO7mI1s1H7DgX30ZuY4g==
X-Received: by 2002:a05:6638:2643:b0:323:c3e3:fcec with SMTP id n3-20020a056638264300b00323c3e3fcecmr10003722jat.289.1649442625269;
        Fri, 08 Apr 2022 11:30:25 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y6-20020a056e02174600b002c7f247b3a7sm14985188ill.54.2022.04.08.11.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 11:30:24 -0700 (PDT)
Subject: Re: [PATCH V3] testing/selftests/mqueue: Fix mq_perf_tests to free
 the allocated cpu set
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, disgoel@linux.vnet.ibm.com
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        kjain@linux.ibm.com, srikar@linux.vnet.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220408072431.94947-1-atrajeev@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1a1d119a-e68e-a590-a518-cfb3c78ed888@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 12:30:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220408072431.94947-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 1:24 AM, Athira Rajeev wrote:
> The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
> CPU set. This cpu set is used further in pthread_attr_setaffinity_np
> and by pthread_create in the code. But in current code, allocated
> cpu set is not freed.
> 
> Fix this issue by adding CPU_FREE in the "shutdown" function which
> is called in most of the error/exit path for the cleanup. There are
> few error paths which exit without using shutdown. Add a common goto
> error path with CPU_FREE for these cases.
> 
> Fixes: 7820b0715b6f ("tools/selftests: add mq_perf_tests")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
>   From v2 -> v3:
>    Addressed review comment from Shuah Khan to add
>    common "goto" error path with CPU_FREE for few exit
>    cases.
>   From v1 -> v2:
>    Addressed review comment from Shuah Khan to add
>    CPU_FREE in other exit paths where it is needed
> 

Thank you. I will queue this up for Linux 5.18-rc3

thanks,
-- Shuah
