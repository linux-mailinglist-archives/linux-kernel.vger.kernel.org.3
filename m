Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2D513115
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiD1KQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiD1KQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EBBFB18B2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651140442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ao0Bz8xyz5j/xrhsX58NYx9f81qbkBvupY+H6E6SS5g=;
        b=MytENZxE98nXUrGcEggW1/xV8c+nTc/saEkmRQ6obOeYEq8uWyg71l5Au7L11NnrSGWEXr
        AExBkz1RprWhWedWHOw/1zs1gUZWYI+cfEnuC3ikBv8e4lOJD4ea3fNMzxae67M5mvczSg
        +EgKzSt28IRXJ48KcM5hlmB7ymLGMc0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-lwnCipJvNXivnV76LP4-VQ-1; Thu, 28 Apr 2022 06:07:14 -0400
X-MC-Unique: lwnCipJvNXivnV76LP4-VQ-1
Received: by mail-ej1-f70.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so2694565ejw.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Ao0Bz8xyz5j/xrhsX58NYx9f81qbkBvupY+H6E6SS5g=;
        b=c2sdC+IqwRXCoPQaETPOV4Fh7SAOr6/z8WJZTwL6LmHormiMs0sDoMZKyvRoHtjhuM
         7SYKH4H6fBU8fpB4haWDDiyKs2VyLKSwqecQk7kdxbi33/3fJNB2vC6jcTxyVUNRl0/Y
         ae13eilMcZ4a0ObifIIr02Z7AVAs22rM0DUdQE8MBvOkLGogCqZaE3m9sewMoAOmxtF2
         jUueeK3+lM9P+O4eRAizVTcmCpB9Ht2EY2oHPUqxmF2hAP8/Bhm2eBj7XiGkxx8pIQZE
         oSlWMSUvNIT30vQoj0GfuMX0okJH8TmpTYYpkb4Kc+suz786Y+P2szeqWIpkx2Fh4lHZ
         M5dw==
X-Gm-Message-State: AOAM531jusQEh+e6wJVSUu8eDsqMwbf7F/JR+BbUlYbCAoTG9Q6u2q6e
        80R+eXtXwWZcYZQ6Q/RMc2Yn04+67NuG8wCoSvfGsS4bjYt913k1px5bmnUHvvDRHbIbBpT7XaH
        f6yAQuFNpD9uanoIejrj66Uq7
X-Received: by 2002:a17:906:6144:b0:6cf:bb2e:a2e1 with SMTP id p4-20020a170906614400b006cfbb2ea2e1mr31136392ejl.299.1651140432952;
        Thu, 28 Apr 2022 03:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywqv6biAMo0wtUvC8JVZeUiaXehKVhIyifRpO229YR0IF7PsJl/wJWYDkew029kmRoHokXIg==
X-Received: by 2002:a17:906:6144:b0:6cf:bb2e:a2e1 with SMTP id p4-20020a170906614400b006cfbb2ea2e1mr31136378ejl.299.1651140432762;
        Thu, 28 Apr 2022 03:07:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090626d200b006efdd9b95c8sm8217917ejc.47.2022.04.28.03.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:07:12 -0700 (PDT)
Message-ID: <0c716a6b-c09c-f02c-a42a-9c8dc13518aa@redhat.com>
Date:   Thu, 28 Apr 2022 12:07:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge
 page
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Bibo Mao <maobibo@loongson.cn>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>
References: <20220317065024.2635069-1-maobibo@loongson.cn>
 <20220427134843.576f0a18bea28de9e798004a@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220427134843.576f0a18bea28de9e798004a@linux-foundation.org>
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

On 27.04.22 22:48, Andrew Morton wrote:
> On Thu, 17 Mar 2022 02:50:24 -0400 Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> collapse huge page will copy huge page from general small pages,
>> dest node is calculated from most one of source pages, however
>> THP daemon is not scheduled on dest node. The performance may be
>> poor since huge page copying across nodes, also cache is not used
>> for target node. With this patch, khugepaged daemon switches to
>> the same numa node with huge page. It saves copying time and makes
>> use of local cache better.
>>
>> With this patch, specint 2006 base performance is improved with 6%
>> on Loongson 3C5000L platform with 32 cores and 8 numa nodes.
>>
> 
> Are there any acks for this one please?

I'll have a look!


-- 
Thanks,

David / dhildenb

