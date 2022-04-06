Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901F24F6C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiDFVSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiDFVRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:17:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE23C2EF86D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:05:47 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b16so4361786ioz.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vCgsdofueDzmclBeFxqo6aKHtjsWdXLi6JiPYoFCmoc=;
        b=cR+5rsgYLkhZXAAFxLpza6qfB2xOzcJNUAIYelWplokZAKThWScNamgWLpMmkHBhgA
         R1+F1qKd7EG/GEu8cxmj1P80ibmXO1V5w96lKod+E60ujDAa/xCZ0xLxp4Nsp/y1+zNj
         pGI4QVenIIYqNlvjtSBl1t5pMtIx0NmwB3jyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCgsdofueDzmclBeFxqo6aKHtjsWdXLi6JiPYoFCmoc=;
        b=2zvrJkrYtOfx/7pdO4WXvzI5bMtXc0ZgOgiYjAuBTWjltARXquDmKUfiA7P+wfKBCM
         mtgKVP7Yqzmvlk3t4pYUnK0VqRCntkYXJ71MVSerahHCmRAoM9tDGE2O2/GOh5BAdNnP
         P57rv/yoS9gf2yrumnUwvvw+Jd0FRlHrAvq6YAbxIZ1yhRSorOxnKAQ71bZES5L03Lp7
         6iL/LT+D1uNB/S4NbG1rAlFu0GsGjSd6yWooJLsUGQ+i451S3wDX87a+D1tOMHPsP+mw
         gQujX0a3SJOOxObylTGM5XfjmVZ3pNhZ4u3J505DI6A3JzN38y565UuMOxRjQ+iXGJ2M
         FBsQ==
X-Gm-Message-State: AOAM530IYnG2mrPKvqi152jXVEAQRNZN3Rr+bLmLpiE0+1nkQZqiR8p9
        6Hsw7h8A67j/DvlEqoaAI1LPfw==
X-Google-Smtp-Source: ABdhPJwZyiBF+1MJR1ViEYkDA/OLIZOqcFI6CqmqutLKLEchEzixjki5nX6+7D+OjxHw9lBwnsyheA==
X-Received: by 2002:a05:6638:41a0:b0:323:d771:8146 with SMTP id az32-20020a05663841a000b00323d7718146mr5494354jab.193.1649275547223;
        Wed, 06 Apr 2022 13:05:47 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602184e00b00649673c175asm11534641ioi.25.2022.04.06.13.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 13:05:46 -0700 (PDT)
Subject: Re: [PATCH] testing/selftests/mqueue: Fix mq_perf_tests to free the
 allocated cpu set
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, disgoel@linux.vnet.ibm.com
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        kjain@linux.ibm.com, srikar@linux.vnet.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220406175715.87937-1-atrajeev@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ad0648a9-0252-2d1f-cc48-7e14846fc0af@linuxfoundation.org>
Date:   Wed, 6 Apr 2022 14:05:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220406175715.87937-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 11:57 AM, Athira Rajeev wrote:
> The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
> CPU set. This cpu set is used further in pthread_attr_setaffinity_np
> and by pthread_create in the code. But in current code, allocated
> cpu set is not freed. Fix this by adding CPU_FREE after its usage
> is done.
> 

Good find.

> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>   tools/testing/selftests/mqueue/mq_perf_tests.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
> index b019e0b8221c..17c41f216bef 100644
> --- a/tools/testing/selftests/mqueue/mq_perf_tests.c
> +++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
> @@ -732,6 +732,7 @@ int main(int argc, char *argv[])
>   		pthread_attr_destroy(&thread_attr);
>   	}
>   
> +	CPU_FREE(cpu_set);
>   	if (!continuous_mode) {
>   		pthread_join(cpu_threads[0], &retval);
>   		shutdown((long)retval, "perf_test_thread()", __LINE__);
> 

CPU_ALLOC() is called very early on in main() and there are a
few error paths that exit without calling CPU_FREE. This change
doesn't fully fix the problem.

Review the other exit paths where CPU_FREE is needed.

thanks,
-- Shuah
