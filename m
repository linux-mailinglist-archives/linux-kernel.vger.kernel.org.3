Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0FE510305
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352880AbiDZQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348049AbiDZQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:19:30 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86311D0F4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:16:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n134so20601332iod.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HXWdjkfFgqjuuDDxvdwI+4bKI50cYTCo99OhpT4yUUA=;
        b=asJnWv/5XRA4F4Rt4VsDIaqHUngaJ2jxIJmd6hFDl+QhdPM+ZE2j+UaZ4xSwq8xqdS
         PBI3/IGHu50VNKpA+cm2y+UyoIyVSrw+ygqofnIyiUhrrC1OOFIjJf3/k77+14GKNefy
         Ba34H4zkKpDXtSa0ViWgDX0M9ljaWZ4NFhi38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HXWdjkfFgqjuuDDxvdwI+4bKI50cYTCo99OhpT4yUUA=;
        b=T19jx3EazETov4mTcYJjas3NDHIRGJ/Yrn4L2fl95aUb12KlcHJGOXirIH5oldFCXA
         rBkhaPR1oe0bYgS29b15kot1crCYsAJH1PsLCB0xSSy1DFyNYiLfgtisFaPPbbnyOsAV
         SptWKJ4igtgEEYBFym7RpJwetokPiY/f9ypIlIkggaJE74Nvmbd0O4AJQW2y6aOfXwOI
         A54k5R3zHCc8wYUu5uwoPMILGe9Beb36SO6/vtsRwo7WCjwPfVEcNTCemJbIllte32WJ
         /8sNCeap3x+LFkZsUnVQQerJ7gVg6WNZIcTyr3JBhFNiS4EffBWSS+x+sq9y3hh6dLvT
         J9JA==
X-Gm-Message-State: AOAM532O64cl6PUbAmtejd78Yi4R2qnefKVQxEUS914f9ME7X73KQSY2
        UU8MoLRHTRGFhpLHw4JP0xHnqw==
X-Google-Smtp-Source: ABdhPJyZ9Q6A3Qye4GAn3uZyc/gODe2JY9K+1Qqgz0ZLuqW7qoimkMFBBI5vTAdI8yWt1KFsJ5dbqg==
X-Received: by 2002:a6b:fb05:0:b0:657:655e:a287 with SMTP id h5-20020a6bfb05000000b00657655ea287mr7364988iog.211.1650989781126;
        Tue, 26 Apr 2022 09:16:21 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id r9-20020a6b6009000000b006412abddbbbsm9458932iog.24.2022.04.26.09.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 09:16:20 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] userfaultfd: selftests: modify selftest to use
 /dev/userfaultfd
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-4-axelrasmussen@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a6f7ff80-ea77-75d0-2454-99d14f164708@linuxfoundation.org>
Date:   Tue, 26 Apr 2022 10:16:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220422212945.2227722-4-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 3:29 PM, Axel Rasmussen wrote:
> We clearly want to ensure both userfaultfd(2) and /dev/userfaultfd keep
> working into the future, so just run the test twice, using each
> interface.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   tools/testing/selftests/vm/userfaultfd.c | 31 ++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 92a4516f8f0d..12ae742a9981 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -77,6 +77,9 @@ static int bounces;
>   #define TEST_SHMEM	3
>   static int test_type;
>   
> +/* test using /dev/userfaultfd, instead of userfaultfd(2) */
> +static bool test_dev_userfaultfd;
> +
>   /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
>   #define ALARM_INTERVAL_SECS 10
>   static volatile bool test_uffdio_copy_eexist = true;
> @@ -383,13 +386,31 @@ static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
>   	}
>   }
>   
> +static void __userfaultfd_open_dev(void)
> +{
> +	int fd;
> +
> +	uffd = -1;
> +	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> +	if (fd < 0)
> +		return;
> +
> +	uffd = ioctl(fd, USERFAULTFD_IOC_NEW,
> +		     O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> +	close(fd);
> +}
> +
>   static void userfaultfd_open(uint64_t *features)
>   {
>   	struct uffdio_api uffdio_api;
>   
> -	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> +	if (test_dev_userfaultfd)
> +		__userfaultfd_open_dev();
> +	else
> +		uffd = syscall(__NR_userfaultfd,
> +			       O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
>   	if (uffd < 0)
> -		err("userfaultfd syscall not available in this kernel");
> +		err("creating userfaultfd failed");

This isn't an error as in test failure. This will be a skip because of
unmet dependencies. Also if this test requires root access, please check
for that and make that a skip as well.

>   	uffd_flags = fcntl(uffd, F_GETFD, NULL);
>   
>   	uffdio_api.api = UFFD_API;
> @@ -1698,6 +1719,12 @@ int main(int argc, char **argv)
>   	}
>   	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
>   	       nr_pages, nr_pages_per_cpu);
> +
> +	test_dev_userfaultfd = false;
> +	if (userfaultfd_stress())
> +		return 1;
> +
> +	test_dev_userfaultfd = true;
>   	return userfaultfd_stress();
>   }
>   
> 

thanks,
-- Shuah
