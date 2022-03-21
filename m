Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95884E27D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiCUNlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbiCUNlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D83710FE0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647869978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vB3vLBvRcKjKfgtWTOX9eVbtgZOrJ2AsHjIDSNYEF8=;
        b=VSGkoowcjzafZPDyNDsH9khvmzzeDJfhptqpgVtYu/fxa4qwUk8VCO+P4WdSHIAT9iG8pe
        //w6u8ZOILQrhAA8Ms19xS3d0nN6WINkkwhqcExeSTLZors5Mosl5vSZcIRR9IL36i3MsZ
        CCw/G9ofV0Lgqv7GxgkdIclS5uOS0T4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-V6YgXvScObKoo_nRZZEsHw-1; Mon, 21 Mar 2022 09:39:37 -0400
X-MC-Unique: V6YgXvScObKoo_nRZZEsHw-1
Received: by mail-qk1-f199.google.com with SMTP id f11-20020a05620a20cb00b0067b3fedce10so9777771qka.15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4vB3vLBvRcKjKfgtWTOX9eVbtgZOrJ2AsHjIDSNYEF8=;
        b=jl0ue/SbO2fYlNn64BRmzq3S558nrYNaXT2sn3g7wOaQKmb8sVhLAI5gH2FphGyvHu
         4WsewNa/Wi7oWMs+yUC9V7lietsA7Oem52zXcznypETjhH6iFRpqnvEBRa9ks6JrExZN
         2nLZc6P23sOlTg2EHKD6AfdqXYSHSzL1VcVw8igJUXINjkxxx68BI8TPWw0QHG8UPLkk
         MD1DSgkDOkHUEPF1xol3VnRfBlyJCQCL2GRsDTl9QVrpqc3eyK78jlv8c8Xq0ftNZ9kN
         /xtivA/Aq2YWLiDTiW83J5zEoXGGUsoNARGQFEvgOQcbPJWILyW5Qx484+cxYOIqkSnR
         UWxQ==
X-Gm-Message-State: AOAM530zgw5n7eJSWWG3yNkbIZpB0XFv3k6bbjB0DBYy9L4r/N92rYCB
        aUvNAZMdyN0MMLrRM/Do58rRXL1rQgaFLGxqMZpWrdu3k0N2Wz/mW79biwz4V9pKhFviB2XFQEU
        cVcwp7MKJbjVATfJ9hCcyK7IJ
X-Received: by 2002:a05:622a:4cb:b0:2e1:ce8c:f097 with SMTP id q11-20020a05622a04cb00b002e1ce8cf097mr16352333qtx.395.1647869976582;
        Mon, 21 Mar 2022 06:39:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwffiZT7sArY+rjQRzyKQCS9OCGHnDeS5R5qqaSRAq/k1AH9vga4g3Q4n0n8Ja7bEYg1j6gaw==
X-Received: by 2002:a05:622a:4cb:b0:2e1:ce8c:f097 with SMTP id q11-20020a05622a04cb00b002e1ce8cf097mr16352307qtx.395.1647869976251;
        Mon, 21 Mar 2022 06:39:36 -0700 (PDT)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id e7-20020a37ac07000000b0067d7cd47af4sm7714115qkm.31.2022.03.21.06.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 06:39:35 -0700 (PDT)
To:     trix@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        mbenes@suse.cz, pmladek@suse.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220320015143.2208591-1-trix@redhat.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2] livepatch: Reorder to use before freeing a pointer
Message-ID: <3ee9826e-b770-d015-0251-e9770172d973@redhat.com>
Date:   Mon, 21 Mar 2022 09:39:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220320015143.2208591-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/22 9:51 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issue
> livepatch-shadow-fix1.c:113:2: warning: Use of
>   memory after it is freed
>   pr_info("%s: dummy @ %p, prevented leak @ %p\n",
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The pointer is freed in the previous statement.
> Reorder the pr_info to report before the free.
> 
> Similar issue in livepatch-shadow-fix2.c
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v2: Fix similar issue in livepatch-shadow-fix2.c
> 
>  samples/livepatch/livepatch-shadow-fix1.c | 2 +-
>  samples/livepatch/livepatch-shadow-fix2.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
> index 918ce17b43fda..6701641bf12d4 100644
> --- a/samples/livepatch/livepatch-shadow-fix1.c
> +++ b/samples/livepatch/livepatch-shadow-fix1.c
> @@ -109,9 +109,9 @@ static void livepatch_fix1_dummy_leak_dtor(void *obj, void *shadow_data)
>  	void *d = obj;
>  	int **shadow_leak = shadow_data;
>  
> -	kfree(*shadow_leak);
>  	pr_info("%s: dummy @ %p, prevented leak @ %p\n",
>  			 __func__, d, *shadow_leak);
> +	kfree(*shadow_leak);
>  }
>  
>  static void livepatch_fix1_dummy_free(struct dummy *d)
> diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
> index 29fe5cd420472..361046a4f10cf 100644
> --- a/samples/livepatch/livepatch-shadow-fix2.c
> +++ b/samples/livepatch/livepatch-shadow-fix2.c
> @@ -61,9 +61,9 @@ static void livepatch_fix2_dummy_leak_dtor(void *obj, void *shadow_data)
>  	void *d = obj;
>  	int **shadow_leak = shadow_data;
>  
> -	kfree(*shadow_leak);
>  	pr_info("%s: dummy @ %p, prevented leak @ %p\n",
>  			 __func__, d, *shadow_leak);
> +	kfree(*shadow_leak);
>  }
>  
>  static void livepatch_fix2_dummy_free(struct dummy *d)
> 

Hi Tom,

Ordering doesn't matter for the example, so let's clean up the static
analysis.

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

But for my sanity, isn't this a false positive?  There shouldn't be harm
in printing the pointer itself, even after what it points to has been
freed, i.e.

	int *i = malloc(sizeof(*i));
	free(i);
	printf("%p\n", i);      << ok
	printf("%d\n", *i);     << NOT ok

But I suppose clang doesn't know that the passed pointer isn't getting
dereferenced by the function, so it throws up a warning?  Just curious
what your experience has been with respect to these reports.

Thanks,
-- 
Joe

