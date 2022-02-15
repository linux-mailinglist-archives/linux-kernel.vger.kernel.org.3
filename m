Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6DE4B729A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbiBOPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:06:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbiBOPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F14D2108761
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644937572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfA3vO8+6n1DQao6u/Mr2EuXbzpIlm1ffHmAiLuPWK8=;
        b=V3rutEc9rAyx9HEFdcjMjXbwbApXmHO86VKm1MJPfmFFYrkELg9Edl9aInryX4fwwTfEzv
        /+cQThj8PTBTuwVcG1/MF077iRyq14jGLVkfqrJRzsahxZZ8nTTKz7pSkSqOdXyNXnYwa+
        +mP0g6kx1LWp6jMRSd1pmgC2azWbkjk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-CTT9jKNPPTegL3fqOe2nDg-1; Tue, 15 Feb 2022 10:06:11 -0500
X-MC-Unique: CTT9jKNPPTegL3fqOe2nDg-1
Received: by mail-wr1-f71.google.com with SMTP id v17-20020adfc5d1000000b001e6405c2b56so3471894wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HfA3vO8+6n1DQao6u/Mr2EuXbzpIlm1ffHmAiLuPWK8=;
        b=wz1yzDu617RmInuE8nv0GfLUfDyXq4at3uuHNJyA8mubqX61/FdDd4hhGhhsaQm/ez
         GerF5ckViXvSGjDPG9OQ0+DnOIC3PlZKP+mXPz3voAsXTc8Lg9IiOWi8/oZGNzPEI7eL
         MdEGuOUIPZGiho0a5JW8jidW1kyE21Fj5owXxNTC/sCLQ8MDNt5q8wJopUPaB23awLvj
         8Imo//NQJLhGgfNa4SmtNlsGV9tpq1hnbOa/7mg1ehSaCt2pdj/ZiB4ejBXN2FT2Boj1
         nrxJrqUbdfwWhTZSD35tPTdBvNyy1qTqmVlFoMXyiO8F9Aqo2ba+WT4w6+pPP8gj6AX3
         WLPw==
X-Gm-Message-State: AOAM5313FjF98VDxaQiGnWjeeI/HoPnr2Wb+osTwldPT8ImefkxZuA02
        1Q9LKCIanyOebVEOvBBE5ZeGJCb4FoloQ7AGXZOxIe12EeM3MY37fwOTQz3Y+jv+LPUMyzFbEcy
        Mhix4BU6MzVzUuiqw9/YEDpXP
X-Received: by 2002:a05:6000:2c5:: with SMTP id o5mr3572612wry.130.1644937569076;
        Tue, 15 Feb 2022 07:06:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGuhi4OibgJoa3W0FK7ohMmfc7Hmn4KSzRw7AVu1OMbfqzr7TxKkeEcpypUNuJd+1KYhk38Q==
X-Received: by 2002:a05:6000:2c5:: with SMTP id o5mr3572592wry.130.1644937568834;
        Tue, 15 Feb 2022 07:06:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:3700:9260:2fb2:742d:da3e? (p200300cbc70e370092602fb2742dda3e.dip0.t-ipconnect.de. [2003:cb:c70e:3700:9260:2fb2:742d:da3e])
        by smtp.gmail.com with ESMTPSA id s7sm3872048wro.104.2022.02.15.07.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:06:08 -0800 (PST)
Message-ID: <2cc44d0d-1ede-daca-30fd-d302f1537dfe@redhat.com>
Date:   Tue, 15 Feb 2022 16:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
Content-Language: en-US
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220212213740.423efcea@imladris.surriel.com>
 <2a881586-3f5e-c277-f373-a9014d631700@redhat.com>
 <63f930e411655a6ad37d4818d0ae19784c82f076.camel@surriel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <63f930e411655a6ad37d4818d0ae19784c82f076.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.22 16:01, Rik van Riel wrote:
> On Tue, 2022-02-15 at 12:22 +0100, David Hildenbrand wrote:
>> On 13.02.22 03:37, Rik van Riel wrote:
>>> Sometimes the page offlining code can leave behind a hwpoisoned
>>> clean
>>> page cache page. This can lead to programs being killed over and
>>> over
>>> and over again as they fault in the hwpoisoned page, get killed,
>>> and
>>> then get re-spawned by whatever wanted to run them.
>>
>> Hi Rik,
>>
>> am I correct that you are only talking about soft offlining as
>> triggered
>> from mm/memory-failure.c, not page offlining as in memory offlining
>> mm/memory_hotunplug.c ?
> 
> That is correct in that I am talking only about memory-failure.c,
> however the code in memory-failure.c has both hard and soft
> offlining modes, and I suppose this patch covers both?
> 

Right, for hwpoison handling there is hard and soft offlining of pages
... maybe "hwpoison page offlining" would be clearer, not sure.

Thanks for clarifying!

-- 
Thanks,

David / dhildenb

