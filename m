Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21814E9936
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbiC1OUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiC1OUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 871185DA67
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648477142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdCC2vq9cPXJuSNaiMrLPgmXV59Q9f2WNHJtMSehXOA=;
        b=jE8Ab9w/nr0M+wzoBLuSpdsEP4i0h1UeLrWOPfHR0HMdYzavHhEsCdciVbGPx5GN9gUNeT
        ZwqkYBbTsycIgSFe6I0IoghkwltwgI/4vK/eRkl7NxTyTPQSi+mLCjr8iEyXjJ2CVeIqUz
        Tnp4g7NI/kZ/sz/dt3Hm3OFESfPPL6g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-STCIvrdoOxW5eo8Q9DZp2Q-1; Mon, 28 Mar 2022 10:19:01 -0400
X-MC-Unique: STCIvrdoOxW5eo8Q9DZp2Q-1
Received: by mail-wr1-f70.google.com with SMTP id h33-20020adf9024000000b00203fcba8aadso4338852wrh.15
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=MdCC2vq9cPXJuSNaiMrLPgmXV59Q9f2WNHJtMSehXOA=;
        b=7kINMV0pcAoVTDqHArCz1XN5oCc4Li7hmA0PSV43OtfW7SN4NrrGqb1BpgeBoak0SU
         ZlW2tocYfXOxciOJ5VGl1i+sQ2pWLjdHT54hFqnla+DCoEDoUePudED5Yn8M/909SP9Q
         JgvBV7ZozcqJPhcU4vIUsHW+El6B3YLOVZKciWIEuo++KstpAkBd/OTZCOcgxU+HBGE4
         sHNL/rAaVe0TC9S88b5f2KviA0ZyywRasdrg1rNiQg44U8zpXNI0SvYvNXIEeqnxrvSS
         Wbzt4WuHrMSv2FsIa8QKxTLXLb/CvLCo9KqOpX0LwI6wZIob/BaBXc6oZWDo7O0IflHM
         7muA==
X-Gm-Message-State: AOAM5333CKZDjTilMskYy4HaqJvxQsufbOIsevoM5JVqnWEt8UgSRycg
        +cQwwQk7/mGzyDzPQmHQrhEfo2n86mWV0jyNl7zxvnVX/JsiHNscXrTitfdSkG5wEGoUJb1e+zg
        bwkp/ajpqWVhUympWSfdTDArk
X-Received: by 2002:a05:6000:15c7:b0:205:87a2:87bc with SMTP id y7-20020a05600015c700b0020587a287bcmr23267027wry.260.1648477139905;
        Mon, 28 Mar 2022 07:18:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8w6depzhTIUSmpGGv6Ed4U55mm4nqtTubVGFzw0jHjIXP1/XJspcPZTrwm3K2T94Ka0w6kQ==
X-Received: by 2002:a05:6000:15c7:b0:205:87a2:87bc with SMTP id y7-20020a05600015c700b0020587a287bcmr23267009wry.260.1648477139677;
        Mon, 28 Mar 2022 07:18:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:2200:50d1:ff5c:5927:203a? (p200300cbc704220050d1ff5c5927203a.dip0.t-ipconnect.de. [2003:cb:c704:2200:50d1:ff5c:5927:203a])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b00203e5c9aa09sm18374118wrf.27.2022.03.28.07.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 07:18:58 -0700 (PDT)
Message-ID: <02f50037-46ce-ec08-63cb-e855694e69a5@redhat.com>
Date:   Mon, 28 Mar 2022 16:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC] locking/rwsem: dont wake up wwaiter in case of lock holder
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>, Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220326134059.4082-1-hdanton@sina.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220326134059.4082-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.22 14:40, Hillf Danton wrote:
> In the slowpath of down for write, we bail out in case of signal received and
> try to wake up any pending waiter but it makes no sense to wake up a write
> waiter given any lock holder, either write or read.

But is handling this better really worth additional code and runtime
checks? IOW, does this happen often enough that we actually care about
optimizing this? I have no idea :)

> 
> The RFC is do nothing for wwaiter if any lock holder present - they will fill
> their duty at lock release time.
> 
> Only for thoughts now.
> 
> Hillf
> 
> --- x/kernel/locking/rwsem.c
> +++ y/kernel/locking/rwsem.c
> @@ -418,6 +418,8 @@ static void rwsem_mark_wake(struct rw_se
>  	waiter = rwsem_first_waiter(sem);
>  
>  	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
> +		if (RWSEM_LOCK_MASK & atomic_long_read(&sem->count))
> +			return;
>  		if (wake_type == RWSEM_WAKE_ANY) {
>  			/*
>  			 * Mark writer at the front of the queue for wakeup.
> --
> 


-- 
Thanks,

David / dhildenb

