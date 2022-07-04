Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905D15658F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiGDOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiGDOvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD66BFF7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656946289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFvVKJ1fGrkThPrJCts+OirM91DHRLcTY7JYj4rk62U=;
        b=NQm5TmGP+3ADPRQ9sx4ypfKRVfl8ORsMPcL8gk2c6AasNKB/RiiPVyIotSWxV/BUoVFI+3
        thKVxjXutUY8wv2BcIEiclnqlcQ5CQzKplYAyqFKURfupLW5IdtV3d1bGEspBt/TxXEiC2
        LgLMx381xEKS1E0OyFzzuQjN0ES4Bo0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-5hNRvtoWNUyrMfBD9Mm0nw-1; Mon, 04 Jul 2022 10:51:28 -0400
X-MC-Unique: 5hNRvtoWNUyrMfBD9Mm0nw-1
Received: by mail-qt1-f197.google.com with SMTP id ck12-20020a05622a230c00b00304ee787b02so5931281qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zFvVKJ1fGrkThPrJCts+OirM91DHRLcTY7JYj4rk62U=;
        b=0XdONtMpcvZF0OjtMTDoyPgKNqXh0hWBUU9vh09mpVvWyTUN+bGuptdTMAYwphE3J0
         fCeNN7pPbHib2KReaKUGK5U8xN3C77gXAKGwK/aAflz2JPMBf4ZAi5N4KGSiKS0L+ohH
         mY9q8+mMOOTdjfTt4dKxPbBsQ6/jMbQU2cOXIM6sfw8bQ75Th4MfzFzOw5j/ytgn2Glp
         hP15WZccPed7u99XZIRjKc6rvnjVsQQXo0dfYeNQbBRqhU2MwHWfZKMDHMLd7R1GY2jZ
         qMSlT9pzkdrgJ//FjRC+v+Fp1u1GV87UaZVMq7xfpNVFRTK5YAlerGevg1Y8TNjIl+BW
         BbPQ==
X-Gm-Message-State: AJIora9eFRGaNqiZ8vM6NCa09Wowde/4yftyeUqsqdNJXTnjxs+BgPMf
        NhiBd24N/7OLKpfBtovmIE6zwBBNb/QVygz8wTo9g/t+aoM2yEHW2QgYrMASuA7eILjWjLRzUOi
        yotWBJyrY9AohIKZ9K/ZAAEJrSd7fOepMbww4VmjOwBtEr0R3qvBmjL1hLJFpt9QGmKxUAic=
X-Received: by 2002:a05:622a:391:b0:31d:2a07:4f41 with SMTP id j17-20020a05622a039100b0031d2a074f41mr21046662qtx.294.1656946288164;
        Mon, 04 Jul 2022 07:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOvptI4Bharw1kjiR6aB6/HEu3IoshyNYmsXxZb0mtL2gdO0jVvSB0WNMIX3QGj42rlK2jFA==
X-Received: by 2002:a05:622a:391:b0:31d:2a07:4f41 with SMTP id j17-20020a05622a039100b0031d2a074f41mr21046638qtx.294.1656946287912;
        Mon, 04 Jul 2022 07:51:27 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g84-20020a379d57000000b0069c72b41b59sm24603917qke.2.2022.07.04.07.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 07:51:27 -0700 (PDT)
Subject: Re: [PATCH] secretmem: drop unneeded initialization in
 secretmem_file_create()
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220704092605.19604-1-lukas.bulwahn@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3aff433c-f503-791d-77df-21a962185c54@redhat.com>
Date:   Mon, 4 Jul 2022 07:51:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220704092605.19604-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/22 2:26 AM, Lukas Bulwahn wrote:
> Drop the unneeded initialization of the local variable file in function
> secretmem_file_create().
>
> No functional change and no change in the resulting object code.
>
> This unneeded initialization was already introduced with the introduction
> of secretmem in commit 1507f51255c9 ("mm: introduce memfd_secret system
> call to create "secret" memory areas").

You may need to be more specific about this commit, the whole function, 
including this initialization was introduced at this time.

Otherwise, change looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

>   This minor code-stylistic issue
> was discovered as a dead store with clang-analyzer.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Mike, please ack.
>
> Andrew, please pick this minor stylistic clean-up patch. Thanks.
>
>   mm/secretmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 7584aab54d20..46b431d62761 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -171,7 +171,7 @@ static struct vfsmount *secretmem_mnt;
>   
>   static struct file *secretmem_file_create(unsigned long flags)
>   {
> -	struct file *file = ERR_PTR(-ENOMEM);
> +	struct file *file;
>   	struct inode *inode;
>   	const char *anon_name = "[secretmem]";
>   	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));

