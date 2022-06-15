Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5AA54C52F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347194AbiFOJxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245608AbiFOJxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F17D245067
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655286819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sw6uD4GNioRfBtX3jEJXdTt3T/W8UHiD+VjqDyMbLsw=;
        b=cY7cjXYPO5ftx2yZdZCdgeesn6DPJS+2rI3uccKMCWDrgkyQdKC2edAk8N9v2LGhI8Fchp
        6zgzm1rxc28zmxktn8VEfu5SSfSYbsAwB0szbcXfDkXPTF9imwcVv95ARc6LW0bwT6HyLM
        b8Th59nIpD8etkof8O7Fdfjv8mDD0Pc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-4P6tSLPSNX2K3kr7z6JVeg-1; Wed, 15 Jun 2022 05:53:35 -0400
X-MC-Unique: 4P6tSLPSNX2K3kr7z6JVeg-1
Received: by mail-wr1-f71.google.com with SMTP id i10-20020a5d55ca000000b002103d76ffcaso1711264wrw.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Sw6uD4GNioRfBtX3jEJXdTt3T/W8UHiD+VjqDyMbLsw=;
        b=ZG98uS795gphcxeaZhLtJwL6r0cuzlZ5sa4nSmo9hNFySWWBEUM5kJeGLoVizpRktb
         /qiMeygv+opXAE1lzGLvCa2Sx5q1MpCm+RP0FnRokRu92OxlRQ+ia1vn6sOeQPDrC8PH
         aU2vN0pKe+eZSTgAitFh+lWqG94+pRnQ29AD+tBv75euEuCgs9p4Rwvgo1uGO2TZUcPS
         5tO94YwZ+68Yxf4foO1IBCd1nvB9jV93ZMbKseqADc6sFc7nXr4H1NvGESrHn9mjcmlg
         AWRqD5BujA2S9nsLD58z1S97vhaE3cp5WkzDky17nssapbw/9kX0J787u2y1rXAIXflj
         iD1Q==
X-Gm-Message-State: AJIora+9IDd3h+BfRyPpJovsDTAophOU05aVmwAqkhebXy1UpaJ+GI/J
        r2VUTwcAdJoXgBlfhiROkeoW6pYszMETk5jUAS0DLf1q7g63KwDepsHRTkoihRc+2ZWsQa8v2m1
        EnOMzmjgszH0D3fIy1MgfrXTS
X-Received: by 2002:a5d:54c3:0:b0:210:2a28:5666 with SMTP id x3-20020a5d54c3000000b002102a285666mr9020421wrv.345.1655286814572;
        Wed, 15 Jun 2022 02:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vWQshi2ag3X1ZGvSLVqvcGr6liU6e5hkf80ENh4j2nNiQ3afv4GT3be4CkAz8Cckl+MchtEw==
X-Received: by 2002:a5d:54c3:0:b0:210:2a28:5666 with SMTP id x3-20020a5d54c3000000b002102a285666mr9020398wrv.345.1655286814297;
        Wed, 15 Jun 2022 02:53:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:2700:1d28:26c3:b272:fcc6? (p200300cbc70a27001d2826c3b272fcc6.dip0.t-ipconnect.de. [2003:cb:c70a:2700:1d28:26c3:b272:fcc6])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b0039c95b31e66sm2130939wms.31.2022.06.15.02.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:53:33 -0700 (PDT)
Message-ID: <1ef10873-c20f-afd8-e560-3b7fb5516f2b@redhat.com>
Date:   Wed, 15 Jun 2022 11:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
 <e4120abd-c3ac-ee4d-1a0d-260126914b09@oracle.com>
 <b38f4597-0d9b-5b17-0b24-13d99605fb69@redhat.com>
 <24513679-d92d-ead1-2c1d-98db6a9bbdac@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <24513679-d92d-ead1-2c1d-98db6a9bbdac@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.22 00:25, Eric DeVolder wrote:
> 
> 
> On 5/31/22 08:15, David Hildenbrand wrote:
>> On 12.05.22 18:10, Eric DeVolder wrote:
>>> David,
>>> Great questions! See inline responses below.
>>> eric
>>
>> Sorry for the late reply, travel and vacation ...
> No problem, greatly appreciate the feedback!
> eric
> 
>>
>>>>
>>>>> +
>>>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>>>> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
>>>>> +							unsigned int hp_action, unsigned int cpu)
>>>>> +{
>>>>> +	WARN(1, "crash hotplug handler not implemented");
>>>>
>>>>
>>>> Won't that trigger on any arch that has CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG?
>>>> I mean, you only implement it for x86 later in this series. Or what else stops this WARN from
>>>> triggering?
>>>>
>>> You're correct. What about: printk_once(KERN_DEBUG "...") ?
>>
>> Why even bother about printing anything? If the feature is not
>> supported, there should be some way for user space to figure out that it
>> sill has to reload on hot(un)plug manually, no?
> 
> I've changed this to WARN_ONCE(). If that isn't agreeable, I'll remove it.

Please don't use WARN* on expected error paths.

-- 
Thanks,

David / dhildenb

