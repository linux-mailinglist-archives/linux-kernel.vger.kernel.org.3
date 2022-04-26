Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0751028F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352818AbiDZQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352810AbiDZQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:09:47 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29347041
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:06:38 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 125so20553689iov.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=48HTw/rBGTX9w0BVqolReo8yB9AAi0BaZFQxJTNNLy4=;
        b=ZD1m7Y4nVS7PfQ4Kjhtcx2pWQRTgJwYNx2+YXbk1O2CUO2UxP5EWmPra4LFir6/Taw
         RpW0It155qOW40r+x6bxxHSyaWqdAxyZPQbArFGFnVhID+wD8iVD1c4L/8kFEbTKgLUz
         EJZN4+mqFAvk4fkU1MkgFX4lHN0a0xfTh0KQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48HTw/rBGTX9w0BVqolReo8yB9AAi0BaZFQxJTNNLy4=;
        b=PwfGAWbg9t6N4F2lnfyeHyAJRbBEteL3b81/dM3b4kTg5gfVumeDTmijOu6Q6I8O0J
         XB2+pmQSNUso3gxctDOMfbLhAlv/oJHjGBkOtazOZrtNeUTN5CYiRgDu0c/3FVOkN2xQ
         HVECv0JnwOx6Bq0+vBmftTyNSdXFlqkV7ZEfFRcGaLmv1iU0qKuDVkfISpAtoj5LP8Mm
         Xs+wEclQr2zETL/eCEHHqYTEdYm0I62YRSuOhsDOKWt8uv96GPWlB5d5dn9I/OgG0ouc
         5oAL6bN3p/hrP39ZJ+E0ldjxyoaxIfvAyLE25omlKSUKe20gwG8hkpqw492Clo5vP8wB
         lCeA==
X-Gm-Message-State: AOAM5312lDNuRFMQ/p6p612uK0A/otaqg6o/+8g94+iNtk3NtO70tkyo
        ldwz99T+0N09O4unjU3Y+E01VQ==
X-Google-Smtp-Source: ABdhPJxlhTF/uJw3gqLA3Hj0XRaHwykEJis0oX2P2Zrd5M2rhYKz2s635umapHwjfAZEV7w+j3mLVw==
X-Received: by 2002:a05:6638:1652:b0:328:5357:7acb with SMTP id a18-20020a056638165200b0032853577acbmr11320817jat.71.1650989197839;
        Tue, 26 Apr 2022 09:06:37 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id s21-20020a6bd315000000b006573987c4fcsm9786770iob.3.2022.04.26.09.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 09:06:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] selftests: vm: add hugetlb_shared userfaultfd test
 to run_vmtests.sh
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
 <20220422212945.2227722-2-axelrasmussen@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <037ea7ee-5248-86a5-55a2-f1726567af81@linuxfoundation.org>
Date:   Tue, 26 Apr 2022 10:06:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220422212945.2227722-2-axelrasmussen@google.com>
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
> This not being included was just a simple oversight. There are certain
> features (like minor fault support) which are only enabled on shared
> mappings, so without including hugetlb_shared we actually lose a
> significant amount of test coverage.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   tools/testing/selftests/vm/run_vmtests.sh | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index a2302b5faaf2..5065dbd89bdb 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -121,9 +121,11 @@ run_test ./gup_test -a
>   run_test ./gup_test -ct -F 0x1 0 19 0x1000
>   
>   run_test ./userfaultfd anon 20 16
> -# Test requires source and destination huge pages.  Size of source
> -# (half_ufd_size_MB) is passed as argument to test.
> +# Hugetlb tests require source and destination huge pages. Pass in half the
> +# size ($half_ufd_size_MB), which is used for *each*.
>   run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
> +run_test ./userfaultfd hugetlb_shared "$half_ufd_size_MB" 32 "$mnt"/uffd-test
> +rm -f "$mnt"/uffd-test
>   run_test ./userfaultfd shmem 20 16
>   
>   #cleanup
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
