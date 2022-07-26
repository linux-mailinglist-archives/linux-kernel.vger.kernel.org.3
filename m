Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDF3581468
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiGZNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiGZNpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E7261CFE7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658843154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0RbgNeCMWGTLl5NaMw002w/avfS4HhxBQ3/PBLMnCQ=;
        b=GhS2dtlG1FtdNJ8K8BU2hlzHCxxcdiQN3Eov1nzkCZgN8JeskT6rV9A/SlqWogMiutdqPv
        7WTViMDVjpYX8UIlEwFi3IN1dzGj5bIfrY5H4WPQsSfFZUKYyl2Et3YPZURmWmDP8qj3yN
        G/TPFkIuNIZEnUmUiCkWYK4Bj3xM858=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-FMmQk8DeNGGTQp5_HkcRlg-1; Tue, 26 Jul 2022 09:45:53 -0400
X-MC-Unique: FMmQk8DeNGGTQp5_HkcRlg-1
Received: by mail-wr1-f69.google.com with SMTP id q17-20020adfab11000000b0021e4c9ca970so2147254wrc.20
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=U0RbgNeCMWGTLl5NaMw002w/avfS4HhxBQ3/PBLMnCQ=;
        b=PDUUDQOtBFbZRFHWhT1YLNpan5SCSjyPaRez8hQOR/TOA1206A9TVhbyHoD04o7qoy
         ud8Zh9mw132KTHDrh8OCTXOn6CIk4IPCh5ppNTqlw0kpXIvI8uO+heq1LOe1yQMVo6Xw
         0U93HoNy71+waDOEfLCWTV/lPuPGXg3/RNOiGty9NcanUuEl9RgcWXz0T/MQuATz29O2
         xyJ9+8qqVFB8aAH1uE9XBiOrSpks4eMjvcnR2qNmJSb/oyvZ4rfKg5ZfKF7AQaNDfq1d
         8uoTdhOGpxJw/KuVe4SIWdMaIXNfHMkaHHA2BjMCZA3HO9PxYBS1PZIoP93xB7mYfzMi
         S0zg==
X-Gm-Message-State: AJIora9qqHoDFrPigsDBwkC+ZU6i8tpRmhEST5X8rrcTOnLMt4dwxs/s
        dCSZvmhK8BbOL1jvHRW3xpbqGxKdfITEKXg3cezrPnA/Jk3HDJ6MSm9PjD6t55hi5bHS8M7KCyt
        60g3wcpd0IEj8T1ELgfB2EVuA
X-Received: by 2002:a05:600c:6002:b0:3a3:5453:bcbe with SMTP id az2-20020a05600c600200b003a35453bcbemr9010627wmb.190.1658843151694;
        Tue, 26 Jul 2022 06:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uEdYS/8GD2rKXrwKi1xsxaGrPurKtjlF+VbooQh/DnQoNo/7sFgoDFG+enrLLNF4k9hzJrTg==
X-Received: by 2002:a05:600c:6002:b0:3a3:5453:bcbe with SMTP id az2-20020a05600c600200b003a35453bcbemr9010611wmb.190.1658843151474;
        Tue, 26 Jul 2022 06:45:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:fe00:8ba4:5871:abc3:8a75? (p200300cbc708fe008ba45871abc38a75.dip0.t-ipconnect.de. [2003:cb:c708:fe00:8ba4:5871:abc3:8a75])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b003a2fc754313sm19918457wms.10.2022.07.26.06.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:45:51 -0700 (PDT)
Message-ID: <18dc0807-5596-3aad-350d-3673a033bca8@redhat.com>
Date:   Tue, 26 Jul 2022 15:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: add warning if __vm_enough_memory fails
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Yongqiang Liu <liuyongqiang13@huawei.com>
References: <20220726072451.142427-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220726072451.142427-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.22 09:24, Kefeng Wang wrote:
> If a process has no enough memory to allocate a new virtual mapping, we
> may meet kinds of error, eg, fork cannot allocate memory, SIGBUS error
> in shmem, but it is difficult to confirm them, let's add some debug
> information to easy to check this scenario if __vm_enough_memory fails.
> 
> Reported-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/util.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 1266a33a49ea..19bfff8a0ad6 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1020,6 +1020,8 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
>  		return 0;
>  error:
> +	pr_warn("%s: pid: %d, comm: %s, no enough memory for the allocation\n",
> +		__func__, current->pid, current->comm);
>  	vm_unacct_memory(pages);
>  
>  	return -ENOMEM;

Users can easily spam the kernel log, no? Maybe at least ratelimit.

-- 
Thanks,

David / dhildenb

