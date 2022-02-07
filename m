Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BD74AC1B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383009AbiBGOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382648AbiBGOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6B88C0401C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644244528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZZgqYvSXYR+oleAuOjKwJYuJo6PBzXou2noV4Zc2s8=;
        b=eWBJiyqB/SgLJHyutFZRcPSDAligUF4ZfFc8pBaP7MZfe/ZPT8vLfHGTYtDwc1xAb+hpkB
        YTuW+8tPylGErpY1TEy69zI2uHWRuvjSgRVv/rdr5Jk9yCk/tbQHxzB5nEN1gkvMxyndqf
        J7+Fj42UuYJfwgBqE8nCSWy9HZOor28=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-CkW6mvAuMk-ywnLja8UeNw-1; Mon, 07 Feb 2022 09:35:26 -0500
X-MC-Unique: CkW6mvAuMk-ywnLja8UeNw-1
Received: by mail-ej1-f72.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so4348870ejw.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=xZZgqYvSXYR+oleAuOjKwJYuJo6PBzXou2noV4Zc2s8=;
        b=f+zzRp4rDDtsjZ39lK1IJQ0+u468iufM/GAewkHXQWDX5KGkgznBIXPVfS1ylXiaCi
         eEWvfaGtjPmVq6848TCenS6nJXu9/qOdnNvMJVWwTwoKk+EbRAPuKjxfCth6w06lGfUn
         ZJtLjClRKhOUUUbDk64P+T8rmjNosX5QyBQ3yioGdzAy6b6v5zw6pcgRXti5Dfs/uOYB
         R/rOL8BuXB0Fi7dNfWpxJUKhs66bdvILQVq8orMRwPyioC7zSVzGVBLN3WDizAQvB7BQ
         8T6wP3u2dszwNIj3tgEyePrQIYHr8KEqMkX+l/4HJxiM9as8LGmaCIjY1WvZJglYJJo3
         UZKA==
X-Gm-Message-State: AOAM533GZ26hf6U8Gu3mQDGHkuK9J5i/GPdVXnah0S8Z6cJq3h8bxCxW
        1X+8u80QSo5zJ7lcBA32hrQLbbS8JlNkWJXNgtVOhoN+f/eUWDjEBVR2GbBrKxTwlCkP4BHCs9V
        1PKlvmKWPQ8EnILLG5LwuSIQ0
X-Received: by 2002:a17:906:2a91:: with SMTP id l17mr14720eje.245.1644244524893;
        Mon, 07 Feb 2022 06:35:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjGBKL0CynVyEL8UISkpQlHq9yINJnfDANYwbL9GyFwYctn0c+PlkmeG7Ac0lR3oo+40ERWQ==
X-Received: by 2002:a17:906:2a91:: with SMTP id l17mr14711eje.245.1644244524735;
        Mon, 07 Feb 2022 06:35:24 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id k24sm3787142ejv.179.2022.02.07.06.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:35:24 -0800 (PST)
Message-ID: <9b9b7f7a-cfc6-1e56-aeb2-d3a7e445fe14@redhat.com>
Date:   Mon, 7 Feb 2022 15:35:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 06/23] KVM: MMU: load new PGD once nested two-dimensional
 paging is initialized
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-7-pbonzini@redhat.com> <Yf178LYEY4pFJcLc@google.com>
 <180d7f0f-8c58-2a52-02a7-bd014d81d7a3@redhat.com>
In-Reply-To: <180d7f0f-8c58-2a52-02a7-bd014d81d7a3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 14:50, Paolo Bonzini wrote:
>>>
>> Those checks are just for performance correct (to skip iterating through
>> the list of roots)?
>>
>> Either way, it's probably worth including a Fixes tag below.
> 
> There's no bug because __kvm_mmu_new_pgd is passed a correct new_role. 
> But it's unnecessarily complex as shown by patches 7 and 9.

root_level is not part of the role, but we're still safe because 
changing it requires to flip CR0.PG to 0 and back to 1.  This calls 
kvm_mmu_reset_context and unloads all roots, so it's not possible to 
have a cached PGD with the wrong root level.  On the first call the 
root_level might be incorrect, but then again there's no cached PGD.

(Also, shadow_root_level is either always or never >= PT64_ROOT_4LEVEL, 
so it's okay unless the guest_mmu was never set up and therefore no 
cached PGD exists).

Paolo

