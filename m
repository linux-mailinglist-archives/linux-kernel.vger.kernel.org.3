Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7FF5650FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiGDJfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiGDJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7268313B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656927340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WWiJ66vmyv6AuRzY8eurkcg8dPpumGhr2N20qzH6fo=;
        b=J4WKR9plqustxOj4RqsjLSJ4zJ8CEXXKkyGWBNQCVw2eU+8qrSuHgE1UiNu0Ftaz+LgzkA
        TsrPIHV2AEJV6YGOF4BJOvBisUdM2chjBL9zH21couemGUrC/0dpmulfAhtrnGWoX8wtXA
        v7F4bdO3CtZOiROO9xYoOxdKcLVmvaY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-IclPsw1-NWaGNJzrIhb-zA-1; Mon, 04 Jul 2022 05:35:36 -0400
X-MC-Unique: IclPsw1-NWaGNJzrIhb-zA-1
Received: by mail-wm1-f70.google.com with SMTP id 18-20020a05600c021200b003a19b2beb0aso1529124wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=3WWiJ66vmyv6AuRzY8eurkcg8dPpumGhr2N20qzH6fo=;
        b=6hmZD7RqHIY0VEgHSgqn0sHzQOrclq3qUTPISinF4+q7aFYcCARJTpUtqYPdQS2VsM
         iAdpfZhDUSk4rnRcM5fpwr/GxdzQOcqqvSQBTxOxIMLd2utNMyb9GT9BskSnIC642hbY
         Fi+pEMQJwumeqFNerQuL1EzLGi0BQZWGo2zBj/L9hq8uvKRWynh/QdtvTFP2OBciT7lV
         aLBd/VLVKprBWn0OAgvHLsd7yqGaDe9FlTWA+XzLpg1xESrWL00t5oXg9oneDtQnaYva
         oTI97wjqPxh/kL6pdpBGDmMQse8NUJEa9zrPcaeOggAQDNVjUBXKAB+G0UqubHujYt84
         lUbw==
X-Gm-Message-State: AJIora+T+7JTn86WsdgofvZT3RiUbgsPEWeLFhpMVtj2MGgIJFtLREaW
        yFiaGXamwLREytSR7DuMp09A4UG9M2zUYrjfn4sEnTZiiSaMoUWeEBZw12QOVGniyLkfRw9L0mg
        20DTZ+Q022HCUQC5YpcR4qifB
X-Received: by 2002:a05:600c:214c:b0:3a0:401a:6f4b with SMTP id v12-20020a05600c214c00b003a0401a6f4bmr28285410wml.15.1656927335277;
        Mon, 04 Jul 2022 02:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOoGkRwsVrhieUeF7OSWKXjC9T6azUqXh3cTeIyaZvuBChf4RCiWX9inQwizMMvzbe63BN3w==
X-Received: by 2002:a05:600c:214c:b0:3a0:401a:6f4b with SMTP id v12-20020a05600c214c00b003a0401a6f4bmr28285394wml.15.1656927335042;
        Mon, 04 Jul 2022 02:35:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f16:2a00:198:c1f8:a413:2600? (p200300d82f162a000198c1f8a4132600.dip0.t-ipconnect.de. [2003:d8:2f16:2a00:198:c1f8:a413:2600])
        by smtp.gmail.com with ESMTPSA id t5-20020a1c4605000000b0039db31f6372sm15310021wma.2.2022.07.04.02.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 02:35:34 -0700 (PDT)
Message-ID: <777bf32f-4657-d590-ce1d-55b65980f0e4@redhat.com>
Date:   Mon, 4 Jul 2022 11:35:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, CGEL <cgel.zte@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
        minchan@kernel.org, oleksandr@redhat.com,
        xu xin <xu.xin16@zte.com.cn>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
 <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
 <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
 <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
 <Yr7qQsWQGb0dhkxr@dhcp22.suse.cz>
 <54b67d6b-f600-1b9b-3d3f-e91b13d04c91@redhat.com>
 <Yr70ZwUAIHNz5VNy@dhcp22.suse.cz>
 <11d28e6d-edb0-7d11-b476-c5808f3b7c5d@redhat.com>
 <YsKNJiGA/ruLRS27@dhcp22.suse.cz>
 <62c296e6.1c69fb81.41c44.1cca@mx.google.com>
 <YsKnZ++HZcOPOhCS@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
In-Reply-To: <YsKnZ++HZcOPOhCS@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.22 10:40, Michal Hocko wrote:
> On Mon 04-07-22 07:29:41, CGEL wrote:
> [...]
>> Maybe new semantics is needed similarly to MADV_NOHUGEPAGE that ensures that
>> there will *not* be huge pages.
> 
> How do you achieve that with a backward compatibility?

Some apps mark secrets via mlock(). I did not check, but I assume
mlock()'ed pages (in VMAs) would not be applicable to KSM. If they would
be, one option would be to not deduplicate them.

But then, I have no clue what's exploitable via a side channel and
what's not. Eventually, having a proper fix for most side channels would
make KSM safer to use in the the general case. But then, who knows what
security researchers will be able to come up with ...

As a very minimum, there would have to be some kind of toggle to allow
forcing KSM on other applications at all. Either/o a compile-time and a
run-time option. Once most of the known side channels are fixed we could
adjust the default of the run-time option.

(I think to this day, Windows still disables system-wide deduplication
as a default and requires an admin to explicitly enable it)

-- 
Thanks,

David / dhildenb

