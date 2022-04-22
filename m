Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A707050B1CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444966AbiDVHnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444960AbiDVHmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A19D2517CD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650613181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTSUiueHwVf/dbd1QJxPKAiv9Tb89ujDYdY/eBNq3Fo=;
        b=jIe9EPEPC6WZ5+Q7sIfraeaaaHxR3AOw6iv3jkMeZEBgsbw0lCjZiFQTLVDZJeVLnqjFJe
        ity3e7gclepPU0r/2epl4ISSLaFQM5YjChjodpwWOpfQ88LSyWdY3yVzRIV/YzxaPQFYBV
        Z19nN8rgTPoIfjfuuh7fsKKJl1f1ZGc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-8uu1ty6IPLSBeB9F24UHJg-1; Fri, 22 Apr 2022 03:39:40 -0400
X-MC-Unique: 8uu1ty6IPLSBeB9F24UHJg-1
Received: by mail-wm1-f70.google.com with SMTP id h127-20020a1c2185000000b0038ff033b654so867173wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=OTSUiueHwVf/dbd1QJxPKAiv9Tb89ujDYdY/eBNq3Fo=;
        b=cbg7vKzp3P8JcmdPXJR3h/sVprGKWD0gXqnvHuk8UyMutsoDLIuA9ks+KdMQalk86+
         NZlY9UUTi9x1bb6cX+E/gYpNeC6Av0EdH2cCazo4gmwzV9LchCWwpi6WU/32o1TakBSw
         ks47gOgJ0tXhoSMvrqiN6k+JVlTNcwWP8NGBQMvCgf3xUMfkvHJeZA31ZfGNaZHVpxfe
         RAHQhjqmuue9RdWtBySecI5sU5puUjNDhh3hkok9FKLGQipSt/AXCbdSyMpLClGA7AgS
         PRjEHNbBIU/DPu313bcUAbLqc28FA1RLQ9IAZWOo1wvJ0tPrHJ4cskG2xUjpho5QMWHg
         OPmQ==
X-Gm-Message-State: AOAM532FNkA07XTJewGyjX0YIMKIw/2h0d08UmOxf+pEz2UYTvkF2Heu
        UmJV/Ge3J/8xoMwbjzE2xSTLlBNdimE3KSi7APuhPPM7pC6dRmZ2uDtIzOREUu1nXVCohRL+/kV
        7XejCD50Nun+HQMJh9gt3TDE/
X-Received: by 2002:adf:ed4e:0:b0:20a:c805:1d62 with SMTP id u14-20020adfed4e000000b0020ac8051d62mr1787585wro.134.1650613179580;
        Fri, 22 Apr 2022 00:39:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEj/kZHw3Xd6aev6oueKi84P2Bo2sdX2NK9wAJbmPEGb3bCNVMi6gs3/pbgL2tcEKTtTxN8Q==
X-Received: by 2002:adf:ed4e:0:b0:20a:c805:1d62 with SMTP id u14-20020adfed4e000000b0020ac8051d62mr1787567wro.134.1650613179292;
        Fri, 22 Apr 2022 00:39:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:dd00:745e:20b7:bfa4:2e5f? (p200300cbc702dd00745e20b7bfa42e5f.dip0.t-ipconnect.de. [2003:cb:c702:dd00:745e:20b7:bfa4:2e5f])
        by smtp.gmail.com with ESMTPSA id v11-20020a056000144b00b0020a9c02f60dsm1052532wrx.50.2022.04.22.00.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 00:39:38 -0700 (PDT)
Message-ID: <3c218202-c4de-958c-8cf2-b0f24550d0d1@redhat.com>
Date:   Fri, 22 Apr 2022 09:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drivers/base/memory: Fix a reference counting issue in
 __add_memory_block()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <d44c63d78aafe844f920dc02ad6af25acc448fcf.1650611702.git.christophe.jaillet@wanadoo.fr>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <d44c63d78aafe844f920dc02ad6af25acc448fcf.1650611702.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.22 09:15, Christophe JAILLET wrote:
> There is no point in doing put_device()/device_unregister() on a
> device that has just been registered a few lines above. This will lead to
> a double reference decrement.
> 
> I guess that this put_device()/device_unregister() is a cut'n'paste from
> remove_memory_block() (i.e. unregister_memory() at the time being) which
> does need it.
> 
> Fixes: 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in xarray to accelerate lookup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/base/memory.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 7222ff9b5e05..084d67fd55cc 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -636,10 +636,9 @@ static int __add_memory_block(struct memory_block *memory)
>  	}
>  	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
>  			      GFP_KERNEL));
> -	if (ret) {
> -		put_device(&memory->dev);
> +	if (ret)
>  		device_unregister(&memory->dev);
> -	}
> +
>  	return ret;
>  }
>  

Looks correct to me. I assume this will only happen once the stars
align, but it's most certainly wrong I think.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

