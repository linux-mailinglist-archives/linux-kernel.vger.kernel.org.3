Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B776A4D85C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbiCNNN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241516AbiCNNNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10CDA1D0DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647263534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfrmpYIpBAIQM1+Gt9Phq5AOoHKq7aRJ010EA06rYLU=;
        b=YkK2u4ua2ItTwZ+Oxu1jmK+LGAUZycZDqrVHiY+i5bUSUZPJA1VdeJGGOM6avXoUPkrbrT
        I2PfV1iwINea1rGqB8bNnDQJjHROQpZbNRI5Qh0jvv8vcDSc1ttY0gbL9eRPPbmLrovXCE
        Xu4tT24OOLk7EnKfpXDhBWtAzANjh9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-43vqek-rNWihQVMCtyTaPw-1; Mon, 14 Mar 2022 09:12:12 -0400
X-MC-Unique: 43vqek-rNWihQVMCtyTaPw-1
Received: by mail-wr1-f71.google.com with SMTP id m18-20020a5d4a12000000b00203731460e6so4348451wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BfrmpYIpBAIQM1+Gt9Phq5AOoHKq7aRJ010EA06rYLU=;
        b=IOesXGLl55Nl+7sLnmFgjJSfLDiYSb2NZUbZYWGstjLAjr9xjzISorVVvXx9BpjMXe
         XXa37lMSAY7w5TJ7NhxxvHzadjZcJlXeKC2ipsbjcQFHjGDf4eZrnT3IgYXqdYC/J0ni
         Lt7l5HzFwnN+ug0gP2EVmuBFo6nJfynxKTnBVEbbi9iGzGxKdLYkXV77n5K+mdl48f9E
         e2439Tq0lbOvb63/eirt1Oaep/ALjfbwFL0AYS1HFkzQcj14WmiG5l6eaCYvD2knZ/MO
         rdw7m4N0l1FyfGvZlRngmfBnidQ2IKdlaSIV6gQ1+5r/15EucpbZAiYDby1pUtGF65DJ
         Lasw==
X-Gm-Message-State: AOAM53396JgG5wzNP28cHh8gEzkCK5OGpfljH0R1/Yp9twdZZRT6TffL
        4ht8urDWfQYJUldot9JH1sKKkWqm43j2/C2UXBe+FsXkFyp94JaP02hYpI8vuTXCOV3CfpEk/q5
        nBBt6m06jYuU2PbR+s3aw3Myo
X-Received: by 2002:a5d:4992:0:b0:1f0:68bd:4c34 with SMTP id r18-20020a5d4992000000b001f068bd4c34mr17064596wrq.670.1647263531485;
        Mon, 14 Mar 2022 06:12:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3mZ0+w8htNAo5t0qhYrTrRDOxGC7G6tNWZztZlmqcfmQXvFb0I4unRmYEI5Q5T6ypHhtxMQ==
X-Received: by 2002:a5d:4992:0:b0:1f0:68bd:4c34 with SMTP id r18-20020a5d4992000000b001f068bd4c34mr17064584wrq.670.1647263531261;
        Mon, 14 Mar 2022 06:12:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:9a00:b2c1:8682:b807:e870? (p200300cbc7049a00b2c18682b807e870.dip0.t-ipconnect.de. [2003:cb:c704:9a00:b2c1:8682:b807:e870])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b001f0256761b9sm20912217wrt.45.2022.03.14.06.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 06:12:10 -0700 (PDT)
Message-ID: <9cb7c909-eded-4933-c7a5-a7aa5a5221da@redhat.com>
Date:   Mon, 14 Mar 2022 14:12:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/mremap:: Use vma_lookup() instead of find_vma()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220312083118.48284-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220312083118.48284-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.22 09:31, Miaohe Lin wrote:
> Using vma_lookup() verifies the address is contained in the found vma.
> This results in easier to read the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/mremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 002eec83e91e..9d76da79594d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -942,8 +942,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  
>  	if (mmap_write_lock_killable(current->mm))
>  		return -EINTR;
> -	vma = find_vma(mm, addr);
> -	if (!vma || vma->vm_start > addr) {
> +	vma = vma_lookup(mm, addr);
> +	if (!vma) {
>  		ret = EFAULT;
>  		goto out;
>  	}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

