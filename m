Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B64D3C36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiCIVkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiCIVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:40:30 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99D76677
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:39:30 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h7so2472618ile.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 13:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zOnqPnT6Pa2ZicR2EFcXEDxd/ntBqJXzc8CY9w8hS4s=;
        b=SwKsVqpxG6sd3JP9ZBuyzq1EvlLs2+s94s1mQ7gbDmpqo5mrxWlJJWzHpnSwa/ULRH
         CIwgbl4Nxw3U+4FG/NMEGvb+B9XD09Z8qiF2cnuPwUtmiywsc8th2+Gn0lUvaXqWB1Dp
         cCipwEhr9ODyyNGJA6CdE4d+yc0Y3NhT6m+Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zOnqPnT6Pa2ZicR2EFcXEDxd/ntBqJXzc8CY9w8hS4s=;
        b=heP7WAYqkkfREic4pDT5nx+I28Tr29NY+tMjsv1aQ8o/iX9MUg7rn85zukBLaEdd8N
         5osv02GaJGnzD2D2d2e6fRnkrB6HxCqFfOn9tjCoAu7Pj7h6OwJb0exKVrEoXf/F+o9c
         1qRWCk0SwzFkhs0W+VypDmELMl8/AU8mIKf71zC9aFXkkJ+k8dLTvMiHCZvP1KH5YtJl
         ul7sM+A335k1g0yIeqtjLP9OAZqVRvIRgP+KxCy34NZT8L09l0fmJQS5VO+ZndGjIsa2
         K1trDKShup4N8YHLtsBOn3jmzQZPFCb7jM2DHMdNLFJrT7bsCuc3d4QKPSzpZh8HOS07
         arIA==
X-Gm-Message-State: AOAM532+a/eHoQHeTyJSwA5qSmP5ozvHEWtB7BYzlwUSfAZCkYyvU25B
        m467/XpRIAPkZG0U4i2nx71fkNzehVvJ9Q==
X-Google-Smtp-Source: ABdhPJy61oVAoTBdNapdnWk8a09TumWKakoLj4S/3jgje9lwQAIa32+X0V3f7AbApGGP501Oabaa9g==
X-Received: by 2002:a05:6e02:1a4a:b0:2c6:6a0d:b8f0 with SMTP id u10-20020a056e021a4a00b002c66a0db8f0mr1189404ilv.85.1646861969934;
        Wed, 09 Mar 2022 13:39:29 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c6-20020a056e020bc600b002c6731e7cb8sm1158182ilu.31.2022.03.09.13.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 13:39:29 -0800 (PST)
Subject: Re: [PATCH 3/3] kfence: test: try to avoid test_gfpzero trigger
 rcu_stall
To:     Peng Liu <liupeng256@huawei.com>, brendanhiggins@google.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc:     wangkefeng.wang@huawei.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220309014705.1265861-1-liupeng256@huawei.com>
 <20220309014705.1265861-4-liupeng256@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1dfeea09-cd4a-39fc-18f4-775bec99afa4@linuxfoundation.org>
Date:   Wed, 9 Mar 2022 14:39:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220309014705.1265861-4-liupeng256@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 6:47 PM, Peng Liu wrote:
> When CONFIG_KFENCE_DYNAMIC_OBJECTS is set to a big number, kfence
> kunit-test-case test_gfpzero will eat up nearly all the CPU's
> resources and rcu_stall is reported as the following log which is
> cut from a physical server.
> 
>    rcu: INFO: rcu_sched self-detected stall on CPU
>    rcu: 	68-....: (14422 ticks this GP) idle=6ce/1/0x4000000000000002
>    softirq=592/592 fqs=7500 (t=15004 jiffies g=10677 q=20019)
>    Task dump for CPU 68:
>    task:kunit_try_catch state:R  running task
>    stack:    0 pid: 9728 ppid:     2 flags:0x0000020a
>    Call trace:
>     dump_backtrace+0x0/0x1e4
>     show_stack+0x20/0x2c
>     sched_show_task+0x148/0x170
>     ...
>     rcu_sched_clock_irq+0x70/0x180
>     update_process_times+0x68/0xb0
>     tick_sched_handle+0x38/0x74
>     ...
>     gic_handle_irq+0x78/0x2c0
>     el1_irq+0xb8/0x140
>     kfree+0xd8/0x53c
>     test_alloc+0x264/0x310 [kfence_test]
>     test_gfpzero+0xf4/0x840 [kfence_test]
>     kunit_try_run_case+0x48/0x20c
>     kunit_generic_run_threadfn_adapter+0x28/0x34
>     kthread+0x108/0x13c
>     ret_from_fork+0x10/0x18
> 
> To avoid rcu_stall and unacceptable latency, a schedule point is
> added to test_gfpzero.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>   mm/kfence/kfence_test.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index caed6b4eba94..1b50f70a4c0f 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -627,6 +627,7 @@ static void test_gfpzero(struct kunit *test)
>   			kunit_warn(test, "giving up ... cannot get same object back\n");
>   			return;
>   		}
> +		cond_resched();

This sounds like a band-aid - is there a better way to fix this?

>   	}
>   
>   	for (i = 0; i < size; i++)
> 

thanks,
-- Shuah
