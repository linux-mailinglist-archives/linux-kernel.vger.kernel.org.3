Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA94A6189
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbiBAQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbiBAQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:45:59 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E95C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:45:59 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z199so21938358iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 08:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y6LUyFcnFmJZfl6pUaqznZq25qjWW5IaFFfetEnm8pE=;
        b=OjANnamDd2aLy28kxdbVFCYfF+KDlBQv2VxjReEVGzrTFODEIREmBLTVW+b6Qf7oSw
         T9wtJi5mozJG0bnXrwHX0E3s97iAa4Z0Exhoh2nyZPfP6jxaRKsZQcBBus5RRrAk+Qwa
         Gpyz9UpUyvan+ufyeYSl6CuK04Rg0H3StZbpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y6LUyFcnFmJZfl6pUaqznZq25qjWW5IaFFfetEnm8pE=;
        b=E+JgDv2IT3be90NYa9TzgOvBaSdiEAt4NB+H91gqLYAn+7ImdDNwrVCaHq+yAr900r
         arpVS5WDWP8gIYSloqL7sblEXh9gc3k3ftsHlnuo0UC4/ukHLWcy3yE/l1FA4pELByck
         7eRiQRJe37YSDJFHAYBx/QymUd/Lrb3sy9CSAPx/wLkZ+AQTfq4RFIVwI1YacaDDvqUJ
         OZNzKcQNjCn9/Bh4SfiEpRBSp/HN6PBnhKhG0JyzTPLbn7K0/jviWEmVbcc2TC9RtoB0
         B8DIPekwZOgK6VZc0QwQA52+bgneL4d/Md23WxAoz+vhTtQlS/oVhYEWlVEGgizJW1H4
         7fiA==
X-Gm-Message-State: AOAM531p97zUfwXpgRu7CFx7/nij4GSwMzRq84yUca9Oog8wuOCQpgGG
        KhLwSEFOVhemcNZF/H8TdHczZA==
X-Google-Smtp-Source: ABdhPJygx01PVOP0KxGWme2ti0XbibVoM5Wf/kSbQtNwoU5OnjEpa3gPqn39prvUbQzoEDREyUa2fw==
X-Received: by 2002:a5e:8a45:: with SMTP id o5mr13965842iom.169.1643733958960;
        Tue, 01 Feb 2022 08:45:58 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id h3sm20058598ild.11.2022.02.01.08.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 08:45:58 -0800 (PST)
Subject: Re: [PATCH] selftests/vm: cleanup hugetlb file after mremap test
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mina Almasry <almasrymina@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220201033459.156944-1-mike.kravetz@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <33568901-8ef9-1461-0907-217634b3b989@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 09:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220201033459.156944-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 8:34 PM, Mike Kravetz wrote:
> The hugepage-mremap test will create a file in a hugetlb filesystem.
> In a default 'run_vmtests' run, the file will contain all the hugetlb
> pages.  After the test, the file remains and there are no free hugetlb
> pages for subsequent tests. This causes those hugetlb tests to fail.
> 
> Change hugepage-mremap to take the name of the hugetlb file as an
> argument.  Unlink the file within the test, and just to be sure remove
> the file in the run_vmtests script.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   tools/testing/selftests/vm/hugepage-mremap.c | 26 ++++++++++++++------
>   tools/testing/selftests/vm/run_vmtests.sh    |  3 ++-
>   2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
> index 2a7c33631a29..1d689084a54b 100644
> --- a/tools/testing/selftests/vm/hugepage-mremap.c
> +++ b/tools/testing/selftests/vm/hugepage-mremap.c
> @@ -3,9 +3,10 @@
>    * hugepage-mremap:
>    *
>    * Example of remapping huge page memory in a user application using the
> - * mremap system call.  Code assumes a hugetlbfs filesystem is mounted
> - * at './huge'.  The amount of memory used by this test is decided by a command
> - * line argument in MBs. If missing, the default amount is 10MB.
> + * mremap system call.  The path to a file in a hugetlbfs filesystem must
> + * be passed as the last argument to this test.  The amount of memory used
> + * by this test in MBs can optionally be passed as an argument.  If no memory
> + * amount is passed, the default amount is 10MB.
>    *
>    * To make sure the test triggers pmd sharing and goes through the 'unshare'
>    * path in the mremap code use 1GB (1024) or more.
> @@ -25,7 +26,6 @@
>   #define DEFAULT_LENGTH_MB 10UL
>   #define MB_TO_BYTES(x) (x * 1024 * 1024)
>   
> -#define FILE_NAME "huge/hugepagefile"
>   #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
>   #define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
>   
> @@ -107,17 +107,26 @@ static void register_region_with_uffd(char *addr, size_t len)
>   
>   int main(int argc, char *argv[])
>   {
> +	size_t length;
> +
> +	if (argc != 2 && argc != 3) {
> +		printf("Usage: %s [length_in_MB] <hugetlb_file>\n", argv[0]);
> +		exit(1);
> +	}
> +
>   	/* Read memory length as the first arg if valid, otherwise fallback to
> -	 * the default length. Any additional args are ignored.
> +	 * the default length.
>   	 */
> -	size_t length = argc > 1 ? (size_t)atoi(argv[1]) : 0UL;
> +	if (argc == 3)
> +		length = argc > 2 ? (size_t)atoi(argv[1]) : 0UL;
>   

Looks like getopt() might be useful - we have a few arguments now.
Makes it easier to maintain the test.

>   	length = length > 0 ? length : DEFAULT_LENGTH_MB;
>   	length = MB_TO_BYTES(length);
>   
>   	int ret = 0;
>   
> -	int fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
> +	/* last arg is the hugetlb file name */
> +	int fd = open(argv[argc-1], O_CREAT | O_RDWR, 0755);
>   
>   	if (fd < 0) {
>   		perror("Open failed");
> @@ -169,5 +178,8 @@ int main(int argc, char *argv[])
>   
>   	munmap(addr, length);
>   
> +	close(fd);
> +	unlink(argv[argc-1]);
> +
>   	return ret;
>   }
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index e09040a3dc08..e10d50e0b8e8 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -111,13 +111,14 @@ fi
>   echo "-----------------------"
>   echo "running hugepage-mremap"
>   echo "-----------------------"
> -./hugepage-mremap 256
> +./hugepage-mremap $mnt/huge_mremap
>   if [ $? -ne 0 ]; then
>   	echo "[FAIL]"
>   	exitcode=1
>   else
>   	echo "[PASS]"
>   fi
> +rm -f $mnt/huge_mremap
>   
>   echo "------------------------"
>   echo "running hugepage-vmemmap"
> 

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
